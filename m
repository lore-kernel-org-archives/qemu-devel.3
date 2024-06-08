Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D528C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFreT-0003Vv-1L; Sat, 08 Jun 2024 04:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreR-0003Rz-Hl
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreP-0001Rw-Vo
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJcH5tshX4nsRNYSBtlqLleRQ0annTdItK+uyAnqpkA=;
 b=SFhKFP5wO+UzBjHMIys3plweRuDFQR1XzUPWry5s0srjBmvvPepKUjK7HxaSlqablQeL1Z
 n0FZIEbqG8dctkFornIrksZDCvX2ZeZPIf/gogOGSsdQDDtCXgCMf7NSHrqahp3XReU++T
 VyJqF6bUkc25N6xpPmBD0Tgg5ySPK2U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-hd9OSoOaNtetRTmTr5zVGQ-1; Sat, 08 Jun 2024 04:42:11 -0400
X-MC-Unique: hd9OSoOaNtetRTmTr5zVGQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6ef8d9d3efso16457466b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836129; x=1718440929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJcH5tshX4nsRNYSBtlqLleRQ0annTdItK+uyAnqpkA=;
 b=XuQfpzGsYQI028tSKQNqbGV/gAHB7WJf27wzDVbOZ3mCJOlIiiL/2+MksWFLYOZhJH
 iP7EtIyYWyNxNboG6Oi25TaOHKeFM5WUKNO+OMZxxHOJqt990+VX5l1UxXwnjlStfhXW
 fwhp4CUNOgL2ZUznkL/f0abjHNGW2M9fhYUMB0EEWFOYP3/QX9ssBHztHI+/vVJFIYSu
 nqBm0ioXlxK9QzAYcYOuLRUCi9GdMxNqWPittF2VzTQKWHBHWj4otx4o04Hb2KPKOQ9J
 TdwfTmMDOd1uCSSNA2gEeBTjEq0PJq9FNYFiZY7740LXYsopYrNLryM3+WqrFQBbTUd3
 u+Nw==
X-Gm-Message-State: AOJu0YwpMC/mKtKDZrGJDpKG81WB9p63aKVlJT9COlPDuFtwHv0U0XQj
 W9WP4SNaO1ZEZA5+avvfZ/bs+ccductnQt7jVDry35I/s1TILoQj4VjWzx8iB4qkZ34dKVcGhmJ
 oZPqOC06fgmGs0G7yqVG52ii6KiImN9jnMl+tiFcS+gPmiFZgJvC0kM6f5pC7u+Xl4Cfw6zMssh
 F8Mi5Mfx9zdVK6jN4vy9L+UN0b5h+S5BnCqTVO
X-Received: by 2002:a17:906:b313:b0:a6e:2a67:789f with SMTP id
 a640c23a62f3a-a6e2a677a24mr215074966b.40.1717836129144; 
 Sat, 08 Jun 2024 01:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG84wibuR6pFAitspADx3et4dNex5WEK3nOdESsZCnSIZWhzYRDua5Xuc+GARVjWEaZowtYZQ==
X-Received: by 2002:a17:906:b313:b0:a6e:2a67:789f with SMTP id
 a640c23a62f3a-a6e2a677a24mr215073466b.40.1717836128611; 
 Sat, 08 Jun 2024 01:42:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805d0ba8sm352223766b.85.2024.06.08.01.42.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/25] target/i386: pull load/writeback out of gen_shiftd_rm_T1
Date: Sat,  8 Jun 2024 10:41:03 +0200
Message-ID: <20240608084113.2770363-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use gen_ld_modrm/gen_st_modrm, moving them and gen_shift_flags to the
caller.  This way, gen_shiftd_rm_T1 becomes something that the new
decoder can call.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 55 ++++++++++---------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c3843092350..416db2f3b0e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -535,15 +535,6 @@ static inline void gen_op_st_v(DisasContext *s, int idx, TCGv t0, TCGv a0)
     tcg_gen_qemu_st_tl(t0, a0, s->mem_index, idx | MO_LE);
 }
 
-static inline void gen_op_st_rm_T0_A0(DisasContext *s, int idx, int d)
-{
-    if (d == OR_TMP0) {
-        gen_op_st_v(s, idx, s->T0, s->A0);
-    } else {
-        gen_op_mov_reg_v(s, idx, d, s->T0);
-    }
-}
-
 static void gen_update_eip_next(DisasContext *s)
 {
     assert(s->pc_save != -1);
@@ -1481,19 +1472,12 @@ static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,
 }
 
 /* XXX: add faster immediate case */
-static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
+static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
                              bool is_right, TCGv count_in)
 {
     target_ulong mask = (ot == MO_64 ? 63 : 31);
     TCGv count;
 
-    /* load */
-    if (op1 == OR_TMP0) {
-        gen_op_ld_v(s, ot, s->T0, s->A0);
-    } else {
-        gen_op_mov_v_reg(s, ot, s->T0, op1);
-    }
-
     count = tcg_temp_new();
     tcg_gen_andi_tl(count, count_in, mask);
 
@@ -1558,10 +1542,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
         break;
     }
 
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-
-    gen_shift_flags(s, ot, s->T0, s->tmp0, count, is_right);
+    return count;
 }
 
 #define X86_MAX_INSN_LENGTH 15
@@ -3071,9 +3052,9 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     CPUX86State *env = cpu_env(cpu);
     int prefixes = s->prefix;
     MemOp dflag = s->dflag;
-    int shift;
+    TCGv shift;
     MemOp ot;
-    int modrm, reg, rm, mod, op, opreg;
+    int modrm, reg, rm, mod, op;
 
     /* now check op code */
     switch (b) {
@@ -3239,39 +3220,31 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         /* shifts */
     case 0x1a4: /* shld imm */
         op = 0;
-        shift = 1;
+        shift = NULL;
         goto do_shiftd;
     case 0x1a5: /* shld cl */
         op = 0;
-        shift = 0;
+        shift = cpu_regs[R_ECX];
         goto do_shiftd;
     case 0x1ac: /* shrd imm */
         op = 1;
-        shift = 1;
+        shift = NULL;
         goto do_shiftd;
     case 0x1ad: /* shrd cl */
         op = 1;
-        shift = 0;
+        shift = cpu_regs[R_ECX];
     do_shiftd:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
-        mod = (modrm >> 6) & 3;
-        rm = (modrm & 7) | REX_B(s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        if (mod != 3) {
-            gen_lea_modrm(env, s, modrm);
-            opreg = OR_TMP0;
-        } else {
-            opreg = rm;
+        gen_ld_modrm(env, s, modrm, ot);
+        if (!shift) {
+            shift = tcg_constant_tl(x86_ldub_code(env, s));
         }
         gen_op_mov_v_reg(s, ot, s->T1, reg);
-
-        if (shift) {
-            TCGv imm = tcg_constant_tl(x86_ldub_code(env, s));
-            gen_shiftd_rm_T1(s, ot, opreg, op, imm);
-        } else {
-            gen_shiftd_rm_T1(s, ot, opreg, op, cpu_regs[R_ECX]);
-        }
+        shift = gen_shiftd_rm_T1(s, ot, op, shift);
+        gen_st_modrm(env, s, modrm, ot);
+        gen_shift_flags(s, ot, s->T0, s->tmp0, shift, op);
         break;
     case 0x1bc: /* bsf / tzcnt */
     case 0x1bd: /* bsr / lzcnt */
-- 
2.45.1


