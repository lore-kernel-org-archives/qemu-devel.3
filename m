Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5677DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbe-00078d-Vn; Thu, 02 Jan 2025 13:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbE-0006yK-VV
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbB-000589-Ay
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:11 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216401de828so149071525ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841225; x=1736446025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LdV/fw1z38xgmhQOFy7vKXkzceYMFFjgRQIhSP1eZoA=;
 b=ZWp5ngeiyNobhbfxp4URDoU/kvQMf97gtpDeO4/0PV7c1GWAudNAAQmjmCPOWKbmD7
 3HKVNemVWYJEJYw/3QPJx/Fnwu7pRPVkpot8IPiaxj89rIlJCXKHr65SKtq8H+2aI+U+
 KJ2zd4nxHsN7Fm8iPSNa/o6SAOO3ACTW35FyGTatAttgBQVzP1vQFfLJhrAYDCquM0tm
 bEa5EFnk4GJN/M4oarTssSYPQegkuikVQv/cn/gn/gwuweqrWvEJ5hL7E/d0DvmFIdgA
 kX+eMtxntpKE6Wey0IVqNbw3X7V0BoKW6KZKqLXfKq7ZYAvJPs3fSuKv/otquLF25LLu
 bZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841225; x=1736446025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdV/fw1z38xgmhQOFy7vKXkzceYMFFjgRQIhSP1eZoA=;
 b=vC7JdTmFyzTnx+2GCFxijtbDX+NxQx8GWCKdRbQhnRX6vLngWxbWkwkIKzBy9c4WKI
 tLGMxR5kc+KaFJpJhQzcxgYRcXjOSRFOi0EfYhi9pdq1uYJ/dcY2liKWLC44dwZhBLrk
 scGcdb7/riUFg91NL7E/4vUguGe2x1+JnTlMoBARm2tgmmCFAfDOik/zESi+pzbvL6op
 ZfJ3KbaSCoJpUdZ4DBWGvsJHL02RGipY1tjuEXa1SkzM+av8DQyW20+4enuGIf5LFSj0
 4KA/wX6v3DTVKmCf6qed+IVeCZlKDDJHJIVJPaHHyoxu26voI3MbHFIZGsWuJRL9+y4E
 sf/Q==
X-Gm-Message-State: AOJu0Yx008EMKprUI1ZGUUz3j4Gw6BZYX/XCcdTVNIYQRFJesky5Po/8
 YioWBa/D0aQXkd4kG37hNpnGj1n6V7gAWVps0FrySc+r5bQIQCEm43pm67cu2Zb1MzKt4uV6aAY
 c
X-Gm-Gg: ASbGnctMDlqMoC8Q3xTO2SytX15VrTa30CStDHMJjufaCNKYtIoGFCtcmjIsGrhIyc3
 TtBqUu0AMD8WDyKdQ7ZI/Q2NF/QeuTMMC8wCcVbIUygVWFeBxJs7lWQ1ymh84p4jq2KHm8RoKae
 044n67q9YEdXwZ7qlfxiVymfPXROnTk7QVgB58FOD1bbWvm+QcLP0YuQZe+07v38uoLy6IbKFYZ
 60mDZXyP7qJfuHH7qvDeL2bRMoGodIP7AxZay0GJO9CNceYK+0E9xAAVU3EJw==
X-Google-Smtp-Source: AGHT+IGCjp3LtmmyM3g2y7FqA5wiToZlr/3NlhdSvUI44R031YYpvqpFcCqHpWPUCXkPluP6yTj1pg==
X-Received: by 2002:a05:6a21:3116:b0:1e1:abd6:ca66 with SMTP id
 adf61e73a8af0-1e5e049f46dmr69172796637.24.1735841225285; 
 Thu, 02 Jan 2025 10:07:05 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/73] target/i386: Remove TCG_TARGET_extract_tl_valid
Date: Thu,  2 Jan 2025 10:05:52 -0800
Message-ID: <20250102180654.1420056-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This macro is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 785ff63f2a..ab416627b7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -26,11 +26,9 @@
 #ifdef TARGET_X86_64
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
 #define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i64_valid
 #else
 #define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
 #define TCG_TARGET_deposit_tl_valid     TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
 #endif
 
 #define MMX_OFFSET(reg)                        \
-- 
2.43.0


