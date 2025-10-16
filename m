Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7B7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0o-0000dO-2C; Thu, 16 Oct 2025 08:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9MzU-0006GL-Mu
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9MzI-0000YH-Fw
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4256866958bso438716f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617299; x=1761222099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlH28MEFkskcP66JhzjpJic8qnfGg69iwWfrsdKmpK4=;
 b=RWtvD6wzrctyCIVhCcE5wYoMenrKWcV6fnEpbwJGD0SRC3C/nl6YEXFXA9vyhDW4TE
 URelmyumQB+rCQIReUS63rugocbh4UVloWIj13Y93Dsjx0wQp0mpRalWObd80lH8X0Qi
 HISzhdQD2HYQrqMsVIszQREsl7nIBmvwIcmbx3B1TWRXp+KqoqK/XBT77F8vZIPUK0Ft
 sbGjllkmdxMEGcqGdhbMTN4CLy4c21F0Eb45R7obr9cwQMZutj9ESeCQNqLSuV4Lc5fv
 3fAFQXOxQCN+vhFYSvpnjLCAEPNFszD7qlK2Vtha0lH8Fys47U1JKkJS4fxTK61U2pOx
 wi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617300; x=1761222100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlH28MEFkskcP66JhzjpJic8qnfGg69iwWfrsdKmpK4=;
 b=dilF/3xDdcb/FlpW1r58BQMtLr5KkGtwUP+6QhhUHWy/kVfcZ1CIvMG9RQGdTVosuI
 HFYF6fKp0FU4qQv0tmz3pbm7/tydvjsHTqYiqkIJvcbAnyxAC8j5b7maOHN+PFWOYMg8
 geKat2zWAtTouOmJWLDX0Yolh4rPQ72a3iS7MaS2Ni/A/z9zBl4Mwkf0tm5h3o4Gq2ou
 YT3lrwAWsRxray//H6I+kuPZxet/fHEOYUpajqCFKC6VaJAJh1fwHI5D6eVmwu3iEWIv
 wxaV3ulW67rhQp+0OFjXcx4HtGFypmwCM6E0EDXC731eFdi2s/y4oasZ4zHFiQLu3nxX
 AqOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqFz8jjdkLpbmIB+31Lcbglh7HnR+IC2aqWr4jLDlGor99CsfiSCzcYzGQI0wiKcJ66tltkCIr3OnP@nongnu.org
X-Gm-Message-State: AOJu0YzVBpxbM3P9vNjbYcbe2yh81cWfTXf2ISWYFiMBIco++8o2CEma
 J7qdkE3NMTSOmfHHHGxIcaq/SIg/7Mme4nmI8yFQbG9QYeIxOLoVh5wgGHXqSIXiaa4=
X-Gm-Gg: ASbGncuc1WCdTjS//CrWMWYhw+n0DNv0iEjDDgYqnmQ21XaYrVy44hmTW1MvebrO4au
 6oDst4WueXUlVtAcVOExxunVjo07jJM0911DpEhCXfVpNeC4zfJYZ+SRTp4kNx2IIsJ/MxIfIjF
 3Zb4u9Oy9krgO5dEZSq1OvPE0NvANBlnn8Hbn4qz9UKaazERvfpAftHYkdT0+0+KS/mkIlEDay/
 38Mz4jmz8rhIltzDL2H73IHRjpFfPtSqy+2XfkjyEcJd93e6blcLfrcy8NFE19LPtERxWt4U6mL
 SfqCYNNHYubEf6LghnuxPvC1ECupjsRymHB3naOM+1dYTiKQz4UInb4KBSh+F1rsOVSn56VztZ+
 SJcRnt0WCyiuUiVZ3t1erkjGFgA1EXhnWCYXhIzxy/RkVueYFeDWGBXhhnyci1n34EI7zTlo0pg
 T+JTgctw8BbA==
X-Google-Smtp-Source: AGHT+IHwZxLI71dDPDvJdf1rb1C7VEky/xIj+7p4PAr3KhbPdap2q1uMNHgsDhegr9DCV7OTwK69CQ==
X-Received: by 2002:a05:6000:491e:b0:426:d51c:4be9 with SMTP id
 ffacd0b85a97d-426d51c4d14mr14831646f8f.25.1760617299538; 
 Thu, 16 Oct 2025 05:21:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ff65596csm3412428f8f.24.2025.10.16.05.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 05:21:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH 1/2] target/arm: Implement SME2 support in gdbstub
