Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B67C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvNh-0004Se-FE; Mon, 17 Feb 2025 02:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNg-0004RL-1A; Mon, 17 Feb 2025 02:17:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNd-0002ez-7x; Mon, 17 Feb 2025 02:17:27 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GMnfJp029071;
 Mon, 17 Feb 2025 07:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LsNqxe
 tULiCL0ePKbB4uYacucfEJVbJZE42c6Hahndk=; b=rdzq/LDgDz7/8LVyc9OHqZ
 vDry/ZU+pogpakipd5+f5/ZvOwOS8UrykHsJpb5s4VKmQACB8nw9cFQTG/ToIg6t
 hwg/xE3F25AQManuqUJnE+sq0Gjb1a0ilRFr8/lAJEdkYzko1pgcpSy/MQMp9DHy
 tXav5apwy9fWvod7dc1nytI91crzvSga3fPaRTthuuaMxjqgcxASnGxZpCksq7AN
 YwCoYmZUh6AU+sPZR6KRLUFUORPheHa0LB3p0O7mHaZFiePehAcML8doZTyukMwl
 QMc8dB3x6hBrDgwEB10EEM3JLj1XTxcB4RkadeiBpqrzP86kZ4b0NzVvuocHF+XA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a1ncs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7Cp5Y016912;
 Mon, 17 Feb 2025 07:17:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a1ncq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H3tWeu004038;
 Mon, 17 Feb 2025 07:17:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u68nmy9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7HH5b51970362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:17:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD11920049;
 Mon, 17 Feb 2025 07:17:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 224A52004D;
 Mon, 17 Feb 2025 07:17:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:17:15 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 2/6] hw/ppc: Trigger Fadump boot if fadump is registered
Date: Mon, 17 Feb 2025 12:47:07 +0530
Message-ID: <20250217071711.83735-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071711.83735-1-adityag@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yQ4Da42aGwO7IRsyfA64UurawnZ3wAja
X-Proofpoint-GUID: mbPe02p6ESSJipHENBrNcJ0scHZLpYTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
    * pause all vcpus (will save registers later)
    * preserve memory regions specified by fadump
    * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
      the memory)

Memory regions registered by fadump will be handled in a later patch.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr_rtas.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index eebdf13b1552..01c82375f03d 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -342,6 +342,43 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
 }
 
 struct fadump_metadata fadump_metadata;
+bool is_next_boot_fadump;
+
+static void trigger_fadump_boot(target_ulong spapr_retcode)
+{
+    /*
+     * In PowerNV, SBE stops all clocks for cores, do similar to it
+     * QEMU's nearest equivalent is 'pause_all_vcpus'
+     * See 'stopClocksS0' in SBE source code for more info on SBE part
+     */
+    pause_all_vcpus();
+
+    if (true /* TODO: Preserve memory registered for fadump */) {
+        /* Failed to preserve the registered memory regions */
+        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
+
+        /* Cause a reboot */
+        qemu_system_guest_panicked(NULL);
+        return;
+    }
+
+    /* Mark next boot as fadump boot */
+    is_next_boot_fadump = true;
+
+    /* Reset fadump_registered for next boot */
+    fadump_metadata.fadump_registered = false;
+    fadump_metadata.fadump_dump_active = true;
+
+    /* Then do a guest reset */
+    /*
+     * Requirement:
+     * This guest reset should not clear the memory (which is
+     * the case when this is merged)
+     */
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+
+    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
+}
 
 /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
 static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,
@@ -449,6 +486,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
     target_ulong msgaddr = rtas_ld(args, 0);
     char msg[512];
 
+    if (fadump_metadata.fadump_registered) {
+        /* If fadump boot works, control won't come back here */
+        return trigger_fadump_boot(rets);
+    }
+
     cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
     msg[sizeof(msg) - 1] = 0;
 
-- 
2.48.1


