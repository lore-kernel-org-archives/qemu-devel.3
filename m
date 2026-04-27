Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE3FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQy-0002hg-Sr; Mon, 27 Apr 2026 08:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-00084j-9w
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNi-0005fy-Q3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so126645365e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294088; x=1777898888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Royy9UKz2653bp7UiRhq7eGlbKNi2zJHhkuwnIFZio=;
 b=AQFuz+SmNbEWEFw45qaXp6YPmleUO+5sdYskAeU0peOSr7qOEonEW5TPGqCYXLqtGe
 sxyLz9WsOJB7eLM6WcjpI60D8q7Jyo2qqn/7DfKK8MYaNaLASUJVV4OnMzknmC9TLBh5
 Mryz3XQI1Ot1kqjkbE/oZ/Wp3/qjiPT21ZyxaXt2cHghbKGQIX5uHnMW6B0MU2aYpvEa
 /0ZbOnyzXi6XVabY28VwfgjKVaa0ibThkP5F5rUKtgSkEKrNNmhAWHJbUQz1UhLphQLC
 Umunxmes0r9i6ewr85QAoxjWsd3tCYURAGKOJ2BzRhCqcFperIgrHfFR4DFAd3bFmAoP
 GE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294088; x=1777898888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Royy9UKz2653bp7UiRhq7eGlbKNi2zJHhkuwnIFZio=;
 b=GVnARqA6z1WHtTFG0bBk3JKo5zvZjyu2G/9PtdoBTxoY5EDlkuUO0cvVRAYmleVhQO
 3wVCh6WgK+5SSW10Q3vMI/oiWwTiB9KcqbQzxB9xovlMDPWx/awAMvv00LRODFycDQv4
 YCYxmv3b1cKxmUPOgrwsmvKrmvm8PyetHBT4WYvkqMIjy31ZQy1cmavokQgQkEWrH0CP
 mnpZPpS9ty+smiBfnsXZtzj19kJu3QAjQ/DFfKqvN/jmpaUmgeun3zt3aZaER/burgoq
 6EPKVE1FbVyc0gOQrOboSB68IHhcUw/QLhkFWYDmqITYd55f2XFh3a4toc4ZBL7TwkVo
 7+7A==
X-Gm-Message-State: AOJu0Yx734w8H+67bYYkYEaUtyNVqwvdshV6Gdwwdv4W3EbKCfCBYO7H
 pUQNhElJDj/uAIzYRM5DF+M4wUkzgnmHSNItK7TGWsRAL/l0MJeWF+GMsr0e2eUQvKfyuZlfosD
 ObE8G
X-Gm-Gg: AeBDiesIeOfDn6dNyttBGTKvvHcs8gurMS8viljiZm9rgoQC4L+16PqIpETkj3Mt9LJ
 OX4XC48QD14s7v/5sVd9wwww1WtYzBWOZmG2EC7yYJE5X/e+EDENsUtoe20PEZEIrC7JoPxd5F4
 A077LdG7FQCD6nMCFSaZjzil8xCh9LLW7RyTUL86ArLa2Mx5AlexQ4MT0clWWwQx1iNVsPtmgGa
 Z4TjiyU1/+Qo68LoJtUmekMjc0dSDZOsfU1sVrIaDKr96DC9UyFD72/xhUYoJPY7zeTgnkSVWeo
 J9V+DX7TJGB+p1DTe+cfTxp6uxel+IONsxRUUsazwXj3lwwCMC8EhKbSE5sxh+hQ/ltqONyuhkz
 LRZcAEX7niwqZgMxgiTBVMr6eJDUyz6Fb2r0mHE9NkLwlJCQx7NasElhj0Jy2a5rj4200Uuz1W4
 vjCVXRzxqwmt3atnZPaNSVvLwc2Y6Lezz5FFU1F4j/rSikJbNO4yJbjS55DtRBnR7CxZPLyN3ZZ
 GLnS6NeNwSIZ0X/Y82N8Q5e4RHo95G+Znvc82uK+8DAiHEffoTz
