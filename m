Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C356CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0J-0007jz-ML; Thu, 16 Oct 2025 08:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myi-0005Kq-Fg
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyZ-0000SK-DV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so595539f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617255; x=1761222055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=daVaVTk3MTDMD8FiKFs2A/gHvabvjdD9QS1GSoZ1ANA=;
 b=vI3VEbJu2tjYMHoL7UF+fkxJObm+b/fI686TGmarUR/sEgkS5iBQSg3OvObF/PKS31
 ktLYKhLjkyZTCvKhpvIB7RF+vVCfdrjvTUmMbqP2gY8QgQq+RNgx92iJKg8BIFm2g+fe
 SWdgANi8NDEdC7C460v91dfohTxk44q+0INNMdfoLU8BkM75BT+MWXJkdhrwK5jHwf6Z
 SNFkaFbs2ngHwPVDPba1eeCuVh6oHyC6TGbrI7xMWhUA7vT+Y6Q+9RKP5AqStlpnknnq
 umsc1iVfBBuXtbYJiFa4Bku8sNho/YXIxL5E/uTEx82xmRMKugqzFBVKMUvH6P5cAEaM
 ne2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617255; x=1761222055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daVaVTk3MTDMD8FiKFs2A/gHvabvjdD9QS1GSoZ1ANA=;
 b=sqIGm9eEgYnzvFnMwe9Y7f+UGI2igPDqYAzwRxon+zv6SaararZLQWuJavr2ZiyF5U
 vHTb7Xulc2vLkQGqlxtqcqVt3u64GAsGF0tcL8FziMJEajCvT+uBUn1d0hWQBFuKwGa4
 xs5bokKLzj8Gf7I4XjjcaySSGOjCJpe0+lUoIoaUCBWpWpqK/cmQCdONes3Le06LnRtz
 TuVlGV2f/WGPgcmnckQSLLpOn2/zm8SHU08vIJn/wDFhC+X1OG+WckWh39HfbV3/M3q1
 Kan42s+h6WBA5kUMtJVEzFIHjLbGNLCRHLsgWX5Qa2yBcBXZFzbpCJZunzbDOiGhn4bS
 dGnQ==
X-Gm-Message-State: AOJu0Yw03o86BU9/ZrJaSjtKdtTc9XwimfrYTFXsoybfzo3x9DWr1ZOb
 UpEda55Cm2GYqf+rhsEzKmbYJ/zRAQbwLmywUWR3hYDKjA2QV97IrrhYNe4XnqTSaIjj4jZbuBP
 WMI8Av3k=
X-Gm-Gg: ASbGncu4bWMhmqJNq4XHdRQlsrxYOzImTtaXRy4mMm7PBUmjnXhf23XIq6TGM3ewDJs
 TlbPA70/gSOP7jQqqOwOD82eHnSqxQsJbRg0KqRVxL0A8BJNw/Kyzf7X4I0CWQpIfeuTzuqo/ba
 Lb+WB9cUHy9p9u8+g7Kv8P1/nRl94JdGqUCmHw0DHLlz1Q5GwHVuSqPxj/EBT7x11vaId7W/0ej
 v4/3ETrSbsZRCQOmaeqqQtgMAm19U7HhdSkpN78VYw5tvBjgkNHOEvM72FUAv3bjqxH/zTTE8DS
 hgbHQQAQIcYMA5A1svbA7rXaqUEDXXSIVwAKJTaq0SBKATwWk8MHBALEw2AhZ98MNqPf9NgEBiW
 q13E2AtzN55WRy8FWPlaY396sybm9QyFSK3U4G/3WC/ODq0pe8o+Z82p8ljDM7cu75jc3K8AjIF
 CH4LzJso7RYiSTOcoMrtZCgzzl4dZl5BjgpTUxGrBBA5hfp/lXpO0zZw==
