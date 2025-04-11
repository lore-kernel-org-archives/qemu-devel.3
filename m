Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F1C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 09:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ab0-0006hD-9u; Fri, 11 Apr 2025 05:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u3Aay-0006gC-Bh; Fri, 11 Apr 2025 05:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u3Aaw-00066a-0k; Fri, 11 Apr 2025 05:22:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3k9Gq027448;
 Fri, 11 Apr 2025 09:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gcwVRxPWOuhO4Ow+a
 bXOxZj4AJ3bKeX4KzQ5Jh/fVoA=; b=CzRKTBtCCxDOAPsVmANWCJ+Nuo+VGHIAd
 NA/tdvV5W51qR99hZcLginQS8XPJRg+tSLqiYVGrBQLZyIszm1Z9hiJcrP7O9npZ
 zPAW88cTnBOR5CJHRTPuETSArmAd5jYEyOy2i5IrgNKTwde82Ju4BI+qGqIBtjy/
 gIOsLbloHunlEUSEzuiH+mIVBLjdaqWnVJaZBob5G0byTDLdtcUnlDRfYsSf4nLL
 lINmq5U4Jz6j1/uM4UpfAGZ2mSJPJfnuRI0Lw1YEBu+E5zHfjh4o8IrKne1BzigA
 J2prrta73ck2v4hXSRkcXaKSOR4Z3m/LcqoA0082igBsr7gcDg53g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufa9dc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 09:22:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53B8bP9r024651;
 Fri, 11 Apr 2025 09:22:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutth09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 09:22:39 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53B9Mcnv14287496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 09:22:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C88758056;
 Fri, 11 Apr 2025 09:22:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 554C658063;
 Fri, 11 Apr 2025 09:22:37 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Apr 2025 09:22:37 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 3/3] target/s390x: Return UVC cmd code,
 RC and RRC value when DIAG 308 Subcode 10 fails to enter secure mode
Date: Fri, 11 Apr 2025 11:22:33 +0200
Message-ID: <20250411092233.418164-4-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411092233.418164-1-ggala@linux.ibm.com>
References: <20250411092233.418164-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3jHP-Pt3p_CxPJfnEPCRV7t3HGwyzZDJ
X-Proofpoint-ORIG-GUID: 3jHP-Pt3p_CxPJfnEPCRV7t3HGwyzZDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
function does not complete successfully (in addition to the
previously returned diag response code in bit position 47-63).

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 hw/s390x/ipl.c             | 11 ++++++----
 hw/s390x/ipl.h             |  5 +++--
 hw/s390x/s390-virtio-ccw.c | 24 +++++++++++++++------
 target/s390x/kvm/pv.c      | 44 +++++++++++++++++++++++++-------------
 target/s390x/kvm/pv.h      | 27 ++++++++++++++++-------
 5 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ce6f6078d7..4f3e3945f1 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -676,7 +676,8 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
-int s390_ipl_prepare_pv_header(Error **errp)
+int s390_ipl_prepare_pv_header(Error **errp, uint16_t *pv_cmd,
+                               uint16_t *pv_rc, uint16_t *pv_rrc)
 {
     IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
     IPLBlockPV *ipib_pv = &ipib->pv;
@@ -685,12 +686,13 @@ int s390_ipl_prepare_pv_header(Error **errp)
 
     cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
                              ipib_pv->pv_header_len);
-    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
+    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len,
+                               errp, pv_cmd, pv_rc, pv_rrc);
     g_free(hdr);
     return rc;
 }
 
-int s390_ipl_pv_unpack(void)
+int s390_ipl_pv_unpack(uint16_t *pv_cmd, uint16_t *pv_rc, uint16_t *pv_rrc)
 {
     IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
     IPLBlockPV *ipib_pv = &ipib->pv;
@@ -699,7 +701,8 @@ int s390_ipl_pv_unpack(void)
     for (i = 0; i < ipib_pv->num_comp; i++) {
         rc = s390_pv_unpack(ipib_pv->components[i].addr,
                             TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
-                            ipib_pv->components[i].tweak_pref);
+                            ipib_pv->components[i].tweak_pref,
+                            pv_cmd, pv_rc, pv_rrc);
         if (rc) {
             break;
         }
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8e3882d506..e021b2431f 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -26,8 +26,9 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
 void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
-int s390_ipl_prepare_pv_header(Error **errp);
-int s390_ipl_pv_unpack(void);
+int s390_ipl_prepare_pv_header(Error **errp, uint16_t *pv_cmd,
+                               uint16_t *pv_rc, uint16_t *pv_rrc);
+int s390_ipl_pv_unpack(uint16_t *pv_cmd, uint16_t *pv_rc, uint16_t *pv_rrc);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
 IplParameterBlock *s390_ipl_get_iplb_pv(void);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d9e683c5b4..0faf2841d6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -53,6 +53,13 @@
 
 static Error *pv_mig_blocker;
 
+struct diag308response {
+    uint16_t pv_cmd;
+    uint16_t pv_rrc;
+    uint16_t pv_rc;
+    uint16_t diag_rc;
+};
+
 static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
                               Error **errp)
 {
@@ -364,7 +371,10 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
     ram_block_discard_disable(false);
 }
 
