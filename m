Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C2ECA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6xW-0001wF-GJ; Fri, 12 Sep 2025 12:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xO-0001m0-9G; Fri, 12 Sep 2025 12:49:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xJ-0008Ju-5u; Fri, 12 Sep 2025 12:49:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEPKJo029387;
 Fri, 12 Sep 2025 16:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tJeRu9Z1FY40oG6lU
 NYs/4y/7Rh9urI2TsD8bM0JuI0=; b=rkjzBXPkAEWwsx6ott7GkXm3UWnUQYmqf
 2ZAPVy6PDUyqZ1x8JF5rcsw+0rL1Gja1wBOvBmyuFmgZ1UVjQgYkcuP0qOwK1T1O
 uWV/YP57ZmqhOvyHAergOKpaXifeAYwaP9RdHwpY4gxRUMNl0gBsFIAvGUhsLtVj
 LdH6/e2po+BgC3lBbTQUT+XpD+MNWi2CdF4RTjtri3MKLz6jtIebrNzjh04WMKND
 f2xdatar4thd3U6A9WSZZO7K1O9m5Lvn/5s07gxy7Hz68RazaG+3lFoKy2pDhyZR
 kfkxkbXdP87aBL3peiEhTeIXTYYtPuSgWeo1Myl1SUEZQf6hzZPjg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffvsaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CGmvsd018830;
 Fri, 12 Sep 2025 16:48:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffvsab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CDnDmv020695;
 Fri, 12 Sep 2025 16:48:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp1c2eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58CGmsEL27263518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 16:48:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A7EE58064;
 Fri, 12 Sep 2025 16:48:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14A885805A;
 Fri, 12 Sep 2025 16:48:54 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Sep 2025 16:48:54 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
Date: Fri, 12 Sep 2025 11:47:34 -0500
Message-ID: <20250912164808.371944-7-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912164808.371944-1-milesg@linux.ibm.com>
References: <20250912164808.371944-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cWA9EJhVh82WbMsdhTbs_iX1TPe66rw2
X-Proofpoint-GUID: SnjmZQNv6hZmcrA3lB5J9IOIV1jAQj1z
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c44ef9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=jRLB2SoPAAAA:8 a=VnNF1IyMAAAA:8
 a=pXgVCJyPgkniI-CB58UA:9 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX6fcxw7OHbfdb
 CMgzx2aH1iIyjDxuWyPRxwJKKDL6lqGLK/ynZCgJ5yuyelBGy4xKbedjaikjfUZWzcHx/9ZKFQT
 ffDK3WdUwhLXzZmmhY1CMATxGsQ8M0mkMVL1cbcrHd3C8xnaMrgKC6GoIhcuQeElN8PCT+YFrOo
 26roChKPxtbYeYz5/vF65Z8mAO9f6qwOpXl9AyAiFAhEVatN9Q/4+1cPdRvkb6J48tr5xc2GjuV
 SldemzhLM+ZYXafTbRVL2JoKc5uKdJQPqQCu9M76gOHO+q8KL6JTT/BtY/0bcGGXTZ+MFAd8Hw/
 BIgCFAfIHXgpqK4oHJF7nyN9DDZmFa2ciM+iY6PgWht2f0hj2PF/zYEuj22Z69IKGRRU0VwniXf
 zoEsIrzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds the following instructions exclusively for
IBM PPE42 processors:

  LSKU
  LCXU
  STSKU
  STCXU
  LVD
  LVDU
  LVDX
  STVD
  STVDU
  STVDX
  SLVD
  SRVD
  CMPWBC
  CMPLWBC
  CMPWIBC
  BNBWI
  BNBW
  CLRBWIBC
  CLRWBC
  DCBQ
  RLDICL
  RLDICR
  RLDIMI

A PPE42 GCC compiler is available here:
https://github.com/open-power/ppe42-gcc

For more information on the PPE42 processors please visit:
https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
Changes from v3:
  - Removed copy of CHECK_VDR
  - Refactored ld/st instructions

 target/ppc/insn32.decode            |  66 ++-
 target/ppc/translate.c              |  29 +-
 target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
 3 files changed, 750 insertions(+), 10 deletions(-)
 create mode 100644 target/ppc/translate/ppe-impl.c.inc

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e53fd2840d..8beb588a2a 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -58,6 +58,10 @@
 %ds_rtp         22:4   !function=times_2
 @DS_rtp         ...... ....0 ra:5 .............. ..             &D rt=%ds_rtp si=%ds_si
 
