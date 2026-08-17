Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB231C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvua5-0000mZ-VJ; Mon, 17 Aug 2026 06:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvua4-0000lp-Bw; Mon, 17 Aug 2026 06:28:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvua2-0008DN-9x; Mon, 17 Aug 2026 06:28:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVukN3728188; Mon, 17 Aug 2026 10:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GD1yJKTR4btE5T37d
 Xl/pRGrEOAy80pZdSV8FuS1//0=; b=bLT10nbafocfZ3Rzp3Dc9kOhG8/h11VkW
 SfsaG6JxMhGBSl0e0btuLEB0ISCMMBjx0yiJ8YIVaQtcuPFVutcT0ezGyzjkb4Cq
 P+ZzA27UBdt7KfEAtB/QU0/2Jx5RDzErSvxiI4t+DSRo5SNwDJxKDyn4+S/unaEk
 umKU4NGBwZNTXMgrxv5lVPHm99GTyexgYW2ZPZj6qQNSeH8z1FvNnMS8BLr7VV/x
 Xik7a7VchJ3/qoA+hUiDZspzB0y9xfpack752vmpSGCvkqF6NTkfu5lGj/gBGsfb
 zxZJY2U4Eev9pSL5iZ6Qk5L7eFHBL2u8SIyBfcOfapOxQqc2nHeUw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4hraa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQRq8019280;
 Mon, 17 Aug 2026 10:28:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejwmny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HASRcM55050602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:28:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B1E658058;
 Mon, 17 Aug 2026 10:28:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F25B15805B;
 Mon, 17 Aug 2026 10:28:19 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:28:19 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 1/8] ppc/spapr: add PReP boot partition detection
Date: Mon, 17 Aug 2026 15:57:18 +0530
Message-ID: <20260817102733.605346-2-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: oV-KZKqb55rdEi1UHhTrI0bRexn5d_xu
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82e24d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=n8BdF2ktrfXooMQ4x7UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfXxnhpCZKN69gc
 byjMPGSKyGU4nmYb//z0PO6Yw7x4JsPM/XE1TSWYRMKPznJTfa8KBb+6GY8qZihSIdYMbY5QwnM
 bgHa2+89szfUwWiFsaSwpILUUlfgrZs=
X-Proofpoint-ORIG-GUID: Iznyn5DlN3nFkBPy-K-5UqTYgWvz7Jk6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX2WLLbm2JU38z
 k4mvIeT09YsI6698ikSUNS+St++oj84My4x4sb/bkdCXFI0Iay1gGbPie3qKrLr2RZkm2VzFI1A
 +69wRvU+Y2PkywTABcBNVBrZMkBDbhGYXZ4itHFRncQhiX/EYmiG2580cHi8Qh8+6CGo1SAkKZH
 qHVJJE4ExNuFO/lBLqGMd099hWzFLBKb7sGPm1fycsSLi1bXwnQYHeBQt9yoGCzNc9g+D7sSkGo
 edHY0OHJ2jc6fgy8ec+Ou01R0LGeNONEnEecCu+UsuFzhawwDWP8f7l7HTMkpjElszfH4a+nxXy
 E23xcURfTxbO5NQG54DTjaF4uhBWBhm51Ku1Yqc41sthA3OlnkUKxpZlCY5XaKbb8kKMGCl+Mp8
 HYgs493p/DX551hVdVLTbveHCVzMGrc/YFJPVPJSo09UA877dZuOquj6fCsIvHfVL4jOrbEQvBe
 VGBOyps7du5kHniEiZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
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

Add spapr_vof_partition.c which implements basic MBR and GPT partition
table scanning to locate the PReP boot partition during VOF enabled boot.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/meson.build           |   5 +-
 hw/ppc/spapr_vof_partition.c | 176 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_vof.h   |  14 +++
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_vof_partition.c
 create mode 100644 include/hw/ppc/spapr_vof.h

diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 37aa535db2..68a5d2622f 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -93,6 +93,9 @@ ppc_ss.add(when: 'CONFIG_AMIGAONE', if_true: files('amigaone.c'))
 ppc_ss.add(when: 'CONFIG_PEGASOS', if_true: files('pegasos.c'))
 
 ppc_ss.add(when: 'CONFIG_VOF', if_true: files('vof.c'))
-ppc_ss.add(when: ['CONFIG_VOF', 'CONFIG_PSERIES'], if_true: files('spapr_vof.c'))
+ppc_ss.add(when: ['CONFIG_VOF', 'CONFIG_PSERIES'], if_true: files(
+  'spapr_vof.c',
+  'spapr_vof_partition.c',
+))
 
 hw_arch += {'ppc': ppc_ss}
diff --git a/hw/ppc/spapr_vof_partition.c b/hw/ppc/spapr_vof_partition.c
new file mode 100644
index 0000000000..ced2818998
--- /dev/null
+++ b/hw/ppc/spapr_vof_partition.c
@@ -0,0 +1,176 @@
+/*
+ * QEMU PowerPC sPAPR VOF Partition Table Support.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This implements partition table detection for VOF boot,
+ * supporting MBR and GPT partition tables with focus on PReP boot partition.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/error-report.h"
+#include "system/block-backend-io.h"
+#include "hw/ppc/spapr_vof.h"
+
+#define SECTOR_SIZE              512
+#define MBR_PARTITION_ENTRY_SIZE 16
+#define MBR_PARTITION_TABLE_OFFSET 446
+#define MBR_NUM_PARTITIONS       4
+
+#define PARTITION_TYPE_PREP      0x41  /* PReP Boot partition */
+#define PARTITION_TYPE_GPT       0xEE
+
+#define GPT_SIGNATURE            "EFI PART"
+#define GPT_SIGNATURE_SIZE       8
+
+/* PReP Boot: 9E1A2D38-C612-4316-AA26-8B49521E5A8B */
+static const uint8_t GUID_PREP_BOOT[16] = {
+    0x38, 0x2D, 0x1A, 0x9E, 0x12, 0xC6, 0x16, 0x43,
+    0xAA, 0x26, 0x8B, 0x49, 0x52, 0x1E, 0x5A, 0x8B
+};
+
+typedef struct MBRPartitionEntry {
+    uint8_t  boot_flag;
+    uint8_t  start_chs[3];
+    uint8_t  type;
+    uint8_t  end_chs[3];
+    uint32_t start_lba;
+    uint32_t num_sectors;
+} QEMU_PACKED MBRPartitionEntry;
+
+typedef struct GPTHeader {
+    char     signature[8];
+    uint32_t revision;
+    uint32_t header_size;
+    uint32_t header_crc32;
+    uint32_t reserved;
+    uint64_t current_lba;
+    uint64_t backup_lba;
+    uint64_t first_usable_lba;
+    uint64_t last_usable_lba;
+    uint8_t  disk_guid[16];
+    uint64_t partition_entries_lba;
+    uint32_t num_partition_entries;
+    uint32_t partition_entry_size;
+    uint32_t partition_array_crc32;
+} QEMU_PACKED GPTHeader;
+
+typedef struct GPTPartitionEntry {
+    uint8_t  type_guid[16];
+    uint8_t  partition_guid[16];
+    uint64_t first_lba;
+    uint64_t last_lba;
+    uint64_t attributes;
+    uint16_t name[36];
+} QEMU_PACKED GPTPartitionEntry;
+
+static bool find_prep_partition_gpt(BlockBackend *blk,
+                                    uint64_t *offset, uint64_t *size)
+{
+    uint8_t lba1[SECTOR_SIZE];
+    GPTHeader *header;
+    uint64_t entries_lba;
+    uint32_t num_entries;
+    uint32_t entry_size;
+    uint64_t current_entry_offset;
+    uint8_t *buf;
+    GPTPartitionEntry *current_entry;
+    uint32_t i;
+    int ret;
+
+    ret = blk_pread(blk, SECTOR_SIZE, SECTOR_SIZE, lba1, 0);
+    if (ret < 0) {
+        warn_report("GPT: failed to read LBA1 (ret=%d)", ret);
+        return false;
+    }
+
+    header = (GPTHeader *)lba1;
+
+    if (memcmp(header->signature, GPT_SIGNATURE, GPT_SIGNATURE_SIZE) != 0) {
+        return false;
+    }
+
+    entries_lba = le64_to_cpu(header->partition_entries_lba);
+    num_entries = le32_to_cpu(header->num_partition_entries);
+    entry_size = le32_to_cpu(header->partition_entry_size);
+
+    if (num_entries > 128) {
+        num_entries = 128;
+    }
+
+    if (entry_size < 128) {
+        return false;
+    }
+
+    buf = g_malloc(entry_size);
+    for (i = 0; i < num_entries; i++) {
+        current_entry_offset = (entries_lba * SECTOR_SIZE) +
+                               ((uint64_t)i * entry_size);
+
+        ret = blk_pread(blk, current_entry_offset, entry_size, buf, 0);
+        if (ret < 0) {
+            warn_report("GPT: failed to read partition entry %u "
+                        "(ret=%d)", i, ret);
+            g_free(buf);
+            return false;
+        }
+
+        current_entry = (GPTPartitionEntry *)buf;
+        if (memcmp(current_entry->type_guid, GUID_PREP_BOOT,
+                   sizeof(GUID_PREP_BOOT)) == 0) {
+            *offset = le64_to_cpu(current_entry->first_lba) * SECTOR_SIZE;
+            *size = (le64_to_cpu(current_entry->last_lba) -
+                     le64_to_cpu(current_entry->first_lba) + 1) * SECTOR_SIZE;
+            g_free(buf);
+            return true;
+        }
+    }
+    g_free(buf);
+    return false;
+}
+
+static bool find_prep_partition_mbr(BlockBackend *blk,
+                                    uint64_t *offset, uint64_t *size)
+{
+    uint8_t mbr[SECTOR_SIZE];
+    MBRPartitionEntry *entry;
+    int ret;
+    int i;
+
+    ret = blk_pread(blk, 0, SECTOR_SIZE, mbr, 0);
+    if (ret < 0) {
+        warn_report("MBR: failed to read MBR sector (ret=%d)", ret);
+        return false;
+    }
+
+    /* MBR boot signature: byte 510 = 0x55, byte 511 = 0xAA */
+    if (mbr[510] != 0x55 || mbr[511] != 0xAA) {
+        return false;
+    }
+
+    for (i = 0; i < MBR_NUM_PARTITIONS; i++) {
+        entry = (MBRPartitionEntry *)&mbr[MBR_PARTITION_TABLE_OFFSET +
+                                          i * MBR_PARTITION_ENTRY_SIZE];
+
+        if (entry->type == PARTITION_TYPE_GPT) {
+            return find_prep_partition_gpt(blk, offset, size);
+        }
+
+        if (entry->type == PARTITION_TYPE_PREP) {
+            *offset = (uint64_t)le32_to_cpu(entry->start_lba) * SECTOR_SIZE;
+            *size = (uint64_t)le32_to_cpu(entry->num_sectors) * SECTOR_SIZE;
+            return true;
+        }
+    }
+    return false;
+}
+
+bool spapr_vof_find_prep_partition(BlockBackend *blk,
+                                   uint64_t *offset, uint64_t *size)
+{
+    if (!blk) {
+        return false;
+    }
+    return find_prep_partition_mbr(blk, offset, size);
+}
diff --git a/include/hw/ppc/spapr_vof.h b/include/hw/ppc/spapr_vof.h
new file mode 100644
index 0000000000..08787d2aeb
--- /dev/null
+++ b/include/hw/ppc/spapr_vof.h
@@ -0,0 +1,14 @@
+/*
+ * QEMU PowerPC sPAPR VOF Support
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_SPAPR_VOF_H
+#define HW_SPAPR_VOF_H
+
+typedef struct BlockBackend BlockBackend;
+
+bool spapr_vof_find_prep_partition(BlockBackend *blk,
+                                   uint64_t *offset, uint64_t *size);
+
+#endif /* HW_SPAPR_VOF_H */
-- 
2.54.0


