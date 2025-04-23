Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6C4C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VAh-0000sD-Eg; Wed, 23 Apr 2025 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAe-0000qM-GR; Wed, 23 Apr 2025 04:09:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAb-0006l2-E8; Wed, 23 Apr 2025 04:09:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fjOd011160;
 Wed, 23 Apr 2025 08:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wPfWpY6nCth8EEUBZ
 g2fTAQQQeWSvx4d3k1SyLlEQkM=; b=SZjrSZwbitpV7LsVypG4XhTmd/AUe29ia
 NI1DJfM1rYrUY6YLBJl77iWEQtEl/2oLn90qGLeaK2abq6wZ4DzFGcZ66tfJODDG
 h73inhNk0FVt/rK3Irh7idIzWUrjD4JolZcftmP85jE6iWDdDtQUmQgozcuiJSgo
 snKYaBFdrKvv9UUuSw6ZLysdasfi2M/4TZR5hlVUHbmos2nz7NG4njfMe1x5k5Zk
 55iecx2I5Pk2ITfwsmUd5b64Lm5FZsdkXMxn1TcZPiU5kj+FTyCVoFVPi5PvQWMc
 nneBkRUArRKpTmGybuWfEdPEhyboUoVmR1PmmpbwY0Xk5ZLkJ2vnA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpe29mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6afYd022281;
 Wed, 23 Apr 2025 08:09:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxa3b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53N89Lud31326794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 08:09:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2D6058056;
 Wed, 23 Apr 2025 08:09:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2E675803F;
 Wed, 23 Apr 2025 08:09:20 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 08:09:20 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v5 3/3] target/s390x: Return UVC cmd code,
 RC and RRC value when DIAG 308 Subcode 10 fails to enter secure mode
Date: Wed, 23 Apr 2025 10:09:15 +0200
Message-ID: <20250423080915.1048123-4-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423080915.1048123-1-ggala@linux.ibm.com>
References: <20250423080915.1048123-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 84HvZ5V-iaimKW_cEbasJ18xXQ9wop_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NCBTYWx0ZWRfXzITRpOmIaqu6
 VNWWH70+duoiqAG7UdABUjaTzftZJpMfRLQM0IntvyNN9SgSwzbP5bv4Rqrp1uv9pH1RIekVbCj
 y+aRzCU1+i93VF3ADOY9rL4d8Mc2Fro3Ov7YGq/5DerWku5K+8agWzJ44uflrHbAw8Rw7HQ4Nx/
 OEkrpdM29bkdzmwXgaBuITiLXFH4zjjJKDEVS8LMjHRrMCO5T34DK6jH4zLGFSYZO7XumDybhS8
 GpCrEJU9/7PiOupZqCL9M8k005yoe0Az52dH5IOxJwa364Ma4f8ou1FSH1X89vIgYztvFZf4CTi
 UokjWltfN3ocfgpCSNZLxqszLAu4EC/Ek6P6fo7S7iviTUBkhAB4d++xh6IKymuUEH1d4r5ATia
 WOKZOjSO4s3cdTtDHFdWBotUqQ3I57U1iq10XfgljNmMtAV+MmfZojRo++mjlZ38p6NG1O8c
X-Proofpoint-GUID: 84HvZ5V-iaimKW_cEbasJ18xXQ9wop_l
X-Authority-Analysis: v=2.4 cv=IdWHWXqa c=1 sm=1 tr=0 ts=6808a033 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=LV91gym9Rfd1-J3rwfEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ggala@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
function does not complete successfully (in addition to the
previously returned diag response code in bit position 47-63).

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 hw/s390x/ipl.c             | 11 ++++----
 hw/s390x/ipl.h             |  6 +++--
 hw/s390x/s390-virtio-ccw.c | 14 ++++++-----
 target/s390x/kvm/pv.c      | 51 +++++++++++++++++++++++++++-----------
 target/s390x/kvm/pv.h      | 26 +++++++++++++------
 5 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ce6f6078d7..7829a39483 100644
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
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8e3882d506..e108aca369 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -18,6 +18,7 @@
 #include "hw/qdev-core.h"
 #include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
+#include "target/s390x/kvm/pv.h"
 
 #define DIAG308_FLAGS_LP_VALID 0x80
 #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
@@ -26,8 +27,9 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
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
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d9e683c5b4..942ebde94a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -364,7 +364,8 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
     ram_block_discard_disable(false);
 }
 
-static int s390_machine_protect(S390CcwMachineState *ms)
+static int s390_machine_protect(S390CcwMachineState *ms,
+                                struct S390PVResponse *pv_resp)
 {
     Error *local_err = NULL;
     int rc;
@@ -407,19 +408,19 @@ static int s390_machine_protect(S390CcwMachineState *ms)
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
@@ -451,6 +452,7 @@ static void s390_pv_prepare_reset(S390CcwMachineState *ms)
 static void s390_machine_reset(MachineState *machine, ResetType type)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
+    struct S390PVResponse pv_resp;
     enum s390_reset reset_type;
     CPUState *cs, *t;
     S390CPU *cpu;
@@ -539,8 +541,8 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
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
index 589038ad4e..399814a122 100644
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
diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index 5e9c8bd351..94e885e933 100644
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
-- 
2.49.0


