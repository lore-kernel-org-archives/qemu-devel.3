Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0AFEF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUul-0006LF-Mc; Mon, 09 Mar 2026 03:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuh-0006IQ-OB; Mon, 09 Mar 2026 03:20:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuf-0006D3-QP; Mon, 09 Mar 2026 03:20:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628BvOaY299451; Mon, 9 Mar 2026 07:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=na/i1CpwhGXhZmVMW
 EqEhFCMO8LuQOXcquBJVbFOmB4=; b=cyyXQJnZyrwNkxaPYR2C3NN8lqQZypqiZ
 0C2sOLZxWasd7qnqMslC/FiQMRcZz9dE879pMA9wXy33m50X/qagRcDEd+cSom1x
 BLWdXNvI4OI9FgkQKxdHS93Q0ysVNIfWTDduZjsD9wSoaIhZ8PePyQt+F78odJUR
 1wCBaDBVUKQswXRqmXZF7otOZyQKMKHXfHzFGVhKsS6NFDbyArrGBZjw5mSbm+Jj
 Yp65+Gv1Cs3w+6BfAdtbGrg8MYEDPuS/lJYXUC0ydyWT/mg0kEukD92TJCqCqXwd
 ZtNYtMauegBUsxn0NrX4W+hI1oImFfogK5pP2FTvu9H2e2T/XNdjA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1md8y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6293lc5j009081;
 Mon, 9 Mar 2026 07:20:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy4304-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KIIw23331326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFE122004B;
 Mon,  9 Mar 2026 07:20:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A8BF20040;
 Mon,  9 Mar 2026 07:20:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:16 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 04/10] pnv/mpipl: Preserve memory regions as per MDST/MDDT
 tables
Date: Mon,  9 Mar 2026 12:49:53 +0530
Message-ID: <20260309072001.3136261-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69ae74b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uldKd1TX8WFnlnzwhmkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfXwb9OWltSuDF1
 bSV/elvcpfuH9X3zaYJkwfMZV10r275DtqTw+M/7rYTydObS43rLWjFCQJmj/KxWq3T0TPvhefk
 KwErjHBDG4mrkczQtaZG0yOtJumdOGrOQKZp+GxORP7hTZcX5jtg9GZ21x2SSdnjkScmXbvesyW
 Qfk743H8ujx37EP5OQHOqAk46Cjq3//oyAvZd8sEuR8kH3SFHRXbu0epIcGEmENPb5oTWOQA4Ec
 AWW9pz1IjZOgSm2jHGTFwUnR6EOxY7TJwUVB+5yb2YESIjJFzpQ9l9eG80nWxMi56MTKgWcwZlj
 82BfFiqRu+Ui09VAOEMuBladZMoBtHVuCLjNbdVn1wO+ksHmHJDgnWq+Y3uV5Szwanao+02ZzLl
 MzP5ZvQmcAaE+HpCj/5phzzhgzDe2ivfIdPvnV+X9pUgcJ5qpJXfZHX3BcpHJW4LOoVDoYvu4DK
 xJi+5E5ZVOiqf4cVv4w==
X-Proofpoint-GUID: 4AHSiAmbyOZOICJo-Es1FW0ZSa_DQk3n
X-Proofpoint-ORIG-GUID: T1LWxNnmBIX5zrhW-NyO29S599bHB9Dz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_mpipl.c         | 161 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_mpipl.h |  86 ++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
index d8c9b7a428b7..d9fe4a5decac 100644
--- a/hw/ppc/pnv_mpipl.c
+++ b/hw/ppc/pnv_mpipl.c
@@ -5,12 +5,173 @@
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
+        is_copy_failed = false;
+        copy_buffer = g_try_malloc(COPY_CHUNK_SIZE);
+        if (copy_buffer == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "MPIPL: Failed allocating memory (size: %zu) for copying"
+                " reserved memory regions\n", COPY_CHUNK_SIZE);
+            is_copy_failed = true;
+        }
+
+        num_chunks = ceil((data_len * 1.0f) / COPY_CHUNK_SIZE);
+        while ((!is_copy_failed) && (chunk_id < num_chunks)) {
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
 
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index 60d6ede48209..e0518ef2e12e 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -10,13 +10,99 @@
 #include "qemu/osdep.h"
 #include "exec/hwaddr.h"
 
+#include <assert.h>
+
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
+#define __packed             __attribute__((packed))
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
+} __packed;
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
+} __packed;
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
-- 
2.53.0


