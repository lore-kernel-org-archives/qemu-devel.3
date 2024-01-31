Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9FDC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 23:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVJiY-00079J-Nn; Wed, 31 Jan 2024 18:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVJiP-00076A-1r; Wed, 31 Jan 2024 18:09:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVJiM-0000KQ-Sc; Wed, 31 Jan 2024 18:09:56 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VMCggF022216; Wed, 31 Jan 2024 23:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PDs9WcuQA2Fn9a9vifWCDcrigVwLNQp3r4uZwvf7LJY=;
 b=lqGhBighAFMlFZqg+vr7PLkzGvPZBQZDJuU+k9MoUDotZ5/lPDsudEYLNulAqinzERdi
 UzQNsv6YL5rsieJqcGuqnxtCvheIbs/bruLEZ34jRJ2HVlBoU2d29YGcIrtVIGoXQpth
 4b5e60DyOFmW+QgU1QvnQWoLUAwImNclrjxZXGJInmrSXYtNOorbdLKo6JCxim5qDd4X
 9BpPxbVZNcYkr8r1AzUJ4oORF07Z02TJmtl6iG37dIzGJzT1sSuB+BjFECPJAHYGWQMp
 7/RACvTxWxEbZ8Gr31pyT+Boy97UfNcdak7fEVd8BVM3piLOYwwvH2YqwHjItCkqBLE6 wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vytwmy7mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:52 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VN0erL003175;
 Wed, 31 Jan 2024 23:09:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vytwmy7mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VK1wBV002256; Wed, 31 Jan 2024 23:09:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tgq6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VN9nO716974554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 23:09:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF8A20040;
 Wed, 31 Jan 2024 23:09:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9045E2004B;
 Wed, 31 Jan 2024 23:09:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 23:09:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PATCH v3 3/4] target/s390x: implement CVB, CVBY and CVBG
Date: Thu,  1 Feb 2024 00:07:12 +0100
Message-ID: <20240131230938.325919-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131230938.325919-1-iii@linux.ibm.com>
References: <20240131230938.325919-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wLUVu3BzEkjLVHTFEnZdq_t_lp4UyCSN
X-Proofpoint-ORIG-GUID: zCnvGO16RUAM3MeYOw-z-5kptm1c6rx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=886
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310178
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

From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Convert to Binary - counterparts of the already implemented Convert
to Decimal (CVD*) instructions.
Example from the Principles of Operation: 25594C becomes 63FA.

[iii: Use separate functions for CVB and CVBG for simplicity].

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/helper.h            |  1 +
 target/s390x/tcg/insn-data.h.inc |  4 ++++
 target/s390x/tcg/int_helper.c    | 40 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/translate.c     | 12 ++++++++++
 4 files changed, 57 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 332a9a9c632..3c607f4e437 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -88,6 +88,7 @@ DEF_HELPER_FLAGS_3(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i128, i64)
 DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
+DEF_HELPER_FLAGS_3(cvb, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 388dcb8dbbc..9eb998d4c25 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -293,6 +293,10 @@
     D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_16u, 0, 0, ct, 0, 1)
     D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_16u, 0, 0, ct, 0, 1)
 
+/* CONVERT TO BINARY */
+    C(0x4f00, CVB,     RX_a,  Z,   la2, 0, new, r1_32, cvb, 0)
+    C(0xe306, CVBY,    RXY_a, LD,  la2, 0, new, r1_32, cvb, 0)
+    C(0xe30e, CVBG,    RXY_a, Z,   la2, 0, r1, 0, cvbg, 0)
 /* CONVERT TO DECIMAL */
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index 121e3006a65..002d4b52dda 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
@@ -98,6 +99,45 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
     tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
 }
 
+uint64_t HELPER(cvb)(CPUS390XState *env, uint64_t src, uint32_t n)
+{
+    int64_t dec, sign = 0, digit, val = 0, pow10 = 0;
+    const uintptr_t ra = GETPC();
+    uint64_t tmpsrc;
+    int i, j;
+
+    for (i = 0; i < n; i++) {
+        tmpsrc = wrap_address(env, src + (n - i - 1) * 8);
+        dec = cpu_ldq_data_ra(env, tmpsrc, ra);
+        for (j = 0; j < 16; j++, dec >>= 4) {
+            if (i == 0 && j == 0) {
+                sign = dec & 0xf;
+                if (sign < 0xa) {
+                    tcg_s390_data_exception(env, 0, ra);
+                }
+                continue;
+            }
+            digit = dec & 0xf;
+            if (digit > 0x9) {
+                tcg_s390_data_exception(env, 0, ra);
+            }
+            if (i == 0 && j == 1) {
+                if (sign == 0xb || sign == 0xd) {
+                    val = -digit;
+                    pow10 = -10;
+                } else {
+                    val = digit;
+                    pow10 = 10;
+                }
+            } else {
+                val += digit * pow10;
+                pow10 *= 10;
+            }
+        }
+    }
+    return val;
+}
+
 uint64_t HELPER(cvd)(int32_t reg)
 {
     /* positive 0 */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c2fdc920a50..43216571b44 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2223,6 +2223,18 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
+{
+    gen_helper_cvb(o->out, tcg_env, o->addr1, tcg_constant_i32(1));
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_cvbg(DisasContext *s, DisasOps *o)
+{
+    gen_helper_cvb(o->out, tcg_env, o->addr1, tcg_constant_i32(2));
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
-- 
2.43.0


