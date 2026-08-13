Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D46C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wub9N-0000hm-73; Thu, 13 Aug 2026 15:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wub9F-0000gK-Lj; Thu, 13 Aug 2026 15:31:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wub9D-0005a5-1X; Thu, 13 Aug 2026 15:31:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DJ1ufK3099940; Thu, 13 Aug 2026 19:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=A/pSzArHwzYAVbVTs
 ZslFykHVroRDdEe/J5hEkPi4u4=; b=qrnNK4jKylz+/M6F5okAaQ85q12ykTFU2
 J0ZYdxuxTIX5tVa9N0sFujF4fS/i7745Z5Z9RXpqu/VP81ZCQh+3S/VfdCaUWDTb
 RfLsyRFNTILCWCSZ01vT9LM+X6VKanYe7GlNgQVaVzweI5RzC8CHkKp6zhjRfntA
 MiuM5q1sXpW710IheNm66+2jGMN1IlDtIqMbhyDdMeSppRyubJB3WL3VWZ5Q84xw
 fU0LllZgtEd3Hz1PjGezyzbot9DF0mJV18z5nUFSyiNoQ36VGEleD24NZYJhhInM
 AKIHxIZhXFgaiMZN/tibwBWP9lKJKuuWHlxKsIA5WsljAbodyAjAQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp38k1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 19:30:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DJQQNY021909;
 Thu, 13 Aug 2026 19:30:48 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hcb0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 19:30:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DJUl8L16646846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 19:30:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3E6F5805D;
 Thu, 13 Aug 2026 19:30:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2151A5805B;
 Thu, 13 Aug 2026 19:30:46 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2026 19:30:46 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] ufs: Make the logical block size configurable and
 answer absent LUNs
Date: Thu, 13 Aug 2026 14:30:37 -0500
Message-ID: <20260813193040.669533-6-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813193040.669533-1-mikail.sadic@ibm.com>
References: <20260813193040.669533-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7e1b69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=H40MSsQeoNOp76yvAOYA:9
X-Proofpoint-GUID: KKV6NNHkMr-WLOBfFMs9vphbO51IO5us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzOCBTYWx0ZWRfXztFPKnhhOEHh
 SFzcYc0uhsRXOyGYgo/EJ4iU59HUtN9H5Zi3U/lahKoiBYKi1nc0woNupuGnazkHzsChsFhQrOb
 mQYdf0JGEazJyOVrDdAZuqjqVKmOi0616FLNBsJbOmgXQaNAdE3CRp6mIii+h7rF0PSk3ViRpze
 k9ZcJsdu3MM6P6xafrFo0UvZbCoMm5gdnytgrzXbFw9KdRuhgS8E+K7+hmPO5ZSSZifXj2AnpnQ
 4D/GGlDURaFpyyUn1rqRHeGobAQEby7f0az1nUMWaFl0o/d3U/1nhTMJQAKJ4qTazCl0S+oFga+
 2d417j3Y2rczb+8KoXFMrI6i35ouGDBbs90Q9en1f1uNELpTbLOTemXLWtd0LOI8OHsm5kW6W3/
 +3Ti+KjS/sMBQiEPB3F7tcUJ9XaXdi+IM+Og2WO2Ybs66QMMYLV4HBozBb0/o4yQbrr5iaL/F/X
 7Yq/AotFq+jSry9Ja1g==
X-Proofpoint-ORIG-GUID: J2mLdFbU-Saf3DVB6P9_0qlJ4K2g0xBT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzOCBTYWx0ZWRfX8V+gzRxT2Gs5
 Nv3sBlKxCGl+z/B1q9iPlIB50pHjNAYGBmPOTMjcEJ8+mqvZeeOKmi+LplhilbMb4ovkuSh/0A2
 YkaLoeX0zsZeKcGfrdYuukWKZiMpWXc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=mikail.sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


