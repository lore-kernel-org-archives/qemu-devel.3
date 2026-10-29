Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C94606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MTmWIIv1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCf-0000qr-HB; Thu, 29 Oct 2026 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qJ-91
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bz-Jt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDWxn3234237; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mvYB2sm3n1N
 e54BJ7/ULnbRMRSA4d0bPVD0+cn56Q9c=; b=MTmWIIv1lFmfNbDP4gEG6jT6tyn
 xYkSgNgoY0g58vYjpStnba+F6cmJHFp9qy/S19HVwungswVUYKgGXBuKktUNI9+Q
 DOL9lLzM1PU18GsuYZTcouKK4niLKoJSmIDG29TqwwES7oy7M2/tXRrwDj0UUaC2
 0w3FvuTUrF1Ajwdut2WR1p+wwuuKZvUSlOynT5XKmeidt/kRnyEC5jN4tepZh8vU
 WRyHboB0JuQSsgeI7Xk95I4Ist8YEcgcotX//Dn+1h0Uuo85rXKZ1137v9LyX4Ek
 Nku0ah7Eqfz4M+oK8fic8WsHY4oNIXJkP8QpwBqSGT/TJram8fMjfRRZSMA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b28d0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEp22549232; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69THiEdD2549238
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 814402582F; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 05/20] target/hexagon: add HLX register classes to generators
Date: Thu, 29 Oct 2026 10:43:58 -0700
Message-ID: <20261029174413.643130-6-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX6g37zFXE4alP
 /5jEOyxgquBn2JWZlCObgZnDOy/VH+co8Sygtkd+81feXAOub9aU9+zX8f5czZUgCOUJ8ak0oaw
 rlrytiqky+fX/TC6KFX/xEXQ3wx+flQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXwrKGe27DcpEj
 md3mRfV35IDLzo3mvNecVQQw6YL7CDaGYGf5GvnKAYCxaTG+DKx+Y8Eqrq6NMIf80yCHBCTzSJE
 wJR1rgkNf6rrdrlIPWB8IDAxwZnm3v0ugA7okwzltvY+o9O10BwlDOTwMZ5OKNwkXdvbVgvg+Ho
 BZhfh9p+H5UrspT2WlpIE/UUNNnFnaPYir5aURoDe+tEbxeAJX9qUfmX33kkWpUAN2OzYUr/1Ag
 MXmuYj+6z9n8CcN/FinKQTQ1Zic05WCoIvkjUVadsKmMdrYwfiJFsgzch2+wouBbCoXXhFxArPx
 U4kbf+mAQeAuYhaFkBtiOsFSPKF02sFv1wmAZYAMb9Wbsa/oQM9tiHMrxRFYy1UxgocjIPmqgXW
 CSLoA0zKZ/d7WzaKEM98j1x78aQ0XHtpJikaV+EjKx0MIYbug4XaSVIBhRdXiU7rh56JQW/qAXu
 L/FEQYScolu1J4kC1Bw==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=8N5cFOFvIqjjT47vyNkA:9
X-Proofpoint-GUID: F2Stode4OLZvyrZCX47egAAJTOCOji-m
X-Proofpoint-ORIG-GUID: F2Stode4OLZvyrZCX47egAAJTOCOji-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Teach the generators about L registers and add support for inline gvec
operations.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_decodetree.py  |   6 +-
 target/hexagon/gen_trans_funcs.py |   4 +-
 target/hexagon/hex_common.py      | 606 +++++++++++++++++++++++++++++-
 3 files changed, 607 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/gen_decodetree.py b/target/hexagon/gen_decodetree.py
index ce703af41d..3aa2979a1f 100755
--- a/target/hexagon/gen_decodetree.py
+++ b/target/hexagon/gen_decodetree.py
@@ -33,14 +33,16 @@
 }
 
 
