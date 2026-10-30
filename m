Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D2606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ixvr5zV/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMh5Z-0002ka-Di; Fri, 30 Oct 2026 03:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMh4w-0001oW-I3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 03:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMh4u-0005fP-P7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 03:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793345468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvLwS/N1pk/tD3VgegJXMgrrfqN8Zx0U/juCBWUjj5s=;
 b=ixvr5zV/hu8IgyxElRRSuL9uuq8kZx8YfNQZMT+lj6WaUFRVltPEgpXdYbThN79I5EQ1nL
 QtuVNgYW/Uc9nD4Le2zdid0AD/MneDpG8e09RBwmmrC9I7/50pFGNL1Xw98YS50Gj/yUuc
 FL7sObzpkxc7Dyk8cCHY1tkyPtKCGfU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-_YqA-GT8Nce8m8DPeaYBNA-1; Fri,
 30 Oct 2026 03:31:01 -0400
X-MC-Unique: _YqA-GT8Nce8m8DPeaYBNA-1
X-Mimecast-MFC-AGG-ID: _YqA-GT8Nce8m8DPeaYBNA_1793345459
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD51218005AD; Fri, 30 Oct 2026 07:30:58 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 757353000738; Fri, 30 Oct 2026 07:30:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v3 for-11.2 10/10] target/arm/kvm: Pass an error handle to
 kvm_arm_create_scratch_host_vcpu
Date: Fri, 30 Oct 2026 08:28:51 +0100
Message-ID: <20261030072956.402425-11-eric.auger@redhat.com>
In-Reply-To: <20261030072956.402425-1-eric.auger@redhat.com>
References: <20261030072956.402425-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This allows to report a precise error message if any error occurs.

In arm_gic_cap_kvm_probe() call path we just pass a NULL error handle
because we don't care about the failure, reverting to emulated
versions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm_arm.h |  3 ++-
 target/arm/kvm.c     | 27 ++++++++++++++++++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003..9c7e7f654a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -105,6 +105,7 @@ struct kvm_vcpu_init;
  * @init: filled in with the necessary values for creating a host
  * vcpu. If NULL is provided, will not init the vCPU (though the cpufd
  * will still be set up).
+ * @errp: Error handle
  *
  * Create a scratch vcpu in its own VM of the type preferred by the host
  * kernel (as would be used for '-cpu host'), for purposes of probing it
@@ -114,7 +115,7 @@ struct kvm_vcpu_init;
  * false on failure (and fdarray and init are not valid).
  */
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
-                                      struct kvm_vcpu_init *init);
+                                      struct kvm_vcpu_init *init, Error **errp);
 
 /**
  * kvm_arm_destroy_scratch_host_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index fc9551411e..c6ba2cb29a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -104,13 +104,14 @@ static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 }
 
 bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
-                                      struct kvm_vcpu_init *init)
+                                      struct kvm_vcpu_init *init, Error **errp)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
+        error_setg_errno(errp, errno, "Failed to open /dev/kvm");
         goto err;
     }
     max_vm_pa_size = ioctl(kvmfd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
@@ -121,6 +122,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
         vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
+        error_setg_errno(errp, errno, "Failed to create the scratch VM");
         goto err;
     }
 
@@ -140,6 +142,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 
     cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
     if (cpufd < 0) {
+        error_setg_errno(errp, errno, "Failed to create the scratch VCPU");
         goto err;
     }
 
@@ -153,12 +156,16 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 
         ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
         if (ret < 0) {
+            error_setg_errno(errp, errno,
+                             "Failed to get the preferred KVM target");
             goto err;
         }
         init->target = preferred.target;
     }
     ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
     if (ret < 0) {
+        error_setg_errno(errp, errno,
+                         "Failed to initialize the scratch VCPU");
         goto err;
     }
 
@@ -312,7 +319,8 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
 }
 
-static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+static bool
+kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf, Error **errp)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
@@ -330,6 +338,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->dtb_compatible = "arm,armv8";
 
     if (!kvm_enabled()) {
+        error_setg(errp, "KVM is not enabled");
         return false;
     }
 
@@ -371,7 +380,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         features |= 1ULL << ARM_FEATURE_PMU;
     }
 
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, &init, errp)) {
         return false;
     }
 
@@ -502,6 +511,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
     if (err < 0) {
+        error_setg(errp, "Failed to read some host CPU ID registers");
         return false;
     }
 
@@ -527,15 +537,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
-    static bool probe_ok;
+    static Error *probe_err;
 
     if (!arm_host_cpu_features.dtb_compatible) {
-        probe_ok = kvm_arm_get_host_cpu_features(&arm_host_cpu_features);
+        kvm_arm_get_host_cpu_features(&arm_host_cpu_features, &probe_err);
     }
 
-    if (!probe_ok) {
-        error_setg(&cpu->host_cpu_probe_err,
-                   "failed to retrieve host CPU features");
+    if (probe_err) {
+        cpu->host_cpu_probe_err = error_copy(probe_err);
         return;
     }
 
@@ -2671,7 +2680,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
     int fdarray[3];
 
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL, NULL)) {
         return;
     }
 
-- 
2.53.0


