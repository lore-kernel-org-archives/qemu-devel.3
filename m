Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A83C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttLIy-0007xE-GQ; Sat, 15 Mar 2025 02:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ttLIR-0007pt-T7; Sat, 15 Mar 2025 02:47:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ttLIQ-00073I-1Z; Sat, 15 Mar 2025 02:46:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52F5kYA2028462;
 Sat, 15 Mar 2025 06:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c4P8qH
 ApX6xkfLpS3eFuj7AWa+YejvQRwL9h85MZV5c=; b=gj802M/6qX8REUN9VMko3C
 NwPFivmOkdPTH2uvjNygTrAzHiyIeIuI7StFVWXFHGAKUhl66RvuaMbjJ2jSto9U
 pw2zLLeHvc3VOivgeHmuLHaygdaX4bG3NXgh8c2+/QTCtL0ts6SxVK10a7d70wsy
 4rNGEEnUf2b2RhL8KgNuv9yAOoLmM9oXJDp+/Xt3KuSYAsyamMZzDGwBZaOcaoJD
 Gm0YrdjgtDZ+1BLh/doV9mkINphpZnFNPD+VlcNIOKG4AjPKEergR4axGGNXAQFe
 Qa5DFg5OYL7U+XGsW6D5967gJwtpH5pLNWFX6phw9JzDPAD9Pee1dDaNjgqKuJ8A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45d1v70eck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52F6kuCD003436;
 Sat, 15 Mar 2025 06:46:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45d1v70ecf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52F3aq3v007845;
 Sat, 15 Mar 2025 06:46:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45d1su8hym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52F6kpLH53215684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Mar 2025 06:46:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 966B520043;
 Sat, 15 Mar 2025 06:46:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C7320040;
 Sat, 15 Mar 2025 06:46:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.208.229])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 15 Mar 2025 06:46:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v3 3/8] hw/ppc: Trigger Fadump boot if fadump is registered
Date: Sat, 15 Mar 2025 12:16:31 +0530
Message-ID: <20250315064636.611714-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315064636.611714-1-adityag@linux.ibm.com>
References: <20250315064636.611714-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xvG2Ussky6jZBs3KksN-lEK9ZVmUMZIJ
X-Proofpoint-GUID: Jzx_9Fl4YJ6lV6zc5JVS96J4SWmDb80f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_02,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503150041
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

According to PAPR:

    R1–7.3.30–3. When the platform receives an ibm,os-term RTAS call, or
    on a system reset without an ibm,nmi-interlock RTAS call, if the
    platform has a dump structure registered through the
    ibm,configure-kernel-dump call, the platform must process each
    registered kernel dump section as required and, when available,
    present the dump structure information to the operating system
    through the “ibm,kernel-dump” property, updated with status for each
    dump section, until the dump has been invalidated through the
    ibm,configure-kernel-dump RTAS call.

If Fadump has been registered, trigger an Fadump boot (memory preserving
boot), if QEMU recieves a 'ibm,os-term' rtas call.

Implementing the fadump boot as:
    * pause all vcpus (will need to save registers later)
    * preserve memory regions specified by fadump (will be implemented
      in future)
    * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
      the memory)

Memory regions registered by fadump will be handled in a later patch.

Note: Preserving memory regions is not implemented yet so on an
"ibm,os-term" call will just trigger a reboot in QEMU if fadump is
registered, and the second kernel will boot as a normal boot (not
fadump boot)

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c         | 77 +++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c           |  5 +++
 include/hw/ppc/spapr_fadump.h |  6 +++
 3 files changed, 88 insertions(+)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 9c7fb9e12b16..fedd2cde9a4f 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/ppc/spapr.h"
