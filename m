Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B15CC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLSc-0005lt-2v; Wed, 29 May 2024 11:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSa-0005kG-DT; Wed, 29 May 2024 11:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSY-0006xR-2y; Wed, 29 May 2024 11:43:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TFgU6g027322; Wed, 29 May 2024 15:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=Qnk4AOc8ry9Ao+8TO63Bu1ceY2ulkAuquFQlrY66fa8=;
 b=lLG0YuLvTuD96GFHcGjEfyC1gn0u+SILYGupcHuvh9Q0YSu9Pw4AXRwbrSj60Desa0dg
 XR58yHmsqiJgKLOraPdlfBBX8G7PgsCeC0gkCKAsDp+lhVnu4N67cBMWvDK33KXqi50y
 m44xWvpovE+03IpFy1iAVADM0SOP44eh+A/Y5y3o6JSCcn4Dr+2oHa/i7/mDghRGk419
 KIKfkKntT/mwsDlaq4oLFPr1T3OsEJfIa8/QAl8q6HyJTCcPbiws3eyGPZB9np0G3D69
 6n6ZGY6HM1KhuQyMld2Gk6o48vp3jUa9EJPi/aigXC45ZmzlT8aitRY4qtjNC0SMyDT7 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye77w802y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:23 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TFhNp6029107;
 Wed, 29 May 2024 15:43:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye77w802t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TFNN2X024784; Wed, 29 May 2024 15:43:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydphqmgau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TFhJOj25297462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 15:43:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02E8D58072;
 Wed, 29 May 2024 15:43:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A4B05806F;
 Wed, 29 May 2024 15:43:18 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.67.55.69])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 May 2024 15:43:18 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 3/5] s390x: Build IPLB chain for multiple boot devices
Date: Wed, 29 May 2024 11:43:09 -0400
Message-Id: <20240529154311.734548-4-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240529154311.734548-1-jrossi@linux.ibm.com>
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LPQvYRdmJIj8Z-xl0sMGEvGMKIW_sx6x
X-Proofpoint-ORIG-GUID: tm7L3z210Ie8ZWRdLZ15htiYc7e-13A2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Write a chain of IPLBs into memory for future use.

The IPLB chain is placed immediately before the BIOS in memory at the highest
unused page boundary providing sufficient space to fit the chain. Because this
is not a fixed address, the location of the next IPLB and number of remaining
boot devices is stored in the QIPL global variable for later access.

At this stage the IPLB chain is not accessed by the guest during IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h              |   1 +
 include/hw/s390x/ipl/qipl.h |   4 +-
 hw/s390x/ipl.c              | 129 +++++++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 1dcb8984bb..4f098d3a81 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -20,6 +20,7 @@
 #include "qom/object.h"
 
 #define DIAG308_FLAGS_LP_VALID 0x80
+#define MAX_IPLB_CHAIN 7
 
 void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index a6ce6ddfe3..481c459a53 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -34,7 +34,9 @@ struct QemuIplParameters {
     uint8_t  reserved1[3];
     uint64_t netboot_start_addr;
     uint32_t boot_menu_timeout;
-    uint8_t  reserved2[12];
+    uint8_t  reserved2[2];
+    uint16_t num_iplbs;
+    uint64_t next_iplb;
 }  QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2d4f5152b3..79429acabd 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -55,6 +55,13 @@ static bool iplb_extended_needed(void *opaque)
     return ipl->iplbext_migration;
 }
 
+/* Start IPLB chain from the boundary of the first unused page before BIOS */
+static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t count)
+{
+    return (bios_addr & TARGET_PAGE_MASK)
+            - (count * sizeof(IplParameterBlock));
+}
+
 static const VMStateDescription vmstate_iplb_extended = {
     .name = "ipl/iplb_extended",
     .version_id = 0,
@@ -391,6 +398,17 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
     return ccw_dev;
 }
 
+static void s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
+{
+    S390IPLState *ipl = get_ipl_device();
+    uint16_t count = ipl->qipl.num_iplbs;
+    uint64_t len = sizeof(IplParameterBlock) * count;
+    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
+
+    cpu_physical_memory_write(chain_addr, iplb_chain, be32_to_cpu(len));
+    ipl->qipl.next_iplb = chain_addr;
+}
+
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
 {
     int i;
@@ -422,54 +440,51 @@ void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
     }
 }
 
