Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71599C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvube-0003Ei-Ds; Mon, 17 Aug 2026 06:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvub1-0001r5-C0; Mon, 17 Aug 2026 06:29:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuax-0008UK-20; Mon, 17 Aug 2026 06:29:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLW8TL3685569; Mon, 17 Aug 2026 10:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OHg96fluuMUvfLYTx
 HtOZrorm0qoK32ztsh6mIDQGIo=; b=JeAya4uzAHXAXLvPMX4G6b8oQFypRAN2G
 IpxGyXibe2IrloyO2hYemnE2+tlXG+kjg3C+F2viblOplRlz2XOe17OJx1vtEZYW
 zyaAaxZsYtljyqJC8aqFnrhjSlYaeLktNpMtWiLD+y0ecSLiNZXhGayJ24KRlTVc
 24tt+o21Qfj77lsBXQ+bgDiMSsMcGD3SPsIBfl8HZHkGDXe5NWVWTSxnwCVK8Z1U
 xTM5cj9S4VMlGqyXGHwW83601adx94WWJOPfMuy3QRHATzkAMLiRcsZvMdBF0jFx
 Emwpt/lKnHKaYjm04cxhEe2vQ9VRMmjk2t6GH/1IKpWxrWgvCm49w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3hrnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQURg019302;
 Mon, 17 Aug 2026 10:29:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejwmr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HATMs930999110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:29:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C5875805B;
 Mon, 17 Aug 2026 10:29:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A86658058;
 Mon, 17 Aug 2026 10:29:15 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:29:14 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 8/8] ppc/spapr: implement vscsi-report-luns call-method
 for PAPR vSCSI
Date: Mon, 17 Aug 2026 15:57:25 +0530
Message-ID: <20260817102733.605346-9-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rj3Gmq1nGhDkUoScYYo0Ogi4L_tio3O9
X-Proofpoint-ORIG-GUID: Qr72eLA6ZRfFh4mcSCREuCcmfS8TNi1s
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX1gRcJGbPa6VE
 g0aHdgat200R4HEM0p6+LhBc7VPOx54qMqnmkMZJ9tGV/WjbqfLmJ/VQ8kZKADXCsaETZUB0Fiq
 JcKd6RYA7sYIUcPLE7Cfo8CrcXAsWXg=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a82e285 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rYZidSWV3caZqrqzPaQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX46GMQPOTVe2r
 X4w6hiRiLw5xG9V+XhHzn/3vCQYDgaOjzBZXZsLLcechFC/1xIkTTW0LoYvX58kfAUJC/kxRNPB
 qotWvj+XngcDAvkiS4BKNqBJbHFPOs31nKDVOmtb9/M3d71DbFK6KxnBkLbj07C1cGScZB7BGjH
 lYwBs0ZjzrMAaWys8tIDIGwy3CGX4hNOsArzW0riTBT3agOGjxTCQFn+NQpaqmsTATbn6i4Ln69
 w/aq26W0PcgdMV0zAhydr58hKpdtOvy9d1RDW1k+UWcrFMLXUGKeMr7UZBZwi4JgDqm4l3MU9J/
 BbHgeVOGbtCaU4ObRHCLfcNxca46MYlAWKwsmHwksituA5Z6DxX87T25+3dXibgd2gAgn243WZR
 rvG4SyQn5zP/u3cAXblo0Gz6YglCQysEvMmN6nISSu2VvGMv+01bXK1janpqsN9wDuvRYm9aW4B
 +myt1WEM/fLRfOuHOUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

GRUB (grub-core/disk/ieee1275/ofdisk.c) calls "vscsi-report-luns" on
any PAPR virtual SCSI controller ihandle to enumerate attached LUNs
before attempting to boot from disk. Without this method VOF returns
PROM_ERROR and GRUB cannot find vSCSI disks.

Add vof_find_vscsi_bus() to locate the SCSIBus from a v-scsi@<reg>
instance path, and vof_vscsi_report_luns() to build the response table
in the VOF firmware region (0..fw_size), which GRUB never claims.