Date: Thu, 16 Oct 2025 13:21:31 +0100
Message-ID: <20251016122132.737016-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016122132.737016-1-peter.maydell@linaro.org>
References: <20251016122132.737016-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

For SME2, we need to expose the new ZT0 register in the gdbstub XML.
gdb documents that the requirements are:

> The ‘org.gnu.gdb.aarch64.sme2’ feature is optional.  If present,
> then the ‘org.gnu.gdb.aarch64.sme’ feature must also be present.
> The ‘org.gnu.gdb.aarch64.sme2’ feature should contain the
> following:
>
>    - ZT0 is a register of 512 bits (64 bytes).  It is defined as a
>      vector of bytes.

Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  1 +
 target/arm/internals.h |  3 ++
 target/arm/gdbstub.c   |  7 ++++
 target/arm/gdbstub64.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bf221e6f973..912f7a87e42 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -939,6 +939,7 @@ struct ArchCPU {
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
     DynamicGDBFeatureInfo dyn_smereg_feature;
+    DynamicGDBFeatureInfo dyn_sme2reg_feature;
     DynamicGDBFeatureInfo dyn_m_systemreg_feature;
     DynamicGDBFeatureInfo dyn_m_secextreg_feature;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f539bbe58e1..c41c1f224a5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1715,10 +1715,13 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
+GDBFeature *arm_gen_dynamic_sme2reg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_sme2_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_sme2_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8d2229f5192..7cac2a5965e 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -554,6 +554,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                 arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
                                      aarch64_gdb_set_sme_reg, sme_feature, 0);
+            if (isar_feature_aa64_sme2(&cpu->isar)) {
+                GDBFeature *sme2_feature =
+                    arm_gen_dynamic_sme2reg_feature(cs, cs->gdb_num_regs);
+                gdb_register_coprocessor(cs, aarch64_gdb_get_sme2_reg,
+                                         aarch64_gdb_set_sme2_reg,
+                                         sme2_feature, 0);
+            }
         }
         /*
          * Note that we report pauth information via the feature name
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 65d6bbe65fb..7f7d706324e 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -335,6 +335,58 @@ int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_sme2_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int len = 0;
+
+    switch (reg) {
+    case 0: /* ZT0 */
+        for (int i = 0; i < ARRAY_SIZE(env->za_state.zt0); i+= 2) {
+            len += gdb_get_reg128(buf, env->za_state.zt0[i + 1],
+                                  env->za_state.zt0[i]);
+        }
+        return len;
+    default:
+        /* gdbstub asked for something out of range */
+        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
+        break;
+    }
+
+    return 0;
+}
+
+int aarch64_gdb_set_sme2_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int len = 0;
+
+    switch (reg) {
+    case 0: /* ZT0 */
+        for (int i = 0; i < ARRAY_SIZE(env->za_state.zt0); i += 2) {
+            if (target_big_endian()) {
+                env->za_state.zt0[i + 1] = ldq_p(buf);
+                buf += 8;
+                env->za_state.zt0[i] = ldq_p(buf);
+            } else {
+                env->za_state.zt0[i] = ldq_p(buf);
+                buf += 8;
+                env->za_state.zt0[i + 1] = ldq_p(buf);
+            }
+            buf += 8;
+            len += 16;
+        }
+        return len;
+    default:
+        /* gdbstub asked for something out of range */
+        break;
+    }
+
+    return 0;
+}
+
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -534,6 +586,30 @@ GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_smereg_feature.desc;
 }
 
+GDBFeature *arm_gen_dynamic_sme2reg_feature(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GDBFeatureBuilder builder;
+    int reg = 0;
+
+    gdb_feature_builder_init(&builder, &cpu->dyn_sme2reg_feature.desc,
+                             "org.gnu.gdb.aarch64.sme2", "sme2-registers.xml",
+                             base_reg);
+
+
+    /* Create the sme2_bv vector type (a 64 byte vector) */
+    gdb_feature_builder_append_tag(
+        &builder, "<vector id=\"sme2_bv\" type=\"uint8\" count=\"64\"/>");
+
+    /* Define the ZT0 register */
+    gdb_feature_builder_append_reg(&builder, "zt0", 64 * 8, reg++,
+                                   "sme2_bv", NULL);
+
+    gdb_feature_builder_end(&builder);
+
+    return &cpu->dyn_sme2reg_feature.desc;
+}
+
 #ifdef CONFIG_USER_ONLY
 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 {
-- 
2.43.0