X-Google-Smtp-Source: AGHT+IHco4fRolk9qkJ+NL7ob+2WUdAPs0jL7PUh9CDeUytqLTNiUJ7SDkSp7cGihkCEX4wwszq3Pg==
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id
 ffacd0b85a97d-4266e8de2c2mr23080565f8f.44.1760617254344; 
 Thu, 16 Oct 2025 05:20:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d4bbsm34900341f8f.2.2025.10.16.05.20.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/75] target/tricore: Un-inline various helpers
Date: Thu, 16 Oct 2025 14:15:25 +0200
Message-ID: <20251016121532.14042-70-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rely on the linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-12-philmd@linaro.org>
---
 target/tricore/translate.c | 274 ++++++++++++++++++-------------------
 1 file changed, 135 insertions(+), 139 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 62a2d807266..787c77292fd 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -201,7 +201,7 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 /* For two 32-bit registers used a 64-bit register, the first
    registernumber needs to be even. Otherwise we trap. */
-static inline void generate_trap(DisasContext *ctx, int class, int tin);
+static void generate_trap(DisasContext *ctx, int class, int tin);
 #define CHECK_REG_PAIR(reg) do {                      \
     if (reg & 0x1) {                                  \
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_OPD); \
@@ -210,16 +210,16 @@ static inline void generate_trap(DisasContext *ctx, int class, int tin);
 
 /* Functions for load/save to/from memory */
 
-static inline void gen_offset_ld(DisasContext *ctx, TCGv r1, TCGv r2,
-                                 int16_t con, MemOp mop)
+static void gen_offset_ld(DisasContext *ctx, TCGv r1, TCGv r2,
+                          int16_t con, MemOp mop)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_addi_i32(temp, r2, con);
     tcg_gen_qemu_ld_i32(r1, temp, ctx->mem_idx, mop);
 }
 
-static inline void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
-                                 int16_t con, MemOp mop)
+static void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
+                          int16_t con, MemOp mop)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_addi_i32(temp, r2, con);
@@ -346,7 +346,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
         break;
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)
 #define E(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)
-static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
+static void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
 {
     /* since we're caching PSW make this a special case */
     if (offset == 0xfe04) {
@@ -374,8 +374,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
          watchdog device, we handle endinit protected registers like
          all-access registers for now. */
 #define E(ADDRESS, REG, FEATURE) A(ADDRESS, REG, FEATURE)
-static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
-                            int32_t offset)
+static void gen_mtcr(DisasContext *ctx, TCGv r1, int32_t offset)
 {
     if (ctx->priv == TRICORE_PRIV_SM) {
         /* since we're caching PSW make this a special case */
@@ -394,7 +393,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
 
 /* Functions for arithmetic instructions  */
 
-static inline void gen_add_d(TCGv ret, TCGv r1, TCGv r2)
+static void gen_add_d(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv t0 = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
@@ -415,7 +414,7 @@ static inline void gen_add_d(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static inline void
+static void
 gen_add64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
 {
     TCGv temp = tcg_temp_new();
@@ -441,7 +440,7 @@ gen_add64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
     tcg_gen_mov_i64(ret, result);
 }
 
-static inline void
+static void
 gen_addsub64_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                TCGv r3, void(*op1)(TCGv, TCGv, TCGv),
                void(*op2)(TCGv, TCGv, TCGv))
@@ -488,7 +487,7 @@ gen_addsub64_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
 }
 
 /* ret = r2 + (r1 * r3); */
-static inline void gen_madd32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
+static void gen_madd32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -519,13 +518,13 @@ static inline void gen_madd32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void gen_maddi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_maddi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_madd32_d(ret, r1, r2, temp);
 }
 
-static inline void
+static void
 gen_madd64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
              TCGv r3)
 {
@@ -553,7 +552,7 @@ gen_madd64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_mov_i32(ret_high, t4);
 }
 
-static inline void
+static void
 gen_maddu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
               TCGv r3)
 {
@@ -583,7 +582,7 @@ gen_maddu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void
+static void
 gen_maddi64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
               int32_t con)
 {
@@ -591,7 +590,7 @@ gen_maddi64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_madd64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void
+static void
 gen_maddui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
                int32_t con)
 {
@@ -599,7 +598,7 @@ gen_maddui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_maddu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void
+static void
 gen_madd_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
            TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -626,7 +625,7 @@ gen_madd_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_add_tl, tcg_gen_add_tl);
 }
 
