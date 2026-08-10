Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75465C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVDK-0001hV-D3; Mon, 10 Aug 2026 14:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCx-0001Zk-LF; Mon, 10 Aug 2026 14:58:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCv-0003Ux-N5; Mon, 10 Aug 2026 14:58:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVivr292592; Mon, 10 Aug 2026 18:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A/pSzArHwzYAVbVTs
 ZslFykHVroRDdEe/J5hEkPi4u4=; b=Yh5ovoPwLvlGGsfgmhE1TH6DfFTNGRiYH
 HwJea3zvEL0zvi8wydJ1uQqqvqPqR/VPjETxxTQ71+6RmhsHuPEoOIIuOORP/toH
 tMwRBxQv1r0bkUPcQl5EFlojq9ngY4LK7lM8qG2nCJ7M5XW8BX84caVJ2osrGYGl
 IRIsdTq0CfZL4MudanXrvsId20Oj5BXbdIz9y2Ji91KFMPD29+kl8kpfLK6lL1zC
 Ah75nBlNPs/UgyYxoV/Bab43JRkSnnsZ75RejymXL/pFF+P63CeykevqaNXxz32L
 KYdNKTbY9kzYp32u3wcgK6FIeJTkzL4RMZ2iZEVKFwcTL9F2p9pRw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysmkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIuLHR019209;
 Mon, 10 Aug 2026 18:57:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gx00r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvtsb27329136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8584D58051;
 Mon, 10 Aug 2026 18:57:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E49FC5805F;
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] ufs: Make the logical block size configurable and
 answer absent LUNs
Date: Mon, 10 Aug 2026 13:57:44 -0500
Message-ID: <20260810185748.1253-7-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX0jjF3VWhqurd
 5qVO8EZmcHO0NebAe01q/R2LSYZGl79A1hnO++LvCQHW4mMUel80q2zYyWGirYMeAcGCwlg+p8D
 ZdtrlXpwfxklXNjdDV7S77tUpD3xk2rbWbr3h4My7LlKQHLFP1KoR1lLrLykPrzmJ4qxQlo3fx/
 8Zjo6i/G6m6bveu4KwbSz5NDWQ4SdnxJwCMs7DzWbaVizDSNhGhryM/J9wjFCgp9EJZymyTO7Lj
 KZjki5uFXm0RnWIDncK/8ffmCwiQPAL7hV84tJeF1lOzhYcAD3LYnSgdVyI8/f9Ztb4DgaXgMPs
 JeoWzFvL2i6tfFSrWKS1338PUv3C6QINzs9gWpz+us5io/BIlPAk45KPzR1DVGaurs/VQnYMzsa
 Qg2cnlibFXLW3WATissffmYd+dCkDYKRyQdnA3X4b5CR9fekpELosf6BqxGEnnzqOjAscxIChlu
 tiwzOqH1lQod5IR+Vhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX4fKgumst5EvU
 5fJ3LcMaJjJDroFYvJ/mmfeGxv5g95nM6tKUkoWNKV/6wPUrx8CfhTM+rFRflqWf/uNY2iZknON
 ibRKVofiODrtWsamhWUW8Kznkezuca4=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a1f36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=H40MSsQeoNOp76yvAOYA:9
X-Proofpoint-GUID: S6HDOnoAnohTrwBFgTAwDEtVo-dVFaw7
X-Proofpoint-ORIG-GUID: ejWYIxqZuGDw52ZN7CghYzwaf09sKKrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Two things the ufs-lu model hardcodes that hardware does not.

The logical block size is fixed at UFS_BLOCK_SIZE (4096), both in the unit
descriptor the logical unit reports and in the block size of the scsi-hd
backing it. UFS does not require that: the unit descriptor carries a
base-2 exponent, and 512-byte blocks are common on real hardware and in
images built for it. Add a 'logical-block-size' property that sets both,
defaulting to UFS_BLOCK_SIZE so the ufs PCI device keeps the geometry and
the property set it has today. Restrict it to powers of two from 512 bytes
to UFS_BLOCK_SIZE, and reject a drive shorter than one block, which would
otherwise realize a unit reporting zero blocks.

An INQUIRY addressed to a logical unit that is not mapped fails the
request outright. SPC has a specific answer for this case: return the
standard INQUIRY data with the peripheral qualifier and device type saying
that no device is present on that logical unit, with GOOD status, so that
a host enumerating logical units can tell an absent unit from a transport
error. hw/scsi/scsi-bus.c already answers this way for a target's
unsupported logical units. Do the same for an unmapped ufs-lu, using
TYPE_NO_LUN. Commands other than a standard INQUIRY still fail, now with
LOGICAL UNIT NOT SUPPORTED sense data rather than an unadorned request
failure. The invalid-LUN trace point is unchanged.

Both are needed by the AST2700 UFS controller added later in this series:
the OpenBMC images it boots are laid out for 512-byte sectors, and U-Boot
logs an OCS failure for every unpopulated logical unit while probing it.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 hw/ufs/ufs.h |  3 +++
 hw/ufs/lu.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.c |  2 +-
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index aa8361d93d..47d1c72ef3 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -21,6 +21,7 @@
 #define UFS_MAX_MCQ_QNUM 32
 #define UFS_BLOCK_SIZE_SHIFT 12
 #define UFS_BLOCK_SIZE (1 << UFS_BLOCK_SIZE_SHIFT)
