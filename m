Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E607ACDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfn-0005Ej-Nq; Thu, 25 Jun 2026 18:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsf1-0004ap-SI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsev-0002L9-Ne
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:35:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84594492c26so200536b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426732; x=1783031532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2qvPCvAlb5yeTP6nFMpGkPdpxWzC532ymb18S8maJ0=;
 b=amicl6Mp//DbhzMaM9QZdteeNCheqfKtDfRX80RRUn6V8NpOZIz0Ay7qKM9az+81+g
 nCv4wh+AkF9ItUtHLnYugjewuuQRH13HLsmUBr5dxeD8xB2YXZ06jcywabXeuaBCbYeh
 EvYX35rgapQx0zWkpdNjsACM+AVCDOy8rt129FRl1+HBwxk8TlhHEuC/WKcylQ6MpF2N
 dNh7X5xFJ+ReQ7UgyuGBgD+QcmSI0GcuF5S7IDhsFM6wtXWfYkjQyieDwPx/6fGSs+40
 uCtIVoWWK2oyAAMyu4dIj4G+eq7C91Lt4gtoDVoh2v5udrxMUDL1KcF/46px+oa1HUDO
 Pqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426732; x=1783031532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2qvPCvAlb5yeTP6nFMpGkPdpxWzC532ymb18S8maJ0=;
 b=UpYAvdV4U4E/iX227nFSAtG9NvvwnC54vNjem2yTlRc9hjjWn2WvIUp1Z7nBcvf84D
 +bakHXZdJSWZG0yLoHk6Jxz7D0erq7w5nsEzTH2MKv+kafJAtDPXiKt7W5lG7mRa9ZHf
 885XZG0HYUm/XKt2/3VbSc5C8kDGS1g+1ROJ1k6JSNF4WvV/Dd7OucjJGu+41HBNELtI
 KiwEgrZF6cm8NHRUGbhjKPc3dkU/DUBlDbHoyOOQ3QRqA/b4OYFG5KgE2gXBJHJPIutL
 L0WyXVPoHQorCmJ+UjlO6JpkBVCFBmemXPO6lGl1quGhPmHXc6/QZS44yCAmzw9YBPm8
 GZ5A==
X-Gm-Message-State: AOJu0YwpYIhE5XcBdJWCHDBpGMsLfUZtUWu3sWgokV25frKzILV/L2nV
 NSNSppSBvnvbamJZ6wBzwI/zhvaFDP1mLyVyRePaSb077pDEsCMrcTg/eoZlmGdukzztAvmB/HJ
 Ls2B5
X-Gm-Gg: AfdE7ckIvCfHlPTTeNkTMeYHJDcCITh01oFuPs6tfrrUv6kDN6x0SH/tqiv1ffaDi+L
 W7wEYVp+jFlCgDlle4j+q2BNsJKqEv+VfPaNlUJR/E302Aq90utLSdgmbuDVZLCCC9PU7iSkyex
 X2HFfaIgkpBLIP1FTLoJrAgkUyReEN/STKVQRl3PlxWBjPgtmE6SJFghJvn3BWZyyQOtl1ty+Sv
 WYH+A8By/I0N8ZnxQqk4uwl36Ub2G54aJpnISb744woHsDz8Kw94hQnAqfpYERNzEZJbwtKCewX
 FY57qukT0zv+Y4MdZCkWBy6HOxV8uG2/bT5x0unOd5jyq5X4Qqtci8gfLwSyoZdHCvv0C74WsRp
 qxP2Qfi0pd7DQtuf9HhU7xK1LUEZhdpTiq32NOD1dDZo0rjfXVfnPe+IavF6FlTNktWygf3yfY4
 gCVXMcgMaXoiu4Zz92ma6jm+FNM3T2CxoCx08wJQUMWcdv15S6Dw==
X-Received: by 2002:a05:6a00:2344:b0:82f:3a1e:5618 with SMTP id
 d2e1a72fcca58-845b3ab5607mr5422904b3a.22.1782426732132; 
 Thu, 25 Jun 2026 15:32:12 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/15] target/arm: Enable FEAT_SME_MOP4 for -cpu max
Date: Thu, 25 Jun 2026 15:32:00 -0700
Message-ID: <20260625223200.763198-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625223200.763198-1-richard.henderson@linaro.org>
References: <20260625223200.763198-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 42aeb29306..5c5fd17d68 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
+    GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 42bff58e76..da2940a41e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1383,6 +1383,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7b85ec6146..3d711d76b7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -173,6 +173,7 @@ the following architecture extensions:
 - FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
-- 
2.43.0


