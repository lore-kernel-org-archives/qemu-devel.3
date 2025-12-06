Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A392D3ABF5
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 05:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJY-0004C5-Iw; Sat, 06 Dec 2025 00:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJT-00048x-0E; Sat, 06 Dec 2025 00:58:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJQ-0005XS-4m; Sat, 06 Dec 2025 00:58:34 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B62wvh9005296;
 Sat, 6 Dec 2025 05:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6cPgRN+TlNQStUUWI
 2YeGjGMdaMcQjty9cbw/P60u3w=; b=k8xoFIIeWpQxqKRCMRRAvPo0L3PQwo4us
 Rq91T5Yby6RPk4QMJPy/FoCzoAOM3Nj37B9qEQRTiS2FyvqyN/0Tt+NZPKTI1aUO
 LJuKiK05GvlVSS4NgGUc0Cx0IOMj3tY8uy91hIC7XfDsF63CfdNBB0G+PUuJKC0x
 WTY7ktSD9JA/1F5/ov9fyFWETgLLSCaZqC1YBkB2IwoA80dRurwjq49o4Et5fKib
 wJQ06EsSGuNMQq9P5rHAUHdp8fb+UE05OCdZKE1hry0dMQmsAo58S70JpGV6LhT6
 1BQK6WP5GL9ErXnTenrB+TNy9SB8b4a4JRM+5wNRTF6iyWfVeJLmg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc610evk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B61xZ7S010333;
 Sat, 6 Dec 2025 05:58:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnkrygv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wO9a30867780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A55720040;
 Sat,  6 Dec 2025 05:58:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3752004B;
 Sat,  6 Dec 2025 05:58:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:21 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 3/9] hw/ppc: Handle stash command in PowerNV SBE
Date: Sat,  6 Dec 2025 11:26:42 +0530
Message-ID: <20251206055648.1908734-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX3/q4s0svO7Qa
 AlhUDbwq/CwcyIqZKzW90thKq5yjSM3lhnv/v24VCklbFDl0wT1ud7iB8HZ2wucKRB4V4aJEs18
 +ClNgPuRHwNbitJg8OjUEBwo4OfttGKR6XBgzYF/bqRWSz+6RV5xjSQUmriX7PGS9g1V9Z3LQz0
 rtfgYNZpKUKTjWNc5fIF0qYQSX7CzLtQW1cw/FytJ5MMiFbkc0vFP8JbgjaVAr6VGquMUQNzhcm
 78tTEQygvZDIG5ztMTwvIf+dKL2Vit9jzzh5PrkePstFhPUQeE/uq5Pgn3sJzVr6EiV3wWsLU8g
 +RP63zYZtiuXN68IqRROarG9cJxofMXpjbS1aNO8eDrS169MU1KT2feCgRuyL9yxmvOb16VlxTr
 fDJzHH8/94Jx3g3/jPown0uRwyVR+Q==
X-Proofpoint-GUID: eO8qQ9pLJfrJoyDDQt-6533rLv6DEJHL
X-Proofpoint-ORIG-GUID: eO8qQ9pLJfrJoyDDQt-6533rLv6DEJHL
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=6933c605 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=rjUXpLR2p4wDE8UIozkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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
 hw/ppc/pnv_sbe.c           | 27 +++++++++++++++++++++++++++
 include/hw/ppc/pnv_mpipl.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index d004b7d5c225..af888126e758 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -233,6 +233,7 @@ static void sbe_timer(void *opaque)
 
 static void do_sbe_msg(PnvSBE *sbe)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     struct sbe_msg msg;
     uint16_t cmd, ctrl_flags, seq_id;
     int i;
@@ -265,6 +266,32 @@ static void do_sbe_msg(PnvSBE *sbe)
             timer_del(sbe->timer);
         }
         break;
+    case SBE_CMD_STASH_MPIPL_CONFIG:
+        /* key = sbe->mbox[1] */
+        switch (sbe->mbox[1]) {
+        case SBE_STASH_KEY_SKIBOOT_BASE:
+            pnv->mpipl_state.skiboot_base = sbe->mbox[2];
+            qemu_log_mask(LOG_UNIMP,
+                "Stashing skiboot base: 0x%" HWADDR_PRIx "\n",
+                pnv->mpipl_state.skiboot_base);
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
+            qemu_log_mask(LOG_UNIMP,
+                "SBE: CMD_STASH_MPIPL_CONFIG: Unimplemented key: 0x" TARGET_FMT_lx "\n",
+                sbe->mbox[1]);
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "SBE Unimplemented command: 0x%x\n", cmd);
     }
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index c544984dc76d..60d6ede48209 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -8,11 +8,14 @@
 #define PNV_MPIPL_H
 
 #include "qemu/osdep.h"
+#include "exec/hwaddr.h"
 
 typedef struct MpiplPreservedState MpiplPreservedState;
 
 /* Preserved state to be saved in PnvMachineState */
 struct MpiplPreservedState {
+    /* skiboot_base will be valid only after OPAL sends relocated base to SBE */
+    hwaddr     skiboot_base;
     bool       is_next_boot_mpipl;
 };
 
-- 
2.52.0


