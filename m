Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEF5CD6E56
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrQ-0000Fy-KU; Sat, 30 May 2026 19:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrO-0000CZ-4C
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:54 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrM-0007Xs-JY
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8422f148dfcso242441b3a.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182771; x=1780787571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwM2p9I/SON4IwZR4K/Mk/coaIyxRCDMbGetn6Pf8BM=;
 b=tQZRNLjMr3ZrEL+lXq0pimLEGUpUfCLQX+XPsfUR6+qwS99PM3U03K1I5KjXPNtI1h
 bdjW6Zn87Znu+/U8QkarCk0gRf2l7y8CoXBK0ST4ipCP6o0qQ1lQnl8NtY9Rky1PLo0m
 zFNzZwnbqaEf+8uCn5qlqYc5B1//WRQr1wn9sS4OwjWPamKV/Ew0Sgtz0GDwmnQ7ihGw
 kZZArnBXPpVnNW0MCyV37NybN7vwCWEI/69ZofMHTmTkITK5K+0EIRqqn+UJ7QldmCwm
 kskPdC1xrHK2uIsC4eKMNi7YSjrL2mysu/iVd73ZNrsHWPFzBmdJIvBWpqxAThOFruvc
 Wq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182771; x=1780787571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LwM2p9I/SON4IwZR4K/Mk/coaIyxRCDMbGetn6Pf8BM=;
 b=fnl26aCQBeB5D5tK1yoqpLA4xfKEf9yGC05tJ5vldTdt7XASWhzoA7wrTYUjx5hjl5
 hc68JdP8/VQPYE+8kcPaaqOtGgN06GrrCZNZGy7SiQ9mU8fPybOq3XcNU6INwosf5LIu
 dC9bBwWi10fqxGe+/yxL7TpBHKwl5eXjBM0OdaoQPpyYmVHpQOafuCNtCs9+6/ffmB9B
 PLLON0SP5Eqp9MbSAchiEOBlD53Zab56yjavc69SbgKUrKPNqcS5PPG3gs1B1WVpQo8l
 w8cKbh6R9WVcmu04C2jtTT7nRlzHPyKZZWwMtmdT3t75MUnwN08I9g1QfQHGrGD9U1Ij
 pKsQ==
X-Gm-Message-State: AOJu0YxXVeNS9b2W/SFEpVkDL6QHOeW6U7NfGJi/fU3KrH5TJoJvOYKI
 KPdV77FFYi4rl/FIOEsQHltER/iDKcy/SrGppWQeSjUhyCjvFGbdkuIW4NKNA6RL+OZcRBvPn9+
 G+Y0Js5k=
X-Gm-Gg: Acq92OHQ6z26S5aUvbuZzr6dPDdbGHct1gGrhZg0KvtMPraVOkglEJDnZ0VQKPeS8Jc
 G500lWC8auqfJKf1sE2bCezpWZPrMnT89jjyPeJ7GyIaYTlCGcwvafsJ4SbQBslz1XwGW589L1D
 igjlEbAAuUZvl5LJCqrhkpMaNC6wqkiTYrXGoYHVMVoUmCDBUS57ouEsX+9/ebf1rGB5op1ihA+
 9mEmsYZjWpoU43ZOAS3ydSoJHn1eeZXQxP+hySsyGnPH19zhZhR/vWCJ7lYfr30HIkq+G5HpaBe
 j9TApgWp58AXx0L7CzDiw8ejDJ/yr/V55m8EAX1FOoJD9r1G1jJa5mdFBuC1hHbHKarrFMCoMaB
 M1pMc4seEo4kKetLZ84I9JpaFmmBA8ls4exJoZNS6524hGDMq97otrcFDSo5S+9kCibG2iF8Vvz
 xfZ4RoYKBzxGwDtfTwH8noM4b5hf+kph+KzkHrVxY=
X-Received: by 2002:a05:6a20:ce44:b0:39b:fbb2:5e46 with SMTP id
 adf61e73a8af0-3b427fbf046mr4966398637.40.1780182771142; 
 Sat, 30 May 2026 16:12:51 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 19/41] target/arm: Enable FEAT_LUT for -cpu max
Date: Sat, 30 May 2026 16:12:07 -0700
Message-ID: <20260530231229.400441-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 228b593316..5ed7a7badb 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -221,6 +221,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
+    GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1a4f50486d..39dc769a04 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1263,6 +1263,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 18c6355967..dc20632097 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -102,6 +102,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
+- FEAT_LUT (Lookup table instructions with 2-bit and 4-bit indices)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MEC (Memory Encryption Contexts)
 
-- 
2.43.0


