Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD7ACA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVpK-0000CV-Ro; Fri, 02 Oct 2026 01:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVoc-0008Ko-DT; Fri, 02 Oct 2026 01:28:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVoZ-00082A-Pl; Fri, 02 Oct 2026 01:28:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922ZW0H3513067; Fri, 2 Oct 2026 05:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LQuhzk3+SlnJVJ+TY
 y3QZqVA4Au11GVYP11q3OYC0R8=; b=nPXMMzNFeyZ+PMGPRHoDBVmi5g1OnDyfb
 LIJ0/YBHjrUyYNAMxVEfaiDlY6IEr8dHIFPuqaWf8wSxGdNuPQaLn+AeENjecs6V
 2Z0ExEXfSel6ktBVz7aM6iPkgzR2WM0/J2rZQ4gqEnzSIavcWaQCOgnYLcJfpIwi
 skca+vjQGAnPFthjBgAEkXu3+GC7+6w4BiZy8ds3wU0NbNcNl3V32MceaRrOkhXi
 1u8BkqZU9tepJs5hHUCirHiTOjvQcZztn7dzbMqvMBjNTqp/QD/jGzoEf5iuTXLO
 2msAaY+vH29antWAv8BvX1cXxVCmhJsn8jVrzuylUlZB8YhHzE/Sw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptp7nh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922KE0w1834610; Fri, 2 Oct 2026 05:28:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dhfjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6925S2ng27656746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 05:28:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49B425805A;
 Fri,  2 Oct 2026 05:28:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A4D558056;
 Fri,  2 Oct 2026 05:27:53 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.111.176]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 05:27:53 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH v2 5/8] ppc/spapr: add block device backend to VOF
 open/read/write/seek services
Date: Fri,  2 Oct 2026 10:55:44 +0530
Message-ID: <20261002052605.605858-6-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: -w_-X_KHlF4I5218ZQ_6fMeyVv15mVbL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX7pslFDuaHX/P
 rwXys4X2Q3s/NNvDz7DW4yIUZmlHzKk7Jo9s09UQEc0R9mOd0An3V0N1vDJRXNLMcHOBPm27Lq4
 MkzPwm7gee3IZH97V2UQTFxQ2mXtugAx48NzfU5QifHvFQS1iVc9XxQWNzNXRpnv4IdXSGJIbvM
 UTyzv6YGEf01FvYmU1Wbtyrn/og/SUKM0CmwBs9ZqaUwgFhAOKU1ux8EMHJ5GYjYEoUDpAB93q2
 pMyaiSnkN8+qlPcYUkLM5SKR/OH/l/Q8R4II8aUGxkxHHKt1xQ8obY6nmxprm8m4w2PcNS+0fbj
 PQmEGWcDN5dRCl/y4rlQD3oPZbC+oirtr/SQGYZc4wa/neqLB+0G0Q36wzMKd2JE/sFPtCtMKm4
 zDEQSoA6BhcBUEOck0hR3nq20kHlIEYXXERjrURSCsrg0mHfmdYVCypDosHJdWemcqfr6i1zcgX
 2cLXA3GvinVvxhMmHAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfXyenq383Z/2Qq
 zcshQXLortgsgnrGBYObeQ9tAooxcXs7O6CEkvrlXwBrqpxWq+ssOW+Z4RX3p8sXPks6NwNXI74
 25FmoES0PWqy0Xy7DnOewVnceNgHny8=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abf40e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8
 a=WDcW98JQBSw0CRIMMy4A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: gvn7uCj8J7gYzRK3mDFpi4w_IPhKDiWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Utkarsh Verma <uverma@linux.ibm.com>

Extend the VOF client interface to support block device I/O through the
sPAPR SCSI disk, which is needed by bootloaders such as GRUB during VOF
disk boot.

Add BlockBackend and position tracking fields to OfInstance and use them
in vof_seek(), vof_write() and vof_read() to extend their functionality
to handle block devices as well.

In vof_do_open(), detect "disk" FDT nodes, extract the SRP LUN from the
path string, and use scsi_device_find() + blk_by_dev() to obtain the
matching BlockBackend.

Add vof_seek() to implement the OpenFirmware "seek" client service,
which was previously missing.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
Changelog:
v2:
- vof_do_open(): replaced brute force blk_next() loop with
  vof_find_vscsi_bus() + scsi_device_find() + blk_by_dev() for a SCSI
  disk discovery.