+%dd_si          3:s13
+&DD             rt ra si:int64_t
+@DD             ...... rt:5 ra:5 ............. . ..             &DD si=%dd_si
+
 &DX_b           vrt b
 %dx_b           6:10 16:5 0:1
 @DX_b           ...... vrt:5  ..... .......... ..... .          &DX_b b=%dx_b
@@ -66,6 +70,11 @@
 %dx_d           6:s10 16:5 0:1
 @DX             ...... rt:5  ..... .......... ..... .           &DX d=%dx_d
 
+%md_sh          1:1 11:5
+%md_mb          5:1 6:5
+&MD             rs ra sh mb rc
+@MD             ...... rs:5 ra:5 ..... ...... ... . rc:1        &MD sh=%md_sh mb=%md_mb
+
 &VA             vrt vra vrb rc
 @VA             ...... vrt:5 vra:5 vrb:5 rc:5 ......            &VA
 
@@ -322,6 +331,13 @@ LDUX            011111 ..... ..... ..... 0000110101 -   @X
 
 LQ              111000 ..... ..... ............ ----    @DQ_rtp
 
+LVD             000101 ..... ..... ................     @D
+LVDU            001001 ..... ..... ................     @D
+LVDX            011111 ..... ..... ..... 0000010001 -   @X
+LSKU            111010 ..... ..... ............. 0 11   @DD
+LCXU            111010 ..... ..... ............. 1 11   @DD
+
+
 ### Fixed-Point Store Instructions
 
 STB             100110 ..... ..... ................     @D
@@ -346,6 +362,11 @@ STDUX           011111 ..... ..... ..... 0010110101 -   @X
 
 STQ             111110 ..... ..... ..............10     @DS_rtp
 
+STVDU           010110 ..... ..... ................     @D
+STVDX           011111 ..... ..... ..... 0010010001 -   @X
+STSKU           111110 ..... ..... ............. 0 11   @DD
+STCXU           111110 ..... ..... ............. 1 11   @DD
+
 ### Fixed-Point Compare Instructions
 
 CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
@@ -461,8 +482,14 @@ PRTYD           011111 ..... ..... ----- 0010111010 -   @X_sa
 
 BPERMD          011111 ..... ..... ..... 0011111100 -   @X
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
-CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
-CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
+{
+  SLVD            011111 ..... ..... ..... 0000111011 .   @X_rc
+  CNTLZDM         011111 ..... ..... ..... 0000111011 -   @X
+}
+{
+  SRVD            011111 ..... ..... ..... 1000111011 .   @X_rc
+  CNTTZDM         011111 ..... ..... ..... 1000111011 -   @X
+}
 PDEPD           011111 ..... ..... ..... 0010011100 -   @X
 PEXTD           011111 ..... ..... ..... 0010111100 -   @X
 
@@ -981,8 +1008,16 @@ LXSSP           111001 ..... ..... .............. 11    @DS
 STXSSP          111101 ..... ..... .............. 11    @DS
 LXV             111101 ..... ..... ............ . 001   @DQ_TSX
 STXV            111101 ..... ..... ............ . 101   @DQ_TSX
-LXVP            000110 ..... ..... ............ 0000    @DQ_TSXP
-STXVP           000110 ..... ..... ............ 0001    @DQ_TSXP
+
+# STVD PPE instruction overlaps with the LXVP and STXVP instructions
+{
+  STVD          000110 ..... ..... ................     @D
+  [
+    LXVP        000110 ..... ..... ............ 0000    @DQ_TSXP
+    STXVP       000110 ..... ..... ............ 0001    @DQ_TSXP
+  ]
+}
+
 LXVX            011111 ..... ..... ..... 0100 - 01100 . @X_TSX
 STXVX           011111 ..... ..... ..... 0110001100 .   @X_TSX
 LXVPX           011111 ..... ..... ..... 0101001101 -   @X_TSXP
@@ -1300,3 +1335,26 @@ CLRBHRB         011111 ----- ----- ----- 0110101110 -
 ## Misc POWER instructions
 
 ATTN            000000 00000 00000 00000 0100000000 0
