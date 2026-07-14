Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836BEC4450B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjjnx-0006od-MG; Tue, 14 Jul 2026 16:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjjnu-0006nj-Op; Tue, 14 Jul 2026 16:32:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjjns-00056I-S3; Tue, 14 Jul 2026 16:32:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EJD5QE2201312; Tue, 14 Jul 2026 20:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PIhWPAGd/4kRvC0Ya
 bg/I0hIqPAyYNm6UkeijqnjLOs=; b=BCSDj2EIXBzB8YrIoyDrrmYJLGsZDnvKU
 yq4/vBmUUyFM2Xj4wrJFfgPjlbxFzJKOQpiELr7QhZNKUkE7vv3CVVobZwCCY0ve
 D3CgkRDhZymzUCaJ9b2Eh3rlpf79gKq+ZAs5r3HxsOLRmkTidVgq+djVuiwf74aG
 C6gmpYzn8R5Eb5w21sr8jcBSDviSPvbLSu7NuWAwdSN9DST5c7bZ9ABJx4kMt2aH
 yOvGQjTXglSWyvEYPto4qtM9G2KqSzZ/5QBMmKtRg01QyAwjf4RdikHWdLGrQmJA
 bY5ru8lLX9f40k7VuWvuVuc0wugWwiP90r+vgBS2YD4ZASpDw2x8Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxg72p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 20:32:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EKJejF031912;
 Tue, 14 Jul 2026 20:32:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw4rbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 20:32:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EKWFCj31523530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 20:32:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 200022006A;
 Tue, 14 Jul 2026 20:32:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05C6220078;
 Tue, 14 Jul 2026 20:32:11 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 20:32:10 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ido Plat <Ido.Plat1@ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] target/s390x/tcg: Set STCK/STCKF condition code after
 the store
Date: Tue, 14 Jul 2026 22:29:54 +0200
Message-ID: <20260714203206.363028-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714203206.363028-1-iii@linux.ibm.com>
References: <20260714203206.363028-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BTRM4zQZLYDKodrYbu_SRbHz3UhUPzIU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwOCBTYWx0ZWRfX3AvzCteRhN3O
 TyvROD4V4Fc1xBW5Yh+FklFbzed6L6OKPfYyWYpacLvHhgVXQZvMexrtsbrkXUtRWxf+UFDEUkl
 4uSgsNu991aElcC6Pqs40r+mF1GtTz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwOCBTYWx0ZWRfX4gndkJf8y7M1
 y6TiXMVwJ/29bNTHoKclcUk+MbKxLqGE2zFHqWNJEC7Iak72S2ygT/yrFzdRLugviBgwjM0yZuM
 WoBduk/P0V2d4cdZ0qYhd6OrORJO0ymMbUeYz0/CXH3rHlCusSaZR9p2eOxiY3YcR7AWWCzd3cA
 DeCMwAyg7gpnFG4GobYXJeK2SxiYr6BGSdnEQ1kj3SOoPaxclyrlx7TbcFQIzOfi0vMSEs4b8Jm
 n0NWvf3KncVUNWrP8iuPaSCX3NrYvP68+YL5eku3SN6aWOUWJLbkuUsYLDfgIYFOD1Z+3eRnkvm
 obxFU8shUGktFEkING1vqdb4Qlx2b1VtuSeoRTqFCCuAWGEyrV5007FvgmGuroRK+HaMkHH3b+B
 GOJM04Fk7Iu3Pw+74ekySxPC290X0QEv/WpKsez9HJxIHIbbp3YZiMEOzXPao04XSO67uCAFiyU
 yTy9Z8Y49XQSvZMvgMA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a569cdc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=xh9t286rN22ytdcU0UYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: BTRM4zQZLYDKodrYbu_SRbHz3UhUPzIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140208
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
---
 target/s390x/tcg/insn-data.h.inc | 4 ++--
 target/s390x/tcg/translate.c     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0d5392eac54..1ea72248a6a 100644
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
index 82165ac1ec0..1b6023168bb 100644
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


