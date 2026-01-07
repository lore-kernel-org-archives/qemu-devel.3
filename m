Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7340CCE9D48
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJu-0003yr-DI; Wed, 07 Jan 2026 07:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJk-0003uY-9g
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJf-0002AG-Hc
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zm7/n0rPmkpRCGgN2m0dJRgkqYqWI8enuEWxkAw+iPQ=;
 b=jFQOq7AUe8BOX+VAKhf9Bjx4lvieK2ycZnxfucucTTrILLNZvkjfUrcRhDqc0U3fms34QG
 zAN0rmk8kTw9YoC2TX2oRg/Noy9nvpfG2QqXh/zGObP9ZArFzizxZfvRVF+mc730qJnc1V
 lZspe8V68++Nk5A62ZH4vLrcpJeWi48=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-TgfzqGSeOTWGBcD4iiHyNA-1; Wed,
 07 Jan 2026 07:06:57 -0500
X-MC-Unique: TgfzqGSeOTWGBcD4iiHyNA-1
X-Mimecast-MFC-AGG-ID: TgfzqGSeOTWGBcD4iiHyNA_1767787616
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0487E1956054; Wed,  7 Jan 2026 12:06:56 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BDE21956053; Wed,  7 Jan 2026 12:06:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 09/14] target/s390x: Replace MO_TE -> MO_BE
Date: Wed,  7 Jan 2026 13:06:33 +0100
Message-ID: <20260107120638.56735-10-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We only build the S390x target using big endianness order,
therefore the MO_TE definitions expand to the big endian
one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_BE/ \
        $(git grep -wl MO_TE target/s390x/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162036.90404-5-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/insn-data.h.inc    |  54 +++++------
 target/s390x/tcg/mem_helper.c       |   8 +-
 target/s390x/tcg/translate.c        | 138 ++++++++++++++--------------
 target/s390x/tcg/translate_vx.c.inc |  38 ++++----
 4 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index ec730ee0919..baaafe922e9 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -42,10 +42,10 @@
     C(0xb9d8, AHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, add, adds32)
 /* ADD IMMEDIATE */
     C(0xc209, AFI,     RIL_a, EI,  r1, i2, new, r1_32, add, adds32)
-    D(0xeb6a, ASI,     SIY,   GIE, la1, i2, new, 0, asi, adds32, MO_TESL)
+    D(0xeb6a, ASI,     SIY,   GIE, la1, i2, new, 0, asi, adds32, MO_BESL)
     C(0xecd8, AHIK,    RIE_d, DO,  r3, i2, new, r1_32, add, adds32)
     C(0xc208, AGFI,    RIL_a, EI,  r1, i2, r1, 0, add, adds64)
-    D(0xeb7a, AGSI,    SIY,   GIE, la1, i2, new, 0, asi, adds64, MO_TEUQ)
+    D(0xeb7a, AGSI,    SIY,   GIE, la1, i2, new, 0, asi, adds64, MO_BEUQ)
     C(0xecd9, AGHIK,   RIE_d, DO,  r3, i2, r1, 0, add, adds64)
 /* ADD IMMEDIATE HIGH */
     C(0xcc08, AIH,     RIL_a, HW,  r1_sr32, i2, new, r1_32h, add, adds32)
@@ -74,9 +74,9 @@
     C(0xc20b, ALFI,    RIL_a, EI,  r1_32u, i2_32u, new, r1_32, add, addu32)
     C(0xc20a, ALGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, addu64, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE */
-    D(0xeb6e, ALSI,    SIY,   GIE, la1, i2_32u, new, 0, asi, addu32, MO_TEUL)
+    D(0xeb6e, ALSI,    SIY,   GIE, la1, i2_32u, new, 0, asi, addu32, MO_BEUL)
     C(0xecda, ALHSIK,  RIE_d, DO,  r3_32u, i2_32u, new, r1_32, add, addu32)
-    D(0xeb7e, ALGSI,   SIY,   GIE, la1, i2, new, 0, asiu64, addu64, MO_TEUQ)
+    D(0xeb7e, ALGSI,   SIY,   GIE, la1, i2, new, 0, asiu64, addu64, MO_BEUQ)
     C(0xecdb, ALGHSIK, RIE_d, DO,  r3, i2, r1, 0, addu64, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE HIGH */
     C(0xcc0a, ALSIH,   RIL_a, HW,  r1_sr32, i2_32u, new, r1_32h, add, addu32)
@@ -270,12 +270,12 @@
     D(0xec7d, CLGIJ,   RIE_c, GIE, r1_o, i2_8u, 0, 0, cj, 0, 1)
 
 /* COMPARE AND SWAP */
-    D(0xba00, CS,      RS_a,  Z,   r3_32u, r1_32u, new, r1_32, cs, 0, MO_TEUL)
-    D(0xeb14, CSY,     RSY_a, LD,  r3_32u, r1_32u, new, r1_32, cs, 0, MO_TEUL)
-    D(0xeb30, CSG,     RSY_a, Z,   r3_o, r1_o, new, r1, cs, 0, MO_TEUQ)
+    D(0xba00, CS,      RS_a,  Z,   r3_32u, r1_32u, new, r1_32, cs, 0, MO_BEUL)
+    D(0xeb14, CSY,     RSY_a, LD,  r3_32u, r1_32u, new, r1_32, cs, 0, MO_BEUL)
+    D(0xeb30, CSG,     RSY_a, Z,   r3_o, r1_o, new, r1, cs, 0, MO_BEUQ)
 /* COMPARE DOUBLE AND SWAP */
-    D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEUQ)
-    D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEUQ)
+    D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, MO_BEUQ)
+    D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, MO_BEUQ)
     C(0xeb3e, CDSG,    RSY_a, Z,   la2, r3_D64, 0, r1_D64, cdsg, 0)
 /* COMPARE AND SWAP AND STORE */
     C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)