+
+# Fused compare-branch instructions for PPE only
+%fcb_bdx        1:s10  !function=times_4
+&FCB            px:bool ra rb:uint64_t bdx lk:bool
+@FCB            ...... .. px:1 .. ra:5 rb:5 .......... lk:1       &FCB bdx=%fcb_bdx
+&FCB_bix        px:bool bix ra rb:uint64_t bdx lk:bool
+@FCB_bix        ...... .. px:1 bix:2 ra:5 rb:5 .......... lk:1    &FCB_bix bdx=%fcb_bdx
+
+CMPWBC          000001 00 . .. ..... ..... .......... .     @FCB_bix
+CMPLWBC         000001 01 . .. ..... ..... .......... .     @FCB_bix
+CMPWIBC         000001 10 . .. ..... ..... .......... .     @FCB_bix
+BNBWI           000001 11 . 00 ..... ..... .......... .     @FCB
+BNBW            000001 11 . 01 ..... ..... .......... .     @FCB
+CLRBWIBC        000001 11 . 10 ..... ..... .......... .     @FCB
+CLRBWBC         000001 11 . 11 ..... ..... .......... .     @FCB
+
+# Data Cache Block Query for PPE only
+DCBQ            011111 ..... ..... ..... 0110010110 -       @X
+
+# Rotate Doubleword Instructions for PPE only (if TARGET_PPC64 not defined)
+RLDICL          011110 ..... ..... ..... ...... 000 . .     @MD
+RLDICR          011110 ..... ..... ..... ...... 001 . .     @MD
+RLDIMI          011110 ..... ..... ..... ...... 011 . .     @MD
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fc817dab54..d422789a1d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -209,6 +209,11 @@ struct DisasContext {
 #define DISAS_CHAIN        DISAS_TARGET_2  /* lookup next tb, pc updated */
 #define DISAS_CHAIN_UPDATE DISAS_TARGET_3  /* lookup next tb, pc stale */
 
+static inline bool is_ppe(const DisasContext *ctx)
+{
+    return !!(ctx->flags & POWERPC_FLAG_PPE42);
+}
+
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
@@ -556,11 +561,8 @@ void spr_access_nop(DisasContext *ctx, int sprn, int gprn)
 
 #endif
 
-/* SPR common to all PowerPC */
-/* XER */
-void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
+static void gen_get_xer(DisasContext *ctx, TCGv dst)
 {
-    TCGv dst = cpu_gpr[gprn];
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
     TCGv t2 = tcg_temp_new();
@@ -579,9 +581,16 @@ void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
     }
 }
 