-static inline void
+static void
 gen_maddsu_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
              TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -653,7 +652,7 @@ gen_maddsu_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_sub_tl, tcg_gen_add_tl);
 }
 
-static inline void
+static void
 gen_maddsum_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
               TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -686,9 +685,9 @@ gen_maddsum_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_2);
 }
 
-static inline void gen_adds(TCGv ret, TCGv r1, TCGv r2);
+static void gen_adds(TCGv ret, TCGv r1, TCGv r2);
 
-static inline void
+static void
 gen_madds_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
            TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -723,9 +722,9 @@ gen_madds_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static inline void gen_subs(TCGv ret, TCGv r1, TCGv r2);
+static void gen_subs(TCGv ret, TCGv r1, TCGv r2);
 
-static inline void
+static void
 gen_maddsus_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
               TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -760,7 +759,7 @@ gen_maddsus_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static inline void
+static void
 gen_maddsums_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -793,7 +792,7 @@ gen_maddsums_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
 }
 
 
-static inline void
+static void
 gen_maddm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
            TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -821,7 +820,7 @@ gen_maddm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_3);
 }
 
-static inline void
+static void
 gen_maddms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
            TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -847,7 +846,7 @@ gen_maddms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_maddr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
               uint32_t mode)
 {
@@ -870,7 +869,7 @@ gen_maddr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
     gen_helper_addr_h(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static inline void
+static void
 gen_maddr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv temp = tcg_temp_new();
@@ -881,7 +880,7 @@ gen_maddr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_maddr64_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static inline void
+static void
 gen_maddsur32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv t_n = tcg_constant_i32(n);
@@ -908,7 +907,7 @@ gen_maddsur32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 }
 
 
-static inline void
+static void
 gen_maddr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
                uint32_t n, uint32_t mode)
 {
@@ -931,7 +930,7 @@ gen_maddr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
     gen_helper_addr_h_ssov(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static inline void
+static void
 gen_maddr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv temp = tcg_temp_new();
@@ -942,7 +941,7 @@ gen_maddr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_maddr64s_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static inline void
+static void
 gen_maddsur32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv t_n = tcg_constant_i32(n);
@@ -968,21 +967,21 @@ gen_maddsur32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_helper_addsur_h_ssov(ret, tcg_env, temp64, temp, temp2);
 }
 
-static inline void
+static void
 gen_maddr_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
 {
     TCGv t_n = tcg_constant_i32(n);
     gen_helper_maddr_q(ret, tcg_env, r1, r2, r3, t_n);
 }
 
-static inline void
+static void
 gen_maddrs_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
 {
     TCGv t_n = tcg_constant_i32(n);
     gen_helper_maddr_q_ssov(ret, tcg_env, r1, r2, r3, t_n);
 }
 
-static inline void
+static void
 gen_madd32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
              uint32_t up_shift)
 {
@@ -1032,7 +1031,7 @@ gen_madd32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     tcg_gen_mov_i32(ret, temp3);
 }
 
-static inline void
+static void
 gen_m16add32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
 {
     TCGv temp = tcg_temp_new();
@@ -1049,7 +1048,7 @@ gen_m16add32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_add_d(ret, arg1, temp);
 }
 
-static inline void
+static void
 gen_m16adds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
 {
     TCGv temp = tcg_temp_new();
@@ -1066,7 +1065,7 @@ gen_m16adds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_adds(ret, arg1, temp);
 }
 
-static inline void
+static void
 gen_m16add64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
                TCGv arg3, uint32_t n)
 {
@@ -1093,7 +1092,7 @@ gen_m16add64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t3);
 }
 
-static inline void
+static void
 gen_m16adds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
                TCGv arg3, uint32_t n)
 {
@@ -1119,7 +1118,7 @@ gen_m16adds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t1);
 }
 
