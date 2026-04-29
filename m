Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F54CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9jL-0007an-Nj; Wed, 29 Apr 2026 14:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jH-0007Zn-PO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jF-000783-CA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T9Cd4O2845814
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YnbGWGVwl3K0DP+R4
 jzGuhExkN5HHSNq/SvQy62xfJg=; b=o/Ibug66zxR/6IbKO2dGi6naEumDwB+jg
 k7uNlqbpASllu/Ps9D1S4aWGpqLUnZwEmcDJToZIbrKwprLvaKAea4dMuR9hp+zD
 k0zkVVbCYps3loiZBNJDavTq1OCDustN3uu8279RDYJD1/dmiEZTLhHxvw5qpOoA
 W0BdzjllJgqHI+i7vJnnmrcqRMgdFD+4WgH11ehQoT2kZLfwYkFUVYKFL1FdwZ9x
 Vjj6BQaVBKmOn4oKtWXrJCeX3cD/uFDZ5RkfJRwtaBKIsOFZBmvBheMjbTf73E+g
 gQ36mZLm00NvTIDLSpoNtES5WMcHclie+QipEvu6Nae6rzBSOelgw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rc223-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINkMx004836
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyfbhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXcW025952622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:33:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B23D82004E;
 Wed, 29 Apr 2026 18:33:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C11072004B;
 Wed, 29 Apr 2026 18:33:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 04/13] pnv/mpipl: Preserve memory regions as per MDST/MDDT
 tables
Date: Thu, 30 Apr 2026 00:02:54 +0530
Message-ID: <20260429183310.12455-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gIxcubMhmen-1CJi_HwKeo_pZmrb0cwp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX6dVh1cgtiH6r
 LqyCM9LV4BU3fv2WzlcpqdB9YuFHzNaQSadpH+aYgGLMNxUAPafhhFFflwbAl9avBhflM8l6aKn
 Yl3G2NjC+bk/Wn/BK9J/1uxF5N4E02z8aTlCCF2ca1/XjYvoFEs1yfwz4O2mVPYb2jju+Za4XTk
 E4nGt5KNibKFnaFyMl5gfXq6JlIUh+lyQl1dDKbv0u4sRRYjhjRoV8uo6NuEWwyIAveZA6jOZZt
 cYzzvS7bAgkYX7kgYX5Rv7LrCU48yrSM95d5BGufETUd+lHHQe45xnioAe8nsmyAVf3bNAj1g+N
 uc35et2GGyVsgi2oeW9fOLR4hF6Xx/VGBVnzDujPNZiloQHVyyuHEvpxJi6VSCbZ4cU51uyStr9
 0yCoBUPs+jEvBI5IUzRgdhlNItytYWJ8WuVVMRdMVGMEoqN5hqdEsSfZCyizLFQKa5DpnE28SnE
 BvBxRHVgjTDz6ION/4w==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f24f07 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uldKd1TX8WFnlnzwhmkA:9
X-Proofpoint-ORIG-GUID: gIxcubMhmen-1CJi_HwKeo_pZmrb0cwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

Implement copying of memory region, as mentioned by MDST and MDDT
tables.

Copy the memory regions from source to destination in chunks of 32MB

Note, qemu can fail preserving a particular entry due to any reason,
such as:
  * region length mis-matching in MDST & MDDT
  * failed copy due to access/decode/etc memory issues

HDAT doesn't specify any field in MDRT to notify host about such errors.

Though HDAT section "15.3.1.3 Memory Dump Results Table (MDRT)" says:
    The Memory Dump Results Table is a list of the memory ranges that
    have been included in the dump

Based on above statement, it looks like MDRT should include only those
regions which are successfully captured in the dump, hence, regions
which qemu fails to dump, just get skipped, and will not have a
corresponding entry in MDRT

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-5-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_mpipl.h |  84 +++++++++++++++++++
 hw/ppc/pnv_mpipl.c         | 162 +++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)

diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index d1d542b724..b3d980dfef 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -7,18 +7,102 @@
 #ifndef PNV_MPIPL_H
 #define PNV_MPIPL_H
 
+#include <assert.h>
 #include <stdbool.h>
 #include <stdint.h>
 
 #include "exec/hwaddr.h"
+#include "qemu/compiler.h"
 
+typedef struct MdstTableEntry MdstTableEntry;
+typedef struct MdrtTableEntry MdrtTableEntry;
 typedef struct MpiplPreservedState MpiplPreservedState;
 
