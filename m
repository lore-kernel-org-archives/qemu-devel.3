Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ACAC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvQB-00014G-N0; Mon, 17 Feb 2025 02:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQ9-00012h-SG; Mon, 17 Feb 2025 02:20:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvQ3-0002pJ-B3; Mon, 17 Feb 2025 02:19:56 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GIExT7031181;
 Mon, 17 Feb 2025 07:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NldQSP9WnDUrMLhCd
 NwPeo0DkCRDHEj87PEOHYkHKGw=; b=U8QZqUwDz++UEAw9oz9yD4DipW4DImBLO
 pge6bP8fk5xpGC81V2bnlJgq1pkeXpFcR0aBSBKvc6C6lScZiv7LpSv6YhXDFUtu
 zM7qVSGInPYHe/DnFz4vamX739fW/k0sOK8PQ4JCV1s94qIUW7HrK7rESfOXfRMQ
 2vRnOqxvt6ccPsLmwJ+9yunZH0jFBq3HIbHZwpYLfZ3QWPr4xBA6LlNTYdQRvWfZ
 +uSNZwpCgXtWC1pwu+0ntTfIAPK6c1Mfv76C7kkw2Dqi6Rat9yXp6Sa57eT857i6
 BwwpUq2zSDfC1KcTUKXQIWIJ0HQhXGKvM0u9rqRHbVpjxj4tbZIjg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuyf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7JrwS031028;
 Mon, 17 Feb 2025 07:19:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuyf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H4VLKZ000498;
 Mon, 17 Feb 2025 07:19:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u6rkmvn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7JnN856230370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:19:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECC732004B;
 Mon, 17 Feb 2025 07:19:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F8E320040;
 Mon, 17 Feb 2025 07:19:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:19:46 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 3/7] hw/ppc: Handle stash command in PowerNV SBE
Date: Mon, 17 Feb 2025 12:49:30 +0530
Message-ID: <20250217071934.86131-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217071934.86131-1-adityag@linux.ibm.com>
References: <20250217071934.86131-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6wY_fItFNPK-jBm_uTvrMfMXPb-MYnWv
X-Proofpoint-ORIG-GUID: kqtqYAR6KnuDlgrnr7b3sVsibkZyQauC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Earlier since the SBE_CMD_STASH_MPIPL_CONFIG command was not handled, so
skiboot used to not get any response from SBE:

    [  106.350742821,3] SBE: Message timeout [chip id = 0], cmd = d7, subcmd = 7
    [  106.352067746,3] SBE: Failed to send stash MPIPL config [chip id = 0x0, rc = 254]

Fix this by handling the command in PowerNV SBE, and sending a response so
skiboot knows SBE has handled the STASH command

The stashed skiboot base is later used to access the relocated MDST/MDDT
tables when MPIPL is implemented.

The purpose of stashing relocated base address is explained in following
skiboot commit:

    author Vasant Hegde <hegdevasant@linux.vnet.ibm.com> Fri Jul 12 16:47:51 2019 +0530
    committer Oliver O'Halloran <oohall@gmail.com> Thu Aug 15 17:53:39 2019 +1000

    SBE: Send OPAL relocated base address to SBE

      OPAL relocates itself during boot. During memory preserving IPL hostboot needs
      to access relocated OPAL base address to get MDST, MDDT tables. Hence send
      relocated base address to SBE via 'stash MPIPL config' chip-op. During next
      IPL SBE will send stashed data to hostboot... so that hostboot can access
      these data.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c         | 25 +++++++++++++++++++++++++
 include/hw/ppc/pnv_sbe.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index a6bf13650f2d..79818177fc36 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -82,6 +82,8 @@
 #define SBE_CONTROL_REG_S0              PPC_BIT(14)
 #define SBE_CONTROL_REG_S1              PPC_BIT(15)
 
+static uint64_t mpipl_skiboot_base = 0x30000000 /*default SKIBOOT_BASE*/;
+
 static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
 {
     val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
@@ -281,6 +283,29 @@ static void do_sbe_msg(PnvSBE *sbe)
             timer_del(sbe->timer);
         }
         break;
+    case SBE_CMD_STASH_MPIPL_CONFIG:
+        /* key = sbe->mbox[1] */
+        switch (sbe->mbox[1]) {
+        case SBE_STASH_KEY_SKIBOOT_BASE:
+            mpipl_skiboot_base = sbe->mbox[2];
+            qemu_log_mask(LOG_UNIMP,
+                "Stashing skiboot base: 0x%lx\n", mpipl_skiboot_base);
+
+            /*
+             * Set the response register.
+             *
+             * Currently setting the same sequence number in
+             * response as we got in the request.
+             */
+            sbe->mbox[4] = sbe->mbox[0];    /* sequence number */
+            pnv_sbe_set_host_doorbell(sbe,
+                    sbe->host_doorbell | SBE_HOST_RESPONSE_WAITING);
+
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "SBE Unimplemented command: 0x%x\n", cmd);
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "SBE Unimplemented command: 0x%x\n", cmd);
     }
diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
index b6b378ad14c7..f6cbcf990ed9 100644
--- a/include/hw/ppc/pnv_sbe.h
+++ b/include/hw/ppc/pnv_sbe.h
@@ -53,4 +53,7 @@ struct PnvSBEClass {
     const MemoryRegionOps *xscom_mbox_ops;
 };
 
+/* Helper to access stashed SKIBOOT_BASE */
+bool pnv_sbe_mpipl_skiboot_base(void);
+
 #endif /* PPC_PNV_SBE_H */
-- 
2.48.1


