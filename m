Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55BCCA5FB1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUf7-0007Eh-DV; Tue, 29 Sep 2026 06:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf4-0007C1-8A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:10 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf2-0008Cz-2g
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:09 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff6f0f87so17033065e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676127; x=1791280927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pCfW5J8p4kjJuBOEGneHUztcohlfUp7Ju5tNCqINCXY=;
 b=Q3brhHjovgrIEywx31K5uYhtLAnCIsxIKDILNXXL/gdNEYTqzZoNYK4zijeqzhRTri
 dx4E9qfoyUxSB9tJt3LotsyTLgTubazh8IrF2LVvNuQm6UF7faapmXney7dpkh+pulx/
 LRJ0BwIbO5uUCDnWAKIlVtXxPslBwm8jjn2iLnwGF3I68rCgjVO7zvAJmsz4AjsTq8vj
 Y574JSvCej5JXtJIq6pOPH6KgR8H8XuY9ia7joyS7ts869u8QR5qOLUt2jSBjQzXfiXl
 84Ht1qkln23IAxlBWnfNDICXdgXjupa8vFhyqsi9Z9j46n7UyPrGaii9R7aO1fYT8RAa
 S13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676127; x=1791280927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pCfW5J8p4kjJuBOEGneHUztcohlfUp7Ju5tNCqINCXY=;
 b=dsGeaBvqu3TQKgU6vCYiF0uhcU4kr3vUjeKFtl9Ma8+nTul2rpExJM/0r5ciKbZObd
 b8WviF49FiIRyLYAQ9KbKozc2U1BL0cCIf/VSdq/et6hS2lA6eMpk67qhpNVhbudxGy5
 uaHt9O1myKA4pUUc/BeZMIhfQWmSRWzNpp8Npn1nKDoF4z1NjBQkkTi/Sa12+HN7NpXT
 VKYaik6b+AbVawN3IKi4DpZwgIiSV/mapZ+vtURRXIU9cyKelivWTgLPWgDuDxM2f4t3
 LDEgjzW35htkokH+ftoy3oGGiPCUaV1Gl7bTU1FLmC74DhGZAChBHLxbcaMiDBc6utqh
 m8VA==
X-Gm-Message-State: AFuF++k/B4Do+wxrZLCoETzFw7nDikjsTIVOb/hGCmbKmDtd25ET1NPp
 YDK9/7zZmF/8XttU0HS3dvDXBngfDBGEpnRykfafTvnHkUMJoNwcHa1yPf1TW401Z5t77kAlCY4
 ehfsl
X-Gm-Gg: AYBFou30tY82zMseS2bS1s9SVSdSsF9yVnBiEejNdzspXKIt7E6o7EIIK57J6mHk5Oq
 ErIvnvdmnYqvrfexTVzJ9sapSfkrzHoALj5CJDEkhjbQkZr6wNrs2fGk7P9cxyX8CQpRTpHzX5C
 Q2jwLHZW8rT72vSMGQRw5tbImd4sH4kOrfUbTVxhfGD8eFVAtvauOLchSu75o4WAWPKg101RVZg
 7m13yFTv9EWxUxm0nhqcSUvkWnPbZ4sWRQQeHpTzZYDoo459FbZS/2/ENTLWs4btunDRGcDzJgW
 FJNvko2jujETT/CG13tVH+ew57ws7fvpWo7wc2hqVbNWL0IR6qux0fNONDeiNViF7dC3/dVfNhv
 2UkuO+MijzUs+rJsGuj8tQaI/mJBrr5642AzVXNAPnCQDyNLqk8YCquu86Ne95w/OLvGnSk0ID3
 W/xZ0pGYJXkngvlEoHEFO+H/QFt2/myNf3/A0szvpLySP7i6lwQyvqaYd5blzAU0ifePDP0o1Tc
 ZCPIEPkDTLjUcxhARCZtZE/rucYQGmhXPSsCcxAIJ+RwqRJWtXFVX0uN8imIC2en85yxAu++Pih
 USY=
X-Received: by 2002:a05:600c:4744:b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49fe7b6371bmr275197255e9.12.1790676126367; 
 Tue, 29 Sep 2026 03:02:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/37] target/arm: Add a debug check that all sysregs are
 migrated
Date: Tue, 29 Sep 2026 11:01:15 +0100
Message-ID: <20260929100133.2598676-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-9-peter.maydell@linaro.org
---
 target/arm/helper.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1fe06a6351c..9ba924e5de3 100644
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


