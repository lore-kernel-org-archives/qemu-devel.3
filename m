Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D4C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaCJ-0000Id-I5; Thu, 27 Aug 2026 09:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCG-0000HY-Hy; Thu, 27 Aug 2026 09:31:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCC-0001S4-Bv; Thu, 27 Aug 2026 09:31:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVZY22976045; Thu, 27 Aug 2026 13:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Pig9Ri2uLFzTWN9kz
 frQc0XmQqLOZxy/WBJDjn6rYP4=; b=TKerUJkg2ScKVSEREd2AIFPHLv65P6HSM
 50CWjKdAYU6WApXkS/Rf0eJxC6YYPf0sOgs/cMZJFJto7vnDqUNMbCdCdO9jKmkO
 R9POpbA+dZhBGm775y4nBS8y1NablzBvJzAOh2HyxPUH4ALi4r7d1hY4Y8FhkfhH
 pi7Dlokw/WoIs/N7KtkptAh1hVTkhhuwOyFf9D2oodOoqUP7ZQyt68124er/YMA8
 rKqYe0vNKg1CopeYtjDHNdR9ceLN0uAjDFF6RHJm8iaR038jmiKqUtm9MrNck3HS
 dscpaf0yr6JNC8KUzHpmOcRphmtnOzkQFkRPylCPTJyz6rM0yZSxA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394dnkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQLDj024887;
 Thu, 27 Aug 2026 13:31:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragr4ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDUot915532500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:30:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52D622004F;
 Thu, 27 Aug 2026 13:30:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5146920043;
 Thu, 27 Aug 2026 13:30:44 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:30:44 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Tasmiya Nalatwad <tasmiya@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 03/37] target/ppc: Convert cache instructions to decodetree
Date: Thu, 27 Aug 2026 18:59:18 +0530
Message-ID: <20260827133010.278889-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _uhaXPuXgFqIZaA6CNW2YKLvL8RH84MM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXyu9zmFPxIKkW
 rva+wWfGcdo3OZMlqPgxIMR5oEU9TusAQSpRscV6PzhSqL1tMRwEKPdZU6PmwFGBD3eIbwU8Jyd
 QUfCZOveTba8ndFF/gaMpQAocGei5YvYekcHwsCyh/rDMXVm7VYNTypX/3YaygJF4HPzkmg+bqO
 c0Vi8KklXJHsknA5bY19jGz5jORDCg9jslsGG8QLSUdid41EM0bGiwf/T0lXYgotde0/CaEHoIv
 02kus34Ggg4m2TkieX2kf+U+Fs6Tks4WWmkpgJ623vy+DvDK4R/Jjt5j3/mYrEi0TBFoJxOBuOf
 7wUAF6T7ht2yTOBGx+DFaC/wfEuQ+hT+KSBFou4jM7tcsFP/629dKY1S8bT4ylNvEsFb/qhsbsp
 1B+Wy9/UjwVSX+Xk66UFaqLnQx4cZR2w0r/aEeKBLDnrl59HWPzRrTq0jScvCihlWy3yrlU5Dqo
 p9zfe9KC6kUL//4K4qw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a903c19 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Lmgfs3a3K7fV6kfGSZAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX9HMsRAtTIlgX
 aXjUdZ9qWhdCrXMB+B0BFcnNQ4tcldmciLq2uBG8hvC9EdWEWibWw27MLwVCNPgWMTdo65dCrr7
 ufZVAu5qg/Da56Ey3C8CpUSz8k47d6w=
X-Proofpoint-ORIG-GUID: A6j8D2AXgiUaEqF_3N0HmT-GLlZyvpun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Convert cache management instructions to decodetree using custom
X-form layouts (@X_ea, @X_l, @X_th) and dedicated translation functions.
This ensures reserved bits are accurately represented and ignored by
the decoder (using '-' in the patterns), rather than being erroneously
parsed into instruction fields.

Legacy GEN_HANDLER-based implementations are removed.

The implementation preserves legacy semantics, including:
  - MMU-visible accesses for instructions treated as loads
    (e.g. dcbt, dcbtst, dcbtep, dcbtstep)
  - Supervisor and BookE-specific constraints
  - Effective address computation via do_ea_calc()

Instructions that were defined as no-ops in the legacy implementation
remain no-ops here.

Note on intentional behavior changes:
  - dcbf now validates the L field against the Power ISA v3.1 set of
    legal values (0, 1, 3, 4, 6).
  - Reserved bits that were previously encoded as part of the opcode
    mask (and trapped if set) are now properly decoded as "don't care"
    ('-' in the pattern).

