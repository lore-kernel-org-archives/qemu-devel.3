Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E432C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 20:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX638-0007Qv-Nt; Mon, 05 Feb 2024 15:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX637-0007Q2-LG; Mon, 05 Feb 2024 15:58:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX634-00038A-Nu; Mon, 05 Feb 2024 15:58:41 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415Kt121022179; Mon, 5 Feb 2024 20:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TWaAYzedoDmwSo+VdLBPaFxuqPcfOVTInVXJb7c9NXw=;
 b=GHl/Z+gkVD8nhLF622jpjo4bGduqjaTaXKbDDd0v4KPzvpfKwVrKkui8XBrEG+HRCH9O
 iPHHyB47DyeaLHop40p58ivfjE8R0qbJ0SHgbXdTpT/swgZKBfFthP0cVl6S8/PNRC0M
 TICgFEQxTqbMEXIDKd6sLywv5JeoOVoSDMjW2xTtsf1V+fioX2Rod3BnJ57ylBO72UiE
 bvjl6PgZqVxXkXGQkBpEDDIKPxb+BFNqlQK07dViO6H0xTvZ0D3Rlbm0LYoD6oLvQibO
 U1etOJvIsk5/tw6EqPohZVxTP396jhqKJK+KT3011eKRYTREr2QShJSMjMDFAfIA579z 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w369eh4ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415KvEv0030600;
 Mon, 5 Feb 2024 20:58:35 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w369eh4uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415IgaOX019991; Mon, 5 Feb 2024 20:58:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsu4su-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 20:58:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415KwWA121037686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 20:58:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C27E720043;
 Mon,  5 Feb 2024 20:58:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5382C20040;
 Mon,  5 Feb 2024 20:58:32 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 20:58:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ido Plat <Ido.Plat@ibm.com>
Subject: [PATCH v5 1/4] target/s390x: Emulate CVDG
Date: Mon,  5 Feb 2024 21:54:53 +0100
Message-ID: <20240205205830.6425-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205205830.6425-1-iii@linux.ibm.com>
References: <20240205205830.6425-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -a9As39X8fWPZaXLc_60St2ICoGmMQIr
X-Proofpoint-ORIG-GUID: HyC9vs0_CV6kLz5cgUSd0MDNmPngoKmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 suspectscore=0 mlxlogscore=530 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

CVDG is the same as CVD, except that it converts 64 bits into 128,
rather than 32 into 64. Create a new helper, which uses Int128
wrappers.

Reported-by: Ido Plat <Ido.Plat@ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h            |  1 +
 target/s390x/tcg/insn-data.h.inc |  1 +
 target/s390x/tcg/int_helper.c    | 21 +++++++++++++++++++++
 target/s390x/tcg/translate.c     |  8 ++++++++
 4 files changed, 31 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 05102578fc9..332a9a9c632 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -89,6 +89,7 @@ DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
+DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 2f07f39d9cb..388dcb8dbbc 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -296,6 +296,7 @@
 /* CONVERT TO DECIMAL */
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
+    C(0xe32e, CVDG,    RXY_a, Z,   r1_o, a2, 0, 0, cvdg, 0)
 /* CONVERT TO FIXED */
     F(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0, IF_BFP)
     F(0xb399, CFDBR,   RRF_e, Z,   0, f2, new, r1_32, cfdb, 0, IF_BFP)
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index eb8e6dd1b57..121e3006a65 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -118,6 +118,27 @@ uint64_t HELPER(cvd)(int32_t reg)
     return dec;
 }
 
+Int128 HELPER(cvdg)(int64_t reg)
+{
+    /* positive 0 */
+    Int128 dec = int128_make64(0x0c);
+    Int128 bin = int128_makes64(reg);
+    Int128 base = int128_make64(10);
+    int shift;
+
+    if (!int128_nonneg(bin)) {
+        bin = int128_neg(bin);
+        dec = int128_make64(0x0d);
+    }
+
+    for (shift = 4; (shift < 128) && int128_nz(bin); shift += 4) {
+        dec = int128_or(dec, int128_lshift(int128_remu(bin, base), shift));
+        bin = int128_divu(bin, base);
+    }
+
+    return dec;
+}
+
 uint64_t HELPER(popcnt)(uint64_t val)
 {
     /* Note that we don't fold past bytes. */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a5fd9cccaa5..c2fdc920a50 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2233,6 +2233,14 @@ static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_cvdg(DisasContext *s, DisasOps *o)
+{
+    TCGv_i128 t = tcg_temp_new_i128();
+    gen_helper_cvdg(t, o->in1);
+    tcg_gen_qemu_st_i128(t, o->in2, get_mem_index(s), MO_TE | MO_128);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_ct(DisasContext *s, DisasOps *o)
 {
     int m3 = get_field(s, m3);
-- 
2.43.0


