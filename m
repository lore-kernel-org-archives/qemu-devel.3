Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85610CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuI6-0002vm-On; Thu, 23 Oct 2025 08:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG8-0001Hh-Rt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG4-0006Rh-BS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MLvesH009163;
 Thu, 23 Oct 2025 12:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4r3gci
 mnVaxRH11Ad0jfuJA9DZCx9TNezn3pCJerEKE=; b=rj8uAeZkBJTZ0iBa6UvF2N
 o7KtI4qwybadvaZ64ws6zOd71s5QjoOHovxYSsCBLP/PokzoN8ygi1tW6zB4wqhY
 EANlxPDcQ7rnRHmOTFsoYXhde3McP5UhuP3cirbS07Gs5JTe4f9xJnV9MuCXvrPk
 j+eaU366reArPK5VbIfMh43pUZJMj3W2+uNEJUo674Z4Tcqr187nO4IBGhjuabBW
 rrZKcM3Rn5geVgFCep9nZyt9zmDPcKWepWdjqlz6MDH1idrhIaCCXz/Bv/LdtSmS
 uE2i/r74jS6NuF0tomzTXQmbC89wZuGHAP59Ti682cd8YhLVHg0uY7Ol4gBAwb9g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fj26f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAU0TS032096;
 Thu, 23 Oct 2025 12:17:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n5jyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHOiT49152386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F2842004B;
 Thu, 23 Oct 2025 12:17:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DC5E20040;
 Thu, 23 Oct 2025 12:17:23 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:23 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/32] hw/ppc/pegasos2: Add south bridge pointer in the machine
 state
Date: Thu, 23 Oct 2025 17:46:37 +0530
Message-ID: <20251023121653.3686015-19-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa1cd7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=TGpnWNUbWJQoO7jwSJQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: ecKNsMFR4_jwfL2LnaBcYJv4QMTYfAcR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwlwmN/tQdoSw
 EHOJRNqre6/LyA0nwcv6CVU6YHE/VabCa+Ook64bMz+omRDYz4dwhuS5ZB8srC2Di3c32VeZUu0
 fR3TS3VLe/cKPgk/i3XB9OkY1leIfXFWk8+q2lIJ6TE83yI2z5y2VXadD0UoQCommDIysMe26wB
 U/oMM2gAXqWxIZMX/ENVH05cFCm/mxTsqCWiNyzEHbFVYQ3IS8zIkTO2LGumB0MmlJ3RVsQaBIS
 HbJvIqHl16ixspCgOoKvCnKR4JEbuS9AwfPRRLPuWyYMMtOdaVwODzjzDV7p9vLyjuMb2nppvew
 wYE5EegyHd/iD52MiUVwfKYRt5x586XIxk7ugvBEiLolOOE/l5P55cdsf61PpRkj2/iKFZyWVJN
 Hw9i7Neh8g6nIC5CnJgkX11UOf8U2A==
X-Proofpoint-ORIG-GUID: ecKNsMFR4_jwfL2LnaBcYJv4QMTYfAcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
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

Add field for the south bridge in machine state to have both north and
south bridges in it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/654d3223b418d5bb2ba08a2b014375c2abf341aa.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 9b89c7ecc2..4b63f0e175 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -69,6 +69,7 @@ struct Pegasos2MachineState {
 
     PowerPCCPU *cpu;
     DeviceState *nb; /* north bridge */
+    DeviceState *sb; /* south bridge */
     IRQState pci_irqs[PCI_NUM_PINS];
     OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
@@ -174,7 +175,8 @@ static void pegasos2_init(MachineState *machine)
     pci_bus = mv64361_get_pci_bus(pm->nb, 1);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
-    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
+    pm->sb = DEVICE(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
+    via = OBJECT(pm->sb);
 
     /* Set properties on individual devices before realizing the south bridge */
     if (machine->audiodev) {
-- 
2.43.5


