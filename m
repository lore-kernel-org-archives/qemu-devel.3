Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB04CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9jJ-0007aa-UO; Wed, 29 Apr 2026 14:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jE-0007ZW-HB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jC-000771-M8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:44 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TFsqo01456647
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2Xqg4RFI/atH/tsbS
 PJi8b4xny2Q3jc7Mgr5yIFu4fk=; b=WwxYRG2gDbjJ1RKpwv/TuedEJgoAo/bfX
 bwfanjeXjtNKY1UrDZPqwEG198HuNDiklJ7y5cYagEaQbikVwZQktn2mpxYc/Kdw
 LfJLvprGwzQQ2ITM/TMuP3kfDKt37bCqBV0Fsno901mD2bHF8pzk+kB7gz4E0cQW
 4mb4sCE+hOjZK2Ec3pyRQcuhvKYiqfbayfQrfQPDvStTKckabOUfALafNIslXHGb
 UqE+cFmkdDrylIEd2aTl65Ysc77ZT+IyYs+pjo7OVT5sqWUqg8cUJsR39nXSjHvF
 au+bOAgWZdQ7p0IIhwzLKlq1gbFolJ4y2nYP5XECON3q6nyPvFtmw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vjh5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINlNx004874
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehfgp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXaID16843218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:33:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EB5D2004D;
 Wed, 29 Apr 2026 18:33:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4948A20040;
 Wed, 29 Apr 2026 18:33:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:33 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 03/13] ppc/pnv: Handle stash command in PowerNV SBE
Date: Thu, 30 Apr 2026 00:02:53 +0530
Message-ID: <20260429183310.12455-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f24f05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=lqnwqb0_oS2Hd41rSKUA:9
X-Proofpoint-ORIG-GUID: IyHW8hFasyweVjpj3jU_rb9gqp8bGzG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfXwlVD8ycvTrTB
 axEdjeT0By4F6L1STZzI+cwFfJW5Vh2R46mzhZLBiwyd4gVmxAV9Db04IsxMg1w//eY/rHr/TGf
 W/UNEjN+bHFfuhrIEQ7/fyv+QPCoMa2tqmobCWDfp8ics4wHum7BBWvIxgANI0ME45c3qE03gi3
 gYTsx7AMmCykJlyZMOw6HlG53VHtSMJoRlBqH+4AFllRgWKIAIZUExPQqvth0sfdY27OmItoAJT
 LTBq9e50SULEinFUX4KxLtppwVZsnaf12ov0fGlz4sNNofQFEPyfYh0+kj21YZ2Zts2hpDGmEMw
 QFSn9xN/bRe51MEmFsnpBLLeRyPIqDutCi60dBjMF4jTryfhgcOaNDXAUnNHqbI5C2CyiRvDAdh
 raHp0F7VmXH14rsHFL66XcHS2ERmRFefr2J7lmk7rMlRxsOcavZARNlxUohB7uqlGYl3MUk5dez
 Z6hZXrkI9pTS7/rmjBQ==
X-Proofpoint-GUID: IyHW8hFasyweVjpj3jU_rb9gqp8bGzG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

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
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-4-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_mpipl.h |  5 +++++
 hw/ppc/pnv_sbe.c           | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index 61ef7ef8fe..d1d542b724 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -8,11 +8,16 @@
 #define PNV_MPIPL_H
 
 #include <stdbool.h>
+#include <stdint.h>
+
+#include "exec/hwaddr.h"
 
 typedef struct MpiplPreservedState MpiplPreservedState;
 
 /* Preserved state to be saved in PnvMachineState */
 struct MpiplPreservedState {
+    /* skiboot_base will be valid only after OPAL sends relocated base to SBE */
+    hwaddr     skiboot_base;
     bool       is_next_boot_mpipl;
 };
 
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 5a2b3342d1..90fc407d05 100644
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
@@ -265,6 +268,41 @@ static void do_sbe_msg(PnvSBE *sbe)
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
+                  "SBE: skiboot_base 0x%" PRIx64 \
+                  "exceeds RAM size 0x" RAM_ADDR_FMT "\n",
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
-- 
2.52.0


