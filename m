Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AE1EE3693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYIT-0001Go-4F; Thu, 12 Feb 2026 10:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqYIS-0001GG-4U
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:08:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqYIO-0004et-TB
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:07:59 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so3200065e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770908875; x=1771513675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7PaFta+XUwMwTOBC6RtKYeGKSumlB4nhsDnQICCsYt8=;
 b=PcjNsIVjwzuVwGrH80TkJZXL101e3RyguWSH8g4gUVSnonX9SCNNW1w8x2A2tnXEXT
 fuo0/rmSEtHlu4vm5kuSWlsQ1CtzkKVNySskmFsIDpdwEDYTSu4+J2HkSqaYMCW8GS8n
 cWqwwHgM97kwOzVF2JiOI3Ky2w+e9LV+mbFKBBMLPa3qyp03U4xTNm9nDXrDiWu/gMT5
 0pI0HRvs8y/NmVT18SENknG9hpkqhhaUbJg3tc/W07jEOb11aytXp5m3JLdXOVErYag2
 oL0yJ2MB/D7dPZcbqS4pIIgwUyGLuM4ndTqg1Y1T/UlbF+KTr5gE4QqA9RUfIU7xga6P
 d7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770908875; x=1771513675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PaFta+XUwMwTOBC6RtKYeGKSumlB4nhsDnQICCsYt8=;
 b=LOZVYOtRAxdhw9Ed/1gh3Oqq8HfAooIIYG5agogMK1nnWTn7XGn15t9Gmyzl63k1b6
 0LzdSJGpVFJl8tdtzzoeXqq3yW3Z2vSutrTL6SHiVo6N443ITmxKuCGdEztXPiNgATKi
 YDOwYm+mcmt2/nFvobCpeLQmAdtvzQZ/9wd7R1AYL1WsDxlpylgv4J6FZ/yCakSa4uPc
 2zny3HbWRhuJUeusHexB8qY1LRYjEDOlI+Fs3ZUHBTnQNLvdRsGDL8UsoxXUaq9FXLGJ
 d1NjhGT+0yXcuzR+ZdAA+eOuLYFOQRaBknZiNWZEi5J02x0lSJrQNT5P78yvb1nSzqhl
 wRsw==
X-Gm-Message-State: AOJu0YxCp7MaQnMnCElmDBOeidIXN4kZxCe3Ab6QwLZzlmaRM93tTuvy
 fbLYO70dvGHcIzLg8PUdWOglgY6ZEgrnynQPo4ndhOn7MTKWcXnNBkLL94h3jCNeBUwequ/dCjm
 AdiM1Lww=
X-Gm-Gg: AZuq6aIfx/qzNmKAZ4+jMciqSFGwV7bKDORCvF7Aun2ATGow5jcdDd5g3Xal05U0gzX
 hyDl/rDR3Z/6tf8QAEvWZ06eHy1eK3KIEuMq4eLsBtth2+abwjIu9SAV39XK5thjGLk8wAYTD8o
 YttImTQU3U6NmqBICufE5HQIKIUAdbd/ry+dOnYDFgh51V2PUSu7BdLyvJA+zTj965irxDNcHfo
 f1IFwJVEJjlM2cD+d5KxrOi9CdLy6yvfS/KyJkgb8eImdWXE2UCWr7Rw46+HgfNJuy9L66XPeTS
 XNrFyI4oXAD8JWMSY83nXE7uEA0M8o838SFtiDk7jZhgo1NvG6UQo1JlUSC7S+d3lrXj9JBy78v
 PsOPfyMOjt8yEMWc3BPWeXhms679jwB95fVCiJoDXjJqk2GQ4Ly2xDzqrooW6SpQHc6pRSbEFpZ
 IFKMmqJdNYd2aR58kfwLMMHt2XtUhn5/aaCxXno/JIGfYolLBU4vPYyz+dC6D8pgZBSCbrf8PiZ
 lFGen0A2ih3HoA0uRdHnbydpFiPJnc=
X-Received: by 2002:a05:600c:848d:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-48365715b6dmr49370635e9.31.1770908874965; 
 Thu, 12 Feb 2026 07:07:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835b9768c9sm84893545e9.2.2026.02.12.07.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 07:07:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH] target/ppc/translate: Fix TCG debug assert translating
 CLRBWIBC