-regre = re.compile(r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
+regre = re.compile(
+    r"((?<!DUP)[MNORCPQXSGVZALK])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)"
+)
 immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
 
 
 def ordered_unique(l):
     return sorted(set(l), key=l.index)
 
-num_registers = {"R": 32, "V": 32}
+num_registers = {"R": 32, "V": 32, "L": 16}
 
 operand_letters = {
     "P",
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 45da1b7b5d..93125bdfe4 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -33,7 +33,9 @@
 }
 
 
-regre = re.compile(r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
+regre = re.compile(
+    r"((?<!DUP)[MNORCPQXSGVZALK])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)"
+)
 immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
 
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index a4807bed7b..091c1bf7ef 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -76,10 +76,12 @@ def uniquify(seq):
     return [x for x in seq if x not in seen and not seen_add(x)]
 
 
-regre = re.compile(r"((?<!DUP)[MNORCPQXSGVZA])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)")
+regre = re.compile(
+    r"((?<!DUP)[MNORCPQXSGVZALK])([stuvwxyzdefg]+)([.]?[LlHh]?)(\d+S?)"
+)
 immre = re.compile(r"[#]([rRsSuUm])(\d+)(?:[:](\d+))?")
 reg_or_immre = re.compile(
-    r"(((?<!DUP)[MNRCOPQXSGVZA])([stuvwxyzdefg]+)"
+    r"(((?<!DUP)[MNRCOPQXSGVZALK])([stuvwxyzdefg]+)"
     r"([.]?[LlHh]?)(\d+S?))|([#]([rRsSuUm])(\d+)[:]?(\d+)?)"
 )
 relimmre = re.compile(r"[#]([rR])(\d+)(?:[:](\d+))?")
@@ -305,6 +307,274 @@ def skip_qemu_helper(tag):
     return tag in overrides.keys()
 
 
+# HLX instructions that are emitted as inline gvec TCG IR instead of a
+# helper call.  "size" is the oprsz/maxsz for the gvec calls, one register
+# (the default) or a pair.  "table" names a descriptor in hlx_gvec_tables.h.
+HLX_INLINE_TAGS = {
+    "LX_add_h":      {"op": "add",          "vece": "MO_16"},
+    "LX_sub_h":      {"op": "sub",          "vece": "MO_16"},
+    "LX_assign":     {"op": "mov",          "vece": "MO_64"},
+    # LX_add_w and LX_sub_w cannot be inlined: the low halfword of each word
+    # is in the lo register and the high halfword in the hi register, so a
+    # 32-bit gvec add would lose the carry between them.  They use the helper,
+    # which interleaves the pair first.
+    "LX_assign_w":   {"op": "mov",          "vece": "MO_64",
+                      "size": "2 * sizeof(HLXVector)"},
+    "LX_combine_w":  {"op": "combine_pair", "vece": "MO_64"},
+}
+
+def is_hlx_inline_tag(tag):
+    return tag in HLX_INLINE_TAGS
+
+def gen_hlx_inline(f, tag, regs):
+    """Emit inline gvec operations, splitting 4096-byte register pairs.
+
+    gvec maxsz is limited to 2048 bytes, so pairs use two calls.
+    """
+    desc = HLX_INLINE_TAGS[tag]
+    op = desc["op"]
+    vece = desc["vece"]
+    sz = desc.get("size", "sizeof(HLXVector)")
+    pair_dst = (sz == "2 * sizeof(HLXVector)")
+    single = "sizeof(HLXVector)"
+    oprsz = single if pair_dst else desc.get("oprsz", sz)
+    maxsz = single if pair_dst else desc.get("maxsz", sz)
+
+    def reg(i):
+        regtype, regid, *_ = regs[i]
+        return f"{regtype}{regid}V"
+
+    if op == "add":
+        d, a, b = reg(0), reg(1), reg(2)
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_add_var({vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {b}_base, {b}_off,
+                                     {oprsz}, {maxsz});
+                tcg_gen_gvec_add_var({vece},
+                                     {d}_base, {d}_off + sizeof(HLXVector),
+                                     {a}_base, {a}_off + sizeof(HLXVector),
+                                     {b}_base, {b}_off + sizeof(HLXVector),
+                                     {oprsz}, {maxsz});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_add_var({vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {b}_base, {b}_off,
+                                     {oprsz}, {maxsz});
+            """))
+    elif op == "sub":
+        d, a, b = reg(0), reg(1), reg(2)
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_sub_var({vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {b}_base, {b}_off,
+                                     {oprsz}, {maxsz});
+                tcg_gen_gvec_sub_var({vece},
+                                     {d}_base, {d}_off + sizeof(HLXVector),
+                                     {a}_base, {a}_off + sizeof(HLXVector),
+                                     {b}_base, {b}_off + sizeof(HLXVector),
+                                     {oprsz}, {maxsz});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_sub_var({vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {b}_base, {b}_off,
+                                     {oprsz}, {maxsz});
+            """))
+    elif op == "mov":
+        d, a = reg(0), reg(1)
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_mov_var({vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {oprsz}, {maxsz});
+                tcg_gen_gvec_mov_var({vece},
+                                     {d}_base, {d}_off + sizeof(HLXVector),
+                                     {a}_base, {a}_off + sizeof(HLXVector),
+                                     {oprsz}, {maxsz});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_mov_var({vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {oprsz}, {maxsz});
+            """))
+    elif op == "dup_imm":
+        d = reg(0)
+        imm = desc["imm"]
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_dup_imm_var({vece},
+                                         {d}_base, {d}_off,
+                                         {oprsz}, {maxsz}, {imm});
+                tcg_gen_gvec_dup_imm_var({vece},
+                                         {d}_base, {d}_off + sizeof(HLXVector),
+                                         {oprsz}, {maxsz}, {imm});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_dup_imm_var({vece},
+                                         {d}_base, {d}_off,
+                                         {oprsz}, {maxsz}, {imm});
+            """))
+    elif op == "gvec3":
+        d, a, b = reg(0), reg(1), reg(2)
+        table = desc["table"]
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_3_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {b}_base, {b}_off,
+                                   {oprsz}, {maxsz}, &{table});
+                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
+                                   {a}_base, {a}_off + sizeof(HLXVector),
+                                   {b}_base, {b}_off + sizeof(HLXVector),
+                                   {oprsz}, {maxsz}, &{table});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_3_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {b}_base, {b}_off,
+                                   {oprsz}, {maxsz}, &{table});
+            """))
+    elif op == "gvec3_arr":
+        # Like gvec3, but table is a GVecGen3[4] indexed by vece.
+        d, a, b = reg(0), reg(1), reg(2)
+        table = desc["table"]
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_3_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {b}_base, {b}_off,
+                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
+                                   {a}_base, {a}_off + sizeof(HLXVector),
+                                   {b}_base, {b}_off + sizeof(HLXVector),
+                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_3_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {b}_base, {b}_off,
+                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+            """))
+    elif op == "combine_pair":
+        dd, u, v = reg(0), reg(1), reg(2)
+        single = "sizeof(HLXVector)"
+        f.write(code_fmt(f"""\
+            tcg_gen_gvec_mov_var({vece},
+                                 {dd}_base, {dd}_off,
+                                 {v}_base, {v}_off,
+                                 {single}, {single});
+            tcg_gen_gvec_mov_var({vece},
+                                 {dd}_base,
+                                 {dd}_off + sizeof(HLXVector),
+                                 {u}_base, {u}_off,
+                                 {single}, {single});
+        """))
+    elif op == "gvec2":
+        # Two-operand op: dest and one source.  table is a const GVecGen2.
+        d, a = reg(0), reg(1)
+        table = desc["table"]
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_2_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {oprsz}, {maxsz}, &{table});
+                tcg_gen_gvec_2_var({d}_base, {d}_off + sizeof(HLXVector),
+                                   {a}_base, {a}_off + sizeof(HLXVector),
+                                   {oprsz}, {maxsz}, &{table});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_2_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {oprsz}, {maxsz}, &{table});
+            """))
+    elif op == "gvec2_arr":
+        # Like gvec2, but table is a GVecGen2[4] indexed by vece.
+        d, a = reg(0), reg(1)
+        table = desc["table"]
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_2_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+                tcg_gen_gvec_2_var({d}_base, {d}_off + sizeof(HLXVector),
+                                   {a}_base, {a}_off + sizeof(HLXVector),
+                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_2_var({d}_base, {d}_off,
+                                   {a}_base, {a}_off,
+                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+            """))
+    elif op == "cmp_gt":
+        # a > b is done as b < a, with the less-than descriptor in "table"
+        d, a, b = reg(0), reg(1), reg(2)
+        table = desc["table"]
+        if pair_dst:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_3_var({d}_base, {d}_off,
+                                   {b}_base, {b}_off,
+                                   {a}_base, {a}_off,
+                                   {oprsz}, {maxsz}, &{table});
+                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
+                                   {b}_base, {b}_off + sizeof(HLXVector),
+                                   {a}_base, {a}_off + sizeof(HLXVector),
+                                   {oprsz}, {maxsz}, &{table});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_3_var({d}_base, {d}_off,
+                                   {b}_base, {b}_off,
+                                   {a}_base, {a}_off,
+                                   {oprsz}, {maxsz}, &{table});
+            """))
+    elif op == "conv_h_to_w_pair":
+        # lo = the source; hi = zeros (zxt) or the source >> 15 (sxt)
+        d, a = reg(0), reg(1)
+        single = "sizeof(HLXVector)"
+        sign_extend = desc.get("sign_extend", False)
+        if sign_extend:
+            table = desc["table"]
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_mov_var(MO_64,
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {single}, {single});
+                tcg_gen_gvec_2_var({d}_base, {d}_off + sizeof(HLXVector),
+                                   {a}_base, {a}_off,
+                                   {single}, {single}, &{table});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                tcg_gen_gvec_mov_var(MO_64,
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {single}, {single});
+                tcg_gen_gvec_dup_imm_var(MO_64,
+                                         {d}_base, {d}_off + sizeof(HLXVector),
+                                         {single}, {single}, 0);
+            """))
+    else:
+        raise Exception(f"unknown HLX inline op {op!r} for tag {tag!r}")
+
+
 def is_idef_parser_enabled(tag):
     return tag in idef_parser_enabled
 