@@ -443,20 +443,20 @@
 /* LOAD ADDRESS RELATIVE LONG */
     C(0xc000, LARL,    RIL_b, Z,   0, ri2, 0, r1, mov2, 0)
 /* LOAD AND ADD */
-    D(0xebf8, LAA,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, laa, adds32, MO_TESL)
-    D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_TEUQ)
+    D(0xebf8, LAA,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, laa, adds32, MO_BESL)
+    D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_BEUQ)
 /* LOAD AND ADD LOGICAL */
-    D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_TEUL)
-    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa_addu64, addu64, MO_TEUQ)
+    D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_BEUL)
+    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa_addu64, addu64, MO_BEUQ)
 /* LOAD AND AND */
-    D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_TESL)
-    D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_TEUQ)
+    D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_BESL)
+    D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_BEUQ)
 /* LOAD AND EXCLUSIVE OR */
-    D(0xebf7, LAX,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lax, nz32, MO_TESL)
-    D(0xebe7, LAXG,    RSY_a, ILA, r3, a2, new, in2_r1, lax, nz64, MO_TEUQ)
+    D(0xebf7, LAX,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lax, nz32, MO_BESL)
+    D(0xebe7, LAXG,    RSY_a, ILA, r3, a2, new, in2_r1, lax, nz64, MO_BEUQ)
 /* LOAD AND OR */
-    D(0xebf6, LAO,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lao, nz32, MO_TESL)
-    D(0xebe6, LAOG,    RSY_a, ILA, r3, a2, new, in2_r1, lao, nz64, MO_TEUQ)
+    D(0xebf6, LAO,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lao, nz32, MO_BESL)
+    D(0xebe6, LAOG,    RSY_a, ILA, r3, a2, new, in2_r1, lao, nz64, MO_BEUQ)
 /* LOAD AND TEST */
     C(0x1200, LTR,     RR_a,  Z,   0, r2_o, 0, cond_r1r2_32, mov2, s32)
     C(0xb902, LTGR,    RRE,   Z,   0, r2_o, 0, r1, mov2, s64)
@@ -572,8 +572,8 @@
     C(0xb9e0, LOCFHR,  RRF_c, LOC2, r1_sr32, r2_sr32, new, r1_32h, loc, 0)
     C(0xebe0, LOCFH,   RSY_b, LOC2, r1_sr32, m2_32u, new, r1_32h, loc, 0)
 /* LOAD PAIR DISJOINT */
-    D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
-    D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEUQ)
+    D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_BEUL)
+    D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_BEUQ)
 /* LOAD PAIR FROM QUADWORD */
     C(0xe38f, LPQ,     RXY_a, Z,   0, a2, 0, r1_D64, lpq, 0)
 /* LOAD POSITIVE */
@@ -1333,8 +1333,8 @@
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
-    E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL, IF_PRIV)
-    E(0xb98a, CSPG,    RRE, DAT_ENH, r1_o, ra2, r1_P, 0, csp, 0, MO_TEUQ, IF_PRIV)
+    E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_BEUL, IF_PRIV)
+    E(0xb98a, CSPG,    RRE, DAT_ENH, r1_o, ra2, r1_P, 0, csp, 0, MO_BEUQ, IF_PRIV)
 /* DIAGNOSE (KVM hypercall) */
     F(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0, IF_PRIV | IF_IO)
 /* INSERT STORAGE KEY EXTENDED */
