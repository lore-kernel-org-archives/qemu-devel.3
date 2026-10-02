Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A38CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVof-0008JM-3g; Fri, 02 Oct 2026 01:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVo5-0008F3-8t; Fri, 02 Oct 2026 01:27:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVo2-00080y-Q2; Fri, 02 Oct 2026 01:27:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922ZR313548244; Fri, 2 Oct 2026 05:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Xz6IQMJvcd99HMztJ
 TjPmClv2LvdyYKgXMxGqdftuBw=; b=SsllzcfRQ6h8jc/+3y+//zfbjzoR8iw3K
 L2zrHRu49XPM7mX9tuiBBHK3Nyyv3sjpQXKIuFTnSJE+a15SscaBQim8nXUTMEHE
 8Zn78UGZUQsiQDkwWNhU8KkzAtMHEFwesky+ON8mmBaf29NojVyAIWcrmB1L1lK/
 hJshCM81DbjZBZ0sOws3cSwiaNoHzCCssRT2Gq2JKVrG8mV/rsx8c/w5DOfsYF8H
 TM9xGJqupJKGJWyIqs+ugQrXm2+cKz3KGlFOlRLf1+I/wWZm+LKFPE4acUFt2m2U
 eqosJAW1sOUIuwWHctVnwx5CaH/mbTJAVFQAu9QVlegT1dQaMgecA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5qs9n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:27:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922KAJb1897664; Fri, 2 Oct 2026 05:27:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7xhe8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:27:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6925ROGw32047678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 05:27:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 368AE58056;
 Fri,  2 Oct 2026 05:27:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD0A858052;
 Fri,  2 Oct 2026 05:27:14 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.111.176]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 05:27:14 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH v2 1/8] ppc/spapr: add PReP boot partition detection
Date: Fri,  2 Oct 2026 10:55:40 +0530
Message-ID: <20261002052605.605858-2-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX0OwNT3rdZaKm
 1xDB/JyrDK6MYuQWFGoNQMOJc1XIwVvYMLi6hd3AkWOoHBZ+TG3Jcj6HMsRMgjqBKxRV4+m/oit
 dOjP6j4H5lOjBfP4n5MEOImklEW7Ygs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX6GL46w9QQ8Gy
 lb4Lh5slQK695nznoXnin3ucgutmEcpeJokiGro72b52wiTtSKl3QIJyJTrmxWWDEHXxABEy46T
 B5sSy7lReBW/rnhCobu5AsTRFwT3yG6qp3aQIbrsh9uNisl0b99Ftz4nDG1/uRBllue71UCs/Lo
 auDu5eBLlggYu4FnvJLxtT/8p3hnzrBuMyPrONt/tRa7NdI/pVZCaWn1KABj082bMKkqvOUX76T
 pt8H396D1HLD/u87xImYWxgqYGKQ0iDBM0MI30BoKuaRJ5pT0mVzEAuu46nKJbBHnNx3oT5HFcw
 AHHtE4jg11eiR7axsqdE0Zou75ISzR1InjAjLs9FPfyvtYX3z3OEf/yIB6rhcLXNYrQSncxzliQ
 KzLe56Z8TmQtFt+wokXP7gBEAcsAemm409V5/Dz4X5E7uCRkgl7uG0ouexeM2eBFzde/7ehLxVJ
 jjZOivR/GYgTuX8eYuQ==
X-Proofpoint-GUID: HibtK9Oej-h0piv6a62nfN0wUax65lvu
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abf40bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=8QURaz6fMi4Cysm5H64A:9
X-Proofpoint-ORIG-GUID: wWXBOclZpPiuQ_YGRTXn-uLY---74PEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
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

Add spapr_vof_partition.c which implements basic MBR and GPT partition
table scanning to locate the PReP boot partition during VOF enabled boot.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
Chaneglog:
v2:
- Added CRC validations for GPT.
- Added bounds checking GPT header size.
- Added new GPT_MAX_PARTITION to cap max partitions at 128
- Added bounds checking for the partition entry array against disk size
  for GPT.
- Switched GPT entry to use a fixed-size buffer instead of g_malloc per
  entry.
- Added validation for first_lba and last_lba in GPT before returning
  size.
