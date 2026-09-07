Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA75C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzy-0006HA-PM; Mon, 07 Sep 2026 09:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yzg-0006Bj-0f
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yzc-000523-TX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso31382085e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786155; x=1789390955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iotEmPiMiYZmi7r+LxWWGWJQuCRVXl+ELdBcaukh1a8=;
 b=WT2vBRizlVP3A8qU/PqNmC3jhDqigCwjOuMLlNDgwjNosrOnnv/0LG2JCf9eJ1kLO3
 GyDV10KwKCQ1dYOVZ5Rcb0eeYQgjpOTBda48l6n/l3HCjHJk3mXww+/yT1dapB/zC0Km
 Y58njGQ5dhtW0sij6leicw3ooXW4UXLMXhYbDJPssvYRqTnsObv8tXi+Xo2HNP7CR0Os
 kCp5U4TmSYixSnMF0nuXbilMxCw2QvlarZoWn0hBMM2NrZGiFGrlFn801N6hvB0IQh0J
 tnTTndvyfs+8EFQ68dTdbHoV85JW3r9RXQNfjsFkp7VSyRcsLGkxwz1axSQDlAdVPoUE
 qulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786155; x=1789390955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iotEmPiMiYZmi7r+LxWWGWJQuCRVXl+ELdBcaukh1a8=;
 b=gFMnRi8BWmnPuIIsthRTGHBRL2GJVBnObFomr605CTxBbBgoKcXS/WZaYRnFW9ihS/
 /w97V82Uupbp/lTImWUm4ksZCWi0HTXLup17xs8wd5HlAHw+o2n4guHwW2TBMpvPLtmV
 mrbn2iZ5B1rzoU6BgFeH9ERc8OMI4R0YZMFtv+6OfURg7DjuUl/atqc43eGLaJG9L2e+
 oeHE5ejfBS22cvlsjRbRrQVXSEaIpKdE0wLbl8oe4nJBoLR8QPw07lPybvmz45+BXQoc
 oMkTAGBiR3TVSynhssUkhrDxWQ1WE+ol6ZfziDdSClgAw87Q5si+vM2F3wfLWTCfrunO
 bsMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSp6woocviNUR80vVfX+oTShvCUfNBjDqS0uCxOQJ5wvFKrrDvqJcjbz+RHt3AwG9DLBu+xTaFEeTI@nongnu.org
X-Gm-Message-State: AFuF++mzxKbSYbvcOAZjKHUC/vJAG2ih0OEuiYgv6LqYYI8XFXm2o/vp
 jhK4jPS48fLWliYNx1zvFHGhHMLLYPIpeGf5F1OdNl8K4y9PxDBtwN6CppOHrb5D8zHmP8qmBRC
 y/N6Vagw=
X-Gm-Gg: AYBFou1etJs1ItxQ9iWlkRUKu/L9nlXjzIsdFoTh2w2//GZn0NaqKUx5vWh7R/Uz43J
 Y5dETS/aEe19v8u3+pq1Mq22O0qWsbaHnuV4lAKJTS35ayblitl4vz2fJJ4HWO62NSgnqQ1M7Aq
 ucAcNk7UordCO2bPK3A0Ek+cRzMRL9MmmLWnkqvNp4u4zK3qyB30j06RDykThCjrK3/kMrI5grt
 qWANy4pR9119qjl81UzL+Fv+1Ua2jxxuN6dtcONCG+1N8lX6dHt8k5GE7rwwe0AK1EAFT1/eDjB
 hya3HBk/uBYl6+E0sDTmODSzmzdN4FsyWCPmDQuU3/6F2tfopJTx0B1B5DXNLaGfGCYJfu0Vly3
 i2WWb0IvHSk/isUPujwcg/TI0yx7rxq24US4gEVw3bHVfPM9raNbenPNpFKOHfrN5+8SmxNQmHp
 g7VnX82krsDyi4bn5IdFAha7T/MDftsQ97Ar4HkSIvXLS1STWnrWGacMuLlh4JfNlqkHl7yqVzF
 4U7wtFnWLSZ1/AzNAUecA+x5KgP1+AYMHdq5+Af3tgcRlb5TqvVh83i6o2C3NdEoBY/TIWqfh+P
 9HzI
X-Received: by 2002:a05:600c:6088:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49cfc6cc100mr200291415e9.27.1788786154889; 
 Mon, 07 Sep 2026 06:02:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 8/8] target/arm: Add a debug check that all sysregs are
 migrated
Date: Mon,  7 Sep 2026 14:02:23 +0100
Message-ID: <20260907130223.3148989-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

We mark some sysregs with ARM_CP_ALIAS (either manually or
automatically) to indicate that they are accessing underlying guest
CPU state whose migration and reset is handled by some other
register.  (For example, typically we make the 32-bit view of a
register an alias and handle migration for the 64-bit view.)

Add a debug check that we actually do handle the migration elsewhere:
for every sysreg in the hashtable (i.e.  which might be visible to
the guest), check that some register in the migration list has a
field offset that matches.  This isn't perfect but it can catch some
bugs.  In particular it did fire for the various secure banked
registers that we were not migrating before the fixes in the previous
patches.

