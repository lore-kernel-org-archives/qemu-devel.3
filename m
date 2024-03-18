Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0EBC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJa6-0008Pj-RF; Mon, 18 Mar 2024 16:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rmJa4-0008PI-RZ; Mon, 18 Mar 2024 16:27:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rmJa1-0001sr-Sv; Mon, 18 Mar 2024 16:27:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IK5uP0019451; Mon, 18 Mar 2024 20:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6He4HjzjnfBMCl7gVtLvqU5B0mB7QhuK+qGMlO1WXgU=;
 b=JinaQe59sUjFkuycOUji5yVbBuWPy+PzXJoW81u9qzomZ8zjrNi/pbyLtk0xDR9SO02O
 IiXMC1c7wXwpjJEggdBdRoSEaNEzq2NEfyzjpl0k5LixfiRFavua2BxgCz8UQGuVZ8ZM
 LUW9nvmw27cLnLiY4WipI7Kpdfm4UVNus1BFqka4OBWfR/sU5YmFaK/Q/bL9LUy972ts
 9KOYl19uu7Z5POPw7xU5yZPUibY6H21ynQtVoSsZ8x88zDpMfMQORgBbWyNYjNamnF5O
 nuHvDYZLuCfFWvacv6+isQomxnxSQO9a6H7YBZxnjVVLT3ZzXV8+PRvjzIW+FwYnGQ1I PA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxumv8atd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 20:27:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42IKPgR4027988;
 Mon, 18 Mar 2024 20:27:29 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxumv8at9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 20:27:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IJupOK002773; Mon, 18 Mar 2024 20:27:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2amrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 20:27:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42IKROd349676780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 20:27:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F5C22004B;
 Mon, 18 Mar 2024 20:27:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1118220040;
 Mon, 18 Mar 2024 20:27:24 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.85.188])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Mar 2024 20:27:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Ido Plat <ido.plat@ibm.com>, 
 qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/2] target/s390x: Use mutable temporary value for op_ts
Date: Mon, 18 Mar 2024 21:27:10 +0100
Message-ID: <20240318202722.20675-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: isfHxD47IDppckKsfUigyDk2U2xn2Lka
X-Proofpoint-ORIG-GUID: vtFgJ8O-NoYbarWKt-1KC1M7lOe8WRg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=821 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

From: Ido Plat <ido.plat@ibm.com>

Otherwise TCG would assume the register that holds t1 would be constant
and reuse whenever it needs the value within it.

Cc: qemu-stable@nongnu.org
Fixes: f1ea739bd598 ("target/s390x: Use tcg_constant_* in local contexts")
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[iii: Adjust a newline and capitalization, add tags]
Signed-off-by: Ido Plat <ido.plat@ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0d0c672c959..57b7db1ee96 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4781,9 +4781,10 @@ static DisasJumpType op_trXX(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ts(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 t1 = tcg_constant_i32(0xff);
+    TCGv_i32 ff = tcg_constant_i32(0xff);
+    TCGv_i32 t1 = tcg_temp_new_i32();
 
-    tcg_gen_atomic_xchg_i32(t1, o->in2, t1, get_mem_index(s), MO_UB);
+    tcg_gen_atomic_xchg_i32(t1, o->in2, ff, get_mem_index(s), MO_UB);
     tcg_gen_extract_i32(cc_op, t1, 7, 1);
     set_cc_static(s);
     return DISAS_NEXT;
-- 
2.44.0