@@ -1357,8 +1357,8 @@
     F(0xe313, LRAY,    RXY_a, LD,  0, a2, r1, 0, lra, 0, IF_PRIV)
     F(0xe303, LRAG,    RXY_a, Z,   0, a2, r1, 0, lra, 0, IF_PRIV)
 /* LOAD USING REAL ADDRESS */
-    E(0xb24b, LURA,    RRE,   Z,   0, ra2, new, r1_32, lura, 0, MO_TEUL, IF_PRIV)
-    E(0xb905, LURAG,   RRE,   Z,   0, ra2, r1, 0, lura, 0, MO_TEUQ, IF_PRIV)
+    E(0xb24b, LURA,    RRE,   Z,   0, ra2, new, r1_32, lura, 0, MO_BEUL, IF_PRIV)
+    E(0xb905, LURAG,   RRE,   Z,   0, ra2, r1, 0, lura, 0, MO_BEUQ, IF_PRIV)
 /* MOVE TO PRIMARY */
     C(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0)
 /* MOVE TO SECONDARY */
@@ -1411,8 +1411,8 @@
 /* STORE THEN OR SYSTEM MASK */
     F(0xad00, STOSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0, IF_PRIV)
 /* STORE USING REAL ADDRESS */
-    E(0xb246, STURA,   RRE,   Z,   r1_o, ra2, 0, 0, stura, 0, MO_TEUL, IF_PRIV)
-    E(0xb925, STURG,   RRE,   Z,   r1_o, ra2, 0, 0, stura, 0, MO_TEUQ, IF_PRIV)
+    E(0xb246, STURA,   RRE,   Z,   r1_o, ra2, 0, 0, stura, 0, MO_BEUL, IF_PRIV)
+    E(0xb925, STURG,   RRE,   Z,   r1_o, ra2, 0, 0, stura, 0, MO_BEUQ, IF_PRIV)
 /* TEST BLOCK */
     F(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0, IF_PRIV)
 /* TEST PROTECTION */
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 157ad95b23f..c29253fab56 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1776,10 +1776,10 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
                         uint64_t a2, bool parallel)
 {
     uint32_t mem_idx = s390x_env_mmu_index(env, false);
-    MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, mem_idx);
-    MemOpIdx oi8 = make_memop_idx(MO_TE | MO_64, mem_idx);
-    MemOpIdx oi4 = make_memop_idx(MO_TE | MO_32, mem_idx);
-    MemOpIdx oi2 = make_memop_idx(MO_TE | MO_16, mem_idx);
+    MemOpIdx oi16 = make_memop_idx(MO_BE | MO_128, mem_idx);
+    MemOpIdx oi8 = make_memop_idx(MO_BE | MO_64, mem_idx);
+    MemOpIdx oi4 = make_memop_idx(MO_BE | MO_32, mem_idx);
+    MemOpIdx oi2 = make_memop_idx(MO_BE | MO_16, mem_idx);
     MemOpIdx oi1 = make_memop_idx(MO_8, mem_idx);
     uintptr_t ra = GETPC();
     uint32_t fc = extract32(env->regs[0], 0, 8);
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4d2b8c5e2be..db2276f1cfc 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1914,7 +1914,7 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
     case 2:
     case 4:
     case 8:
-        mop = ctz32(l + 1) | MO_TE;
+        mop = ctz32(l + 1) | MO_BE;
         /* Do not update cc_src yet: loading cc_dst may cause an exception. */
         src = tcg_temp_new_i64();
         tcg_gen_qemu_ld_tl(src, o->addr1, get_mem_index(s), mop);
@@ -2124,7 +2124,7 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_BEUQ);
     gen_helper_cvb(tcg_env, tcg_constant_i32(get_field(s, r1)), t);
     return DISAS_NEXT;
 }
@@ -2132,7 +2132,7 @@ static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
 static DisasJumpType op_cvbg(DisasContext *s, DisasOps *o)
 {
     TCGv_i128 t = tcg_temp_new_i128();
-    tcg_gen_qemu_ld_i128(t, o->addr1, get_mem_index(s), MO_TE | MO_128);
+    tcg_gen_qemu_ld_i128(t, o->addr1, get_mem_index(s), MO_BE | MO_128);
     gen_helper_cvbg(o->out, tcg_env, t);
     return DISAS_NEXT;
 }
@@ -2143,7 +2143,7 @@ static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
     TCGv_i32 t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, o->in1);
     gen_helper_cvd(t1, t2);
-    tcg_gen_qemu_st_i64(t1, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(t1, o->in2, get_mem_index(s), MO_BEUQ);
     return DISAS_NEXT;
 }
 
