Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5558E7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu4L-0007I6-OX; Mon, 02 Feb 2026 08:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4G-00076v-SG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4C-0002hq-M1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:16 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso40858685e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039251; x=1770644051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7/A50zC5y9dv4obdxsbQJJ3KmtCSDayPVIoHJnHYD0=;
 b=yguDanot1pXM85cA0t3/BxYsYppeTavl6+3Z++iVV7DKxaC45uCt/7XILJbJBBbHus
 W4f+TOehoh9okFth76KiJ5QhQs2Lhnfod+DZLintlGMGtP4gqLxOs0D9PBISJZuH8pAc
 oDwhP+GxmeOjhUMHKWYz+0TjjX2RnMUXxMpCp94/vHwZCqT63FTDDIZP9k97mDbiuswG
 g4sEECVdNefNjUUrDE3JJo079tK7z4I9tsgFHtlQ99uoTCwopO5U0MZT4pubf5kpwTy3
 MpIhjS7ZXKPAuPG3g32rMzG9D9HRx17Y/7+t5TGXXjZ3L1aDLUlFLqSwhTHDDPY5dbli
 QQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039251; x=1770644051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7/A50zC5y9dv4obdxsbQJJ3KmtCSDayPVIoHJnHYD0=;
 b=gS2xm6Cc/8pAoZmHwYZwcTCqbGWCYAehZdWdNChc5SIzvXoxtAMNisgH+kfjSOd9zU
 WQnqvIdljLYP82asjnHpP9x940PZhd+oFiqqdjqldLQXTjtaIYPlwWSb95Sgqz8Vzrzl
 c46/R4ugaydE6Pn5hcmw6M9pLggCQDUZsGkAWXKsguqslsF2XB70X9B2xizAxksNRUSB
 WvlKMiKl60qNU1cZugPaQR/JHiLee1UPwMCMi3gTrSQmtLMFF1p+bwHL10cFScTkpiND
 wI/a+3yo8S4jVs0B2bYUGarkGLgrPwExaQGKE5YszzGCSwHRgKcdSeE4EUAuQFdZtMfL
 sgYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdgQNkNHOgTY0LZqjBhMLZ19kcJUL0EE8Cyi4Hj3yFtDLRIz4iADds9yFYBgeH4kgwMwjI3eIab0C3@nongnu.org
X-Gm-Message-State: AOJu0YysYYew/aGC9wILszCAg9XCtTlY21mANqoEXPtV6nzg9x65grwC
 xz3j8eskEyJDTqq9xJCffmM8ev0gXy/AavQDXnLXQG0oGZFurjpZZwCh9CZqc5i/7Lo=
X-Gm-Gg: AZuq6aIk1WArVAe7otTfWvL2imoR4o7/hsONO/4lFgTNy/ivUfEGBFOFyDJu6RzyZyv
 BSD2BEm6qTrljNZWdkpQFJicAatZcYPzrLoKi6Lh8H/qTvbw/cQlfu+zm8AqSVVJIq/tNHWraYW
 eWjynjPQ+PweSa1btO7Pks/PT5Z+E70WxfNWmJQC17/YekCBk5YF2CTwFtuw1Udy62i6DBY/c9g
 90+Zqzn/CXWeprV/HBloL98ZVuT9WpD9Qk7mg+nUFbjvXkLrRhZct7CKVmv1tLh/ox9hNhM17Ch
 +9GwG0NGB9Zi1HfE2p4bZUsO4wpiP6tSxIXqHVj5BqqblnhffCHy/chZGo7vOOvhGbvQrXmftQC
 NQ4toshCFrkxwUHBkNUV9w426CLUjONYarU24/ZgS5qSQUXWpcVAJIcXzriaiT21AnwOa6ps8T0
 eS/oR7DcfypTl3QRTpv8TOwdYPkwcoSg==
X-Received: by 2002:a05:600c:19c7:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-482db477009mr174725745e9.12.1770039250927; 
 Mon, 02 Feb 2026 05:34:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 13/15] target/arm: Don't squash all ID_AA64ZFR0_EL1 fields
 for non-SVE
Date: Mon,  2 Feb 2026 13:33:51 +0000
Message-ID: <20260202133353.2231685-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The ID register ID_AA64ZFR0_EL1's fields are not all for SVE
exclusive features; some are also used to describe SME on an
SME-only CPU:

SVE-only fields:
 * F64MM, F32MM, F16MM, SM4, B16B16, SVEVer

Fields used for SVE and SME (in some cases there is also a
field for SME in ID_AA64SMFR0_EL1, but it is just a "present
or absent" single bit flag and the ZFR0 field then tells you
what level of support is present):
 * I8MM, SHA3, BF16, BitPerm, EltPerm, AES

Currently we zero the whole ID_AA64ZFR0_EL1 register in
arm_cpu_sve_finalize() if SVE is not present, which wipes also the
fields we need for SME.  Only clear the fields which are SVE-specific
here, and clear the rest in arm_cpu_sme_finalize() if we
have neither SME nor SVE.

This requires us to update our ID_AA64ZFR0 field definitions
to match the rev M.a.a Arm ARM, as the F16MM SVE-only field
is not one we had a definition for previously.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h |  2 ++
 target/arm/cpu64.c        | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1bcf28ab08..e0b7a45b7b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -367,12 +367,14 @@ FIELD(ID_AA64DFR0, HPMN0, 60, 4)
 
 FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
 FIELD(ID_AA64ZFR0, AES, 4, 4)
+FIELD(ID_AA64ZFR0, ELTPERM, 12, 4)
 FIELD(ID_AA64ZFR0, BITPERM, 16, 4)
 FIELD(ID_AA64ZFR0, BFLOAT16, 20, 4)
 FIELD(ID_AA64ZFR0, B16B16, 24, 4)
 FIELD(ID_AA64ZFR0, SHA3, 32, 4)
 FIELD(ID_AA64ZFR0, SM4, 40, 4)
 FIELD(ID_AA64ZFR0, I8MM, 44, 4)
+FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26873a39b4..a9c1e60c95 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -133,9 +133,17 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
         if (!cpu_isar_feature(aa64_sve, cpu)) {
             /*
              * SVE is disabled and so are all vector lengths.  Good.
-             * Disable all SVE extensions as well.
+             * Disable all SVE extensions as well. Note that some ZFR0
+             * fields are used also by SME so must not be wiped in
+             * an SME-no-SVE config. We will clear the rest in
+             * arm_cpu_sme_finalize() if necessary.
              */
-            SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F64MM, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F32MM, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F16MM, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, SM4, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, B16B16, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, SVEVER, 0);
             return;
         }
 
@@ -335,6 +343,10 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
     if (vq_map == 0) {
         if (!cpu_isar_feature(aa64_sme, cpu)) {
             SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
+            if (!cpu_isar_feature(aa64_sve, cpu)) {
+                /* This clears the "SVE or SME" fields in ZFR0 */
+                SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+            }
             return;
         }
 
-- 
2.43.0


