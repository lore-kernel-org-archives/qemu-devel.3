Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7F5CEBF67
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzDF-00042H-72; Thu, 26 Sep 2024 20:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzD4-0003Mi-AO; Thu, 26 Sep 2024 20:51:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzD1-0007If-Cq; Thu, 26 Sep 2024 20:51:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QDvCWD025981;
 Fri, 27 Sep 2024 00:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=P6sEHFgACZjx5
 4JFaKEz+xV/HOjKLcesewy/S/kCRrY=; b=mttmItV/MFWSNwEkZAU7VKpY6pBZ6
 t9++hVb6x/bR63aGN+tgr6poRfG6TJw9mYjIHISwzxKmQdMCh+y4H7StWMTNjDRn
 kBBKRy3XAnhcpgkjq6ZdSGzMafC41sQM/LUoJ+5rY7wSwbA/tbnXUhezO4XUUtuy
 Pw73jN0I7quOlcnBLVvYSFI1Ls244LRQQG4Nr1VrabGOeDYL6c0O831YJHJ97yq9
 dW6r6eZxHKUbqscl9R3nBC91mWu0Pe79tNLSaGF6eCAfsFNK0g+ejs3B75PTDwy5
 uoNOJ3Vf1VvN7QzSI9/EGBEwdNOLGQmFEkYTXPNOXMdLM4fHlJndKvvdQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntwsemk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pjnH028604;
 Fri, 27 Sep 2024 00:51:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntwsemg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QLGRPx014077;
 Fri, 27 Sep 2024 00:51:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9yna5w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pgPN25428676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BEBA58056;
 Fri, 27 Sep 2024 00:51:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA43858052;
 Fri, 27 Sep 2024 00:51:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:41 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 15/18] hw/s390x: Build an IPLB for each boot device
Date: Thu, 26 Sep 2024 20:51:14 -0400
Message-ID: <20240927005117.1679506-16-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OwmC9D5fM4Ua7uUbZHaANO0XZCo_725S
X-Proofpoint-GUID: C4dMVJiRI4rfrgPa8an45I00yrcZEc1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Build an IPLB for any device with a bootindex (up to a maximum of 8 devices).

The IPLB chain is placed immediately before the BIOS in memory. Because this
is not a fixed address, the location of the next IPLB and number of remaining
boot devices is stored in the QIPL global variable for possible later access by
the guest during IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

---
 hw/s390x/ipl.h              |   1 +
 include/hw/s390x/ipl/qipl.h |   4 +-
 hw/s390x/ipl.c              | 125 ++++++++++++++++++++++++++++--------
 3 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b670bad551..e4af8e3782 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -20,6 +20,7 @@
 #include "qom/object.h"
 
 #define DIAG308_FLAGS_LP_VALID 0x80
+#define MAX_IPLB_CHAIN 7 /* Max number of fallback boot devices */
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index d21a8f91e3..15342ac5cd 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -31,7 +31,9 @@ struct QemuIplParameters {
     uint8_t  reserved1[3];
     uint64_t reserved2;
     uint32_t boot_menu_timeout;
-    uint8_t  reserved3[12];
+    uint8_t  reserved3[2];
+    uint16_t chain_len;
+    uint64_t next_iplb;
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8a62ff6913..ba66847b9c 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -56,6 +56,13 @@ static bool iplb_extended_needed(void *opaque)
     return ipl->iplbext_migration;
 }
 
+/* Place the IPLB chain immediately before the BIOS in memory */
+static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t count)
+{
+    return (bios_addr & TARGET_PAGE_MASK)
+            - (count * sizeof(IplParameterBlock));
+}
+
 static const VMStateDescription vmstate_iplb_extended = {
     .name = "ipl/iplb_extended",
     .version_id = 0,
@@ -398,6 +405,17 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
     return ccw_dev;
 }
 
+static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
+{
+    S390IPLState *ipl = get_ipl_device();
+    uint16_t count = ipl->qipl.chain_len;
+    uint64_t len = sizeof(IplParameterBlock) * count;
+    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
+
+    cpu_physical_memory_write(chain_addr, iplb_chain, len);
+    return chain_addr;
+}
+
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
 {
     int i;
@@ -428,54 +446,51 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
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
 
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
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
+            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
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
 
@@ -484,8 +499,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         }
 
-        s390_ipl_convert_loadparm((char *)lp, ipl->iplb.loadparm);
-        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+        s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
+        iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
         return true;
     }
@@ -493,6 +508,58 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
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
+        ipl->qipl.chain_len = 0;
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
+    ipl->qipl.chain_len = iplb_num - 1;
+
+    /*
+     * Build fallback IPLBs for any boot devices above index 0, up to a
+     * maximum amount as defined in ipl.h
+     */
+    if (iplb_num > 1) {
+        if (iplb_num > MAX_IPLB_CHAIN + 1) {
+            warn_report("Excess boot devices defined! %d boot devices found, "
+                        "but only the first %d will be considered.",
+                        iplb_num, MAX_IPLB_CHAIN + 1);
+
+            ipl->qipl.chain_len = MAX_IPLB_CHAIN;
+            iplb_num = MAX_IPLB_CHAIN + 1;
+        }
+
+        /* Start at 1 because the IPLB for boot index 0 is not chained */
+        for (int i = 1; i < iplb_num; i++) {
+            dev_st = get_boot_device(i);
+            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
+            iplb_chain[i - 1].flags |= DIAG308_FLAGS_LP_VALID;
+        }
+
+        ipl->qipl.next_iplb = s390_ipl_map_iplb_chain(iplb_chain);
+    }
+
+    return iplb_num;
+}
+
 static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
                                          int virtio_id)
 {
@@ -620,7 +687,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
              * this is the original boot device's SCSI
              * so restore IPL parameter info from it
              */
-            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
         }
     }
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
@@ -714,7 +781,9 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
         if (!ipl->iplb_valid) {
-            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+            ipl->iplb_valid = s390_init_all_iplbs(ipl);
+        } else {
+            ipl->qipl.chain_len = 0;
         }
     }
     s390_ipl_set_boot_menu(ipl);
-- 
2.45.1