@@ -2151,7 +2151,7 @@ static DisasJumpType op_cvdg(DisasContext *s, DisasOps *o)
 {
     TCGv_i128 t = tcg_temp_new_i128();
     gen_helper_cvdg(t, o->in1);
-    tcg_gen_qemu_st_i128(t, o->in2, get_mem_index(s), MO_TE | MO_128);
+    tcg_gen_qemu_st_i128(t, o->in2, get_mem_index(s), MO_BE | MO_128);
     return DISAS_NEXT;
 }
 
@@ -2413,7 +2413,7 @@ static DisasJumpType op_icm(DisasContext *s, DisasOps *o)
     switch (m3) {
     case 0xf:
         /* Effectively a 32-bit load.  */
-        tcg_gen_qemu_ld_i64(tmp, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_ld_i64(tmp, o->in2, get_mem_index(s), MO_BEUL);
         len = 32;
         goto one_insert;
 
@@ -2421,7 +2421,7 @@ static DisasJumpType op_icm(DisasContext *s, DisasOps *o)
     case 0x6:
     case 0x3:
         /* Effectively a 16-bit load.  */
-        tcg_gen_qemu_ld_i64(tmp, o->in2, get_mem_index(s), MO_TEUW);
+        tcg_gen_qemu_ld_i64(tmp, o->in2, get_mem_index(s), MO_BEUW);
         len = 16;
         goto one_insert;
 
@@ -2735,34 +2735,34 @@ static DisasJumpType op_ld8u(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_ld16s(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_TESW);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BESW);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_TEUW);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUW);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_tl(o->out, o->in2, get_mem_index(s),
-                       MO_TESL | s->insn->data);
+                       MO_BESL | s->insn->data);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_tl(o->out, o->in2, get_mem_index(s),
-                       MO_TEUL | s->insn->data);
+                       MO_BEUL | s->insn->data);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ld64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_TEUQ | s->insn->data);
+                        MO_BEUQ | s->insn->data);
     return DISAS_NEXT;
 }
 
@@ -2780,7 +2780,7 @@ static DisasJumpType op_lat(DisasContext *s, DisasOps *o)
 static DisasJumpType op_lgat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUQ);
     /* The value is stored even in case of trap. */
     tcg_gen_brcondi_i64(TCG_COND_NE, o->out, 0, lab);
     gen_trap(s);
@@ -2803,7 +2803,7 @@ static DisasJumpType op_llgfat(DisasContext *s, DisasOps *o)
 {
     TCGLabel *lab = gen_new_label();
 
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUL);
     /* The value is stored even in case of trap. */
     tcg_gen_brcondi_i64(TCG_COND_NE, o->out, 0, lab);
     gen_trap(s);
@@ -2901,7 +2901,7 @@ static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
      */
     mask = tcg_temp_new_i64();
     addr = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(mask, o->in2, get_mem_index(s), MO_TEUQ | MO_ALIGN_8);
+    tcg_gen_qemu_ld_i64(mask, o->in2, get_mem_index(s), MO_BEUQ | MO_ALIGN_8);
     tcg_gen_andi_i64(addr, mask, PSW_MASK_SHORT_ADDR);
     tcg_gen_andi_i64(mask, mask, PSW_MASK_SHORT_CTRL);
     tcg_gen_xori_i64(mask, mask, PSW_MASK_SHORTPSW);
@@ -2918,9 +2918,9 @@ static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s),
-                        MO_TEUQ | MO_ALIGN_8);
+                        MO_BEUQ | MO_ALIGN_8);
     tcg_gen_addi_i64(o->in2, o->in2, 8);
-    tcg_gen_qemu_ld_i64(t2, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t2, o->in2, get_mem_index(s), MO_BEUQ);
     gen_helper_load_psw(tcg_env, t1, t2);
     return DISAS_NORETURN;
 }
@@ -2944,7 +2944,7 @@ static DisasJumpType op_lm32(DisasContext *s, DisasOps *o)
     /* Only one register to read. */
     t1 = tcg_temp_new_i64();
     if (unlikely(r1 == r3)) {
-        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUL);
         store_reg32_i64(r1, t1);
         return DISAS_NEXT;
     }
@@ -2952,9 +2952,9 @@ static DisasJumpType op_lm32(DisasContext *s, DisasOps *o)
     /* First load the values of the first and last registers to trigger
        possible page faults. */
     t2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUL);
     tcg_gen_addi_i64(t2, o->in2, 4 * ((r3 - r1) & 15));