@@ -408,6 +678,8 @@ def is_scalar_reg(self):
         return True
     def is_hvx_reg(self):
         return False
+    def is_hlx_reg(self):
+        return False
     def helper_arg_name(self):
         return self.reg_tcg()
 
@@ -432,6 +704,8 @@ def is_scalar_reg(self):
         return False
     def is_hvx_reg(self):
         return True
+    def is_hlx_reg(self):
+        return False
     def hvx_off(self):
         return f"{self.reg_tcg()}_off"
     def hvx_base(self):
@@ -1203,6 +1477,308 @@ def analyze_write(self, f, tag, regno):
                                insn_has_hvx_helper);
         """))
 
+# HLX has sixteen 2048-byte L registers.
+class Hlx:
+    def is_scalar_reg(self):
+        return False
+    def is_hvx_reg(self):
+        return False
+    def is_hlx_reg(self):
+        return True
+    def hlx_off(self):
+        return f"{self.reg_tcg()}_off"
+    def helper_proto_type(self):
+        return "ptr"
+    def helper_arg_type(self):
+        return "void *"
+    def helper_arg_name(self):
+        return f"{self.reg_tcg()}_void"
+    def decl_reg_num(self, f, regno):
+        # HLX sources are not logged, so this can be unused.
+        f.write(code_fmt(f"""\
+            const int {self.reg_num} G_GNUC_UNUSED = insn->regno[{regno}];
+        """))
+
+class LRegDest(Hlx, Register, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        if "A_HLX_TMP" in attribdict[tag]:
+            storage = "tmp_LRegs"
+        else:
+            storage = "future_LRegs"
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hlx_off()} =
+                offsetof(CPUHexagonState, {storage}[{self.reg_num}]);
+        """))
+        if "A_HLX_TMP" in attribdict[tag] and "A_CONDEXEC" in attribdict[tag]:
+            f.write(code_fmt(f"""\
+                gen_helper_hlx_copy_live_to_tmp(tcg_env,
+                    tcg_constant_i32({self.reg_num}));
+            """))
+        if is_hlx_inline_tag(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()}_base = tcg_env;
+            """))
+        elif not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hlx_off()});
+            """))
+    def gen_write(self, f, tag):
+        pass
+    def helper_hlx_desc(self, f):
+        desc = f"*(HLXVector *)({self.helper_arg_name()})"
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is {desc} */
+        """))
+    def analyze_write(self, f, tag, regno):
+        if "A_HLX_TMP" in attribdict[tag]:
+            f.write(code_fmt(f"""\
+                ctx_log_lreg_tmp_write(ctx, {self.reg_num});
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                ctx_log_lreg_write(ctx, {self.reg_num});
+            """))
+
+class LRegSource(Hlx, Register, Single, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_ptr {self.reg_tcg()}_base;
+            intptr_t {self.reg_tcg()}_off;
+            if (test_bit({self.reg_num}, ctx->lregs_updated_tmp)) {{
+                {self.reg_tcg()}_base = tcg_env;
+                {self.reg_tcg()}_off =
+                    offsetof(CPUHexagonState, tmp_LRegs[{self.reg_num}]);
+            }} else {{
+                {self.reg_tcg()}_base = ctx_get_hlx_base(ctx);
+                {self.reg_tcg()}_off =
+                    offsetof(HexagonHLXContext, LRegs[{self.reg_num}]);
+            }}
+        """))
+        if not is_hlx_inline_tag(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, {self.reg_tcg()}_base,
+                                 {self.reg_tcg()}_off);
+            """))
+    def helper_hlx_desc(self, f):
+        desc = f"*(HLXVector *)({self.helper_arg_name()})"
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is {desc} */
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
+class LRegNewSource(Hlx, Register, Single, NewSource):
+    def decl_tcg(self, f, tag, regno):
+        if skip_qemu_helper(tag):
+            self.decl_reg_num(f, regno)
+            f.write(code_fmt(f"""\
+                const intptr_t {self.hlx_off()} =
+                    offsetof(CPUHexagonState, future_LRegs[{self.reg_num}]);
+            """))
+        else:
+            # No reg_num variable here, it would clash with the TCGv_ptr
+            f.write(code_fmt(f"""\
+                const intptr_t {self.hlx_off()} =
+                    offsetof(CPUHexagonState,
+                             future_LRegs[insn->regno[{regno}]]);
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hlx_off()});
+            """))
+    def helper_hlx_desc(self, f):
+        desc = f"*(HLXVector *)({self.helper_arg_name()})"
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is {desc} */
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
+class LRegReadWrite(Hlx, Register, Single, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hlx_off()} =
+                offsetof(CPUHexagonState, future_LRegs[{self.reg_num}]);
+            if (test_bit({self.reg_num}, ctx->lregs_updated_tmp)) {{
+                tcg_gen_gvec_mov(MO_64, {self.hlx_off()},
+                                 offsetof(CPUHexagonState,
+                                          tmp_LRegs[{self.reg_num}]),
+                                 sizeof(HLXVector), sizeof(HLXVector));
+            }} else {{
+                gen_helper_hlx_copy_live_to_future(tcg_env,
+                    tcg_constant_i32({self.reg_num}));
+            }}
+        """))
+        if not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hlx_off()});
+            """))
+    def gen_write(self, f, tag):
+        pass
+    def helper_hlx_desc(self, f):
+        desc = f"*(HLXVector *)({self.helper_arg_name()})"
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is {desc} */
+        """))
+    def analyze_read(self, f, regno):
+        pass
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_lreg_write(ctx, {self.reg_num});
+        """))
+
+class LRegTmp(Hlx, Register, Single, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hlx_off()} =
+                offsetof(CPUHexagonState, tmp_LRegs[{self.reg_num}]);
+        """))
+        if is_hlx_inline_tag(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()}_base = tcg_env;
+            """))
+        elif not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hlx_off()});
+            """))
+    def gen_write(self, f, tag):
+        pass
+    def helper_hlx_desc(self, f):
+        desc = f"*(HLXVector *)({self.helper_arg_name()})"
+        f.write(code_fmt(f"""\
+            /* {self.reg_tcg()} is {desc} */
+        """))
+    def analyze_read(self, f, regno):
+        pass
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_lreg_tmp_write(ctx, {self.reg_num});
+        """))
+
+# Pair classes expose base and offset for inline tags.
+class LRegPairDest(Hlx, Register, Pair, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hlx_off()} =
+                offsetof(CPUHexagonState, future_LRegs[{self.reg_num}]);
+        """))
+        if is_hlx_inline_tag(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()}_base = tcg_env;
+            """))
+        elif not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hlx_off()});
+            """))
+    def gen_write(self, f, tag):
+        pass
+    def helper_hlx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /*
+             * {self.reg_tcg()} is
+             * *(HLXVectorPair *)({self.helper_arg_name()})
+             */
+        """))
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_lreg_write_pair(ctx, {self.reg_num});
+        """))
+
+class LRegPairSource(Hlx, Register, Pair, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_ptr {self.reg_tcg()}_base;
+            intptr_t {self.reg_tcg()}_off;
+            if (test_bit({self.reg_num}, ctx->lregs_updated_tmp) ||
+                test_bit({self.reg_num} + 1, ctx->lregs_updated_tmp)) {{
+                /* A pair is contiguous, so load any missing .tmp half. */
+                if (!test_bit({self.reg_num}, ctx->lregs_updated_tmp)) {{
+                    gen_helper_hlx_copy_live_to_tmp(tcg_env,
+                        tcg_constant_i32({self.reg_num}));
+                }}
+                if (!test_bit({self.reg_num} + 1, ctx->lregs_updated_tmp)) {{
+                    gen_helper_hlx_copy_live_to_tmp(tcg_env,
+                        tcg_constant_i32({self.reg_num} + 1));
+                }}
+                {self.reg_tcg()}_base = tcg_env;
+                {self.reg_tcg()}_off =
+                    offsetof(CPUHexagonState, tmp_LRegs[{self.reg_num}]);
+            }} else {{
+                {self.reg_tcg()}_base = ctx_get_hlx_base(ctx);
+                {self.reg_tcg()}_off =
+                    offsetof(HexagonHLXContext, LRegs[{self.reg_num}]);
+            }}
+        """))
+        if not is_hlx_inline_tag(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, {self.reg_tcg()}_base,
+                                 {self.reg_tcg()}_off);
+            """))
+    def helper_hlx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /*
+             * {self.reg_tcg()} is
+             * *(HLXVectorPair *)({self.helper_arg_name()})
+             */
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
+class LRegPairReadWrite(Hlx, Register, Pair, ReadWrite):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            const intptr_t {self.hlx_off()} =
+                offsetof(CPUHexagonState, future_LRegs[{self.reg_num}]);
+            /* Use the .tmp value for each updated half. */
+            for (int i = 0; i < 2; i++) {{
+                if (test_bit({self.reg_num} + i, ctx->lregs_updated_tmp)) {{
+                    tcg_gen_gvec_mov(MO_64,
+                                     {self.hlx_off()} + i * sizeof(HLXVector),
+                                     offsetof(CPUHexagonState,
+                                              tmp_LRegs[{self.reg_num} + i]),
+                                     sizeof(HLXVector), sizeof(HLXVector));
+                }} else {{
+                    gen_helper_hlx_copy_live_to_future(tcg_env,
+                        tcg_constant_i32({self.reg_num} + i));
+                }}
+            }}
+        """))
+        if is_hlx_inline_tag(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()}_base = tcg_env;
+            """))
+        elif not skip_qemu_helper(tag):
+            f.write(code_fmt(f"""\
+                TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
+                tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hlx_off()});
+            """))
+    def gen_write(self, f, tag):
+        pass
+    def helper_hlx_desc(self, f):
+        f.write(code_fmt(f"""\
+            /*
+             * {self.reg_tcg()} is
+             * *(HLXVectorPair *)({self.helper_arg_name()})
+             */
+        """))
+    def analyze_read(self, f, regno):
+        pass
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_lreg_write_pair(ctx, {self.reg_num});
+        """))
+
 class GuestRegister(Register):
     def gen_check_impl(self, f, regno):
         if self.is_written():
@@ -1385,6 +1961,20 @@ def init_registers():
         QRegSource("Q", "v"),
         QRegReadWrite("Q", "x"),
 
+        # HLX regs
+        LRegDest("L", "d"),
+        LRegSource("L", "s"),
+        LRegSource("L", "u"),
+        LRegSource("L", "v"),
+        LRegSource("L", "w"),
+        LRegReadWrite("L", "x"),
+        LRegTmp("L", "y"),
+        LRegPairDest("L", "dd"),
+        LRegPairSource("L", "uu"),
+        LRegPairSource("L", "vv"),
+        LRegPairSource("L", "ss"),
+        LRegPairReadWrite("L", "xx"),
+
         # system regs
         GuestDest("G", "d"),
         GuestSource("G", "s"),
@@ -1405,12 +1995,13 @@ def init_registers():
         PredNewSource("P", "u"),
         PredNewSource("P", "v"),
         VRegNewSource("O", "s"),
+        LRegNewSource("K", "u"),
     }
     for reg in new_regs:
         new_registers[f"{reg.regtype}{reg.regid}"] = reg
 
 def is_new_reg(tag, regid):
-    if regid[0] in "NO":
+    if regid[0] in "NOK":
         return True
     return regid[0] == "P" and \
            f"{regid}N" in semdict[tag] and \
@@ -1457,19 +2048,22 @@ def helper_args(tag, regs, imms):
     if is_predicated(tag):
         for regtype, regid in regs:
             reg = get_register(tag, regtype, regid)
-            if reg.is_writeonly() and not reg.is_hvx_reg():
+            is_vector = reg.is_hvx_reg() or reg.is_hlx_reg()
+            if reg.is_writeonly() and not is_vector:
                 args.append(reg.helper_arg())
 
     ## Pass the HVX destination registers
     for regtype, regid in regs:
         reg = get_register(tag, regtype, regid)
-        if reg.is_written() and reg.is_hvx_reg():
+        if reg.is_written() and (reg.is_hvx_reg() or reg.is_hlx_reg()):
             args.append(reg.helper_arg())
 
     ## Pass the source registers
     for regtype, regid in regs:
         reg = get_register(tag, regtype, regid)
-        if reg.is_read() and not (reg.is_hvx_reg() and reg.is_readwrite()):
+        is_vector_readwrite = ((reg.is_hvx_reg() or reg.is_hlx_reg()) and
+                               reg.is_readwrite())
+        if reg.is_read() and not is_vector_readwrite:
             args.append(reg.helper_arg())
 
     ## Pass the immediates
-- 
2.43.0


