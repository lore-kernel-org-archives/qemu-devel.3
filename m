Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8415CC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa6-0003L3-BX; Mon, 01 Jul 2024 12:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZD-0000nN-PL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ8-0005Sz-7v
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:47 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52d259dbe3cso3383819e87.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850060; x=1720454860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iLACqgTTEHhqCS+ObmefTAtVB4Q6QNPzyB2rXjNCxak=;
 b=egvhZ1oR+ZCvtJe50zaLi/IyA3lwQv57jnLM6GC3+g7f8dSghHCUCBvhbNgANj8sS2
 +j+GLnGzG7KAdghiDKSvUmNho5bRZdQVDkDZg3NeknPgozF5ZTWCHvzUbdvdkW+kd9hC
 jF7HGoPmYyldAttsaNi/EiqBHHSpFG7qPFzm88aejxUhit1MFF7kNhj5yzPDkWhoaWyh
 KLRwG6tBf4iXC9lpumeZUPRzbhbWFzRXsZejuyFPDCqZ1a8+CtaRmHtkxVZ/akVA40c6
 hA2t/4CBMwUZlh2HwiBLTuhXINOrBPnlXEk1dkBm2lY9XHzHaEQUA1wfahVS3UVcYTMh
 zoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850060; x=1720454860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLACqgTTEHhqCS+ObmefTAtVB4Q6QNPzyB2rXjNCxak=;
 b=NxH4xwb8A60REXDfkZmCJTg8T+fYDC9AB6AChSFM1fdVjteY1Axw7x2vukTuZcQLc7
 A3rDm0TbB8oyu3FZnOdo6PtK1onqEMh+o/c5F1heNYbjIWxLenObN6gzJP+yRCR9kglS
 GHa+XDJjVyOUmso/ZZ9nCVErSMJZzF2fMKQHHWkuFqGNeRMNfqhtgsD9COwH6mGYSQPp
 WqnIynoTh1Zh0NUZoT/6ZEjKdt5gxwttonWhhqr9i2f3Ursi1h+K6AMlYIgVeGDOMJet
 tezZLac+x40oRm/bxALhAFVUUQBWNRIP75zOqxBi5OjZIc5nEdMriKfMPVMihgk4UR3q
 hKww==
X-Gm-Message-State: AOJu0YzmZE89ALrCyEyIn4QtB8W/WiB3vXnkG4XfdPx39deVAbUadu5J
 J9XAFSnEK32nRdZ/77nfzX/8AN96gzIPmnkwuBLlSbIEz5OvraPcfOd2uVNzjuKGKxmN7SfFNH4
 3bpo=
X-Google-Smtp-Source: AGHT+IEeGRhpwMeTL7DbJNC9wDn1G++7MGrI+WOMeNWupUS2uSZ4SpIbF2yRv72F2krKsNH2/KM5bw==
X-Received: by 2002:a05:6512:33c9:b0:52c:dfe6:70e0 with SMTP id
 2adb3069b0e04-52e8264460dmr4607537e87.10.1719850060120; 
 Mon, 01 Jul 2024 09:07:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/29] target/arm: Delete dead code from disas_simd_indexed
Date: Mon,  1 Jul 2024 17:07:19 +0100
Message-Id: <20240701160729.1910763-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

MLA, MLS, SQDMULH, SQRDMULH, were converted with 8db93dcd3def
and f80701cb44d, and this code should have been removed then.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 93 ----------------------------------
 1 file changed, 93 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 161fa2659c4..6c07aeaf3bd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11976,7 +11976,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int h = extract32(insn, 11, 1);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    bool is_long = false;
     int index;
 
     switch (16 * u + opcode) {
@@ -11990,12 +11989,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        is_long = true;
         break;
     case 0x03: /* SQDMLAL, SQDMLAL2 */
     case 0x07: /* SQDMLSL, SQDMLSL2 */
     case 0x0b: /* SQDMULL, SQDMULL2 */
-        is_long = true;
         break;
     default:
     case 0x00: /* FMLAL */
@@ -12047,96 +12044,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
     if (size == 3) {
         g_assert_not_reached();
-    } else if (!is_long) {
-        /* 32 bit floating point, or 16 or 32 bit integer.
-         * For the 16 bit scalar case we use the usual Neon helpers and
-         * rely on the fact that 0 op 0 == 0 with no side effects.
-         */
-        TCGv_i32 tcg_idx = tcg_temp_new_i32();
-        int pass, maxpasses;
-
-        if (is_scalar) {
-            maxpasses = 1;
-        } else {
-            maxpasses = is_q ? 4 : 2;
-        }
-
-        read_vec_element_i32(s, tcg_idx, rm, index, size);
-
-        if (size == 1 && !is_scalar) {
-            /* The simplest way to handle the 16x16 indexed ops is to duplicate
-             * the index into both halves of the 32 bit tcg_idx and then use
-             * the usual Neon helpers.
-             */
-            tcg_gen_deposit_i32(tcg_idx, tcg_idx, tcg_idx, 16, 16);
-        }
-
-        for (pass = 0; pass < maxpasses; pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op, rn, pass, is_scalar ? size : MO_32);
-
-            switch (16 * u + opcode) {
-            case 0x10: /* MLA */
-            case 0x14: /* MLS */
-            {
-                static NeonGenTwoOpFn * const fns[2][2] = {
-                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
-                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
-                };
-                NeonGenTwoOpFn *genfn;
-                bool is_sub = opcode == 0x4;
-
-                if (size == 1) {
-                    gen_helper_neon_mul_u16(tcg_res, tcg_op, tcg_idx);
-                } else {
-                    tcg_gen_mul_i32(tcg_res, tcg_op, tcg_idx);
-                }
-                if (opcode == 0x8) {
-                    break;
-                }
-                read_vec_element_i32(s, tcg_op, rd, pass, MO_32);
-                genfn = fns[size - 1][is_sub];
-                genfn(tcg_res, tcg_op, tcg_res);
-                break;
-            }
-            case 0x0c: /* SQDMULH */
-                if (size == 1) {
-                    gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
-                                               tcg_op, tcg_idx);
-                } else {
-                    gen_helper_neon_qdmulh_s32(tcg_res, tcg_env,
-                                               tcg_op, tcg_idx);
-                }
-                break;
-            case 0x0d: /* SQRDMULH */
-                if (size == 1) {
-                    gen_helper_neon_qrdmulh_s16(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx);
-                } else {
-                    gen_helper_neon_qrdmulh_s32(tcg_res, tcg_env,
-                                                tcg_op, tcg_idx);
-                }
-                break;
-            default:
-            case 0x01: /* FMLA */
-            case 0x05: /* FMLS */
-            case 0x09: /* FMUL */
-            case 0x19: /* FMULX */
-            case 0x1d: /* SQRDMLAH */
-            case 0x1f: /* SQRDMLSH */
-                g_assert_not_reached();
-            }
-
-            if (is_scalar) {
-                write_fp_sreg(s, rd, tcg_res);
-            } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-            }
-        }
-
-        clear_vec_high(s, is_q, rd);
     } else {
         /* long ops: 16x16->32 or 32x32->64 */
         TCGv_i64 tcg_res[2];
-- 
2.34.1


