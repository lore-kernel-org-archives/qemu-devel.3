Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B108EF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUul-0006Ky-5H; Mon, 09 Mar 2026 03:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuf-0006Ha-Ga; Mon, 09 Mar 2026 03:20:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUud-0006B1-Rn; Mon, 09 Mar 2026 03:20:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628MP5gC1849314; Mon, 9 Mar 2026 07:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RUuZaIl2BO9hgmx/S
 SQppSlppQtAun4qakBW8cld8yA=; b=ol64r8Xjhzy8WiySJLpSoo2yDqNDOR9za
 kXj4Bjvi8hBIx+/+0gqZt3SETmttJkJF92j4Vd2QrO8y6XQzjz1++D1GjAWZ2l5K
 7rhcG+MP1DR3DdnGAObYTFda5TZuj31F0S7b5M+hJCo+cy8OHf0pym6wH9Gxgs3x
 0TwBKrJNuG4ZavhZaj3sgB1BtNDFip78FvimYlgRn3xIqG6Do+0h5nZ6xEhd2kjd
 p23bmg//AbRPd3ypaH4uPMfcBnuQtoalB0YQeUvBtREAZ0k7+XrhZvjqRjvXLNdz
 G5oVZ4MLKbmy2eBQybDlOhAvsSSyw5OCDPVIjusT6LAC12u8jQfmg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm5h1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6295UKAr024649;
 Mon, 9 Mar 2026 07:20:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjutfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KH6912190164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30CAB2004B;
 Mon,  9 Mar 2026 07:20:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ACB720043;
 Mon,  9 Mar 2026 07:20:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:13 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 03/10] ppc/pnv: Handle stash command in PowerNV SBE
Date: Mon,  9 Mar 2026 12:49:52 +0530
Message-ID: <20260309072001.3136261-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: kRE7T_JD1IKHVsqTs183VYzF3rYea0aY
X-Proofpoint-ORIG-GUID: -j01_TlyyJii5rOy4hdfzfWDKBP6joS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfX67xjQ5Zbp0fC
 8Pg0kf5CyhScOAwDTezEg7hCJ3D1xvnDriic1gtHe+hbvasfYWSMG7nHlew51UlxcjRlKqIX3Ur
 eiZIu3CMS8QiAgOGyMSilGutcdE3kzg2DnVZtnukj+JLR7RCZERT2zRRePn7o7kD2SNIMJxJNnZ
 xnoWAAtZC5NpZmZP8N5Mx/aDcU6yGJy/VWRuwDedRYsKM4ya2GXT4TDisYZnH9+8ZKZ9nM8Cfoa
 MXRDOoCwOc/cBJSpdGu0zAZleX55VD+Hon3fDQfdBe9Fzl3jUMAxqn2irzEiOgu+cFmS2CVeG7J
 gpNdGJ5UzGkhsRHcSFAaJ1+9MgyRLiW76bbaqYiYdfv3OcJPpXPRHHhPW4OmZLPleJ9Ay5mppL2
 7QhAPlyt/OWk/2bdQLmKO1vEa0qgkM6vYRdXaj8bHW3ZovLCYbqhHbTBPF3x94H4Z8CIbkRe/o1
 7eWcW/DzwzQdTxfqlkg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69ae74b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=rjUXpLR2p4wDE8UIozkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c           | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_mpipl.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 5a2b3342d199..46c5047f1c0a 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -233,8 +233,11 @@ static void sbe_timer(void *opaque)
 
 static void do_sbe_msg(PnvSBE *sbe)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    MachineState *machine = MACHINE(pnv);
     struct sbe_msg msg;
     uint16_t cmd, ctrl_flags, seq_id;
+    uint64_t mbox_val;
     int i;
 
     memset(&msg, 0, sizeof(msg));
@@ -265,6 +268,40 @@ static void do_sbe_msg(PnvSBE *sbe)
             timer_del(sbe->timer);
         }
         break;
+    case SBE_CMD_STASH_MPIPL_CONFIG:
+        /* key = sbe->mbox[1] */
+        switch (sbe->mbox[1]) {
+        case SBE_STASH_KEY_SKIBOOT_BASE:
+            mbox_val = sbe->mbox[2];
+            if (mbox_val >= machine->ram_size) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                  "SBE: skiboot_base 0x%" PRIx64 " exceeds RAM size 0x%" PRIx64 "\n",
+                  mbox_val, machine->ram_size);
+                return;
+            }
+
+            pnv->mpipl_state.skiboot_base = mbox_val;
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
2.53.0


