Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3393FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCaz-0000fU-4k; Wed, 12 Aug 2026 13:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZz-0000CG-QB; Wed, 12 Aug 2026 13:17:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZw-0000sM-F2; Wed, 12 Aug 2026 13:17:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1aFo4088182; Wed, 12 Aug 2026 17:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iF6+DE2D89tXUFrXy
 8RPVc2//VeLdgIExeDcvlgSGIQ=; b=fx6s8veCnmackN4trZ/NA+hosotFjzF0a
 g7UCizkJtl4INcAv+eNrcSp3rxLLu7H4D1j3QgDa8SGII8WO3cowMKPrtUa2OHMd
 8CbAFBNKzxwqG9y1Hx9Xwjg2xWaF5x3aIF01dOVfL0f9PWV1XWP9gMWOiqL6dOVu
 HnZ4LEh0UiFB9bFCF/nGu9awSYk+ePODdSap5fzXgfor31Lh5cmoxA3+Docjs1KB
 4mrDZPLcQSJys/c8tMRSvvwK/3xXtXSBJ4KH1idQJDYehaI1SNPjGTiVhVdVpEyf
 Flfx7wI6kSrmR9VFgEUYcY9Fgbp7Kj3Dp8SzkIMCZNk/fGRW1CRMA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9us38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBGXD026637;
 Wed, 12 Aug 2026 17:17:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gf0dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHIHM30474864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C822E58051;
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22CB05805C;
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ido Plat <Ido.Plat1@ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 11/15] target/s390x/tcg: Set STCK/STCKF condition code after
 the store
Date: Wed, 12 Aug 2026 13:17:03 -0400
Message-ID: <20260812171707.1605637-12-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX5usiNBpm/m/X
 9Z5e2wMjmtmgWJCFB8HBMjS6GXXatbYmKIULX3PGlx1onFHFHSoX6OS8x9b+Dr5ummF4W99nFhV
 pj9IZNfeWYk/dnpcCsv10nfVtYf4cgG0AZ7LNiiv7RJb2iKM2vzECg0k7LAlRwDF0CiY1clTfjE
 8uc19n4qBBYddGzExi8wXDFOGdxexwiCtGVZmyn0sYjk1WseVYtEmhUlZG9Q1sV2PPG24dNiIj3
 Cms3O3UICARqAP/doC9eIqoxY1SHiQ89FnncXrce+XueoIC3Nhyryk2vVs9l5h5AxuC4rXEELz1
 2/aGUQOi5mtb6cfdMFnwWR0iEDIZH3p51cojvZcqThvMXFYmiHWNkwohs1XymlP4EyE3ks8LOCn
 gfQ8wTHgrXR3zHUMChFMLK6BCK/OBUCqo69xxFbzZ3w7DRw0SaZYJVrQkEJkYfqZnxTIy/1UNCP
 ozctass78UFNu4tjrfQ==
X-Proofpoint-ORIG-GUID: DY1HtQOU9w6MYbG84BiRE2T1TVnNFkdr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXzI2fEU+qMBm0
 76/9J3PKC8Ckh4RNPX3F2fTQt+U0bTfFEn7JToxN9VYcmqDOpHIPYuk6nuMgJQoOvTXJSNfpiA8
 aVNjDPMvrkPLkaDnKfMNaKhE3OB1+eU=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7caaa2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=xh9t286rN22ytdcU0UYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: DY1HtQOU9w6MYbG84BiRE2T1TVnNFkdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

STORE CLOCK [FAST] to an inaccessible address aborts QEMU:

  $ qemu-s390x ./stckf
  ERROR:cc_helper.c:128:cc_calc_addu: assertion failed: (carry_out <= 1)

op_stck() sets the condition code with gen_op_movi_cc() before the
output operand store, which is deferred to wout_m1_64(). Assigning a
constant condition code discards the lazy CC values, so the optimizer
drops the writes that produced them. When the store then raises an
exception, the instruction is suppressed and
s390x_restore_state_to_opc() reinstates the cc_op recorded at the start
of STCK[F], but cc_src/cc_dst now hold stale values, so the next
condition code evaluation reads garbage.

Fix by performing the store manually. The alternative of not discarding
in gen_op_movi_cc() keeps the inputs live, but results in less optimal
code.

Reported-by: Ido Plat <Ido.Plat1@ibm.com>
Fixes: 434c91a5f4ed ("target-s390: Convert STCK")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260714203206.363028-2-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/tcg/insn-data.h.inc | 4 ++--
 target/s390x/tcg/translate.c     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0d5392eac5..1ea72248a6 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -887,8 +887,8 @@
     C(0xe32f, STRVG,   RXY_a, Z,   la2, r1_o, new, m1_64, rev64, 0)
 
 /* STORE CLOCK */
-    F(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0, IF_IO)
-    F(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0, IF_IO)
+    F(0xb205, STCK,    S,     Z,   la2, 0, new, 0, stck, 0, IF_IO)
+    F(0xb27c, STCKF,   S,     SCF, la2, 0, new, 0, stck, 0, IF_IO)
 /* STORE CLOCK EXTENDED */
     F(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0, IF_IO)
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 82165ac1ec..1b6023168b 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4108,7 +4108,9 @@ static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
 static DisasJumpType op_stck(DisasContext *s, DisasOps *o)
 {
     gen_helper_stck(o->out, tcg_env);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUQ);
     /* ??? We don't implement clock states.  */
+    /* Set the CC after the store; a suppressed store must preserve it. */
     gen_op_movi_cc(s, 0);
     return DISAS_NEXT;
 }
-- 
2.55.0


