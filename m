Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFD0FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwqt-000139-ST; Wed, 29 Apr 2026 00:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqr-00012d-O5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqq-0008HV-2D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b7d3ecc10dso39171975ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438122; x=1778042922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqeMwhjDBjglQffNTUWVy8tQdA8hvh3XZpyZhrNNsAc=;
 b=lW9DgOKXGHotq8hWqlRsvg+lhYCCfGgLQ6YU4o9pfeRqOHWqJKYTGIlRsZ8/3IWJoE
 j/W2xcRBcc83wyreM/n8CjGXnoJe8kqB730hyz5hGgdi7ZlPy2GMotvpJnV+7hbcSvEL
 6hnUrquEP3d06h/mSJiqlgSypI4Am89gvsOmEt2FqlLz3HPiFY1E7nNOkZ0Elw+TQbBH
 ddzTaJdicb9WMtk0XaFyBwumCwsTllTpztDwRYXq1ewhWXrRSZzs1W3FEk4HmV8syTTw
 LwiUCgD/Fpp8yV4iA/itFFAt4+MjFGiW0hxNiy2hwALfi/REuIZBv0BrpVCkwkScdrux
 YLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438122; x=1778042922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqeMwhjDBjglQffNTUWVy8tQdA8hvh3XZpyZhrNNsAc=;
 b=Hh5m2oyFbzavlnI5GHGaLbSCBQFKC4V2j8y5UeiFZshYAXNeXXiIMuLdyuIrUxMErF
 XnT6nWMixHGvYrl4ocu1Aznuqo7DBai6JrE0KbBN9Tqn9jQGASjGH6bBT8L00tgPnj+U
 jPoImGHA+Utg7fZZBsz6Gu/NSdFl4N8Ug+HB4wpJVBF5CNnQqTI0AodrHW7iW0JcsQCc
 5wMiLodtNzJEycFocoU7fPg3AFUrsrxFBvefKrBlqLGJ3FlgeB7oK7TuVqCUvZ3EPnvQ
 UzMIPYB6BgkX9GaJdFdt4SRUi5z8r3C/nm4kjZEavdF0b84LaoDt+bwMNirourBfR94w
 gs1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9io8EnYQ7Vs/FUHJPvmcTOva3KZw5A4FIdO5sbNSSb0kNyiVWPth06yUOitnDYoAVqrvn3i0JZDQB0@nongnu.org
X-Gm-Message-State: AOJu0YxiHjDIrNktimBk2vnObBl/wJWyLE4axFTJIyLYUYFnMoexzAPD
 rvIvOEWJXn6i28NddUW7epC/YOpPQHlw7Sgv255J3YXVFWOeeMQhqMGK
X-Gm-Gg: AeBDietnRD4UxzbcaaxBHRa/HD5xIgkm5bGT9KhTa3mjWsD6YYQBxPCedNjaEPQUs47
 5e2PFP5UVIjFhJX+XK6k+NJNpa5Fi+yXScsjJA1ocdthp3eUWS9saRcP3B7Mw3nyfGYdgTTp8Vp
 KlwFbpcpW9F4tv5mXwrTj9tkKKZWR2hFy9CqgBUIH16L8p4Ctms44QZs59SJ3OYXKf44h3k/YBa
 BL+mKk2ABiGn7po2lQmXHi6aYhWpwT4KLS6Oav1UgpC4zFiqBsPaJQMOG8dU5yGXZ0w/+8h3ysr
 /bgc4GuS4xP65KBmIW4+TzRi8Tk+z0FidmC2FRDwr2UA9HEs2/cFlyr+Q7FQeHr1WBoSb5cMhDY
 t50k3PfTmRVaTJBbw5+gYHMrC9hbmdFt6wdv3ttMWYO70kwqlvz3w3Ui3lVyX5HR+ZxGw3n+j4q
 OrBvdkot4K8CxLE5tOQOojq+JMqQpLC678pIR1EmbsStHbBqeIchKj
X-Received: by 2002:a17:903:298c:b0:2b2:6df1:1112 with SMTP id
 d9443c01a7336-2b97c4f41b0mr58709595ad.40.1777438122263; 
 Tue, 28 Apr 2026 21:48:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/51] target/riscv: Make LQ and SQ use 128-bit ld/st
Date: Wed, 29 Apr 2026 14:47:07 +1000
Message-ID: <20260429044752.4176397-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The lq and sq helpers for the experimental rv128 architecture
currently use direct memory accesses.
Replace these direct accesses with the standard
tcg_gen_qemu_{ld,st}_i128 TCG helpers that handle endianness
issues.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Message-ID: <20260101181442.2489496-2-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-4-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f241..2c82ae41a7 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -377,6 +377,9 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
     TCGv destl = dest_gpr(ctx, a->rd);
     TCGv desth = dest_gprh(ctx, a->rd);
     TCGv addrl = tcg_temp_new();
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i64 tl = tcg_temp_new_i64();
+    TCGv_i64 th = tcg_temp_new_i64();
 
     tcg_gen_addi_tl(addrl, src1l, a->imm);
 
@@ -388,10 +391,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
             tcg_gen_movi_tl(desth, 0);
         }
     } else {
-        /* assume little-endian memory access for now */
-        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_extr_i128_i64(tl, th, t16);
+        } else {
+            tcg_gen_extr_i128_i64(th, tl, t16);
+        }
+        tcg_gen_trunc_i64_tl(destl, tl);
+        tcg_gen_trunc_i64_tl(desth, th);
     }
 
     gen_set_gpr128(ctx, a->rd, destl, desth);
@@ -488,16 +495,25 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv src2l = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv src2h = get_gprh(ctx, a->rs2);
     TCGv addrl = tcg_temp_new();
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i64 tl = tcg_temp_new_i64();
+    TCGv_i64 th = tcg_temp_new_i64();
 
     tcg_gen_addi_tl(addrl, src1l, a->imm);
 
     if ((memop & MO_SIZE) <= MO_64) {
         tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
     } else {
-        /* little-endian memory access assumed for now */
-        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
+
+        tcg_gen_ext_tl_i64(tl, src2l);
+        tcg_gen_ext_tl_i64(th, src2h);
+
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_concat_i64_i128(t16, tl, th);
+        } else {
+            tcg_gen_concat_i64_i128(t16, th, tl);
+        }
+        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
     }
     return true;
 }
-- 
2.53.0


