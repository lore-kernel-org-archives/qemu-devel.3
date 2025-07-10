Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04728C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuiY-0006xX-83; Thu, 10 Jul 2025 13:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuLE-0004Pn-Kz
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuLC-0001As-Tq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso843032b3a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752165705; x=1752770505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxglZr9FSbfBVmHLZ+FvVDfQKN3fWf8b03y6OHhLFac=;
 b=XbGyl32HuXid/Xp6ibSD/wCDSnax1aJiUgR6GzJhvj5Y27ctxt+u6k7TbGZbcNP1EL
 CE/jWd2U9f4T5+jB3kIXNHWqmTJKYENq0NouxUdVwwJl+UnIl7gygkHv7AptAlmyE7ud
 2DhT1IM32dNG/syDsuWzXX1Jh7Q1R/gqY4xJ9PPmXYSqvBtLQ42pAhgfYSh7LxeMLeYI
 WDwHxXGXl3NjhURgHrM+hBO5ZTNTQOoGBGmHMsA4wZJY5Tyuc/vgmjCP7a8Bss7/faUc
 hmdrPPJpnwwMrIi+UgKD5+DwvtcwKbfH5r9faBPLN8FnWJBRXqGoiSvVBbWSxFIxtp1V
 DuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165705; x=1752770505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxglZr9FSbfBVmHLZ+FvVDfQKN3fWf8b03y6OHhLFac=;
 b=ClsXJT0X8cXj85nb+8sV+b7EKikT+p3F9o7vRL3QTLKQYi8u3D1yNioqJy4cgKntdP
 hxlMlEw8Lm6l362mVomK3AcPZNbe834KNl3AfcX0cHQqcZmxcJ78q3avik1/qO/zaGZb
 DRz2A17zy99TSMYMO8tSShAMAzsGQfgjgUofW5lpev4y20jB754KiEj6WZ5JuVRpcxfD
 fnx7+kHjVd65I2uMpc+jl0uBqOJxSqEEKq471/gUJn8aSs0Bsdn1UwawRclXN1akFlLo
 39SernJR3DETJ+XMSWIGL9PZ2c2m8iY1Fu9IFv6pWwKwAcowhbemNTxrPV7Sad+wsEku
 fUGQ==
X-Gm-Message-State: AOJu0YznNsXi8NDGn8bpH6KP7tnqkj1reTHASdpeMjaM7kiIbPM4kgB6
 XiD84+tkqbbZBuA8Ar/nWRt8wjyO4jOeP0phxt8D6tynS8hl1VN18WjFBtVk/fSXPd4=
X-Gm-Gg: ASbGncuHIR1wkGARx7r5vuZBlmW9ZKrU2q+BDLMX0eHQf0z1ALBnMAM1fNC6PzUq5D2
 lwJjzFN5dFpc7l85swO7PIQ3Rr+bzPt4xYq0dp9Yc/FZZdRgiKDyz1hHeMbi4I/vsPEcc2bA7Tn
 8LOQFAAxMUa+7qg58MTv9+k5pKVa4HvmyQ49jfmyPjrF1ALkqkkfVkLiXuAtH5Ee5DkXfP0f0IO
 R512VXvEH+pIhxrfAabkInYlJoB9YkI7h4H9xyJYa/ikzxHP7gH+8VwK7bgexnRchM8wixClDUW
 OORr25JQ4HDJKG4bNCe0baJzXpwIaXNyOOaowDtaBbF4MOavOqqzRYIrA7oLBkom+mkHoHytay/
 3d0G9gr70muqjLggAlWlJLQ==
X-Google-Smtp-Source: AGHT+IHs6X6TJoZFV3hxG75A/LOqYKYH0DdE6kJoOtPODuPsbqQiF/CnEFD7ROf7LLpj5AehxDrz1g==
X-Received: by 2002:a05:6a00:bd93:b0:73e:2d7a:8fc0 with SMTP id
 d2e1a72fcca58-74ea641180fmr10537784b3a.1.1752165705377; 
 Thu, 10 Jul 2025 09:41:45 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5c7f7sm2919119b3a.142.2025.07.10.09.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:41:44 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 6/6] target/arm: Advertise FEAT_MEC in cpu max
Date: Thu, 10 Jul 2025 16:38:59 +0000
Message-Id: <20250710163858.1094780-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710163858.1094780-1-gustavo.romero@linaro.org>
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but software
stacks that rely on FEAT_MEC to run should work properly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d8673..d207a9f266 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,9 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ae2046a7f6..1b9b6475b6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1250,6 +1250,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
-- 
2.34.1


