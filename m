Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8DEC5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXs-0001Ic-Pw; Wed, 12 Aug 2026 18:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXq-0001Ei-Pn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:34 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXk-0001rJ-45
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:34 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1404758a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574127; x=1787178927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MoeKa9Pn9WFjvQnH9edW4Vt/HfdbhxKuqI9aNv81cmw=;
 b=BlghA9p1+BODf4s2KoDvCAJAhNzunmcxITnJcsiT+5chgHIUwuRkeGAVRCxRujBxjL
 ooRbAo+wVECd+9A1AgePe1D46FGBBKKDoydhvHPX8YIhgBqJsym0yduik8wQxMCD41Pr
 /G4LAplLx5XkdpvqOuMBCcMhHj+RGibzrUdAMXsillc5WoYGlHAjXnWgSuvVJVNhmaNz
 cuY/eIN1fILwxxr3J2P4dHNm8gNrMN51nFN9BHqeGTUxsp+rB+lMYAuG7LFaQahl2ceo
 KorySumHD7XbDsP33VD9uU7BVWD6E582fcFMo0N63VfmkBgm039mm3na+KZRNYKP5uSt
 KGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574127; x=1787178927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MoeKa9Pn9WFjvQnH9edW4Vt/HfdbhxKuqI9aNv81cmw=;
 b=YHYRuvBKLTu3R3A0KLz6/Dnl6BMadIPr600uMr5jUo7KNppFIwjfZyQ4upD8dED0fH
 QpKNuzI4uf8wuHT204B7xUJzwJkIpCNKXt20KBJkRVnq/az5+afdaT5YiTNsr2xC8poA
 e5Q14snBMFvs8+sjS8W/PuGgrgNydlB7hMDArqRbLVS/JdwGkZ589CfqpiTKfBd864Id
 h3/Jr7IdN2hMIYCYDTGpVpg7fNGwF+vGqe9VR7VJR5iX1PgT/E8tqXXIDu1VocN0KJ18
 YyWT1UVcw0aLduzLRd+SSfZihwV2rQDaC4u55q+QJmDGvWBZbDE5wqaVGl4RKl9yjkNE
 AwKA==
X-Gm-Message-State: AOJu0Yy1oOwktaojonEhVcGHtNfqPOXRxeQngK2zxNSG1NeuDjENgsQ8
 WaQEqZv+bGAOwa+MAqusEwD0TOpXMQT1GaDXoIB0K2759lzxTdBnR8tMDmyfIMfacYB+Ui5XfQS
 EQ5Cc
X-Gm-Gg: AR+sD12V4iJeToZywIPUfxAEDDKPgaX0pO2Cg/0hjWoyUOZKg2Vf0A8GmlQcuvHquz8
 xx/asb5EjU6XhT8ElQT8fCIPLZQACB5zw4g94Z/Nxg52enXhHRyq0+rGm84mca2xZQlm1rLGtml
 xI9UtQJ5fKVfikFf7Ay+P/7oQjjc+kxtkJ8Oem1VW6IoPWy2uSsDVVEch9j7LVNzwKFOkUPh23D
 LHdMeid4C5C6Xpj9D5/mGRhDqjg1eAXQP0v2ows0+CEe5fpulnMIjeBwEIDGqD432E3EXexMIAM
 QzWq19+ctJO8jtWtEpDmtNK2YMwA3EhO1QVja9zlIRmL1+kGXlAoEchMTohSGtMA5S2KvBmbFnb
 AaQv/TTgi182xMv6dI8702I1DApCOn+MxVZTLp/MIcN+yfnvAmC8XKGFDQBDWm0y3T+2HKQ9bz5
 KJxF8RMyEXSynjghrl9YipASUyKgk3OSgkUgk+HhmAXXIhPIjuv0AaVheguAT6DmyMjI6SH4SW2
 DK7TOy9co5oe0lqtQl0wtutKxwkog==
X-Received: by 2002:a17:90a:ec8f:b0:38e:485c:ebd3 with SMTP id
 98e67ed59e1d1-3931e291d2dmr1795377a91.15.1786574125345; 
 Wed, 12 Aug 2026 15:35:25 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 45/52] disas/riscv: Split out riscv-op.c.inc
Date: Wed, 12 Aug 2026 15:31:35 -0700
Message-ID: <20260812223142.349142-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move rvi_opcode_data to riscv-op.c.inc and massage the lines into
OP() form.  Unlike other files, keep the enumeration and the table
intact for now, but build them both from the same source.

Adjust the names of rv_*mop to include _op_ to match the general pattern.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c        | 1931 +-----------------------------------------
 disas/riscv-op.c.inc |  958 +++++++++++++++++++++
 2 files changed, 967 insertions(+), 1922 deletions(-)
 create mode 100644 disas/riscv-op.c.inc

