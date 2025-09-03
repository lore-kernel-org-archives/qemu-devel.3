Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D72CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 02:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utd8V-0002ze-TK; Tue, 02 Sep 2025 22:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utd8O-0002uD-9y; Tue, 02 Sep 2025 22:22:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utd8L-0004dg-Sa; Tue, 02 Sep 2025 22:22:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24c89867a17so3286145ad.1; 
 Tue, 02 Sep 2025 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756866118; x=1757470918; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FFDTpEWQjsPHpaJMt1i0tDnXkqJppDBmCRXUnMMVm00=;
 b=VOJNKbrsWttphQHnrQZalnKId19Gup5xLEes2P8J9QPaF8OU56qagi3DZlYzmtDjRF
 /OyhIZgUofCvqfy9idcLC/pa/uL4A2si5ImJf50tDDxqFBiedelIDKAzfr68iqg441PX
 Ov2OHqg8+xNcCrxziiUcEV0Y0eW9x+wxK4bPufCFSxDZ9EwdAa+ZK08R459Q4pWsyoew
 RQQHoSqq+IuRnarpRPBtFkMwuVYyGsH9Mhhj+qrWZFIGgK6Epp/J2KUs3Uha/KnrO0Mb
 eRhnfA6isKY7aQuJy1lKJ76ZhT2CzcpSr8Nv0XKwvtFvAo1PmlTGWNszR6HDn1n+pEZZ
 lD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756866118; x=1757470918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFDTpEWQjsPHpaJMt1i0tDnXkqJppDBmCRXUnMMVm00=;
 b=d4S2mHFgGFu+UHO+RVEiJwnjCBktH9xSrMI5uwaY/7ZbZEs084Hr5T6gOjftmvWaeS
 4V6QFO9qEfKKiOIxHv5IVHyWVEf/M6euHJCzIut01ok96RMQyrU1ziFixWhlUjaZ0Byr
 /6xWRlFI9wkJxRvSzaFOcsXa/M4oyHM/JtSl6E/JHebRBvqaCjOJrozMMppwB4UFHa40
 Qc+AeQzJQ/CniBv+mJHohrKGTzLb1KT8X2YwPNz/flnI4uDSHh+alHc+26yyLh6U9BX2
 YKaESLA1gCKQbbs5f3w/8QxW9uN756fYHDIpSNMoC77ljCuSIKE2umKZ6aM6cQYX/OzS
 nRNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJOvL191OKKpYpXSvPKotYjTK4SZjAQFSgoXsd6j77EiUgmoluDSWTwvoVTB+HwLu/w9nxsUbjUnM8@nongnu.org,
 AJvYcCVUR6x2TYvkKLvFeqPKvQal8qrKTNgKrxSn70ZiJGC16iKV+CtdpJRbyzU/2tzR3uewH62JlMynGz/Zog==@nongnu.org
X-Gm-Message-State: AOJu0YzMAwtg1or/vaAGHwyvLmi/6839RRXMBrCH3gmrj1KT4T7JHCq0
 tXVICh6UeaANtFyu4rWFSVv765fBNsFbNfse8FWaLRMjVVouOmvxkZcM
X-Gm-Gg: ASbGnctpt8AaUoqpLyG7GQtXZ6nRePXZXWqsIypiAEufVnd+uiigNJvHSktL+wfJrGu
 hbjMn+qeaHXDkVpExQzpgxpN7R1oEEm5gCkoV2Af9BD15svJD4elpyyb2iz+HEJp6gOm2nrGP1J
 t7tolE32MaYL3P9HkqRWSNAb9QXmkh6XzzeyUy7RJuhoV41yn5/F2ErzBj2LnRD85k4kwKIQTRK
 ywEI3C9wUHMs60hsJszxVKxjLQ3HkyevN8a8bNoGReuqiAmCsznSS4VKNTLd1xwmFCGGb5zOgZF
 FQVIX1obVOh9II7oGxlIQFL3tWSajHJAKfqHv2e9yfPOue08c+CZrsGBpcGXK42uuxxODr7LyHY
 m2wrzAQfxgY7OIyhHSLtr1bIu3xKmfv+6Qs9f9m/8gqR+go/0FcJfsVNvChrBqN3BTcfJ9oy0Bd
 8=
X-Google-Smtp-Source: AGHT+IEL5HvEWmzFyJQMiCbVO8ilmml4jpBac7/FGPMv2HowIGnhrCR0DlgoZj33wN8GycD/JiwUEQ==
X-Received: by 2002:a17:902:e5c5:b0:24b:2336:e1c5 with SMTP id
 d9443c01a7336-24b2336e605mr49311645ad.55.1756866117827; 
 Tue, 02 Sep 2025 19:21:57 -0700 (PDT)
