Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD3BC5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuai-0001BA-Am; Mon, 17 Aug 2026 06:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuah-0001A0-7S; Mon, 17 Aug 2026 06:29:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaf-0008O9-Bp; Mon, 17 Aug 2026 06:29:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVuiI2629279; Mon, 17 Aug 2026 10:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lWDTYqjxZ6k2JMMKR
 D4C+jLc/xxIgx2Zk2wj3sojIaI=; b=VjqfOjCDvehkyjFc3BHLD5lpEZToK7KHK
 NOyPzEMijDq6jkZLuZIa1mU4qTWbgoAka0+AqhZUM/GVmye09AsFfGMGvQVLQPLi
 EYhVqFCa428P9IMzvBGN3VQ+MNY88GnIXK9HF/FqaJLVI/90jYMo9xN73nyiylWZ
 uI/IDCvn0Eiweh9gUxo/wLIoJrbYYz65+WvXccc8+v2Pz7x3zkzWxDwydIfWfzaO
 0Ru9ZCh+ej5fnZ6sYwpwDzsYLe4LvFHjvPEgnKdACusvC8Id/iBxGtCSlqmIQLnw
 q5lyBs4egeJ3EwQG9h+y+9a26gKgdzjHOAQXpx3XWjwKCknkwRu4A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe1jg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQURb019302;
 Mon, 17 Aug 2026 10:29:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejwmq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HASwx518547418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:28:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CC745805C;
 Mon, 17 Aug 2026 10:28:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AE065805B;
 Mon, 17 Aug 2026 10:28:51 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:28:51 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 5/8] ppc/spapr: add block device backend to VOF
 open/read/write/seek services
Date: Mon, 17 Aug 2026 15:57:22 +0530
Message-ID: <20260817102733.605346-6-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX/BT6kqAH1swn
 dlMpn0Fc6lsQayb42sP9IlO58FvIiM/tMmUxfP4xSu4+7cblhqI6bFHw8RMGU6weqNeAuu3Qj4z
 9LZs5qgFsWPNuiRnQXBJQJVTe8VM+mNlTVEEjBTf7tsdpvjXKiP+9XmqjsIWNGpAaKY7D8XKM40
 XV8OpXYlFYOCYHBvOa503Bnru8/cK4spkhM3oUfbqVoXo62MHYSMPAogN8oZQE8hzu6qWiTQAUb
 Vu3LB+hjwDWl1/w2zqehfMM4TQdOstxl+ctL51CLH5m3v7fnOkBEr8BH2Foln6Uc0inrGWKfR7+
 0GEUUlNbDutD3JwOzOnLAqR1B+9LDgWrKhJvjnzrCVrfsdVrfcF/zMREeh4c5vN8aCNifiW6Fv1
 midRb2yorU2gipWj/Rmku7J/Eg/nAfkgbXMny0wnA67i1E2amuL+r5eMbXazLNZpiZKxf3+CTHo
 rjKpSkZ8OBTVh+/pIHg==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a82e26d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=jPRefoL-jKG6ujQr-m8A:9
X-Proofpoint-ORIG-GUID: V_M1pHA6abwW27VH8Gbvm8peTe0r9IuE
X-Proofpoint-GUID: ki9wzESAlgj5le6iiTzVzwzJ_zrV3AnG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX9rPr4wtv2W3d
 EMAh33G6OS9tyxxMJ5npOJH19Qqu6BsBiBC+gQDF/Ckr3/FTgmgrE+R2IQRGL2Y2sf9qJEV4ena
 6SFfgwAr5FGfNiF3C3vdogXUFXkEWQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

In vof_do_open(), detect FDT nodes named "disk@<srp-lun>" and resolve
the SRP LUN encoding to the matching SCSIDevice/BlockBackend by scanning
id/channel/lun.

Add vof_seek() to implement the OpenFirmware "seek" client service,
which was previously missing.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/trace-events |   2 +
 hw/ppc/vof.c        | 116 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

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
index 45c197df9f..b1c574aabf 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -11,6 +11,7 @@
 
 #include CONFIG_DEVICES /* CONFIG_PSERIES */
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
@@ -24,6 +25,8 @@
 #include "trace.h"
 
 #include "hw/ppc/spapr_vio.h"
+#include "hw/scsi/scsi.h"
+#include "system/block-backend.h"
 #include <libfdt.h>
 
 /*
@@ -46,6 +49,8 @@ typedef struct {
 typedef struct {
     char *path; /* the path used to open the instance */
     uint32_t phandle;