diff --git a/disas/riscv.c b/disas/riscv.c
index c3a8cde37d..8aaad96bf4 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -29,964 +29,9 @@
 #include "disas/riscv-xlrbr.h"
 
 typedef enum {
-    rv_op_illegal = 0,
-    rv_op_lui = 1,
-    rv_op_auipc = 2,
-    rv_op_jal = 3,
-    rv_op_jalr = 4,
-    rv_op_beq = 5,
-    rv_op_bne = 6,
-    rv_op_blt = 7,
-    rv_op_bge = 8,
-    rv_op_bltu = 9,
-    rv_op_bgeu = 10,
-    rv_op_lb = 11,
-    rv_op_lh = 12,
-    rv_op_lw = 13,
-    rv_op_lbu = 14,
-    rv_op_lhu = 15,
-    rv_op_sb = 16,
-    rv_op_sh = 17,
-    rv_op_sw = 18,
-    rv_op_addi = 19,
-    rv_op_slti = 20,
-    rv_op_sltiu = 21,
-    rv_op_xori = 22,
-    rv_op_ori = 23,
-    rv_op_andi = 24,
-    rv_op_slli = 25,
-    rv_op_srli = 26,
-    rv_op_srai = 27,
-    rv_op_add = 28,
-    rv_op_sub = 29,
-    rv_op_sll = 30,
-    rv_op_slt = 31,
-    rv_op_sltu = 32,
-    rv_op_xor = 33,
-    rv_op_srl = 34,
-    rv_op_sra = 35,
-    rv_op_or = 36,
-    rv_op_and = 37,
-    rv_op_fence = 38,
-    rv_op_fence_i = 39,
-    rv_op_lwu = 40,
-    rv_op_ld = 41,
-    rv_op_sd = 42,
-    rv_op_addiw = 43,
-    rv_op_slliw = 44,
-    rv_op_srliw = 45,
-    rv_op_sraiw = 46,
-    rv_op_addw = 47,
-    rv_op_subw = 48,
-    rv_op_sllw = 49,
-    rv_op_srlw = 50,
-    rv_op_sraw = 51,
-    rv_op_ldu = 52,
-    rv_op_lq = 53,
-    rv_op_sq = 54,
-    rv_op_addid = 55,
-    rv_op_sllid = 56,
-    rv_op_srlid = 57,
-    rv_op_sraid = 58,
-    rv_op_addd = 59,
-    rv_op_subd = 60,
-    rv_op_slld = 61,
-    rv_op_srld = 62,
-    rv_op_srad = 63,
-    rv_op_mul = 64,
-    rv_op_mulh = 65,
-    rv_op_mulhsu = 66,
-    rv_op_mulhu = 67,
-    rv_op_div = 68,
-    rv_op_divu = 69,
-    rv_op_rem = 70,
-    rv_op_remu = 71,
-    rv_op_mulw = 72,
-    rv_op_divw = 73,
-    rv_op_divuw = 74,
-    rv_op_remw = 75,
-    rv_op_remuw = 76,
-    rv_op_muld = 77,
-    rv_op_divd = 78,
-    rv_op_divud = 79,
-    rv_op_remd = 80,
-    rv_op_remud = 81,
-    rv_op_lr_w = 82,
-    rv_op_sc_w = 83,
-    rv_op_amoswap_w = 84,
-    rv_op_amoadd_w = 85,
-    rv_op_amoxor_w = 86,
-    rv_op_amoor_w = 87,
-    rv_op_amoand_w = 88,
-    rv_op_amomin_w = 89,
-    rv_op_amomax_w = 90,
-    rv_op_amominu_w = 91,
-    rv_op_amomaxu_w = 92,
-    rv_op_lr_d = 93,
-    rv_op_sc_d = 94,
-    rv_op_amoswap_d = 95,
-    rv_op_amoadd_d = 96,
-    rv_op_amoxor_d = 97,
-    rv_op_amoor_d = 98,
-    rv_op_amoand_d = 99,
-    rv_op_amomin_d = 100,
-    rv_op_amomax_d = 101,
-    rv_op_amominu_d = 102,
-    rv_op_amomaxu_d = 103,
-    rv_op_lr_q = 104,
-    rv_op_sc_q = 105,
-    rv_op_amoswap_q = 106,
-    rv_op_amoadd_q = 107,
-    rv_op_amoxor_q = 108,
-    rv_op_amoor_q = 109,
-    rv_op_amoand_q = 110,
-    rv_op_amomin_q = 111,
-    rv_op_amomax_q = 112,
-    rv_op_amominu_q = 113,
-    rv_op_amomaxu_q = 114,
-    rv_op_ecall = 115,
-    rv_op_ebreak = 116,
-    rv_op_uret = 117,
-    rv_op_sret = 118,
-    rv_op_hret = 119,
-    rv_op_mret = 120,
-    rv_op_dret = 121,
-    rv_op_sfence_vm = 122,
-    rv_op_sfence_vma = 123,
-    rv_op_wfi = 124,
-    rv_op_csrrw = 125,
-    rv_op_csrrs = 126,
-    rv_op_csrrc = 127,
-    rv_op_csrrwi = 128,
-    rv_op_csrrsi = 129,
-    rv_op_csrrci = 130,
-    rv_op_flw = 131,
-    rv_op_fsw = 132,
-    rv_op_fmadd_s = 133,
-    rv_op_fmsub_s = 134,
-    rv_op_fnmsub_s = 135,
-    rv_op_fnmadd_s = 136,
-    rv_op_fadd_s = 137,
-    rv_op_fsub_s = 138,
-    rv_op_fmul_s = 139,
-    rv_op_fdiv_s = 140,
-    rv_op_fsgnj_s = 141,
-    rv_op_fsgnjn_s = 142,
-    rv_op_fsgnjx_s = 143,
-    rv_op_fmin_s = 144,
-    rv_op_fmax_s = 145,
-    rv_op_fsqrt_s = 146,
-    rv_op_fle_s = 147,
-    rv_op_flt_s = 148,
-    rv_op_feq_s = 149,
-    rv_op_fcvt_w_s = 150,
-    rv_op_fcvt_wu_s = 151,
-    rv_op_fcvt_s_w = 152,
-    rv_op_fcvt_s_wu = 153,
-    rv_op_fmv_x_s = 154,
-    rv_op_fclass_s = 155,
-    rv_op_fmv_s_x = 156,
-    rv_op_fcvt_l_s = 157,
-    rv_op_fcvt_lu_s = 158,
-    rv_op_fcvt_s_l = 159,
-    rv_op_fcvt_s_lu = 160,
-    rv_op_fld = 161,
-    rv_op_fsd = 162,
-    rv_op_fmadd_d = 163,
-    rv_op_fmsub_d = 164,
-    rv_op_fnmsub_d = 165,
-    rv_op_fnmadd_d = 166,
-    rv_op_fadd_d = 167,
-    rv_op_fsub_d = 168,
-    rv_op_fmul_d = 169,
-    rv_op_fdiv_d = 170,
-    rv_op_fsgnj_d = 171,
-    rv_op_fsgnjn_d = 172,
-    rv_op_fsgnjx_d = 173,
-    rv_op_fmin_d = 174,
-    rv_op_fmax_d = 175,
-    rv_op_fcvt_s_d = 176,
-    rv_op_fcvt_d_s = 177,
-    rv_op_fsqrt_d = 178,
-    rv_op_fle_d = 179,
-    rv_op_flt_d = 180,
-    rv_op_feq_d = 181,
-    rv_op_fcvt_w_d = 182,
-    rv_op_fcvt_wu_d = 183,
-    rv_op_fcvt_d_w = 184,
-    rv_op_fcvt_d_wu = 185,
-    rv_op_fclass_d = 186,
-    rv_op_fcvt_l_d = 187,
-    rv_op_fcvt_lu_d = 188,
-    rv_op_fmv_x_d = 189,
-    rv_op_fcvt_d_l = 190,
-    rv_op_fcvt_d_lu = 191,
-    rv_op_fmv_d_x = 192,
-    rv_op_flq = 193,
-    rv_op_fsq = 194,
-    rv_op_fmadd_q = 195,
-    rv_op_fmsub_q = 196,
-    rv_op_fnmsub_q = 197,
-    rv_op_fnmadd_q = 198,
-    rv_op_fadd_q = 199,
-    rv_op_fsub_q = 200,
-    rv_op_fmul_q = 201,
-    rv_op_fdiv_q = 202,
-    rv_op_fsgnj_q = 203,
-    rv_op_fsgnjn_q = 204,
-    rv_op_fsgnjx_q = 205,
-    rv_op_fmin_q = 206,
-    rv_op_fmax_q = 207,
-    rv_op_fcvt_s_q = 208,
-    rv_op_fcvt_q_s = 209,
-    rv_op_fcvt_d_q = 210,
-    rv_op_fcvt_q_d = 211,
-    rv_op_fsqrt_q = 212,
-    rv_op_fle_q = 213,
-    rv_op_flt_q = 214,
-    rv_op_feq_q = 215,
-    rv_op_fcvt_w_q = 216,
-    rv_op_fcvt_wu_q = 217,
-    rv_op_fcvt_q_w = 218,
-    rv_op_fcvt_q_wu = 219,
-    rv_op_fclass_q = 220,
-    rv_op_fcvt_l_q = 221,
-    rv_op_fcvt_lu_q = 222,
-    rv_op_fcvt_q_l = 223,
-    rv_op_fcvt_q_lu = 224,
-    rv_op_fmv_x_q = 225,
-    rv_op_fmv_q_x = 226,
-    rv_op_c_addi4spn = 227,
-    rv_op_c_fld = 228,
-    rv_op_c_lw = 229,
-    rv_op_c_flw = 230,
-    rv_op_c_fsd = 231,
-    rv_op_c_sw = 232,
-    rv_op_c_fsw = 233,
-    rv_op_c_addi = 235,
-    rv_op_c_jal = 236,
-    rv_op_c_li = 237,
-    rv_op_c_addi16sp = 238,
-    rv_op_c_lui = 239,
-    rv_op_c_srli = 240,
-    rv_op_c_srai = 241,
-    rv_op_c_andi = 242,
-    rv_op_c_sub = 243,
-    rv_op_c_xor = 244,
-    rv_op_c_or = 245,
-    rv_op_c_and = 246,
-    rv_op_c_subw = 247,
-    rv_op_c_addw = 248,
-    rv_op_c_j = 249,
-    rv_op_c_beqz = 250,
-    rv_op_c_bnez = 251,
-    rv_op_c_slli = 252,
-    rv_op_c_fldsp = 253,
-    rv_op_c_lwsp = 254,
-    rv_op_c_flwsp = 255,
-    rv_op_c_jr = 256,
-    rv_op_c_mv = 257,
-    rv_op_c_ebreak = 258,
-    rv_op_c_jalr = 259,
-    rv_op_c_add = 260,
-    rv_op_c_fsdsp = 261,
-    rv_op_c_swsp = 262,
-    rv_op_c_fswsp = 263,
-    rv_op_c_ld = 264,
-    rv_op_c_sd = 265,
-    rv_op_c_addiw = 266,
-    rv_op_c_ldsp = 267,
-    rv_op_c_sdsp = 268,
-    rv_op_c_lq = 269,
-    rv_op_c_sq = 270,
-    rv_op_c_lqsp = 271,
-    rv_op_c_sqsp = 272,
-    rv_op_nop = 273,
-    rv_op_mv = 274,
-    rv_op_not = 275,
-    rv_op_neg = 276,
-    rv_op_negw = 277,
-    rv_op_sext_w = 278,
-    rv_op_seqz = 279,
-    rv_op_snez = 280,
-    rv_op_sltz = 281,
-    rv_op_sgtz = 282,
-    rv_op_fmv_s = 283,
-    rv_op_fabs_s = 284,
-    rv_op_fneg_s = 285,
-    rv_op_fmv_d = 286,
-    rv_op_fabs_d = 287,
-    rv_op_fneg_d = 288,
-    rv_op_fmv_q = 289,
-    rv_op_fabs_q = 290,
-    rv_op_fneg_q = 291,
-    rv_op_beqz = 292,
-    rv_op_bnez = 293,
-    rv_op_blez = 294,
-    rv_op_bgez = 295,
-    rv_op_bltz = 296,
-    rv_op_bgtz = 297,
-    rv_op_jal_ra = 298,
-    rv_op_jalr_ra = 299,
-    rv_op_j = 302,
-    rv_op_ret = 303,
-    rv_op_jr = 304,
-    rv_op_rdcycle = 305,
-    rv_op_rdtime = 306,
-    rv_op_rdinstret = 307,
-    rv_op_rdcycleh = 308,
-    rv_op_rdtimeh = 309,
-    rv_op_rdinstreth = 310,
-    rv_op_frcsr = 311,
-    rv_op_frrm = 312,
-    rv_op_frflags = 313,
-    rv_op_fscsr = 314,
-    rv_op_fsrm = 315,
-    rv_op_fsflags = 316,
-    rv_op_fsrmi = 317,
-    rv_op_fsflagsi = 318,
-    rv_op_bseti = 319,
-    rv_op_bclri = 320,
-    rv_op_binvi = 321,
-    rv_op_bexti = 322,
-    rv_op_rori = 323,
-    rv_op_clz = 324,
-    rv_op_ctz = 325,
-    rv_op_cpop = 326,
-    rv_op_sext_h = 327,
-    rv_op_sext_b = 328,
-    rv_op_xnor = 329,
-    rv_op_orn = 330,
-    rv_op_andn = 331,
-    rv_op_rol = 332,
-    rv_op_ror = 333,
-    rv_op_sh1add = 334,
-    rv_op_sh2add = 335,
-    rv_op_sh3add = 336,
-    rv_op_sh1add_uw = 337,
-    rv_op_sh2add_uw = 338,
-    rv_op_sh3add_uw = 339,
-    rv_op_clmul = 340,
-    rv_op_clmulr = 341,
-    rv_op_clmulh = 342,
-    rv_op_min = 343,
-    rv_op_minu = 344,
-    rv_op_max = 345,
-    rv_op_maxu = 346,
-    rv_op_clzw = 347,
-    rv_op_ctzw = 348,
-    rv_op_cpopw = 349,
-    rv_op_slli_uw = 350,
-    rv_op_add_uw = 351,
-    rv_op_rolw = 352,
-    rv_op_rorw = 353,
-    rv_op_rev8 = 354,
-    rv_op_zext_h = 355,
-    rv_op_roriw = 356,
-    rv_op_orc_b = 357,
-    rv_op_bset = 358,
-    rv_op_bclr = 359,
-    rv_op_binv = 360,
-    rv_op_bext = 361,
-    rv_op_aes32esmi = 362,
-    rv_op_aes32esi = 363,
-    rv_op_aes32dsmi = 364,
-    rv_op_aes32dsi = 365,
-    rv_op_aes64ks1i = 366,
-    rv_op_aes64ks2 = 367,
-    rv_op_aes64im = 368,
-    rv_op_aes64esm = 369,
-    rv_op_aes64es = 370,
-    rv_op_aes64dsm = 371,
-    rv_op_aes64ds = 372,
-    rv_op_sha256sig0 = 373,
-    rv_op_sha256sig1 = 374,
-    rv_op_sha256sum0 = 375,
-    rv_op_sha256sum1 = 376,
-    rv_op_sha512sig0 = 377,
-    rv_op_sha512sig1 = 378,
-    rv_op_sha512sum0 = 379,
-    rv_op_sha512sum1 = 380,
-    rv_op_sha512sum0r = 381,
-    rv_op_sha512sum1r = 382,
-    rv_op_sha512sig0l = 383,
-    rv_op_sha512sig0h = 384,
-    rv_op_sha512sig1l = 385,
-    rv_op_sha512sig1h = 386,
-    rv_op_sm3p0 = 387,
-    rv_op_sm3p1 = 388,
-    rv_op_sm4ed = 389,
-    rv_op_sm4ks = 390,
-    rv_op_brev8 = 391,
-    rv_op_pack = 392,
-    rv_op_packh = 393,
-    rv_op_packw = 394,
-    rv_op_unzip = 395,
-    rv_op_zip = 396,
-    rv_op_xperm4 = 397,
-    rv_op_xperm8 = 398,
-    rv_op_vle8_v = 399,
-    rv_op_vle16_v = 400,
-    rv_op_vle32_v = 401,
-    rv_op_vle64_v = 402,
-    rv_op_vse8_v = 403,
-    rv_op_vse16_v = 404,
-    rv_op_vse32_v = 405,
-    rv_op_vse64_v = 406,
-    rv_op_vlm_v = 407,
-    rv_op_vsm_v = 408,
-    rv_op_vlse8_v = 409,
-    rv_op_vlse16_v = 410,
-    rv_op_vlse32_v = 411,
-    rv_op_vlse64_v = 412,
-    rv_op_vsse8_v = 413,
-    rv_op_vsse16_v = 414,
-    rv_op_vsse32_v = 415,
-    rv_op_vsse64_v = 416,
-    rv_op_vluxei8_v = 417,
-    rv_op_vluxei16_v = 418,
-    rv_op_vluxei32_v = 419,
-    rv_op_vluxei64_v = 420,
-    rv_op_vloxei8_v = 421,
-    rv_op_vloxei16_v = 422,
-    rv_op_vloxei32_v = 423,
-    rv_op_vloxei64_v = 424,
-    rv_op_vsuxei8_v = 425,
-    rv_op_vsuxei16_v = 426,
-    rv_op_vsuxei32_v = 427,
-    rv_op_vsuxei64_v = 428,
-    rv_op_vsoxei8_v = 429,
-    rv_op_vsoxei16_v = 430,
-    rv_op_vsoxei32_v = 431,
-    rv_op_vsoxei64_v = 432,
-    rv_op_vle8ff_v = 433,
-    rv_op_vle16ff_v = 434,
-    rv_op_vle32ff_v = 435,
-    rv_op_vle64ff_v = 436,
-    rv_op_vl1re8_v = 437,
-    rv_op_vl1re16_v = 438,
-    rv_op_vl1re32_v = 439,
-    rv_op_vl1re64_v = 440,
-    rv_op_vl2re8_v = 441,
-    rv_op_vl2re16_v = 442,
-    rv_op_vl2re32_v = 443,
-    rv_op_vl2re64_v = 444,
-    rv_op_vl4re8_v = 445,
-    rv_op_vl4re16_v = 446,
-    rv_op_vl4re32_v = 447,
-    rv_op_vl4re64_v = 448,
-    rv_op_vl8re8_v = 449,
-    rv_op_vl8re16_v = 450,
-    rv_op_vl8re32_v = 451,
-    rv_op_vl8re64_v = 452,
-    rv_op_vs1r_v = 453,
-    rv_op_vs2r_v = 454,
-    rv_op_vs4r_v = 455,
-    rv_op_vs8r_v = 456,
-    rv_op_vadd_vv = 457,
-    rv_op_vadd_vx = 458,
-    rv_op_vadd_vi = 459,
-    rv_op_vsub_vv = 460,
-    rv_op_vsub_vx = 461,
-    rv_op_vrsub_vx = 462,
-    rv_op_vrsub_vi = 463,
-    rv_op_vwaddu_vv = 464,
-    rv_op_vwaddu_vx = 465,
-    rv_op_vwadd_vv = 466,
-    rv_op_vwadd_vx = 467,
-    rv_op_vwsubu_vv = 468,
-    rv_op_vwsubu_vx = 469,
-    rv_op_vwsub_vv = 470,
-    rv_op_vwsub_vx = 471,
-    rv_op_vwaddu_wv = 472,
-    rv_op_vwaddu_wx = 473,
-    rv_op_vwadd_wv = 474,
-    rv_op_vwadd_wx = 475,
-    rv_op_vwsubu_wv = 476,
-    rv_op_vwsubu_wx = 477,
-    rv_op_vwsub_wv = 478,
-    rv_op_vwsub_wx = 479,
-    rv_op_vadc_vvm = 480,
-    rv_op_vadc_vxm = 481,
-    rv_op_vadc_vim = 482,
-    rv_op_vmadc_vvm = 483,
-    rv_op_vmadc_vxm = 484,
-    rv_op_vmadc_vim = 485,
-    rv_op_vsbc_vvm = 486,
-    rv_op_vsbc_vxm = 487,
-    rv_op_vmsbc_vvm = 488,
-    rv_op_vmsbc_vxm = 489,
-    rv_op_vand_vv = 490,
-    rv_op_vand_vx = 491,
-    rv_op_vand_vi = 492,
-    rv_op_vor_vv = 493,
-    rv_op_vor_vx = 494,
-    rv_op_vor_vi = 495,
-    rv_op_vxor_vv = 496,
-    rv_op_vxor_vx = 497,
-    rv_op_vxor_vi = 498,
-    rv_op_vsll_vv = 499,
-    rv_op_vsll_vx = 500,
-    rv_op_vsll_vi = 501,
-    rv_op_vsrl_vv = 502,
-    rv_op_vsrl_vx = 503,
-    rv_op_vsrl_vi = 504,
-    rv_op_vsra_vv = 505,
-    rv_op_vsra_vx = 506,
-    rv_op_vsra_vi = 507,
-    rv_op_vnsrl_wv = 508,
-    rv_op_vnsrl_wx = 509,
-    rv_op_vnsrl_wi = 510,
-    rv_op_vnsra_wv = 511,
-    rv_op_vnsra_wx = 512,
-    rv_op_vnsra_wi = 513,
-    rv_op_vmseq_vv = 514,
-    rv_op_vmseq_vx = 515,
-    rv_op_vmseq_vi = 516,
-    rv_op_vmsne_vv = 517,
-    rv_op_vmsne_vx = 518,
-    rv_op_vmsne_vi = 519,
-    rv_op_vmsltu_vv = 520,
-    rv_op_vmsltu_vx = 521,
-    rv_op_vmslt_vv = 522,
-    rv_op_vmslt_vx = 523,
-    rv_op_vmsleu_vv = 524,
-    rv_op_vmsleu_vx = 525,
-    rv_op_vmsleu_vi = 526,
-    rv_op_vmsle_vv = 527,
-    rv_op_vmsle_vx = 528,
-    rv_op_vmsle_vi = 529,
-    rv_op_vmsgtu_vx = 530,
-    rv_op_vmsgtu_vi = 531,
-    rv_op_vmsgt_vx = 532,
-    rv_op_vmsgt_vi = 533,
-    rv_op_vminu_vv = 534,
-    rv_op_vminu_vx = 535,
-    rv_op_vmin_vv = 536,
-    rv_op_vmin_vx = 537,
-    rv_op_vmaxu_vv = 538,
-    rv_op_vmaxu_vx = 539,
-    rv_op_vmax_vv = 540,
-    rv_op_vmax_vx = 541,
-    rv_op_vmul_vv = 542,
-    rv_op_vmul_vx = 543,
-    rv_op_vmulh_vv = 544,
-    rv_op_vmulh_vx = 545,
-    rv_op_vmulhu_vv = 546,
-    rv_op_vmulhu_vx = 547,
-    rv_op_vmulhsu_vv = 548,
-    rv_op_vmulhsu_vx = 549,
-    rv_op_vdivu_vv = 550,
-    rv_op_vdivu_vx = 551,
-    rv_op_vdiv_vv = 552,
-    rv_op_vdiv_vx = 553,
-    rv_op_vremu_vv = 554,
-    rv_op_vremu_vx = 555,
-    rv_op_vrem_vv = 556,
-    rv_op_vrem_vx = 557,
-    rv_op_vwmulu_vv = 558,
-    rv_op_vwmulu_vx = 559,
-    rv_op_vwmulsu_vv = 560,
-    rv_op_vwmulsu_vx = 561,
-    rv_op_vwmul_vv = 562,
-    rv_op_vwmul_vx = 563,
-    rv_op_vmacc_vv = 564,
-    rv_op_vmacc_vx = 565,
-    rv_op_vnmsac_vv = 566,
-    rv_op_vnmsac_vx = 567,
-    rv_op_vmadd_vv = 568,
-    rv_op_vmadd_vx = 569,
-    rv_op_vnmsub_vv = 570,
-    rv_op_vnmsub_vx = 571,
-    rv_op_vwmaccu_vv = 572,
-    rv_op_vwmaccu_vx = 573,
-    rv_op_vwmacc_vv = 574,
-    rv_op_vwmacc_vx = 575,
-    rv_op_vwmaccsu_vv = 576,
-    rv_op_vwmaccsu_vx = 577,
-    rv_op_vwmaccus_vx = 578,
-    rv_op_vmv_v_v = 579,
-    rv_op_vmv_v_x = 580,
-    rv_op_vmv_v_i = 581,
-    rv_op_vmerge_vvm = 582,
-    rv_op_vmerge_vxm = 583,
-    rv_op_vmerge_vim = 584,
-    rv_op_vsaddu_vv = 585,
-    rv_op_vsaddu_vx = 586,
-    rv_op_vsaddu_vi = 587,
-    rv_op_vsadd_vv = 588,
-    rv_op_vsadd_vx = 589,
-    rv_op_vsadd_vi = 590,
-    rv_op_vssubu_vv = 591,
-    rv_op_vssubu_vx = 592,
-    rv_op_vssub_vv = 593,
-    rv_op_vssub_vx = 594,
-    rv_op_vaadd_vv = 595,
-    rv_op_vaadd_vx = 596,
-    rv_op_vaaddu_vv = 597,
-    rv_op_vaaddu_vx = 598,
-    rv_op_vasub_vv = 599,
-    rv_op_vasub_vx = 600,
-    rv_op_vasubu_vv = 601,
-    rv_op_vasubu_vx = 602,
-    rv_op_vsmul_vv = 603,
-    rv_op_vsmul_vx = 604,
-    rv_op_vssrl_vv = 605,
-    rv_op_vssrl_vx = 606,
-    rv_op_vssrl_vi = 607,
-    rv_op_vssra_vv = 608,
-    rv_op_vssra_vx = 609,
-    rv_op_vssra_vi = 610,
-    rv_op_vnclipu_wv = 611,
-    rv_op_vnclipu_wx = 612,
-    rv_op_vnclipu_wi = 613,
-    rv_op_vnclip_wv = 614,
-    rv_op_vnclip_wx = 615,
-    rv_op_vnclip_wi = 616,
-    rv_op_vfadd_vv = 617,
-    rv_op_vfadd_vf = 618,
-    rv_op_vfsub_vv = 619,
-    rv_op_vfsub_vf = 620,
-    rv_op_vfrsub_vf = 621,
-    rv_op_vfwadd_vv = 622,
-    rv_op_vfwadd_vf = 623,
-    rv_op_vfwadd_wv = 624,
-    rv_op_vfwadd_wf = 625,
-    rv_op_vfwsub_vv = 626,
-    rv_op_vfwsub_vf = 627,
-    rv_op_vfwsub_wv = 628,
-    rv_op_vfwsub_wf = 629,
-    rv_op_vfmul_vv = 630,
-    rv_op_vfmul_vf = 631,
-    rv_op_vfdiv_vv = 632,
-    rv_op_vfdiv_vf = 633,
-    rv_op_vfrdiv_vf = 634,
-    rv_op_vfwmul_vv = 635,
-    rv_op_vfwmul_vf = 636,
-    rv_op_vfmacc_vv = 637,
-    rv_op_vfmacc_vf = 638,
-    rv_op_vfnmacc_vv = 639,
-    rv_op_vfnmacc_vf = 640,
-    rv_op_vfmsac_vv = 641,
-    rv_op_vfmsac_vf = 642,
-    rv_op_vfnmsac_vv = 643,
-    rv_op_vfnmsac_vf = 644,
-    rv_op_vfmadd_vv = 645,
-    rv_op_vfmadd_vf = 646,
-    rv_op_vfnmadd_vv = 647,
-    rv_op_vfnmadd_vf = 648,
-    rv_op_vfmsub_vv = 649,
-    rv_op_vfmsub_vf = 650,
-    rv_op_vfnmsub_vv = 651,
-    rv_op_vfnmsub_vf = 652,
-    rv_op_vfwmacc_vv = 653,
-    rv_op_vfwmacc_vf = 654,
-    rv_op_vfwnmacc_vv = 655,
-    rv_op_vfwnmacc_vf = 656,
-    rv_op_vfwmsac_vv = 657,
-    rv_op_vfwmsac_vf = 658,
-    rv_op_vfwnmsac_vv = 659,
-    rv_op_vfwnmsac_vf = 660,
-    rv_op_vfsqrt_v = 661,
-    rv_op_vfrsqrt7_v = 662,
-    rv_op_vfrec7_v = 663,
-    rv_op_vfmin_vv = 664,
-    rv_op_vfmin_vf = 665,
-    rv_op_vfmax_vv = 666,
-    rv_op_vfmax_vf = 667,
-    rv_op_vfsgnj_vv = 668,
-    rv_op_vfsgnj_vf = 669,
-    rv_op_vfsgnjn_vv = 670,
-    rv_op_vfsgnjn_vf = 671,
-    rv_op_vfsgnjx_vv = 672,
-    rv_op_vfsgnjx_vf = 673,
-    rv_op_vfslide1up_vf = 674,
-    rv_op_vfslide1down_vf = 675,
-    rv_op_vmfeq_vv = 676,
-    rv_op_vmfeq_vf = 677,
-    rv_op_vmfne_vv = 678,
-    rv_op_vmfne_vf = 679,
-    rv_op_vmflt_vv = 680,
-    rv_op_vmflt_vf = 681,
-    rv_op_vmfle_vv = 682,
-    rv_op_vmfle_vf = 683,
-    rv_op_vmfgt_vf = 684,
-    rv_op_vmfge_vf = 685,
-    rv_op_vfclass_v = 686,
-    rv_op_vfmerge_vfm = 687,
-    rv_op_vfmv_v_f = 688,
-    rv_op_vfcvt_xu_f_v = 689,
-    rv_op_vfcvt_x_f_v = 690,
-    rv_op_vfcvt_f_xu_v = 691,
-    rv_op_vfcvt_f_x_v = 692,
-    rv_op_vfcvt_rtz_xu_f_v = 693,
-    rv_op_vfcvt_rtz_x_f_v = 694,
-    rv_op_vfwcvt_xu_f_v = 695,
-    rv_op_vfwcvt_x_f_v = 696,
-    rv_op_vfwcvt_f_xu_v = 697,
-    rv_op_vfwcvt_f_x_v = 698,
-    rv_op_vfwcvt_f_f_v = 699,
-    rv_op_vfwcvt_rtz_xu_f_v = 700,
-    rv_op_vfwcvt_rtz_x_f_v = 701,
-    rv_op_vfncvt_xu_f_w = 702,
-    rv_op_vfncvt_x_f_w = 703,
-    rv_op_vfncvt_f_xu_w = 704,
-    rv_op_vfncvt_f_x_w = 705,
-    rv_op_vfncvt_f_f_w = 706,
-    rv_op_vfncvt_rod_f_f_w = 707,
-    rv_op_vfncvt_rtz_xu_f_w = 708,
-    rv_op_vfncvt_rtz_x_f_w = 709,
-    rv_op_vredsum_vs = 710,
-    rv_op_vredand_vs = 711,
-    rv_op_vredor_vs = 712,
-    rv_op_vredxor_vs = 713,
-    rv_op_vredminu_vs = 714,
-    rv_op_vredmin_vs = 715,
-    rv_op_vredmaxu_vs = 716,
-    rv_op_vredmax_vs = 717,
-    rv_op_vwredsumu_vs = 718,
-    rv_op_vwredsum_vs = 719,
-    rv_op_vfredusum_vs = 720,
-    rv_op_vfredosum_vs = 721,
-    rv_op_vfredmin_vs = 722,
-    rv_op_vfredmax_vs = 723,
-    rv_op_vfwredusum_vs = 724,
-    rv_op_vfwredosum_vs = 725,
-    rv_op_vmand_mm = 726,
-    rv_op_vmnand_mm = 727,
-    rv_op_vmandn_mm = 728,
-    rv_op_vmxor_mm = 729,
-    rv_op_vmor_mm = 730,
-    rv_op_vmnor_mm = 731,
-    rv_op_vmorn_mm = 732,
-    rv_op_vmxnor_mm = 733,
-    rv_op_vcpop_m = 734,
-    rv_op_vfirst_m = 735,
-    rv_op_vmsbf_m = 736,
-    rv_op_vmsif_m = 737,
-    rv_op_vmsof_m = 738,
-    rv_op_viota_m = 739,
-    rv_op_vid_v = 740,
-    rv_op_vmv_x_s = 741,
-    rv_op_vmv_s_x = 742,
-    rv_op_vfmv_f_s = 743,
-    rv_op_vfmv_s_f = 744,
-    rv_op_vslideup_vx = 745,
-    rv_op_vslideup_vi = 746,
-    rv_op_vslide1up_vx = 747,
-    rv_op_vslidedown_vx = 748,
-    rv_op_vslidedown_vi = 749,
-    rv_op_vslide1down_vx = 750,
-    rv_op_vrgather_vv = 751,
-    rv_op_vrgatherei16_vv = 752,
-    rv_op_vrgather_vx = 753,
-    rv_op_vrgather_vi = 754,
-    rv_op_vcompress_vm = 755,
-    rv_op_vmv1r_v = 756,
-    rv_op_vmv2r_v = 757,
-    rv_op_vmv4r_v = 758,
-    rv_op_vmv8r_v = 759,
-    rv_op_vzext_vf2 = 760,
-    rv_op_vzext_vf4 = 761,
-    rv_op_vzext_vf8 = 762,
-    rv_op_vsext_vf2 = 763,
-    rv_op_vsext_vf4 = 764,
-    rv_op_vsext_vf8 = 765,
-    rv_op_vsetvli = 766,
-    rv_op_vsetivli = 767,
-    rv_op_vsetvl = 768,
-    rv_op_c_zext_b = 769,
-    rv_op_c_sext_b = 770,
-    rv_op_c_zext_h = 771,
-    rv_op_c_sext_h = 772,
-    rv_op_c_zext_w = 773,
-    rv_op_c_not = 774,
-    rv_op_c_mul = 775,
-    rv_op_c_lbu = 776,
-    rv_op_c_lhu = 777,
-    rv_op_c_lh = 778,
-    rv_op_c_sb = 779,
-    rv_op_c_sh = 780,
-    rv_op_cm_push = 781,
-    rv_op_cm_pop = 782,
-    rv_op_cm_popret = 783,
-    rv_op_cm_popretz = 784,
-    rv_op_cm_mva01s = 785,
-    rv_op_cm_mvsa01 = 786,
-    rv_op_cm_jt = 787,
-    rv_op_cm_jalt = 788,
-    rv_op_czero_eqz = 789,
-    rv_op_czero_nez = 790,
-    rv_op_fcvt_bf16_s = 791,
-    rv_op_fcvt_s_bf16 = 792,
-    rv_op_vfncvtbf16_f_f_w = 793,
-    rv_op_vfwcvtbf16_f_f_v = 794,
-    rv_op_vfwmaccbf16_vv = 795,
-    rv_op_vfwmaccbf16_vf = 796,
-    rv_op_flh = 797,
-    rv_op_fsh = 798,
-    rv_op_fmv_h_x = 799,
-    rv_op_fmv_x_h = 800,
-    rv_op_fli_s = 801,
-    rv_op_fli_d = 802,
-    rv_op_fli_q = 803,
-    rv_op_fli_h = 804,
-    rv_op_fminm_s = 805,
-    rv_op_fmaxm_s = 806,
-    rv_op_fminm_d = 807,
-    rv_op_fmaxm_d = 808,
-    rv_op_fminm_q = 809,
-    rv_op_fmaxm_q = 810,
-    rv_op_fminm_h = 811,
-    rv_op_fmaxm_h = 812,
-    rv_op_fround_s = 813,
-    rv_op_froundnx_s = 814,
-    rv_op_fround_d = 815,
-    rv_op_froundnx_d = 816,
-    rv_op_fround_q = 817,
-    rv_op_froundnx_q = 818,
-    rv_op_fround_h = 819,
-    rv_op_froundnx_h = 820,
-    rv_op_fcvtmod_w_d = 821,
-    rv_op_fmvh_x_d = 822,
-    rv_op_fmvp_d_x = 823,
-    rv_op_fmvh_x_q = 824,
-    rv_op_fmvp_q_x = 825,
-    rv_op_fleq_s = 826,
-    rv_op_fltq_s = 827,
-    rv_op_fleq_d = 828,
-    rv_op_fltq_d = 829,
-    rv_op_fleq_q = 830,
-    rv_op_fltq_q = 831,
-    rv_op_fleq_h = 832,
-    rv_op_fltq_h = 833,
-    rv_op_vaesdf_vv = 834,
-    rv_op_vaesdf_vs = 835,
-    rv_op_vaesdm_vv = 836,
-    rv_op_vaesdm_vs = 837,
-    rv_op_vaesef_vv = 838,
-    rv_op_vaesef_vs = 839,
-    rv_op_vaesem_vv = 840,
-    rv_op_vaesem_vs = 841,
-    rv_op_vaeskf1_vi = 842,
-    rv_op_vaeskf2_vi = 843,
-    rv_op_vaesz_vs = 844,
-    rv_op_vandn_vv = 845,
-    rv_op_vandn_vx = 846,
-    rv_op_vbrev_v = 847,
-    rv_op_vbrev8_v = 848,
-    rv_op_vclmul_vv = 849,
-    rv_op_vclmul_vx = 850,
-    rv_op_vclmulh_vv = 851,
-    rv_op_vclmulh_vx = 852,
-    rv_op_vclz_v = 853,
-    rv_op_vcpop_v = 854,
-    rv_op_vctz_v = 855,
-    rv_op_vghsh_vv = 856,
-    rv_op_vgmul_vv = 857,
-    rv_op_vrev8_v = 858,
-    rv_op_vrol_vv = 859,
-    rv_op_vrol_vx = 860,
-    rv_op_vror_vv = 861,
-    rv_op_vror_vx = 862,
-    rv_op_vror_vi = 863,
-    rv_op_vsha2ch_vv = 864,
-    rv_op_vsha2cl_vv = 865,
-    rv_op_vsha2ms_vv = 866,
-    rv_op_vsm3c_vi = 867,
-    rv_op_vsm3me_vv = 868,
-    rv_op_vsm4k_vi = 869,
-    rv_op_vsm4r_vv = 870,
-    rv_op_vsm4r_vs = 871,
-    rv_op_vwsll_vv = 872,
-    rv_op_vwsll_vx = 873,
-    rv_op_vwsll_vi = 874,
-    rv_op_amocas_w = 875,
-    rv_op_amocas_d = 876,
-    rv_op_amocas_q = 877,
-    rv_mop_r_0     = 878,
-    rv_mop_r_1     = 879,
-    rv_mop_r_2     = 880,
-    rv_mop_r_3     = 881,
-    rv_mop_r_4     = 882,
-    rv_mop_r_5     = 883,
-    rv_mop_r_6     = 884,
-    rv_mop_r_7     = 885,
-    rv_mop_r_8     = 886,
-    rv_mop_r_9     = 887,
-    rv_mop_r_10    = 888,
-    rv_mop_r_11    = 889,
-    rv_mop_r_12    = 890,
-    rv_mop_r_13    = 891,
-    rv_mop_r_14    = 892,
-    rv_mop_r_15    = 893,
-    rv_mop_r_16    = 894,
-    rv_mop_r_17    = 895,
-    rv_mop_r_18    = 896,
-    rv_mop_r_19    = 897,
-    rv_mop_r_20    = 898,
-    rv_mop_r_21    = 899,
-    rv_mop_r_22    = 900,
-    rv_mop_r_23    = 901,
-    rv_mop_r_24    = 902,
-    rv_mop_r_25    = 903,
-    rv_mop_r_26    = 904,
-    rv_mop_r_27    = 905,
-    rv_mop_r_28    = 906,
-    rv_mop_r_29    = 907,
-    rv_mop_r_30    = 908,
-    rv_mop_r_31    = 909,
-    rv_mop_rr_0    = 910,
-    rv_mop_rr_1    = 911,
-    rv_mop_rr_2    = 912,
-    rv_mop_rr_3    = 913,
-    rv_mop_rr_4    = 914,
-    rv_mop_rr_5    = 915,
-    rv_mop_rr_6    = 916,
-    rv_mop_rr_7    = 917,
-    rv_c_mop_1     = 918,
-    rv_c_mop_3     = 919,
-    rv_c_mop_5     = 920,
-    rv_c_mop_7     = 921,
-    rv_c_mop_9     = 922,
-    rv_c_mop_11    = 923,
-    rv_c_mop_13    = 924,
-    rv_c_mop_15    = 925,
-    rv_op_amoswap_b = 926,
-    rv_op_amoadd_b  = 927,
-    rv_op_amoxor_b  = 928,
-    rv_op_amoor_b   = 929,
-    rv_op_amoand_b  = 930,
-    rv_op_amomin_b  = 931,
-    rv_op_amomax_b  = 932,
-    rv_op_amominu_b = 933,
-    rv_op_amomaxu_b = 934,
-    rv_op_amoswap_h = 935,
-    rv_op_amoadd_h  = 936,
-    rv_op_amoxor_h  = 937,
-    rv_op_amoor_h   = 938,
-    rv_op_amoand_h  = 939,
-    rv_op_amomin_h  = 940,
-    rv_op_amomax_h  = 941,
-    rv_op_amominu_h = 942,
-    rv_op_amomaxu_h = 943,
-    rv_op_amocas_b  = 944,
-    rv_op_amocas_h  = 945,
-    rv_op_wrs_sto = 946,
-    rv_op_wrs_nto = 947,
-    rv_op_lpad = 948,
-    rv_op_sspush = 949,
-    rv_op_sspopchk = 950,
-    rv_op_ssrdp = 951,
-    rv_op_ssamoswap_w = 952,
-    rv_op_ssamoswap_d = 953,
-    rv_op_c_sspush = 954,
-    rv_op_c_sspopchk = 955,
-    rv_op_cbo_inval = 956,
-    rv_op_cbo_clean = 957,
-    rv_op_cbo_flush = 958,
-    rv_op_cbo_zero = 959,
-    rv_op_mnret = 960,
+#define OP(N, ...) rv_op_##N,
+#include "riscv-op.c.inc"
+#undef OP
 } rv_op;
 
 /* register names */