X-Received: by 2002:a05:600c:899:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-4891a635125mr302497985e9.0.1777294088318; 
 Mon, 27 Apr 2026 05:48:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/63] target/arm/cpu: Introduce the infrastructure for cpreg
 migration tolerances
Date: Mon, 27 Apr 2026 13:47:05 +0100
Message-ID: <20260427124738.966578-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
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

From: Eric Auger <eric.auger@redhat.com>

We introduce a datatype for a tolerance with respect to a given
cpreg migration issue. The tolerance applies to a given cpreg kvm index,
and can be of different types:
a) mismatch in cpreg indexes
- ToleranceNotOnBothEnds (cpreg index is allowed to be only present
  on one end)
- ToleranceOnlySrcTestValue (cpreg index is allowed to be only
  present in source if its value @mask field matches @value)
b) mismatch in cpreg values
- ToleranceDiffInMask (value differences are allowed only within a mask)
- ToleranceFieldLT (incoming field value must be less than a given value)
- ToleranceFieldGT (incoming field value must be greater than a given value)

A QLIST of such tolerances can be populated using a new helper:
arm_register_cpreg_mig_tolerance() and arm_cpu_match_cpreg_mig_tolerance()
allows to check whether a tolerance exists for a given kvm index and its
criterion is matched.

callers for those helpers will be introduced in subsequent patches.

Only registration of migration tolerances related to cpreg index
mismatch is currently allowed.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260420140552.104369-2-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c       | 82 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h       |  1 +
 target/arm/internals.h | 54 ++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9b80dda140..10feb639c4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -181,6 +181,82 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+static ARMCPRegMigTolerance *find_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx)
+{
+    ARMCPRegMigTolerance *t;
+    QLIST_FOREACH(t, &cpu->cpreg_mig_tolerances, node) {
+        if (t->kvmidx == kvmidx)  {
+            return t;
+        }
+    }
+    return NULL;
+}
+
+void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                      uint64_t mask, uint64_t value,
+                                      ARMCPRegMigToleranceType type)
+{
+    ARMCPRegMigTolerance *entry;
+
+    /* make sure the kvmidx has not tolerance already registered */
+    assert(!find_mig_tolerance(cpu, kvmidx));
+
+    assert(type == ToleranceNotOnBothEnds ||
+           type == ToleranceOnlySrcTestValue);
+
+    entry = g_new0(ARMCPRegMigTolerance, 1);
+
+    entry->kvmidx = kvmidx;
+    entry->mask = mask;
+    entry->value = value;
+    entry->type = type;
+
+    QLIST_INSERT_HEAD(&cpu->cpreg_mig_tolerances, entry, node);
+}
+
+bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                       uint64_t vmstate_value, uint64_t local_value,
+                                       ARMCPRegMigToleranceType type)
+{
+    ARMCPRegMigTolerance *t = find_mig_tolerance(cpu, kvmidx);
+    uint64_t diff, diff_outside_mask, field;
+
+    if (!t || t->type != type) {
+        return false;
+    }
+
+    if (type == ToleranceNotOnBothEnds) {
+        return true;
+    }
+
+    if (type == ToleranceOnlySrcTestValue &&
+        ((vmstate_value & t->mask) == t->value)) {
+        return true;
+    }
+
+    /* Need to check the mask */
+    diff = vmstate_value ^ local_value;
+    diff_outside_mask = diff & ~t->mask;
+
+    if (diff_outside_mask) {
+        /* there are differences outside of the mask */
+        return false;
+    }
+    if (type == ToleranceDiffInMask) {
+        /* differences only in the field, tolerance matched */
+        return true;
+    }
+    /* need to compare field value against authorized ones */
+    field = vmstate_value & t->mask;
+    if (type == ToleranceFieldLT && (field < t->value)) {
+        return true;
+    }
+    if (type == ToleranceFieldGT && (field > t->value)) {
+        return true;
+    }
+    return false;
+}
+
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
@@ -1102,6 +1178,7 @@ static void arm_cpu_initfn(Object *obj)
 
     QLIST_INIT(&cpu->pre_el_change_hooks);
     QLIST_INIT(&cpu->el_change_hooks);
