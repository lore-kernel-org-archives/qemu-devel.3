Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E49DD374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCt-000769-4a; Thu, 17 Oct 2024 11:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCs-00075m-0i
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCq-00013e-1m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvgP017840;
 Thu, 17 Oct 2024 15:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=PXtvzfzl2yGZ7l+I4dGCA33x//L52uyZUNRRD8cVjlA=; b=
 NqPOk7iEjKz5ihtB3xzywnPON6KuFzjCaHP7hi5AP9fJmXMBh2oailQviA5/hJIK
 k0If/Ry0TkMh6TvzOIA/5qjsXfW3uswvMx9Ju47SPA0Q+AYWe7g9YMRTVfzblEVt
 nj+BLr6kzPerH6Jqu+kdzTDlLp4CQbGf1wPJg7acEUY3TydZ41HY/iMuZC9MaGUw
 O9vaWbLFCq12pgSX6X6LuLoWKTggfojtTozuXZXPTF4IV+JegAz3YHPjnZDpLcec
 98nOssIg/9Visq17M+xK2FTBQdlPWPOHxxffuI39+c/lBJps6a5/fcZxLE4R9nGd
 GrwoTdv8mwTOZwLmkINkHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntepyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HE1UQE027411; Thu, 17 Oct 2024 15:14:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy659-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgV017147;
 Thu, 17 Oct 2024 15:14:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-3; Thu, 17 Oct 2024 15:14:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 02/14] accel: accel preinit function
Date: Thu, 17 Oct 2024 08:14:03 -0700
Message-Id: <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-ORIG-GUID: wsrSyCv5AIDFOAELthL4hsZrAKytxc3L
X-Proofpoint-GUID: wsrSyCv5AIDFOAELthL4hsZrAKytxc3L
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extract the first part of the AccelState init_machine function into
a new function preinit, which can be called without knowing any
machine properties.  For now call preinit and init_machine at the
same place, so no functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 accel/accel-system.c        |  6 +++++
 accel/kvm/kvm-all.c         | 58 +++++++++++++++++++++++++++++----------------
 accel/xen/xen-all.c         | 11 ++++++---
 include/qemu/accel.h        |  1 +
 target/i386/nvmm/nvmm-all.c | 10 +++++++-
 target/i386/whpx/whpx-all.c | 14 +++++++----
 6 files changed, 70 insertions(+), 30 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947d..fef6625 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -36,8 +36,14 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
+    ret = acc->preinit(accel);
+    if (ret < 0) {
+        goto fail;
+    }
+
     ret = acc->init_machine(ms);
     if (ret < 0) {
+fail:
         ms->accelerator = NULL;
         *(acc->allowed) = false;
         object_unref(OBJECT(accel));
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 905fb84..c7c6001 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2484,6 +2484,42 @@ static int kvm_setup_dirty_ring(KVMState *s)
     return 0;
 }
 
+static int kvm_preinit(AccelState *accel)
+{
+    int ret;
+    KVMState *s = KVM_STATE(accel);
+
+    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
+    if (s->fd == -1) {
+        error_report("Could not access KVM kernel module: %m");
+        ret = -errno;
+        goto err;
+    }
+
+    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
+    if (ret < KVM_API_VERSION) {
+        if (ret >= 0) {
+            ret = -EINVAL;
+        }
+        fprintf(stderr, "kvm version too old\n");
+        goto err;
+    }
+
+    if (ret > KVM_API_VERSION) {
+        ret = -EINVAL;
+        error_report("kvm version not supported");
+        goto err;
+    }
+    return 0;
+
+err:
+    assert(ret < 0);
+    if (s->fd != -1) {
+        close(s->fd);
+    }
+    return ret;
+}
+
 static int kvm_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -2523,27 +2559,6 @@ static int kvm_init(MachineState *ms)
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
-    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
-    if (s->fd == -1) {
-        error_report("Could not access KVM kernel module: %m");
-        ret = -errno;
-        goto err;
-    }
-
-    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
-    if (ret < KVM_API_VERSION) {
-        if (ret >= 0) {
-            ret = -EINVAL;
-        }
-        error_report("kvm version too old");
-        goto err;
-    }
-
-    if (ret > KVM_API_VERSION) {
-        ret = -EINVAL;
-        error_report("kvm version not supported");
-        goto err;
-    }
 
     kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
@@ -3891,6 +3906,7 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
+    ac->preinit = kvm_preinit;
     ac->init_machine = kvm_init;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 0bdefce..dfcb90c 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -75,10 +75,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
     }
 }
 
-static int xen_init(MachineState *ms)
+static int xen_preinit(AccelState *accel)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-
     xen_xc = xc_interface_open(0, 0, 0);
     if (xen_xc == NULL) {
         xen_pv_printf(NULL, 0, "can't open xen interface\n");
@@ -97,6 +95,12 @@ static int xen_init(MachineState *ms)
         xc_interface_close(xen_xc);
         return -1;
     }
+    return 0;
+}
+
+static int xen_init(MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     /*
      * The XenStore write would fail when running restricted so don't attempt
@@ -125,6 +129,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
     };
 
     ac->name = "Xen";
+    ac->preinit = xen_preinit;
     ac->init_machine = xen_init;
     ac->setup_post = xen_setup_post;
     ac->allowed = &xen_allowed;
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 972a849..6b3b1cf 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -37,6 +37,7 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+    int (*preinit)(AccelState *accel);
     int (*init_machine)(MachineState *ms);
 #ifndef CONFIG_USER_ONLY
     void (*setup_post)(MachineState *ms, AccelState *accel);
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 65768ac..ce858a0 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
 /* -------------------------------------------------------------------------- */
 
 static int
-nvmm_accel_init(MachineState *ms)
+nvmm_accel_preinit(MachineState *ms)
 {
     int ret, err;
 
@@ -1178,6 +1178,13 @@ nvmm_accel_init(MachineState *ms)
         error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_size);
         return -EPROGMISMATCH;
     }
+    return 0;
+}
+
+static int
+nvmm_accel_init(MachineState *ms)
+{
+    int ret, err;
 
     ret = nvmm_machine_create(&qemu_mach.mach);
     if (ret == -1) {
@@ -1204,6 +1211,7 @@ nvmm_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "NVMM";
+    ac->preinit = nvmm_accel_preinit;
     ac->init_machine = nvmm_accel_init;
     ac->allowed = &nvmm_allowed;
 }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a6674a8..50bfc19 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2516,6 +2516,14 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
  * Partition support
  */
 
+static int whpx_accel_preinit(AccelState *accel)
+{
+    if (!init_whp_dispatch()) {
+        return -ENOSYS;
+    }
+    return 0;
+}
+
 static int whpx_accel_init(MachineState *ms)
 {
     struct whpx_state *whpx;
@@ -2529,11 +2537,6 @@ static int whpx_accel_init(MachineState *ms)
 
     whpx = &whpx_global;
 
-    if (!init_whp_dispatch()) {
-        ret = -ENOSYS;
-        goto error;
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -2713,6 +2716,7 @@ static void whpx_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "WHPX";
+    ac->preinit = whpx_accel_preinit;
     ac->init_machine = whpx_accel_init;
     ac->allowed = &whpx_allowed;
 
-- 
1.8.3.1