-static int s390_machine_protect(S390CcwMachineState *ms)
+static int s390_machine_protect(S390CcwMachineState *ms,
+                                uint16_t *pv_cmd,
+                                uint16_t *pv_rc,
+                                uint16_t *pv_rrc)
 {
     Error *local_err = NULL;
     int rc;
@@ -407,19 +417,19 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     }
 
     /* Set SE header and unpack */
-    rc = s390_ipl_prepare_pv_header(&local_err);
+    rc = s390_ipl_prepare_pv_header(&local_err, pv_cmd, pv_rc, pv_rrc);
     if (rc) {
         goto out_err;
     }
 
     /* Decrypt image */
-    rc = s390_ipl_pv_unpack();
+    rc = s390_ipl_pv_unpack(pv_cmd, pv_rc, pv_rrc);
     if (rc) {
         goto out_err;
     }
 
     /* Verify integrity */
-    rc = s390_pv_verify();
+    rc = s390_pv_verify(pv_cmd, pv_rc, pv_rrc);
     if (rc) {
         goto out_err;
     }
@@ -452,6 +462,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     enum s390_reset reset_type;
+    struct diag308response resp;
     CPUState *cs, *t;
     S390CPU *cpu;
 
@@ -539,8 +550,9 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
         }
         run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
 
