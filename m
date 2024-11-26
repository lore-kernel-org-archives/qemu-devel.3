Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4E2D6552F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxU-0007Wt-5L; Tue, 26 Nov 2024 12:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxQ-0007Ke-8Q
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxO-00020x-5A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so14753855e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640552; x=1733245352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xFzPeRmZcYFg+diNYuLvRmiok0TT9be1yhuo0Ta4GIs=;
 b=AdJZlPn1S2puc9d+A7FFYqwcoLq7FIOv1RYbzxvAansRjYmKBcCMo1l2iBcDmOkgWz
 ZFre778uIrB6a855K1oadAMHnD+3l0Bm71RIybcl96NEndKOR1jkNCs4NtcdUCtegTIZ
 cnFQT58rnLyZZMpofqvVixEUht8oMMP9v0YWIiV1tuR0rXi1msf18oDU26bAvC36yQzN
 U5gyL3Lzziz4IJnLoXfsSHl8VaAO9YgRJcx4+sb2cHIQkoMC4sXzskO80ryZAIzj68tz
 87qDhOLspkzY42jj3wHI40ocJj5h4mXQ8akm1hWI+fThvqnee3Zf8awu5bZPa/Q/RfDb
 mhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640552; x=1733245352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFzPeRmZcYFg+diNYuLvRmiok0TT9be1yhuo0Ta4GIs=;
 b=hv+XkRoEVuf4zKvLNtmmkJFpY6GnhIrNYC4eP4QVXFdQ78gH/tFopiV+kfkLQdVZ8n
 SOfHvHlEsyBYGSYr7w/Lt7RzoSkz8gTZEL2eArRMmU6gqBRINjYq2mawW2j1WR6zgaAU
 6/wgqdZHCdIXUcCunpfegNgVVZoUE8kl8sfUv6bQYtDQ18B1XAGFa/Z4xaOSo/5RFcP5
 0Im5ew3cvTlxS67eizC5f8X2i0ZqZI4wiJyGOxKaJW8TcJRMiPxIfBl4wXtDMCZU1AJ+
 eXNqkX0+zaqIIQa+vFKSexRRHPlN+URC1Mt++2dhCVtQX3hC+ybir/dPRuUUHHrNL2yD
 q3Vg==
X-Gm-Message-State: AOJu0Yxw9g2Qz1xo0okZxYS0xXg13kHnquy221jTyf8Yzu7ZM5EVP5Q2
 LN3zBrOET32R1VOghxb95bDMT9EGLKhR8KWi6LfObQhmgikSnWxa48pSRhPanWtkCNdB6QTiRrY
 O
X-Gm-Gg: ASbGncsoRO2sKTyZXzap+//Pg/ORV0YFc/YwHayUp28nmElqjcHJ4zmI4VNkVe1xz5T
 pHY/4ZOvfSGEGGrX7VbisL702AFj0L/gqZVlnJyWPS/CqxAPyeyLIaP9mBBkPeUEwbq9YO3j07i
 M0WyqCQ22atlSvSbg4L1K6w63w2T1ku2j3/IhUCciGBelzv80ImRYzS9M1GrB3gDCK0Q2JDBu5X
 TtvyxLkYeQc8e+uz48cfjUcpCYXWnmgh+Kg+gXsiHyBoByuZIEBQ7Cl
X-Google-Smtp-Source: AGHT+IGpXcPkfZEjd2lJKlIMrYKVkxQ8wKf9jZNn+iHoh/1yvZ/kEymA5zjWYgouh2yDcqJYBKkJYw==
X-Received: by 2002:a05:600c:154f:b0:434:a706:c0fd with SMTP id
 5b1f17b1804b1-434a9db8386mr319075e9.2.1732640550637; 
 Tue, 26 Nov 2024 09:02:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] docs/system/arm/emulation: fix typo in feature name
Date: Tue, 26 Nov 2024 17:02:18 +0000
Message-Id: <20241126170224.2926917-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241122225049.1617774-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2956c22a1b7..af613b9c8b8 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -88,7 +88,7 @@ the following architecture extensions:
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MixedEnd (Mixed-endian support)
-- FEAT_MixdEndEL0 (Mixed-endian support at EL0)
+- FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
-- 
2.34.1


