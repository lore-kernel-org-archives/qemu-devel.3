Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6760DC55171
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpX5C-0004GQ-J7; Thu, 30 Jul 2026 16:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5A-00049j-HM; Thu, 30 Jul 2026 16:10:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX58-0001gd-2T; Thu, 30 Jul 2026 16:10:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJlwGw3942870; Thu, 30 Jul 2026 20:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uxKVfcDIfxxH5N5G4
 79uiCdHgCaCC04SuPYebfocHYM=; b=mFq2ExReLtcjL+TcHqMUriDcdjimEYPfT
 qSUQiqOvBQchn+fz3lbrSIOFRxucZbpTOKbqA00IQYj6rOBVSbe11u74GZdL65Mr
 ahWdV5gMC2BfQwKfOkd8YUwEUmJ61q2vKk+MLtuK2gjMsxbl2R2XwmQsAIg3O11c
 UCOeigiGLE6zJ1LynwPGLMDBVzgP25mLGxYrpdJVLzfttQuDtePf3eJJ4K8DOy6X
 TnNBR7sAnGCN22otpd1YjzhOKZT/xDC0BKIsTfFDsxSPO3hQycHEDebPizJOPFxR
 FW7p9GfkbBjNjxeOKP+UxHJpqyp5Z0yYrnwFEd9R8+7slhnxFmueQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7sper-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJuIMt028370;
 Thu, 30 Jul 2026 20:09:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkcy7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UK9nBh10093296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 20:09:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A62E858055;
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CABF5805D;
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] ufs: Refactor common core out of the PCI implementation
Date: Thu, 30 Jul 2026 15:09:41 -0500
Message-ID: <20260730200945.1113936-7-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730200945.1113936-1-mikail.sadic@ibm.com>
References: <20260730200945.1113936-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: N6T7vCFdgHz0h05ezm_pZMH1CUtYKTDe
X-Proofpoint-ORIG-GUID: rD6K3qn1ULoXr1rIJK3nyzrMtlBA5hvU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXw2WAqLXRzuBd
 C8r+ouGTury83qD1OttTgr+NL5CbTlkv3MvDMJpDfbvYUidsf7YGcxM4uoF80piW4tAUgZCgtSh
 z//oMpnl43yS18L+XjCTKk5FAZW+jA6YTo1+iot9BCixQrIegUEXaBBTsmPGq9tUmGv7RzF59Zn
 Pyr6gO8amePqylK05D4h6tpR6W9R1QyRv7Zh5B8LFAHc5Y84dyox6v3dv9Z+hnN5C8zyZhdtSQN
 +AZgn3uDGDEMYb7WyZAV1plAhWvPmuHNEKDp56adTxL3+lNzNkg4fi0tHB+n9S92a5uOeKZoqbr
 i/CY33GxSf6XeDKzQsptvS3qAKLDWBwVwWpkzvbs9SmMb4ahF19gtU66U08yMtbqGDEVgDpXOiR
 RECdK1DZYg8hCNdpZjWgo+D7gBVhuyaYkwwzP92nC/d3gX5zNOZmIIf23IVM/pItu/mu1I59tQD
 IgzTU5yRV6pe5Bvj3bA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6baf90 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=zbKmmB3fWhTtxL3vfSwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX3R6ir9WV2NlF
 dwVX8VV1PYxLnevLVISErUDiCn4fFPT/HC3CIdPttGwZTI4lEwP70lhg9bqSb7NeCM3bEZE/kKD
 VkpQN/VMlcTW3dcSs1Ra/QJnEeAgdR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300145
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

In preparation for a sysbus UFS frontend (used by the Aspeed AST2700),
separate the transport-independent UFS host-controller logic from the
PCI-specific glue, following the pattern used by SDHCI and XHCI.

UfsHc's PCIDevice parent is replaced by an anonymous union of a
PCIDevice and a SysBusDevice, and the controller gains an explicit
AddressSpace *dma_as used by ufs_addr_read()/ufs_addr_write() and the
SG-list helpers instead of the PCI address space. Interrupt delivery
goes through qemu_set_irq() in ufs_irq_check(). The realize path is
split into a transport-agnostic ufs_realize_core() plus ufs_init_mmio(),
and UfsBus gains an 'hc' back-pointer so ufs_lu_realize() no longer
reaches through the PCI device. TYPE_UFS remains a PCI device, so
'-device ufs' is unchanged and the PCI ufs-tests qtests still pass.

