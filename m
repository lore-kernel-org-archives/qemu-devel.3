Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAF4CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuKd-0005kk-N8; Thu, 23 Oct 2025 08:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGT-0001Q0-Kb
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGN-0006UE-Qx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N89H2Y018327
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=e5ZRH5Zmk9CV95UyF
 QSWujU4DCdRUIn5aby8B+0zOBg=; b=ARfBqIcXmDSdKc2aTMaGfGFclyHLQyfpr
 WwudCV3m5Kx+kaDV0t4c68Lkhc3GKscJ6HR/kWcf+Pgz+jgOacRqeoj6QJkKOIlX
 L6cVhG8N18x2tD0KY/T7VVU8EnG02ZqhqnPOEf68C4cLPmyxd/qTTOkqe4wCjAd9
 n/WhAh/hGemtb2S8UtXq49LVxqiX8ujpErUq/96DQaL9DxBvkc0V1eBsK3Kq+qoX
 RLvyvcM15/YcbguKyGGzcYBAWI8MPsRY7zlC4KJc5X6VrSMsnVUkoGI1L/lwll5l
 f/sFs7Qvl7rLTLO5GGKUTJzb31RqIaK9hQYIOzuKbjR37UihkGZBQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgp1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBADBL002488
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejne51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHa0T58393014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10B4620043;
 Thu, 23 Oct 2025 12:17:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05ED720040;
 Thu, 23 Oct 2025 12:17:35 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 27/32] hw/ppc: Preserve memory regions registered for fadump
Date: Thu, 23 Oct 2025 17:46:46 +0530
Message-ID: <20251023121653.3686015-28-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -9wvvthfN5MnXKLrEI0l8BmtJgS573Ld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6jRWlC9cOryU
 1OH2ARMKobEcVSNk26YKs8c6WQvcGi1TxNRMkHhmUo5xfTC/ffxXnMckjNm7HWWoc6OAGIx5EBf
 p/SfVA/+eyyzquyUKdAb9n0NJztzhw/wOUq/Uh7hwXSi4rvRsrsAVJ9D2SW9W5PVgBYLfPBJ/hr
 R+NGcqDGSFsJAJDiWWaruwMKv13Uiv+NZzcYMtcc2AJb1P5wa+yY4smW6ZrWQtS0VIyhYl3aoXC
 ZpBP9793rTC8zwbAesLu58V8GDeUC8VkCvYXQlIUmRESLMuOFcUpZInXrM7UruKTUcQW8jemqYp
 orL2gqcICJdJ2XYEZvAJ81mrM5CwmZzaESyXA5/DlCST91MD4+974AFTedpl8DtphIa4YDD7xDU
 wIpvzfQYciRXONxtV4tRYfcip8Tamg==
X-Proofpoint-GUID: -9wvvthfN5MnXKLrEI0l8BmtJgS573Ld
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa1ce4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8rT69PE5f5DtODXktdUA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

While the first kernel boots, it registers memory regions for fadump
such as:
    * CPU state data  (has to be populated by the platform)
    * HPTE state data (has to be populated by the platform)
    * Real Mode Regions (platform should copy it to requested
      destination addresses)
    * OS defined regions (such as parameter save area)

Platform is also expected to modify the 'bytes_dumped' to the length of
data preserved/copied by platform (ideally same as the source length
passed by kernel).

The kernel passes source address and length for the memory regions, and
a destination address to where the memory is to be copied.

Implement the preserving/copying of the Real Mode Regions and the
Parameter Save Area in QEMU Pseries

The regions are copied in chunks instead of copying all at once.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-4-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_fadump.h |  18 ++++
 hw/ppc/spapr_fadump.c         | 183 +++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index 1cb90c9d63..71be2ad92c 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -16,11 +16,29 @@
 
 #define FADUMP_VERSION                 1
 
