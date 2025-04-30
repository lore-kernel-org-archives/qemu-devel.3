Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A9C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWF-0003d7-IR; Wed, 30 Apr 2025 14:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWD-0003a5-AI
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWA-0008KL-V8
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJueaBAHsEGkETUqjZxxQ2XnzJ0ttLydobbuJHmlo9g=;
 b=XCnmCv8BycZdsLt8ul8AZKSgtFzJS/q7UIfkZdWdkdfNxuaY1sU1Twa0y3b7EnL+uP2n94
 4GxGoPoHTbtZzdFs56VzHkLyb3/FXFETk5qAD3B1eYtkmGDiITE+ACfmyqMu+JqaGJ0q1x
 ufssSGI3watoc8soo96E9p1UIHXM7vM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-6GgasH_TP2mUTmp81gDVFw-1; Wed,
 30 Apr 2025 14:50:48 -0400
X-MC-Unique: 6GgasH_TP2mUTmp81gDVFw-1
X-Mimecast-MFC-AGG-ID: 6GgasH_TP2mUTmp81gDVFw_1746039047
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F06E180048E; Wed, 30 Apr 2025 18:50:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F6E819560A3; Wed, 30 Apr 2025 18:50:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: [PULL 3/9] target/s390x: Return UVC cmd code,
 RC and RRC value when DIAG 308 Subcode 10 fails to enter secure mode
Date: Wed, 30 Apr 2025 20:50:29 +0200
Message-ID: <20250430185035.724919-4-thuth@redhat.com>
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gautam Gala <ggala@linux.ibm.com>

Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
function does not complete successfully (in addition to the
previously returned diag response code in bit position 47-63).

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Message-ID: <20250423080915.1048123-4-ggala@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.h             |  6 +++--
 target/s390x/kvm/pv.h      | 26 +++++++++++++------
 hw/s390x/ipl.c             | 11 ++++----
 hw/s390x/s390-virtio-ccw.c | 14 ++++++-----
 target/s390x/kvm/pv.c      | 51 +++++++++++++++++++++++++++-----------
 5 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index cb55101f062..505cded490c 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -20,6 +20,7 @@
 #include "hw/qdev-core.h"
 #include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
+#include "target/s390x/kvm/pv.h"
 
 #define DIAG308_FLAGS_LP_VALID 0x80
 #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
@@ -28,8 +29,9 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
 void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
-int s390_ipl_prepare_pv_header(Error **errp);
-int s390_ipl_pv_unpack(void);
+int s390_ipl_prepare_pv_header(struct S390PVResponse *pv_resp,
+                               Error **errp);
+int s390_ipl_pv_unpack(struct S390PVResponse *pv_resp);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
 IplParameterBlock *s390_ipl_get_iplb_pv(void);
diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 5e9c8bd3510..94e885e9335 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -16,6 +16,12 @@
 #include "system/kvm.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
+struct S390PVResponse {
+    uint16_t cmd;
+    uint16_t rrc;
+    uint16_t rc;
+};
+
 #ifdef CONFIG_KVM
 #include "cpu.h"
 
@@ -42,12 +48,15 @@ int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
 bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms);
-int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp);
-int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          struct S390PVResponse *pv_resp, Error **errp);
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
+                   struct S390PVResponse *pv_resp);
 void s390_pv_prep_reset(void);
-int s390_pv_verify(void);
+int s390_pv_verify(struct S390PVResponse *pv_resp);
 void s390_pv_unshare(void);
-void s390_pv_inject_reset_error(CPUState *cs);
+void s390_pv_inject_reset_error(CPUState *cs,
+                                struct S390PVResponse pv_resp);
 uint64_t kvm_s390_pv_dmp_get_size_cpu(void);
 uint64_t kvm_s390_pv_dmp_get_size_mem_state(void);
 uint64_t kvm_s390_pv_dmp_get_size_completion_data(void);
@@ -63,12 +72,15 @@ static inline int s390_pv_vm_enable(void) { return 0; }
 static inline void s390_pv_vm_disable(void) {}
 static inline bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms) { return false; }
 static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                                        struct S390PVResponse *pv_resp,
                                         Error **errp) { return 0; }
