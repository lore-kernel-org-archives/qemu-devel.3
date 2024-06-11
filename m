Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D2C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S7-0007xr-Oh; Tue, 11 Jun 2024 10:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S2-0007hK-Fe
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rx-0006AF-A7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JKKpF/R8XrovARW4oO1irCqVYJ8qovTQdQfc+FwtlE=;
 b=C8QXHZAYqXNniN/N8qYI9ERYnykuedzf+OvBCTpFw6MDFesnJNkKtCA5JSGcOWSqnKNeLR
 2TG37MYXMPsybl3yfNnKadHxczLzQSuhCyucmCWlabw9MWtR8Kgf08RHEV7Gl3xKmCz7nI
 Z1Zig+LXaNi/9dOFYkAfaD4txy+pi08=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Nv5EEF10ODaejqTpixWB0A-1; Tue, 11 Jun 2024 10:26:08 -0400
X-MC-Unique: Nv5EEF10ODaejqTpixWB0A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6ef9e87ef1so187803466b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115966; x=1718720766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JKKpF/R8XrovARW4oO1irCqVYJ8qovTQdQfc+FwtlE=;
 b=H13MEy2Kx1T1/hlsG6Wwv9NH37do29Td+1hMlKXf2zQOWuKJxyaBoJ1eOosVytJJll
 zLaQZ9wJiD1HZuChFTplakdTQEAJ4Vc0Mx63mdildPzaMYlb5qFle/vi8pjRVW+jONnb
 sMU+mjsZRX5vj/Rs5j6evL9v87reoGRRizD0/enSYHjwvttIHD6R60kKMtTWcUab+aOY
 8AXssFFT5Idd+8j0M4K1Szyna9o212PqVVIjEw+AX0vRJM20Rxfm7fN3q/5iAEhFxqk1
 keicxnnCvhDEQ4iH+XQkpuA2XdIVW+XSMXXWOeB8mMWDqTLnMU2APcHSXxKloATD2YYd
 V8sg==
X-Gm-Message-State: AOJu0Yy0VUR3F8b6idZYf1UdoxdH4ag8YM++MZSKMXLI7g/qcQxPQRLo
 dC5YWoqFc3FBOwZ5w49LYmZOlxwnBvXTQGjodlSBT8QDVdNY8tkvwAV1AWGOCXp/x3tOBIYCQPD
 TMTx4H/0c5V/40Lxdcx7q4HIOxu+LT+h9b1LdZhXix8dD4bd9JUVS0FGt8v0ifAkMQkyyuREmgK
 dv4xbOUYkIRCWTw3oFhESSZehwz7ggA0E+Bpe5
X-Received: by 2002:a17:907:94cb:b0:a6c:7181:4ffe with SMTP id
 a640c23a62f3a-a6f1204771cmr491173866b.66.1718115966185; 
 Tue, 11 Jun 2024 07:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVUzOzFUlgcVMFyMLwKrsP2tjtiS2P3Y9l49pIp+amensp9rsny4TLllTAXT7S12ORsg8QQQ==
X-Received: by 2002:a17:907:94cb:b0:a6c:7181:4ffe with SMTP id
 a640c23a62f3a-a6f1204771cmr491172466b.66.1718115965874; 
 Tue, 11 Jun 2024 07:26:05 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c7ef8d914sm4421131a12.71.2024.06.11.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/25] target/i386: pull load/writeback out of gen_shiftd_rm_T1
Date: Tue, 11 Jun 2024 16:25:17 +0200
Message-ID: <20240611142524.83762-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Use gen_ld_modrm/gen_st_modrm, moving them and gen_shift_flags to the
caller.  This way, gen_shiftd_rm_T1 becomes something that the new
decoder can call.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 55 ++++++++++---------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4b2f7488022..5200b578a0e 100644
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
@@ -1486,19 +1477,12 @@ static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,
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
 
@@ -1563,10 +1547,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
         break;
     }
 
-    /* store */
-    gen_op_st_rm_T0_A0(s, ot, op1);
-
-    gen_shift_flags(s, ot, s->T0, s->tmp0, count, is_right);
+    return count;
 }
 
 #define X86_MAX_INSN_LENGTH 15
@@ -3076,9 +3057,9 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     CPUX86State *env = cpu_env(cpu);
     int prefixes = s->prefix;
     MemOp dflag = s->dflag;
-    int shift;
+    TCGv shift;
     MemOp ot;
-    int modrm, reg, rm, mod, op, opreg, val;
+    int modrm, reg, rm, mod, op, val;
 
     /* now check op code */
     switch (b) {
@@ -3244,39 +3225,31 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
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
 
         /************************/
-- 
2.45.1