Because the check is more of a debugging aid than something I'm
confident will never produce a false-positive report for some niche
combination of CPU and machine options, we only do it for debug
builds, and make it a warning printed to the user rather than an
assertion failure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b41e07e84b4..82e7a20bdb6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -230,6 +230,125 @@ bool write_list_to_cpustate(ARMCPU *cpu)
     return ok;
 }
 
+#ifdef CONFIG_DEBUG_TCG
+/* Data to pass through to check_cpreg() */
+typedef struct CheckCPRegData {
+    ARMCPU *cpu;
+    bool warned;
+} CheckCPRegData;
+
+static void check_cpreg(gpointer key, gpointer value, gpointer opaque)
+{
+    CheckCPRegData *data = opaque;
+    ARMCPU *cpu = data->cpu;
+    CPUARMState *env = &cpu->env;
+    bool match = false;
+    const ARMCPRegInfo *ri = value;
+
+    if ((ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)) ||
+        ri->fieldoffset == 0) {
+        return;
+    }
+
+    /*
+     * If we don't have EL3 then the guest can't get at S-only
+     * registers even if they're in the hashtable. This avoids
+     * false-positive complaints about e.g. TTBCR_S and DFSR_S: they
+     * are migrated via ESR_EL3 and TCR_EL3, but we only register those
+     * _EL3 regs if ARM_FEATURE_EL3.
+     */
+    if (ri->secure == ARM_CP_SECSTATE_S && !arm_feature(env, ARM_FEATURE_EL3)) {
+        return;
+    }
+
+    /*
+     * Some special cases for sysregs that are backed by fields that we
+     * migrate in the main vmstate, not the cpregs array.
+     */
+    if (ri->fieldoffset >= offsetof(CPUARMState, banked_spsr[BANK_USRSYS]) &&
+        ri->fieldoffset <= offsetof(CPUARMState, banked_spsr[BANK_MON])) {
+        return;
+    }
+    if (ri->fieldoffset >= offsetof(CPUARMState, elr_el[0]) &&
+        ri->fieldoffset <= offsetof(CPUARMState, elr_el[3])) {
+        return;
+    }
+    if (ri->fieldoffset >= offsetof(CPUARMState, sp_el[0]) &&
+        ri->fieldoffset <= offsetof(CPUARMState, sp_el[3])) {
+        return;
+    }
+    if (ri->fieldoffset == offsetof(CPUARMState, vfp.xregs[ARM_VFP_FPEXC])) {
+        return;
+    }
+
+    for (int i = 0; i < cpu->cpreg_array_len; i++) {
+        uint32_t other_regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
+        const ARMCPRegInfo *other_ri = get_arm_cp_reginfo(cpu->cp_regs,
+                                                          other_regidx);
+
+        if (!other_ri || (other_ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)) ||
+            other_ri->fieldoffset == 0) {
+            continue;
+        }
+
+        /*
+         * If the field offsets match exactly, or this 32-bit cpreg
+         * is in the second half of a 64-bit field, consider it to
+         * be handled.
+         */
+        if (ri->fieldoffset == other_ri->fieldoffset ||
+            (cpreg_field_type(ri) == MO_32 &&
+             cpreg_field_type(other_ri) == MO_64 &&
+             ri->fieldoffset == other_ri->fieldoffset + 4)) {
+            match = true;
+            break;
+        }
+    }
+    if (!match) {
+        warn_report("check_cpreg: no migration entry found for %s", ri->name);
+        data->warned = true;
+    }
+}
+#endif /* CONFIG_DEBUG_TCG */
+
+static void arm_check_cpreg_coverage(ARMCPU *cpu)
+{
+    /*
+     * Try to catch bugs where we don't actually migrate a cpreg.
+     * Specifically, here we check that every cpreg in the hash table
+     * (and thus potentially visible to the guest) which specifies
+     * a fieldoffset has some entry in the cpreg_indexes[] array that
+     * handles that same fieldoffset.
+     * The typical bug that will be flagged up here is if a register
+     * is marked as an alias of something else, but there isn't actually
+     * anything else that handles the field.
+     *
+     * Note that the checks are more of a best-effort, are somewhat
+     * expensive at O(n^2) in the number of sysregs, and need some
+     * cases to be excluded where the sysreg data isn't migrated via
+     * the cpreg arrays. So we only do them in --enable-debug builds,
+     * to avoid potentially causing problems for users.
+     */
+#ifdef CONFIG_DEBUG_TCG
+    CheckCPRegData data = {
+        .cpu = cpu,
+        .warned = false,
+    };
+
+    /* We'll only use the cpregs for migration with TCG */
+    if (!tcg_enabled()) {
+        return;
+    }
+    g_hash_table_foreach(cpu->cp_regs, check_cpreg, &data);
+
+    if (data.warned) {
+        error_printf("check_cpreg errors are a QEMU bug that may cause "
+                     "migration to fail. Please report this with the full "
+                     "QEMU command line and version.\n");
+    }
+#endif
+}
+
 static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
@@ -281,6 +400,8 @@ void arm_init_cpreg_list(ARMCPU *cpu)
     if (arraylen) {
         qsort(cpu->cpreg_indexes, arraylen, sizeof(uint64_t), compare_u64);
     }
+
+    arm_check_cpreg_coverage(cpu);
 }
 
 bool arm_pan_enabled(CPUARMState *env)
-- 
2.43.0