+    QLIST_INIT(&cpu->cpreg_mig_tolerances);
 
 #ifdef CONFIG_USER_ONLY
 # ifdef TARGET_AARCH64
@@ -1574,6 +1651,7 @@ static void arm_cpu_finalizefn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMELChangeHook *hook, *next;
+    ARMCPRegMigTolerance *t, *n;
 
     g_hash_table_destroy(cpu->cp_regs);
 
@@ -1585,6 +1663,10 @@ static void arm_cpu_finalizefn(Object *obj)
         QLIST_REMOVE(hook, node);
         g_free(hook);
     }
+    QLIST_FOREACH_SAFE(t, &cpu->cpreg_mig_tolerances, node, n) {
+        QLIST_REMOVE(t, node);
+        g_free(t);
+    }
 #ifndef CONFIG_USER_ONLY
     if (cpu->pmu_timer) {
         timer_free(cpu->pmu_timer);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab6bacf4aa..be14a47c35 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1140,6 +1140,7 @@ struct ArchCPU {
 
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
+    QLIST_HEAD(, ARMCPRegMigTolerance) cpreg_mig_tolerances;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 06655409e5..a632584a4e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1943,4 +1943,58 @@ int compare_u64(const void *a, const void *b);
 /* Used in FEAT_MEC to set the MECIDWidthm1 field in the MECIDR_EL2 register. */
 #define MECID_WIDTH 16
 
+typedef enum {
+    ToleranceNotOnBothEnds,
+    ToleranceOnlySrcTestValue,
+    ToleranceDiffInMask,
+    ToleranceFieldLT,
+    ToleranceFieldGT,
+} ARMCPRegMigToleranceType;
+
+typedef struct ARMCPRegMigTolerance {
+    uint64_t kvmidx;
+    uint64_t mask;
+    uint64_t value;
+    ARMCPRegMigToleranceType type;
+    QLIST_ENTRY(ARMCPRegMigTolerance) node;
+} ARMCPRegMigTolerance;
+
+/**
+ * arm_register_cpreg_mig_tolerance:
+ * Register a migration tolerance wrt one given cpreg identified by its
+ * @kvmidx. Calling this function twice for the same @kvmidx is a
+ * programming error and will cause an assertion failure.
+ *
+ * @cpu: vcpu to apply the migration tolerance on
+ * @kvmidx: kvm index of the cpreg the tolerance applies to
+ * @mask: bitmask where a difference is tolerated
+ *        (relevant with ToleranceDiffInMask)
+ * @value: value the bitmask field is compared with
+ *        (relevant with ToleranceFieldLT and ToleranceFieldGT)
+ * @type: type of the migration tolerance:
+ * - ToleranceNotOnBothEnds (cpreg index is allowed to be only present
+ *   on one end)
+ * - ToleranceOnlySrcTestValue (cpreg index is allowed to be only
+ *   present in source if its value @mask field matches @value)
+ * - ToleranceDiffInMask (mismatch in cpreg values are only tolerated
+ *   if differences are within @mask)
+ * - ToleranceFieldLT (mismatch in cpreg values are only tolerated
+ *   if incoming @bitmask field value is less than @value)
+ * - ToleranceFieldGT (mismatch in cpreg values are only tolerated
+ *   if incoming @bitmask field value is greater than @value)
+ */
+void arm_register_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                      uint64_t mask, uint64_t value,
+                                      ARMCPRegMigToleranceType type);
+
+/**
+ * arm_cpu_match_cpreg_mig_tolerance:
+ * Check whether a tolerance of type @type exists for a given @kvmidx
+ * and the tolerance criterion is satisfied
+ */
+bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
+                                       uint64_t vmstate_value, uint64_t local_value,
+                                       ARMCPRegMigToleranceType type);
+
+
 #endif
-- 
2.43.0


