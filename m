Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE605C3600D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPKY-0003KK-Kj; Sun, 23 Mar 2025 13:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJE-0001BO-Tw; Sun, 23 Mar 2025 13:40:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJD-0003Pv-3f; Sun, 23 Mar 2025 13:40:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NHBjqS010370;
 Sun, 23 Mar 2025 17:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cWIDlA
 srTpHE/5ZKk7+DwWGArD1g4XUUV8rvCpDI0O0=; b=m/TyrkOTMEjDYUp7mrPuXH
 6TW06DJyojfIofEIwXcuB3E/wn2ayFou175COY04jtzQcpiKTnQR+89CcuOAmtv2
 16Xfc+e2cY2duC5OOo4traAFv8EsDDl9UwffiwZRXpp90ZrefklQLVnqSa54Dn3g
 CiPxnjl+z0G9cIfIFkW7bZr+ggyBn1RJpnChZuhVhT9RthhLf68LyEMnSVABtGsQ
 a0Hm6AMW7FZXMQL5qBeJLbNv84ezGeBsMVIrOflAfoND43Rp+UYJoreZ28S9NMew
 /MMIuGzDetrmB/JMwBHPgo8slPerAHd+iW+DnbfhiI13RjVB11eCeI9y67QjfFig
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwr2y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52NHeOPp031694;
 Sun, 23 Mar 2025 17:40:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwr2y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52NCbnN0012359;
 Sun, 23 Mar 2025 17:40:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91ktkgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52NHeJ5e41222554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Mar 2025 17:40:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDE9D20043;
 Sun, 23 Mar 2025 17:40:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8713720040;
 Sun, 23 Mar 2025 17:40:17 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.162])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Mar 2025 17:40:17 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v4 3/8] hw/ppc: Trigger Fadump boot if fadump is registered
Date: Sun, 23 Mar 2025 23:10:02 +0530
Message-ID: <20250323174007.221116-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323174007.221116-1-adityag@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R4tFWWxe3ECwI84dM2zxOy906j3n6fHH
X-Proofpoint-GUID: cnhcA31mkdk9iFoq7hYG1NlTkWgk91mB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503230123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
2.49.0