-    tcg_gen_qemu_ld_i64(t2, t2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(t2, t2, get_mem_index(s), MO_BEUL);
     store_reg32_i64(r1, t1);
     store_reg32_i64(r3, t2);
 
@@ -2969,7 +2969,7 @@ static DisasJumpType op_lm32(DisasContext *s, DisasOps *o)
     while (r1 != r3) {
         r1 = (r1 + 1) & 15;
         tcg_gen_add_i64(o->in2, o->in2, t2);
-        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUL);
         store_reg32_i64(r1, t1);
     }
     return DISAS_NEXT;
@@ -2984,7 +2984,7 @@ static DisasJumpType op_lmh(DisasContext *s, DisasOps *o)
     /* Only one register to read. */
     t1 = tcg_temp_new_i64();
     if (unlikely(r1 == r3)) {
-        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUL);
         store_reg32h_i64(r1, t1);
         return DISAS_NEXT;
     }
@@ -2992,9 +2992,9 @@ static DisasJumpType op_lmh(DisasContext *s, DisasOps *o)
     /* First load the values of the first and last registers to trigger
        possible page faults. */
     t2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUL);
     tcg_gen_addi_i64(t2, o->in2, 4 * ((r3 - r1) & 15));
-    tcg_gen_qemu_ld_i64(t2, t2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(t2, t2, get_mem_index(s), MO_BEUL);
     store_reg32h_i64(r1, t1);
     store_reg32h_i64(r3, t2);
 
@@ -3009,7 +3009,7 @@ static DisasJumpType op_lmh(DisasContext *s, DisasOps *o)
     while (r1 != r3) {
         r1 = (r1 + 1) & 15;
         tcg_gen_add_i64(o->in2, o->in2, t2);
-        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUL);
         store_reg32h_i64(r1, t1);
     }
     return DISAS_NEXT;
@@ -3023,7 +3023,7 @@ static DisasJumpType op_lm64(DisasContext *s, DisasOps *o)
 
     /* Only one register to read. */
     if (unlikely(r1 == r3)) {
-        tcg_gen_qemu_ld_i64(regs[r1], o->in2, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_ld_i64(regs[r1], o->in2, get_mem_index(s), MO_BEUQ);
         return DISAS_NEXT;
     }
 
@@ -3031,9 +3031,9 @@ static DisasJumpType op_lm64(DisasContext *s, DisasOps *o)
        possible page faults. */
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s), MO_BEUQ);
     tcg_gen_addi_i64(t2, o->in2, 8 * ((r3 - r1) & 15));
-    tcg_gen_qemu_ld_i64(regs[r3], t2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(regs[r3], t2, get_mem_index(s), MO_BEUQ);
     tcg_gen_mov_i64(regs[r1], t1);
 
     /* Only two registers to read. */
@@ -3047,7 +3047,7 @@ static DisasJumpType op_lm64(DisasContext *s, DisasOps *o)
     while (r1 != r3) {
         r1 = (r1 + 1) & 15;
         tcg_gen_add_i64(o->in2, o->in2, t1);
-        tcg_gen_qemu_ld_i64(regs[r1], o->in2, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_ld_i64(regs[r1], o->in2, get_mem_index(s), MO_BEUQ);
     }
     return DISAS_NEXT;
 }
@@ -3080,7 +3080,7 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 {
     o->out_128 = tcg_temp_new_i128();
     tcg_gen_qemu_ld_i128(o->out_128, o->in2, get_mem_index(s),
-                         MO_TE | MO_128 | MO_ALIGN);
+                         MO_BE | MO_128 | MO_ALIGN);
     return DISAS_NEXT;
 }
 
