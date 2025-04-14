Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46618C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MsN-0007zs-QO; Mon, 14 Apr 2025 12:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u4Ms7-0007dk-T2
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1u4Ms1-0006UQ-Jn
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744648874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EyLEZ3HI7CqZABdZVcXz92ZT3jwespQsaTUlJJTXjs=;
 b=h0iKVKi6f+3J5tpIpV2lVjzavDkjhGZypk5WmMy2+3Jn5bAkGzn2jwvLoHOi8uZzmP3w4x
 O6LB5v3fYoAAuBfCvENSlWBFAtKHG0gZy8cWfw7ZnqWcHgHGDmGH4jOAF0lbaYokgLnPdr
 ZoazfSANWA2xZAW/rRaJLcBDkS8AMTE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-N-mCmTkQNBSx3dUD_6wKJg-1; Mon,
 14 Apr 2025 12:41:11 -0400
X-MC-Unique: N-mCmTkQNBSx3dUD_6wKJg-1
X-Mimecast-MFC-AGG-ID: N-mCmTkQNBSx3dUD_6wKJg_1744648869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46F5118001E3; Mon, 14 Apr 2025 16:41:09 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.67.24.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2700180AF7C; Mon, 14 Apr 2025 16:40:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 07/10] arm/kvm: write back modified ID regs to KVM
Date: Mon, 14 Apr 2025 18:38:46 +0200
Message-ID: <20250414163849.321857-8-cohuck@redhat.com>
In-Reply-To: <20250414163849.321857-1-cohuck@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

We want to give a chance to override the value of host ID regs.
In a previous patch we made sure all their values could be fetched
through kvm_get_one_reg() calls before their modification. After
their potential modification we need to make sure we write back
the values through kvm_set_one_reg() calls.

Make sure the cpreg_list is modified with updated values and
transfer those values back to kvm.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm.c        | 44 ++++++++++++++++++++++++++++++++++++++++-
 target/arm/trace-events |  1 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b07d5f16db50..9e4cca1705c8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1083,6 +1083,39 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu)
     }
 }
 
+static void kvm_arm_writable_idregs_to_cpreg_list(ARMCPU *cpu)
+{
+    if (!cpu->writable_map) {
+        return;
+    }
+    for (int i = 0; i < NR_ID_REGS; i++) {
+        uint64_t writable_mask = cpu->writable_map->regs[i];
+        uint64_t *cpreg;
+
+        if (writable_mask) {
+            uint64_t previous, new;
+            int idx = kvm_idx_to_idregs_idx(i);
+            ARM64SysReg *sysregdesc;
+            uint32_t sysreg;
+
+            if (idx == -1) {
+                /* sysreg writable, but we don't know it */
+                continue;
+            }
+            sysregdesc = &arm64_id_regs[idx];
+            sysreg = sysregdesc->sysreg;
+            cpreg = kvm_arm_get_cpreg_ptr(cpu, idregs_sysreg_to_kvm_reg(sysreg));
+            previous = *cpreg;
+            new = cpu->isar.idregs[idx];
+            if (previous != new) {
+                *cpreg = new;
+                trace_kvm_arm_writable_idregs_to_cpreg_list(sysregdesc->name,
+                                                            previous, new);
+            }
+        }
+    }
+}
+
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     int ret;
@@ -2050,7 +2083,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    return kvm_arm_init_cpreg_list(cpu);
+    ret = kvm_arm_init_cpreg_list(cpu);
+    if (ret) {
+        return ret;
+    }
+    /* overwrite writable ID regs with their updated property values */
+    kvm_arm_writable_idregs_to_cpreg_list(cpu);
+
+    write_list_to_kvmstate(cpu, 3);
+
+    return 0;
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 17e52c0705f2..955149ee1ac4 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -14,3 +14,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
+kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
-- 
2.49.0