-        if (s390_machine_protect(ms)) {
-            s390_pv_inject_reset_error(cs);
+        if (s390_machine_protect(ms, &resp.pv_cmd, &resp.pv_rc, &resp.pv_rrc)) {
+            resp.diag_rc = DIAG_308_RC_INVAL_FOR_PV;
+            s390_pv_inject_reset_error(cs, (uint64_t *)(&resp));
             /*
              * Continue after the diag308 so the guest knows something
              * went wrong.
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index b4abda2cef..3c69f6e74b 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -30,7 +30,7 @@ static struct kvm_s390_pv_info_vm info_vm;
 static struct kvm_s390_pv_info_dump info_dump;
 
 static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
-                         int *pvrc)
+                         uint16_t *pv_rc, uint16_t *pv_rrc)
 {
     struct kvm_pv_cmd pv_cmd = {
         .cmd = cmd,
@@ -47,9 +47,13 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
                      "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
                      rc);
     }
-    if (pvrc) {
-        *pvrc = pv_cmd.rc;
+    if (pv_rc) {
+        *pv_rc = pv_cmd.rc;
     }
+    if (pv_rrc) {
+        *pv_rrc = pv_cmd.rrc;
+    }
+
     return rc;
 }
 
@@ -57,8 +61,11 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
  * This macro lets us pass the command as a string to the function so
  * we can print it on an error.
  */
-#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
-#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
+#define s390_pv_cmd(cmd, data)  __s390_pv_cmd(cmd, #cmd, data, NULL, NULL)
+#define s390_pv_cmd_pvrc(cmd, data, pv_rc) \
+                                __s390_pv_cmd(cmd, #cmd, data, pv_rc, NULL)
+#define s390_pv_cmd_pvrc_pvrrc(cmd, data, pv_rc, pv_rrc) \
+                                __s390_pv_cmd(cmd, #cmd, data, pv_rc, pv_rrc)
 
 static void s390_pv_cmd_exit(uint32_t cmd, void *data)
 {
@@ -149,18 +156,21 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
 }
 
 #define DIAG_308_UV_RC_INVAL_HOSTKEY    0x0108
-int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          Error **errp, uint16_t *pv_cmd,
+                          uint16_t *pv_rc, uint16_t *pv_rrc)
 {
-    int ret, pvrc;
+    int ret;
     struct kvm_s390_pv_sec_parm args = {
         .origin = origin,
         .length = length,
     };
 
-    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
+    *pv_cmd = KVM_PV_SET_SEC_PARMS;
+    ret = s390_pv_cmd_pvrc_pvrrc(*pv_cmd, &args, pv_rc, pv_rrc);
     if (ret) {
         error_setg(errp, "Failed to set secure execution parameters");
-        if (pvrc == DIAG_308_UV_RC_INVAL_HOSTKEY) {
+        if (*pv_rc == DIAG_308_UV_RC_INVAL_HOSTKEY) {
             error_append_hint(errp, "Please check whether the image is "
                                     "correctly encrypted for this host\n");
         }
@@ -172,7 +182,9 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
 /*
  * Called for each component in the SE type IPL parameter block 0.
  */
-int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
+int s390_pv_unpack(uint64_t addr, uint64_t size,
+                   uint64_t tweak, uint16_t *pv_cmd,
+                   uint16_t *pv_rc, uint16_t *pv_rrc)
 {
     struct kvm_s390_pv_unp args = {
         .addr = addr,
@@ -180,7 +192,8 @@ int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
         .tweak = tweak,
     };
 
-    return s390_pv_cmd(KVM_PV_UNPACK, &args);
+    *pv_cmd = KVM_PV_UNPACK;
+    return s390_pv_cmd_pvrc_pvrrc(*pv_cmd, &args, pv_rc, pv_rrc);
 }
 
 void s390_pv_prep_reset(void)
@@ -188,9 +201,10 @@ void s390_pv_prep_reset(void)
     s390_pv_cmd_exit(KVM_PV_PREP_RESET, NULL);
 }
 
-int s390_pv_verify(void)
+int s390_pv_verify(uint16_t *pv_cmd, uint16_t *pv_rc, uint16_t *pv_rrc)
 {
-    return s390_pv_cmd(KVM_PV_VERIFY, NULL);
+    *pv_cmd = KVM_PV_VERIFY;
+    return s390_pv_cmd_pvrc_pvrrc(*pv_cmd, NULL, pv_rc, pv_rrc);
 }
 
 void s390_pv_unshare(void)
@@ -198,13 +212,13 @@ void s390_pv_unshare(void)
     s390_pv_cmd_exit(KVM_PV_UNSHARE_ALL, NULL);
 }
 
-void s390_pv_inject_reset_error(CPUState *cs)
+void s390_pv_inject_reset_error(CPUState *cs, uint64_t *resp)
 {
     int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
     CPUS390XState *env = &S390_CPU(cs)->env;
 
     /* Report that we are unable to enter protected mode */
-    env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
+    env->regs[r1 + 1] = *resp;
 }
 
 uint64_t kvm_s390_pv_dmp_get_size_cpu(void)
diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 5e9c8bd351..7c003d1e28 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -42,12 +42,16 @@ int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
 bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms);
-int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp);
-int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
+                          Error **errp, uint16_t *pv_cmd,
+                          uint16_t *pv_rc, uint16_t *pv_rrc);
+int s390_pv_unpack(uint64_t addr, uint64_t size,
+                   uint64_t tweak, uint16_t *pv_cmd,
+                   uint16_t *pv_rc, uint16_t *pv_rrc);
 void s390_pv_prep_reset(void);
-int s390_pv_verify(void);
+int s390_pv_verify(uint16_t *pv_cmd, uint16_t *pv_rc, uint16_t *pv_rrc);
 void s390_pv_unshare(void);
-void s390_pv_inject_reset_error(CPUState *cs);
+void s390_pv_inject_reset_error(CPUState *cs, uint64_t *resp);
 uint64_t kvm_s390_pv_dmp_get_size_cpu(void);
 uint64_t kvm_s390_pv_dmp_get_size_mem_state(void);
 uint64_t kvm_s390_pv_dmp_get_size_completion_data(void);
@@ -63,12 +67,19 @@ static inline int s390_pv_vm_enable(void) { return 0; }
 static inline void s390_pv_vm_disable(void) {}
 static inline bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms) { return false; }
 static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length,
-                                        Error **errp) { return 0; }
-static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0; }
+                                        Error **errp, uint16_t *pv_cmd,
+                                        uint16_t *pv_rc, uint16_t *pv_rrc)
+                                        { return 0; }
+static inline int s390_pv_unpack(uint64_t addr, uint64_t size,
+                                 uint64_t tweak, uint16_t *pv_cmd,
+                                 uint16_t *pv_rc, uint16_t *pv_rrc)
+                                 { return 0; }
 static inline void s390_pv_prep_reset(void) {}
-static inline int s390_pv_verify(void) { return 0; }
+static inline int s390_pv_verify(uint16_t *pv_cmd,
+                                 uint16_t *pv_rc,
+                                 uint16_t *pv_rrc) { return 0; }
 static inline void s390_pv_unshare(void) {}
-static inline void s390_pv_inject_reset_error(CPUState *cs) {};
+static inline void s390_pv_inject_reset_error(CPUState *cs, uint64_t *resp) {};
 static inline uint64_t kvm_s390_pv_dmp_get_size_cpu(void) { return 0; }
 static inline uint64_t kvm_s390_pv_dmp_get_size_mem_state(void) { return 0; }
 static inline uint64_t kvm_s390_pv_dmp_get_size_completion_data(void) { return 0; }
-- 
2.49.0