-static inline void
+static void
 gen_madd64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
              TCGv arg3, uint32_t n)
 {
@@ -1167,7 +1166,7 @@ gen_madd64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void
+static void
 gen_madds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
               uint32_t up_shift)
 {
@@ -1185,7 +1184,7 @@ gen_madds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     gen_helper_madd32_q_add_ssov(ret, tcg_env, t1, t2);
 }
 
-static inline void
+static void
 gen_madds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
              TCGv arg3, uint32_t n)
 {
@@ -1198,7 +1197,7 @@ gen_madds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
 }
 
 /* ret = r2 - (r1 * r3); */
-static inline void gen_msub32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
+static void gen_msub32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -1230,13 +1229,13 @@ static inline void gen_msub32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void gen_msubi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_msubi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_msub32_d(ret, r1, r2, temp);
 }
 
-static inline void
+static void
 gen_msub64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
              TCGv r3)
 {
@@ -1264,7 +1263,7 @@ gen_msub64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_mov_i32(ret_high, t4);
 }
 
-static inline void
+static void
 gen_msubi64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
               int32_t con)
 {
@@ -1272,7 +1271,7 @@ gen_msubi64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_msub64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void
+static void
 gen_msubu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
               TCGv r3)
 {
@@ -1300,7 +1299,7 @@ gen_msubu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void
+static void
 gen_msubui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
                int32_t con)
 {
@@ -1308,14 +1307,14 @@ gen_msubui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_msubu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void gen_addi_d(TCGv ret, TCGv r1, int32_t r2)
+static void gen_addi_d(TCGv ret, TCGv r1, int32_t r2)
 {
     TCGv temp = tcg_constant_i32(r2);
     gen_add_d(ret, r1, temp);
 }
 
 /* calculate the carry bit too */
-static inline void gen_add_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_add_CC(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv t0    = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
@@ -1338,13 +1337,13 @@ static inline void gen_add_CC(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static inline void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
+static void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_add_CC(ret, r1, temp);
 }
 
-static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv t0     = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
@@ -1366,14 +1365,13 @@ static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static inline void gen_addci_CC(TCGv ret, TCGv r1, int32_t con)
+static void gen_addci_CC(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_addc_CC(ret, r1, temp);
 }
 
-static inline void gen_cond_add(TCGCond cond, TCGv r1, TCGv r2, TCGv r3,
-                                TCGv r4)
+static void gen_cond_add(TCGCond cond, TCGv r1, TCGv r2, TCGv r3, TCGv r4)
 {
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
@@ -1405,14 +1403,13 @@ static inline void gen_cond_add(TCGCond cond, TCGv r1, TCGv r2, TCGv r3,
     tcg_gen_movcond_i32(cond, r3, r4, t0, result, r1);
 }
 
-static inline void gen_condi_add(TCGCond cond, TCGv r1, int32_t r2,
-                                 TCGv r3, TCGv r4)
+static void gen_condi_add(TCGCond cond, TCGv r1, int32_t r2, TCGv r3, TCGv r4)
 {
     TCGv temp = tcg_constant_i32(r2);
     gen_cond_add(cond, r1, temp, r3, r4);
 }
 
-static inline void gen_sub_d(TCGv ret, TCGv r1, TCGv r2)
+static void gen_sub_d(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv temp = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
@@ -1433,7 +1430,7 @@ static inline void gen_sub_d(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static inline void
+static void
 gen_sub64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
 {
     TCGv temp = tcg_temp_new();
@@ -1459,7 +1456,7 @@ gen_sub64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
     tcg_gen_mov_i64(ret, result);
 }
 
-static inline void gen_sub_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_sub_CC(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv result = tcg_temp_new();
     TCGv temp = tcg_temp_new();
@@ -1482,15 +1479,14 @@ static inline void gen_sub_CC(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static inline void gen_subc_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_subc_CC(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_not_i32(temp, r2);
     gen_addc_CC(ret, r1, temp);
 }
 
-static inline void gen_cond_sub(TCGCond cond, TCGv r1, TCGv r2, TCGv r3,
-                                TCGv r4)
+static void gen_cond_sub(TCGCond cond, TCGv r1, TCGv r2, TCGv r3, TCGv r4)
 {
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
@@ -1522,7 +1518,7 @@ static inline void gen_cond_sub(TCGCond cond, TCGv r1, TCGv r2, TCGv r3,
     tcg_gen_movcond_i32(cond, r3, r4, t0, result, r1);
 }
 
-static inline void
+static void
 gen_msub_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
            TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -1549,7 +1545,7 @@ gen_msub_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_sub_tl, tcg_gen_sub_tl);
 }
 
-static inline void
+static void
 gen_msubs_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
             TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -1584,7 +1580,7 @@ gen_msubs_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static inline void
+static void
 gen_msubm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
             TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -1612,7 +1608,7 @@ gen_msubm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_3);
 }
 
-static inline void
+static void
 gen_msubms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
              TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -1638,7 +1634,7 @@ gen_msubms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_msubr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
               uint32_t mode)
 {
@@ -1661,7 +1657,7 @@ gen_msubr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
     gen_helper_subr_h(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static inline void
+static void
 gen_msubr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv temp = tcg_temp_new();
@@ -1672,7 +1668,7 @@ gen_msubr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_msubr64_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static inline void
+static void
 gen_msubr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
                uint32_t n, uint32_t mode)
 {
@@ -1695,7 +1691,7 @@ gen_msubr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
     gen_helper_subr_h_ssov(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static inline void
+static void
 gen_msubr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv temp = tcg_temp_new();
@@ -1706,21 +1702,21 @@ gen_msubr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_msubr64s_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static inline void
+static void
 gen_msubr_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
 {
     TCGv temp = tcg_constant_i32(n);
     gen_helper_msubr_q(ret, tcg_env, r1, r2, r3, temp);
 }
 
-static inline void
+static void
 gen_msubrs_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
 {
     TCGv temp = tcg_constant_i32(n);
     gen_helper_msubr_q_ssov(ret, tcg_env, r1, r2, r3, temp);
 }
 
-static inline void
+static void
 gen_msub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
              uint32_t up_shift)
 {
@@ -1761,7 +1757,7 @@ gen_msub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     tcg_gen_mov_i32(ret, temp3);
 }
 
-static inline void
+static void
 gen_m16sub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
 {
     TCGv temp = tcg_temp_new();
@@ -1778,7 +1774,7 @@ gen_m16sub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_sub_d(ret, arg1, temp);
 }
 
-static inline void
+static void
 gen_m16subs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
 {
     TCGv temp = tcg_temp_new();
@@ -1795,7 +1791,7 @@ gen_m16subs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_subs(ret, arg1, temp);
 }
 
-static inline void
+static void
 gen_m16sub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
                TCGv arg3, uint32_t n)
 {
@@ -1822,7 +1818,7 @@ gen_m16sub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t3);
 }
 
-static inline void
+static void
 gen_m16subs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
                TCGv arg3, uint32_t n)
 {
@@ -1848,7 +1844,7 @@ gen_m16subs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t1);
 }
 
-static inline void
+static void
 gen_msub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
              TCGv arg3, uint32_t n)
 {
@@ -1896,7 +1892,7 @@ gen_msub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void
+static void
 gen_msubs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
               uint32_t up_shift)
 {
@@ -1919,7 +1915,7 @@ gen_msubs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     gen_helper_msub32_q_sub_ssov(ret, tcg_env, t1, t3);
 }
 
