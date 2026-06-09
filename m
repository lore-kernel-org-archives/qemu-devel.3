Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F05CCD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28B-0003f4-Og; Tue, 09 Jun 2026 15:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX225-0003fS-IT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21t-00046F-VY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso53591175ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032889; x=1781637689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yx3pBpNnnixYGvFXS+Bu2M3m7XbvSzNcUUbjpi1jMJc=;
 b=Dh4nGgkNWT0gpe/Hbk36KVl6RlFv4vh+KPvkrIhkz38cuH0t8j0Svysvt7YYpPk4t+
 j4cxWnvjuwiSe/DoG0BBVhX7Xkb9x9mLaQjsEuwDOfejZSEeeF6zEcUpBtzzghM4kPx9
 onJWx4ZmO6blsQbaWQrPytTbUNRZNaxgU7KZApqvfE9eNr1Vb7EuXBcR+AEC1Zb6iXna
 f9waQhKZsr0PyeeXqT4rMPEXGsQPanXibg8Rw2/JBcNlnOhsBvfrp9aLetrWyZ3w06/0
 BrMQmPpdUKJLhl6pgoBsrxzmGeytgycNC5BwqXeTmZm6IRw6v5TQXNtyQ9UiNyFH4Lhj
 O/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032889; x=1781637689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yx3pBpNnnixYGvFXS+Bu2M3m7XbvSzNcUUbjpi1jMJc=;
 b=da/WbuUZu+6Y08maTxE9/oYy+E/xwenvwkiO/VlA+c15rEM6UYnWVh84C4sH8c77ne
 6G4BoDnpqI3c1vcAoTOfJ9DOA0+DIaXwd9awoQf58MX6hkHu1L4tThl5ansQ+SfFvT/U
 az5vLLLrU0DbuvgUOSwP3vEEqLWhCwuPAa4eZGcemuyWxvyOTo/CaINur3YNDy0UuG1Z
 OxJ9leu8ObG8xQDKFWhUXe5LUQlswk/p9j4kbspskpzQ12tjSH8oYa5ROiwONP8Ku7a8
 77iE157c79Mj82DVCuorwlJJiErp7lqrBcjFxfEwt2bB6uH3vEQYNNSwcU6BMLISIVml
 XuSg==
X-Gm-Message-State: AOJu0YyiPu9lsaP1oLnZNBHd0tjj8gpI0rgLqRkbaMxwfzvxISXHF4v8
 WQx64r950WmQP/48L97QBOoTD6SabT7GStjIBUTf81wNp+ZB6n/nLYb6LNRrOfsDgk/JMaZU7yR
 +RT3vHZQ=
X-Gm-Gg: Acq92OHbT0fI2XvxjyJ6shClQy0ayUNGUOqF5gJRLRrK0We6b1T5XHP3uAs3RVBOukv
 dkgVsiJjorIKLwvaBTOPt7OWnXvbFsYj3EIhaNIzavVkHB43Lc046Fkqg4qmNfbiEYl0QflFZCP
 Po5cUD5cYNWevIMBjtC9zMJ/n5N0FtK9vCh9/kaH1iJomMF+F5Zzrru13Hb22D4M8Zfkpp9F+MX
 chqe5xFyKdHwS2lL9ooSt5QTEbzohtXOnAugIHhCjj+XDDix2RVLhgIJfWIxWx8VhQ9v3Xis9wK
 /602tdNG6wzMq/U8NPUq3x/IJTtCEmqh/JfWmNIEFmCn8qOf9PLondg5rHLb5o1BQsg9ZcjRfF1
 e9xG1AR59b9z5xr89GxRlX4ykJQtZV9rtOosceJxBmGz/qaLqk0zT6N2czfNIIcorm4dAV4e0fP
 DlImeVTGq9punpO+4q7qw7eJwULkv+D9pB3/ZOoUi7Ggk5l/Umrg==
X-Received: by 2002:a17:903:2411:b0:2bf:379b:53f4 with SMTP id
 d9443c01a7336-2c1e849511fmr270740355ad.19.1781032888649; 
 Tue, 09 Jun 2026 12:21:28 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 24/45] target/arm: Enable FEAT_FP8 for -cpu max
Date: Tue,  9 Jun 2026 12:20:48 -0700
Message-ID: <20260609192110.752384-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 3 +++
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 10 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 5ed7a7badb..1c0c404b7c 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -222,6 +222,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
+                               ARM_HWCAP2_A64_F8E4M3 |
+                               ARM_HWCAP2_A64_F8E5M2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 39dc769a04..b48dd01a2c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1392,6 +1392,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index dc20632097..470f7d891e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


