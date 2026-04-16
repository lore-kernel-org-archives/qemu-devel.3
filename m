Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE5BF8D762
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPyg-00069v-Ks; Thu, 16 Apr 2026 12:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyf-00069C-7R
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDPyd-0007c5-AF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:54:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4888375f735so82359885e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776358441; x=1776963241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1oPHbQSPRM9BqIW/R6wbhEyiBfOJFdGBhv8oIagU3w=;
 b=Zkm0edQiNVN9NZLd/+nC44tpaY9Nt5+TybHzdzome3Dvs33dvVD7G1Wwca9bfcYXMp
 PBOM3hQcabO+///LW/pm6RpIFXpVqqV6vfvTPBMMdOES0HnRj1zK/LPHVED7kUumCWFb
 v9OqrNbdh2wAycZilXXiNZNyyrasR/eWtJbpvTxdo6GqioFA3V4LNrb37ShA8VBRj7r4
 Ksdgk/PLtQCjkTiexnjp0Xq33Jo3opGo8Q5qFcGK4Prj7b5+248ygNdoFfoFpoyYjj88
 E8MNHGrUHeUtoqAPoGn2rrqb3esz9eLyvRCXYja3PrJo+fn1hk8J5qBfp8pv/rGD7QWq
 Mlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358441; x=1776963241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f1oPHbQSPRM9BqIW/R6wbhEyiBfOJFdGBhv8oIagU3w=;
 b=B1CS0qv2Xiw15pUJVRbWqATDF4eJFFludySBJJwO4E2O7NJNrMRGuDusyElVM2XGac
 uprL08Y5svB5JAtkBVq/NnShx8/bMMK0OHV2gb0eVWZwSt9sah5MTaknjZ4pHdEPgXDy
 AmHoZT5Zo+somKzEmnBpwBcxETS7f3rjOTliYCJWnUQglIdid56tmS8TU/Ijft12qCMb
 j5n0ifuIUtjE4Cai9muV4r7CX75ckJw2wAIwgfwuTOLwWSaofIUJCaJpP5rF5jX++J2u
 F7LC3pw1QzjviDGVA9/XppEOOJnoPBl3xegg1X2OsVD6lKXlb+EEp4w0OCBqnTvQyG0E
 MCYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0nKrFhG/icVRHIk006IVKKBhGFvNGch0LYJmIQtVw9HqjDih+l9Ow1d5GHB/3A7M+GLPkFBQ4FYhQ@nongnu.org
X-Gm-Message-State: AOJu0Yznv7wT/CzQKNrZBZh1nVHh/28srucmFJAL10Zn30Z22YcQ3j4p
 axED+iLknGHPis7c0+SVJeOHFl5YoujP+cJy5pWdNDadAa+IgGiZISj73NXZ85N5n+6bVHDQL4w
 AqkoKD5Y=
X-Gm-Gg: AeBDievFTSw8/EaKWPFVWyIwf0eNvAbuLQpirOSFCflNR3Ij39MSXC5IyWKxiAqR8Aa
 a+pYQL+paoqQbkmX0DnKxx26IV96r8fqIYVr40djkhKupHXbFz7LinUQshH2yrC8NmQf2zoIEkC
 vOA7g9uTClEtsukamg5yGRKF6qaiDB908STXVM/EuptWQm4uaqsFGaiQmszEOIzMZ/y6BBbfszF
 NS4PTIhEUxE2+LY+5+AMKfwJpNH6PzMKMBunYxxwpkDyymw6TrLtqfI2Py1C+SDkthZxlBpiKMN
 /XRApSbwoGzWzUpgPqTMta6xcqN2K/o5GK0Lf1Tzopk08N2JbQwyD3YrSV/emRSJ47BXW25Z7mq
 oQ1cvOAnC89Q4XBm07PCeAbr2rXdS6Z2ZskASEh7z4o0x1BWWvSFFAdsUG9LmSyv+nQUaJQRPGy
 LsKugu7YF5MF+ld3+KKQwrq7F5QQ6SCGguqZ208dbm7DgVtt2iJxeB5JK4Op8btlTRDALciWJ8I
 x5nB8/KBjuYyPdxNHt8kbGNXD9stxr0+puLFOfQbg==
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-488d67bbcbamr381815095e9.3.1776358440828; 
 Thu, 16 Apr 2026 09:54:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fa79d476sm473035e9.1.2026.04.16.09.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:53:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 1/3] target/arm: Clear AArch64 ID regs from ARMISARegisters
 if AArch64 disabled