@@ -3896,15 +3896,15 @@ static DisasJumpType op_soc(DisasContext *s, DisasOps *o)
     a = get_address(s, 0, get_field(s, b2), get_field(s, d2));
     switch (s->insn->data) {
     case 1: /* STOCG */
-        tcg_gen_qemu_st_i64(regs[r1], a, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_st_i64(regs[r1], a, get_mem_index(s), MO_BEUQ);
         break;
     case 0: /* STOC */
-        tcg_gen_qemu_st_i64(regs[r1], a, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_st_i64(regs[r1], a, get_mem_index(s), MO_BEUL);
         break;
     case 2: /* STOCFH */
         h = tcg_temp_new_i64();
         tcg_gen_shri_i64(h, regs[r1], 32);
-        tcg_gen_qemu_st_i64(h, a, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_st_i64(h, a, get_mem_index(s), MO_BEUL);
         break;
     default:
         g_assert_not_reached();
@@ -4023,7 +4023,7 @@ static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
     gen_addi_and_wrap_i64(s, o->addr1, regs[r3], 0);
 
     /* load the third operand into r3 before modifying anything */
-    tcg_gen_qemu_ld_i64(regs[r3], o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(regs[r3], o->addr1, get_mem_index(s), MO_BEUQ);
 
     /* subtract CPU timer from first operand and store in GR0 */
     gen_helper_stpt(tmp, tcg_env);
@@ -4101,9 +4101,9 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     tcg_gen_shri_i64(c1, c1, 8);
     tcg_gen_ori_i64(c2, c2, 0x10000);
     tcg_gen_or_i64(c2, c2, todpr);
-    tcg_gen_qemu_st_i64(c1, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(c1, o->in2, get_mem_index(s), MO_BEUQ);
     tcg_gen_addi_i64(o->in2, o->in2, 8);
-    tcg_gen_qemu_st_i64(c2, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(c2, o->in2, get_mem_index(s), MO_BEUQ);
     /* ??? We don't implement clock states.  */
     gen_op_movi_cc(s, 0);
     return DISAS_NEXT;
@@ -4361,21 +4361,21 @@ static DisasJumpType op_st8(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_st16(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), MO_TEUW);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), MO_BEUW);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_tl(o->in1, o->in2, get_mem_index(s),
-                       MO_TEUL | s->insn->data);
+                       MO_BEUL | s->insn->data);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_st64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
-                        MO_TEUQ | s->insn->data);
+                        MO_BEUQ | s->insn->data);
     return DISAS_NEXT;
 }
 
@@ -4399,7 +4399,7 @@ static DisasJumpType op_stcm(DisasContext *s, DisasOps *o)
     case 0xf:
         /* Effectively a 32-bit store.  */
         tcg_gen_shri_i64(tmp, o->in1, pos);
-        tcg_gen_qemu_st_i64(tmp, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_st_i64(tmp, o->in2, get_mem_index(s), MO_BEUL);
         break;
 
     case 0xc:
@@ -4407,7 +4407,7 @@ static DisasJumpType op_stcm(DisasContext *s, DisasOps *o)
     case 0x3:
         /* Effectively a 16-bit store.  */
         tcg_gen_shri_i64(tmp, o->in1, pos);
-        tcg_gen_qemu_st_i64(tmp, o->in2, get_mem_index(s), MO_TEUW);
+        tcg_gen_qemu_st_i64(tmp, o->in2, get_mem_index(s), MO_BEUW);
         break;
 
     case 0x8:
@@ -4445,7 +4445,7 @@ static DisasJumpType op_stm(DisasContext *s, DisasOps *o)
 
     while (1) {
         tcg_gen_qemu_st_i64(regs[r1], o->in2, get_mem_index(s),
-                            size == 8 ? MO_TEUQ : MO_TEUL);
+                            size == 8 ? MO_BEUQ : MO_BEUL);
         if (r1 == r3) {
             break;
         }
@@ -4466,7 +4466,7 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 
     while (1) {
         tcg_gen_shl_i64(t, regs[r1], t32);
-        tcg_gen_qemu_st_i64(t, o->in2, get_mem_index(s), MO_TEUL);
+        tcg_gen_qemu_st_i64(t, o->in2, get_mem_index(s), MO_BEUL);
         if (r1 == r3) {
             break;
         }
@@ -4482,7 +4482,7 @@ static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
 
     tcg_gen_concat_i64_i128(t16, o->out2, o->out);
     tcg_gen_qemu_st_i128(t16, o->in2, get_mem_index(s),
-                         MO_TE | MO_128 | MO_ALIGN);
+                         MO_BE | MO_128 | MO_ALIGN);
     return DISAS_NEXT;
 }
 
@@ -5284,49 +5284,49 @@ static void wout_m1_8(DisasContext *s, DisasOps *o)
 
 static void wout_m1_16(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEUW);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUW);
 }
 #define SPEC_wout_m1_16 0
 
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_16a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUW | MO_ALIGN);
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_BEUW | MO_ALIGN);
 }
 #define SPEC_wout_m1_16a 0
 #endif
 
 static void wout_m1_32(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUL);
 }
 #define SPEC_wout_m1_32 0
 
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_32a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_TEUL | MO_ALIGN);
+    tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), MO_BEUL | MO_ALIGN);
 }
 #define SPEC_wout_m1_32a 0
 #endif
 
 static void wout_m1_64(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUQ);
 }
 #define SPEC_wout_m1_64 0
 
 #ifndef CONFIG_USER_ONLY
 static void wout_m1_64a(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEUQ | MO_ALIGN);
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_BEUQ | MO_ALIGN);
 }
 #define SPEC_wout_m1_64a 0
 #endif
 
 static void wout_m2_32(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->out, o->in2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_st_i64(o->out, o->in2, get_mem_index(s), MO_BEUL);
 }
 #define SPEC_wout_m2_32 0
 