Received: from localhost (123.253.189.97.qld.leaptel.network. [123.253.189.97])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-24c928dab7fsm2364735ad.34.2025.09.02.19.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 19:21:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
X-Google-Original-From: Nicholas Piggin <npiggin@lima-default>
Date: Wed, 3 Sep 2025 12:21:55 +1000
To: Chao Liu <chao.liu@zevorn.cn>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com, 
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 0/2] target/riscv: Generate strided vector ld/st with
 tcg
Message-ID: <6bqmz4ejwvp4vaj2vve7scqwsvrnjzm657htie7xcvciy54gw6@nbz6hvbombui>
References: <cover.1755609029.git.chao.liu@zevorn.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755609029.git.chao.liu@zevorn.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Aug 19, 2025 at 09:23:38PM +0800, Chao Liu wrote:
> Hi all,
> 
> In this patch (v5), I've removed the redundant call to mark_vs_dirty(s)
> within the gen_ldst_stride_main_loop() function.
> 
> The reason for this change is that mark_vs_dirty(s) is already being called
> at a higher level, making the call inside gen_ldst_stride_main_loop()
> unnecessary.

Hey, nice patch. Do you have any performance numbers?

I hit a problem with this being unable to deal with restarts. You left
the existing heleprs in there that can deal with vstart != 0, so I guess
you intended it to fall back, but it's not quite wired up right.

I tried adding that in and it seems to work. Also made a little
adjustment to your test case if you wouldn't mind changing that too.

I have a tcg test for interrupted vector memory operations that caught
this bug, I will submit it soon and cc you on it.

Thanks,
Nick

[PATCH] target/riscv: Fix "Generate strided vector ld/st with tcg"

If a strided vector memory access instruction has non-zero
vstart, fall back to the helper functions rather than causing
an illegal instruction trap. The vlse/vsse helpers were dead
code before this.

An implementation is permitted to cause an illegal instruction
if vstart is not 0 and it is set to a value that can not be
produced implicitly by the implementation, but memory accesses
will generally always need to deal with page faults.

This also adjusts the tcg test Makefile change to specify the
cpu type on a per-test basis, because I have another test that
needs different CPU options, and that gets broken if you
change it this way.

[ feel free to take changes or parts of the changelog and adjust
/ merge them into your patches ]

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc   | 37 ++++++++++++++++++++---
 tests/tcg/riscv64/Makefile.softmmu-target |  3 +-
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5e200249ef..439ea0edcf 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1090,11 +1090,30 @@ static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
     return;
 }
 
+typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
+                                    TCGv, TCGv_env, TCGv_i32);
+
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
-                              uint32_t data, DisasContext *s, bool is_load)
+                              uint32_t data, gen_helper_ldst_stride *fn,
+                              DisasContext *s, bool is_load)
 {
     if (!s->vstart_eq_zero) {
-        return false;
+        TCGv_ptr dest, mask;
+        TCGv base, stride;
+        TCGv_i32 desc;
+
+        dest = tcg_temp_new_ptr();
+        mask = tcg_temp_new_ptr();
+        base = get_gpr(s, rs1, EXT_NONE);
+        stride = get_gpr(s, rs2, EXT_NONE);
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                          s->cfg_ptr->vlenb, data));
+
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+        mark_vs_dirty(s);
+        fn(dest, mask, base, stride, tcg_env, desc);
+        return true;
     }
 
     TCGv dest = tcg_temp_new();
@@ -1146,6 +1165,16 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
 {
     uint32_t data = 0;
+    gen_helper_ldst_stride *fn;
+    static gen_helper_ldst_stride *const fns[4] = {
+        gen_helper_vlse8_v, gen_helper_vlse16_v,
+        gen_helper_vlse32_v, gen_helper_vlse64_v
+    };
+
+    fn = fns[eew];
+    if (fn == NULL) {
+        return false;
+    }
 
     uint8_t emul = vext_get_emul(s, eew);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -1153,7 +1182,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1177,7 +1206,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, NULL, s, false);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index f09f1a57c4..d9f067dbd4 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -14,7 +14,7 @@ CFLAGS += -march=rv64gcv -mabi=lp64d -g -Og
 %: %.o $(LINK_SCRIPT)
 	$(LD) $(LDFLAGS) $< -o $@
 
-QEMU_OPTS += -M virt -cpu rv64,v=true -display none -semihosting -device loader,file=
+QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
 
 EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
@@ -30,6 +30,7 @@ run-misa-ialign: misa-ialign
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
 EXTRA_RUNS += run-vlsseg8e32
+run-vlsseg8e32: QEMU_OPTS := -cpu rv64,v=true $(QEMU_OPTS)
 run-vlsseg8e32: test-vlsseg8e32
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
-- 
2.51.0



