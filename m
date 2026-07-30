Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEACCC5516E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpX5A-0004CJ-V6; Thu, 30 Jul 2026 16:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX58-00049F-KY; Thu, 30 Jul 2026 16:10:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX56-0001gR-Tn; Thu, 30 Jul 2026 16:10:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJmVqD2081872; Thu, 30 Jul 2026 20:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TR/zMuZQNfrB4LNiZ
 cJDwIVjsxAmSUCCo0C3kWPvJlw=; b=SfHpFSIbGj1NtcHLK1JFb1q9sK8rJOn9e
 y8PQOt9Y2WQzBxqk4VkoL1R43Fno29VrfjSzQLd8tBuXJet875bSWTMBIKtQ8r7j
 qIHnC8oMwW6s0vthbWBf8y70DPEdhXlILr6r5FYKIAqPCe/bkfpMJ6A5zqapYDlg
 4MBuX8ZON+rqCzKuFbYtUJChbc75irkv4E64sRuWFeRNwPhuK27Qe8cIZf9Fd5a/
 vUJwNu6ckN+Jt9CSCErmq5JO4POatjjg8mDaaey6a0heR1s4hVVl9uTHt+FCVOhZ
 4k+clq/naTFlmqILWgFiL3L6jLntnWnWuEOvYAs9K2B1Z5KsTyELg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycsmhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJuLjs008962;
 Thu, 30 Jul 2026 20:09:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwd383-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UK9mY429688336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 20:09:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A75E5805D;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24D1758055;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB
 bridges
Date: Thu, 30 Jul 2026 15:09:38 -0500
Message-ID: <20260730200945.1113936-4-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730200945.1113936-1-mikail.sadic@ibm.com>
References: <20260730200945.1113936-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aXlHLMtTivrWextQ2yR7MwyTfWqUls1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfX7nmPQ3u/Z7UM
 clZw9o6bu+P8Dh/04mMD9AMKIPfWA+MCHN6xncXFhq4Xqy6N6h1ZgHnL386599KLOx8fw6gseUK
 rlf5D2CZI84wicWzQ+/IhABIDexw7JZRJuLbxxBtJKahA6OGUq2J3pwnnR3088/htT8I+7w7th+
 NbdVTiKZ/NPrfmr2oeo/ZnqdR8PX8jfL/NmJnBa2QtaK/E4GCuVD+ix4pPgVll3q8nPDG2QY2GT
 KFH9PJjz4zcpL9tlXNqEEinfP1pu6euD6frD39TMOTEc3s1+8ELP0gQgkbsNIviSrV9wbAKUuiR
 AV12go/N4EosKsC4Iw85TMtl/Uv/KiuTxxrlxSLTLWVoxiEK9LxACMAgn2yGUjbxpXz2pQKdrhS
 nWHAGbLryvJuVZT5mULvR6U37pA7qjQ12gF4mAwuGojWKwrC03PXboc7qQCYNKhk5PBf/Uert2j
 3myOxnMp2ir+bJqv4yQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXzzJZXVcFJI40
 QnztJ1jP0Iim84rGVna13mwAwZQ10wlt4C0TZ3L0+flfDXivWV8Y5Wpy9eJbaJXJ0uLvSc2MHXv
 ERi4XSl+guCLyfl5FZrdVTH4yQAsHbQ=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6baf8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=phIN1QjiwUTDb9KW1ZcA:9
X-Proofpoint-GUID: e06NPOStSOryLsiTMy1eqHDweHXpPIFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The AST2700 SoC exposes two FSI controllers behind APB-to-OPB bridges.
Add the ASPEED_DEV_FSI1/FSI2 memory-map entries, instantiate both fsi[]
APB-to-OPB bridges and map them during SoC realize, so the CFAM/CFAM-S
devices on the FSI local buses become reachable from the SoC.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 hw/arm/aspeed_ast27x0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index dddd7d2106..b908d7d4ff 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
+#include "hw/fsi/aspeed_apb2opb.h"
 #include "net/net.h"
 #include "system/qtest.h"
 #include "system/system.h"
@@ -98,6 +99,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
     [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
+    [ASPEED_DEV_FSI1]      =  0x21800000,
+    [ASPEED_DEV_FSI2]      =  0x23800000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
@@ -559,6 +562,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
                              sc->silicon_rev);
     }
 
+    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
+        object_initialize_child(obj, "fsi[*]", &s->fsi[i],
+                                TYPE_ASPEED_APB2OPB);
+    }
+
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem", &s->iomem,
@@ -1132,6 +1140,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* FSI / OPB */
+    for (i = 0; i < ARRAY_SIZE(s->fsi); i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
+                        sc->memmap[ASPEED_DEV_FSI1 + i]);
+    }
+
+
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
-- 
2.53.0