+/* Firmware provided dump sections */
+#define FADUMP_CPU_STATE_DATA   0x0001
+#define FADUMP_HPTE_REGION      0x0002
+#define FADUMP_REAL_MODE_REGION 0x0011
+
+/* OS defined sections */
+#define FADUMP_PARAM_AREA       0x0100
+
+/* Dump request flag */
+#define FADUMP_REQUEST_FLAG     0x00000001
+
 /* Dump status flags */
 #define FADUMP_STATUS_DUMP_PERFORMED            0x8000
 #define FADUMP_STATUS_DUMP_TRIGGERED            0x4000
 #define FADUMP_STATUS_DUMP_ERROR                0x2000
 
+/* Region dump error flags */
+#define FADUMP_ERROR_INVALID_DATA_TYPE          0x8000
+#define FADUMP_ERROR_INVALID_SOURCE_ADDR        0x4000
+#define FADUMP_ERROR_LENGTH_EXCEEDS_SOURCE      0x2000
+#define FADUMP_ERROR_INVALID_DEST_ADDR          0x1000
+#define FAUDMP_ERROR_DEST_TOO_SMALL             0x0800
+
 /*
  * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
  * in the dump memory structure. Presently, three sections are used for
diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 53e5c12c76..5068a9d83d 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -7,7 +7,9 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/ppc/spapr.h"
+#include "qemu/units.h"
 #include "system/cpus.h"
+#include <math.h>
 
 /*
  * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
@@ -123,14 +125,185 @@ uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
     return RTAS_OUT_SUCCESS;
 }
 
+/*
+ * Copy the source region of given fadump section, to the destination
+ * address mentioned in the region
+ *
+ * Also set the region's error flag, if the copy fails due to non-existent
+ * address (MEMTX_DECODE_ERROR) or permission issues (MEMTX_ACCESS_ERROR)
+ *
+ * Returns true if successful copy
+ *
+ * Returns false in case of any other error, being treated as hardware
+ * error for fadump purposes
+ */
+static bool do_preserve_region(FadumpSection *region)
+{
+    AddressSpace *default_as = &address_space_memory;
+    MemTxResult io_result;
+    MemTxAttrs attrs;
+    uint64_t src_addr, src_len, dest_addr;
+    uint64_t num_chunks;
+    g_autofree void *copy_buffer = NULL;
+
+    src_addr  = be64_to_cpu(region->source_address);
+    src_len   = be64_to_cpu(region->source_len);
+    dest_addr = be64_to_cpu(region->destination_address);
+
+    /* Mark the memory transaction as privileged memory access */
+    attrs.user = 0;
+    attrs.memory = 1;
+
+    /*
+     * Optimisation: Skip copy if source and destination are same
+     * (eg. param area)
+     */
+    if (src_addr == dest_addr) {
+        region->bytes_dumped = cpu_to_be64(src_len);
+        return true;
+    }
+
+#define FADUMP_CHUNK_SIZE  ((size_t)(32 * MiB))
+    copy_buffer = g_try_malloc(FADUMP_CHUNK_SIZE);
+    if (copy_buffer == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "FADump: Failed allocating memory (size: %zu) for copying"
+            " reserved memory regions\n", FADUMP_CHUNK_SIZE);
+    }
+
+    num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
+    for (uint64_t chunk_id = 0; chunk_id < num_chunks; ++chunk_id) {
+        /* Take minimum of bytes left to copy, and chunk size */
+        uint64_t copy_len = MIN(
+                        src_len - (chunk_id * FADUMP_CHUNK_SIZE),
+                        FADUMP_CHUNK_SIZE
+                    );
+
+        /* Copy the source region to destination */
+        io_result = address_space_read(default_as, src_addr, attrs,
+                copy_buffer, copy_len);
+        if ((io_result & MEMTX_DECODE_ERROR) ||
+            (io_result & MEMTX_ACCESS_ERROR)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Failed to decode/access address in section: %d\n",
+                region->source_data_type);
+
+            /*
+             * Invalid source address is not an hardware error, instead
+             * wrong parameter from the kernel.
+             * Return true to let caller know to continue reading other
+             * sections
+             */
+            region->error_flags = FADUMP_ERROR_INVALID_SOURCE_ADDR;
+            region->bytes_dumped = 0;
+            return true;
+        } else if (io_result != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Failed to read source region in section: %d\n",
+                region->source_data_type);
+
+            return false;
+        }
+
+        io_result = address_space_write(default_as, dest_addr, attrs,
+                copy_buffer, copy_len);
+        if ((io_result & MEMTX_DECODE_ERROR) ||
+            (io_result & MEMTX_ACCESS_ERROR)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Failed to decode/access address in section: %d\n",
+                region->source_data_type);
+
+            /*
+             * Invalid destination address is not an hardware error,
+             * instead wrong parameter from the kernel.
+             * Return true to let caller know to continue reading other
+             * sections
+             */
+            region->error_flags = FADUMP_ERROR_INVALID_DEST_ADDR;
+            region->bytes_dumped = 0;
+            return true;
+        } else if (io_result != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Failed to write destination in section: %d\n",
+                region->source_data_type);
+
+            return false;
+        }
+
+        src_addr += FADUMP_CHUNK_SIZE;
+        dest_addr += FADUMP_CHUNK_SIZE;
+    }
+#undef FADUMP_CHUNK_SIZE
+
+    /*
+     * Considering address_space_write would have copied the
+     * complete region
+     */
+    region->bytes_dumped = cpu_to_be64(src_len);
+    return true;
+}
+
 /* Preserve the memory locations registered for fadump */
