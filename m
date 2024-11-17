Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92E2D68BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 00:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCSt2-0008A1-KJ; Sat, 16 Nov 2024 19:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCSt0-00089Z-Hr
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 19:11:30 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCSsy-00047U-U4
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 19:11:30 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso2537856b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 16:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731802286; x=1732407086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+g2eNNwdi+ZRWwt/0k8PCPo7YfvWyjRPCKEEPHDqTo8=;
 b=gD+OgATHD0KINsq/OzrTEKEtssUtgsdmFCuidO0e8bAEJnG4tcJLTXgO8Xn4FUYkTs
 ZkJEpiM8goU+9bx4YGIah8D3+tvC8r5n7pSLUbVKI9BKHK5m4rXAnVDkPosWYKMPQ8Oa
 TbyfWF1r0YsGoXyskfjKvfNKjpyV+/FPa30Xmei0oKJmudVkvPrI/EhnjGCSllP2ltGx
 VSbO/iYkhfR0Ff0R786Z3PVM6xQaZo76dAESboj0TI41j1Y1hnuJ56oJ6GMupGYTau/M
 F/rRJ2IZX3b+QqF9NqJ9mxI4Xc2rna7p7Cyr7ci/TEQVrbN9ZLasll66YxkKOQ0W3/j4
 nP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731802286; x=1732407086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+g2eNNwdi+ZRWwt/0k8PCPo7YfvWyjRPCKEEPHDqTo8=;
 b=bnyL0r2J/Mcyb+2wTYwexLOYZishtGpa4q5fqltHXB/YQKz25G2JJqkp59SLUHo87m
 kmyrs/g456bdg+XSOU3569/9ECsY/TRHIfd7cAf3WP2WlSD6vdg2HRY3iM/8C3+3eeTN
 mpDw/RksojrcWM4HlPcsjVK2CnuDxvgTIRyYaJC0GKB5OTQ54yEoPH1IFWTYln19bfnw
 RTNqkEKBLDvOM9d2QGVlwWUjhBwXFhizEsOvrAdwDschXN5U8/xeVQYcwDHZP+CIRFKi
 QuNfsPMlUyuIRlldCAPIuFvVsw6H8p3JXyiboVO+JqzF0nOUpSFF+d/QVuJGwFbQ4iuy
 mcMA==
X-Gm-Message-State: AOJu0Yyjy0UqrFvBlJQWnQnD1125kgFOySFUyoBJhHQiGLy8xOl1v9rC
 p6VkxUUiU76kElVmrfbT/9orcuTYy/6Vfy2Vys7vD2slZPUc6GsQNkuqDNjJG0ggJv7XH91sfgC
 O
X-Google-Smtp-Source: AGHT+IE/UQ/WKgmE79w2ga8MD4iWg8XmjBRXbeNulcajgeEBRnyQY+1Ylzqy8rIi2dwSouVkw2cOxg==
X-Received: by 2002:a17:902:ce06:b0:20c:9936:f0ab with SMTP id
 d9443c01a7336-211d0ecd04bmr113203465ad.47.1731802286601; 
 Sat, 16 Nov 2024 16:11:26 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f47adbsm32399055ad.223.2024.11.16.16.11.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 16:11:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH RISU] risugen/aarch64: FCMP*Z* require rm == 0
Date: Sat, 16 Nov 2024 16:11:25 -0800
Message-ID: <20241117001125.497129-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Do not generate rm other than 0, as it is UNPREDICTABLE
whether the instruction will trap as invalid.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 aarch64.risu | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index 87d9c72..bfea659 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2632,14 +2632,14 @@ SHA256SU0 A64_V 0101 1110 sz:2 10100 00010 10 rn:5 rd:5
 @DataProcessingScalarFP
 
 FCMPS A64_V 000 11110 00 1 rm:5 00 1000 rn:5 00 000
-FCMPZS A64_V 000 11110 00 1 rm:5 00 1000 rn:5 01 000
+FCMPZS A64_V 000 11110 00 1 00000 00 1000 rn:5 01 000
 FCMPES A64_V 000 11110 00 1 rm:5 00 1000 rn:5 10 000
-FCMPEZS A64_V 000 11110 00 1 rm:5 00 1000 rn:5 11 000
+FCMPEZS A64_V 000 11110 00 1 00000 00 1000 rn:5 11 000
 
 FCMPD A64_V 000 11110 01 1 rm:5 00 1000 rn:5 00 000
-FCMPZD A64_V 000 11110 01 1 rm:5 00 1000 rn:5 01 000
+FCMPZD A64_V 000 11110 01 1 00000 00 1000 rn:5 01 000
 FCMPED A64_V 000 11110 01 1 rm:5 00 1000 rn:5 10 000
-FCMPEZD A64_V 000 11110 01 1 rm:5 00 1000 rn:5 11 000
+FCMPEZD A64_V 000 11110 01 1 00000 00 1000 rn:5 11 000
 
 # Unallocated Encodings and ReservedValues
 FCMP_RES1 A64_V mos:3 11110 0 type:1 1 rm:5 00 1000 rn:5 opc:2 000 \
-- 
2.43.0


