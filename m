Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCE6CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVpX-0000Vu-2k; Fri, 02 Oct 2026 01:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVp6-0008Su-0O; Fri, 02 Oct 2026 01:28:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVp3-00083Z-Vs; Fri, 02 Oct 2026 01:28:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922aEvA3548979; Fri, 2 Oct 2026 05:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QEduXL
 n7dwHyWUBEfUgLbXehXDjJUzjg1tc7yCdBCag=; b=hlVuPi8W02RJssHiKXuYe0
 btSpmCa68mlAVs/LkyiXyRybssKNgZOKjUoUQjgtkiO8c6rcqovsqr76LyljdBlI
 BL2WQQT2pT64HEctnsmT6PHEm3DiODnHeNqpKHlRT7rRwasyqClKiAegg9egMqTx
 e7ANyG54PqGIcMMpVWZJQSp5KhEbmf7L0G6qdSp0OBDEcCUpXNAMwwUR2cJ39+z0
 eH2SwAao4dy8P6JO7dokD8Z6gOj87SvDDtIxWLpEZ9AkyqtT0uLdp6jgCIa4lgtd
 sraTL1g1ZXTt/WJBInIeV7g45p00GMV/ezTJRmd2dyrl2DeP85jWS893iBqXf4Cg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5qsc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922Z6Qv1855161; Fri, 2 Oct 2026 05:28:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcshhpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6925SVKR4719454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 05:28:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C27958052;
 Fri,  2 Oct 2026 05:28:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 717035805A;
 Fri,  2 Oct 2026 05:28:22 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.111.176]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 05:28:22 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH v2 8/8] ppc/spapr: implement vscsi-report-luns call-method
 for PAPR vSCSI
Date: Fri,  2 Oct 2026 10:55:47 +0530
Message-ID: <20261002052605.605858-9-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfXwMTItTxOF5ZT
 l+SDIdLIAMQmZUM02sVi0Wx7xdSwJjVk27ce1rzKR9LOBHgAsuechH0UC22j5G6Z0ncZTUbq4vp
 pXJvuplYM6D0CSHiCmN8GKuim6nSc0Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX6KNA/vSx5369
 qhexwBSmqg8FiWHsMBKYuR40fzy2RqJP1wobCENa62D1b3Y7/xY889qz+oaOwJ0px1OaSu5uEu5
 4XK9jmjqbDsD13dqSdNyOFkUUOeByUXBZUbzLvkGWvjT3jciqmjxRHiE+03UEi4LBElzdbsGSga
 dXVZ3NlqVdR438r0Q8Dd3tZhD5Fm6lGJpcq1EvH0g7GrqewCZyXNbVU4+ZGWi+wbHPGD+gdl+SR
 J35SjTdroVStNvTqpph78sG8PagGje4B8QspNPGAgJLsC4gKf853wZ5ypt9OxLOtmCp/XMpFzgU
 27Swk+Ne6H/JwOU+QkqEBDxKQqx5gam4vKjWqi0oJ352Veh0h1mD0roda1hjbIm1FPUFi4m6LMn
 F4W2N+5mlInvl40by/tu94RYOIzCgpkQQ0XxijXuCOrAPiYFiCZOR6nz4mYtexCkHa+K0SHiDMP
 zjdrEsr2lK+8lPNBn9w==
X-Proofpoint-GUID: mK_NmP2l7t_mTjGtwc741rHRqGK78EY2
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abf4102 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=QkoNu6Jh_I66vS5nlkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9hP5X5HAbK7xFKRD2ouksdX2CgqCoc5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add vof_vscsi_report_luns() to build the LUN response table in guest
memory and wire it into vof_call_method().

Place the table at a fixed address VSCSI_TABLE_BASE (0x10000), in the
free gap between the OF stack top and KERNEL_LOAD_ADDR, and cap its
size at VSCSI_TABLE_MAXSZ (64 KB).