- vof_write() block path: capped I/O to VOF_BLK_BUF_SIZE (64 KB) per
  iteration, checked blk_flush() return value, added bdrv_is_read_only()
  guard before any write attempt.
- vof_write() serial path: fixed an existing bug, which did not advance
  the buffer after each iteration and returned the remaining len instead
  of bytes written.
- vof_read() block path: added the same loop pattern as vof_write(),
  advancing buf and position correctly per iteration.
- path_offset(): added wildcard fallback so "disk@<srp-lun>" paths
  resolve to the parent's generic "disk" FDT subnode.
---
 hw/ppc/trace-events |   2 +
 hw/ppc/vof.c        | 217 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index dbdcfada26..a61398ecb2 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -78,6 +78,7 @@ vof_error_unknown_service(const char *service, int nargs, int nret) "\"%s\" args
 vof_error_unknown_method(const char *method) "\"%s\""
 vof_error_unknown_ihandle_close(uint32_t ih) "ih=0x%x"
 vof_error_unknown_path(const char *path) "\"%s\""
+vof_error_seek(uint32_t ih) "ih=0x%x"
 vof_error_write(uint32_t ih) "ih=0x%x"
 vof_error_read(uint32_t ih) "ih=0x%x"
 vof_finddevice(const char *path, uint32_t ph) "\"%s\" => ph=0x%x"
