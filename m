Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B122ED116F3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxoE-0002CI-LK; Fri, 28 Nov 2025 07:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxo1-0001xi-DL
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:35 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxny-00037T-UH
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:32 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-55b6a642a4cso1213403e0c.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764333749; x=1764938549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2+w7aKeM4mn6IUIq7PiZicrN3KwLnQcc+QlfR75hvY=;
 b=FAahTJDvZDOJi8pH598gbhliuHmCsPbZUbxc4bebao+wZQU7tNLUED9NPTW/drHcDb
 plOM/B6dwwEZQNE42F4w7H1ZdbrzDea7iDSjFDiS/lTjokwdxKuzoBUguUy8as/Krz11
 gS4M9RydQdzpQ+1XO4F4fF7JjUNLlV+K3yw50nBOBUvMGre43J1c98AS7Kgy7GSDWnwl
 pd0f82k1j1jM6D8k/eGoU8wEobMhFQJxrJ3cnN1d4HSKRTbBr1eiugS11PNIesFDKm7Z
 RBFZarQ1+FCpjOQhCrFOjzBdgBCpc+NiXzOjIvxOX3+fvibgcBbvc3h60Jhwvy1pg6S5
 8v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764333749; x=1764938549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u2+w7aKeM4mn6IUIq7PiZicrN3KwLnQcc+QlfR75hvY=;
 b=qjWReRKao/maTtkRdF3TtK7I5vLw20p4sk5NJ9g5RIHGuUq4GYs4lwdVhRHu1U0qiS
 msN0j+UXfrXzP02gWuFY3e0rh7ANBkNY7+GG6wR1wNoYKFd5Apyd1xL9HOdpD4fS1U9A
 0K1sGUhvXR5FSBaklTp0hOIG+Njt4iWTrcXMARb1iIODFxocq3bCfOLCiSsePXzKyUxp
 h/dvIjAr9ATdRlRbR8LgrKm0J9sBSJBNiinzl3KP4T03eTjG3Z85VyskRqMSjBfveIuB
 PEJ24/SLhjbR4Fe7Gzpok9F0o9PLYw6BA3k8uZyfj1TnlC3jr/e7ZrX7ztajQMfMQN6/
 w9Ng==
X-Gm-Message-State: AOJu0YxGOyj4SnIWZwcqC9eLy86iS5h+eaGDKL5sXyKM3eBn/8NMXflK
 ayUXO+TaDCntni3rfyyVaDdZHlniCbXWOpzW+YzF553C6UxI3NzeHqlP8/syL4GPyUV4i00pc/u
 vWEW4
X-Gm-Gg: ASbGncuuiXvpEP3puUFhEQ1UI+2d496GrrgJpCLTCTxqrkPRuSC8jngeudul+25ZXS+
 ddyGknqeugtFJ+eHFCfOUTNPXbyAIfmsgkL9VlyIakRFPoZ+AoWIza8F7aJALXGTUGYvCwgJjEF
 Q842dGzCQVHTgQJY9Rju4hKzDbUHHIHYd5vvTfkkkRrBabO9dxjHW4NZsojmo3aSaN7hWmBurNn
 /9LyYGwsEtgyD0/PxlBlUP+1Wm2Ge7CjIrYP1wnN2ZBZWEkKZ+FYVPPSNyQaB6qkxGiajah+7mP
 dOmLlhYLaecvskxGiU2T9sDGtO6WX0kaLhSraGgMRqjluMHJUuIHiaWcEbISkm26yKvHaA+OIu3
 pYGx0qXfuXQ4GrBX8WGXMtyH7Zk74NNxjHNpNj6g1vvJvLSj0d4IBOJsLNJiJcf+u+8J7eXcyqK
 bqHsYcVy/241XTciJZvTTZtfSnFg==
X-Google-Smtp-Source: AGHT+IFkEOO1HxrrFhHSwQQNPPj4Qz3a19ayGVICN9yh2joO63JaDcXWtGBCWeTJTQPUFQsbSXaOHw==
X-Received: by 2002:a05:6122:3d06:b0:55b:9c2d:1147 with SMTP id
 71dfb90a1353d-55cd761e433mr5654983e0c.1.1764333748670; 
 Fri, 28 Nov 2025 04:42:28 -0800 (PST)
Received: from gromero0.. ([177.139.2.175]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-55cf4e1d56asm1776930e0c.4.2025.11.28.04.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 04:42:28 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v1 3/6] target/arm: Add a _MAX sentinel to ARMASIdx enum
Date: Fri, 28 Nov 2025 12:41:07 +0000
Message-Id: <20251128124110.1272336-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128124110.1272336-1-gustavo.romero@linaro.org>
References: <20251128124110.1272336-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a sentinel to the ARMASIdx enum so it can be used when the total
number of address spaces is required.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54d..00f5af0fcd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2336,6 +2336,7 @@ typedef enum ARMASIdx {
     ARMASIdx_S = 1,
     ARMASIdx_TagNS = 2,
     ARMASIdx_TagS = 3,
+    ARMASIdx_MAX
 } ARMASIdx;
 
 static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)
-- 
2.34.1


