Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91180C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuIU-0007mA-Fv; Fri, 02 Feb 2024 09:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVuIO-0007kf-04; Fri, 02 Feb 2024 09:13:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVuIM-00048M-1j; Fri, 02 Feb 2024 09:13:31 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412DoVKa030823; Fri, 2 Feb 2024 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JHGGu5VK0Qk9ffsN0tt8P10AYR/ZYGJq76N48EeA1yE=;
 b=r4n3mWquKK69NNvqv3xYBMiWTl76Z0cA1rIjCJamweUo5UuHrGFOubHGG/2qLl9aojGc
 otWufgf3j9rRiXvDkzG+qLEvZgxhpDOQxRfgpwREq0BUk7r7JvZW40QtFH/K9mtRkE3k
 zgRFDFWqrkx4L5u3aAnsoRbvxZBIGWK7xcNVliXTDnASV/WkfmdPnsNwevWYBC1nGrGs
 5G/lVJtl2wsEtZqtir9zQemUrxZaf/5I7AAVELheiNrykYmWtRrP70U4awq5d7/6qj+j
 m0ZvUqZYTFuyHHrGzRXGAnqVLAMvTtnhJA5OpMTxSS+6RxptpNWfmzv9EarZF2nHGR5I ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11mh0j3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:13:27 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412Dqx75004260;
 Fri, 2 Feb 2024 14:13:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11mh0j2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:13:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412CpGUN010569; Fri, 2 Feb 2024 14:13:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pbq90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:13:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412EDN1o38208106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 14:13:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEE4A2004B;
 Fri,  2 Feb 2024 14:13:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A163F20043;
 Fri,  2 Feb 2024 14:13:23 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 14:13:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PATCH v4 2/4] target/s390x: Emulate CVB, CVBY and CVBG
Date: Fri,  2 Feb 2024 15:11:58 +0100
Message-ID: <20240202141318.95962-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202141318.95962-1-iii@linux.ibm.com>
References: <20240202141318.95962-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H8cO1kBfneb5W71r6yYvBeSeGziXa1PJ
X-Proofpoint-GUID: By-ew7AgQAcRkeAxtmFkrjsWux4WHplP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=786 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Convert to Binary - counterparts of the already implemented Convert
to Decimal (CVD*) instructions.
Example from the Principles of Operation: 25594C becomes 63FA.

Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h            |  2 +
 target/s390x/tcg/insn-data.h.inc |  4 ++
 target/s390x/tcg/int_helper.c    | 72 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/translate.c     | 16 +++++++
 4 files changed, 94 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 332a9a9c632..cc1c20e9e3f 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -88,6 +88,8 @@ DEF_HELPER_FLAGS_3(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i128, i64)
 DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
+DEF_HELPER_3(cvb, void, env, i32, i64)
+DEF_HELPER_FLAGS_2(cvbg, TCG_CALL_NO_WG, i64, env, i128)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 388dcb8dbbc..e7d61cdec28 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -293,6 +293,10 @@
     D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_16u, 0, 0, ct, 0, 1)
     D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_16u, 0, 0, ct, 0, 1)
 
+/* CONVERT TO BINARY */
+    C(0x4f00, CVB,     RX_a,  Z,   la2, 0, 0, 0, cvb, 0)
+    C(0xe306, CVBY,    RXY_a, LD,  la2, 0, 0, 0, cvb, 0)
+    C(0xe30e, CVBG,    RXY_a, Z,   la2, 0, r1, 0, cvbg, 0)
 /* CONVERT TO DECIMAL */
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index 121e3006a65..17974375e98 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
@@ -98,6 +99,77 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
     tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
 }
 
+void HELPER(cvb)(CPUS390XState *env, uint32_t r1, uint64_t dec)
+{
+    int64_t pow10 = 1, bin = 0;
+    int digit, sign;
+
+    sign = dec & 0xf;
+    if (sign < 0xa) {
+        tcg_s390_data_exception(env, 0, GETPC());
+    }
+    dec >>= 4;
+
+    while (dec) {
+        digit = dec & 0xf;
+        if (digit > 0x9) {
+            tcg_s390_data_exception(env, 0, GETPC());
+        }
+        dec >>= 4;
+        bin += digit * pow10;
+        pow10 *= 10;
+    }
+
+    if (sign == 0xb || sign == 0xd) {
+        bin = -bin;
+    }
+
+    /* R1 is updated even on fixed-point-divide exception. */
+    env->regs[r1] = (env->regs[r1] & 0xffffffff00000000ULL) | (uint32_t)bin;
+    if (bin != (int32_t)bin) {
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+    }
+}
+
+uint64_t HELPER(cvbg)(CPUS390XState *env, Int128 dec)
+{
+    uint64_t dec64[] = {int128_getlo(dec), int128_gethi(dec)};
+    int64_t bin = 0, pow10, tmp;
+    int digit, i, sign;
+
+    sign = dec64[0] & 0xf;
+    if (sign < 0xa) {
+        tcg_s390_data_exception(env, 0, GETPC());
+    }
+    dec64[0] >>= 4;
+    pow10 = (sign == 0xb || sign == 0xd) ? -1 : 1;
+
+    for (i = 1; i < 20; i++) {
+        digit = dec64[i >> 4] & 0xf;
+        if (digit > 0x9) {
+            tcg_s390_data_exception(env, 0, GETPC());
+        }
+        dec64[i >> 4] >>= 4;
+        tmp = pow10 * digit;
+        if (digit && ((tmp ^ pow10) < 0)) {
+            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        }
+        tmp = bin + tmp;
+        if (bin && ((tmp ^ bin) < 0)) {
+            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        }
+        bin = tmp;
+        pow10 *= 10;
+    }
+
+    g_assert(!dec64[0]);
+    if (dec64[1]) {
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+    }
+
+    return bin;
+}
+
 uint64_t HELPER(cvd)(int32_t reg)
 {
     /* positive 0 */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c2fdc920a50..325b25959d3 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2223,6 +2223,22 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEUQ);
+    gen_helper_cvb(tcg_env, tcg_constant_i32(get_field(s, r1)), t);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_cvbg(DisasContext *s, DisasOps *o)
+{
+    TCGv_i128 t = tcg_temp_new_i128();
+    tcg_gen_qemu_ld_i128(t, o->addr1, get_mem_index(s), MO_TE | MO_128);
+    gen_helper_cvbg(o->out, tcg_env, t);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
-- 
2.43.0


