Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4201D10ED66E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66WI-0003rF-Gt; Fri, 27 Mar 2026 08:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w66WG-0003qa-33; Fri, 27 Mar 2026 08:42:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w66WE-0007RB-59; Fri, 27 Mar 2026 08:42:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R303SN573231; Fri, 27 Mar 2026 12:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=rM5CqSwxGGyRgiWjqee5/1pXOOhnnNzwwZd0Yc5ms
 bQ=; b=g12EANPS9AtPljqcOAo9N+HW637jazRWrm5mgeQksSicRclnu8Yt8JT4B
 HqlhbBGZq4fLDKhXr2OcpBu+oL0xRW3fDj+95uFzdDeaPfrwh7iyJm7t8Go6ViA/
 Atb/esepcLyBzJbJ7kWIS0OWQACVtayTGIcZtBU+xfmNsBGfgyCXUeHbP/YHog5i
 +B96y6nqK7U0UVr+F4n1wk6+4iPVAG4FgJOfpri3gMWVzly+BP6aCJy+dOwSqbk+
 0NJGpiWUS6xOYrQXgCXOvmmtsMUvR3Q79IDW1gn6At70lCSSMutfc0WyslIzMhj2
 TVXlVD909rXp6sbGk45lpEWDileyQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0gwk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 12:42:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB5u0l012213;
 Fri, 27 Mar 2026 12:42:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkfabs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 12:42:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RCgAc330867958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 12:42:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF2D22004B;
 Fri, 27 Mar 2026 12:42:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61D0220043;
 Fri, 27 Mar 2026 12:42:07 +0000 (GMT)
Received: from shivang.com (unknown [9.124.223.21])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 12:42:07 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] ppc/pnv: generate dtb after machine initialization is
 complete
Date: Fri, 27 Mar 2026 18:11:36 +0530
Message-ID: <20260327124136.983955-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4NCBTYWx0ZWRfX27iXYD2XvAEg
 z/AvgdP5ElKJWyn0q9eiZr5QSoyJsfOaDElnL7Q6kHQ2JOrgaPjJiHvO5RlSWSPRNRCbyYhKHvA
 mxM166uzn2AxU3a0SPkyw7SZIE3xJXgEXRqU9V69BPMJNOIe1YZnL/He+wzA3vBJ3jXjDKvHRzp
 oQL3rujdlovJkOHVxEQtTcfEC9YWra4PKXwOl3QZCrbYGKXB/bRsWIlevTauUvz8e39pOGcOgM/
 BMPTw03Zl7wqlh8qHyWXsWkg5kRivg6/M+AmJaK+aN5aMInAVWBY3aX93w8M5/LeTBf88PS0Sgm
 pzzlOxXYOucBt3msg9kZqAxAA2sxpXRIJbJKnfTCVdNowxPg7N7UXHH046qHd8X/SUTw4OppLkW
 KLEBtWpJCBGlicYGPiE54ci0TxOzPNmi6F1nNlTQ7V4WDVs8wm1Ni4KXSpmhT1ao5HMTp29C1rj
 5H8AOTY8ZDbjZ5U5bIQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c67b27 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=EF3hw48zBu3OhOgeIqkA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: S8BiI-sJ9k9MEIHVLcnIwksJPpYN-Vm3
X-Proofpoint-GUID: uquMS-PIIoPErc8R3hnE0TqxIUa38oFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270084
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Changes:

v2:
* moved pnv->bmc initialization to pnv_machine_init_done.

v1:
* https://lore.kernel.org/all/20260324135026.247418-1-shivangu@linux.ibm.com/
---
 hw/ppc/pnv.c         | 58 +++++++++++++++++++++++++-------------------
 include/hw/ppc/pnv.h |  2 ++
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7e54b6bc60..524563dcfc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -748,31 +748,10 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
 
 static void pnv_reset(MachineState *machine, ResetType type)
 {
-    PnvMachineState *pnv = PNV_MACHINE(machine);
-    IPMIBmc *bmc;
     void *fdt;
 
     qemu_devices_reset(type);
 
-    /*
-     * The machine should provide by default an internal BMC simulator.
-     * If not, try to use the BMC device that was provided on the command
-     * line.
-     */
-    bmc = pnv_bmc_find(&error_fatal);
-    if (!pnv->bmc) {
-        if (!bmc) {
-            if (!qtest_enabled()) {
-                warn_report("machine has no BMC device. Use '-device "
-                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
-                            "to define one");
-            }
-        } else {
-            pnv_bmc_set_pnor(bmc, pnv->pnor);
-            pnv->bmc = bmc;
-        }
-    }
-
     fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
@@ -984,6 +963,37 @@ static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
     return chip_id == 0 ? 1 * GiB : QEMU_ALIGN_DOWN(ram_per_chip, 1 * MiB);
 }
 
+static void pnv_machine_init_done(Notifier *notifier, void *data)
+{
+    PnvMachineState *pnv = container_of(notifier, PnvMachineState, machine_init_done);
+    MachineState *machine = MACHINE(pnv);
+    IPMIBmc *bmc;
+
+    /*
+     * The machine should provide by default an internal BMC simulator.
+     * If not, try to use the BMC device that was provided on the command
+     * line.
+     */
+    bmc = pnv_bmc_find(&error_fatal);
+    if (!pnv->bmc) {
+        if (!bmc) {
+            if (!qtest_enabled()) {
+                warn_report("machine has no BMC device. Use '-device "
+                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
+                            "to define one");
+            }
+        } else {
+            pnv_bmc_set_pnor(bmc, pnv->pnor);
+            pnv->bmc = bmc;
+        }
+    }
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
@@ -1244,10 +1254,8 @@ static void pnv_init(MachineState *machine)
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


