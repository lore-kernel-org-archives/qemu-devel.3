Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73B7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMT-0007pP-1h; Thu, 30 Oct 2025 04:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOML-0007nP-JM
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOMC-0007Nw-8p
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TN4aN5008824;
 Thu, 30 Oct 2025 08:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=G1zwFS/RyUpHX52Z7
 +M+yMw+rXDzyCxeXRjA83aunOY=; b=ASO8WlQad8M3VFs8LY4UhXhPzTTAmkuLn
 sgF4aD7KxKQ05QZ7dzeU7iMgEtGFnF+9jRnddrsZcQiXhluTruRYfUEHXuL+VUKc
 H11TUBNryOahXDqAaHzmAoTDs+lqvq4VQRjnjBWOH7SeFkQiXDnCZTXfcesm+Qwr
 /UdF8YHX/gt88dqoiY+2cy9OkyexxRbh8wdIZIFI2vDS01moabA/Y50SLIv4eylE
 dAt8DGSjayuYlo5kO9zP37TJxB7f40CUnc9E1FypAAnke84rHQDH+t2yUplnyZ8n
 wZIJt4/NF4wOs7LogWMCS6u3CdaUkEwADbW2Hp5lneDWZXE2s3/0w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34affe8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:50:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5rqcq030750;
 Thu, 30 Oct 2025 08:49:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwqr9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8nvR352298066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81AAB20043;
 Thu, 30 Oct 2025 08:49:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D431820040;
 Thu, 30 Oct 2025 08:49:56 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:56 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 08/10] hw/ppc/pegasos2: Add /chosen/stdin node with VOF
Date: Thu, 30 Oct 2025 14:19:34 +0530
Message-ID: <20251030084936.1132417-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MJMy8rkL4Pn0QEUYuN15Ay0YFlTL7Yku
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=690326b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=JCJieAoTSOM0q0owOEEA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX1dkQ72RpOvBo
 s9E9sqxK3pMUeqUGTdQQCWQU6ylLSZ/pjVEcYZa+DUcrbZ5w44Tqmb8ClNcw/nsrkqaZ+8kivqo
 1ZtBxxF+KGBOa/y0XnCPDKBmjcAH4nDza23RYthrGjj6Nx9YOqNKV9ajQ7kZwvWu/i4pjAQURlZ
 tsRuTdOamk7J0HGvChQrFB7YiVoL2toevNQqURMDzoCP4cJLhgkGQgXgTUjwIsnoqqdU5KGOreu
 qy+QprNcYsOI3Kc88Coy69WHcnYZFkmIBXVK69g3FMDg6XIThMxvIGiOaxWV99VBNdBZb5RFdte
 qvrzhS1TZwZCzRpNlKV14u5B4FC7Nv75/pXElwKZUtrgcuKmJR0wjPbtycEGt75OMrCTwUvHUQq
 dBJ2A8NIPv5ikuYi95RyqS5sbfz5fg==
X-Proofpoint-ORIG-GUID: MJMy8rkL4Pn0QEUYuN15Ay0YFlTL7Yku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
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

Some very old Linux kernels fail to start if /chosen/stdin is not
found so add it to the device tree when using VOF.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/642ef77674d08ba466e7a2beb4858ab1e67776ae.1761346145.git.balaton@eik.bme.hu
Message-ID: <642ef77674d08ba466e7a2beb4858ab1e67776ae.1761346145.git.balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 3c02c53c3a..3a498edd16 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -561,6 +561,7 @@ static void pegasos_machine_reset(MachineState *machine, ResetType type)
     qemu_fdt_setprop(fdt, "/chosen", "qemu,boot-kernel", d, sizeof(d));
 
     vof_build_dt(fdt, pm->vof);
+    vof_client_open_store(fdt, pm->vof, "/chosen", "stdin", "/failsafe");
     vof_client_open_store(fdt, pm->vof, "/chosen", "stdout", "/failsafe");
 
     /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
-- 
2.43.5