+    BlockBackend *blk;
+    uint64_t pos; /* current position for seek operations */
     void *vty;
 } OfInstance;
 
@@ -449,6 +454,7 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, int offset, const char *path)
 {
     uint32_t ret = PROM_ERROR;
     OfInstance *inst = NULL;
+    const char *node_name;
 
     if (vof->of_instance_last == 0xFFFFFFFF) {
         /* We do not recycle ihandles yet */
@@ -461,10 +467,42 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, int offset, const char *path)
     ++vof->of_instance_last;
 
     inst->path = g_strdup(path);
+    inst->blk = NULL;
+    inst->pos = 0;
     inst->vty = NULL;
 
+    node_name = fdt_get_name(fdt, offset, NULL);
+
+    if (node_name && strncmp(node_name, "disk@", 5) == 0) {
+        uint64_t srp_lun;
+        uint32_t id, channel, lun;
+        BlockBackend *blk;
+
+        if (qemu_strtou64(node_name + 5, NULL, 16, &srp_lun) == 0) {
+            id      = (srp_lun >> 56) & 0x3f;
+            channel = (srp_lun >> 53) & 0x7;
+            lun     = (srp_lun >> 48) & 0x1f;
+
+            for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+                DeviceState *attached = blk_get_attached_dev(blk);
+                SCSIDevice *sdev;
+
+                if (!attached) {
+                    continue;
+                }
+                sdev = (SCSIDevice *)object_dynamic_cast(OBJECT(attached),
+                                                         TYPE_SCSI_DEVICE);
+                if (sdev && sdev->id == (int)id &&
+                    sdev->channel == (int)channel &&
+                    sdev->lun == (int)lun) {
+                    inst->blk = blk;
+                    break;
+                }
+            }
+        }
+    }
+
 #ifdef CONFIG_PSERIES
-    const char *node_name = fdt_get_name(fdt, offset, NULL);
     if (node_name && strncmp(node_name, "vty", 3) == 0) {
         uint8_t discard_buf[VOF_VTY_BUF_SIZE];
         MachineState *ms = MACHINE(qdev_get_machine());
@@ -601,6 +639,25 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
         return PROM_ERROR;
     }
 
+    if (inst->blk) {
+        g_autofree uint8_t *blkbuf = g_malloc(len);
+        int ret;
+
+        if (VOF_MEM_READ(buf, blkbuf, len) != MEMTX_OK) {
+            trace_vof_error_write(ihandle);
+            return PROM_ERROR;
+        }
+        ret = blk_pwrite(inst->blk, inst->pos, len, blkbuf, 0);
+        if (ret < 0) {
+            trace_vof_error_write(ihandle);
+            return PROM_ERROR;
+        }
+        blk_flush(inst->blk);
+        inst->pos += len;
+        trace_vof_write(ihandle, len, "(disk)");
+        return len;
+    }
+
 #ifdef CONFIG_PSERIES
     if (inst->vty) {
         uint32_t total_written = 0;
@@ -646,6 +703,26 @@ static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
         return PROM_ERROR;
     }
 
+    if (inst->blk) {
+        g_autofree uint8_t *tmp = g_malloc(len);
+        int ret;
+
+        ret = blk_pread(inst->blk, inst->pos, len, tmp, 0);
+        if (ret < 0) {
+            trace_vof_error_read(ihandle);
+            return PROM_ERROR;
+        }
+
+        if (VOF_MEM_WRITE(buf, tmp, len) != MEMTX_OK) {
+            trace_vof_error_read(ihandle);
+            return PROM_ERROR;
+        }
+
+        inst->pos += len;
+        trace_vof_read(ihandle, len, "(disk)");
+        return len;
+    }
+
 #ifdef CONFIG_PSERIES
     if (inst->vty) {
         uint8_t tmp[VOF_VTY_BUF_SIZE];
@@ -675,6 +752,41 @@ static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
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
@@ -985,6 +1097,8 @@ static uint32_t vof_client_handle(MachineState *ms, void *fdt, Vof *vof,
         ret = vof_package_to_path(fdt, args[0], args[1], args[2]);
     } else if (cmpserv("instance-to-path", 3, 1)) {
         ret = vof_instance_to_path(fdt, vof, args[0], args[1], args[2]);
+    } else if (cmpserv("seek", 3, 1)) {
+        ret = vof_seek(vof, args[0], args[1], args[2]);
     } else if (cmpserv("write", 3, 1)) {
         ret = vof_write(vof, args[0], args[1], args[2]);
     } else if (cmpserv("read", 3, 1)) {
-- 
2.54.0