Two small behaviour additions ride along on the core so that frontends
with differing geometry and bus-scan behaviour can be modelled:

  - ufs-lu gains configurable 'logical-block-size' property. It
    defaults to UFS_BLOCK_SIZE, so the PCI device is unaffected.

  - an unmapped LUN now answers INQUIRY as "not connected" rather than
    failing the request, so that a host bus-scan does not observe
    controller errors for absent LUNs.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 hw/ufs/ufs.h | 18 ++++++++++++++++-
 hw/ufs/lu.c  | 50 +++++++++++++++++++++++++++++++++++++++++----
 hw/ufs/ufs.c | 57 ++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index feb47f460d..3d4be8deb5 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -12,7 +12,9 @@
 #define HW_UFS_UFS_H
 
 #include "hw/pci/pci_device.h"
+#include "hw/core/sysbus.h"
 #include "hw/scsi/scsi.h"
+#include "scsi/constants.h"
 #include "block/ufs.h"
 
 #define UFS_MAX_LUS 32
@@ -27,6 +29,7 @@ typedef struct UfsBusClass {
 
 typedef struct UfsBus {
     BusState parent_bus;
+    struct UfsHc *hc; /* host controller owning this bus (frontend-agnostic) */
 } UfsBus;
 
 #define TYPE_UFS_BUS "ufs-bus"
@@ -77,6 +80,7 @@ typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
 typedef struct UfsLu {
     DeviceState qdev;
     uint8_t lun;
+    uint32_t logical_block_size;
     UnitDescriptor unit_desc;
     SCSIBus bus;
     SCSIDevice *scsi_dev;
@@ -141,7 +145,15 @@ typedef struct UfsWb {
 } UfsWb;
 
 typedef struct UfsHc {
-    PCIDevice parent_obj;
+    /*
+     * The controller can be instantiated either as a PCI function or as a
+     * sysbus device.  Following the SDHCI model, both frontends share this
+     * state structure via a union of the possible parent objects.
+     */
+    union {
+        PCIDevice pci_dev;
+        SysBusDevice sbdev;
+    };
     UfsBus bus;
     MemoryRegion iomem;
     UfsReg reg;
@@ -162,6 +174,7 @@ typedef struct UfsHc {
     Flags flags;
 
     qemu_irq irq;
+    AddressSpace *dma_as;
     QEMUBH *doorbell_bh;
     QEMUBH *complete_bh;
 
@@ -302,4 +315,7 @@ void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
+UfsReqResult ufs_emulate_absent_lun(UfsRequest *req);
+void ufs_init_mmio(UfsHc *u);
+bool ufs_realize_core(UfsHc *u, Error **errp);
 #endif /* HW_UFS_UFS_H */
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 13f4a90145..a0b5574668 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -308,6 +308,44 @@ static int ufs_emulate_wlun_inquiry(UfsRequest *req, uint8_t *outbuf,
     return SCSI_INQUIRY_LEN;
 }
 
+UfsReqResult ufs_emulate_absent_lun(UfsRequest *req)
+{
+    QEMU_UNINITIALIZED uint8_t outbuf[SCSI_INQUIRY_LEN];
+    uint8_t sense_buf[UFS_SENSE_SIZE];
+    uint8_t scsi_status;
+    int len = 0;
+
+    if (req->req_upiu.sc.cdb[0] == INQUIRY &&
+        !(req->req_upiu.sc.cdb[1] & 0x1)) {
+        /*
+         * Standard INQUIRY to a logical unit that is not mapped: report it
+         * as "not connected" (peripheral qualifier 0x3, device type 0x1f)
+         * with GOOD status, like real hardware. Host-side bus scans then
+         * skip the unit quietly instead of flagging a controller error.
+         */
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
@@ -475,8 +515,10 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
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
@@ -497,7 +539,7 @@ static void ufs_lu_realize(DeviceState *dev, Error **errp)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
     BusState *s = qdev_get_parent_bus(dev);
-    UfsHc *u = UFS(s->parent);
+    UfsHc *u = UFS_BUS(s)->hc;
     BlockBackend *blk = lu->conf.blk;
 
     if (!ufs_lu_check_constraints(lu, errp)) {
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 464fd465b3..1489bd3321 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -102,7 +102,8 @@ static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
         return MEMTX_DECODE_ERROR;
     }
 
-    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
+    return dma_memory_read(u->dma_as, addr, buf, size,
+                           MEMTXATTRS_UNSPECIFIED);
 }
 
 static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
@@ -117,7 +118,8 @@ static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
         return MEMTX_DECODE_ERROR;
     }
 
-    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
+    return dma_memory_write(u->dma_as, addr, buf, size,
+                            MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
@@ -222,7 +224,7 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
     }
 
     req->sg = g_malloc0(sizeof(QEMUSGList));
-    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
+    qemu_sglist_init(req->sg, DEVICE(u), prdt_len, u->dma_as);
     req->data_len = 0;
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
@@ -317,14 +319,12 @@ static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
 
 static void ufs_irq_check(UfsHc *u)
 {
-    PCIDevice *pci = PCI_DEVICE(u);
-
     if ((u->reg.is & UFS_INTR_MASK) & u->reg.ie) {
         trace_ufs_irq_raise();
-        pci_irq_assert(pci);
+        qemu_set_irq(u->irq, 1);
     } else {
         trace_ufs_irq_lower();
-        pci_irq_deassert(pci);
+        qemu_set_irq(u->irq, 0);
     }
 }
 
@@ -1092,7 +1092,7 @@ static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
 
     if (!is_wlun(lun) && (lun >= UFS_MAX_LUS || u->lus[lun] == NULL)) {
         trace_ufs_err_scsi_cmd_invalid_lun(lun);
-        return UFS_REQUEST_FAIL;
+        return ufs_emulate_absent_lun(req);
     }
 
     switch (lun) {
@@ -2488,6 +2488,12 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
     return true;
 }
 
+void ufs_init_mmio(UfsHc *u)
+{
+    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
+                          u->reg_size);
+}
+
 static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
 {
     uint8_t *pci_conf = pci_dev->config;
@@ -2495,8 +2501,7 @@ static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_conf, 0x1);
 
-    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
-                          u->reg_size);
+    ufs_init_mmio(u);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
     u->irq = pci_allocate_irq(pci_dev);
 }
@@ -2689,25 +2694,43 @@ static void ufs_init_hc(UfsHc *u)
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
-static void ufs_realize(PCIDevice *pci_dev, Error **errp)
+/*
+ * Frontend-agnostic realization: everything except the host-bus specific
+ * MMIO/IRQ/DMA plumbing, which the PCI or sysbus frontend sets up around
+ * this call.  The frontend must assign u->dma_as before calling.
+ */
+bool ufs_realize_core(UfsHc *u, Error **errp)
 {
-    UfsHc *u = UFS(pci_dev);
-
     if (!ufs_check_constraints(u, errp)) {
-        return;
+        return false;
     }
 
-    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, &pci_dev->qdev,
-              u->parent_obj.qdev.id);
+    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, DEVICE(u),
+              DEVICE(u)->id);
+    u->bus.hc = u;
 
     ufs_init_state(u);
     ufs_init_hc(u);
-    ufs_init_pci(u, pci_dev);
 
     ufs_init_wlu(&u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN);
     ufs_init_wlu(&u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN);
     ufs_init_wlu(&u->boot_wlu, UFS_UPIU_BOOT_WLUN);
     ufs_init_wlu(&u->rpmb_wlu, UFS_UPIU_RPMB_WLUN);
+
+    return true;
+}
+
+static void ufs_realize(PCIDevice *pci_dev, Error **errp)
+{
+    UfsHc *u = UFS(pci_dev);
+
+    u->dma_as = pci_get_address_space(pci_dev);
+
+    if (!ufs_realize_core(u, errp)) {
+        return;
+    }
+
+    ufs_init_pci(u, pci_dev);
 }
 
 static void ufs_exit(PCIDevice *pci_dev)
-- 
2.53.0