Testing:
  - Verified TCG equivalence for all cache operations

Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h      |   4 +-
 target/ppc/insn32.decode |  33 ++++
 target/ppc/mem_helper.c  |   4 +-
 target/ppc/translate.c   | 409 ++++++++++++++++++++-------------------
 4 files changed, 249 insertions(+), 201 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6b2d19a3ad..82ec3a471b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -52,8 +52,8 @@ DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
 #ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
 #endif
-DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(ICBI, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(ICBIEP, TCG_CALL_NO_WG, void, env, tl)
 
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 26948e08a7..92706e2097 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1306,6 +1306,39 @@ XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
 XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
 XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
 
+## Cache Management Instructions
+
+&X_ea           ra rb
+@X_ea           ...... ..... ra:5 rb:5 .......... .     &X_ea
+
+&X_l            l ra rb
+@X_l            ...... .. l:3 ra:5 rb:5 .......... .    &X_l
+
+&X_th           th ra rb
+@X_th           ...... th:5 ra:5 rb:5 .......... .      &X_th
+
+DCBF            011111 -- ... ..... ..... 0001010110 -   @X_l
+DCBFEP          011111 ----- ..... ..... 0001111111 -   @X_ea
+DCBI            011111 ----- ..... ..... 0111010110 -   @X_ea
+DCBST           011111 ----- ..... ..... 0000110110 -   @X_ea
+DCBSTEP         011111 ----- ..... ..... 0000111111 -   @X_ea
+DCBA            011111 ----- ..... ..... 1011110110 -   @X_ea
+
+DCBT            011111 ..... ..... ..... 0100010110 -   @X_th
+DCBTEP          011111 ----- ..... ..... 0100111111 -   @X_ea
+DCBTST          011111 ..... ..... ..... 0011110110 -   @X_th
+DCBTSTEP        011111 ----- ..... ..... 0011111111 -   @X_ea
+
+DCBTLS          011111 ..... ..... ..... 0010100110 -   @X_th
+DCBLC           011111 ..... ..... ..... 0110000110 -   @X_th
+
+ICBI            011111 ----- ..... ..... 1111010110 -   @X_ea
+ICBIEP          011111 ----- ..... ..... 1111011111 -   @X_ea
+
+DST             011111 ----- ..... ..... 0101010110 -   @X_ea
+DSTST           011111 ----- ..... ..... 0101110110 -   @X_ea
+DSS             011111 ----- ..... ..... 1100110110 -   @X_ea
+
 ##Extend Sign Word and Shift Left Immediate XS-form
 EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 787ba2cdec..8ad6945590 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -341,7 +341,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
 }
 #endif
 
-void helper_icbi(CPUPPCState *env, target_ulong addr)
+void helper_ICBI(CPUPPCState *env, target_ulong addr)
 {
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
     MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
@@ -357,7 +357,7 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
     cpu_ldl_mmu(env, addr, oi, GETPC());
 }
 
-void helper_icbiep(CPUPPCState *env, target_ulong addr)
+void helper_ICBIEP(CPUPPCState *env, target_ulong addr)
 {
 #if !defined(CONFIG_USER_ONLY)
     MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 69c4443dda..4bd7f44b3c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4298,128 +4298,6 @@ static void gen_setb(DisasContext *ctx)
 
 /***                         Cache management                              ***/
 
-/* dcbf */
-static void gen_dcbf(DisasContext *ctx)
-{
-    /* XXX: specification says this is treated as a load by the MMU */
-    TCGv t0;
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    gen_qemu_ld8u(ctx, t0, t0);
-}
-
-/* dcbfep (external PID dcbf) */
-static void gen_dcbfep(DisasContext *ctx)
-{
-    /* XXX: specification says this is treated as a load by the MMU */
-    TCGv t0;
-    CHK_SV(ctx);
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
-}
-
-/* dcbi (Supervisor only) */
-static void gen_dcbi(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv EA, val;
-
-    CHK_SV(ctx);
-    EA = tcg_temp_new();
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    gen_addr_reg_index(ctx, EA);
-    val = tcg_temp_new();
-    /* XXX: specification says this should be treated as a store by the MMU */
-    gen_qemu_ld8u(ctx, val, EA);
-    gen_qemu_st8(ctx, val, EA);
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-/* dcdst */
-static void gen_dcbst(DisasContext *ctx)
-{
-    /* XXX: specification say this is treated as a load by the MMU */
-    TCGv t0;
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    gen_qemu_ld8u(ctx, t0, t0);
-}
-
-/* dcbstep (dcbstep External PID version) */
-static void gen_dcbstep(DisasContext *ctx)
-{
-    /* XXX: specification say this is treated as a load by the MMU */
-    TCGv t0;
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
-}
-
-/* dcbt */
-static void gen_dcbt(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     * XXX: specification say this is treated as a load by the MMU but
-     *      does not generate any exception
-     */
-}
-
-/* dcbtep */
-static void gen_dcbtep(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     * XXX: specification say this is treated as a load by the MMU but
-     *      does not generate any exception
-     */
-}
-
-/* dcbtst */
-static void gen_dcbtst(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     * XXX: specification say this is treated as a load by the MMU but
-     *      does not generate any exception
-     */
-}
-
-/* dcbtstep */
-static void gen_dcbtstep(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     * XXX: specification say this is treated as a load by the MMU but
-     *      does not generate any exception
-     */
-}
-
-/* dcbtls */
-static void gen_dcbtls(DisasContext *ctx)
-{
-    /* Always fails locking the cache */
-    TCGv t0 = tcg_temp_new();
-    gen_load_spr(t0, SPR_Exxx_L1CSR0);
-    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
-    gen_store_spr(SPR_Exxx_L1CSR0, t0);
-}
-
-/* dcblc */
-static void gen_dcblc(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     */
-}
-
 /* dcbz */
 static void gen_dcbz(DisasContext *ctx)
 {
@@ -4448,64 +4326,6 @@ static void gen_dcbzep(DisasContext *ctx)
     gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_STORE));
 }
 