@@ -5529,7 +5529,7 @@ static void in1_m1_16s(DisasContext *s, DisasOps *o)
 {
     in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TESW);
+    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_BESW);
 }
 #define SPEC_in1_m1_16s 0
 
@@ -5537,7 +5537,7 @@ static void in1_m1_16u(DisasContext *s, DisasOps *o)
 {
     in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEUW);
+    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_BEUW);
 }
 #define SPEC_in1_m1_16u 0
 
@@ -5545,7 +5545,7 @@ static void in1_m1_32s(DisasContext *s, DisasOps *o)
 {
     in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TESL);
+    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_BESL);
 }
 #define SPEC_in1_m1_32s 0
 
@@ -5553,7 +5553,7 @@ static void in1_m1_32u(DisasContext *s, DisasOps *o)
 {
     in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_BEUL);
 }
 #define SPEC_in1_m1_32u 0
 
@@ -5561,7 +5561,7 @@ static void in1_m1_64(DisasContext *s, DisasOps *o)
 {
     in1_la1(s, o);
     o->in1 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_BEUQ);
 }
 #define SPEC_in1_m1_64 0
 
@@ -5787,28 +5787,28 @@ static void in2_m2_8u(DisasContext *s, DisasOps *o)
 static void in2_m2_16s(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TESW);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BESW);
 }
 #define SPEC_in2_m2_16s 0
 
 static void in2_m2_16u(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEUW);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUW);
 }
 #define SPEC_in2_m2_16u 0
 
 static void in2_m2_32s(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TESL);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BESL);
 }
 #define SPEC_in2_m2_32s 0
 
 static void in2_m2_32u(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEUL);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUL);
 }
 #define SPEC_in2_m2_32u 0
 
@@ -5816,7 +5816,7 @@ static void in2_m2_32u(DisasContext *s, DisasOps *o)
 static void in2_m2_32ua(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_TEUL | MO_ALIGN);
+    tcg_gen_qemu_ld_tl(o->in2, o->in2, get_mem_index(s), MO_BEUL | MO_ALIGN);
 }
 #define SPEC_in2_m2_32ua 0
 #endif
@@ -5824,14 +5824,14 @@ static void in2_m2_32ua(DisasContext *s, DisasOps *o)
 static void in2_m2_64(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUQ);
 }
 #define SPEC_in2_m2_64 0
 
 static void in2_m2_64w(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUQ);
     gen_addi_and_wrap_i64(s, o->in2, o->in2, 0);
 }
 #define SPEC_in2_m2_64w 0
@@ -5840,7 +5840,7 @@ static void in2_m2_64w(DisasContext *s, DisasOps *o)
 static void in2_m2_64a(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_TEUQ | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUQ | MO_ALIGN);
 }
 #define SPEC_in2_m2_64a 0
 #endif
@@ -5848,14 +5848,14 @@ static void in2_m2_64a(DisasContext *s, DisasOps *o)
 static void in2_mri2_16s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s), MO_TESW);
+    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s), MO_BESW);
 }
 #define SPEC_in2_mri2_16s 0
 
 static void in2_mri2_16u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s), MO_TEUW);
+    tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s), MO_BEUW);
 }
 #define SPEC_in2_mri2_16u 0
 
@@ -5863,7 +5863,7 @@ static void in2_mri2_32s(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
     tcg_gen_qemu_ld_tl(o->in2, gen_ri2(s), get_mem_index(s),
-                       MO_TESL | MO_ALIGN);
+                       MO_BESL | MO_ALIGN);
 }
 #define SPEC_in2_mri2_32s 0
 
@@ -5871,7 +5871,7 @@ static void in2_mri2_32u(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
     tcg_gen_qemu_ld_tl(o->in2, gen_ri2(s), get_mem_index(s),
-                       MO_TEUL | MO_ALIGN);
+                       MO_BEUL | MO_ALIGN);
 }
 #define SPEC_in2_mri2_32u 0
 
@@ -5879,7 +5879,7 @@ static void in2_mri2_64(DisasContext *s, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
     tcg_gen_qemu_ld_i64(o->in2, gen_ri2(s), get_mem_index(s),
-                        MO_TEUQ | MO_ALIGN);
+                        MO_BEUQ | MO_ALIGN);
 }
 #define SPEC_in2_mri2_64 0
 
diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index f3b4b48ab7b..b53e9e52639 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -331,7 +331,7 @@ static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
     tcg_gen_add_i64(o->addr1, o->addr1, tmp);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 0);
 