-static bool s390_gen_initial_iplb(S390IPLState *ipl)
+static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
-    DeviceState *dev_st;
+    S390IPLState *ipl = get_ipl_device();
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
     uint8_t *lp;
 
-    dev_st = get_boot_device(0);
-    if (dev_st) {
-        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
-    }
-
     /*
      * Currently allow IPL only from CCW devices.
      */
+    ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
         lp = ccw_dev->loadparm;
 
-        switch (devtype) {
-        case CCW_DEVTYPE_SCSI:
+         switch (devtype) {
+         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
-            ipl->iplb.blk0_len =
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
+            iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_QEMU_SCSI;
-            ipl->iplb.scsi.lun = cpu_to_be32(sd->lun);
-            ipl->iplb.scsi.target = cpu_to_be16(sd->id);
-            ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
-            ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
+            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
+            iplb->scsi.lun = cpu_to_be32(sd->lun);
+            iplb->scsi.target = cpu_to_be16(sd->id);
+            iplb->scsi.channel = cpu_to_be16(sd->channel);
+            iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VFIO:
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
-            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->pbt = S390_IPL_TYPE_CCW;
+            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
+            /* The S390IPLState netboot is ture if ANY IPLB may use netboot */
             ipl->netboot = true;
             /* Fall through to CCW_DEVTYPE_VIRTIO case */
         case CCW_DEVTYPE_VIRTIO:
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
-            ipl->iplb.blk0_len =
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
-            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            iplb->pbt = S390_IPL_TYPE_CCW;
+            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         }
 
@@ -478,8 +493,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         }
 
-        s390_ipl_set_loadparm((char *)lp, ipl->iplb.loadparm);
-        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+        s390_ipl_set_loadparm((char *)lp, iplb->loadparm);
+        iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
         return true;
     }
@@ -487,6 +502,58 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
     return false;
 }
 
+static bool s390_init_all_iplbs(S390IPLState *ipl)
+{
+    int iplb_num = 0;
+    IplParameterBlock iplb_chain[7];
+    DeviceState *dev_st = get_boot_device(0);
+
+    /*
+     * Parse the boot devices.  Generate an IPLB for the first boot device,
+     * which will later be set with DIAG308. Index any fallback boot devices.
+     */
+    if (!dev_st) {
+        ipl->qipl.num_iplbs = 0;
+        return false;
+    }
+
+    iplb_num = 1;
+    s390_build_iplb(dev_st, &ipl->iplb);
+    ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+
+    while (get_boot_device(iplb_num)) {
+        iplb_num++;
+    }
+
+    ipl->qipl.num_iplbs = iplb_num - 1;
+
+    /*
+     * Build fallback IPLBs for any boot devices above index 0, up to a
+     * maximum amount as defined in ipl.h
+     */
+    if (iplb_num > 1) {
+        if (iplb_num > MAX_IPLB_CHAIN) {
+            warn_report("Excess boot devices defined! %d boot devices found, "
+                        "but only the first %d will be considered.",
+                        iplb_num, MAX_IPLB_CHAIN + 1);
+            iplb_num = MAX_IPLB_CHAIN + 1;
+        }
+
+        ipl->qipl.num_iplbs = iplb_num - 1;
+
+        /* Start at 1 because the IPLB for boot index 0 is not chained */
+        for (int i = 1; i < iplb_num; i++) {
+            dev_st = get_boot_device(i);
+            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
+            iplb_chain[i - 1].flags |= DIAG308_FLAGS_LP_VALID;
+        }
+
+        s390_ipl_map_iplb_chain(iplb_chain);
+    }
+
+    return iplb_num;
+}
+
 static int load_netboot_image(Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -664,7 +731,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
              * this is the original boot device's SCSI
              * so restore IPL parameter info from it
              */
-            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
         }
     }
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
@@ -758,7 +825,9 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
         if (!ipl->iplb_valid) {
-            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+            ipl->iplb_valid = s390_init_all_iplbs(ipl);
+        } else {
+            ipl->qipl.num_iplbs = 0;
         }
     }
     if (ipl->netboot) {
-- 
2.45.1