-static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0; }
+static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak,
+                                 struct S390PVResponse *pv_resp) { return 0; }
 static inline void s390_pv_prep_reset(void) {}
-static inline int s390_pv_verify(void) { return 0; }
+static inline int s390_pv_verify(struct S390PVResponse *pv_resp) { return 0; }
 static inline void s390_pv_unshare(void) {}
-static inline void s390_pv_inject_reset_error(CPUState *cs) {};
+static inline void s390_pv_inject_reset_error(CPUState *cs,
+                                              struct S390PVResponse pv_resp) {};
 static inline uint64_t kvm_s390_pv_dmp_get_size_cpu(void) { return 0; }
 static inline uint64_t kvm_s390_pv_dmp_get_size_mem_state(void) { return 0; }
 static inline uint64_t kvm_s390_pv_dmp_get_size_completion_data(void) { return 0; }
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 716a6b78694..2f082396c73 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -26,7 +26,6 @@
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
-#include "target/s390x/kvm/pv.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-net.h"
 #include "ipl.h"
@@ -676,7 +675,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
-int s390_ipl_prepare_pv_header(Error **errp)
+int s390_ipl_prepare_pv_header(struct S390PVResponse *pv_resp, Error **errp)
 {
     IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
     IPLBlockPV *ipib_pv = &ipib->pv;
@@ -685,12 +684,13 @@ int s390_ipl_prepare_pv_header(Error **errp)
 
     cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
                              ipib_pv->pv_header_len);
-    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
+    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len,
+                               pv_resp, errp);
     g_free(hdr);
     return rc;
 }
 
-int s390_ipl_pv_unpack(void)
+int s390_ipl_pv_unpack(struct S390PVResponse *pv_resp)
 {
     IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
     IPLBlockPV *ipib_pv = &ipib->pv;
@@ -699,7 +699,8 @@ int s390_ipl_pv_unpack(void)
     for (i = 0; i < ipib_pv->num_comp; i++) {
         rc = s390_pv_unpack(ipib_pv->components[i].addr,
                             TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
-                            ipib_pv->components[i].tweak_pref);
+                            ipib_pv->components[i].tweak_pref,
+                            pv_resp);
         if (rc) {
             break;
         }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 94edd42dd25..d5658afed96 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -365,7 +365,8 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
     ram_block_discard_disable(false);
 }
 
-static int s390_machine_protect(S390CcwMachineState *ms)
+static int s390_machine_protect(S390CcwMachineState *ms,
+                                struct S390PVResponse *pv_resp)
 {
     Error *local_err = NULL;
     int rc;
@@ -408,19 +409,19 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     }
 
     /* Set SE header and unpack */
-    rc = s390_ipl_prepare_pv_header(&local_err);
+    rc = s390_ipl_prepare_pv_header(pv_resp, &local_err);
     if (rc) {
         goto out_err;
     }
 
     /* Decrypt image */
-    rc = s390_ipl_pv_unpack();
+    rc = s390_ipl_pv_unpack(pv_resp);
     if (rc) {
         goto out_err;
     }
 
     /* Verify integrity */
-    rc = s390_pv_verify();
+    rc = s390_pv_verify(pv_resp);
     if (rc) {
         goto out_err;
     }
@@ -452,6 +453,7 @@ static void s390_pv_prepare_reset(S390CcwMachineState *ms)
 static void s390_machine_reset(MachineState *machine, ResetType type)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
+    struct S390PVResponse pv_resp;
     enum s390_reset reset_type;
     CPUState *cs, *t;
     S390CPU *cpu;
@@ -540,8 +542,8 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
         }
         run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
 
