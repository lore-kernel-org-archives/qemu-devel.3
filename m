Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BBDCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkq-0001lv-Sl; Thu, 23 Oct 2025 07:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkZ-0001P2-Mo
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkW-0001cB-Gs
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6OILQ007627;
 Thu, 23 Oct 2025 11:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MLbS2Z
 xde9nv+p/z5o8rHSvwi5Bt6B6KkQCG6FaD6w0=; b=lO3W5NBe1n5YDCjA2RneAc
 CBDMgXLKOF2ZHJyN+zaiuVvCgFnM4KzPoJlMi0gXc9xpY2M2ViGtz+gmIgzkFTqz
 Bt2GI7HNSk5FuIh7PPkQPGtm1oe3/6N3yjMle0ozICpHVkqqu+EwpFGyzTKlqz7O
 +5AqBfEIfl2Lt6cHlCChpX6VrUnaoAUzmOx7PfU/VtHvAAGMMgjdkTcnzGiDnYz9
 fUaKhKZcy1xFiDsOzhA/s1WDwlPWWcK2wEc1QDNWiD3PoWInymqfT3vBnM7TnKE+
 x0iB+fioqAFdNKN94fBSKWJxfI0rhlowTxFi99VDqpZTpOjZRx3JuCLdauF/rX7Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271wcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAk0uo024940;
 Thu, 23 Oct 2025 11:44:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5dsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBinRd29360420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EB4C20049;
 Thu, 23 Oct 2025 11:44:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E46420040;
 Thu, 23 Oct 2025 11:44:48 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:48 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/32] hw/ppc/pegasos2: Remove fdt pointer from machine state
Date: Thu, 23 Oct 2025 17:14:03 +0530
Message-ID: <20251023114422.3675018-17-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa1534 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=MSIEXOgWn6CInn48Bo0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyTgpIJniRYv3
 Y5rz19jX4fSFN5JjbHBYwZ0P6+OF66CIek3CS0Kdn2kCDqUU21xkZLe6d81L/yB5qHauuUvC9HJ
 K0cVDPmChvqA3eTKG8b+SdRCRF//Be7vaSRp1uK742XaUR6Lfcngny3288EYPRRaspwH+aZBNka
 dcnWEZQpotaBYd+Cni652NTM3QDg+OqDWgzMYpTLeej3Uk8b0TrgZXKEQLGk8f+mAcKMtG5V6WL
 9ckdi+5eWrhHABfrdOK74/WxXBHgNs2U0gw1c4qggopfaCNow+AirC47QHsq8oYc8zhMyXNeC0N
 7Mzb6VD8awXo0tHpBcoEkQ1dF9KWGIjEiuq4EefnlMDnWNFyzhZ/xa37YYgIp/2uFFyUz/yvfHi
 ELJE5X9AJjbqul5lFDgyxGVjzn+xPA==
X-Proofpoint-GUID: diU60jPht6yQsikJi6Z01S13YddkrvjB
X-Proofpoint-ORIG-GUID: diU60jPht6yQsikJi6Z01S13YddkrvjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The machine class has a field for storing the fdt so we don't need our
own and can use that instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f4355b8d2889aba19d28001e61ac3f9937fc5250.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index f4787397dc..2ba579dddf 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -74,7 +74,6 @@ struct Pegasos2MachineState {
     qemu_irq mv_pirq[PCI_NUM_PINS];
     qemu_irq via_pirq[PCI_NUM_PINS];
     Vof *vof;
-    void *fdt_blob;
     uint64_t kernel_addr;
     uint64_t kernel_entry;
     uint64_t kernel_size;
@@ -413,13 +412,11 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
     qemu_fdt_setprop(fdt, "/chosen", "qemu,boot-kernel", d, sizeof(d));
 
-    g_free(pm->fdt_blob);
-    pm->fdt_blob = fdt;
-
     vof_build_dt(fdt, pm->vof);
     vof_client_open_store(fdt, pm->vof, "/chosen", "stdout", "/failsafe");
 
     /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
+    g_free(machine->fdt);
     machine->fdt = fdt;
 
     pm->cpu->vhyp = PPC_VIRTUAL_HYPERVISOR(machine);
@@ -559,7 +556,7 @@ static void pegasos2_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
     } else if (env->gpr[3] == KVMPPC_H_RTAS) {
         env->gpr[3] = pegasos2_rtas(cpu, pm, env->gpr[4]);
     } else if (env->gpr[3] == KVMPPC_H_VOF_CLIENT) {
-        int ret = vof_client_call(MACHINE(pm), pm->vof, pm->fdt_blob,
+        int ret = vof_client_call(MACHINE(pm), pm->vof, MACHINE(pm)->fdt,
                                   env->gpr[4]);
         env->gpr[3] = (ret ? H_PARAMETER : H_SUCCESS);
     } else {
-- 
2.43.5


