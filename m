Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC10F54AB0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52AS-00060J-Qf; Tue, 24 Mar 2026 09:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w52AQ-0005zC-Go; Tue, 24 Mar 2026 09:51:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w52AO-0006o3-7B; Tue, 24 Mar 2026 09:51:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O8hR10569186; Tue, 24 Mar 2026 13:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=buuiN39Vu5REgaZO5K2+FV8UZFg9qf9shKom+SDvP
 wU=; b=XBrxl0Isz/7NYTWkSx078WFmpFFhirkKGClIvjNhLTyoTkbGZq1SahuSa
 fSr3nrxmMHiL532iH69qsDrNSL+e8yzsfhZIS5XjvgDYn2S/hyTtOZf07aN17F4R
 1unq6QXJ3tOhL20eioCgyB5bIIXu/tmBfb6jhfoTCOhNzCqm7+jOLe51ZkiT9xDx
 +d+g6Cvgx7Enim4iLawzPjjtG+QkZLRw1JTuZ7DBX2SUnMpwROo5mO9DQzgL5os9
 2WpbxdYbf0gDOASd6RLxf2oXXZUizZ2CwjSm1uJkLMjRrEGqHWvrIsD0omMzhZRr
 oUXdz93IZpMGj5tSzZTWVfsSaIaWw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuu6mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 13:51:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCe3qs026698;
 Tue, 24 Mar 2026 13:51:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kt1n2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 13:51:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62ODpK1H60621286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 13:51:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F244520049;
 Tue, 24 Mar 2026 13:51:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B80620040;
 Tue, 24 Mar 2026 13:51:15 +0000 (GMT)
Received: from shivang.com (unknown [9.39.27.96])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 13:51:14 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] ppc/pnv: generate dtb after machine initialization is complete
Date: Tue, 24 Mar 2026 19:20:26 +0530
Message-ID: <20260324135026.247418-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: PL6XUOS4SMvoB2sdZj_IUFRltYYO4G3q
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c296dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=3Nvx4KkB4OfEQQwSXpwA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwOSBTYWx0ZWRfX6xOMU+08LE2Z
 SRSOrFBZ2ZTZeW0W1HA5RmqGn1L43Iu2t5Y3eSaPj+uH9gEJHKwV4ek1EXY2XnrmSWsY7HJU/nY
 BrZWDWJx/7FruzGLHqLp+MmTYe6sZi5flAhMiXYIrZy79o/lA1EadldPKr4n7z98W9uEzRqAqlp
 vdcpp5f3y2hUlncDORX+7pGD8HwyrI2FHtYpcpEBHl2WYo1AF/ffiAwilTSnGtX+15PLCzp1IXo
 MrQAu1Gae0LxwN2O7fpuFjTS1eW6nmq4OggNQ+cVe/EJB2m6oNnzS9Z8gKw7E9fU6SDF3az1k1l
 s1BMdKVFEk/o83htiU+6r3FL7Ty038i5IM2h98aSNvzPQSQYlVY2UkAwkxy/1WpkYHyNI0vSgX3
 F3ctWx7tuKEzgrpmFVGjwDaGiwPWiKknjMrCupdkY9JMuemnnv3XdQ54RELhtL60smqM0a4fW0h
 uYRxX3Bq1yjOydMVh/w==
X-Proofpoint-GUID: 8HALic1-HaJl6yIUSwE-5z-3F96iB8gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240109
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Currently, the machine dtb is generated in pnv_init(), before all devices
are fully initialized. This can result in an incomplete dtb for the system,
as seen in bug [1].

Fix this by deferring dtb generation until machine initialization is complete,
using the machine_init_done_notifier hook.

[1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-stable@nongnu.org
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/pnv.c         | 17 +++++++++++++----
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7e54b6bc60..f13b2e3db8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -984,6 +984,17 @@ static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
     return chip_id == 0 ? 1 * GiB : QEMU_ALIGN_DOWN(ram_per_chip, 1 * MiB);
 }
 
+static void pnv_machine_init_done(Notifier *notifier, void *data)
+{
+    PnvMachineState *pnv = container_of(notifier, PnvMachineState, machine_init_done);
+    MachineState *machine = MACHINE(pnv);
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(machine->fdt)));
+    }
+}
+
 static void pnv_init(MachineState *machine)
 {
     const char *bios_name = machine->firmware ?: FW_FILE_NAME;
@@ -1244,10 +1255,8 @@ static void pnv_init(MachineState *machine)
         pmc->i2c_init(pnv);
     }
 
-    if (!machine->fdt) {
-        machine->fdt = pnv_dt_create(machine);
-        _FDT((fdt_pack(machine->fdt)));
-    }
+    pnv->machine_init_done.notify = pnv_machine_init_done;
+    qemu_add_machine_init_done_notifier(&pnv->machine_init_done);
 }
 
 /*
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 24f8843a40..90028f974d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -111,6 +111,8 @@ struct PnvMachineState {
 
     bool         big_core;
     bool         lpar_per_core;
+
+    Notifier     machine_init_done;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
-- 
2.53.0


