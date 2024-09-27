Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6979ECEBF60
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzDH-0004C7-E2; Thu, 26 Sep 2024 20:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzD4-0003Ml-AT; Thu, 26 Sep 2024 20:51:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzD2-0007Is-02; Thu, 26 Sep 2024 20:51:49 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QE9kbJ012810;
 Fri, 27 Sep 2024 00:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=uHfjc08pH5yLb
 8ntZWfcboGUsBWrGDBaZRK8l67cf4Y=; b=Vwp69ygCiVRwVS+snKcgnkJ5WlgF8
 jmACmMfYioln1SzJSWtKW0XuNTUe4z++ooG2CYxel3WCDy1STV/a0Ryr7XDNqWXp
 tc3k0NgaHY8PwlGd8fvkhDyv1sMXR8wy0uHfVDQZK13O5TZorYGcZ1kQYWHnY7Ie
 v9yUPK/FA2nsi3dcebB5rjv+yn1ph+AxnH7MwwhNi5xfn2+V1D+1saX92uDSO+72
 85qqhuryjzogK3xAW+GGDlZ68OqbyJ65uZ8W1N3BjgEdvx3LpnFl86eEv883sdQH
 h7qqTtINSYqb7Fj5A4x/+J8r5gPNeXuEOzZPi1qjkQIQ/uH3FJMfsFNBQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pW49006298;
 Fri, 27 Sep 2024 00:51:46 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QN2l5H020843;
 Fri, 27 Sep 2024 00:51:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb63htug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0phku29491760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A020A58056;
 Fri, 27 Sep 2024 00:51:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BAD758052;
 Fri, 27 Sep 2024 00:51:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:43 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 16/18] s390x: Rebuild IPLB for SCSI device directly from
 DIAG308
Date: Thu, 26 Sep 2024 20:51:15 -0400
Message-ID: <20240927005117.1679506-17-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LAhH2Au13pH-IdnU83BhulcnOFxTWFHb
X-Proofpoint-GUID: ExDmkUPhSt_qFimikMkMhwyo0nG_DHyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Because virtio-scsi type devices use a non-architected IPLB pbt code they cannot
be set and stored normally. Instead, the IPLB must be rebuilt during re-ipl.

As s390x does not natively support multiple boot devices, the devno field is
used to store the position in the boot order for the device.

Handling the rebuild as part of DIAG308 removes the need to check the devices
for invalid IPLBs later in the IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

---
 hw/s390x/ipl.h              |  11 ++--
 include/hw/s390x/ipl/qipl.h |   3 +-
 hw/s390x/ipl.c              | 104 ++++++++++--------------------------
 pc-bios/s390-ccw/jump2ipl.c |  11 ++--
 target/s390x/diag.c         |   9 +++-
 5 files changed, 54 insertions(+), 84 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index e4af8e3782..d1ebc384d8 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -24,6 +24,7 @@
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
+void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 int s390_ipl_prepare_pv_header(Error **errp);
 int s390_ipl_pv_unpack(void);
@@ -65,7 +66,8 @@ struct S390IPLState {
     bool enforce_bios;
     bool iplb_valid;
     bool iplb_valid_pv;
-    bool netboot;
+    bool rebuilt_iplb;
+    uint16_t iplb_index;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
     int reset_cpu_index;
@@ -172,11 +174,14 @@ static inline bool iplb_valid_pv(IplParameterBlock *iplb)
 
 static inline bool iplb_valid(IplParameterBlock *iplb)
 {
+    uint32_t len = be32_to_cpu(iplb->len);
+
     switch (iplb->pbt) {
     case S390_IPL_TYPE_FCP:
-        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
+        return len >= S390_IPLB_MIN_FCP_LEN;
     case S390_IPL_TYPE_CCW:
-        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
+        return (len >= S390_IPLB_MIN_CCW_LEN);
+    case S390_IPL_TYPE_QEMU_SCSI:
     default:
         return false;
     }
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 15342ac5cd..0f518adb62 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -28,7 +28,8 @@
  */
 struct QemuIplParameters {
     uint8_t  qipl_flags;
-    uint8_t  reserved1[3];
+    uint8_t  index;
+    uint8_t  reserved1[2];
     uint64_t reserved2;
     uint32_t boot_menu_timeout;
     uint8_t  reserved3[2];
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ba66847b9c..86c995b580 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -448,7 +448,6 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
 
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
-    S390IPLState *ipl = get_ipl_device();
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
@@ -481,9 +480,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
-            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
-            ipl->netboot = true;
-            /* Fall through to CCW_DEVTYPE_VIRTIO case */
         case CCW_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             iplb->blk0_len =
@@ -508,6 +504,16 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     return false;
 }
 
+
+void s390_rebuild_iplb(uint16_t dev_index, IplParameterBlock *iplb) {
+    S390IPLState *ipl = get_ipl_device();
+    uint16_t index;
+    index = ipl->rebuilt_iplb ? ipl->iplb_index : dev_index;
+
+    ipl->rebuilt_iplb = s390_build_iplb(get_boot_device(index), iplb);
+    ipl->iplb_index = index;
+}
+
 static bool s390_init_all_iplbs(S390IPLState *ipl)
 {
     int iplb_num = 0;
@@ -560,44 +566,6 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
     return iplb_num;
 }
 
-static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
-                                         int virtio_id)
-{
-    uint8_t cssid;
-    uint8_t ssid;
-    uint16_t devno;
-    uint16_t schid;
-    SubchDev *sch = NULL;
-
-    if (iplb->pbt != S390_IPL_TYPE_CCW) {
-        return false;
-    }
-
-    devno = be16_to_cpu(iplb->ccw.devno);
-    ssid = iplb->ccw.ssid & 3;
-
-    for (schid = 0; schid < MAX_SCHID; schid++) {
-        for (cssid = 0; cssid < MAX_CSSID; cssid++) {
-            sch = css_find_subch(1, cssid, ssid, schid);
-
-            if (sch && sch->devno == devno) {
-                return sch->id.cu_model == virtio_id;
-            }
-        }
-    }
-    return false;
-}
-
-static bool is_virtio_net_device(IplParameterBlock *iplb)
-{
-    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_NET);
-}
-
-static bool is_virtio_scsi_device(IplParameterBlock *iplb)
-{
-    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
-}
-
 static void update_machine_ipl_properties(IplParameterBlock *iplb)
 {
     Object *machine = qdev_get_machine();
@@ -637,7 +605,7 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
         ipl->iplb = *iplb;
         ipl->iplb_valid = true;
     }