+/*
+ * Following offsets are copied from skiboot source code.
+ * These need to be updated if this changes in a future skiboot version
+ */
+/* Use 768 bytes for SPIRAH */
+#define SPIRAH_OFF      0x00010000
+#define SPIRAH_SIZE     0x300
+
+/* Use 256 bytes for processor dump area */
+#define PROC_DUMP_AREA_OFF  (SPIRAH_OFF + SPIRAH_SIZE)
+#define PROC_DUMP_AREA_SIZE 0x100
+
+#define PROCIN_OFF      (PROC_DUMP_AREA_OFF + PROC_DUMP_AREA_SIZE)
+#define PROCIN_SIZE     0x800
+
+/* Offsets of MDST and MDDT tables from skiboot base */
+#define MDST_TABLE_OFF      (PROCIN_OFF + PROCIN_SIZE)
+#define MDST_TABLE_SIZE     0x400
+
+#define MDDT_TABLE_OFF      (MDST_TABLE_OFF + MDST_TABLE_SIZE)
+#define MDDT_TABLE_SIZE     0x400
+/*
+ * Offset of the dump result table MDRT. Hostboot will write to this
+ * memory after moving memory content from source to destination memory.
+ */
+#define MDRT_TABLE_OFF         0x01c00000
+#define MDRT_TABLE_SIZE        0x00008000
+
+/* HRMOR_BIT copied from skiboot */
+#define HRMOR_BIT (1ull << 63)
+
+/*
+ * Memory Dump Source Table (MDST)
+ *
+ * Format of this table is same as Memory Dump Source Table defined in HDAT
+ */
+struct MdstTableEntry {
+    uint64_t  addr;
+    uint8_t data_region;
+    uint8_t dump_type;
+    uint16_t  reserved;
+    uint32_t  size;
+} QEMU_PACKED;
+
+/* Memory dump destination table (MDDT) has same structure as MDST */
+typedef MdstTableEntry MddtTableEntry;
+
+/*
+ * Memory dump result table (MDRT)
+ *
+ * List of the memory ranges that have been included in the dump. This table is
+ * filled by hostboot and passed to OPAL on second boot. OPAL/payload will use
+ * this table to extract the dump.
+ *
+ * Note: This structure differs from HDAT, but matches the structure
+ * skiboot uses
+ */
+struct MdrtTableEntry {
+    uint64_t  src_addr;
+    uint64_t  dest_addr;
+    uint8_t data_region;
+    uint8_t dump_type;  /* unused */
+    uint16_t  reserved;   /* unused */
+    uint32_t  size;
+    uint64_t  padding;    /* unused */
+} QEMU_PACKED;
+
+/* Maximum length of mdst/mddt/mdrt tables */
+#define MDST_MAX_ENTRIES    (MDST_TABLE_SIZE / sizeof(MdstTableEntry))
+#define MDDT_MAX_ENTRIES    (MDDT_TABLE_SIZE / sizeof(MddtTableEntry))
+#define MDRT_MAX_ENTRIES    (MDRT_TABLE_SIZE / sizeof(MdrtTableEntry))
+
+static_assert(MDST_MAX_ENTRIES == MDDT_MAX_ENTRIES,
+        "Maximum entries in MDDT must match MDST");
+static_assert(MDRT_MAX_ENTRIES >= MDST_MAX_ENTRIES,
+        "MDRT should support atleast having number of entries as in MDST");
+
 /* Preserved state to be saved in PnvMachineState */
 struct MpiplPreservedState {
     /* skiboot_base will be valid only after OPAL sends relocated base to SBE */
     hwaddr     skiboot_base;
     bool       is_next_boot_mpipl;
+
+    MdrtTableEntry *mdrt_table;
+    uint32_t num_mdrt_entries;
 };
 
 #endif
diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
index d8c9b7a428..cef1fe2c40 100644
--- a/hw/ppc/pnv_mpipl.c
+++ b/hw/ppc/pnv_mpipl.c
@@ -5,12 +5,174 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "system/address-spaces.h"
 #include "system/runstate.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_mpipl.h"
