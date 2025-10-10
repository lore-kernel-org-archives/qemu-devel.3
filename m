Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5850CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77E1-0001eS-DG; Fri, 10 Oct 2025 03:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dz-0001dt-FQ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dw-0007xu-1f
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso11167525e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080048; x=1760684848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKAKoCrCXL4+jyUO8dvnijZXKLkuHiqnUNKcG3emi0Y=;
 b=rt/s42uYVMDnJVTJ0YaqwF5R2LDmA2e5Wjjo9xn8TVw9pEW5JKY/+4RAjM1TclBkaY
 3c2wU0IuiwJH9jWOu+7aBAfpqRcHEBI95jRHCjjDGDwtnk4kXJzFN66TJ5loQwDIHrHA
 ZdeXd7DTvOT+4NqO0pdfZiaaS0cF7AJLZiTXRx/KLJNR6JKy6KMFIKyJzHU8PUUFGTr6
 ABK66ZSzbpCliJm2zfmGGE1mmx5USsHO66s93borlICLKDGMLCOtfPUtx53ujxJFobg8
 JChzjkq5wHLABdJD8+Wl3IEfY3HyOoYAGALaZiLS/EdhAdRXHsOKqdAT3Z3968B/JU/9
 Ydsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080048; x=1760684848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKAKoCrCXL4+jyUO8dvnijZXKLkuHiqnUNKcG3emi0Y=;
 b=YHTluH5jH1POyLGL8p4OR9pl92E+BSp9MzxBupyzr8L8jyTMoYTQ2hAS7CxsFVKuAI
 0nUX7uFWYLz0hGimaO/iPyFzKUqChJ+jLEpnzs6Xm8xSscDpcvd/BBOAmlkVyfKhv0YS
 yIZFpRDrtNieev/LZMUqT6kjaE6ItNRVg7Yu5vgGqTXUrghhk0tYu72ZWaPUI5hSRVnW
 oTAc37GATBoNEN8jAkc6mk790qN4NlWA7sqnZImWetvUCbJfwjdPbThfTQHHwipo/58i
 OYvZDihtz1TU4B8+4zGR+p212mB/dMP9CKPpbwEB9w/nuGjNKlK0PICntRiBjbQnUcyI
 Vvtg==
X-Gm-Message-State: AOJu0YxfucezmWVXMF6gA7AqB8EvSkwWmR6PmV1XI8zkczZCdM+3ZFAZ
 ROA3I9BjwbuC/NpD1634ZTjdcefQ5MSzX0mZEeETHIeLDKTvltjijHBh79MEj9C5sXuHuEoDMGQ
 3F9ZibIMQo8bM
X-Gm-Gg: ASbGnctw5T/7bpTOg9b1ZVtNYxMxlwyREUeT09Q7vCdkceRKr/v3hEbX78656AHO5sc
 2qBGoao0Gslf2RBr34Sqf9zxIbPY1y/+BrnqTcu7li6gEKTwxyYCmRA/VyGvgCWJNeH3ASgRG55
 oZfZrPytNqwGjXuYsyIc/ffa1zat7jtqsszRf8StKHlYlG5ajCDN0F2ucimB6mABnOyo8T2D6Wz
 zO3bhEXVNVqX0tymtt7PJxH/0GmCZMSqXXaJYvTJ5jZhBoTAnu5CcRsR8H1ehaHwbN4mWpp+ECd
 IPZ4/8yQ+8YzSOl23Dzuuvr7y1R4bJ/Tz2KIrh45MQ8bDs+3SgnBtvaeI/qfiLS5PcY4ZJJo/ar
 dMbkD/isFDggnDMh8THc2m2XdKBLAQjHFKsHOAJhUveX9w7KPAHXAbUS5MdmFpFo1z75sdo+m90
 pmPJAtEuyAlnTJUJq0scyzDXnp
X-Google-Smtp-Source: AGHT+IFHFRpk1YsDhmZMVZWf9CwZ3VzL/nEYWqU80e6jk7ZrGeymWYOPKFUx2kVJg/PPMVY0u11JTg==
X-Received: by 2002:a05:600c:37cd:b0:46e:6d5f:f6c with SMTP id
 5b1f17b1804b1-46fa9a8c2ecmr70738935e9.3.1760080048304; 
 Fri, 10 Oct 2025 00:07:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab648795sm55878405e9.4.2025.10.10.00.07.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/13] target/openrisc: Use vaddr type for $pc jumps
Date: Fri, 10 Oct 2025 09:06:53 +0200
Message-ID: <20251010070702.51484-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 5ab3bc7021d..9f61f917b3b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -51,7 +51,7 @@ typedef struct DisasContext {
     uint32_t avr;
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
-    target_ulong jmp_pc_imm;
+    vaddr jmp_pc_imm;
 
     /* The temporary corresponding to register 0 for this compilation.  */
     TCGv R0;
@@ -580,7 +580,7 @@ static bool trans_l_muldu(DisasContext *dc, arg_ab *a)
 
 static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
 
     tcg_gen_movi_tl(jmp_pc, tmp_pc);
     dc->jmp_pc_imm = tmp_pc;
@@ -590,8 +590,8 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 
 static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
-    target_ulong ret_pc = dc->base.pc_next + 8;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr ret_pc = dc->base.pc_next + 8;
 
     tcg_gen_movi_tl(cpu_regs[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
@@ -605,7 +605,7 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 
 static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
 {
-    target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
+    vaddr tmp_pc = dc->base.pc_next + a->n * 4;
     TCGv t_next = tcg_constant_tl(dc->base.pc_next + 8);
     TCGv t_true = tcg_constant_tl(tmp_pc);
 
@@ -1586,7 +1586,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong jmp_dest;
+    vaddr jmp_dest;
 
     /* If we have already exited the TB, nothing following has effect.  */
     if (dc->base.is_jmp == DISAS_NORETURN) {
-- 
2.51.0