-static bool fadump_preserve_mem(void)
+static bool fadump_preserve_mem(SpaprMachineState *spapr)
 {
+    FadumpMemStruct *fdm = &spapr->registered_fdm;
+    uint16_t dump_num_sections, data_type;
+
+    assert(spapr->fadump_registered);
+
     /*
-     * TODO: Implement preserving memory regions requested during fadump
-     * registration
+     * Handle all sections
+     *
+     * CPU State Data and HPTE regions are handled in their own cases
+     *
+     * RMR regions and any custom OS reserved regions such as parameter
+     * save area, are handled by simply copying the source region to
+     * destination address
      */
-    return false;
+    dump_num_sections = be16_to_cpu(fdm->header.dump_num_sections);
+    for (int i = 0; i < dump_num_sections; ++i) {
+        data_type = be16_to_cpu(fdm->rgn[i].source_data_type);
+
+        /* Reset error_flags & bytes_dumped for now */
+        fdm->rgn[i].error_flags = 0;
+        fdm->rgn[i].bytes_dumped = 0;
+
+        /* If kernel did not request for the memory region, then skip it */
+        if (be32_to_cpu(fdm->rgn[i].request_flag) != FADUMP_REQUEST_FLAG) {
+            qemu_log_mask(LOG_UNIMP,
+                "FADump: Skipping copying region as not requested\n");
+            continue;
+        }
+
+        switch (data_type) {
+        case FADUMP_CPU_STATE_DATA:
+            /* TODO: Add CPU state data */
+            break;
+        case FADUMP_HPTE_REGION:
+            /* TODO: Add hpte state data */
+            break;
+        case FADUMP_REAL_MODE_REGION:
+        case FADUMP_PARAM_AREA:
+            /* Copy the memory region from region's source to its destination */
+            if (!do_preserve_region(&fdm->rgn[i])) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "FADump: Failed to preserve dump section: %d\n",
+                    be16_to_cpu(fdm->rgn[i].source_data_type));
+                fdm->header.dump_status_flag |=
+                    cpu_to_be16(FADUMP_STATUS_DUMP_ERROR);
+            }
+
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Skipping unknown source data type: %d\n", data_type);
+
+            fdm->rgn[i].error_flags =
+                cpu_to_be16(FADUMP_ERROR_INVALID_DATA_TYPE);
+        }
+    }
+
+    return true;
 }
 
 /*
@@ -151,7 +324,7 @@ void trigger_fadump_boot(SpaprMachineState *spapr, target_ulong spapr_retcode)
     pause_all_vcpus();
 
     /* Preserve the memory locations registered for fadump */
-    if (!fadump_preserve_mem()) {
+    if (!fadump_preserve_mem(spapr)) {
         /* Failed to preserve the registered memory regions */
         rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
 
-- 
2.43.5


