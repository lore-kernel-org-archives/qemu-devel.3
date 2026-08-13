Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586BCC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wub9D-0000ej-Tp; Thu, 13 Aug 2026 15:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wub8z-0000cG-MR; Thu, 13 Aug 2026 15:31:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wub8y-0005YA-2N; Thu, 13 Aug 2026 15:31:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DJ1Wm93144703; Thu, 13 Aug 2026 19:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jfTCYN
 r982oAyzSBVsp+0HjZNznludIiAnHgfS6IhQY=; b=aPBsNij1Oe7oggbl0jSeFM
 jsD3/nV0ZECesTnRdDS4Vdby4E2XJ1EQ5whHPwS1duHEEfeZTZs4JE1zW2dMhvnD
 5Lq3dXyvO7CZf2w6yojPLFFXsNGwo7ruLXlzxRA6qv4VTZYHTuPpwJXv4BWtannI
 l9vlkWou6NWQfCvryhAl0DDm3nmQBaEQMgdmBQujpUNatTqNznaV6qvJwvaRnV/y
 AfmLdjU1b7Si7vj5GhpuSOMCraI0aONbdrz+bDDscjue/yT7RAQeThMmluU0iv9M
 qaQVcAeOZAcCTiEw8KPk2WOWEqFbCLubVuSgF3l1qHhZPECbfuVuzCgaMRRcZluQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9sm08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 19:30:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DJBcKP022994;
 Thu, 13 Aug 2026 19:30:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wcgsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 19:30:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DJUj4032637562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 19:30:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 248BF58059;
 Thu, 13 Aug 2026 19:30:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47D6D58058;
 Thu, 13 Aug 2026 19:30:44 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2026 19:30:44 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 3/7] arm/aspeed: Wire AST2700 FSI controllers to APB-to-OPB
 bridges
Date: Thu, 13 Aug 2026 14:30:35 -0500
Message-ID: <20260813193040.669533-4-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813193040.669533-1-mikail.sadic@ibm.com>
References: <20260813193040.669533-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cak7SkUosunBky5GcC6pJD5SoWnWV5Lw
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7e1b68 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=phIN1QjiwUTDb9KW1ZcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzOCBTYWx0ZWRfX27fNcOGYT5BS
 B1EW9PkfCnRSOUevK3ap7T6hd6YRFAjzHh+2mS4I1y7Oy1/a2I6gFJHrGFNldOuxVJOB6R8ZbDk
 2TJBPekUS4nvOwX6xzoS5WEILh+yDDjhsdt/Av+LFflf/Lbojkudr+ki4VjfVY67URRoxA/xmeT
 MmG/0SWdujQWZJdCgZSgaVQBQUJC27lPcuLFdKnbJ1XggJTGWBjD67t0LU32lb75V5QMqQJMQ3M
 /DtlEG1cmnis4kCZKd/6HiTT8TA3vuCXF8HG0zzmeqEMgaT4rXcSgP3FAfz+MXcRVKtpvY/6+AG
 /41PyRl2sWC8c26prVuSmbEHSvZ+SEjBrBVta4/BYi7uuzEgT30mbhcAVL0kSBWIoW4gvp2cSQa
 R3uBuMDmNT/MxIlgbuu9jZgRyCtYPsqHFT1Q7tLx5VckR31DMGb+rcNQuCsCLC+ScsxfL6Sl9KY
 WA6PrrfHXTOy00KBd0g==
X-Proofpoint-ORIG-GUID: g_1Z6vprPJIU0GcOAF6vdDA6fpmixAXe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzOCBTYWx0ZWRfX/6j1KAx8wFWI
 hRLva2QuebPf90WpqVb+w21YmoeSvI5Iqvh7OouB4xqfnz5TLwsSKBMVkyL5jEeZD+wPp2l0SHQ
 4DeS0FvhJynEe58g3d8mtKNJPIYsLYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130138
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6365dbd638..87f7c8070e 100644
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
@@ -1137,6 +1145,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
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


