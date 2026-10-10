Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDB9CA9EC5
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXIG-0003WV-RV; Sat, 10 Oct 2026 09:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIE-0003Jo-Hv
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXIC-0004fo-P1
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2e+3CcNTBkD4MMGpHP73g186a5p7lV5juXn4lBjmR0Q=;
 b=f7cWgZ9anaO8Fhx8IZ3ocxjDqbfh9ZN112YEGYgw1InHI8erhKuvGGVG+0FeyJyQvI6shZ
 CiLhCAJx8ROPbG4DRiuOc7E02azYIEi1ZiWFWWP/KdZWdO5S24bsI4w8c8IHPSQBeFB7WY
 6UDbbiSrFGrBAPcso6I1E4WWqANHSDA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-HXkgVivpOn-D1dziElzKEQ-1; Sat,
 10 Oct 2026 13:39:12 +0000
X-MC-Unique: HXkgVivpOn-D1dziElzKEQ-1
X-Mimecast-MFC-AGG-ID: HXkgVivpOn-D1dziElzKEQ_1791639550
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88E081944DF3; Sat, 10 Oct 2026 13:39:10 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C48330000E5; Sat, 10 Oct 2026 13:39:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 19/26] target/arm/kvm: Apply SYSREG props
Date: Sat, 10 Oct 2026 15:36:23 +0200
Message-ID: <20261010133725.642498-20-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now the infrastructure is in place let's trigger the
SYSREG prop update in the KVM code. This is done in both
kvm_arch_init_vcpu() and kvm_arm_reset_vcpu() after the final
vcpu has been initialized with the proper kvm init settings and
before kvmstate is synced back to the cpreg list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10
- use ValueRange
---
 target/arm/cpu64.c |  9 +++++----
 target/arm/kvm.c   | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26baee102c..ff178bcaf5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -883,10 +883,11 @@ static void set_sysreg_prop(Object *obj, Visitor *v,
         return;
     }
 
-    if (field->arch_vals) {
-        /* this field has some enum values */
-        for (int i = 0; i < field->arch_vals_count; i++) {
-            if (value == field->arch_vals[i]) {
+    if (field->arch_value_ranges) {
+        for (uint32_t i = 0; i < field->arch_value_ranges_count; i++) {
+            const ARM64SysRegArchValueRange *r = &field->arch_value_ranges[i];
+
+            if (value >= r->lo && value <= r->hi) {
                 goto valid;
             }
         }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c6c9ea03a5..0c7e80aea8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1247,7 +1247,7 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
     return true;
 }
 
-static int G_GNUC_UNUSED
+static int
 kvm_arm_override_idreg_field(int fd, ARM64SysRegField *field,
                              uint64_t newfv, Error **errp)
 {
@@ -1291,6 +1291,17 @@ kvm_arm_override_idreg_field(int fd, ARM64SysRegField *field,
     return 0;
 }
 
+static int kvm_arm_apply_one_sysreg_prop(ARMCPU *cpu, ARM64SysRegField *field,
+                                         uint64_t newfv, Error **errp)
+{
+    return kvm_arm_override_idreg_field(CPU(cpu)->kvm_fd, field, newfv, errp);
+}
+
+static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
+{
+    return arm_cpu_apply_sysreg_props(cpu, kvm_arm_apply_one_sysreg_prop, errp);
+}
+
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     int ret;
@@ -1304,6 +1315,8 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         abort();
     }
 
+    kvm_arm_apply_sysreg_props(cpu, &error_abort);
+
     if (!write_kvmstate_to_list(cpu)) {
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
@@ -2250,6 +2263,11 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
     }
     SET_IDREG(&cpu->isar, MPIDR, mpidr);
 
+    ret = kvm_arm_apply_sysreg_props(cpu, errp);
+    if (ret) {
+        return ret;
+    }
+
     cpu->mp_affinity = GET_IDREG(&cpu->isar, MPIDR) & ARM64_AFFINITY_MASK;
 
     return kvm_arm_init_cpreg_list(cpu, errp);
-- 
2.53.0


