Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C613CEE334
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 16:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLOHr-0002nW-E9; Tue, 18 Nov 2025 11:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOH8-0002Zp-HB
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vLOH6-0004gd-Jh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 11:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763482186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCXFBOVAeisHEx3+fOj5JbWs4YJB8n7CVHoFfGsSQp8=;
 b=AYnkcHx1z+gbLMbQR6dungH7kd2TbQtVKKiSBEmiuqOeH4ePAleD2uX5YtTQMt+FBWRH0N
 CdWp6/jWXV2rbwrxgYcrqwDzGj0CGZCryOqk9ic02R3zka1x1+NTJT7dig80XzdZXfsIa7
 3GGcWpMhboaRADkQfBPvPlpsCvHJj6M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-aV09ZANiM9-52Edrkl-8Xg-1; Tue,
 18 Nov 2025 11:09:43 -0500
X-MC-Unique: aV09ZANiM9-52Edrkl-8Xg-1
X-Mimecast-MFC-AGG-ID: aV09ZANiM9-52Edrkl-8Xg_1763482180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 996BD1800107; Tue, 18 Nov 2025 16:09:40 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FF1719560B2; Tue, 18 Nov 2025 16:09:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v2 2/8] target/arm/cpu: Allow registers to be hidden
Date: Tue, 18 Nov 2025 17:07:32 +0100
Message-ID: <20251118160920.554809-3-eric.auger@redhat.com>
In-Reply-To: <20251118160920.554809-1-eric.auger@redhat.com>
References: <20251118160920.554809-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

More recent kernels sometimes expose new registers in an
unconditionnal manner. This situation breaks backward migration
as qemu notices there are more registers in the input stream
than supported on the destination host. This leads to a
"failed to load cpu:cpreg_vmstate_array_len" error.

A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
migration from a host kernel that features the commit to a destination
host that doesn't, fail with above error.

Currently QEMU is not using that feature so ignoring this latter
is not a problem. An easy way to fix the migration issue is to teach
qemu we don't care about that register and we can simply ignore it
when syncing its state during migration.

This patch introduces an array of such hidden registers. Soon it will
be settable through an array property.

If hidden, the register is moved out of the array of cpreg which is
built in kvm_arm_init_cpreg_list(). That way their state won't be
synced.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- Move the property in a separate patch
- improve the commit msg
- change the trace point to just print info in
  kvm_arm_init_cpreg_list()
- improve comment in cpu.h (Connie)
---
 target/arm/cpu.h        | 23 +++++++++++++++++++++++
 target/arm/kvm.c        | 12 +++++++++++-
 target/arm/trace-events |  2 ++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 077b0cce5b..0a283940be 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1044,6 +1044,18 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /*
+     * Register indexes that must be hidden. Although normally
+     * supported (defined in TCG description or exposed by KVM) they are
+     * willingly hidden for migration sake. This may be used to allow
+     * backward migration to older versions that do implement a specific
+     * feature. With KVM acceleration the indexes are the ones described
+     * in linux/Documentation/virt/kvm/api.rst. With TCG, this is the TCG
+     * sysreg index.
+     */
+    uint64_t *hidden_regs;
+    uint32_t nr_hidden_regs;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
@@ -1184,6 +1196,17 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
+static inline bool
+arm_cpu_hidden_reg(ARMCPU *cpu, uint64_t regidx)
+{
+    for (int i = 0; i < cpu->nr_hidden_regs; i++) {
+        if (cpu->hidden_regs[i] == regidx) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 58c6075a9e..575a668f49 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -788,7 +788,10 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     qsort(&rlp->reg, rlp->n, sizeof(rlp->reg[0]), compare_u64);
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
-        if (!kvm_arm_reg_syncs_via_cpreg_list(rlp->reg[i])) {
+        uint64_t regidx = rlp->reg[i];
+
+        if (!kvm_arm_reg_syncs_via_cpreg_list(regidx) ||
+            arm_cpu_hidden_reg(cpu, regidx)) {
             continue;
         }
         switch (rlp->reg[i] & KVM_REG_SIZE_MASK) {
@@ -804,6 +807,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         arraylen++;
     }
 
+    trace_kvm_arm_init_cpreg_list_arraylen(arraylen);
+
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
@@ -815,9 +820,14 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
         uint64_t regidx = rlp->reg[i];
+
         if (!kvm_arm_reg_syncs_via_cpreg_list(regidx)) {
             continue;
         }
+        if (arm_cpu_hidden_reg(cpu, regidx)) {
+            trace_kvm_arm_init_cpreg_list_skip_hidden_reg(rlp->reg[i]);
+            continue;
+        }
         cpu->cpreg_indexes[arraylen] = regidx;
         arraylen++;
     }
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 0a5ed3e69d..20f4b4f2cd 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -14,6 +14,8 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input stream: %s"
+kvm_arm_init_cpreg_list_arraylen(uint32_t arraylen) "arraylen=%d"
+kvm_arm_init_cpreg_list_skip_hidden_reg(uint64_t regidx) "hidden 0x%"PRIx64" is skipped"
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.51.1


