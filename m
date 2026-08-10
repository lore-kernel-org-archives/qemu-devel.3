Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4E3C5B569
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVCf-0001XM-PI; Mon, 10 Aug 2026 14:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCd-0001WJ-P8; Mon, 10 Aug 2026 14:58:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCc-0003Sg-53; Mon, 10 Aug 2026 14:58:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGVa292154199; Mon, 10 Aug 2026 18:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TR/zMuZQNfrB4LNiZ
 cJDwIVjsxAmSUCCo0C3kWPvJlw=; b=c8FHS8M9NVLvGbwIGQKFRuaRQrNQGR2vk
 7GIs30hgxRekn+HZ0IhYomt6rf5oJKMgNvq1bP7oNTNmOLxd5McsjSk1AsY6KgzO
 9jtYeiB9sFvjTrlAV/NKKH+8cKH2aPIyslEM3LTf+kNgoI5seHNrDyABFhPB0ijd
 exraQTKz3XQRnCdFUSSX9LdpgukoS+utkNO6CNr/LBu0Gu8nLOYAlHu8BCeOaZKW
 EZFDJcKhiv9nrIZIT17rPpkN35EQVltPTocu09L/1xoOB/emnVqo9eQUFV0ItZOn
 vJ3ZvrQQbfl3L5ksN8tV9n7u1G+UT5ohTpRrlPSEW9hMMAd5slFHw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9hngq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIujVN020349;
 Mon, 10 Aug 2026 18:57:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vx5gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvrHn29557362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B57F5805E;
 Mon, 10 Aug 2026 18:57:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA01E58062;
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:52 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB
 bridges
Date: Mon, 10 Aug 2026 13:57:41 -0500
Message-ID: <20260810185748.1253-4-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX0bBo8KwRv0Fu
 ygMS3flcMOqAH+/oGC5CK+sfdzHbi2QKE2YVLH/I6hzEJ5TztVrcj7jdVegG5RyvpH9QY+2TmKf
 W60OCsuZDotr/tGgvJt+smDlUxf3fnPI5QN6CDGT1GytHg3IdrTmpRcWVFHAu8IinqkjyZ3RxL1
 rB4rcgBtdUXRmbtZOIicBTj3ngTSn96V8YXFrMQhqjTTYWR59ka4uGd8F6/qGpV25ez9JwvT9mh
 Fe8TmhL5KGyyO6L+1Fg3/3v0a/j97a8RCMCXuSe+mYgmekSbUrrQcF+TQmnMoNQpxCwSGyJ1pDh
 NWtXKXhvZcv0KFB667E62lPBuBGNxUr9ZLWpfqwt9HaSRwUQ1boOenFvrfGWp+AebI7By9y0nc0
 beu9SAOyEbe8wkXdMRmr/a+gClL+KhvsP6I1ljAYhaTX1+2ZkBsKCWTN51NhklWXwuOdie2llTT
 GWYPQUXL0IjjkRMVfdg==
X-Proofpoint-ORIG-GUID: -ZFAS8FulKbi5Zp4jxJIAgm9tqgQzbWr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfXxEVEy/zWB7hF
 HltKEqUiZWl4tCDvqc0shoad/ywTtgor4nCxNcWo/Oo7Q/9cQU6JGfTd2N/v+kvLjb+wFmZGARb
 3T9Ay26Sws34q32VGFC7/S8ic3ZM8tk=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7a1f34 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=phIN1QjiwUTDb9KW1ZcA:9
X-Proofpoint-GUID: 37KPgVB5pCdp9Mywkn7VkZhW67Rl3px8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100158
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