+#include "system/cpus.h"
 
 /*
  * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
@@ -121,3 +122,79 @@ uint32_t do_fadump_register(SpaprMachineState *spapr, target_ulong args)
 
     return RTAS_OUT_SUCCESS;
 }
+
+/* Preserve the memory locations registered for fadump */
+static bool fadump_preserve_mem(void)
+{
+    /*
+     * TODO: Implement preserving memory regions requested during fadump
+     * registration
+     */
+    return false;
+}
+
+/*
+ * Trigger a fadump boot, ie. next boot will be a crashkernel/fadump boot
+ * with fadump dump active.
+ *
+ * This is triggered by ibm,os-term RTAS call, if fadump was registered.
+ *
+ * It preserves the memory and sets 'FADUMP_STATUS_DUMP_TRIGGERED' as
+ * fadump status, which can be used later to add the "ibm,kernel-dump"
+ * device tree node as presence of 'FADUMP_STATUS_DUMP_TRIGGERED' signifies
+ * next boot as fadump boot in our case
+ */
+void trigger_fadump_boot(SpaprMachineState *spapr, target_ulong spapr_retcode)
+{
+    FadumpSectionHeader *header = &spapr->registered_fdm.header;
+
+    pause_all_vcpus();
+
+    /* Preserve the memory locations registered for fadump */
+    if (!fadump_preserve_mem()) {
+        /* Failed to preserve the registered memory regions */
+        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
+
+        /* Cause a reboot */
+        qemu_system_guest_panicked(NULL);
+        return;
+    }
+
+    /*
+     * Mark next boot as fadump boot
+     *
+     * Note: These is some bit of assumption involved here, as PAPR doesn't
+     * specify any use of the dump status flags, nor does the kernel use it
+     *
+     * But from description in Table 136 in PAPR v2.13, it looks like:
+     *   FADUMP_STATUS_DUMP_TRIGGERED
+     *      = Dump was triggered by the previous system boot (PAPR says)
+     *      = Next boot will be a fadump boot (My perception)
+     *
+     *   FADUMP_STATUS_DUMP_PERFORMED
+     *      = Dump performed (Set to 0 by caller of the
+     *        ibm,configure-kernel-dump call) (PAPR says)
+     *      = Firmware has performed the copying/dump of requested regions
+     *        (My perception)
+     *      = Dump is active for the next boot (My perception)
+     */
+    header->dump_status_flag = cpu_to_be16(
+            FADUMP_STATUS_DUMP_TRIGGERED |  /* Next boot will be fadump boot */
+            FADUMP_STATUS_DUMP_PERFORMED    /* Dump is active */
+    );
+
+    /* Reset fadump_registered for next boot */
+    spapr->fadump_registered = false;
+    spapr->fadump_dump_active = true;
+
+    /*
+     * Then do a guest reset
+     *
+     * Requirement:
+     * GUEST_RESET is expected to NOT clear the memory, as is the case when
+     * this is merged
+     */
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+
+    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
+}
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0454938a01e9..14b954a05109 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -412,6 +412,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
     target_ulong msgaddr = rtas_ld(args, 0);
     char msg[512];
 
+    if (spapr->fadump_registered) {
+        /* If fadump boot works, control won't come back here */
+        return trigger_fadump_boot(spapr, rets);
+    }
+
     cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
     msg[sizeof(msg) - 1] = 0;
 
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index 6abbcb44f353..e484604c1c70 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -16,6 +16,11 @@
 
 #define FADUMP_VERSION                 1
 
+/* Dump status flags */
+#define FADUMP_STATUS_DUMP_PERFORMED            0x8000
+#define FADUMP_STATUS_DUMP_TRIGGERED            0x4000
+#define FADUMP_STATUS_DUMP_ERROR                0x2000
+
 /*
  * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
  * in the dump memory structure. Presently, three sections are used for
@@ -66,4 +71,5 @@ struct FadumpMemStruct {
 };
 
 uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
+void     trigger_fadump_boot(struct SpaprMachineState *, target_ulong);
 #endif /* PPC_SPAPR_FADUMP_H */
-- 
2.48.1


