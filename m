Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E8BD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlb3-0001uJ-8C; Sun, 01 Dec 2024 10:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaF-0007rO-KN
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:04 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaA-000570-8j
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:01 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e6399b009so28214fac.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065797; x=1733670597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nu8nWD7N4EQBx13FR0vvaNwesH8hvFESmWFdkh2zfM=;
 b=qpt6mzvAcVf5rmC7IMldZjq0LnLqSTXsQeWRALqoABbVgUjqtrRQVspXreXBVpYr4c
 cI3FOtox+S96z+qDtmyotb1mSRpmn2pDT3kpIPFlKek1P1Bt9PKlWVZH0CSVQU3JnZ3H
 WngxwEFbM5dbgOokU8Bn+o7bB5Fnj2kgNbhvav9exIBxpGuIdPtVuB2ojJ2+yKWHix8z
 sX/upZKNnUxG39mIjk9I9pZBAojAgNtr/HcupKMy1YfTifLZRd2X7Z0Op5erJrB3fIYS
 ghvDZFUb1Z5s+E3NSGxuMoiagMzBbEPocdK0lHyzb7JF++SHMdcUmhe/fPfF9TnRh4RB
 +fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065797; x=1733670597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nu8nWD7N4EQBx13FR0vvaNwesH8hvFESmWFdkh2zfM=;
 b=u2z90kg3fZTDmtNXuER8t5j/Cg/93/46m3p+OCHxP9fntREViFfZE88GAJgw1aJsbh
 4PjTtBIA+H8NzAR15Xz1arQNV2XGj4lkZAKEWbxmqZo4mSj17caRe0z+G70Vt5zeieQ7
 QijpiowwhvDf9fsyZOVA2hbbNsnmQw1/2f9NexvR9DtNDn0oOJuBMtlc3KXg/OFsqDec
 HEJRnabskm6v8mhhJzbYWQQUruBl7AUAYQDRKSV3xbXxgbPfQ4J/TW7kCKp92YwOm9uw
 8oCUPye0zPABgHUZ4bJ+r/PjO4Blgmv061RT6DwjfFYHWc/hqo5dkeMkGJDDjcYei9GS
 2Jmg==
X-Gm-Message-State: AOJu0Yxeom/CXSpVONgT8mazYIYp84yME/2lvkDmHgNX0CJFO54shE9l
 LJi2Otom2/ns0Lc2LXmH0KIZ+3OVji6R7s47WpypagzqX0V/NP4cqOYfwTSwcjRiKl2QJ3R+wOJ
 S7as=
X-Gm-Gg: ASbGncsAWUvoelCcKyvGHDZNAIFlrjOTk2kzsTJ8B/EpKdOPloFXuVRaKzeGSi+AHaS
 Cdah/R1GKMPA8caU5C7xzH+v+Xin/hS04tijNqOF60EGQbBKU6URgzCjb71IXzfM/eU4XhgZrOV
 07v73BzudJA2EXa02WLzBePTiBnZcDH9WPxBHQZDNLJPUDkBTa2mrgcJrxCcZLLeYa8VRpKjTUu
 VdZslAD46b1CO/X0+yCVp13NF0UCH0j0w9AwsF//Irz0f8UgG6+8I5amNPg7V2OG7yiWA796OfX
 b71NsdN6t+kmBN38wLCBhTvQvSLAXe57F6p8
X-Google-Smtp-Source: AGHT+IEKECSGs9Ss6HDUgmtlm0siQGQm4CzNot4EwPHYIpytKPp7/QVKVtbby4blPnCkcRi0BDv75Q==
X-Received: by 2002:a05:6830:2aab:b0:718:123e:922d with SMTP id
 46e09a7af769-71d65cd2630mr14247812a34.18.1733065796951; 
 Sun, 01 Dec 2024 07:09:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:09:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 42/67] target/arm: Convert handle_rev to decodetree
Date: Sun,  1 Dec 2024 09:05:41 -0600
Message-ID: <20241201150607.12812-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

This includes REV16, REV32, REV64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 79 +++-------------------------------
 target/arm/tcg/a64.decode      |  5 +++
 2 files changed, 10 insertions(+), 74 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bc1d0e18eb..11ccdb2d08 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8943,6 +8943,8 @@ TRANS(CMGE0_v, do_gvec_fn2, a, gen_gvec_cge0)
 TRANS(CMLT0_v, do_gvec_fn2, a, gen_gvec_clt0)
 TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
 TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
+TRANS(REV16_v, do_gvec_fn2, a, gen_gvec_rev16)
+TRANS(REV32_v, do_gvec_fn2, a, gen_gvec_rev32)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -8957,6 +8959,7 @@ static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
 TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
+TRANS(REV64_v, do_gvec_fn2_bhs, a, gen_gvec_rev64)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9886,76 +9889,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_rev(DisasContext *s, int opcode, bool u,
-                       bool is_q, int size, int rn, int rd)
-{
-    int op = (opcode << 1) | u;
-    int opsz = op + size;
-    int grp_size = 3 - opsz;
-    int dsize = is_q ? 128 : 64;
-    int i;
-
-    if (opsz >= 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 0) {
-        /* Special case bytes, use bswap op on each group of elements */
-        int groups = dsize / (8 << grp_size);
-
-        for (i = 0; i < groups; i++) {
-            TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_tmp, rn, i, grp_size);
-            switch (grp_size) {
-            case MO_16:
-                tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_32:
-                tcg_gen_bswap32_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_64:
-                tcg_gen_bswap64_i64(tcg_tmp, tcg_tmp);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            write_vec_element(s, tcg_tmp, rd, i, grp_size);
-        }
-        clear_vec_high(s, is_q, rd);
-    } else {
-        int revmask = (1 << grp_size) - 1;
-        int esize = 8 << size;
-        int elements = dsize / esize;
-        TCGv_i64 tcg_rn = tcg_temp_new_i64();
-        TCGv_i64 tcg_rd[2];
-
-        for (i = 0; i < 2; i++) {
-            tcg_rd[i] = tcg_temp_new_i64();
-            tcg_gen_movi_i64(tcg_rd[i], 0);
-        }
-
-        for (i = 0; i < elements; i++) {
-            int e_rev = (i & 0xf) ^ revmask;
-            int w = (e_rev * esize) / 64;
-            int o = (e_rev * esize) % 64;
-
-            read_vec_element(s, tcg_rn, rn, i, size);
-            tcg_gen_deposit_i64(tcg_rd[w], tcg_rd[w], tcg_rn, o, esize);
-        }
-
-        for (i = 0; i < 2; i++) {
-            write_vec_element(s, tcg_rd[i], rd, i, MO_64);
-        }
-        clear_vec_high(s, true, rd);
-    }
-}
-
 static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
                                   bool is_q, int size, int rn, int rd)
 {
@@ -10070,10 +10003,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x0: /* REV64, REV32 */
-    case 0x1: /* REV16 */
-        handle_rev(s, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
@@ -10276,6 +10205,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x0: /* REV64 */
+    case 0x1: /* REV16, REV32 */
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4f8231d07a..2531809096 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -73,6 +73,7 @@
 
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
+@qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1657,3 +1658,7 @@ CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
 CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
+
+REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
+REV32_v         0.10 1110 0.1 00000 00011 0 ..... .....     @qrr_bh
+REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
-- 
2.43.0


