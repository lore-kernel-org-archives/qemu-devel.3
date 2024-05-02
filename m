Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB02C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Pun-0007qK-NM; Thu, 02 May 2024 02:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s2Pul-0007pm-CG; Thu, 02 May 2024 02:27:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s2Puj-0002aj-Ac; Thu, 02 May 2024 02:27:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4426RF0a007475; Thu, 2 May 2024 06:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=eP1Rnz19SPtW0UnhjgsT9bWgHO1j5H2BJwWu67RZm2o=;
 b=pmlSs80fXLcpo+Sg8++E7sxuerdvAIgz5lM3wUT3Ly3lqj6Xdoyd0M6d6xIKhaLVq8Dx
 GoQ+Rj9sSX5NYmkkrQWdYxT5XUEKmNXuTknjad0SK6zeQw4nzVyKufL+r/WjtpUulO2/
 5lj0Ej2jyRQzIhLGHQWOzmNdFU/Sbu7QiC39vyDTvhrEfOnShfa+LC5vHGUWrsrrsirp
 n+EL9siIqaTO7tWrLlIcCNZkNDJjswrhIeQzgEcf9gLtdlo5q2qGpvtDJ+k0xMiRGz0C
 m2MMphVxXt67HBRd2/ncALt/UKafvuo42nurqfV95jk4pDnMi3caoRBBeEXmTQpGqQD5 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xv5jtg00f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 May 2024 06:27:15 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4426REFQ007459;
 Thu, 2 May 2024 06:27:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xv5jtg00c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 May 2024 06:27:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44247aob003622; Thu, 2 May 2024 06:27:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscppph8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 May 2024 06:27:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4426R7ND49152508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 May 2024 06:27:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 107A520040;
 Thu,  2 May 2024 06:27:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F18DD20043;
 Thu,  2 May 2024 06:27:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.171.49.201]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 May 2024 06:27:03 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] ppc/pnv: Update Power10's cfam id to use Power10 DD2
Date: Thu,  2 May 2024 11:57:01 +0530
Message-ID: <20240502062701.1379833-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SEQJafuUzjk2wlm98G6W48eJt2s12u50
X-Proofpoint-GUID: 2AysfFp6R2JDHv9YYJlgRmEPNK-Xhgyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Power10 DD1.0 was dropped in:

    commit 8f054d9ee825 ("ppc: Drop support for POWER9 and POWER10 DD1 chips")

Use the newer Power10 DD2 chips cfam id.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c            | 2 +-
 tests/qtest/pnv-xscom.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec76..06a4e4d13948 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2090,7 +2090,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
     static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
 
-    k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
+    k->chip_cfam_id = 0x220da04980000000ull; /* P10 DD2.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
     k->chip_pir = pnv_chip_pir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 6f62941744a6..5aa1701ea768 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -56,7 +56,7 @@ static const PnvChip pnv_chips[] = {
         .chip_type  = PNV_CHIP_POWER10,
         .cpu_model  = "POWER10",
         .xscom_base = 0x000603fc00000000ull,
-        .cfam_id    = 0x120da04900008000ull,
+        .cfam_id    = 0x220da04980000000ull,
         .first_core = 0x0,
         .num_i2c    = 4,
     },
-- 
2.44.0