Date: Thu, 12 Feb 2026 15:07:53 +0000
Message-ID: <20260212150753.1749448-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

The test case in the ppe42 functional test triggers a TCG debug
assertion, which causes the test to fail in an --enable-debug
build or when the sanitizers are enabled:

#6  0x00007ffff4a3b517 in __assert_fail
    (assertion=0x5555562e7589 "!temp_readonly(ots)", file=0x5555562e5b23 "../../tcg/tcg.c", line=4928, function=0x5555562e8900 <__PRETTY_FUNCTION__.23> "tcg_reg_alloc_mov") at ./assert/assert.c:105
#7  0x0000555555cc2189 in tcg_reg_alloc_mov (s=0x7fff60000b70, op=0x7fff600126f8) at ../../tcg/tcg.c:4928
#8  0x0000555555cc74e0 in tcg_gen_code (s=0x7fff60000b70, tb=0x7fffa802f540, pc_start=4294446080) at ../../tcg/tcg.c:6667
#9  0x0000555555d02abe in setjmp_gen_code
    (env=0x555556cbe610, tb=0x7fffa802f540, pc=4294446080, host_pc=0x7fffeea00c00, max_insns=0x7fffee9f9d74, ti=0x7fffee9f9d90)
    at ../../accel/tcg/translate-all.c:257
#10 0x0000555555d02d75 in tb_gen_code (cpu=0x555556cba590, s=...) at ../../accel/tcg/translate-all.c:325
#11 0x0000555555cf5922 in cpu_exec_loop (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:970
#12 0x0000555555cf5aae in cpu_exec_setjmp (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:1016
#13 0x0000555555cf5b4b in cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/cpu-exec.c:1042
#14 0x0000555555d1e7ab in tcg_cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/tcg-accel-ops.c:82
#15 0x0000555555d1ff97 in rr_cpu_thread_fn (arg=0x555556cba590) at ../../accel/tcg/tcg-accel-ops-rr.c:285
#16 0x00005555561586c9 in qemu_thread_start (args=0x555556ee3c90) at ../../util/qemu-thread-posix.c:393
#17 0x00007ffff4a9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
#18 0x00007ffff4b29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78

This can be reproduced "by hand":

 ./build/clang/qemu-system-ppc -display none -vga none \
    -machine ppe42_machine -serial stdio \
    -device loader,file=$HOME/.cache/qemu/download/03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8 \
    -device loader,addr=0xfff80040,cpu-num=0

(assuming you have the image file from the functional test
in your local cache).

This happens for this input:

IN:
0xfff80c00:  07436004  .byte    0x07, 0x43, 0x60, 0x04

which generates (among other things):

 not_i32 $0x80000,$0x80000

which the TCG optimization pass turns into:

 mov_i32 $0x80000,$0xfff7ffff             dead: 1  pref=0xffff

and where we then assert because we tried to write to a constant.

This happens for the CLRBWIBC instruction which ends up in
do_mask_branch() with rb_is_gpr false and invert true.  In this case
we will generate code that sets mask to a tcg_constant_tl() but then
uses it as the LHS in tcg_gen_not_tl().

Fix the assertion by doing the invert in the translate time C code
for the "mask is constant" case.

Cc: qemu-stable@nongnu.org
Fixes: f7ec91c23906 ("target/ppc: Add IBM PPE42 special instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/ppc/translate/ppe-impl.c.inc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
index 0a0590344e..1c27facb89 100644
--- a/target/ppc/translate/ppe-impl.c.inc
+++ b/target/ppc/translate/ppe-impl.c.inc
@@ -424,11 +424,15 @@ static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
         shift = tcg_temp_new();
         tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
         tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
+        if (invert) {
+            tcg_gen_not_tl(mask, mask);
+        }
     } else {
-        mask = tcg_constant_tl(PPC_BIT32(a->rb));
-    }
-    if (invert) {
-        tcg_gen_not_tl(mask, mask);
+        target_ulong mask_const = PPC_BIT32(a->rb);
+        if (invert) {
+            mask_const = ~mask_const;
+        }
+        mask = tcg_constant_tl(mask_const);
     }
 
     /* apply mask to ra */
-- 
2.43.0