The table layout and SRP LUN encoding follow SLOF (vio-vscsi.fs
dev-generate-srplun) each entry is an 8-byte big-endian cell whose
low 4 bytes hold a guest pointer to a null-terminated list of SRP LUNs
for that target; GRUB reads the pointer at offset
table + 4 + 8*i.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
Chaneglog:
v2:
- vof_find_vscsi_bus() moved to patch 5/8; this patch reuses it.
- Table placement changed from the VOF firmware region to the free gap
  between the OF stack top and KERNEL_LOAD_ADDR. Added VSCSI_TABLE_MAXSZ
  (64 KB) cap for table size.
- Rewritten the SRP LUN encoding in simplified manner.
---
 hw/ppc/vof.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 75b2398ae7..6fb39d62a9 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -31,6 +31,9 @@
 #include "block/block-io.h"
 #include <libfdt.h>
 
+#define VSCSI_TABLE_BASE   0x10000U
+#define VSCSI_TABLE_MAXSZ  0x10000U
+
 /*
  * OF 1275 "nextprop" description suggests is it 32 bytes max but
  * LoPAPR defines "ibm,query-interrupt-source-number" which is 33 chars long.
@@ -1086,6 +1089,143 @@ static void vof_instantiate_rtas(Error **errp)
     error_setg(errp, "The firmware should have instantiated RTAS");
 }
 
+#ifdef CONFIG_PSERIES
+/* Combined (channel<<6)|id index space, matches SLOF dev-max-target. */
+#define VSCSI_MAX_TARGETS 512
+
+/*
+ * Build the vscsi-report-luns response in guest memory.
+ *
+ * Returns catch_result (0 = success). On success, *nentries_out and
+ * *table_addr_out describe the result table written into the free gap
+ * between the stack top (0x10000) and KERNEL_LOAD_ADDR (0x400000).
+ *
+ * Table layout (big-endian, 8 bytes per entry):
+ *   [table_addr + 8*i + 0..3] : 0x00000000
+ *   [table_addr + 8*i + 4..7] : guest pointer to null-terminated SRP LUN list
+ *
+ * GRUB reads each pointer as: *(uint32_t *)(table + 4 + 8 * i)
+ */
+static uint32_t vof_vscsi_report_luns(SCSIBus *sbus,
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
+        uint64_t srplun;
+        int cnt;
+
+        combined_target = ((dev->channel & 0x7) << 6) | (dev->id & 0x3f);
+
+        /* SRP LUN: 0x8000 | (id << 8) | (channel << 5) | lun, in top 16 bits */
+        srplun = (0x8000ULL | ((dev->id & 0x3fULL) << 8)
+                             | ((dev->channel & 0x7ULL) << 5)
+                             | (dev->lun & 0x1fULL)) << 48;
+
+        cnt = lun_counts[combined_target];
+        lun_lists[combined_target] = g_realloc(lun_lists[combined_target],
+                                               (cnt + 2) * sizeof(uint64_t));
+        lun_lists[combined_target][cnt] = cpu_to_be64(srplun);
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
+     * Max table size capped at 64 KB, which comfortably covers
+     * 512 targets × ~16 LUNs each.
+     */
+    if (total_size > VSCSI_TABLE_MAXSZ) {
+        for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
+            g_free(lun_lists[t]);
+        }
+        return PROM_ERROR;
+    }
+    base_addr = VSCSI_TABLE_BASE;
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
+#endif /* CONFIG_PSERIES */
+
 static uint32_t vof_call_method(MachineState *ms, Vof *vof, uint32_t methodaddr,
                                 uint32_t ihandle, uint32_t param1,
                                 uint32_t param2, uint32_t param3,
@@ -1109,6 +1249,26 @@ static uint32_t vof_call_method(MachineState *ms, Vof *vof, uint32_t methodaddr,
         goto trace_exit;
     }
 
+#ifdef CONFIG_PSERIES
+    /* vscsi-report-luns: enumerate LUNs for GRUB */
+    if (strcmp(method, "vscsi-report-luns") == 0) {
+        SCSIBus *sbus = vof_find_vscsi_bus(ms, inst->path);
+
+        if (sbus) {
+            uint32_t nentries = 0, table_addr = 0;
+            ret = vof_vscsi_report_luns(sbus, &nentries, &table_addr);
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
2.55.0