The table layout and SRP LUN encoding follow SLOF (vio-vscsi.fs
dev-generate-srplun) each entry is an 8-byte big-endian cell whose
low 4 bytes hold a guest pointer to a null-terminated list of SRP LUNs
for that target; GRUB reads the pointer at offset table + 4 + 8*i.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/vof.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index d3b0df30e4..b1bf5b1af0 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -991,6 +991,198 @@ static void vof_instantiate_rtas(Error **errp)
     error_setg(errp, "The firmware should have instantiated RTAS");
 }
 
+#ifdef CONFIG_PSERIES
+/* Combined (channel<<6)|id index space, matches SLOF dev-max-target. */
+#define VSCSI_MAX_TARGETS 512
+
+/*
+ * Build the vscsi-report-luns response in guest memory.
+ *
+ * Returns catch_result (0 = success).  On success, *nentries_out and
+ * *table_addr_out describe the result table written into the VOF firmware
+ * region (0..fw_size), which GRUB never claims.
+ *
+ * Table layout (big-endian, 8 bytes per entry):
+ *   [table_addr + 8*i + 0..3] : 0x00000000
+ *   [table_addr + 8*i + 4..7] : guest pointer to null-terminated SRP LUN list
+ *
+ * GRUB reads each pointer as: *(uint32_t *)(table + 4 + 8 * i)
+ *
+ * SRP LUN encoding (SLOF dev-generate-srplun):
+ *   srplun = (0x8000 | bus | target | lun) << 48
+ *   where bus    = (combined_target >> 1) & 0x70
+ *         target = (combined_target & 0x3f) << 8
+ *         combined_target = (channel << 6) | id
+ */
+static uint32_t vof_vscsi_report_luns(Vof *vof,
+                                       SCSIBus *sbus,
+                                       uint32_t *nentries_out,
+                                       uint32_t *table_addr_out)
+{
+    uint64_t *lun_lists[VSCSI_MAX_TARGETS];
+    int lun_counts[VSCSI_MAX_TARGETS];
+    uint32_t ptr_table_size;
+    uint32_t lun_data_size;
+    uint32_t total_size;
+    uint32_t base_addr;
+    uint32_t lun_data_base;
+    uint32_t lun_data_off;
+    uint32_t table_idx;
+    uint32_t table_addr;
+    BusChild *kid;
+    int nentries = 0;
+    int t;
+
+    memset(lun_lists, 0, sizeof(lun_lists));
+    memset(lun_counts, 0, sizeof(lun_counts));
+
+    QTAILQ_FOREACH(kid, &sbus->qbus.children, sibling) {
+        SCSIDevice *dev = SCSI_DEVICE(kid->child);
+        int combined_target;
+        uint64_t bus_field;
+        uint64_t target_field;
+        uint64_t lun_field;
+        uint64_t srplun;
+        int cnt;
+
+        /* combined_target = (channel << 6) | id, matching SLOF bus+target */
+        combined_target = ((dev->channel & 0x7) << 6) | (dev->id & 0x3f);
+        if (combined_target >= VSCSI_MAX_TARGETS) {
+            continue;
+        }
+
+        bus_field    = ((uint64_t)combined_target >> 1) & 0x70ULL;
+        target_field = ((uint64_t)combined_target & 0x3fULL) << 8;
+        lun_field    = (uint64_t)(dev->lun & 0x1f);
+        srplun = (0x8000ULL | bus_field | target_field | lun_field) << 48;
+
+        cnt = lun_counts[combined_target];
+        lun_lists[combined_target] = g_realloc(lun_lists[combined_target],
+                                               (cnt + 2) * sizeof(uint64_t));
+        lun_lists[combined_target][cnt]     = cpu_to_be64(srplun);
+        lun_lists[combined_target][cnt + 1] = 0;
+        lun_counts[combined_target]++;
+        if (cnt == 0) {
+            nentries++;
+        }
+    }
+
+    if (nentries == 0) {
+        *nentries_out   = 0;
+        *table_addr_out = 0;
+        return 0;
+    }
+
+    ptr_table_size = nentries * sizeof(uint64_t);
+    lun_data_size  = 0;
+    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
+        if (lun_lists[t]) {
+            lun_data_size += (lun_counts[t] + 1) * sizeof(uint64_t);
+        }
+    }
+    total_size = ptr_table_size + lun_data_size;
+
+    /*
+     * Place the table in the VOF firmware region (0..fw_size), which GRUB
+     * never claims.  Fit into the top of the first 4 KB page, 8-byte aligned.
+     */
+    if (total_size <= 0x1000 - (uint32_t)vof->fw_size) {
+        base_addr = (0x1000 - total_size) & ~7U;
+    } else {
+        base_addr = 0x800;
+    }
+
+    table_addr    = base_addr;
+    lun_data_base = base_addr + ptr_table_size;
+    lun_data_off  = 0;
+    table_idx     = 0;
+
+    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
+        uint32_t lun_buf_size;
+        uint32_t lun_buf_addr;
+        uint64_t cell_be64;
+
+        if (!lun_lists[t]) {
+            continue;
+        }
+
+        lun_buf_size = (lun_counts[t] + 1) * sizeof(uint64_t);
+        lun_buf_addr = lun_data_base + lun_data_off;
+
+        if (VOF_MEM_WRITE(lun_buf_addr, lun_lists[t], lun_buf_size)
+                != MEMTX_OK) {
+            goto write_err;
+        }
+
+        cell_be64 = cpu_to_be64((uint64_t)lun_buf_addr);
+        if (VOF_MEM_WRITE(table_addr + table_idx * sizeof(uint64_t),
+                          &cell_be64, sizeof(cell_be64)) != MEMTX_OK) {
+            goto write_err;
+        }
+
+        lun_data_off += lun_buf_size;
+        table_idx++;
+    }
+
+    *nentries_out   = table_idx;
+    *table_addr_out = table_addr;
+
+    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
+        g_free(lun_lists[t]);
+    }
+    return 0;
+
+write_err:
+    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
+        g_free(lun_lists[t]);
+    }
+    return PROM_ERROR;
+}
+
+/*
+ * Return the SCSIBus for a v-scsi@<reg> path, or NULL if not found.
+ * Handles both "/vdevice/v-scsi@<reg>" and ".../v-scsi@<reg>/disk@..." paths.
+ */
+static SCSIBus *vof_find_vscsi_bus(MachineState *ms, const char *path)
+{
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
+    return NULL;
+}
+#endif /* CONFIG_PSERIES */
+
 static uint32_t vof_call_method(MachineState *ms, Vof *vof, uint32_t methodaddr,
                                 uint32_t ihandle, uint32_t param1,
                                 uint32_t param2, uint32_t param3,
@@ -1014,6 +1206,26 @@ static uint32_t vof_call_method(MachineState *ms, Vof *vof, uint32_t methodaddr,
         goto trace_exit;
     }
 
+#ifdef CONFIG_PSERIES
+    /* vscsi-report-luns: enumerate LUNs for GRUB */
+    if (strcmp(method, "vscsi-report-luns") == 0) {
+        SCSIBus *sbus = vof_find_vscsi_bus(ms, inst->path);
+
+        if (sbus) {
+            uint32_t nentries = 0, table_addr = 0;
+            ret = vof_vscsi_report_luns(vof, sbus, &nentries, &table_addr);
+            ret2[0] = nentries;
+            ret2[1] = table_addr;
+        } else {
+            ret = 1;
+            ret2[0] = 0;
+            ret2[1] = 0;
+        }
+        trace_vof_method(ihandle, method, param1, ret, ret2[0]);
+        goto trace_exit;
+    }
+#endif /* CONFIG_PSERIES */
+
     if (strcmp(inst->path, "/") == 0) {
         if (strcmp(method, "ibm,client-architecture-support") == 0) {
             Object *vmo = object_dynamic_cast(OBJECT(ms), TYPE_VOF_MACHINE_IF);
-- 
2.54.0