-void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
+/* SPR common to all PowerPC */
+/* XER */
+void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
+{
+    TCGv dst = cpu_gpr[gprn];
+    gen_get_xer(ctx, dst);
+}
+
+static void gen_set_xer(DisasContext *ctx, TCGv src)
 {
-    TCGv src = cpu_gpr[gprn];
     /* Write all flags, while reading back check for isa300 */
     tcg_gen_andi_tl(cpu_xer, src,
                     ~((1u << XER_SO) |
@@ -594,6 +603,12 @@ void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
     tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
 }
 
+void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
+{
+    TCGv src = cpu_gpr[gprn];
+    gen_set_xer(ctx, src);
+}
+
 /* LR */
 void spr_read_lr(DisasContext *ctx, int gprn, int sprn)
 {
@@ -5755,6 +5770,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/bhrb-impl.c.inc"
 
+#include "translate/ppe-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
new file mode 100644
index 0000000000..792103d7c2
--- /dev/null
+++ b/target/ppc/translate/ppe-impl.c.inc
@@ -0,0 +1,665 @@
+/*
+ * IBM PPE Instructions
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#if !defined(TARGET_PPC64)
+static bool vdr_is_valid(uint32_t vdr)
+{
+    const uint32_t valid_bitmap = 0xf00003ff;
+    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
+}
+
+static bool ppe_gpr_is_valid(uint32_t reg)
+{
+    const uint32_t valid_bitmap = 0xf00027ff;
+    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
+}
+#endif
+
+#define CHECK_VDR(CTX, VDR)                             \
+    do {                                                \
+        if (unlikely(!vdr_is_valid(VDR))) {             \
+            gen_invalid(CTX);                           \
+            return true;                                \
+        }                                               \
+    } while (0)
+
+#define CHECK_PPE_GPR(CTX, REG)                         \
+    do {                                                \
+        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
+            gen_invalid(CTX);                           \
+            return true;                                \
+        }                                               \
+    } while (0)
+
+#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
+
+#define CHECK_PPE_LEVEL(CTX, LVL)                       \
+    do {                                                \
+        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
+            gen_invalid(CTX);                           \
+            return true;                                \
+        }                                               \
+    } while (0)
+
+static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    int i;
+    TCGv base, EA;
+    TCGv lo, hi;
+    TCGv_i64 t8;
+    const uint8_t vd_list[] = {9, 7, 5, 3, 0};
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_PPE_GPR(ctx, a->rt);
+
+    if (unlikely((a->rt != a->ra) || (a->ra == 0) || (a->si < 0xB))) {
+        gen_invalid(ctx);
+        return true;
+    }
+
+    EA = tcg_temp_new();
+    base = tcg_temp_new();
+
+    tcg_gen_addi_tl(base, cpu_gpr[a->ra], a->si * 8);
+    gen_store_spr(SPR_PPE42_EDR, base);
+
+    t8 = tcg_temp_new_i64();
+
+    tcg_gen_addi_tl(EA, base, -8);
+    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    tcg_gen_extr_i64_tl(cpu_gpr[31], cpu_gpr[30], t8);
+
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    tcg_gen_extr_i64_tl(cpu_gpr[29], cpu_gpr[28], t8);
+
+    lo = tcg_temp_new();
+    hi = tcg_temp_new();
+
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    tcg_gen_extr_i64_tl(lo, hi, t8);
+    gen_store_spr(SPR_SRR0, hi);
+    gen_store_spr(SPR_SRR1, lo);
+
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    tcg_gen_extr_i64_tl(lo, hi, t8);
+    gen_set_xer(ctx, hi);
+    tcg_gen_mov_tl(cpu_ctr, lo);
+
+    for (i = 0; i < sizeof(vd_list); i++) {
+        int vd = vd_list[i];
+        tcg_gen_addi_tl(EA, EA, -8);
+        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+        tcg_gen_extr_i64_tl(cpu_gpr[VDR_PAIR_REG(vd)], cpu_gpr[vd], t8);
+    }
+
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    tcg_gen_extr_i64_tl(lo, hi, t8);
+    tcg_gen_shri_tl(hi, hi, 28);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], hi);
+    gen_store_spr(SPR_SPRG0, lo);
+
+    tcg_gen_addi_tl(EA, base, 4);
+    tcg_gen_qemu_ld_tl(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
+    tcg_gen_mov_tl(cpu_gpr[a->ra], base);
+    return true;
+#endif
+}
+
+static bool trans_LSKU(DisasContext *ctx, arg_LSKU *a)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    int64_t n;
+    TCGv base, EA;
+    TCGv_i32 lo, hi;
+    TCGv_i64 t8;
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_PPE_GPR(ctx, a->rt);
+
+    if (unlikely((a->rt != a->ra) || (a->ra == 0) ||
+                 (a->si & PPC_BIT(0)) || (a->si == 0))) {
+        gen_invalid(ctx);
+        return true;
+    }
+
+    EA = tcg_temp_new();
+    base = tcg_temp_new();
+    gen_addr_register(ctx, base);
+
+
+    tcg_gen_addi_tl(base, base, a->si * 8);
+    gen_store_spr(SPR_PPE42_EDR, base);
+
+    n = a->si - 1;
+    t8 = tcg_temp_new_i64();
+    if (n > 0) {
+        tcg_gen_addi_tl(EA, base, -8);
+        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+        hi = cpu_gpr[30];
+        lo = cpu_gpr[31];
+        tcg_gen_extr_i64_i32(lo, hi, t8);
+    }
+    if (n > 1) {
+        tcg_gen_addi_tl(EA, base, -16);
+        tcg_gen_qemu_ld_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+        hi = cpu_gpr[28];
+        lo = cpu_gpr[29];
+        tcg_gen_extr_i64_i32(lo, hi, t8);
+    }
+    tcg_gen_addi_tl(EA, base, 4);
+    tcg_gen_qemu_ld_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
+    tcg_gen_mov_tl(cpu_gpr[a->ra], base);
+    return true;
+#endif
+}
+
+static bool trans_STCXU(DisasContext *ctx, arg_STCXU *a)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    TCGv EA;
+    TCGv lo, hi;
+    TCGv_i64 t8;
+    int i;
+    const uint8_t vd_list[] = {9, 7, 5, 3, 0};
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_PPE_GPR(ctx, a->rt);
+
+    if (unlikely((a->rt != a->ra) || (a->ra == 0) || !(a->si & PPC_BIT(0)))) {
+        gen_invalid(ctx);
+        return true;
+    }
+
+    EA = tcg_temp_new();
+    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], 4);
+    tcg_gen_qemu_st_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
+
+    gen_store_spr(SPR_PPE42_EDR, cpu_gpr[a->ra]);
+
+    t8 = tcg_temp_new_i64();
+
+    tcg_gen_concat_tl_i64(t8, cpu_gpr[31], cpu_gpr[30]);
+    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], -8);
+    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+
+    tcg_gen_concat_tl_i64(t8, cpu_gpr[29], cpu_gpr[28]);
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+
+    lo = tcg_temp_new();
+    hi = tcg_temp_new();
+
+    gen_load_spr(hi, SPR_SRR0);
+    gen_load_spr(lo, SPR_SRR1);
+    tcg_gen_concat_tl_i64(t8, lo, hi);
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+
+    gen_get_xer(ctx, hi);
+    tcg_gen_mov_tl(lo, cpu_ctr);
+    tcg_gen_concat_tl_i64(t8, lo, hi);
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+
+    for (i = 0; i < sizeof(vd_list); i++) {
+        int vd = vd_list[i];
+        tcg_gen_concat_tl_i64(t8, cpu_gpr[VDR_PAIR_REG(vd)], cpu_gpr[vd]);
+        tcg_gen_addi_tl(EA, EA, -8);
+        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    }
+
+    gen_load_spr(lo, SPR_SPRG0);
+    tcg_gen_extu_i32_tl(hi, cpu_crf[0]);
+    tcg_gen_shli_tl(hi, hi, 28);
+    tcg_gen_concat_tl_i64(t8, lo, hi);
+    tcg_gen_addi_tl(EA, EA, -8);
+    tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+
+    tcg_gen_addi_tl(EA, cpu_gpr[a->ra], a->si * 8);
+    tcg_gen_qemu_st_i32(cpu_gpr[a->rt], EA, ctx->mem_idx, DEF_MEMOP(MO_32) |
+                                                          MO_ALIGN);
+    tcg_gen_mov_tl(cpu_gpr[a->ra], EA);
+    return true;
+#endif
+}
+
+static bool trans_STSKU(DisasContext *ctx, arg_STSKU *a)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    int64_t n;
+    TCGv base, EA;
+    TCGv_i32 lo, hi;
+    TCGv_i64 t8;
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_PPE_GPR(ctx, a->rt);
+
+    if (unlikely((a->rt != a->ra) || (a->ra == 0) || !(a->si & PPC_BIT(0)))) {
+        gen_invalid(ctx);
+        return true;
+    }
+
+    EA = tcg_temp_new();
+    base = tcg_temp_new();
+    gen_addr_register(ctx, base);
+    tcg_gen_addi_tl(EA, base, 4);
+    tcg_gen_qemu_st_i32(cpu_lr, EA, ctx->mem_idx, DEF_MEMOP(MO_32) | MO_ALIGN);
+
+    gen_store_spr(SPR_PPE42_EDR, base);
+
+    n = ~(a->si);
+
+    t8 = tcg_temp_new_i64();
+    if (n > 0) {
+        hi = cpu_gpr[30];
+        lo = cpu_gpr[31];
+        tcg_gen_concat_i32_i64(t8, lo, hi);
+        tcg_gen_addi_tl(EA, base, -8);
+        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    }
+    if (n > 1) {
+        hi = cpu_gpr[28];
+        lo = cpu_gpr[29];
+        tcg_gen_concat_i32_i64(t8, lo, hi);
+        tcg_gen_addi_tl(EA, base, -16);
+        tcg_gen_qemu_st_i64(t8, EA, ctx->mem_idx, DEF_MEMOP(MO_64) | MO_ALIGN);
+    }
+
+    tcg_gen_addi_tl(EA, base, a->si * 8);
+    tcg_gen_qemu_st_i32(cpu_gpr[a->rt], EA, ctx->mem_idx, DEF_MEMOP(MO_32) |
+                                                          MO_ALIGN);
+    tcg_gen_mov_tl(cpu_gpr[a->ra], EA);
+    return true;
+#endif
+}
+
+#if !defined(TARGET_PPC64)
+static bool do_ppe_ldst(DisasContext *ctx, int rt, int ra, TCGv disp,
+                        bool update, bool store)
+{
+    TCGv ea;
+    int rt_lo;
+    TCGv_i64 t8;
+
+    CHECK_VDR(ctx, rt);
+    CHECK_PPE_GPR(ctx, ra);
+    rt_lo = VDR_PAIR_REG(rt);
+    if (update && (ra == 0 || (!store && ((ra == rt) || (ra == rt_lo))))) {
+        gen_invalid(ctx);
+        return true;
+    }
+    gen_set_access_type(ctx, ACCESS_INT);
+
+    ea = do_ea_calc(ctx, ra, disp);
+    t8 = tcg_temp_new_i64();
+    if (store) {
+        tcg_gen_concat_i32_i64(t8, cpu_gpr[rt_lo], cpu_gpr[rt]);
+        tcg_gen_qemu_st_i64(t8, ea, ctx->mem_idx, DEF_MEMOP(MO_64));
+    } else {
+        tcg_gen_qemu_ld_i64(t8, ea, ctx->mem_idx, DEF_MEMOP(MO_64));
+        tcg_gen_extr_i64_i32(cpu_gpr[rt_lo], cpu_gpr[rt], t8);
+    }
+    if (update) {
+        tcg_gen_mov_tl(cpu_gpr[ra], ea);
+    }
+    return true;
+}
+#endif
+
+static bool do_ppe_ldst_D(DisasContext *ctx, arg_D *a, bool update, bool store)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    /* Some PowerPC CPU's have a different meaning for the STVD instruction */
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    return do_ppe_ldst(ctx, a->rt, a->ra, tcg_constant_tl(a->si), update,
+                       store);
+#endif
+}
+
+static bool do_ppe_ldst_X(DisasContext *ctx, arg_X *a, bool store)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    CHECK_PPE_GPR(ctx, a->rb);
+    return do_ppe_ldst(ctx, a->rt, a->ra, cpu_gpr[a->rb], false, store);
+#endif
+}
+
+TRANS(LVD,   do_ppe_ldst_D, false, false)
+TRANS(LVDU,  do_ppe_ldst_D, true,  false)
+TRANS(STVD,  do_ppe_ldst_D, false, true)
+TRANS(STVDU, do_ppe_ldst_D, true,  true)
+TRANS(LVDX,  do_ppe_ldst_X, false)
+TRANS(STVDX, do_ppe_ldst_X, true)
+
+
+#if !defined(TARGET_PPC64)
+static bool do_fcb(DisasContext *ctx, TCGv ra_val, TCGv rb_val, int bix,
+                          int32_t bdx, bool s, bool px, bool lk)
+{
+    TCGCond cond;
+    uint32_t mask;
+    TCGLabel *no_branch;
+    target_ulong dest;
+
+    /* Update CR0 */
+    gen_op_cmp32(ra_val, rb_val, s, 0);
+
+    if (lk) {
+        gen_setlr(ctx, ctx->base.pc_next);
+    }
+
+
+    mask = PPC_BIT32(28 + bix);
+    cond = (px) ? TCG_COND_TSTEQ : TCG_COND_TSTNE;
+    no_branch = gen_new_label();
+    dest = ctx->cia + bdx;
+
+    /* Do the branch if CR0[bix] == PX */
+    tcg_gen_brcondi_i32(cond, cpu_crf[0], mask, no_branch);
+    gen_goto_tb(ctx, 0, dest);
+    gen_set_label(no_branch);
+    gen_goto_tb(ctx, 1, ctx->base.pc_next);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+#endif
+
+static bool do_cmp_branch(DisasContext *ctx, arg_FCB_bix *a, bool s,
+                          bool rb_is_gpr)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    TCGv old_ra;
+    TCGv rb_val;
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    CHECK_PPE_GPR(ctx, a->ra);
+    if (rb_is_gpr) {
+        CHECK_PPE_GPR(ctx, a->rb);
+        rb_val = cpu_gpr[a->rb];
+    } else {
+        rb_val = tcg_constant_tl(a->rb);
+    }
+    if (a->bix == 3) {
+        old_ra = tcg_temp_new();
+        tcg_gen_mov_tl(old_ra, cpu_gpr[a->ra]);
+        tcg_gen_sub_tl(cpu_gpr[a->ra], cpu_gpr[a->ra], rb_val);
+        return do_fcb(ctx, old_ra, rb_val, 2,
+                      a->bdx, s, a->px, a->lk);
+    } else {
+        return do_fcb(ctx, cpu_gpr[a->ra], rb_val, a->bix,
+                      a->bdx, s, a->px, a->lk);
+    }
+#endif
+}
+
+TRANS(CMPWBC, do_cmp_branch, true, true)
+TRANS(CMPLWBC, do_cmp_branch, false, true)
+TRANS(CMPWIBC, do_cmp_branch, true, false)
+
+static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
+                           bool update, bool rb_is_gpr)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    TCGv r;
+    TCGv mask, shift;
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    CHECK_PPE_GPR(ctx, a->ra);
+    if (rb_is_gpr) {
+        CHECK_PPE_GPR(ctx, a->rb);
+        mask = tcg_temp_new();
+        shift = tcg_temp_new();
+        tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
+        tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
+    } else {
+        mask = tcg_constant_tl(PPC_BIT32(a->rb));
+    }
+    if (invert) {
+        tcg_gen_not_tl(mask, mask);
+    }
+
+    /* apply mask to ra */
+    r = tcg_temp_new();
+    tcg_gen_and_tl(r, cpu_gpr[a->ra], mask);
+    if (update) {
+        tcg_gen_mov_tl(cpu_gpr[a->ra], r);
+    }
+    return do_fcb(ctx, r, tcg_constant_tl(0), 2,
+                  a->bdx, false, a->px, a->lk);
+#endif
+}
+
+TRANS(BNBWI,    do_mask_branch, false, false, false)
+TRANS(BNBW,     do_mask_branch, false, false, true)
+TRANS(CLRBWIBC, do_mask_branch, true,  true,  false)
+TRANS(CLRBWBC,  do_mask_branch, true,  true,  true)
+
+#if !defined(TARGET_PPC64)
+static void gen_set_Rc0_i64(DisasContext *ctx, TCGv_i64 reg)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_movi_i64(t0, CRF_EQ);
+    tcg_gen_movi_i64(t1, CRF_LT);
+    tcg_gen_movcond_i64(TCG_COND_LT, t0, reg, tcg_constant_i64(0), t1, t0);
+    tcg_gen_movi_i64(t1, CRF_GT);
+    tcg_gen_movcond_i64(TCG_COND_GT, t0, reg, tcg_constant_i64(0), t1, t0);
+    tcg_gen_extrl_i64_i32(t, t0);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    tcg_gen_or_i32(cpu_crf[0], cpu_crf[0], t);
+}
+#endif
+
+static bool do_shift64(DisasContext *ctx, arg_X_rc *a, bool left)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    int rt_lo, ra_lo;
+    TCGv_i64 t0, t8;
+
+    /* Check for PPE since opcode overlaps with CNTTZDM instruction */
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_VDR(ctx, a->rt);
+    CHECK_VDR(ctx, a->ra);
+    CHECK_PPE_GPR(ctx, a->rb);
+    rt_lo = VDR_PAIR_REG(a->rt);
+    ra_lo = VDR_PAIR_REG(a->ra);
+    t8 = tcg_temp_new_i64();
+
+    /* AND rt with a mask that is 0 when rb >= 0x40 */
+    t0 = tcg_temp_new_i64();
+    tcg_gen_extu_tl_i64(t0, cpu_gpr[a->rb]);
+    tcg_gen_shli_i64(t0, t0, 0x39);
+    tcg_gen_sari_i64(t0, t0, 0x3f);
+
+    /* form 64bit value from two 32bit regs */
+    tcg_gen_concat_tl_i64(t8, cpu_gpr[rt_lo], cpu_gpr[a->rt]);
+
+    /* apply mask */
+    tcg_gen_andc_i64(t8, t8, t0);
+
+    /* do the shift */
+    tcg_gen_extu_tl_i64(t0, cpu_gpr[a->rb]);
+    tcg_gen_andi_i64(t0, t0, 0x3f);
+    if (left) {
+        tcg_gen_shl_i64(t8, t8, t0);
+    } else {
+        tcg_gen_shr_i64(t8, t8, t0);
+    }
+
+    /* split the 64bit word back into two 32bit regs */
+    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t8);
+
+    /* update CR0 if requested */
+    if (unlikely(a->rc != 0)) {
+        gen_set_Rc0_i64(ctx, t8);
+    }
+    return true;
+#endif
+}
+
+TRANS(SRVD, do_shift64, false)
+TRANS(SLVD, do_shift64, true)
+
+static bool trans_DCBQ(DisasContext *ctx, arg_DCBQ * a)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+
+    CHECK_PPE_GPR(ctx, a->rt);
+    CHECK_PPE_GPR(ctx, a->ra);
+    CHECK_PPE_GPR(ctx, a->rb);
+
+    /* No cache exists, so just set RT to 0 */
+    tcg_gen_movi_tl(cpu_gpr[a->rt], 0);
+    return true;
+#endif
+}
+
+static bool trans_RLDIMI(DisasContext *ctx, arg_RLDIMI *a)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    TCGv_i64 t_rs, t_ra;
+    int ra_lo, rs_lo;
+    uint32_t sh = a->sh;
+    uint32_t mb = a->mb;
+    uint32_t me = 63 - sh;
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_VDR(ctx, a->rs);
+    CHECK_VDR(ctx, a->ra);
+
+    rs_lo = VDR_PAIR_REG(a->rs);
+    ra_lo = VDR_PAIR_REG(a->ra);
+
+    t_rs = tcg_temp_new_i64();
+    t_ra = tcg_temp_new_i64();
+
+    tcg_gen_concat_tl_i64(t_rs, cpu_gpr[rs_lo], cpu_gpr[a->rs]);
+    tcg_gen_concat_tl_i64(t_ra, cpu_gpr[ra_lo], cpu_gpr[a->ra]);
+
+    if (mb <= me) {
+        tcg_gen_deposit_i64(t_ra, t_ra, t_rs, sh, me - mb + 1);
+    } else {
+        uint64_t mask = mask_u64(mb, me);
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        tcg_gen_rotli_i64(t1, t_rs, sh);
+        tcg_gen_andi_i64(t1, t1, mask);
+        tcg_gen_andi_i64(t_ra, t_ra, ~mask);
+        tcg_gen_or_i64(t_ra, t_ra, t1);
+    }
+
+    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t_ra);
+
+    if (unlikely(a->rc != 0)) {
+        gen_set_Rc0_i64(ctx, t_ra);
+    }
+    return true;
+#endif
+}
+
+
+static bool gen_rldinm_i64(DisasContext *ctx, arg_MD *a, int mb, int me, int sh)
+{
+#if defined(TARGET_PPC64)
+    return false;
+#else
+    int len = me - mb + 1;
+    int rsh = (64 - sh) & 63;
+    int ra_lo, rs_lo;
+    TCGv_i64 t8;
+
+    if (unlikely(!is_ppe(ctx))) {
+        return false;
+    }
+    CHECK_PPE_LEVEL(ctx, PPC2_PPE42X);
+    CHECK_VDR(ctx, a->rs);
+    CHECK_VDR(ctx, a->ra);
+
+    rs_lo = VDR_PAIR_REG(a->rs);
+    ra_lo = VDR_PAIR_REG(a->ra);
+    t8 = tcg_temp_new_i64();
+    tcg_gen_concat_tl_i64(t8, cpu_gpr[rs_lo], cpu_gpr[a->rs]);
+    if (sh != 0 && len > 0 && me == (63 - sh)) {
+        tcg_gen_deposit_z_i64(t8, t8, sh, len);
+    } else if (me == 63 && rsh + len <= 64) {
+        tcg_gen_extract_i64(t8, t8, rsh, len);
+    } else {
+        tcg_gen_rotli_i64(t8, t8, sh);
+        tcg_gen_andi_i64(t8, t8, mask_u64(mb, me));
+    }
+    tcg_gen_extr_i64_tl(cpu_gpr[ra_lo], cpu_gpr[a->ra], t8);
+    if (unlikely(a->rc != 0)) {
+        gen_set_Rc0_i64(ctx, t8);
+    }
+    return true;
+#endif
+}
+
+TRANS(RLDICL, gen_rldinm_i64, a->mb, 63, a->sh)
+TRANS(RLDICR, gen_rldinm_i64, 0, a->mb, a->sh)
+
-- 
2.43.0