-        if (s390_machine_protect(ms)) {
-            s390_pv_inject_reset_error(cs);
+        if (s390_machine_protect(ms, &pv_resp)) {
+            s390_pv_inject_reset_error(cs, pv_resp);
             /*
              * Continue after the diag308 so the guest knows something
              * went wrong.
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 30b64f7f22e..2bc916a5455 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -30,7 +30,7 @@ static struct kvm_s390_pv_info_vm info_vm;
 static struct kvm_s390_pv_info_dump info_dump;
 
 static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
-                         int *pvrc)
+                         struct S390PVResponse *pv_resp)
 {
     struct kvm_pv_cmd pv_cmd = {
         .cmd = cmd,
@@ -47,8 +47,10 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
                      "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
                      rc);
     }
-    if (pvrc) {
-        *pvrc = pv_cmd.rc;
+    if (pv_resp) {
+        pv_resp->cmd = cmd;
+        pv_resp->rc = pv_cmd.rc;
+        pv_resp->rrc = pv_cmd.rrc;
     }
     return rc;
 }
@@ -57,8 +59,9 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
  * This macro lets us pass the command as a string to the function so
  * we can print it on an error.
  */
-#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
-#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
+#define s390_pv_cmd(cmd, data)  __s390_pv_cmd(cmd, #cmd, data, NULL)
+#define s390_pv_cmd_pv_resp(cmd, data, pv_resp) \
+                                __s390_pv_cmd(cmd, #cmd, data, pv_resp)
 
 static void s390_pv_cmd_exit(uint32_t cmd, void *data)
 {
@@ -146,18 +149,19 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
 }
 
 #define UV_RC_SSC_INVAL_HOSTKEY    0x0108
-int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          struct S390PVResponse *pv_resp, Error **errp)
 {
-    int ret, pvrc;
+    int ret;
     struct kvm_s390_pv_sec_parm args = {
         .origin = origin,
         .length = length,
     };
 
-    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
+    ret = s390_pv_cmd_pv_resp(KVM_PV_SET_SEC_PARMS, &args, pv_resp);
     if (ret) {
         error_setg(errp, "Failed to set secure execution parameters");
-        if (pvrc == UV_RC_SSC_INVAL_HOSTKEY) {
+        if (pv_resp->rc == UV_RC_SSC_INVAL_HOSTKEY) {
             error_append_hint(errp, "Please check whether the image is "
                                     "correctly encrypted for this host\n");
         }
@@ -169,7 +173,8 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
 /*
  * Called for each component in the SE type IPL parameter block 0.
  */
-int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
+int s390_pv_unpack(uint64_t addr, uint64_t size,
+                   uint64_t tweak, struct S390PVResponse *pv_resp)
 {
     struct kvm_s390_pv_unp args = {
         .addr = addr,
@@ -177,7 +182,7 @@ int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
         .tweak = tweak,
     };
 
-    return s390_pv_cmd(KVM_PV_UNPACK, &args);
+    return s390_pv_cmd_pv_resp(KVM_PV_UNPACK, &args, pv_resp);
 }
 
 void s390_pv_prep_reset(void)
@@ -185,9 +190,9 @@ void s390_pv_prep_reset(void)
     s390_pv_cmd_exit(KVM_PV_PREP_RESET, NULL);
 }
 
-int s390_pv_verify(void)
+int s390_pv_verify(struct S390PVResponse *pv_resp)
 {
-    return s390_pv_cmd(KVM_PV_VERIFY, NULL);
+    return s390_pv_cmd_pv_resp(KVM_PV_VERIFY, NULL, pv_resp);
 }
 
 void s390_pv_unshare(void)
@@ -195,13 +200,29 @@ void s390_pv_unshare(void)
     s390_pv_cmd_exit(KVM_PV_UNSHARE_ALL, NULL);
 }
 
-void s390_pv_inject_reset_error(CPUState *cs)
+void s390_pv_inject_reset_error(CPUState *cs,
+                                struct S390PVResponse pv_resp)
 {
     int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
     CPUS390XState *env = &S390_CPU(cs)->env;
 
+    union {
+        struct {
+            uint16_t pv_cmd;
+            uint16_t pv_rrc;
+            uint16_t pv_rc;
+            uint16_t diag_rc;
+        };
+        uint64_t regs;
+    } resp = {
+              .pv_cmd = pv_resp.cmd,
+              .pv_rrc = pv_resp.rrc,
+              .pv_rc = pv_resp.rc,
+              .diag_rc = DIAG_308_RC_INVAL_FOR_PV
+             };
+
     /* Report that we are unable to enter protected mode */
-    env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
+    env->regs[r1 + 1] = resp.regs;
 }
 
 uint64_t kvm_s390_pv_dmp_get_size_cpu(void)
-- 
2.49.0