-    ipl->netboot = is_virtio_net_device(iplb);
+
     update_machine_ipl_properties(iplb);
 }
 
@@ -661,35 +629,33 @@ IplParameterBlock *s390_ipl_get_iplb(void)
     return &ipl->iplb;
 }
 
-void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
+static void s390_ipl_prepare_qipl(S390CPU *cpu)
 {
     S390IPLState *ipl = get_ipl_device();
+    uint8_t *addr;
+    uint64_t len = 4096;
+
+    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
+    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
+        error_report("Cannot set QEMU IPL parameters");
+        return;
+    }
+
+    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
+    cpu_physical_memory_unmap(addr, len, 1, len);
+}
 
+void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
+{
+    S390IPLState *ipl = get_ipl_device();
     if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
         /* use CPU 0 for full resets */
         ipl->reset_cpu_index = 0;
     } else {
         ipl->reset_cpu_index = cs->cpu_index;
     }
-    ipl->reset_type = reset_type;
 
-    if (reset_type == S390_RESET_REIPL &&
-        ipl->iplb_valid &&
-        !ipl->netboot &&
-        ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
-        is_virtio_scsi_device(&ipl->iplb)) {
-        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), NULL);
-
-        if (ccw_dev &&
-            cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
-            (ccw_dev->sch->ssid & 3) == ipl->iplb.ccw.ssid) {
-            /*
-             * this is the original boot device's SCSI
-             * so restore IPL parameter info from it
-             */
-            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
-        }
-    }
+    ipl->reset_type = reset_type;
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
         reset_type == S390_RESET_LOAD_NORMAL ||
         reset_type == S390_RESET_PV) {
@@ -725,20 +691,6 @@ void s390_ipl_clear_reset_request(void)
     ipl->reset_cpu_index = 0;
 }
 
-static void s390_ipl_prepare_qipl(S390CPU *cpu)
-{
-    S390IPLState *ipl = get_ipl_device();
-    uint8_t *addr;
-    uint64_t len = 4096;
-
-    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
-    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
-        error_report("Cannot set QEMU IPL parameters");
-        return;
-    }
-    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
-    cpu_physical_memory_unmap(addr, len, 1, len);
-}
 
 int s390_ipl_prepare_pv_header(Error **errp)
 {
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index d45aec6694..bcf0e12f02 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -39,10 +39,15 @@ int jump_to_IPL_code(uint64_t address)
     write_subsystem_identification();
     write_iplb_location();
 
-    /* prevent unknown IPL types in the guest */
+    /*
+     * The IPLB for QEMU SCSI type devices must be rebuilt during re-ipl. The
+     * iplb.devno is set to the boot position of the target SCSI device.
+     */
     if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
-        iplb.pbt = S390_IPL_TYPE_CCW;
-        set_iplb(&iplb);
+        iplb.devno = qipl.index;
+        if (!set_iplb(&iplb)) {
+            panic("Failed to set IPLB");
+        }
     }
 
     /*
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 27ffd48576..a1fd54ddac 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -133,7 +133,14 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
-            env->regs[r1 + 1] = DIAG_308_RC_INVALID;
+            if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {
+                s390_rebuild_iplb(iplb->devno, iplb);
+                s390_ipl_update_diag308(iplb);
+                env->regs[r1 + 1] = DIAG_308_RC_OK;
+            } else {
+                env->regs[r1 + 1] = DIAG_308_RC_INVALID;
+            }
+
             goto out;
         }
 
-- 
2.45.1


