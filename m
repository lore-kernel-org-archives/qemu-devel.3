Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7D5C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwm79-0004Aq-HZ; Wed, 19 Aug 2026 15:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwm75-00046e-T4; Wed, 19 Aug 2026 15:38:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwm72-0007Gu-RM; Wed, 19 Aug 2026 15:38:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JI1fMj048173; Wed, 19 Aug 2026 19:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4K3ATQ
 Rb43urYsQZTizce4+AYh+ajHYt5M67BY5Sj/c=; b=cNK1dEn4V7iaHFjbIoYLJK
 Il5hSQe0ZenJGk8SRRhu1OzGucvHsRM3hwAOCErn01pAfJuraOoMR61k6Lvc2TlI
 7S+Eb6cyE9RaO/KWO1RQ1opi6Hf1JtE0niZrVn39KqlHdp/aQo+Hg80x0g/tklkW
 jcIn0MoGDx3H8INfyVplx3sqX0GEm+oQGqdv3wIIAQHgy38qWQhtgFxelHFs6nRM
 TFGBox4+YhTw9WHxFsqkjxIVO8dcNWQmokPHQZPumK+rlsZfUt+GbLH/2rRdK9AC
 tzqeKcZQQXExB6rJCtw8sWKBhVWhazgFQBOo1g0FrEIJytB4z2GbR4sCaSyNnO3Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu45q4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 19:38:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JJQLk4004033;
 Wed, 19 Aug 2026 19:38:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twaq7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 19:38:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JJc63B39846310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 19:38:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED08420043;
 Wed, 19 Aug 2026 19:38:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38B2820040;
 Wed, 19 Aug 2026 19:38:03 +0000 (GMT)
Received: from shivang.com (unknown [9.39.17.34])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 19:38:02 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 hbathini@linux.ibm.com, mahesh@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, sourabhjain@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH v3 1/2] MAINTAINERS: add dedicated PowerPC RAS section
Date: Thu, 20 Aug 2026 01:07:54 +0530
Message-ID: <20260819193757.1072909-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819193757.1072909-1-shivangu@linux.ibm.com>
References: <20260819193757.1072909-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a860623 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=s2Fq2CiAU11NuBAKINYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: CTohgbzqd4qnto_BnFZaRXSPCxJ3h2aW
X-Proofpoint-GUID: ohO42BZKCWcDe2QCS2BNWyK0gK-Jl92E
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfX8RjpTrXIZXid
 z2smwbtosFYiFE5mLwqnmG108xc/fVrdfXwpbZ3jn1rsxJBI+8qMewZXmnAkz/eX3uqwIZKqqqM
 wUhlG2xENd9u7swgHttosy9Layt9zao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfX7n0BSHiQjGvb
 VpCaD/qFqwZX4jHeGWigRUXXaTPo+hL/0mUO3cDbImAlPOtgKjw/LSVwEIajgfJxjBwqulUQaPr
 5EZhVxuaJNtofX/Taeg6co2lam4+D+Pjvdao9MYsCFsmbgQc0VajuLIpeEaJ/caXYy93PqUj6SV
 J40UvjO+imNZ0MGGaB2DiZsnBjTW3ApABr3NzGw0fdA2buJq/wbYe3QkLJR4E/xeEeDU1nHmgvL
 T7vlkCSMiG4UTTYCi9hNHGGzUpsAewQqSExRFtMHG2l/mjqKu6yfXlNhQE/zVY4VaIvuTxWbtrd
 ckzwS9Ynt8qAXZPE4NcDEBcBIIYbOe90hVlbKEXogcelt/QRCVUllT2KArH8cc4T7+MicPT7W8n
 H6EAhR+QhLPmN6iH5ZrwZQeN3psJ2jMZD7m+fMrLlgOglFItW/A/B3EkeHlpLSkL75iSXIgmu1I
 k47HjjYjrcHpSeYekjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190151
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Introduce a new "PowerPC RAS (Reliability, Availability and
Serviceability)" entry in the PowerPC Machines block, replacing the
existing Fadump/MPIPL sections. Retaining the maintainer and
reviewer entries from Fadump/MPIPL sections for this broader umbrella.

Currently most of RAS related code sits in spapr_rtas.c, So Adding
it to PowerPC RAS section. Additionally adding spapr_events.c, as it
implements RTAS error logging infrastructure and spapr_pci_vfio.c, since
its all EEH related code.

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 MAINTAINERS | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..a2a80c789c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1762,6 +1762,21 @@ F: include/hw/ppc/vof*
 F: pc-bios/vof/*
 F: pc-bios/vof*
 
+PowerPC RAS (Reliability, Availability and Serviceability)
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Sourabh Jain <sourabhjain@linux.ibm.com>
+R: Hari Bathini <hbathini@linux.ibm.com>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ppc/spapr_events.c
+F: hw/ppc/spapr_fadump.c
+F: hw/ppc/spapr_pci_vfio.c
+F: hw/ppc/spapr_rtas.c
+F: hw/ppc/pnv_mpipl.c
+F: include/hw/ppc/spapr_fadump.h
+F: include/hw/ppc/pnv_mpipl.h
+F: tests/functional/ppc64/test_fadump.py
+
 RISC-V Machines
 ---------------
 OpenTitan
@@ -3386,23 +3401,6 @@ F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 F: scripts/coccinelle/errp-guard.cocci
 
-Firmware Assisted Dump (fadump) for sPAPR (pseries)
-M: Aditya Gupta <adityag@linux.ibm.com>
-R: Sourabh Jain <sourabhjain@linux.ibm.com>
-S: Maintained
-F: include/hw/ppc/spapr_fadump.h
-F: hw/ppc/spapr_fadump.c
-F: tests/functional/ppc64/test_fadump.py
-
-Memory-Preserving Initial Program Load (MPIPL) for PowerNV
-M: Aditya Gupta <adityag@linux.ibm.com>
-R: Hari Bathini <hbathini@linux.ibm.com>
-R: Sourabh <sourabhjain@linux.ibm.com>
-S: Maintained
-F: include/hw/ppc/pnv_mpipl.h
-F: hw/ppc/pnv_mpipl.c
-F: tests/functional/ppc64/test_fadump.py
-
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
-- 
2.54.0