@@ -92,6 +93,7 @@ vof_interpret(const char *cmd, uint32_t param1, uint32_t param2, uint32_t ret, u
 vof_package_to_path(uint32_t ph, const char *tmp, int ret) "ph=0x%x => %s len=%d"
 vof_instance_to_path(uint32_t ih, uint32_t ph, const char *tmp, int ret) "ih=0x%x ph=0x%x => %s len=%d"
 vof_instance_to_package(uint32_t ih, uint32_t ph) "ih=0x%x => ph=0x%x"
+vof_seek(uint32_t ih, uint64_t pos) "ih=0x%x pos=0x%"PRIx64
 vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
 vof_read(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
 vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 6f6d424347..d4b57b3b46 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -11,6 +11,7 @@
 
 #include CONFIG_DEVICES /* CONFIG_PSERIES */
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/ctype.h"
 #include "qemu/timer.h"
 #include "qemu/range.h"
@@ -25,6 +26,9 @@
 #include "trace.h"
 
 #include "hw/ppc/spapr_vio.h"
+#include "hw/scsi/scsi.h"
+#include "system/block-backend.h"
+#include "block/block-io.h"
 #include <libfdt.h>
 
 /*
@@ -38,6 +42,7 @@
 #define VOF_MAX_METHODLEN   256
 #define VOF_MAX_FORTHCODE   256
 #define VOF_VTY_BUF_SIZE    256
+#define VOF_BLK_BUF_SIZE    (64 * 1024)
 
 typedef struct {
     uint64_t start;
@@ -47,6 +52,8 @@ typedef struct {
 typedef struct {
     char *path; /* the path used to open the instance */
     uint32_t phandle;
+    BlockBackend *blk;
+    uint64_t pos; /* current position for seek operations */
     void *vty;
 } OfInstance;
 
@@ -138,6 +145,8 @@ static int path_offset(const void *fdt, const char *path)
 {
     g_autofree char *p = NULL;
     char *at;
+    char *last_slash;
+    int offset;
 
     /*
      * https://www.devicetree.org/open-firmware/bindings/ppc/release/ppc-2_1.html#HDR16
@@ -156,7 +165,76 @@ static int path_offset(const void *fdt, const char *path)
             }
     }
 
-    return fdt_path_offset(fdt, p);
+    offset = fdt_path_offset(fdt, p);
+    if (offset >= 0) {
+        return offset;
+    }
+
+    /*
+     * Apply the OF wildcard rule for vSCSI disk paths. A path ending in
+     * disk@<srp-lun> has no per-LUN FDT node, instead the FDT contains a single
+     * generic "disk" child (no srp-lun appended to the path). The phandle is
+     * shared by all LUNs on the adapter, matching the Open Firmware behaviour.
+     */
+    last_slash = strrchr(p, '/');
+    if (last_slash && strncmp(last_slash + 1, "disk@", 5) == 0) {
+        int parent_off;
+
+        *last_slash = '\0';
+        parent_off = fdt_path_offset(fdt, p);
+        if (parent_off >= 0) {
+            int child_off = fdt_subnode_offset(fdt, parent_off, "disk");
+            if (child_off >= 0) {
+                return child_off;
+            }
+        }
+    }
+
+    return offset;
+}
+
+/*
+ * Return the SCSIBus for a v-scsi@<reg> path, or NULL if not found.
+ */
+static SCSIBus *vof_find_vscsi_bus(MachineState *ms, const char *path)
+{
+#ifdef CONFIG_PSERIES
+    SpaprMachineState *spapr = SPAPR_MACHINE(ms);
+    const char *at;
+    const char *endptr;
+    unsigned long reg;
+    SpaprVioDevice *vdev;
+    BusState *bus;
+
+    if (!spapr || !spapr->vio_bus) {
+        return NULL;
+    }
+
+    at = strstr(path, "v-scsi@");
+    if (!at) {
+        return NULL;
+    }
+    at = strchr(at, '@');
+    if (!at) {
+        return NULL;
+    }
+
+    if (qemu_strtoul(at + 1, &endptr, 16, &reg) || endptr == at + 1) {
+        return NULL;
+    }
+
+    vdev = spapr_vio_find_by_reg(spapr->vio_bus, (uint32_t)reg);
+    if (!vdev) {
+        return NULL;
+    }
+
+    QLIST_FOREACH(bus, &vdev->qdev.child_bus, sibling) {
+        if (object_dynamic_cast(OBJECT(bus), TYPE_SCSI_BUS)) {
+            return SCSI_BUS(bus);
+        }
+    }
+#endif /* CONFIG_PSERIES */
+    return NULL;
 }
 
 static uint32_t vof_finddevice(const void *fdt, uint32_t nodeaddr)
@@ -450,6 +528,8 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, int offset, const char *path)
 {
     uint32_t ret = PROM_ERROR;
     OfInstance *inst = NULL;
+    const char *node_name;
+    MachineState *ms = MACHINE(qdev_get_machine());
 
     if (vof->of_instance_last == 0xFFFFFFFF) {
         /* We do not recycle ihandles yet */
@@ -462,13 +542,43 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, int offset, const char *path)
     ++vof->of_instance_last;
 
     inst->path = g_strdup(path);
+    inst->blk = NULL;
+    inst->pos = 0;
     inst->vty = NULL;
 
+    node_name = fdt_get_name(fdt, offset, NULL);
+
+    /*
+     * vSCSI disk open.  The FDT contains only a generic "disk" child node (no
+     * srp-lun appended to the path), matching Open Firmware behaviour.
+     * Extract the LUN from the "disk@<hex>" component of the path string
+     * and use it to find the corresponding QEMU block backend.
+     */
+    if (node_name && strcmp(node_name, "disk") == 0) {
+        const char *disk_at = strstr(path, "/disk@");
+        const char *endptr;
+        uint64_t srp_lun;
+
+        if (disk_at &&
+            qemu_strtou64(disk_at + 6, &endptr, 16, &srp_lun) == 0) {
+            SCSIBus *sbus = vof_find_vscsi_bus(ms, path);
+
+            if (sbus) {
+                uint32_t target  = (srp_lun >> 56) & 0x3f;
+                uint32_t channel = (srp_lun >> 53) & 0x7;
+                uint32_t lun     = (srp_lun >> 48) & 0x1f;
+                SCSIDevice *sdev = scsi_device_find(sbus, (int)channel,
+                                                    (int)target, (int)lun);
+                if (sdev) {
+                    inst->blk = blk_by_dev(sdev);
+                }
+            }
+        }
+    }
+
 #ifdef CONFIG_PSERIES
-    const char *node_name = fdt_get_name(fdt, offset, NULL);
     if (node_name && strncmp(node_name, "vty", 3) == 0) {
         uint8_t discard_buf[VOF_VTY_BUF_SIZE];
-        MachineState *ms = MACHINE(qdev_get_machine());
         SpaprMachineState *spapr = SPAPR_MACHINE(ms);
 
         if (spapr && spapr->vio_bus) {
@@ -602,6 +712,38 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
         return PROM_ERROR;
     }
 
+    if (inst->blk) {
+        if (bdrv_is_read_only(blk_bs(inst->blk))) {
+            trace_vof_error_write(ihandle);
+            return PROM_ERROR;
+        }
+
+        g_autofree uint8_t *blkbuf = g_malloc(MIN(len, (uint32_t)VOF_BLK_BUF_SIZE));
+        uint32_t total = 0;
+
+        while (len > 0) {
+            cb = MIN(len, (uint32_t)VOF_BLK_BUF_SIZE);
+            if (VOF_MEM_READ(buf, blkbuf, cb) != MEMTX_OK) {
+                trace_vof_error_write(ihandle);
+                return PROM_ERROR;
+            }
+            if (blk_pwrite(inst->blk, inst->pos, cb, blkbuf, 0) < 0) {
+                trace_vof_error_write(ihandle);
+                return PROM_ERROR;
+            }
+            inst->pos += cb;
+            buf += cb;
+            len -= cb;
+            total += cb;
+        }
+        if (blk_flush(inst->blk) < 0) {
+            trace_vof_error_write(ihandle);
+            return PROM_ERROR;
+        }
+        trace_vof_write(ihandle, total, "(disk)");
+        return total;
+    }
+
 #ifdef CONFIG_PSERIES
     if (inst->vty) {
         uint32_t total_written = 0;
@@ -619,6 +761,7 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
     }
 #endif
 
+    uint32_t total_traced = 0;
     for ( ; len > 0; len -= cb) {
         cb = MIN(len, sizeof(tmp) - 1);
         if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
@@ -631,9 +774,11 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
             tmp[cb] = '\0';
             trace_vof_write(ihandle, cb, tmp);
         }
+        buf += cb;
+        total_traced += cb;
     }
 
-    return len;
+    return total_traced;
 }
 
 static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
