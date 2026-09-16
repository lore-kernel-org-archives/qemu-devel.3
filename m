Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AE7C982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qxM-0001aQ-1H; Wed, 16 Sep 2026 10:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qx5-0000ze-Hr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qx3-0006mC-No
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e02JHTK5vtyACAt9OjPCN3RGbXnELCnkz1SQgi2oqUc=;
 b=UMOjgj4SiRziIdUHdeshGfgHxENL8DD+wbVbn3MDwLagAVIVWTeaADhZT8e2ocOlRjdC3d
 spk2ml/W9Ke2RU1bIiScBzGsg2U/wZFXRRwcOskeMfcjo+78Lk90ceXtJ6ZGu7LOIKd1rh
 SB2NOIgPGCkF+4vG+At4hT3yHIymD6k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-pDKpRdLvO4mUUX9UnosilA-1; Wed,
 16 Sep 2026 10:49:29 -0400
X-MC-Unique: pDKpRdLvO4mUUX9UnosilA-1
X-Mimecast-MFC-AGG-ID: pDKpRdLvO4mUUX9UnosilA_1789570167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99FF2183019A; Wed, 16 Sep 2026 14:49:27 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA73919560AB; Wed, 16 Sep 2026 14:49:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 22/26] target/arm/kvm: Add an error handle to
 kvm_arm_create_scratch_host_vcpu
Date: Wed, 16 Sep 2026 16:45:45 +0200
Message-ID: <20260916144721.751810-23-eric.auger@redhat.com>
In-Reply-To: <20260916144721.751810-1-eric.auger@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This allows to report a precise error message if any error occurs.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm_arm.h |  3 ++-
 target/arm/kvm.c     | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index bace69efed..185018e00c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -106,6 +106,7 @@ struct kvm_vcpu_init;
  * @init: filled in with the necessary values for creating a host
  * vcpu. If NULL is provided, will not init the vCPU (though the cpufd
  * will still be set up).
+ * @errp: Error handle
  *
  * Create a scratch vcpu in its own VM of the type preferred by the host
  * kernel (as would be used for '-cpu host'), for purposes of probing it
@@ -115,7 +116,7 @@ struct kvm_vcpu_init;
  * false on failure (and fdarray and init are not valid).
  */
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
-                                      struct kvm_vcpu_init *init);
+                                      struct kvm_vcpu_init *init, Error **errp);
 
 /**
  * kvm_arm_destroy_scratch_host_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f7ca0e0250..43fb61bef4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -107,13 +107,14 @@ static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 }
 
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
-                                      struct kvm_vcpu_init *init)
+                                      struct kvm_vcpu_init *init, Error **errp)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
+        error_setg(errp, "Failed opening /dev/kvm");
         goto err;
     }
     max_vm_pa_size = ioctl(kvmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
@@ -124,6 +125,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
         vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
+        error_setg(errp, "Failed creating the scratch VM");
         goto err;
     }
 
@@ -143,6 +145,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 
     cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
     if (cpufd < 0) {
+        error_setg(errp, "Failed creating the scratch VCPU");
         goto err;
     }
 
@@ -156,12 +159,14 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 
         ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
         if (ret < 0) {
+            error_setg(errp, "Failed getting the preferred target");
             goto err;
         }
         init->target = preferred.target;
     }
     ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
     if (ret < 0) {
+        error_setg(errp, "Failed the init of the scratch vcpu");
         goto err;
     }
 
@@ -659,6 +664,7 @@ kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     bool el2_supported;
     bool pmu_supported = false;
     uint64_t features = 0;
+    Error *local_err = NULL;
     int err;
 
     ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
@@ -706,7 +712,8 @@ kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, &local_err)) {
+        error_report_err(local_err);
         return;
     }
 
@@ -3093,8 +3100,10 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
     int fdarray[3];
+    Error *err = NULL;
 
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL, &err)) {
+        error_report_err(err);
         return;
     }
 
-- 
2.53.0


