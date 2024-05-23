Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CC8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA54F-0001vs-QH; Thu, 23 May 2024 05:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA54E-0001vK-Eo; Thu, 23 May 2024 05:48:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA54B-0001U6-QH; Thu, 23 May 2024 05:48:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N9Eudh001877; Thu, 23 May 2024 09:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eQVqRXZgJVcKhKPlhr/pWRtuHrXO3gFWwVNiyBSXKIc=;
 b=GaZCgySd938EWeKQwdUYEAkBIjl0t984+LfiHlG14S8CIc2qFfiLS4DxWEq9xmKPdeYh
 hyNCJ3CCXsjl2BhpsbCUYimgOXAiZffGwZ2Nni3mdcSQJWspYQ3GVfZ0CvIKITcH9NaV
 tdeSwWwloHa3MkWh0TeqkvgRLX9yob9acOnY5rEtOoZ3uCjNjnojpLax8OuHzb8IRHD/
 QrDu87sp8mhSnHQeudoDycIDqeZasrktSUQS4Z7xoWRp0uM99XV7zrtlvSgD37F3fr1Q
 w37NPAGKaXC08vFv0pRcGtD6gKDH00FCE/PdLsEK/IeOBvqQe21EpgjKeXOSOUg9FML8 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya2tsr3tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:53 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N9mrL9024316;
 Thu, 23 May 2024 09:48:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya2tsr3t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N9Fj2q007412; Thu, 23 May 2024 09:48:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c38v86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N9mmcu33423788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 09:48:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9E2420040;
 Thu, 23 May 2024 09:48:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7AEE20043;
 Thu, 23 May 2024 09:48:47 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 09:48:47 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 1/3] target/ppc: Move ISA300 flag check out of do_helper_XX3.
Date: Thu, 23 May 2024 15:18:19 +0530
Message-Id: <20240523094821.124014-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523094821.124014-1-rathc@linux.ibm.com>
References: <20240523094821.124014-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AFHJqmMp6dFopJhAHifo7zdOFq3eKIzk
X-Proofpoint-ORIG-GUID: 7sx5DwFY3XHe1UYDyZldOHQfPYY-1jO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=855 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Moving PPC2_ISA300 flag check out of do_helper_XX3 method in vmx-impl.c.inc
so that the helper can be used with other instructions as well.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate/vsx-impl.c.inc | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0266f09119..6025119e5b 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2712,8 +2712,6 @@ static bool do_helper_XX3(DisasContext *ctx, arg_XX3 *a,
     void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
 {
     TCGv_ptr xt, xa, xb;
-
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_VSX(ctx);
 
     xt = gen_vsr_ptr(a->xt);
@@ -2724,13 +2722,13 @@ static bool do_helper_XX3(DisasContext *ctx, arg_XX3 *a,
     return true;
 }
 
-TRANS(XSCMPEQDP, do_helper_XX3, gen_helper_XSCMPEQDP)
-TRANS(XSCMPGEDP, do_helper_XX3, gen_helper_XSCMPGEDP)
-TRANS(XSCMPGTDP, do_helper_XX3, gen_helper_XSCMPGTDP)
-TRANS(XSMAXCDP, do_helper_XX3, gen_helper_XSMAXCDP)
-TRANS(XSMINCDP, do_helper_XX3, gen_helper_XSMINCDP)
-TRANS(XSMAXJDP, do_helper_XX3, gen_helper_XSMAXJDP)
-TRANS(XSMINJDP, do_helper_XX3, gen_helper_XSMINJDP)
+TRANS_FLAGS2(ISA300, XSCMPEQDP, do_helper_XX3, gen_helper_XSCMPEQDP)
+TRANS_FLAGS2(ISA300, XSCMPGEDP, do_helper_XX3, gen_helper_XSCMPGEDP)
+TRANS_FLAGS2(ISA300, XSCMPGTDP, do_helper_XX3, gen_helper_XSCMPGTDP)
+TRANS_FLAGS2(ISA300, XSMAXCDP, do_helper_XX3, gen_helper_XSMAXCDP)
+TRANS_FLAGS2(ISA300, XSMINCDP, do_helper_XX3, gen_helper_XSMINCDP)
+TRANS_FLAGS2(ISA300, XSMAXJDP, do_helper_XX3, gen_helper_XSMAXJDP)
+TRANS_FLAGS2(ISA300, XSMINJDP, do_helper_XX3, gen_helper_XSMINJDP)
 
 static bool do_helper_X(arg_X *a,
     void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr))
-- 
2.39.3