-    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_BE | es);
     write_vec_element_i64(tmp, get_field(s, v1), enr, es);
     return DISAS_NEXT;
 }
@@ -402,9 +402,9 @@ static DisasJumpType op_vl(DisasContext *s, DisasOps *o)
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(t0, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t0, o->addr1, get_mem_index(s), MO_BEUQ);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
-    tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_BEUQ);
     write_vec_element_i64(t0, get_field(s, v1), 0, ES_64);
     write_vec_element_i64(t1, get_field(s, v1), 1, ES_64);
     return DISAS_NEXT;
@@ -427,7 +427,7 @@ static DisasJumpType op_vlrep(DisasContext *s, DisasOps *o)
     }
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_BE | es);
     gen_gvec_dup_i64(es, get_field(s, v1), tmp);
     return DISAS_NEXT;
 }
@@ -561,7 +561,7 @@ static DisasJumpType op_vle(DisasContext *s, DisasOps *o)
     }
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_BE | es);
     write_vec_element_i64(tmp, get_field(s, v1), enr, es);
     return DISAS_NEXT;
 }
@@ -595,9 +595,9 @@ static DisasJumpType op_vler(DisasContext *s, DisasOps *o)
     TCGv_i64 t1 = tcg_temp_new_i64();
 
     /* Begin with the two doublewords swapped... */
-    tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_BEUQ);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
-    tcg_gen_qemu_ld_i64(t0, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t0, o->addr1, get_mem_index(s), MO_BEUQ);
 
     /* ... then swap smaller elements within the doublewords as required. */
     switch (es) {
@@ -693,7 +693,7 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
     }
 
     t = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_BE | es);
     gen_gvec_dup_imm(es, get_field(s, v1), 0);
     write_vec_element_i64(t, get_field(s, v1), enr, es);
     return DISAS_NEXT;
@@ -717,16 +717,16 @@ static DisasJumpType op_vlm(DisasContext *s, DisasOps *o)
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_addi_and_wrap_i64(s, t0, o->addr1, (v3 - v1) * 16 + 8);
-    tcg_gen_qemu_ld_i64(t0, t0, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t0, t0, get_mem_index(s), MO_BEUQ);
 
     for (;; v1++) {
-        tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_BEUQ);
         write_vec_element_i64(t1, v1, 0, ES_64);
         if (v1 == v3) {
             break;
         }
         gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
-        tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_BEUQ);
         write_vec_element_i64(t1, v1, 1, ES_64);
         gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
     }
@@ -1009,7 +1009,7 @@ static DisasJumpType op_vsce(DisasContext *s, DisasOps *o)
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 0);
 
     read_vec_element_i64(tmp, get_field(s, v1), enr, es);
-    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_BE | es);
     return DISAS_NEXT;
 }
 
@@ -1063,10 +1063,10 @@ static DisasJumpType op_vst(DisasContext *s, DisasOps *o)
 
     tmp = tcg_temp_new_i64();
     read_vec_element_i64(tmp,  get_field(s, v1), 0, ES_64);
-    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_BEUQ);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
     read_vec_element_i64(tmp,  get_field(s, v1), 1, ES_64);
-    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_BEUQ);
     return DISAS_NEXT;
 }
 
@@ -1154,7 +1154,7 @@ static DisasJumpType op_vste(DisasContext *s, DisasOps *o)
 
     tmp = tcg_temp_new_i64();
     read_vec_element_i64(tmp, get_field(s, v1), enr, es);
-    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_BE | es);
     return DISAS_NEXT;
 }
 
@@ -1193,9 +1193,9 @@ static DisasJumpType op_vster(DisasContext *s, DisasOps *o)
         g_assert_not_reached();
     }
 
-    tcg_gen_qemu_st_i64(t0, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(t0, o->addr1, get_mem_index(s), MO_BEUQ);
     gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
-    tcg_gen_qemu_st_i64(t1, o->addr1, get_mem_index(s), MO_TEUQ);
+    tcg_gen_qemu_st_i64(t1, o->addr1, get_mem_index(s), MO_BEUQ);
     return DISAS_NEXT;
 }
 
@@ -1217,10 +1217,10 @@ static DisasJumpType op_vstm(DisasContext *s, DisasOps *o)
     tmp = tcg_temp_new_i64();
     for (;; v1++) {
         read_vec_element_i64(tmp, v1, 0, ES_64);
-        tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_BEUQ);
         gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
         read_vec_element_i64(tmp, v1, 1, ES_64);
-        tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEUQ);
+        tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_BEUQ);
         if (v1 == v3) {
             break;
         }
-- 
2.52.0