@@ -1601,967 +646,9 @@ static uint32_t operand_lpl(rv_inst inst)
 /* instruction metadata */
 
 static const rv_opcode_data rvi_opcode_data[] = {
-    { "illegal", rv_codec_none, rv_fmt_none },
-    { "lui", rv_codec_u, rv_fmt_rd_uimm },
-    { "auipc", rv_codec_u, rv_fmt_rd_uoffset },
-    { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal },
-    { "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr },
-    { "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq },
-    { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne },
-    { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt },
-    { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge },
-    { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
-    { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
-    { "lb", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "lh", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "lw", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "lbu", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "lhu", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "sb", rv_codec_s, rv_fmt_rs2_offset_rs1 },
-    { "sh", rv_codec_s, rv_fmt_rs2_offset_rs1 },
-    { "sw", rv_codec_s, rv_fmt_rs2_offset_rs1 },
-    { "addi", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addi },
-    { "slti", rv_codec_i, rv_fmt_rd_rs1_imm },
-    { "sltiu", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_sltiu },
-    { "xori", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_xori },
-    { "ori", rv_codec_i, rv_fmt_rd_rs1_imm },
-    { "andi", rv_codec_i, rv_fmt_rd_rs1_imm },
-    { "slli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "srli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "srai", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sub", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sub },
-    { "sll", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "slt", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_slt },
-    { "sltu", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sltu },
-    { "xor", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "srl", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sra", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "or", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "and", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "fence", rv_codec_r_f, rv_fmt_pred_succ },
-    { "fence.i", rv_codec_none, rv_fmt_none },
-    { "lwu", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "ld", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "sd", rv_codec_s, rv_fmt_rs2_offset_rs1 },
-    { "addiw", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addiw },
-    { "slliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
-    { "srliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
-    { "sraiw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
-    { "addw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "subw", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_subw },
-    { "sllw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "srlw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sraw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "ldu", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "lq", rv_codec_i, rv_fmt_rd_offset_rs1 },
-    { "sq", rv_codec_s, rv_fmt_rs2_offset_rs1 },
-    { "addid", rv_codec_i, rv_fmt_rd_rs1_imm },
-    { "sllid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
-    { "srlid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
-    { "sraid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
-    { "addd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "subd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "slld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "srld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "srad", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mul", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mulh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mulhsu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mulhu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "div", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "divu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "rem", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "remu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mulw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "divw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "divuw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "remw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "remuw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "muld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "divd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "divud", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "remd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "remud", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "lr.w", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
-    { "sc.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoadd.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoxor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoand.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomin.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomax.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amominu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomaxu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "lr.d", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
-    { "sc.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoadd.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoxor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoand.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomin.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomax.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amominu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomaxu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "lr.q", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
-    { "sc.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoadd.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoxor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoand.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomin.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomax.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amominu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomaxu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "ecall", rv_codec_none, rv_fmt_none },
-    { "ebreak", rv_codec_none, rv_fmt_none },
-    { "uret", rv_codec_none, rv_fmt_none },
-    { "sret", rv_codec_none, rv_fmt_none },
-    { "hret", rv_codec_none, rv_fmt_none },
-    { "mret", rv_codec_none, rv_fmt_none },
-    { "dret", rv_codec_none, rv_fmt_none },
-    { "sfence.vm", rv_codec_r, rv_fmt_rs1 },
-    { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
-    { "wfi", rv_codec_none, rv_fmt_none },
-    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
-    { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
-    { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
-    { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
-    { "flw", rv_codec_i, rv_fmt_frd_offset_rs1 },
-    { "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1 },
-    { "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_s },
-    { "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_s },
-    { "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_s },
-    { "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fclass.s", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fld", rv_codec_i, rv_fmt_frd_offset_rs1 },
-    { "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1 },
-    { "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_d },
-    { "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_d },
-    { "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_d },
-    { "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fclass.d", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "flq", rv_codec_i, rv_fmt_frd_offset_rs1 },
-    { "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1 },
-    { "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3 },
-    { "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
-    { "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_q },
-    { "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_q },
-    { "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_q },
-    { "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fclass.q", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
-    { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op_addi) },
-    { "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld) },
-    { "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw) },
-    { "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw) },
-    { "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd) },
-    { "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw) },
-    { "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw) },
-    { },
-    { "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi) },
-    { "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal) },
-    { "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi) },
-    { "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_addi) },
-    { "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui) },
-    { "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli) },
-    { "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai) },
-    { "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi) },
-    { "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub) },
-    { "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor) },
-    { "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or) },
-    { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
-    { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
-    { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
-    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j) },
-    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz) },
-    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez) },
-    { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli) },
-    { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld) },
-    { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) },
-    { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw) },
-    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr) },
-    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv) },
-    { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak) },
-    { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr) },
-    { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
-    { "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fsd) },
-    { "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw) },
-    { "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fsw) },
-    { "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld) },
-    { "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd) },
-    { "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw) },
-    { "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld) },
-    { "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd) },
-    { "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq) },
-    { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
-    { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
-    { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
-    { "nop", rv_codec_illegal, rv_fmt_none },
-    { "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv },
-    { "not", rv_codec_illegal, rv_fmt_rd_rs1 },
-    { "neg", rv_codec_illegal, rv_fmt_rd_rs2 },
-    { "negw", rv_codec_illegal, rv_fmt_rd_rs2 },
-    { "sext.w", rv_codec_illegal, rv_fmt_rd_rs1 },
-    { "seqz", rv_codec_illegal, rv_fmt_rd_rs1 },
-    { "snez", rv_codec_illegal, rv_fmt_rd_rs2 },
-    { "sltz", rv_codec_illegal, rv_fmt_rd_rs1 },
-    { "sgtz", rv_codec_illegal, rv_fmt_rd_rs2 },
-    { "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1 },
-    { "beqz", rv_codec_illegal, rv_fmt_rs1_offset },
-    { "bnez", rv_codec_illegal, rv_fmt_rs1_offset },
-    { "blez", rv_codec_illegal, rv_fmt_rs2_offset },
-    { "bgez", rv_codec_illegal, rv_fmt_rs1_offset },
-    { "bltz", rv_codec_illegal, rv_fmt_rs1_offset },
-    { "bgtz", rv_codec_illegal, rv_fmt_rs2_offset },
-    { "jal", rv_codec_illegal, rv_fmt_offset }, /* rv_op_jal_ra */
-    { "jalr", rv_codec_illegal, rv_fmt_rs1 }, /* rv_op_jalr_ra */
-    { },
-    { },
-    { "j", rv_codec_illegal, rv_fmt_offset },
-    { "ret", rv_codec_illegal, rv_fmt_none },
-    { "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr },
-    { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
-    { "rdtime", rv_codec_i_csr, rv_fmt_rd },
-    { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
-    { "rdcycleh", rv_codec_i_csr, rv_fmt_rd },
-    { "rdtimeh", rv_codec_i_csr, rv_fmt_rd },
-    { "rdinstreth", rv_codec_i_csr, rv_fmt_rd },
-    { "frcsr", rv_codec_i_csr, rv_fmt_rd },
-    { "frrm", rv_codec_i_csr, rv_fmt_rd },
-    { "frflags", rv_codec_i_csr, rv_fmt_rd },
-    { "fscsr", rv_codec_i_csr, rv_fmt_rd_rs1 },
-    { "fsrm", rv_codec_i_csr, rv_fmt_rd_rs1 },
-    { "fsflags", rv_codec_i_csr, rv_fmt_rd_rs1 },
-    { "fsrmi", rv_codec_i_csr, rv_fmt_rd_zimm },
-    { "fsflagsi", rv_codec_i_csr, rv_fmt_rd_zimm },
-    { "bseti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "bclri", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "binvi", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "bexti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "rori", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
-    { "clz", rv_codec_r, rv_fmt_rd_rs1 },
-    { "ctz", rv_codec_r, rv_fmt_rd_rs1 },
-    { "cpop", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sext.h", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sext.b", rv_codec_r, rv_fmt_rd_rs1 },
-    { "xnor", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "orn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "andn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "rol", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "ror", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sh1add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sh2add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sh3add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sh1add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sh2add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sh3add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "clmul", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "clmulr", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "clmulh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "min", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "minu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "max", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "maxu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "clzw", rv_codec_r, rv_fmt_rd_rs1 },
-    { "ctzw", rv_codec_r, rv_fmt_rd_rs1 },
-    { "cpopw", rv_codec_r, rv_fmt_rd_rs1 },
-    { "slli.uw", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
-    { "add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "rolw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "rorw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "rev8", rv_codec_r, rv_fmt_rd_rs1 },
-    { "zext.h", rv_codec_r, rv_fmt_rd_rs1 },
-    { "roriw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
-    { "orc.b", rv_codec_r, rv_fmt_rd_rs1 },
-    { "bset", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "bclr", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "binv", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "bext", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "aes32esmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
-    { "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
-    { "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
-    { "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
-    { "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum },
-    { "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "aes64im", rv_codec_r, rv_fmt_rd_rs1 },
-    { "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "aes64es", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "aes64dsm", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "aes64ds", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha256sig0", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sha256sig1", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sha256sum0", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sha256sum1", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sha512sig0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sig1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sum0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sum1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sum0r", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sum1r", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sig0l", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sig0h", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sig1l", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sha512sig1h", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "sm3p0", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sm3p1", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sm4ed", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
-    { "sm4ks", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
-    { "brev8", rv_codec_r, rv_fmt_rd_rs1 },
-    { "pack", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "packh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "packw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "unzip", rv_codec_r, rv_fmt_rd_rs1 },
-    { "zip", rv_codec_r, rv_fmt_rd_rs1 },
-    { "xperm4", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "xperm8", rv_codec_r, rv_fmt_rd_rs1 },
-    { "vle8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vle16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vle32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vle64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vse8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vse16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vse32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vse64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vlm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vsm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vlse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vlse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vlse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vlse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vsse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vsse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vsse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vsse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm },
-    { "vluxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vluxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vluxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vluxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vloxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vloxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vloxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vloxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsoxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsoxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsoxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vsoxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm },
-    { "vle8ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vle16ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vle32ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vle64ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl1re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl1re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl1re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl1re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl2re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl2re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl2re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl2re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl4re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl4re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl4re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl4re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl8re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl8re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl8re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vl8re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vs1r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vs2r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vs4r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vs8r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
-    { "vadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vrsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vrsub.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vwaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwsubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwsubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwaddu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwaddu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwadd.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwsubu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwsubu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwsub.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
-    { "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
-    { "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
-    { "vmadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
-    { "vmadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
-    { "vmadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
-    { "vsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
-    { "vsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
-    { "vmsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
-    { "vmsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
-    { "vand.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vand.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vand.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vxor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vxor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vmsne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmsne.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmsne.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vmsltu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmsltu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmslt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmslt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmsleu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmsleu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmsleu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vmsle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmsle.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmsle.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vmsgtu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmsgtu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vmsgt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmsgt.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vminu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vminu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmin.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmaxu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmaxu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmax.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmulhu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmulhu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmulhsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmulhsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vdiv.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vremu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vremu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vrem.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vrem.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwmulu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwmulu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwmulsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwmulsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vnmsac.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vmadd.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vnmsub.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vwmaccu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vwmaccu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vwmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vwmaccsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vwmaccsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vwmaccus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
-    { "vmv.v.v", rv_codec_v_r, rv_fmt_vd_vs1 },
-    { "vmv.v.x", rv_codec_v_r, rv_fmt_vd_rs1 },
-    { "vmv.v.i", rv_codec_v_i, rv_fmt_vd_imm },
-    { "vmerge.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
-    { "vmerge.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
-    { "vmerge.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
-    { "vsaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vsaddu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vsadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vsadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
-    { "vssubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vssubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vssub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vssub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vasub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vasub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vasubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vasubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vsmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfrsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwsub.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfnmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfnmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfwnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfwnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfwmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfwmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfwnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfwnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "vfsqrt.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vfrsqrt7.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vfmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfmin.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfmax.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfsgnj.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfsgnj.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfsgnjn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfsgnjn.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfsgnjx.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfsgnjx.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfslide1up.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfslide1down.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vmfeq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmfeq.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vmfne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmfne.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vmflt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmflt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vmfle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmfle.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vmfgt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vmfge.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
-    { "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfmerge.vfm", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vl },
-    { "vfmv.v.f", rv_codec_v_r, rv_fmt_vd_fs1 },
-    { "vfcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.f.xu.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.f.x.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.rod.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.rtz.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfncvt.rtz.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredxor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredminu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwredsumu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vfwredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmnand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmandn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmxor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmorn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vmxnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vcpop.m", rv_codec_v_r, rv_fmt_rd_vs2_vm },
-    { "vfirst.m", rv_codec_v_r, rv_fmt_rd_vs2_vm },
-    { "vmsbf.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vmsif.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vmsof.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "viota.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vid.v", rv_codec_v_r, rv_fmt_vd_vm },
-    { "vmv.x.s", rv_codec_v_r, rv_fmt_rd_vs2 },
-    { "vmv.s.x", rv_codec_v_r, rv_fmt_vd_rs1 },
-    { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2 },
-    { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1 },
-    { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
-    { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vmv4r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vmv8r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vzext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vzext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vzext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vsext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vsext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli },
-    { "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli },
-    { "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "c.zext.b", rv_codec_zcb_ext, rv_fmt_rd },
-    { "c.sext.b", rv_codec_zcb_ext, rv_fmt_rd },
-    { "c.zext.h", rv_codec_zcb_ext, rv_fmt_rd },
-    { "c.sext.h", rv_codec_zcb_ext, rv_fmt_rd },
-    { "c.zext.w", rv_codec_zcb_ext, rv_fmt_rd },
-    { "c.not", rv_codec_zcb_ext, rv_fmt_rd },
-    { "c.mul", rv_codec_zcb_mul, rv_fmt_rd_rs2 },
-    { "c.lbu", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst },
-    { "c.lhu", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
-    { "c.lh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
-    { "c.sb", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst },
-    { "c.sh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
-    { "cm.push", rv_codec_zcmp_cm_pushpop, rv_fmt_push_rlist },
-    { "cm.pop", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist },
-    { "cm.popret", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist },
-    { "cm.popretz", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist },
-    { "cm.mva01s", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2 },
-    { "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2 },
-    { "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index },
-    { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index },
-    { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
-    { "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
-    { "flh", rv_codec_i, rv_fmt_frd_offset_rs1 },
-    { "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1 },
-    { "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fli.s", rv_codec_fli, rv_fmt_fli },
-    { "fli.d", rv_codec_fli, rv_fmt_fli },
-    { "fli.q", rv_codec_fli, rv_fmt_fli },
-    { "fli.h", rv_codec_fli, rv_fmt_fli },
-    { "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2 },
-    { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
-    { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
-    { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2 },
-    { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1 },
-    { "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2 },
-    { "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2 },
-    { "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
-    { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
-    { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
-    { "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
-    { "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm },
-    { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
-    { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
-    { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
-    { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
-    { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
-    { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
-    { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
-    { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
-    { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
-    { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
-    { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1 },
-    { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2 },
-    { "c.mop.1", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.3", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.5", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.7", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.9", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.11", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.13", rv_codec_ci_none, rv_fmt_none },
-    { "c.mop.15", rv_codec_ci_none, rv_fmt_none },
-    { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "wrs.sto", rv_codec_none, rv_fmt_none },
-    { "wrs.nto", rv_codec_none, rv_fmt_none },
-    { "lpad", rv_codec_lp, rv_fmt_imm },
-    { "sspush", rv_codec_r, rv_fmt_rs2 },
-    { "sspopchk", rv_codec_r, rv_fmt_rs1 },
-    { "ssrdp", rv_codec_r, rv_fmt_rd },
-    { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspush) },
-    { "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspopchk) },
-   { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
-   { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
-   { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
-   { "cbo.zero", rv_codec_r, rv_fmt_rs1 },
-   { "mnret", rv_codec_none, rv_fmt_none },
+#define OP(N, ...) { __VA_ARGS__ },
+#include "riscv-op.c.inc"
+#undef OP
 };
 
 /* CSR names */
@@ -2928,7 +1015,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     (((inst >> 11) & 0b11) == 0b0)) {
                     unsigned int cmop_code = 0;
                     cmop_code = ((inst >> 8) & 0b111);
-                    op = rv_c_mop_1 + cmop_code;
+                    op = rv_op_c_mop_1 + cmop_code;
                     if (dec->cfg->ext_zicfiss) {
                         op = (cmop_code == 0) ? rv_op_c_sspush : op;
                         op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
@@ -4459,7 +2546,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                                        2, 2,
                                                        extract32(inst, 26, 2)),
                                              4, 1, extract32(inst, 30, 1));
-                        op = rv_mop_r_0 + imm_mop5;
+                        op = rv_op_mop_r_0 + imm_mop5;
                         /* if zicfiss enabled and mop5 is shadow stack */
                         if (dec->cfg->ext_zicfiss &&
                             ((imm_mop5 & 0b11100) == 0b11100)) {
@@ -4478,7 +2565,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                == 0b1000001) {
                         imm_mop3 = deposit32(extract32(inst, 26, 2),
                                              2, 1, extract32(inst, 30, 1));
-                        op = rv_mop_rr_0 + imm_mop3;
+                        op = rv_op_mop_rr_0 + imm_mop3;
                         /* if zicfiss enabled and mop3 is shadow stack */
                         if (dec->cfg->ext_zicfiss &&
                             ((imm_mop3 & 0b111) == 0b111)) {
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
new file mode 100644
index 0000000000..3fe934688e
--- /dev/null
+++ b/disas/riscv-op.c.inc
@@ -0,0 +1,958 @@
+OP(illegal, "illegal", rv_codec_none, rv_fmt_none)
+OP(lui, "lui", rv_codec_u, rv_fmt_rd_uimm)
+OP(auipc, "auipc", rv_codec_u, rv_fmt_rd_uoffset)
+OP(jal, "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal)
+OP(jalr, "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr)
+OP(beq, "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq)
+OP(bne, "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne)
+OP(blt, "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt)
+OP(bge, "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge)
+OP(bltu, "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset)
+OP(bgeu, "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset)
+OP(lb, "lb", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(lh, "lh", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(lw, "lw", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(lbu, "lbu", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(lhu, "lhu", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(sb, "sb", rv_codec_s, rv_fmt_rs2_offset_rs1)
+OP(sh, "sh", rv_codec_s, rv_fmt_rs2_offset_rs1)
+OP(sw, "sw", rv_codec_s, rv_fmt_rs2_offset_rs1)
+OP(addi, "addi", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addi)
+OP(slti, "slti", rv_codec_i, rv_fmt_rd_rs1_imm)
+OP(sltiu, "sltiu", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_sltiu)
+OP(xori, "xori", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_xori)
+OP(ori, "ori", rv_codec_i, rv_fmt_rd_rs1_imm)
+OP(andi, "andi", rv_codec_i, rv_fmt_rd_rs1_imm)
+OP(slli, "slli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(srli, "srli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(srai, "srai", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(add, "add", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sub, "sub", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sub)
+OP(sll, "sll", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(slt, "slt", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_slt)
+OP(sltu, "sltu", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sltu)
+OP(xor, "xor", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(srl, "srl", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sra, "sra", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(or, "or", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(and, "and", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(fence, "fence", rv_codec_r_f, rv_fmt_pred_succ)
+OP(fence_i, "fence.i", rv_codec_none, rv_fmt_none)
+OP(lwu, "lwu", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(ld, "ld", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(sd, "sd", rv_codec_s, rv_fmt_rs2_offset_rs1)
+OP(addiw, "addiw", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addiw)
+OP(slliw, "slliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
+OP(srliw, "srliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
+OP(sraiw, "sraiw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
+OP(addw, "addw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(subw, "subw", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_subw)
+OP(sllw, "sllw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(srlw, "srlw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sraw, "sraw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(ldu, "ldu", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(lq, "lq", rv_codec_i, rv_fmt_rd_offset_rs1)
+OP(sq, "sq", rv_codec_s, rv_fmt_rs2_offset_rs1)
+OP(addid, "addid", rv_codec_i, rv_fmt_rd_rs1_imm)
+OP(sllid, "sllid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
+OP(srlid, "srlid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
+OP(sraid, "sraid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
+OP(addd, "addd", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(subd, "subd", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(slld, "slld", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(srld, "srld", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(srad, "srad", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mul, "mul", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mulh, "mulh", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mulhsu, "mulhsu", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mulhu, "mulhu", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(div, "div", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(divu, "divu", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(rem, "rem", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(remu, "remu", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mulw, "mulw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(divw, "divw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(divuw, "divuw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(remw, "remw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(remuw, "remuw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(muld, "muld", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(divd, "divd", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(divud, "divud", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(remd, "remd", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(remud, "remud", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(lr_w, "lr.w", rv_codec_r_l, rv_fmt_aqrl_rd_rs1)
+OP(sc_w, "sc.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoswap_w, "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoadd_w, "amoadd.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoxor_w, "amoxor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoor_w, "amoor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoand_w, "amoand.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomin_w, "amomin.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomax_w, "amomax.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amominu_w, "amominu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomaxu_w, "amomaxu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(lr_d, "lr.d", rv_codec_r_l, rv_fmt_aqrl_rd_rs1)
+OP(sc_d, "sc.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoswap_d, "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoadd_d, "amoadd.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoxor_d, "amoxor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoor_d, "amoor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoand_d, "amoand.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomin_d, "amomin.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomax_d, "amomax.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amominu_d, "amominu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomaxu_d, "amomaxu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(lr_q, "lr.q", rv_codec_r_l, rv_fmt_aqrl_rd_rs1)
+OP(sc_q, "sc.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoswap_q, "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoadd_q, "amoadd.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoxor_q, "amoxor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoor_q, "amoor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoand_q, "amoand.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomin_q, "amomin.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomax_q, "amomax.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amominu_q, "amominu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomaxu_q, "amomaxu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(ecall, "ecall", rv_codec_none, rv_fmt_none)
+OP(ebreak, "ebreak", rv_codec_none, rv_fmt_none)
+OP(uret, "uret", rv_codec_none, rv_fmt_none)
+OP(sret, "sret", rv_codec_none, rv_fmt_none)
+OP(hret, "hret", rv_codec_none, rv_fmt_none)
+OP(mret, "mret", rv_codec_none, rv_fmt_none)
+OP(dret, "dret", rv_codec_none, rv_fmt_none)
+OP(sfence_vm, "sfence.vm", rv_codec_r, rv_fmt_rs1)
+OP(sfence_vma, "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2)
+OP(wfi, "wfi", rv_codec_none, rv_fmt_none)
+OP(csrrw, "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1)
+OP(csrrs, "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1)
+OP(csrrc, "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1)
+OP(csrrwi, "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm)
+OP(csrrsi, "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm)
+OP(csrrci, "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm)
+OP(flw, "flw", rv_codec_i, rv_fmt_frd_offset_rs1)
+OP(fsw, "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1)
+OP(fmadd_s, "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fmsub_s, "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fnmsub_s, "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fnmadd_s, "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fadd_s, "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fsub_s, "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fmul_s, "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fdiv_s, "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fsgnj_s, "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_s)
+OP(fsgnjn_s, "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_s)
+OP(fsgnjx_s, "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_s)
+OP(fmin_s, "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmax_s, "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fsqrt_s, "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fle_s, "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(flt_s, "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(feq_s, "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fcvt_w_s, "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_wu_s, "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_s_w, "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fcvt_s_wu, "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fmv_x_s, "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1)
+OP(fclass_s, "fclass.s", rv_codec_r, rv_fmt_rd_frs1)
+OP(fmv_s_x, "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1)
+OP(fcvt_l_s, "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_lu_s, "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_s_l, "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fcvt_s_lu, "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fld, "fld", rv_codec_i, rv_fmt_frd_offset_rs1)
+OP(fsd, "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1)
+OP(fmadd_d, "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fmsub_d, "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fnmsub_d, "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fnmadd_d, "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fadd_d, "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fsub_d, "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fmul_d, "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fdiv_d, "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fsgnj_d, "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_d)
+OP(fsgnjn_d, "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_d)
+OP(fsgnjx_d, "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_d)
+OP(fmin_d, "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmax_d, "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fcvt_s_d, "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fcvt_d_s, "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fsqrt_d, "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fle_d, "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(flt_d, "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(feq_d, "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fcvt_w_d, "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_wu_d, "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_d_w, "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fcvt_d_wu, "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fclass_d, "fclass.d", rv_codec_r, rv_fmt_rd_frs1)
+OP(fcvt_l_d, "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_lu_d, "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fmv_x_d, "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1)
+OP(fcvt_d_l, "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fcvt_d_lu, "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fmv_d_x, "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1)
+OP(flq, "flq", rv_codec_i, rv_fmt_frd_offset_rs1)
+OP(fsq, "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1)
+OP(fmadd_q, "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fmsub_q, "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fnmsub_q, "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fnmadd_q, "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
+OP(fadd_q, "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fsub_q, "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fmul_q, "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fdiv_q, "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
+OP(fsgnj_q, "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnj_q)
+OP(fsgnjn_q, "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjn_q)
+OP(fsgnjx_q, "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_fsgnjx_q)
+OP(fmin_q, "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmax_q, "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fcvt_s_q, "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fcvt_q_s, "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fcvt_d_q, "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fcvt_q_d, "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fsqrt_q, "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fle_q, "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(flt_q, "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(feq_q, "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fcvt_w_q, "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_wu_q, "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_q_w, "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fcvt_q_wu, "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fclass_q, "fclass.q", rv_codec_r, rv_fmt_rd_frs1)
+OP(fcvt_l_q, "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_lu_q, "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fcvt_q_l, "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fcvt_q_lu, "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
+OP(fmv_x_q, "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1)
+OP(fmv_q_x, "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1)
+OP(c_addi4spn, "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op_addi))
+OP(c_fld, "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld))
+OP(c_lw, "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw))
+OP(c_flw, "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw))
+OP(c_fsd, "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd))
+OP(c_sw, "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw))
+OP(c_fsw, "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw))
+OP(c_addi, "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi))
+OP(c_jal, "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal))
+OP(c_li, "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi))
+OP(c_addi16sp, "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_addi))
+OP(c_lui, "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui))
+OP(c_srli, "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli))
+OP(c_srai, "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai))
+OP(c_andi, "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi))
+OP(c_sub, "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub))
+OP(c_xor, "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor))
+OP(c_or, "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or))
+OP(c_and, "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and))
+OP(c_subw, "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw))
+OP(c_addw, "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw))
+OP(c_j, "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j))
+OP(c_beqz, "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz))
+OP(c_bnez, "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez))
+OP(c_slli, "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli))
+OP(c_fldsp, "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld))
+OP(c_lwsp, "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw))
+OP(c_flwsp, "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw))
+OP(c_jr, "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr))
+OP(c_mv, "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv))
+OP(c_ebreak, "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak))
+OP(c_jalr, "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr))
+OP(c_add, "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add))
+OP(c_fsdsp, "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fsd))
+OP(c_swsp, "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw))
+OP(c_fswsp, "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fsw))
+OP(c_ld, "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld))
+OP(c_sd, "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd))
+OP(c_addiw, "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw))
+OP(c_ldsp, "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld))
+OP(c_sdsp, "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd))
+OP(c_lq, "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq))
+OP(c_sq, "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq))
+OP(c_lqsp, "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq))
+OP(c_sqsp, "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq))
+OP(nop, "nop", rv_codec_illegal, rv_fmt_none)
+OP(mv, "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv)
+OP(not, "not", rv_codec_illegal, rv_fmt_rd_rs1)
+OP(neg, "neg", rv_codec_illegal, rv_fmt_rd_rs2)
+OP(negw, "negw", rv_codec_illegal, rv_fmt_rd_rs2)
+OP(sext_w, "sext.w", rv_codec_illegal, rv_fmt_rd_rs1)
+OP(seqz, "seqz", rv_codec_illegal, rv_fmt_rd_rs1)
+OP(snez, "snez", rv_codec_illegal, rv_fmt_rd_rs2)
+OP(sltz, "sltz", rv_codec_illegal, rv_fmt_rd_rs1)
+OP(sgtz, "sgtz", rv_codec_illegal, rv_fmt_rd_rs2)
+OP(fmv_s, "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fabs_s, "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fneg_s, "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fmv_d, "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fabs_d, "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fneg_d, "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fmv_q, "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fabs_q, "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(fneg_q, "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1)
+OP(beqz, "beqz", rv_codec_illegal, rv_fmt_rs1_offset)
+OP(bnez, "bnez", rv_codec_illegal, rv_fmt_rs1_offset)
+OP(blez, "blez", rv_codec_illegal, rv_fmt_rs2_offset)
+OP(bgez, "bgez", rv_codec_illegal, rv_fmt_rs1_offset)
+OP(bltz, "bltz", rv_codec_illegal, rv_fmt_rs1_offset)
+OP(bgtz, "bgtz", rv_codec_illegal, rv_fmt_rs2_offset)
+OP(jal_ra, "jal", rv_codec_illegal, rv_fmt_offset)
+OP(jalr_ra, "jalr", rv_codec_illegal, rv_fmt_rs1)
+OP(j, "j", rv_codec_illegal, rv_fmt_offset)
+OP(ret, "ret", rv_codec_illegal, rv_fmt_none)
+OP(jr, "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr)
+OP(rdcycle, "rdcycle", rv_codec_i_csr, rv_fmt_rd)
+OP(rdtime, "rdtime", rv_codec_i_csr, rv_fmt_rd)
+OP(rdinstret, "rdinstret", rv_codec_i_csr, rv_fmt_rd)
+OP(rdcycleh, "rdcycleh", rv_codec_i_csr, rv_fmt_rd)
+OP(rdtimeh, "rdtimeh", rv_codec_i_csr, rv_fmt_rd)
+OP(rdinstreth, "rdinstreth", rv_codec_i_csr, rv_fmt_rd)
+OP(frcsr, "frcsr", rv_codec_i_csr, rv_fmt_rd)
+OP(frrm, "frrm", rv_codec_i_csr, rv_fmt_rd)
+OP(frflags, "frflags", rv_codec_i_csr, rv_fmt_rd)
+OP(fscsr, "fscsr", rv_codec_i_csr, rv_fmt_rd_rs1)
+OP(fsrm, "fsrm", rv_codec_i_csr, rv_fmt_rd_rs1)
+OP(fsflags, "fsflags", rv_codec_i_csr, rv_fmt_rd_rs1)
+OP(fsrmi, "fsrmi", rv_codec_i_csr, rv_fmt_rd_zimm)
+OP(fsflagsi, "fsflagsi", rv_codec_i_csr, rv_fmt_rd_zimm)
+OP(bseti, "bseti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(bclri, "bclri", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(binvi, "binvi", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(bexti, "bexti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(rori, "rori", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
+OP(clz, "clz", rv_codec_r, rv_fmt_rd_rs1)
+OP(ctz, "ctz", rv_codec_r, rv_fmt_rd_rs1)
+OP(cpop, "cpop", rv_codec_r, rv_fmt_rd_rs1)
+OP(sext_h, "sext.h", rv_codec_r, rv_fmt_rd_rs1)
+OP(sext_b, "sext.b", rv_codec_r, rv_fmt_rd_rs1)
+OP(xnor, "xnor", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(orn, "orn", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(andn, "andn", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(rol, "rol", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(ror, "ror", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sh1add, "sh1add", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sh2add, "sh2add", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sh3add, "sh3add", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sh1add_uw, "sh1add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sh2add_uw, "sh2add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sh3add_uw, "sh3add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(clmul, "clmul", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(clmulr, "clmulr", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(clmulh, "clmulh", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(min, "min", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(minu, "minu", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(max, "max", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(maxu, "maxu", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(clzw, "clzw", rv_codec_r, rv_fmt_rd_rs1)
+OP(ctzw, "ctzw", rv_codec_r, rv_fmt_rd_rs1)
+OP(cpopw, "cpopw", rv_codec_r, rv_fmt_rd_rs1)
+OP(slli_uw, "slli.uw", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
+OP(add_uw, "add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(rolw, "rolw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(rorw, "rorw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(rev8, "rev8", rv_codec_r, rv_fmt_rd_rs1)
+OP(zext_h, "zext.h", rv_codec_r, rv_fmt_rd_rs1)
+OP(roriw, "roriw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
+OP(orc_b, "orc.b", rv_codec_r, rv_fmt_rd_rs1)
+OP(bset, "bset", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(bclr, "bclr", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(binv, "binv", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(bext, "bext", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(aes32esmi, "aes32esmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
+OP(aes32esi, "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
+OP(aes32dsmi, "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
+OP(aes32dsi, "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
+OP(aes64ks1i, "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum)
+OP(aes64ks2, "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(aes64im, "aes64im", rv_codec_r, rv_fmt_rd_rs1)
+OP(aes64esm, "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(aes64es, "aes64es", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(aes64dsm, "aes64dsm", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(aes64ds, "aes64ds", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha256sig0, "sha256sig0", rv_codec_r, rv_fmt_rd_rs1)
+OP(sha256sig1, "sha256sig1", rv_codec_r, rv_fmt_rd_rs1)
+OP(sha256sum0, "sha256sum0", rv_codec_r, rv_fmt_rd_rs1)
+OP(sha256sum1, "sha256sum1", rv_codec_r, rv_fmt_rd_rs1)
+OP(sha512sig0, "sha512sig0", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sig1, "sha512sig1", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sum0, "sha512sum0", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sum1, "sha512sum1", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sum0r, "sha512sum0r", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sum1r, "sha512sum1r", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sig0l, "sha512sig0l", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sig0h, "sha512sig0h", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sig1l, "sha512sig1l", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sha512sig1h, "sha512sig1h", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(sm3p0, "sm3p0", rv_codec_r, rv_fmt_rd_rs1)
+OP(sm3p1, "sm3p1", rv_codec_r, rv_fmt_rd_rs1)
+OP(sm4ed, "sm4ed", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
+OP(sm4ks, "sm4ks", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
+OP(brev8, "brev8", rv_codec_r, rv_fmt_rd_rs1)
+OP(pack, "pack", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(packh, "packh", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(packw, "packw", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(unzip, "unzip", rv_codec_r, rv_fmt_rd_rs1)
+OP(zip, "zip", rv_codec_r, rv_fmt_rd_rs1)
+OP(xperm4, "xperm4", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(xperm8, "xperm8", rv_codec_r, rv_fmt_rd_rs1)
+OP(vle8_v, "vle8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vle16_v, "vle16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vle32_v, "vle32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vle64_v, "vle64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vse8_v, "vse8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vse16_v, "vse16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vse32_v, "vse32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vse64_v, "vse64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vlm_v, "vlm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vsm_v, "vsm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vlse8_v, "vlse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vlse16_v, "vlse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vlse32_v, "vlse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vlse64_v, "vlse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vsse8_v, "vsse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vsse16_v, "vsse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vsse32_v, "vsse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vsse64_v, "vsse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
+OP(vluxei8_v, "vluxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vluxei16_v, "vluxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vluxei32_v, "vluxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vluxei64_v, "vluxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vloxei8_v, "vloxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vloxei16_v, "vloxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vloxei32_v, "vloxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vloxei64_v, "vloxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsoxei8_v, "vsoxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsoxei16_v, "vsoxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsoxei32_v, "vsoxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vsoxei64_v, "vsoxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
+OP(vle8ff_v, "vle8ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vle16ff_v, "vle16ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vle32ff_v, "vle32ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vle64ff_v, "vle64ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl1re8_v, "vl1re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl1re16_v, "vl1re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl1re32_v, "vl1re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl1re64_v, "vl1re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl2re8_v, "vl2re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl2re16_v, "vl2re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl2re32_v, "vl2re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl2re64_v, "vl2re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl4re8_v, "vl4re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl4re16_v, "vl4re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl4re32_v, "vl4re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl4re64_v, "vl4re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl8re8_v, "vl8re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl8re16_v, "vl8re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl8re32_v, "vl8re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vl8re64_v, "vl8re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vs1r_v, "vs1r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vs2r_v, "vs2r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vs4r_v, "vs4r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vs8r_v, "vs8r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
+OP(vadd_vv, "vadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vadd_vx, "vadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vadd_vi, "vadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vsub_vv, "vsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsub_vx, "vsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vrsub_vx, "vrsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vrsub_vi, "vrsub.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vwaddu_vv, "vwaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwaddu_vx, "vwaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwsubu_vv, "vwsubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwsubu_vx, "vwsubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwsub_vv, "vwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwsub_vx, "vwsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwaddu_wv, "vwaddu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwaddu_wx, "vwaddu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwadd_wx, "vwadd.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwsubu_wv, "vwsubu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwsubu_wx, "vwsubu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwsub_wv, "vwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwsub_wx, "vwsub.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
+OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
+OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
+OP(vmadc_vvm, "vmadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
+OP(vmadc_vxm, "vmadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
+OP(vmadc_vim, "vmadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
+OP(vsbc_vvm, "vsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
+OP(vsbc_vxm, "vsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
+OP(vmsbc_vvm, "vmsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
+OP(vmsbc_vxm, "vmsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
+OP(vand_vv, "vand.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vand_vx, "vand.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vand_vi, "vand.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vxor_vv, "vxor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vxor_vx, "vxor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vxor_vi, "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vsll_vv, "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsll_vx, "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vsll_vi, "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vsrl_vv, "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsrl_vx, "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vsrl_vi, "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vsra_vv, "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsra_vx, "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vsra_vi, "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vnsrl_wv, "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vnsrl_wi, "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vnsra_wv, "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vnsra_wx, "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vnsra_wi, "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vmseq_vv, "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmseq_vx, "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmseq_vi, "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vmsne_vv, "vmsne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmsne_vx, "vmsne.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmsne_vi, "vmsne.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vmsltu_vv, "vmsltu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmsltu_vx, "vmsltu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmslt_vv, "vmslt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmslt_vx, "vmslt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmsleu_vv, "vmsleu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmsleu_vx, "vmsleu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmsleu_vi, "vmsleu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vmsle_vv, "vmsle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmsle_vx, "vmsle.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmsle_vi, "vmsle.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vmsgtu_vx, "vmsgtu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmsgtu_vi, "vmsgtu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vmsgt_vx, "vmsgt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmsgt_vi, "vmsgt.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vminu_vv, "vminu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vminu_vx, "vminu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmin_vv, "vmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmin_vx, "vmin.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmaxu_vv, "vmaxu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmaxu_vx, "vmaxu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmax_vv, "vmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmax_vx, "vmax.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmul_vv, "vmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmul_vx, "vmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmulh_vv, "vmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmulh_vx, "vmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmulhu_vv, "vmulhu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmulhu_vx, "vmulhu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmulhsu_vv, "vmulhsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmulhsu_vx, "vmulhsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vdivu_vv, "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vdivu_vx, "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vdiv_vv, "vdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vdiv_vx, "vdiv.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vremu_vv, "vremu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vremu_vx, "vremu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vrem_vv, "vrem.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vrem_vx, "vrem.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwmulu_vv, "vwmulu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwmulu_vx, "vwmulu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwmulsu_vv, "vwmulsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwmulsu_vx, "vwmulsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwmul_vv, "vwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwmul_vx, "vwmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vmacc_vv, "vmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vmacc_vx, "vmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vnmsac_vv, "vnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vnmsac_vx, "vnmsac.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vmadd_vv, "vmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vmadd_vx, "vmadd.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vnmsub_vv, "vnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vnmsub_vx, "vnmsub.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vwmaccu_vv, "vwmaccu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vwmaccu_vx, "vwmaccu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vwmacc_vv, "vwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vwmacc_vx, "vwmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vwmaccsu_vv, "vwmaccsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vwmaccsu_vx, "vwmaccsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vwmaccus_vx, "vwmaccus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
+OP(vmv_v_v, "vmv.v.v", rv_codec_v_r, rv_fmt_vd_vs1)
+OP(vmv_v_x, "vmv.v.x", rv_codec_v_r, rv_fmt_vd_rs1)
+OP(vmv_v_i, "vmv.v.i", rv_codec_v_i, rv_fmt_vd_imm)
+OP(vmerge_vvm, "vmerge.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
+OP(vmerge_vxm, "vmerge.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
+OP(vmerge_vim, "vmerge.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
+OP(vsaddu_vv, "vsaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsaddu_vx, "vsaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vsaddu_vi, "vsaddu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vsadd_vv, "vsadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsadd_vx, "vsadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vsadd_vi, "vsadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
+OP(vssubu_vv, "vssubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vssubu_vx, "vssubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vssub_vv, "vssub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vssub_vx, "vssub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vasub_vv, "vasub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vasub_vx, "vasub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vasubu_vv, "vasubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vasubu_vx, "vasubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vsmul_vv, "vsmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vsmul_vx, "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vssrl_vv, "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vssrl_vx, "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vssrl_vi, "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vssra_vv, "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vssra_vx, "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vssra_vi, "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vnclipu_wv, "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vnclipu_wx, "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vnclipu_wi, "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vnclip_wv, "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vnclip_wx, "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vnclip_wi, "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vfadd_vv, "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfadd_vf, "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfsub_vv, "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfsub_vf, "vfsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfrsub_vf, "vfrsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfwadd_vv, "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwadd_vf, "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfwadd_wv, "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwadd_wf, "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfwsub_vv, "vfwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwsub_vf, "vfwsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfwsub_wv, "vfwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwsub_wf, "vfwsub.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfmul_vv, "vfmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfmul_vf, "vfmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfdiv_vv, "vfdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfdiv_vf, "vfdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfwmul_vv, "vfwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwmul_vf, "vfwmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfmacc_vv, "vfmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfmacc_vf, "vfmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfnmacc_vv, "vfnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfnmacc_vf, "vfnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfmsac_vv, "vfmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfmsac_vf, "vfmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfmadd_vv, "vfmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfmadd_vf, "vfmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfnmadd_vv, "vfnmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfnmadd_vf, "vfnmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfmsub_vv, "vfmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfmsub_vf, "vfmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfwmacc_vv, "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfwmacc_vf, "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfwnmacc_vv, "vfwnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfwnmacc_vf, "vfwnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfwmsac_vv, "vfwmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfwmsac_vf, "vfwmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfwnmsac_vv, "vfwnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfwnmsac_vf, "vfwnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(vfsqrt_v, "vfsqrt.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vfrsqrt7_v, "vfrsqrt7.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vfrec7_v, "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vfmin_vv, "vfmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfmin_vf, "vfmin.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfmax_vv, "vfmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfmax_vf, "vfmax.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfsgnj_vv, "vfsgnj.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfsgnj_vf, "vfsgnj.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfsgnjn_vv, "vfsgnjn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfsgnjn_vf, "vfsgnjn.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfsgnjx_vv, "vfsgnjx.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfsgnjx_vf, "vfsgnjx.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfslide1up_vf, "vfslide1up.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfslide1down_vf, "vfslide1down.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vmfeq_vv, "vmfeq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmfeq_vf, "vmfeq.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vmfne_vv, "vmfne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmfne_vf, "vmfne.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vmflt_vv, "vmflt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmflt_vf, "vmflt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vmfle_vv, "vmfle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmfle_vf, "vmfle.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vmfgt_vf, "vmfgt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vmfge_vf, "vmfge.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
+OP(vfclass_v, "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfmerge_vfm, "vfmerge.vfm", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vl)
+OP(vfmv_v_f, "vfmv.v.f", rv_codec_v_r, rv_fmt_vd_fs1)
+OP(vfcvt_xu_f_v, "vfcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfcvt_x_f_v, "vfcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfcvt_f_xu_v, "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfcvt_f_x_v, "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfcvt_rtz_xu_f_v, "vfcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfcvt_rtz_x_f_v, "vfcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_xu_f_v, "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_x_f_v, "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_f_xu_v, "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_f_x_v, "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_f_f_v, "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_rtz_xu_f_v, "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvt_rtz_x_f_v, "vfwcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_xu_f_w, "vfncvt.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_x_f_w, "vfncvt.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_f_xu_w, "vfncvt.f.xu.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_f_x_w, "vfncvt.f.x.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_f_f_w, "vfncvt.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_rod_f_f_w, "vfncvt.rod.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_rtz_xu_f_w, "vfncvt.rtz.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfncvt_rtz_x_f_w, "vfncvt.rtz.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vredsum_vs, "vredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredor_vs, "vredor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredxor_vs, "vredxor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredminu_vs, "vredminu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredmin_vs, "vredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredmaxu_vs, "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vredmax_vs, "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwredsumu_vs, "vwredsumu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwredsum_vs, "vwredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfredusum_vs, "vfredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfredosum_vs, "vfredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfredmin_vs, "vfredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfredmax_vs, "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwredusum_vs, "vfwredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vfwredosum_vs, "vfwredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmand_mm, "vmand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmnand_mm, "vmnand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmandn_mm, "vmandn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmxor_mm, "vmxor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmor_mm, "vmor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmnor_mm, "vmnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmorn_mm, "vmorn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vmxnor_mm, "vmxnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vcpop_m, "vcpop.m", rv_codec_v_r, rv_fmt_rd_vs2_vm)
+OP(vfirst_m, "vfirst.m", rv_codec_v_r, rv_fmt_rd_vs2_vm)
+OP(vmsbf_m, "vmsbf.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vmsif_m, "vmsif.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vmsof_m, "vmsof.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(viota_m, "viota.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vid_v, "vid.v", rv_codec_v_r, rv_fmt_vd_vm)
+OP(vmv_x_s, "vmv.x.s", rv_codec_v_r, rv_fmt_rd_vs2)
+OP(vmv_s_x, "vmv.s.x", rv_codec_v_r, rv_fmt_vd_rs1)
+OP(vfmv_f_s, "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2)
+OP(vfmv_s_f, "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1)
+OP(vslideup_vx, "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vslideup_vi, "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vslide1up_vx, "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vslidedown_vx, "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vslidedown_vi, "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vslide1down_vx, "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vrgather_vv, "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vrgatherei16_vv, "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vrgather_vx, "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vrgather_vi, "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(vcompress_vm, "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
+OP(vmv1r_v, "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vmv2r_v, "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vmv4r_v, "vmv4r.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vmv8r_v, "vmv8r.v", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vzext_vf2, "vzext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vzext_vf4, "vzext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vzext_vf8, "vzext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vsext_vf2, "vsext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vsext_vf4, "vsext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vsext_vf8, "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vsetvli, "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli)
+OP(vsetivli, "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli)
+OP(vsetvl, "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(c_zext_b, "c.zext.b", rv_codec_zcb_ext, rv_fmt_rd)
+OP(c_sext_b, "c.sext.b", rv_codec_zcb_ext, rv_fmt_rd)
+OP(c_zext_h, "c.zext.h", rv_codec_zcb_ext, rv_fmt_rd)
+OP(c_sext_h, "c.sext.h", rv_codec_zcb_ext, rv_fmt_rd)
+OP(c_zext_w, "c.zext.w", rv_codec_zcb_ext, rv_fmt_rd)
+OP(c_not, "c.not", rv_codec_zcb_ext, rv_fmt_rd)
+OP(c_mul, "c.mul", rv_codec_zcb_mul, rv_fmt_rd_rs2)
+OP(c_lbu, "c.lbu", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst)
+OP(c_lhu, "c.lhu", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst)
+OP(c_lh, "c.lh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst)
+OP(c_sb, "c.sb", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst)
+OP(c_sh, "c.sh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst)
+OP(cm_push, "cm.push", rv_codec_zcmp_cm_pushpop, rv_fmt_push_rlist)
+OP(cm_pop, "cm.pop", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist)
+OP(cm_popret, "cm.popret", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist)
+OP(cm_popretz, "cm.popretz", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist)
+OP(cm_mva01s, "cm.mva01s", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2)
+OP(cm_mvsa01, "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2)
+OP(cm_jt, "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index)
+OP(cm_jalt, "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index)
+OP(czero_eqz, "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(czero_nez, "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(fcvt_bf16_s, "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fcvt_s_bf16, "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(vfncvtbf16_f_f_w, "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwcvtbf16_f_f_v, "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vfwmaccbf16_vv, "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
+OP(vfwmaccbf16_vf, "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
+OP(flh, "flh", rv_codec_i, rv_fmt_frd_offset_rs1)
+OP(fsh, "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1)
+OP(fmv_h_x, "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1)
+OP(fmv_x_h, "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1)
+OP(fli_s, "fli.s", rv_codec_fli, rv_fmt_fli)
+OP(fli_d, "fli.d", rv_codec_fli, rv_fmt_fli)
+OP(fli_q, "fli.q", rv_codec_fli, rv_fmt_fli)
+OP(fli_h, "fli.h", rv_codec_fli, rv_fmt_fli)
+OP(fminm_s, "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmaxm_s, "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fminm_d, "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmaxm_d, "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fminm_q, "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmaxm_q, "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fminm_h, "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fmaxm_h, "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2)
+OP(fround_s, "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(froundnx_s, "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fround_d, "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(froundnx_d, "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fround_q, "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(froundnx_q, "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fround_h, "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(froundnx_h, "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1)
+OP(fcvtmod_w_d, "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
+OP(fmvh_x_d, "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1)
+OP(fmvp_d_x, "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2)
+OP(fmvh_x_q, "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1)
+OP(fmvp_q_x, "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2)
+OP(fleq_s, "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fltq_s, "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fleq_d, "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fltq_d, "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fleq_q, "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fltq_q, "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fleq_h, "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(fltq_h, "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2)
+OP(vaesdf_vv, "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesdf_vs, "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesdm_vv, "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesdm_vs, "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesef_vv, "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesef_vs, "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesem_vv, "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaesem_vs, "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vaeskf1_vi, "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
+OP(vaeskf2_vi, "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
+OP(vaesz_vs, "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vandn_vv, "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vandn_vx, "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vbrev_v, "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vbrev8_v, "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vclmul_vv, "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vclmul_vx, "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vclmulh_vv, "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vclmulh_vx, "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vclz_v, "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vcpop_v, "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vctz_v, "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vghsh_vv, "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
+OP(vgmul_vv, "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vrev8_v, "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
+OP(vrol_vv, "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vrol_vx, "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vror_vv, "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vror_vx, "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vror_vi, "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm)
+OP(vsha2ch_vv, "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
+OP(vsha2cl_vv, "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
+OP(vsha2ms_vv, "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
+OP(vsm3c_vi, "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
+OP(vsm3me_vv, "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
+OP(vsm4k_vi, "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
+OP(vsm4r_vv, "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vsm4r_vs, "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2)
+OP(vwsll_vv, "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
+OP(vwsll_vx, "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vwsll_vi, "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
+OP(amocas_w, "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(mop_r_0, "mop.r.0", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_1, "mop.r.1", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_2, "mop.r.2", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_3, "mop.r.3", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_4, "mop.r.4", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_5, "mop.r.5", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_6, "mop.r.6", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_7, "mop.r.7", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_8, "mop.r.8", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_9, "mop.r.9", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_10, "mop.r.10", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_11, "mop.r.11", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_12, "mop.r.12", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_13, "mop.r.13", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_14, "mop.r.14", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_15, "mop.r.15", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_16, "mop.r.16", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_17, "mop.r.17", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_18, "mop.r.18", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_19, "mop.r.19", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_20, "mop.r.20", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_21, "mop.r.21", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_22, "mop.r.22", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_23, "mop.r.23", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_24, "mop.r.24", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_25, "mop.r.25", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_26, "mop.r.26", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_27, "mop.r.27", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_28, "mop.r.28", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_29, "mop.r.29", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_30, "mop.r.30", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r_31, "mop.r.31", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_rr_0, "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_1, "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_2, "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_3, "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_4, "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_5, "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_6, "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr_7, "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(c_mop_1, "c.mop.1", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_3, "c.mop.3", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_5, "c.mop.5", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_7, "c.mop.7", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_9, "c.mop.9", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_11, "c.mop.11", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_13, "c.mop.13", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop_15, "c.mop.15", rv_codec_ci_none, rv_fmt_none)
+OP(amoswap_b, "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoadd_b, "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoxor_b, "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoor_b, "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoand_b, "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomin_b, "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomax_b, "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amominu_b, "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomaxu_b, "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoswap_h, "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoadd_h, "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoxor_h, "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoor_h, "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amoand_h, "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomin_h, "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomax_h, "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amominu_h, "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amomaxu_h, "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amocas_b, "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(amocas_h, "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(wrs_sto, "wrs.sto", rv_codec_none, rv_fmt_none)
+OP(wrs_nto, "wrs.nto", rv_codec_none, rv_fmt_none)
+OP(lpad, "lpad", rv_codec_lp, rv_fmt_imm)
+OP(sspush, "sspush", rv_codec_r, rv_fmt_rs2)
+OP(sspopchk, "sspopchk", rv_codec_r, rv_fmt_rs1)
+OP(ssrdp, "ssrdp", rv_codec_r, rv_fmt_rd)
+OP(ssamoswap_w, "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(ssamoswap_d, "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
+OP(c_sspush, "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspush))
+OP(c_sspopchk, "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspopchk))
+OP(cbo_inval, "cbo.inval", rv_codec_r, rv_fmt_rs1)
+OP(cbo_clean, "cbo.clean", rv_codec_r, rv_fmt_rs1)
+OP(cbo_flush, "cbo.flush", rv_codec_r, rv_fmt_rs1)
+OP(cbo_zero, "cbo.zero", rv_codec_r, rv_fmt_rs1)
+OP(mnret, "mnret", rv_codec_none, rv_fmt_none)
-- 
2.43.0


