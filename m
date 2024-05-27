Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672C8C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUVp-0003jg-0j; Mon, 27 May 2024 03:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVn-0003hO-Hk; Mon, 27 May 2024 03:11:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVl-0003RT-NI; Mon, 27 May 2024 03:11:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R77cnv008956; Mon, 27 May 2024 07:11:01 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3DFmY?=
 =?UTF-8?Q?1ucFdc4dSpXgtu0sK2/aASJ5FxS+98Ial1bXooSg=3D;_b=3DWPcTfS/JdtDJqK?=
 =?UTF-8?Q?6nYW70eboTjuhrAobVSw7s9OPdZdrMoIh5z7XnF6Qfzlupka4k0NUD_tV/N6j84?=
 =?UTF-8?Q?NNua5QCeuLsSOus0VrGi/FZ2cFo6RRwEnKV7cwYNOx6EEPR6OjnyYVlZd8kJ_na?=
 =?UTF-8?Q?yG+1rhsfEI/zpGhdzlT79FLbjjD+yPaS7zooUFK/OUPKnW55ca8UpLc54qGpQkj?=
 =?UTF-8?Q?mOX_JH+5+5iUqV2hJQGJmV/ujlHDW/6/QKu1WYncuo/4wJfUWtLd5i8nPnCw5aI?=
 =?UTF-8?Q?EXn3CAp72_JIJksEMEPKrjGFLq9KcpPzY7aMKLnlXb6xYOa8vUIGkx/TBCWN50m?=
 =?UTF-8?Q?totu9e0QKGjb6fr_xw=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycngng0an-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:11:00 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44R7B0mQ013995;
 Mon, 27 May 2024 07:11:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycngng0ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:10:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R4t5oQ004501; Mon, 27 May 2024 07:10:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybuanqhdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:10:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44R7AqEl19530038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 07:10:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6AF420040;
 Mon, 27 May 2024 07:10:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E360720043;
 Mon, 27 May 2024 07:10:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.179.2.64]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2024 07:10:49 +0000 (GMT)
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
Subject: [PATCH v3 02/11] ppc/pseries: Add Power11 cpu type
Date: Mon, 27 May 2024 12:40:33 +0530
Message-ID: <20240527071042.489540-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527071042.489540-1-adityag@linux.ibm.com>
References: <20240527071042.489540-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R3tBAOtRWtK-HNfNLbTUs-2f1Sn4tmgo
X-Proofpoint-GUID: zpFc5fNTfZMthXZd2prOHq9ucJMmd51t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 mlxlogscore=730 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405270057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


