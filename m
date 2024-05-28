Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2125AC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqux-0007IQ-DQ; Tue, 28 May 2024 03:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBqun-0007AP-B1; Tue, 28 May 2024 03:06:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBquc-0004kG-8v; Tue, 28 May 2024 03:06:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6fiIs027939; Tue, 28 May 2024 07:05:30 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DFmY?=
 =?UTF-8?Q?1ucFdc4dSpXgtu0sK2/aASJ5FxS+98Ial1bXooSg=3D;_b=3Dj//lzLhBaOcM7M?=
 =?UTF-8?Q?T7XcqlqtCftQONZeh5c/qi19/+GP3Svbvj2Ce1YPIpQLy+z/I6JISo_vQRnaAEQ?=
 =?UTF-8?Q?kYc3NtpCLaQiF0UIJqDkg+xlEgX7q17s6FHgdb14J/29ugCzOMFVfjxn2xQ5_Q7?=
 =?UTF-8?Q?6uFPd2QtmFC2qkFohnkXKGWkGETNxTdeMFrf8n6Bg05V0e64MFlf/rWPCK8jWYD?=
 =?UTF-8?Q?LH2_beZodGV7zv+flxiJw5doVsv1a5LejNSl0uINALH6HdSPkj4nGZYE1SNighJ?=
 =?UTF-8?Q?fRfPRhMFd_mId7h0xZbeM9DLLpMToj2XNfN9jCmkfSXZ1/0ziPv8H3b4Q/H52xP?=
 =?UTF-8?Q?WCcJbsy2Re17qsa_vA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd9xp03r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S75Uh8032561;
 Tue, 28 May 2024 07:05:30 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd9xp03r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S40Mwc027099; Tue, 28 May 2024 07:05:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybvhkn3t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S75N5u50856290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 07:05:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1EC420043;
 Tue, 28 May 2024 07:05:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38A312004E;
 Tue, 28 May 2024 07:05:21 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 07:05:20 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v4 02/11] ppc/pseries: Add Power11 cpu type
Date: Tue, 28 May 2024 12:35:06 +0530
Message-ID: <20240528070515.117160-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528070515.117160-1-adityag@linux.ibm.com>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3pe1_vdTECwNBu7IGuwP4KJ9VC5NdRgl
X-Proofpoint-ORIG-GUID: cItpu8J9Yu4cjETV-KrtIB02T7dDGv7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxlogscore=722 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add sPAPR CPU Core definition for Power11

Cc: David Gibson <david@gibson.dropbear.id.au> (reviewer:sPAPR (pseries))
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com> (reviewer:sPAPR (pseries))
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/pseries.rst | 6 +++---
 hw/ppc/spapr_cpu_core.c     | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index a876d897b6e4..3277564b34c2 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -15,9 +15,9 @@ Supported devices
 =================
 
  * Multi processor support for many Power processors generations: POWER7,
-   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
-   but its state is unknown.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
+   POWER7+, POWER8, POWER8NVL, POWER9, Power10 and Power11. Support for POWER5+
+   exists, but its state is unknown.
+ * Interrupt Controller, XICS (POWER8) and XIVE (POWER9, Power10, Power11)
  * vPHB PCIe Host bridge.
  * vscsi and vnet devices, compatible with the same devices available on a
    PowerVM hypervisor with VIOS managing LPARs.
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e7c9edd033c8..62416b7e0a7e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -401,6 +401,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
+    DEFINE_SPAPR_CPU_CORE_TYPE("power11_v2.0"),
 #ifdef CONFIG_KVM
     DEFINE_SPAPR_CPU_CORE_TYPE("host"),
 #endif
-- 
2.45.1


