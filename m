Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF88CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuJb-0004UA-UR; Thu, 23 Oct 2025 08:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGT-0001Pw-Fi
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGN-0006Ty-2S
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6vUhe016545
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kPGBKP
 iIs5nX76EZjTNh7xq+nu8zr82vTL9W4BNifQE=; b=pu7M1e7/1fsIeIL9ypaZL/
 PnDCLfWMv6lcHJZd+qIVzfnbDeNDP7VE1VcVHuLUKymL5MHL+SX9ks1o8/m4CQmr
 kMS25gZD9K4dloRy7RllcUimxnMH0vM+6xMuamJMjIzfrOnLWnKpTkAe8wavAkb4
 Zegdh0Fzg1Qky6qgJtx2rrTVgIQMNrYJYSugFl/9hL+cibyv+LigykcOx3q2e3rm
 9Ym4Too+mnMrFoIvU5qouPg5hnmQd2B1fyl/xICFV37N1OLQZoS2x8wwvWfc0r1H
 pOuzYc33WhRDIMXRDiERAYqw48kiOjv/vNFOypL6bIbyK0MLYawIuuFLMt5Pa8HQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fj289-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBADBJ002488
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejne4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHY3Y36438272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A755220043;
 Thu, 23 Oct 2025 12:17:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A55B20040;
 Thu, 23 Oct 2025 12:17:33 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:33 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 26/32] hw/ppc: Trigger Fadump boot if fadump is registered
Date: Thu, 23 Oct 2025 17:46:45 +0530
Message-ID: <20251023121653.3686015-27-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa1ce3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EnqhkoKPK9QirTlNTXYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: hhhXZdUB1YaWtvbisfDWNq14pswH2j2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1ygSirEzEZzW
 m2IUjvkgsRmM7G2EH9EIcqu901USmOAaKPxMO3cSghNVqvqVxJ7IlCetNEYDBob7KZJporwNasr
 jsI8JCrHwU0QiizjkcEBvc8dhIZuTf24jHNiyq1u4qwvsZl5isHB2KIVtovk5jV9IZZCsRqRzY/
 8kida0xFtaUfYkPjkXUjb4m1Iru9I7DidX7tdBknTPqUKC2d7gGVacXLFjYMclsm8qPuyEnMNkN
 OUpf61TwOhSDBnpABHzS9dxANGMHSd2ipEW9IpEItPucox7Q3lZh9IYxWGJULRCpYKc8QxbCGki
 PXKgDECKHu9glBJg7ZaNYUmJC6UmrG8/AM8ndV/GZWNZLSIIvVVOKWdvVsNZXZHJz/kWC49piMm
 mZKu4hYGeQlfX/FuX2ABL/cRpGDhnw==
X-Proofpoint-ORIG-GUID: hhhXZdUB1YaWtvbisfDWNq14pswH2j2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-3-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_fadump.h |  6 +++
 hw/ppc/spapr_fadump.c         | 77 +++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c           |  5 +++
 3 files changed, 88 insertions(+)

diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index f64f339204..1cb90c9d63 100644
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
diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 2c9f024c2d..53e5c12c76 100644
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
+     *      = Next boot will be a fadump boot (Assumed)
+     *
+     *   FADUMP_STATUS_DUMP_PERFORMED
+     *      = Dump performed (Set to 0 by caller of the
+     *        ibm,configure-kernel-dump call) (PAPR says)
+     *      = Firmware has performed the copying/dump of requested regions
+     *        (Assumed)
+     *      = Dump is active for the next boot (Assumed)
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
index 6042fc72e5..1f78fe406e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -420,6 +420,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
     target_ulong msgaddr = rtas_ld(args, 0);
     char msg[512];
 
+    if (spapr->fadump_registered) {
+        /* If fadump boot works, control won't come back here */
+        return trigger_fadump_boot(spapr, rets);
+    }
+
     cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
     msg[sizeof(msg) - 1] = 0;
 
-- 
2.43.5