-/* dst / dstt */
-static void gen_dst(DisasContext *ctx)
-{
-    if (rA(ctx->opcode) == 0) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-    } else {
-        /* interpreted as no-op */
-    }
-}
-
-/* dstst /dststt */
-static void gen_dstst(DisasContext *ctx)
-{
-    if (rA(ctx->opcode) == 0) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-    } else {
-        /* interpreted as no-op */
-    }
-
-}
-
-/* dss / dssall */
-static void gen_dss(DisasContext *ctx)
-{
-    /* interpreted as no-op */
-}
-
-/* icbi */
-static void gen_icbi(DisasContext *ctx)
-{
-    TCGv t0;
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    gen_helper_icbi(tcg_env, t0);
-}
-
-/* icbiep */
-static void gen_icbiep(DisasContext *ctx)
-{
-    TCGv t0;
-    gen_set_access_type(ctx, ACCESS_CACHE);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    gen_helper_icbiep(tcg_env, t0);
-}
-
-/* Optional: */
-/* dcba */
-static void gen_dcba(DisasContext *ctx)
-{
-    /*
-     * interpreted as no-op
-     * XXX: specification say this is treated as a store by the MMU
-     *      but does not generate any exception
-     */
-}
-
 /***                    Segment register manipulation                      ***/
 /* Supervisor only: */
 
@@ -5740,6 +5560,218 @@ static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
     return true;
 }
 