+#define UFS_MIN_BLOCK_SIZE 512
 
 typedef struct UfsBusClass {
     BusClass parent_class;
@@ -80,6 +81,7 @@ typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
 typedef struct UfsLu {
     DeviceState qdev;
     uint8_t lun;
+    uint32_t logical_block_size;
     UnitDescriptor unit_desc;
     SCSIBus bus;
     SCSIDevice *scsi_dev;
@@ -303,6 +305,7 @@ void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
+UfsReqResult ufs_emulate_absent_lun(UfsRequest *req);
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
                  Error **errp);
 void ufs_unrealize(UfsHc *u);
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index eeca865eb5..b1aba79a53 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -308,6 +308,44 @@ static int ufs_emulate_wlun_inquiry(UfsRequest *req, uint8_t *outbuf,
     return SCSI_INQUIRY_LEN;
 }
 
+/*
+ * A logical unit that is not mapped answers a standard INQUIRY as "not
+ * connected" with GOOD status, as hardware does, so that a host bus scan
+ * skips it instead of reporting a controller error. Any other command is
+ * rejected.
+ */
+UfsReqResult ufs_emulate_absent_lun(UfsRequest *req)
+{
+    QEMU_UNINITIALIZED uint8_t outbuf[SCSI_INQUIRY_LEN];
+    uint8_t sense_buf[UFS_SENSE_SIZE];
+    uint8_t scsi_status;
+    int len = 0;
+
+    if (req->req_upiu.sc.cdb[0] == INQUIRY &&
+        !(req->req_upiu.sc.cdb[1] & 0x1)) {
+        memset(outbuf, 0, sizeof(outbuf));
+        outbuf[0] = TYPE_NO_LUN;
+        outbuf[3] = 0x2;
+        outbuf[4] = SCSI_INQUIRY_LEN - 5;
+        len = SCSI_INQUIRY_LEN;
+        scsi_status = GOOD;
+    } else {
+        scsi_build_sense(sense_buf, SENSE_CODE(LUN_NOT_SUPPORTED));
+        scsi_status = CHECK_CONDITION;
+    }
+
+    len = MIN(len, (int)req->data_len);
+    if (scsi_status == GOOD && len > 0 &&
+        dma_buf_read(outbuf, len, NULL, req->sg, MEMTXATTRS_UNSPECIFIED) !=
+            MEMTX_OK) {
+        return UFS_REQUEST_FAIL;
+    }
+
+    ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf), len,
+                                 scsi_status);
+    return UFS_REQUEST_SUCCESS;
+}
+
 static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t lun = lu->lun;
@@ -394,6 +432,8 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static const Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
+    DEFINE_PROP_UINT32("logical-block-size", UfsLu, logical_block_size,
+                       UFS_BLOCK_SIZE),
 };
 
 static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
@@ -435,7 +475,7 @@ static void ufs_init_lu(UfsLu *lu)
     lu->unit_desc.length = sizeof(UnitDescriptor);
     lu->unit_desc.descriptor_idn = UFS_QUERY_DESC_IDN_UNIT;
     lu->unit_desc.lu_enable = 0x01;
-    lu->unit_desc.logical_block_size = UFS_BLOCK_SIZE_SHIFT;
+    lu->unit_desc.logical_block_size = ctz32(lu->logical_block_size);
     lu->unit_desc.unit_index = lu->lun;
     lu->unit_desc.logical_block_count =
         cpu_to_be64(brdv_len / (1 << lu->unit_desc.logical_block_size));
@@ -455,6 +495,25 @@ static bool ufs_lu_check_constraints(UfsLu *lu, Error **errp)
         return false;
     }
 
+    if (!is_power_of_2(lu->logical_block_size)) {
+        error_setg(errp, "logical-block-size must be a power of 2, not %"
+                   PRIu32, lu->logical_block_size);
+        return false;
+    }
+
+    if (lu->logical_block_size < UFS_MIN_BLOCK_SIZE ||
+        lu->logical_block_size > UFS_BLOCK_SIZE) {
+        error_setg(errp, "logical-block-size must be between %d and %d bytes",
+                   UFS_MIN_BLOCK_SIZE, UFS_BLOCK_SIZE);
+        return false;
+    }
+
+    if (blk_getlength(lu->conf.blk) < lu->logical_block_size) {
+        error_setg(errp, "drive is smaller than one %" PRIu32 "-byte block",
+                   lu->logical_block_size);
+        return false;
+    }
+
     return true;
 }
 
@@ -475,8 +534,10 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
     scsi_dev = qdev_new("scsi-hd");
     object_property_add_child(OBJECT(&lu->bus), "ufs-scsi", OBJECT(scsi_dev));
 
-    qdev_prop_set_uint32(scsi_dev, "physical_block_size", UFS_BLOCK_SIZE);
-    qdev_prop_set_uint32(scsi_dev, "logical_block_size", UFS_BLOCK_SIZE);
+    qdev_prop_set_uint32(scsi_dev, "physical_block_size",
+                         lu->logical_block_size);
+    qdev_prop_set_uint32(scsi_dev, "logical_block_size",
+                         lu->logical_block_size);
     qdev_prop_set_uint32(scsi_dev, "scsi-id", 0);
     qdev_prop_set_uint32(scsi_dev, "lun", lu->lun);
     if (!qdev_prop_set_drive_err(scsi_dev, "drive", blk, errp)) {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 36c674af32..016876eb63 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1083,7 +1083,7 @@ static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
 
     if (!is_wlun(lun) && (lun >= UFS_MAX_LUS || u->lus[lun] == NULL)) {
         trace_ufs_err_scsi_cmd_invalid_lun(lun);
-        return UFS_REQUEST_FAIL;
+        return ufs_emulate_absent_lun(req);
     }
 
     switch (lun) {
-- 
2.53.0


