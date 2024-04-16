Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E5C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcUs-0004SU-Sh; Tue, 16 Apr 2024 02:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcUr-0004RE-DZ; Tue, 16 Apr 2024 02:40:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcUp-0006jb-Pj; Tue, 16 Apr 2024 02:40:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G5xJKw027999; Tue, 16 Apr 2024 06:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zdYAlIjWiDzO+Pulqn/Pyu7g66SOTh6p+XyZYb4MTE4=;
 b=UxfFFV0gzcttubxfLNJDEalrPNfo49F30AAJol1ZTldL5czQKJ8844ZRxDU5lgHO9EsY
 X1xAcA/9vPxd8tzQlGqRdVVJ0hopBZKTySDyrTocrdjqSkQQ6o+EpcMHB++ZTH6VkqBV
 gFMphSK4LJQwVWsP4Y3SgdiOwFA28Q2HBAnd6S/uIJoj9Z4Ka40C+dz+PH16wy6sivZc
 dn2AfXKuUAhS5ez5gA1y2o1jhALP2YG4RoD//KC8c+OGrRt+HDd9lDmid3wauXDpHREt
 8Fl7qhN5duUjgfakKr+oSaJqn8BaWJSo7f+ZW+UPksvYehqqoer2lx+T+4Sm7EYsNaw4 MA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhkmr02jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43G6ehtO027013;
 Tue, 16 Apr 2024 06:40:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhkmr02js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G5KVYl023576; Tue, 16 Apr 2024 06:40:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnvgnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G6ecHE52298204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 06:40:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2622420043;
 Tue, 16 Apr 2024 06:40:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E67E920067;
 Tue, 16 Apr 2024 06:40:36 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 06:40:36 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 2/8] target/ppc: Make divw[u] handler method decodetree
 compatible.
Date: Tue, 16 Apr 2024 12:09:21 +0530
Message-Id: <20240416063927.99428-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240416063927.99428-1-rathc@linux.ibm.com>
References: <20240416063927.99428-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bZ3nVH-83Ngap1yRCWFvjH3gQDaINtMV
X-Proofpoint-ORIG-GUID: Mn0YLQAhUYGQHAZgok1vEOXlCaFOvBCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=811 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

The handler methods for divw[u] instructions internally use Rc(ctx->opcode),
for extraction of Rc field of instructions, which poses a problem if we move
the above said instructions to decodetree, as the ctx->opcode field is not
popluated in decodetree. Hence, making it decodetree compatible, so that the
mentioned insns can be safely move to decodetree specs.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c45547a770..be7d807e3c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1738,8 +1738,9 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 
-static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
-                                     TCGv arg2, int sign, int compute_ov)
+static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
+                                     TCGv arg1, TCGv arg2, bool sign,
+                                     bool compute_ov, bool compute_rc0)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     TCGv_i32 t1 = tcg_temp_new_i32();
@@ -1773,7 +1774,7 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret, TCGv arg1,
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
 
-    if (unlikely(Rc(ctx->opcode) != 0)) {
+    if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, ret);
     }
 }
@@ -1783,7 +1784,7 @@ static void glue(gen_, name)(DisasContext *ctx)                               \
 {                                                                             \
     gen_op_arith_divw(ctx, cpu_gpr[rD(ctx->opcode)],                          \
                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
-                     sign, compute_ov);                                       \
+                     sign, compute_ov, Rc(ctx->opcode));                      \
 }
 /* divwu  divwu.  divwuo  divwuo.   */
 GEN_INT_ARITH_DIVW(divwu, 0x0E, 0, 0);
-- 
2.39.3


