Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A40C48299
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 20:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX63B-0007Sy-Gh; Mon, 05 Feb 2024 15:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX639-0007Qy-5r; Mon, 05 Feb 2024 15:58:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX636-00038M-LD; Mon, 05 Feb 2024 15:58:42 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415Kg9QA022200; Mon, 5 Feb 2024 20:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JJOYK/3zH3IM/BtXpd2VhZkb4e9MdwCe6stXaqTZkww=;
 b=lHAtwbhaTkoZYcmIdlXPlR6rluuooNLkJcL1gXgZGlu5MzRf1DPOJ1TZe8z5UOd4mff6
 tBr4SK5HigXDOkJBa2CeGVfzKlfHJKsY/WTdzr8UWTX4isENhvKTGKUsl9URMqFNaBRR
 oJHP/hQyh/Tuh/Y0G6oIFLt0YxFApCl0yeAWsbkH5N2prC0+jGPqmoAnSbRtC7E/ioCo
 dcIuL5Hq4lajMa1s+kUadK65Z/BMu7PDDYGf/fXnJJ/z07xOk1Yg8YBCdrUXsNYGTKUI
 i+n5+5CFTwckiPRvHwjW1X+EkyFuUkNehuOnHdNMzcyJthtiFMJZiADARaBkn7ZMZzQR yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w36xj8agk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415KgEGG022380;
 Mon, 5 Feb 2024 20:58:36 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w36xj8ag6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415IgaOY019991; Mon, 5 Feb 2024 20:58:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsu4sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415KwX8x66126264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 20:58:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9FA320043;
 Mon,  5 Feb 2024 20:58:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B6EE20040;
 Mon,  5 Feb 2024 20:58:33 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 20:58:33 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PATCH v5 2/4] target/s390x: Emulate CVB, CVBY and CVBG
Date: Mon,  5 Feb 2024 21:54:54 +0100
Message-ID: <20240205205830.6425-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205205830.6425-1-iii@linux.ibm.com>
References: <20240205205830.6425-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dUvxRpzwE-tkTxIuKj76DjrFU-PjpnFK
X-Proofpoint-GUID: 0oiFIayoIIGPcKZ9sS21NFBXAhcNzReM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=798 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050157
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

Convert to Binary - counterparts of the already implemented Convert
to Decimal (CVD*) instructions.
Example from the Principles of Operation: 25594C becomes 63FA.

Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h            |  2 +
 target/s390x/tcg/insn-data.h.inc |  4 ++
 target/s390x/tcg/int_helper.c    | 76 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/translate.c     | 16 +++++++
 4 files changed, 98 insertions(+)

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
index 121e3006a65..2af970f2c8b 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
@@ -98,6 +99,81 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
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
+        /*
+         * Prepend the next digit and check for overflow. The multiplication
+         * cannot overflow, since, conveniently, the int64_t limits are
+         * approximately +-9.2E+18. If bin is zero, the addition cannot
+         * overflow. Otherwise bin is known to have the same sign as the rhs
+         * addend, in which case overflow happens if and only if the result
+         * has a different sign.
+         */
+        tmp = bin + pow10 * digit;
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