Date: Thu, 16 Apr 2026 17:53:51 +0100
Message-ID: <20260416165353.589569-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416165353.589569-1-peter.maydell@linaro.org>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

If we create a normally-AArch64 CPU and configure it with
aarch64=off, this will by default leave all the AArch64 ID register
values in its ARMISARegisters struct untouched.  That in turn means
that tests of cpu_isar_feature(aa64_something, cpu) will return true.

Until now we have had a design policy that you shouldn't check an
aa64_ feature unless you know that the CPU has AArch64; but this is
quite fragile as it's easy to forget and only causes a problem in the
corner case where AArch64 was turned off.  In particular, when we
extend the ability to disable AArch64 from only KVM to also TCG there
are many more aa64 feature check points which we would otherwise have
to audit for whether they needed to be guarded with a check on
ARM_FEATURE_AARCH64.

Instead, make the CPU realize function zero out all the 64-bit ID
registers if a TCG CPU doesn't have AArch64; this will make aa64_
feature tests generally return false.

We only do this for TCG because only TCG really needs it, and for
KVM it might be confusing to have QEMU's idea of the ID registers
be different from KVM's.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: limit scope of register clearing to TCG, as I suggested
after posting and testing the v1 version:
 https://patchew.org/QEMU/20251002101648.2455374-1-peter.maydell@linaro.org/20251002101648.2455374-2-peter.maydell@linaro.org/
---
 target/arm/cpu.c | 35 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h |  3 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9a..11d3437843 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1610,6 +1610,27 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
     }
 }
 
+static void arm_clear_aarch64_idregs(ARMCPU *cpu)
+{
+    /* Zero out all the AArch64 ID registers in ARMISARegisters */
+    SET_IDREG(&cpu->isar, ID_AA64ISAR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64PFR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64MMFR3, 0);
+    SET_IDREG(&cpu->isar, ID_AA64DFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64DFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64AFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64AFR1, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+    SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
+}
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1737,6 +1758,20 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
+    /*
+     * A TCG aarch64=off CPU has no AArch64 at all, so we clear out the
+     * ID registers to avoid cpu_isar_feature(aa64_something, cpu) tests
+     * incorrectly returning true. We don't do this for other accelerators
+     * (which in practice means "for KVM", since no others have AArch32
+     * guest support) because from KVM's point of view the AArch64 ID
+     * registers still exist and must have their correct values. So we
+     * avoid clearing them out so that we don't have QEMU and KVM with
+     * different ideas of the ID registers.
+     */
+    if (tcg_enabled() && !arm_feature(env, ARM_FEATURE_AARCH64)) {
+        arm_clear_aarch64_idregs(cpu);
+    }
+
 #ifdef CONFIG_USER_ONLY
     /*
      * User mode relies on IC IVAU instructions to catch modification of
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..ab6bacf4aa 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1080,7 +1080,8 @@ struct ArchCPU {
      * Note that if you add an ID register to the ARMISARegisters struct
      * you need to also update the 32-bit and 64-bit versions of the
      * kvm_arm_get_host_cpu_features() function to correctly populate the
-     * field by reading the value from the KVM vCPU.
+     * field by reading the value from the KVM vCPU. If it is an AArch64
+     * ID register then you also must update arm_clear_aarch64_idregs().
      */
     struct ARMISARegisters {
         uint32_t mvfr0;
-- 
2.43.0