-static inline void
+static void
 gen_msubs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
              TCGv arg3, uint32_t n)
 {
@@ -1931,7 +1927,7 @@ gen_msubs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, r1);
 }
 
-static inline void
+static void
 gen_msubad_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
              TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -1958,7 +1954,7 @@ gen_msubad_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_add_tl, tcg_gen_sub_tl);
 }
 
-static inline void
+static void
 gen_msubadm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
               TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -1991,7 +1987,7 @@ gen_msubadm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_2);
 }
 
-static inline void
+static void
 gen_msubadr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv t_n = tcg_constant_i32(n);
@@ -2017,7 +2013,7 @@ gen_msubadr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_helper_subadr_h(ret, tcg_env, temp64, temp, temp2);
 }
 
-static inline void
+static void
 gen_msubads_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
               TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -2052,7 +2048,7 @@ gen_msubads_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static inline void
+static void
 gen_msubadms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                TCGv r3, uint32_t n, uint32_t mode)
 {
@@ -2084,7 +2080,7 @@ gen_msubadms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 {
     TCGv t_n = tcg_constant_i32(n);
@@ -2110,7 +2106,7 @@ gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_helper_subadr_h_ssov(ret, tcg_env, temp64, temp, temp2);
 }
 
-static inline void gen_abs(TCGv ret, TCGv r1)
+static void gen_abs(TCGv ret, TCGv r1)
 {
     tcg_gen_abs_i32(ret, r1);
     /* overflow can only happen, if r1 = 0x80000000 */
@@ -2125,7 +2121,7 @@ static inline void gen_abs(TCGv ret, TCGv r1)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
+static void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv temp = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
@@ -2151,19 +2147,19 @@ static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static inline void gen_absdifi(TCGv ret, TCGv r1, int32_t con)
+static void gen_absdifi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_absdif(ret, r1, temp);
 }
 
-static inline void gen_absdifsi(TCGv ret, TCGv r1, int32_t con)
+static void gen_absdifsi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_absdif_ssov(ret, tcg_env, r1, temp);
 }
 
