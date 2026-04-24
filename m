Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC639FB44D6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC4D-0004gB-JX; Fri, 24 Apr 2026 04:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4B-0004fX-PV; Fri, 24 Apr 2026 04:39:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4A-0005Jv-5v; Fri, 24 Apr 2026 04:39:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIt3243108112; Fri, 24 Apr 2026 08:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8rF0iHKAOVxHpO7lM
 +YABu0ieviBsC8YYxWdyQVq0HQ=; b=MXMhHiHCUSkJ5fb55P0zY7EO5ggQpRuye
 wIkQv7wH7qtp9GCooKeMD7X8sL7SOFrQvV8Y2sEeozS/1FT9hN7x2AJinX/eFOmx
 WAxbx1yA1I5Rd7GvtoZpBlOv4LwOlDiRRruNGaw4tkUmBpBLVoNsGcDEX5vFPALZ
 FUfNOQPfFZrGsnmYKrra8bG2vWwXJSpmZ3L/LYKzuDvK7wEOW99iMvXzF1Lcl6t3
 UOim4Ler+2hjKvK97+9vS3A0BgP+X3dRWPJCFGTZN7L7eYYraPOI0fNzZ26DRoFS
 DE1hN6xt/RQH9pFOOR2hSNrZEzPCZ3We1JjJWpBOQyxC2pEt13T7A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6m4qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8KfCY009018;
 Fri, 24 Apr 2026 08:39:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky229n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8d8OS42402236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:39:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29D1520040;
 Fri, 24 Apr 2026 08:39:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59C312004B;
 Fri, 24 Apr 2026 08:39:04 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:39:03 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 03/10] ppc/pnv: Handle stash command in PowerNV SBE
Date: Fri, 24 Apr 2026 14:08:30 +0530
Message-ID: <20260424083837.214947-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX6Pns5E1Xjg7e
 e2D4g6bdTa45rv5ezfSZmmv21G+OX42LGK+8O5VZMJ2ojfYNmgfzxGIex34Pm7MrAlcg3T3wwao
 /mLPP/5JlmcM6rUoHQgUoDhJRkGewLeMN3goE5b7RecU9IhzbyFzkdqazDxUJKM2YpX4gW9LkMa
 oAc+DFXL97QmwVolmEAmWZzOG6JNMOFhGCh9wIxUqmqXHihBVHrVpBLV+dd5WXW8YfSKvF9jVC0
 QmtArbYebPA1HpI/Xri3pIMuNkEhQbprW9B+CtdinA422whfbkDjSpt318RKhxqwZoKsnIMnSwr
 hNvfrCHzeY/49vUIT/bpwGJaAkmvif5NQmT0IBNEJZ3Bml3f2HfeohhKaz4OhPTJZ1bMnOIGLRL
 DwBWms/JIjOISJhvpBWpdtzgXnm4wyGZh7TbFCvYuSemjorEKrR6AyIbQH9BSNiplK9PXoCJaXf
 vvTwdozHH1POu/zOxXg==
X-Proofpoint-ORIG-GUID: lZ8ww_UbJJxgKSnPh-BGyhDqyEaL_hms
X-Proofpoint-GUID: LQk9ylMRyziPuiN95K9rsMnGRknz5Dzr
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69eb2c30 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=lqnwqb0_oS2Hd41rSKUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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
---
 hw/ppc/pnv_sbe.c           | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_mpipl.h |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 5a2b3342d199..90fc407d05bb 100644
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
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index 61ef7ef8fe60..d1d542b72488 100644
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
 
-- 
2.53.0


