Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC64C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNPx-0007eH-Qp; Tue, 18 Aug 2026 13:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwNPv-0007cT-L1; Tue, 18 Aug 2026 13:16:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwNPu-0008Bp-4n; Tue, 18 Aug 2026 13:16:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3Zo3542373; Tue, 18 Aug 2026 17:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=V3LMoR
 IT9M8wFuxb1HPjHIlhwclcnZZPQqB5X7kX71g=; b=BwBmfxfPXm6CXNsk8Uunzg
 aTTTENTE7eTxDN4UYNPElhGefubB7T2ldbTld3X5Q/tJlHGmU8LgWH3TWjkB79cl
 AV+H+sElYGpCX0c3oc0sS61tPP5+c+r2i51wTOpnKMOM5BtTLPTogu0to6NY0ALr
 de5x11W9QRekW23Nlkp7N40Dxe2DmLGF1pZaAcp/XJvOSt6vELVLbRykTfMzYehL
 tinunEn3fU5lVEz92SttlE5Jnt78tEWC9Qcl2xaiBdRfyC23Ko4x6gainUJ8LT6R
 5RvksqumEvX87ZDsmSX9FPeAkI9cTl8F9UvdAeUU0GZ3FQp8F7sS//ReCnpCCfvw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt94u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:15:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDcP2008706;
 Tue, 18 Aug 2026 17:15:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq4k2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:15:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHFtV335586458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:15:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C6222004B;
 Tue, 18 Aug 2026 17:15:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC4C120040;
 Tue, 18 Aug 2026 17:15:51 +0000 (GMT)
Received: from shivang.com (unknown [9.124.212.164])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:15:51 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 hbathini@linux.ibm.com, mahesh@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, sourabhjain@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH v2 1/2] MAINTAINERS: add dedicated PowerPC RAS section
Date: Tue, 18 Aug 2026 22:45:32 +0530
Message-ID: <20260818171541.903431-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818171541.903431-1-shivangu@linux.ibm.com>
References: <20260818171541.903431-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a849350 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=dmkjvbsFamE0tA2L3EsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfXxnwrBeIeu3Zy
 WSkzPf+WpbLNPFMVXkdVVQaUHqYrkeSVPyEIVCMtpnCaDpxjwMs3+zfP9qcS6sRMQuXsm9YAhY6
 QLJcl+O/SnrxycBLW4CehSCECwmIMLE=
X-Proofpoint-GUID: fQcHTY7rKXHBI0ntNzE557UmG1il7MWJ
X-Proofpoint-ORIG-GUID: OA6t8xlJCXWKPd-WMG6V3cnBDDR2XIsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX8/Vygpov9N+/
 gx2eEVKaSyojHNbQVoY76SXK4JjKQyY5Asn4nM9mph/iT0zEktB8OfMKOce+8gKnVuwM9BHKPV0
 te+YyKnaI3WL0U4/EkFV9ba28RGDA8SUHpe3Lg3SD7IRaBf5S8V4+8ITLfskV9RI+EEsCD1XiFp
 L4RcIjB65jDpejScbDIhSGfoATRSLkBeLD1AwnLiAhHznXbP8HOH7a3UEtD3aGJIipUwhNniqgJ
 KcXuGjavczKhhb/1TkzrytJNwzSffCkr37IsU/05aAI/XdDTo8UGbl5uxH5Y9VJdvPyikvjPwOz
 1CCLuEl5Dd9jV10lVXWmJZSqjn54J1d8VvtXCzKK9AxXZkac1Pvl1lFok5SaYVM6aIIoMnBEQC6
 Y1/sZnZjE8GSTnJ4jHME/+6765NQ9MchccmoX0UTkXIZozMK7BQOEjPbIGZIYlkx3qUWGto9bg+
 HX/TjiRhXvAkgSc05/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
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

Additionally adding spapr_events.c, as it implements RTAS error logging
infrastructure and spapr_pci_vfio.c, since its all EEH related code.

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 MAINTAINERS | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..99e6585ca0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1762,6 +1762,20 @@ F: include/hw/ppc/vof*
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
+F: hw/ppc/pnv_mpipl.c
+F: include/hw/ppc/spapr_fadump.h
+F: include/hw/ppc/pnv_mpipl.h
+F: tests/functional/ppc64/test_fadump.py
+
 RISC-V Machines
 ---------------
 OpenTitan
@@ -3386,23 +3400,6 @@ F: scripts/coccinelle/remove_local_err.cocci
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