- Added validation for MBR PReP partition entries(start_lba/num_sectors)
---
 hw/ppc/meson.build           |   5 +-
 hw/ppc/spapr_vof_partition.c | 272 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_vof.h   |  14 ++
 3 files changed, 290 insertions(+), 1 deletion(-)
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
index 0000000000..b495a53d9d
--- /dev/null
+++ b/hw/ppc/spapr_vof_partition.c
@@ -0,0 +1,272 @@
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
+#include <zlib.h>
+
+#define SECTOR_SIZE              512
+#define MBR_PARTITION_ENTRY_SIZE 16
+#define MBR_PARTITION_TABLE_OFFSET 446
+#define MBR_NUM_PARTITIONS       4
+
+#define PARTITION_TYPE_PREP      0x41  /* PReP Boot partition */
+#define PARTITION_TYPE_GPT       0xEE
+
+#define GPT_MAX_PARTITION        128
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
+    uint32_t header_size;
+    GPTHeader header_copy;
+    uint32_t crc_stored;
+    uint32_t crc_computed;
+    uint64_t entries_lba;
+    uint32_t num_entries;
+    uint32_t entry_size;
+    int64_t disk_size;
+    uint64_t disk_last_lba;
+    uint32_t array_bytes;
+    g_autofree uint8_t *array_buf = NULL;
+    uint8_t buf[sizeof(GPTPartitionEntry)];
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
+    /* EFI PART signature validation */
+    if (memcmp(header->signature, GPT_SIGNATURE, GPT_SIGNATURE_SIZE) != 0) {
+        return false;
+    }
+
+    /* GPT header size validation */
+    header_size = le32_to_cpu(header->header_size);
+    if (header_size < sizeof(GPTHeader) || header_size > SECTOR_SIZE) {
+        warn_report("GPT: invalid header size %u (expected %zu..%u)",
+                    header_size, sizeof(GPTHeader), SECTOR_SIZE);
+        return false;
+    }
+
+    /* CRC32 validation of GPT header */
+    header_copy = *header;
+    header_copy.header_crc32 = 0;
+    crc_stored = le32_to_cpu(header->header_crc32);
+    crc_computed = crc32(0, (uint8_t *)&header_copy, header_size);
+    if (crc_computed != crc_stored) {
+        warn_report("GPT: header CRC32 mismatch (computed=0x%08x "
+                    "stored=0x%08x)", crc_computed, crc_stored);
+        return false;
+    }
+
+    entries_lba = le64_to_cpu(header->partition_entries_lba);
+    num_entries = le32_to_cpu(header->num_partition_entries);
+    entry_size  = le32_to_cpu(header->partition_entry_size);
+
+    /*
+     * Usually the PReP is the first partition and most systems commonly have
+     * 128 max partitions, so cap the scan at 128
+     */
+    if (num_entries > GPT_MAX_PARTITION) {
+        warn_report("GPT: num_partition_entries %u exceeds %u, "
+                    "scanning only the first %u partitions", num_entries,
+                    GPT_MAX_PARTITION, GPT_MAX_PARTITION);
+        num_entries = GPT_MAX_PARTITION;
+    }
+
+    if (num_entries == 0) {
+        warn_report("GPT: partition table has no entries");
+        return false;
+    }
+
+    if (entry_size < sizeof(GPTPartitionEntry)) {
+        warn_report("GPT: partition entry size %u is too small", entry_size);
+        return false;
+    }
+
+    disk_size = blk_getlength(blk);
+    if (disk_size <= 0) {
+        warn_report("GPT: failed to get disk size");
+        return false;
+    }
+    disk_last_lba = (uint64_t)disk_size / SECTOR_SIZE - 1;
+
+    if (entries_lba >= UINT64_MAX / SECTOR_SIZE ||
+        entries_lba >= (uint64_t)disk_size / SECTOR_SIZE ||
+        num_entries > ((uint64_t)disk_size - entries_lba * SECTOR_SIZE)
+                       / entry_size) {
+        warn_report("GPT: partition entry array extends beyond disk");
+        return false;
+    }
+
+    /* CRC32 validation of GPT partition array */
+    array_bytes = num_entries * entry_size;
+    array_buf = g_malloc(array_bytes);
+    crc_stored = le32_to_cpu(header->partition_array_crc32);
+
+    ret = blk_pread(blk, entries_lba * SECTOR_SIZE, array_bytes, array_buf, 0);
+    if (ret < 0) {
+        warn_report("GPT: failed to read partition entry array for CRC "
+                    "(ret=%d)", ret);
+        return false;
+    }
+    crc_computed = crc32(0, array_buf, array_bytes);
+    if (crc_computed != crc_stored) {
+        warn_report("GPT: partition array CRC32 mismatch (computed=0x%08x "
+                    "stored=0x%08x)", crc_computed, crc_stored);
+        return false;
+    }
+
+    for (i = 0; i < num_entries; i++) {
+        uint64_t current_entry_offset = entries_lba * SECTOR_SIZE +
+                                        (uint64_t)i * entry_size;
+        ret = blk_pread(blk, current_entry_offset, sizeof(buf), buf, 0);
+        if (ret < 0) {
+            warn_report("GPT: failed to read partition entry %u (ret=%d)",
+                        i, ret);
+            return false;
+        }
+
+        current_entry = (GPTPartitionEntry *)buf;
+        if (memcmp(current_entry->type_guid, GUID_PREP_BOOT,
+                   sizeof(GUID_PREP_BOOT)) == 0) {
+            uint64_t first_lba = le64_to_cpu(current_entry->first_lba);
+            uint64_t last_lba  = le64_to_cpu(current_entry->last_lba);
+
+            if (last_lba < first_lba) {
+                warn_report("GPT: PReP entry has "
+                            "last_lba (%"PRIu64") < first_lba (%"PRIu64"), "
+                            "skipping", last_lba, first_lba);
+                continue;
+            }
+            if (first_lba > disk_last_lba || last_lba > disk_last_lba) {
+                warn_report("GPT: PReP entry LBA range [%"PRIu64", %"PRIu64"] "
+                            "exceeds disk (%"PRIu64"), skipping",
+                            first_lba, last_lba, disk_last_lba);
+                continue;
+            }
+
+            *offset = first_lba * SECTOR_SIZE;
+            *size   = (last_lba - first_lba + 1) * SECTOR_SIZE;
+            return true;
+        }
+    }
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
+        warn_report("MBR: invalid boot signature (0x%02x 0x%02x), "
+                    "expected 0x55 0xAA", mbr[510], mbr[511]);
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
+            uint32_t start_lba   = le32_to_cpu(entry->start_lba);
+            uint32_t num_sectors = le32_to_cpu(entry->num_sectors);
+
+            if (start_lba == 0 || num_sectors == 0) {
+                warn_report("MBR: PReP partition entry %d has invalid "
+                            "start_lba=%u or num_sectors=%u, skipping",
+                            i, start_lba, num_sectors);
+                continue;
+            }
+            *offset = (uint64_t)start_lba * SECTOR_SIZE;
+            *size   = (uint64_t)num_sectors * SECTOR_SIZE;
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
2.55.0


