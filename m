Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7283CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7F-0003Lv-2c; Wed, 07 Oct 2026 04:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEI1w-0000ek-1u; Tue, 06 Oct 2026 23:09:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEI1e-00083p-Cl; Tue, 06 Oct 2026 23:09:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5wMm2199241; Tue, 6 Oct 2026 10:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KT8QaaY6Zbu1E/+XH
 ssMcD7uiihy4OiUH6NJqGgSmCo=; b=lOmo2fID8B2PgkYamjFaiuatfy63AqIj7
 JriIcYb/g5+gbJSUuS2jEH9VcpVLLND2kJeCYkp/7ijQ8BLBF0V3G2hL56rEQsVG
 ochTWJrN9+IWKwgDDoMkEC2s6M5dMCyOjvfnAzgC3VDsE68IYPORkSh4Vvlv+7ud
 icRpzSOEgTssX7SWClP19Epgic9S7uPHA0YtnxvvWtWPv1PFPv89jyoYo4HJzecb
 lbC6MOoA6G2hNqh4iqMuOWXrgQKQT7dXgQn1OvBE84apiYE7+iBIa2mBO73ZzQ9D
 DeH36gWTq4zWZyDBHkIGQ+eSlgab5qbWOC6+2dPv1jLM5gecmRdig==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fxrv3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6Ig1108866; Tue, 6 Oct 2026 10:57:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jsjcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvP8W40763650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45D4B2004D;
 Tue,  6 Oct 2026 10:57:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EAEA20043;
 Tue,  6 Oct 2026 10:57:23 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:22 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 7/8] target/ppc: Add function to point to dmr regs in
 tcg_env
Date: Tue,  6 Oct 2026 16:26:18 +0530
Message-ID: <20261006105650.189752-8-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4d41a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=nXpfQtbvGn4pk-hajn4A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXw63F10gSt6Xd
 uh1czqB4o2HPCINb4c9US4z05IE8L/yy3LoXoCVRu913AQVYVqltHLQsLfYjw64E28ns+7MGXny
 8G9noSTFE86kSQ+h1vHEIyDau2gChSx7fzLUXikvLLFkER6Ni/0OWlAMCS8MoF1hqH3kwEwnt9h
 LWTDJJUOIJylaVNVZ6b07AYNCepn+H24qiuKJKYEoJ/IjhlbiJQb6A0a2m3s46mBmTzffC7NCMD
 I+y0VndOKdeVR3TvyuEc0ci3uyO+7UXqjtlzM7i+KjjPpUeuyvKMeTqhK5uGRIYw6AjG5SVysUb
 2zEjGtR7ttcnfPb6xQxAzL2Fa6XAKvdgcXTnXdbK2nGZS65SP1z2Aqfp6/BC6Ffp/9LjFmlrFjN
 xkSF3SYVbaFEgG1+6RvDQ8Dy6oTkroPzk5YOFgncNZF9T1f9HOUf/2hn9irtdulNZAMld4ttivI
 dWl2aaoPQnTwIcUg6zw==
X-Proofpoint-GUID: QxzUvu5mRqeroOir32y_Qty5UXmg7csk
X-Proofpoint-ORIG-GUID: KYBzqndGBf6yJgBVCaDyjFuUd_pBhKyX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXyUeeUBF1AwIv
 wB9S27PmzIkG3DD0gHFHddm16GP2QP9xk6xQ48gkytaugMjf8vIWC7WKU5Kh1lGXU4hOC1Nh8EM
 PRatrlGvjzislBlg9OcxI6iQjQNiUOw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

To access registers within tcg_env, in a helper function, a pointer to
the required register is traditionally passed to the helper function.
Adding one such function for future usage.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate/dmf-impl.c.inc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/translate/dmf-impl.c.inc b/target/ppc/translate/dmf-impl.c.inc
index 45aabe2a4d..5bc70663f8 100644
--- a/target/ppc/translate/dmf-impl.c.inc
+++ b/target/ppc/translate/dmf-impl.c.inc
@@ -10,6 +10,13 @@ static inline void get_dmr_row(TCGv_i128 dst, int reg, int row)
     tcg_gen_ld_i128(dst, tcg_env, dmr_row_offset(reg, row));
 }
 
+static inline TCGv_ptr gen_dmr_ptr(int reg)
+{
+    TCGv_ptr r = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(r, tcg_env, offsetof(CPUPPCState, dmr[reg]));
+    return r;
+}
+
 static bool trans_DMSETDMRZ(DisasContext *ctx, arg_DMSETDMRZ *a)
 {
     TCGv_i128 zero;
-- 
2.55.0