+/*
+ * Cache Management Instructions (decodetree)
+ */
+
+static bool trans_DCBA(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBA);
+    return true;
+}
+
+static bool trans_DCBT(DisasContext *ctx, arg_X_th *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, CACHE);
+    return true;
+}
+
+static bool trans_DCBTEP(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
+    return true;
+}
+
+static bool trans_DCBTST(DisasContext *ctx, arg_X_th *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, CACHE);
+    return true;
+}
+
+static bool trans_DCBTSTEP(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
+    return true;
+}
+
+static bool trans_DCBLC(DisasContext *ctx, arg_X_th *a)
+{
+    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
+    if (!(ctx->insns_flags & PPC_BOOKE) &&
+        !(ctx->insns_flags2 & PPC2_BOOKE206)) {
+        return false;
+    }
+    return true;
+}
+
+static bool trans_DSS(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    return true;
+}
+
+static bool trans_DCBTLS(DisasContext *ctx, arg_X_th *a)
+{
+    TCGv t0 = tcg_temp_new();
+
+    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
+    if (!(ctx->insns_flags & PPC_BOOKE) &&
+        !(ctx->insns_flags2 & PPC2_BOOKE206)) {
+        return false;
+    }
+
+    gen_load_spr(t0, SPR_Exxx_L1CSR0);
+    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
+    gen_store_spr(SPR_Exxx_L1CSR0, t0);
+
+    return true;
+}
+
+static bool trans_DST(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+
+    if (a->ra == 0) {
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+    }
+
+    return true;
+}
+
+static bool trans_DSTST(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+
+    if (a->ra == 0) {
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+    }
+
+    return true;
+}
+
+static bool trans_DCBF(DisasContext *ctx, arg_X_l *a)
+{
+    TCGv EA;
+
+    REQUIRE_INSNS_FLAGS(ctx, CACHE);
+
+    /*
+     * As per PowerISA v3.1, the L field can have values 0, 1, 3, 4, or 6.
+     * Other values are Undefined Behavior (UB).
+     */
+    switch (a->l) {
+    case 0: /* dcbf */
+    case 1: /* dcbfl */
+    case 3: /* dcbflp */
+    case 4: /* dcbfps */
+    case 6: /* dcbstps */
+        break;
+    default:
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+        return true;
+    }
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    gen_qemu_ld8u(ctx, EA, EA);
+
+    return true;
+}
+
+static bool trans_DCBST(DisasContext *ctx, arg_X_ea *a)
+{
+    TCGv EA;
+
+    REQUIRE_INSNS_FLAGS(ctx, CACHE);
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    gen_qemu_ld8u(ctx, EA, EA);
+
+    return true;
+}
+
+static bool trans_DCBFEP(DisasContext *ctx, arg_X_ea *a)
+{
+    TCGv EA;
+
+    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
+
+    REQUIRE_SV(ctx);
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+
+    tcg_gen_qemu_ld_tl(EA, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
+
+    return true;
+}
+
+static bool trans_DCBSTEP(DisasContext *ctx, arg_X_ea *a)
+{
+    TCGv EA;
+
+    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+
+    tcg_gen_qemu_ld_tl(EA, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
+
+    return true;
+}
+
+static bool trans_DCBI(DisasContext *ctx, arg_X_ea *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, CACHE);
+
+#if defined(CONFIG_USER_ONLY)
+    gen_priv_opc(ctx);
+    return true;
+#else
+    TCGv EA, val;
+
+    REQUIRE_SV(ctx);
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    val = tcg_temp_new();
+
+    gen_qemu_ld8u(ctx, val, EA);
+    gen_qemu_st8(ctx, val, EA);
+
+    return true;
+#endif
+}
+
+static bool trans_ICBI(DisasContext *ctx, arg_X_ea *a)
+{
+    TCGv EA;
+
+    REQUIRE_INSNS_FLAGS(ctx, CACHE_ICBI);
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    gen_helper_ICBI(tcg_env, EA);
+
+    return true;
+}
+
+static bool trans_ICBIEP(DisasContext *ctx, arg_X_ea *a)
+{
+    TCGv EA;
+
+    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
+    REQUIRE_SV(ctx);
+
+    gen_set_access_type(ctx, ACCESS_CACHE);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+
+    gen_helper_ICBIEP(tcg_env, EA);
+    return true;
+}
+
 #include "translate/fixedpoint-impl.c.inc"
 
 #include "translate/fp-impl.c.inc"
@@ -5904,25 +5936,8 @@ GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
 GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
-GEN_HANDLER(dcbf, 0x1F, 0x16, 0x02, 0x03C00001, PPC_CACHE),
-GEN_HANDLER_E(dcbfep, 0x1F, 0x1F, 0x03, 0x03C00001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER(dcbi, 0x1F, 0x16, 0x0E, 0x03E00001, PPC_CACHE),
-GEN_HANDLER(dcbst, 0x1F, 0x16, 0x01, 0x03E00001, PPC_CACHE),
-GEN_HANDLER_E(dcbstep, 0x1F, 0x1F, 0x01, 0x03E00001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER(dcbt, 0x1F, 0x16, 0x08, 0x00000001, PPC_CACHE),
-GEN_HANDLER_E(dcbtep, 0x1F, 0x1F, 0x09, 0x00000001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE),
-GEN_HANDLER_E(dcbtstep, 0x1F, 0x1F, 0x07, 0x00000001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, PPC2_BOOKE206),
-GEN_HANDLER_E(dcblc, 0x1F, 0x06, 0x0c, 0x02000001, PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
 GEN_HANDLER_E(dcbzep, 0x1F, 0x1F, 0x1F, 0x03C00001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
-GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
-GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
-GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
-GEN_HANDLER_E(icbiep, 0x1F, 0x1F, 0x1E, 0x03E00001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),
 GEN_HANDLER(mfsr, 0x1F, 0x13, 0x12, 0x0010F801, PPC_SEGMENT),
 GEN_HANDLER(mfsrin, 0x1F, 0x13, 0x14, 0x001F0001, PPC_SEGMENT),
 GEN_HANDLER(mtsr, 0x1F, 0x12, 0x06, 0x0010F801, PPC_SEGMENT),
-- 
2.55.0


