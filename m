Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4999CCAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3u-0003Ds-Fq; Sun, 28 Sep 2025 15:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3o-0003CD-4t
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3f-0004An-Co
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SAReCk002106;
 Sun, 28 Sep 2025 19:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4FQQfICHexy3Xs1Ec
 DEvC7A7h1vMSSJuH9TIGR1HYQE=; b=G1ArHBmyQdZmWx8XAGdB53ZjYluBEvQb5
 9cV2sfWzoQ3nhmgsMGPbNjBqlKGsHWJ/unvro6EaQ9nD//KRkKRV9OjTCg/vxrKb
 FvSCZH88NftfZIP/AaDAn6UxEvrmeNPI+cDs1O2D9vG5KvoeZCSZg/DtwPKzCE62
 t1mFWYukQquHaFA0pEbQeFI+9rLaOYSlhZ1De5H1gDWRPfATKsSwswwuO4hoRN31
 ANq1qEmt8mtIwGB7+pO28h4RYmcrlyaQpUCXRfUZOYvDGnt/BOQcjo/CdPkl740a
 iG+GVeLdrcmm0bSa1fMO+gkmdyrUKmJRrjMHNuirUFEqjLaIC/XzQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jw6ewk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SGtlVG020508;
 Sun, 28 Sep 2025 19:27:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru1er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJRIT140042964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6744020049;
 Sun, 28 Sep 2025 19:27:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61DB420040;
 Sun, 28 Sep 2025 19:27:17 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:17 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Denis Sergeev <zeff@altlinux.org>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 27/27] target/ppc: use MAKE_64BIT_MASK for mcrfs exception
 clear mask
Date: Mon, 29 Sep 2025 00:56:29 +0530
Message-ID: <20250928192629.139822-28-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX2M2cwtVqg4K1
 6UU2Lw2wS09Usw01MfWS7BovHem5Sn1wyw3enKJxAfnCoApIL7io0YGKM78eFlKY19HWQP6eMRZ
 0wDzyCEfFDWfk7MHno6UDamnQaSup8cxvvypOv8sR1vDqamo/gx44tCOhxcTNeMTppIfjXwWomw
 4I9S60UrtVgcPq6RNQ+KReCOXrYyJnPXBkBueyWcGLb0hF3GaiTIU/0BrORW7dQuhbBTg2HgS1L
 e/TZkLA+23jEnZ6by8U3Yy3d4+G1m9zufaD5/NVqlscVHmsJw105SXBQb0QN4WnJ2434NpKDonk
 OA/KmYf2TXnw/3RZlQrJK2hkqq+r5oF2Bo5gWwoZ+SW76LJVlJ5RGyezaYvwlI0kKHFhSDprmKI
 cbYRi/veOAUUEss6hMFDEp2G6iQSlA==
X-Proofpoint-ORIG-GUID: o8LchynQTjY-ThAygKLMi04clTo9H7Jj
X-Proofpoint-GUID: o8LchynQTjY-ThAygKLMi04clTo9H7Jj
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68d98c1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=bH78PYQqAAAA:8
 a=HH5vDtPzAAAA:8 a=VnNF1IyMAAAA:8 a=BguI0s01zjOQbXWBZ6YA:9
 a=TrXR8j8ql9YpJ1_1srv2:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Denis Sergeev <zeff@altlinux.org>

In gen_mcrfs() the FPSCR nibble mask is computed as:
      `~((0xF << shift) & FP_EX_CLEAR_BITS)`

Here, 0xF is of type int, so the left shift is performed in
32-bit signed arithmetic. For bfa=0 we get shift=28,
and (0xF << 28) = 0xF0000000, which is not representable as a 32-bit
signed int. Static analyzers flag this as a potential integer
overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Sergeev <zeff@altlinux.org>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250915080118.29898-1-zeff@altlinux.org
Message-ID: <20250915080118.29898-1-zeff@altlinux.org>
---
 target/ppc/translate/fp-impl.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 28dda15040..464fb1d90f 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -396,7 +396,7 @@ static void gen_mcrfs(DisasContext *ctx)
     tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
     /* Only the exception bits (including FX) should be cleared if read */
     tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr,
-                     ~((0xF << shift) & FP_EX_CLEAR_BITS));
+                     ~(MAKE_64BIT_MASK(shift, 4) & FP_EX_CLEAR_BITS));
     /* FEX and VX need to be updated, so don't set fpscr directly */
     tmask = tcg_constant_i32(1 << nibble);
     gen_helper_store_fpscr(tcg_env, tnew_fpscr, tmask);
-- 
2.43.5


