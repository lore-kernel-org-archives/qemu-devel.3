Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E0CEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svduS-00026v-1u; Tue, 01 Oct 2024 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1svdre-0000bH-Cy; Tue, 01 Oct 2024 10:28:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1svdrX-00084Q-1D; Tue, 01 Oct 2024 10:28:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917KHtq021719;
 Tue, 1 Oct 2024 09:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 cJUceJShU3twjEKSjt6X9sFs2yS86zeJy2XpqKWhHP0=; b=V98SqZeGBkjvC5rV
 K1uwnSmcjjwFadnAS2QQOf27beK9AMQvP4TEDBbOlow81tJjCLVCFXkSk71XhLVs
 8+BWydJRRu8eVi6mXg45u74xD/0UrGk9hCf8wgxEwKAUGZmZctjCszKGAt3x3PJp
 SRjk+tvs0LFk7aQW+UAnYK11pSi+qGXo/3/StM0UNQKo2r2Iz254RXpCtgPH4SnZ
 0FQeDQJN44/Vb5aW1HFwL3GWt8a3UhiTJmWu5zecjC9Kh+uYUFpWj1TGhLE+FQJh
 O6LyvbnU+y4qxEMXHKHdarX1cYNpLYiH7zIOzvJ8BPgig/ktFAZNfsu/VMj2ueF2
 YBae2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckngmaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4919TWqv002214;
 Tue, 1 Oct 2024 09:29:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckngmad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4916F45x017836;
 Tue, 1 Oct 2024 09:29:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4muf95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4919TUHk55706074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 09:29:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2698220049;
 Tue,  1 Oct 2024 09:29:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37FFD20040;
 Tue,  1 Oct 2024 09:29:29 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 09:29:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v2 11/11] ppc/spapr: remove deprecated machine pseries-2.11
Date: Tue,  1 Oct 2024 14:59:10 +0530
Message-ID: <20241001092910.1030913-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001092910.1030913-1-harshpb@linux.ibm.com>
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: huPGvSQU__vOiXYh_lCYIvKYC_mWpXui
X-Proofpoint-ORIG-GUID: 9j3yvNRUHwAYYnQ7NAdLx3qJrgP415at
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=944
 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.11 specific code with this patch.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cb6bf219bf..04f06377b4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5157,21 +5157,6 @@ static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
 
-/*
- * pseries-2.11
- */
-
-static void spapr_machine_2_11_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_2_12_class_options(mc);
-    smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
-    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-}
-
-DEFINE_SPAPR_MACHINE(2, 11);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


