Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B68C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFC3b-0008Du-Ph; Thu, 06 Jun 2024 08:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3Z-0008Bg-JL; Thu, 06 Jun 2024 08:17:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC3X-0006E1-Bk; Thu, 06 Jun 2024 08:17:25 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456CCceh025224; Thu, 6 Jun 2024 12:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=NPmQjrLsWxzOffCHQ+0itleFMufaX3SgxEgqWnGXnQI=;
 b=UzmMoKYvo5ENtofVckoxTcHJJwKQMBjCl4UMTUWdLVQV19fYRtCuGONNJn/dOZmT0tU3
 RuWjQjCYCyWUq9oCKVIFS/8CiJKti2SwaTjwAtM5jCPFCpSkSqzRIuBt47t1R9TMEGgf
 c0XcYYxiLaURiDJdOY3ZMMV3j/5akB7hqEkDr/ru5i55GIdnmkgvdNt3OiIJHKD+yP4i
 g/h2+xrpSqlmExMQ7bZv8jCviZTOH2hNJ+pARJI2H1LEyr9jLQrZs1AyqNtcGB53W8cC
 IQx+ywxvcDCTsm2MlhJzrUJdHx8FsEO/UGo7OSd8+7+X2CKicOu8LsPcUlFOZLMWAHUF jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcwj00e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456CHF3Z001185;
 Thu, 6 Jun 2024 12:17:15 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcwj00dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 456C0hvr000781; Thu, 6 Jun 2024 12:17:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyuapyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:17:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456CH8uS29229620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 12:17:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3591B20043;
 Thu,  6 Jun 2024 12:17:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB5FF20040;
 Thu,  6 Jun 2024 12:17:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2024 12:17:05 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v5 3/5] ppc/pseries: Add Power11 cpu type
Date: Thu,  6 Jun 2024 17:46:55 +0530
Message-ID: <20240606121657.254308-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606121657.254308-1-adityag@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JUMbZq8y6szL_FCYZnKmTlst3FdsqitY
X-Proofpoint-ORIG-GUID: AKzAYABMQYUOAhSY43omVkp_HNhCvfAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=933 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406060090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/pseries.rst | 17 +++++++++++++----
 hw/ppc/spapr_cpu_core.c     |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index a876d897b6e4..bbc51aa7fcdb 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -14,10 +14,19 @@ virtualization capabilities.
 Supported devices
 =================
 
- * Multi processor support for many Power processors generations: POWER7,
-   POWER7+, POWER8, POWER8NVL, POWER9, and Power10. Support for POWER5+ exists,
-   but its state is unknown.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9 and Power10)
+ * Multi processor support for many Power processors generations:
+   - POWER7, POWER7+
+   - POWER8, POWER8NVL
+   - POWER9
+   - Power10
+   - Power11
+   - Support for POWER5+ also exists, works with correct kernel/userspace
+ * Interrupt Controller
+    - XICS (POWER8)
+    - XIVE (Supported by below:)
+        - POWER9
+        - Power10
+        - Power11
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