@@ -647,6 +792,33 @@ static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
         return PROM_ERROR;
     }
 
+    if (inst->blk) {
+        g_autofree uint8_t *tmp = g_malloc(MIN(len, (uint32_t)VOF_BLK_BUF_SIZE));
+        uint32_t total = 0;
+
+        while (len > 0) {
+            unsigned cb = MIN(len, (uint32_t)VOF_BLK_BUF_SIZE);
+            int ret = blk_pread(inst->blk, inst->pos, cb, tmp, 0);
+            if (ret < 0) {
+                trace_vof_error_read(ihandle);
+                return PROM_ERROR;
+            }
+
+            if (VOF_MEM_WRITE(buf, tmp, cb) != MEMTX_OK) {
+                trace_vof_error_read(ihandle);
+                return PROM_ERROR;
+            }
+
+            inst->pos += cb;
+            buf += cb;
+            len -= cb;
+            total += cb;
+        }
+
+        trace_vof_read(ihandle, total, "(disk)");
+        return total;
+    }
+
 #ifdef CONFIG_PSERIES
     if (inst->vty) {
         uint8_t tmp[VOF_VTY_BUF_SIZE];
@@ -676,6 +848,41 @@ static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
     return 0;
 }
 
+static uint32_t vof_seek(Vof *vof, uint32_t ihandle, uint32_t pos_hi,
+                         uint32_t pos_lo)
+{
+    OfInstance *inst = (OfInstance *)
+        g_hash_table_lookup(vof->of_instances, GINT_TO_POINTER(ihandle));
+    uint64_t pos = ((uint64_t)pos_hi << 32) | pos_lo;
+
+    if (!inst) {
+        trace_vof_error_seek(ihandle);
+        return PROM_ERROR;
+    }
+
+    if (inst->blk) {
+        int64_t size = blk_getlength(inst->blk);
+
+        if (size < 0) {
+            trace_vof_error_seek(ihandle);
+            return PROM_ERROR;
+        }
+
+        if (pos > (uint64_t)size) {
+            trace_vof_error_seek(ihandle);
+            return PROM_ERROR;
+        }
+
+        inst->pos = pos;
+        trace_vof_seek(ihandle, pos);
+        return 0;
+    }
+
+    /* VTY and other devices don't support seek */
+    trace_vof_error_seek(ihandle);
+    return PROM_ERROR;
+}
+
 static void vof_claimed_dump(GArray *claimed)
 {
     int i;
@@ -986,6 +1193,8 @@ static uint32_t vof_client_handle(MachineState *ms, void *fdt, Vof *vof,
         ret = vof_package_to_path(fdt, args[0], args[1], args[2]);
     } else if (cmpserv("instance-to-path", 3, 1)) {
         ret = vof_instance_to_path(fdt, vof, args[0], args[1], args[2]);
+    } else if (cmpserv("seek", 3, 1)) {
+        ret = vof_seek(vof, args[0], args[1], args[2]);
     } else if (cmpserv("write", 3, 1)) {
         ret = vof_write(vof, args[0], args[1], args[2]);
     } else if (cmpserv("read", 3, 1)) {
-- 
2.55.0