+#include <math.h>
+
+#define MDST_TABLE_RELOCATED                            \
+    (pnv->mpipl_state.skiboot_base + MDST_TABLE_OFF)
+#define MDDT_TABLE_RELOCATED                            \
+    (pnv->mpipl_state.skiboot_base + MDDT_TABLE_OFF)
+
+/*
+ * Preserve the memory regions as pointed by MDST table
+ *
+ * During this, the memory region pointed by entries in MDST, are 'copied'
+ * as it is to the memory region pointed by corresponding entry in MDDT
+ *
+ * Notes: All reads should consider data coming from skiboot as big-endian,
+ *        and data written should also be in big-endian
+ */
+static bool pnv_mpipl_preserve_mem(PnvMachineState *pnv)
+{
+    g_autofree MdstTableEntry *mdst = g_malloc(MDST_TABLE_SIZE);
+    g_autofree MddtTableEntry *mddt = g_malloc(MDDT_TABLE_SIZE);
+    g_autofree MdrtTableEntry *mdrt = g_malloc0(MDRT_TABLE_SIZE);
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+    uint64_t src_addr, dest_addr;
+    uint32_t data_len;
+    uint64_t num_chunks, chunk_id = 0;
+    int mdrt_idx = 0;
+
+    /* Mark the memory transactions as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    if (pnv->mpipl_state.mdrt_table) {
+        /*
+         * MDRT table allocated from some past crash, free the memory to
+         * prevent memory leak
+         */
+        g_free(pnv->mpipl_state.mdrt_table);
+        pnv->mpipl_state.num_mdrt_entries = 0;
+    }
+
+    io_result = address_space_read(default_as, MDST_TABLE_RELOCATED, attrs,
+            mdst, MDST_TABLE_SIZE);
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "MPIPL: Failed to read MDST table at: 0x" TARGET_FMT_lx "\n",
+            MDST_TABLE_RELOCATED);
+
+        return false;
+    }
+
+    io_result = address_space_read(default_as, MDDT_TABLE_RELOCATED, attrs,
+            mddt, MDDT_TABLE_SIZE);
+    if (io_result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "MPIPL: Failed to read MDDT table at: 0x" TARGET_FMT_lx "\n",
+            MDDT_TABLE_RELOCATED);
+
+        return false;
+    }
+
+    /* Try to read all entries */
+    for (int i = 0; i < MDST_MAX_ENTRIES; ++i) {
+        g_autofree uint8_t *copy_buffer = NULL;
+        bool is_copy_failed = false;
+
+        /* Considering entry with address and size as 0, as end of table */
+        if ((mdst[i].addr == 0) && (mdst[i].size == 0)) {
+            break;
+        }
+
+        if (mdst[i].size != mddt[i].size) {
+            qemu_log_mask(LOG_TRACE,
+                    "Warning: Invalid entry, size mismatch in MDST & MDDT\n");
+            continue;
+        }
+
+        if (mdst[i].data_region != mddt[i].data_region) {
+            qemu_log_mask(LOG_TRACE,
+                    "Warning: Invalid entry, region mismatch in MDST & MDDT\n");
+            continue;
+        }
+
+        src_addr  = be64_to_cpu(mdst[i].addr) & ~HRMOR_BIT;
+        dest_addr = be64_to_cpu(mddt[i].addr) & ~HRMOR_BIT;
+        data_len   = be32_to_cpu(mddt[i].size);
+
+#define COPY_CHUNK_SIZE  ((size_t)(32 * MiB))
+        copy_buffer = g_try_malloc(COPY_CHUNK_SIZE);
+        if (copy_buffer == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "MPIPL: Failed allocating memory (size: %zu) for copying"
+                " reserved memory regions\n", COPY_CHUNK_SIZE);
+            is_copy_failed = true;
+            continue;
+        }
+
+        chunk_id = 0;
+        num_chunks = ceil((data_len * 1.0f) / COPY_CHUNK_SIZE);
+        while (chunk_id < num_chunks) {
+            /* Take minimum of bytes left to copy, and chunk size */
+            uint64_t copy_len = MIN(
+                            data_len - (chunk_id * COPY_CHUNK_SIZE),
+                            COPY_CHUNK_SIZE
+                        );
+
+            /* Copy the source region to destination */
+            io_result = address_space_read(default_as, src_addr, attrs,
+                    copy_buffer, copy_len);
+            if (io_result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "MPIPL: Failed to read region at: 0x%" PRIx64 "\n",
+                    src_addr);
+                is_copy_failed = true;
+                break;
+            }
+
+            io_result = address_space_write(default_as, dest_addr, attrs,
+                    copy_buffer, copy_len);
+            if (io_result != MEMTX_OK) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "MPIPL: Failed to write region at: 0x%" PRIx64 "\n",
+                    dest_addr);
+                is_copy_failed = true;
+                break;
+            }
+
+            src_addr += COPY_CHUNK_SIZE;
+            dest_addr += COPY_CHUNK_SIZE;
+            ++chunk_id;
+        }
+#undef COPY_CHUNK_SIZE
+
+        if (is_copy_failed) {
+            /*
+             * HDAT doesn't specify an error code in MDRT for failed copy,
+             * and doesn't specify how this is to be handled
+             * Hence just skip adding an entry in MDRT, as done for size
+             * mismatch or other inconsistency between MDST/MDDT
+             */
+            continue;
+        }
+
+        /* Populate entry in MDRT table if preserving successful */
+        mdrt[mdrt_idx].src_addr    = cpu_to_be64(src_addr);
+        mdrt[mdrt_idx].dest_addr   = cpu_to_be64(dest_addr);
+        mdrt[mdrt_idx].size        = cpu_to_be32(data_len);
+        mdrt[mdrt_idx].data_region = mdst[i].data_region;
+        ++mdrt_idx;
+    }
+
+    pnv->mpipl_state.mdrt_table = g_steal_pointer(&mdrt);
+    pnv->mpipl_state.num_mdrt_entries = mdrt_idx;
+
+    return true;
+}
 
 void do_mpipl_preserve(PnvMachineState *pnv)
 {
+    pnv_mpipl_preserve_mem(pnv);
+
     /* Mark next boot as Memory-preserving boot */
     pnv->mpipl_state.is_next_boot_mpipl = true;
 
-- 
2.52.0


