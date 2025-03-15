Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1024BC28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttLIx-0007wj-GS; Sat, 15 Mar 2025 02:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ttLIV-0007q5-6M; Sat, 15 Mar 2025 02:47:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ttLIS-00073f-VU; Sat, 15 Mar 2025 02:47:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52F3k9rZ011963;
 Sat, 15 Mar 2025 06:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GqZ5THkn9U/CvMsb2
 TKle+/ubzbGo9UCsX+R/y9zy3w=; b=jnRv2Ll8PT68oy+YayRoMxTrOZv7mUsgW
 qh/mZuT/k5RLhH24o5r4fGZ/mLBTx9g26YaBDfvGIwnrnDrTd06/eEY9lYR9Gvif
 rzZM1fqt/9at9l4ICvAlLBj2CipyWqevS6wjkKK/yTk/YG+Gc8Ul0BX8UTzxYfsM
 wJ8Sb1cmza33Sr7+TFI3jY5GRFy+NS61ia00fMBlNQHHE/VW5P6mkQqhqGaZR+VY
 KKyDwEwMnwPuoQRZFxaGv2ebMeSy3/tJiEoYiZNeqEjjFd+4Ogi8d6fKllkOd3JS
 4Rb1kXevbarICc2yx2Q6rlzMHQUjlw1zmyk4ES60epGJfndikgPNw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45d1x8rerh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52F6j3RO018221;
 Sat, 15 Mar 2025 06:46:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45d1x8rerf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52F3aFvD014731;
 Sat, 15 Mar 2025 06:46:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45d1srrj51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52F6ksN433292808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Mar 2025 06:46:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31E4D2004B;
 Sat, 15 Mar 2025 06:46:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECF8820043;
 Sat, 15 Mar 2025 06:46:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.208.229])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 15 Mar 2025 06:46:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v3 4/8] hw/ppc: Preserve memory regions registered for fadump
Date: Sat, 15 Mar 2025 12:16:32 +0530
Message-ID: <20250315064636.611714-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315064636.611714-1-adityag@linux.ibm.com>
References: <20250315064636.611714-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oVAmwSDoJ-rkV67yfuubU3izVc0gzTUm
X-Proofpoint-ORIG-GUID: oL1lsAiOwdDNes0Vu1g4FAdYon1REpFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_02,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503150041
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Note: As of this patch, the "kernel-dump" device tree entry is still not
added for the second boot, so after crash, the second kernel will boot
assuming fadump dump is "NOT" active, and try to register for fadump,
but since we already have fadump registered in QEMU internal state, the
register rtas call will fail with: "DUMP ACTIVE"

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c         | 161 ++++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr_fadump.h |  18 ++++
 2 files changed, 174 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index fedd2cde9a4f..c105b8d21da5 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -123,14 +123,165 @@ uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
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
+    if (src_addr != dest_addr) {
+        /*
+         * Using 'g_try_malloc' as the source length is coming from kernel,
+         * which can be invalid/huge, due to which allocation can fail
+         */
+        copy_buffer = g_try_malloc(src_len + 1);
+        if (copy_buffer == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "FADump: Failed allocating memory (size: %ld) for copying"
+                " reserved memory regions\n", src_len);
+
+            return false;
+        }
+
+        /* Copy the source region to destination */
+        io_result = address_space_read(default_as, src_addr, attrs,
+                copy_buffer, src_len);
+        if ((io_result & MEMTX_DECODE_ERROR) ||
+            (io_result & MEMTX_ACCESS_ERROR)) {
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
+                copy_buffer, src_len);
+        if ((io_result & MEMTX_DECODE_ERROR) ||
+            (io_result & MEMTX_ACCESS_ERROR)) {
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
+    }
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
@@ -151,7 +302,7 @@ void trigger_fadump_boot(SpaprMachineState *spapr, target_ulong spapr_retcode)
     pause_all_vcpus();
 
     /* Preserve the memory locations registered for fadump */
-    if (!fadump_preserve_mem()) {
+    if (!fadump_preserve_mem(spapr)) {
         /* Failed to preserve the registered memory regions */
         rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
 
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index e484604c1c70..d56ca1d6d651 100644
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
-- 
2.48.1