-static inline void gen_mul_i32s(TCGv ret, TCGv r1, TCGv r2)
+static void gen_mul_i32s(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv high = tcg_temp_new();
     TCGv low = tcg_temp_new();
@@ -2183,13 +2179,13 @@ static inline void gen_mul_i32s(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void gen_muli_i32s(TCGv ret, TCGv r1, int32_t con)
+static void gen_muli_i32s(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_mul_i32s(ret, r1, temp);
 }
 
-static inline void gen_mul_i64s(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
+static void gen_mul_i64s(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
 {
     tcg_gen_muls2_i32(ret_low, ret_high, r1, r2);
     /* clear V bit */
@@ -2203,14 +2199,14 @@ static inline void gen_mul_i64s(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void gen_muli_i64s(TCGv ret_low, TCGv ret_high, TCGv r1,
+static void gen_muli_i64s(TCGv ret_low, TCGv ret_high, TCGv r1,
                                 int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_mul_i64s(ret_low, ret_high, r1, temp);
 }
 
-static inline void gen_mul_i64u(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
+static void gen_mul_i64u(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
 {
     tcg_gen_mulu2_i32(ret_low, ret_high, r1, r2);
     /* clear V bit */
@@ -2224,33 +2220,33 @@ static inline void gen_mul_i64u(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static inline void gen_muli_i64u(TCGv ret_low, TCGv ret_high, TCGv r1,
+static void gen_muli_i64u(TCGv ret_low, TCGv ret_high, TCGv r1,
                                 int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_mul_i64u(ret_low, ret_high, r1, temp);
 }
 
-static inline void gen_mulsi_i32(TCGv ret, TCGv r1, int32_t con)
+static void gen_mulsi_i32(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_mul_ssov(ret, tcg_env, r1, temp);
 }
 
-static inline void gen_mulsui_i32(TCGv ret, TCGv r1, int32_t con)
+static void gen_mulsui_i32(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_mul_suov(ret, tcg_env, r1, temp);
 }
 
 /* gen_maddsi_32(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r3], const9); */
-static inline void gen_maddsi_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_maddsi_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_madd32_ssov(ret, tcg_env, r1, r2, temp);
 }
 
-static inline void gen_maddsui_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_maddsui_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_madd32_suov(ret, tcg_env, r1, r2, temp);
@@ -2361,7 +2357,7 @@ static void gen_mulr_q(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
     tcg_gen_andi_i32(ret, ret, 0xffff0000);
 }
 
-static inline void
+static void
 gen_madds_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
              TCGv r3)
 {
@@ -2371,7 +2367,7 @@ gen_madds_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_maddsi_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
               int32_t con)
 {
@@ -2379,7 +2375,7 @@ gen_maddsi_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_madds_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void
+static void
 gen_maddsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
              TCGv r3)
 {
@@ -2389,7 +2385,7 @@ gen_maddsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_maddsui_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
                int32_t con)
 {
@@ -2397,19 +2393,19 @@ gen_maddsui_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_maddsu_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void gen_msubsi_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_msubsi_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_msub32_ssov(ret, tcg_env, r1, r2, temp);
 }
 
-static inline void gen_msubsui_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_msubsui_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_msub32_suov(ret, tcg_env, r1, r2, temp);
 }
 
-static inline void
+static void
 gen_msubs_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
              TCGv r3)
 {
@@ -2419,7 +2415,7 @@ gen_msubs_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_msubsi_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
               int32_t con)
 {
@@ -2427,7 +2423,7 @@ gen_msubsi_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_msubs_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void
+static void
 gen_msubsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
              TCGv r3)
 {
@@ -2437,7 +2433,7 @@ gen_msubsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static inline void
+static void
 gen_msubsui_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
                int32_t con)
 {
@@ -2589,37 +2585,37 @@ static void gen_sh_condi(int cond, TCGv ret, TCGv r1, int32_t con)
     gen_sh_cond(cond, ret, r1, temp);
 }
 
-static inline void gen_adds(TCGv ret, TCGv r1, TCGv r2)
+static void gen_adds(TCGv ret, TCGv r1, TCGv r2)
 {
     gen_helper_add_ssov(ret, tcg_env, r1, r2);
 }
 
-static inline void gen_addsi(TCGv ret, TCGv r1, int32_t con)
+static void gen_addsi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_add_ssov(ret, tcg_env, r1, temp);
 }
 
-static inline void gen_addsui(TCGv ret, TCGv r1, int32_t con)
+static void gen_addsui(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv temp = tcg_constant_i32(con);
     gen_helper_add_suov(ret, tcg_env, r1, temp);
 }
 
-static inline void gen_subs(TCGv ret, TCGv r1, TCGv r2)
+static void gen_subs(TCGv ret, TCGv r1, TCGv r2)
 {
     gen_helper_sub_ssov(ret, tcg_env, r1, r2);
 }
 
-static inline void gen_subsu(TCGv ret, TCGv r1, TCGv r2)
+static void gen_subsu(TCGv ret, TCGv r1, TCGv r2)
 {
     gen_helper_sub_suov(ret, tcg_env, r1, r2);
 }
 
-static inline void gen_bit_2op(TCGv ret, TCGv r1, TCGv r2,
-                               int pos1, int pos2,
-                               void(*op1)(TCGv, TCGv, TCGv),
-                               void(*op2)(TCGv, TCGv, TCGv))
+static void gen_bit_2op(TCGv ret, TCGv r1, TCGv r2,
+                        int pos1, int pos2,
+                        void(*op1)(TCGv, TCGv, TCGv),
+                        void(*op2)(TCGv, TCGv, TCGv))
 {
     TCGv temp1, temp2;
 
@@ -2636,9 +2632,9 @@ static inline void gen_bit_2op(TCGv ret, TCGv r1, TCGv r2,
 }
 
 /* ret = r1[pos1] op1 r2[pos2]; */
-static inline void gen_bit_1op(TCGv ret, TCGv r1, TCGv r2,
-                               int pos1, int pos2,
-                               void(*op1)(TCGv, TCGv, TCGv))
+static void gen_bit_1op(TCGv ret, TCGv r1, TCGv r2,
+                        int pos1, int pos2,
+                        void(*op1)(TCGv, TCGv, TCGv))
 {
     TCGv temp1, temp2;
 
@@ -2653,8 +2649,8 @@ static inline void gen_bit_1op(TCGv ret, TCGv r1, TCGv r2,
     tcg_gen_andi_i32(ret, ret, 0x1);
 }
 
-static inline void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
-                                         void(*op)(TCGv, TCGv, TCGv))
+static void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
+                                  void(*op)(TCGv, TCGv, TCGv))
 {
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
@@ -2668,7 +2664,7 @@ static inline void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
     tcg_gen_deposit_i32(ret, ret, temp, 0, 1);
 }
 
-static inline void
+static void
 gen_accumulating_condi(int cond, TCGv ret, TCGv r1, int32_t con,
                        void(*op)(TCGv, TCGv, TCGv))
 {
@@ -2676,7 +2672,7 @@ gen_accumulating_condi(int cond, TCGv ret, TCGv r1, int32_t con,
     gen_accumulating_cond(cond, ret, r1, temp, op);
 }
 
-static inline void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
+static void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv b0 = tcg_temp_new();
     TCGv b1 = tcg_temp_new();
@@ -2705,7 +2701,7 @@ static inline void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
     tcg_gen_or_i32(ret, ret, b3);
 }
 
-static inline void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
+static void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv h0 = tcg_temp_new();
     TCGv h1 = tcg_temp_new();
@@ -2724,7 +2720,7 @@ static inline void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
 
 /* mask = ((1 << width) -1) << pos;
    ret = (r1 & ~mask) | (r2 << pos) & mask); */
-static inline void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
+static void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
 {
     TCGv mask = tcg_temp_new();
     TCGv temp = tcg_temp_new();
@@ -2740,7 +2736,7 @@ static inline void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
     tcg_gen_or_i32(ret, temp, temp2);
 }
 
-static inline void gen_bsplit(TCGv rl, TCGv rh, TCGv r1)
+static void gen_bsplit(TCGv rl, TCGv rh, TCGv r1)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -2748,7 +2744,7 @@ static inline void gen_bsplit(TCGv rl, TCGv rh, TCGv r1)
     tcg_gen_extr_i64_i32(rl, rh, temp);
 }
 
-static inline void gen_unpack(TCGv rl, TCGv rh, TCGv r1)
+static void gen_unpack(TCGv rl, TCGv rh, TCGv r1)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -2756,7 +2752,7 @@ static inline void gen_unpack(TCGv rl, TCGv rh, TCGv r1)
     tcg_gen_extr_i64_i32(rl, rh, temp);
 }
 
-static inline void
+static void
 gen_dvinit_b(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
 {
     TCGv_i64 ret = tcg_temp_new_i64();
@@ -2769,7 +2765,7 @@ gen_dvinit_b(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
     tcg_gen_extr_i64_i32(rl, rh, ret);
 }
 
-static inline void
+static void
 gen_dvinit_h(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
 {
     TCGv_i64 ret = tcg_temp_new_i64();
@@ -2812,7 +2808,7 @@ static void gen_calc_usb_mulr_h(TCGv arg)
 
 /* helpers for generating program flow micro-ops */
 
-static inline void gen_save_pc(vaddr pc)
+static void gen_save_pc(vaddr pc)
 {
     tcg_gen_movi_i32(cpu_PC, pc);
 }
@@ -2840,8 +2836,8 @@ static void generate_trap(DisasContext *ctx, int class, int tin)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
-                                   TCGv r2, int16_t address)
+static void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
+                            TCGv r2, int16_t address)
 {
     TCGLabel *jumpLabel = gen_new_label();
     tcg_gen_brcond_i32(cond, r1, r2, jumpLabel);
@@ -2852,8 +2848,8 @@ static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
     gen_goto_tb(ctx, 0, ctx->base.pc_next + address * 2);
 }
 
-static inline void gen_branch_condi(DisasContext *ctx, TCGCond cond, TCGv r1,
-                                    int r2, int16_t address)
+static void gen_branch_condi(DisasContext *ctx, TCGCond cond, TCGv r1,
+                             int r2, int16_t address)
 {
     TCGv temp = tcg_constant_i32(r2);
     gen_branch_cond(ctx, cond, r1, temp, address);
-- 
2.51.0


