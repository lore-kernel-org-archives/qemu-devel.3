Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FBCC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFreg-00045j-EL; Sat, 08 Jun 2024 04:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFref-00040O-6J
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFred-0001Y7-Gl
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYrEQWcxDBQQFmBcc6ABlYJsEPy9UqCkZtpsfzq2g7k=;
 b=Yppwdqq3YG9RvfR0wIfs9D+2/nDtXH4Vzj6NHCdawshFEEcI6odIPOw+VWIerh/P02NXkn
 h3+J/rEBLEA5GH15jH43YIKcyaVFwHQxK//oCflwFWkH6n9pboH7vS2H8N7XDNCONj6AHn
 5FCgOuAn0nz6pCOYrCA+dsmbmPU+jpk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-Y2g9pHlCOtmnxatd-RnypA-1; Sat, 08 Jun 2024 04:42:24 -0400
X-MC-Unique: Y2g9pHlCOtmnxatd-RnypA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f0ed4c213so4378466b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836143; x=1718440943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYrEQWcxDBQQFmBcc6ABlYJsEPy9UqCkZtpsfzq2g7k=;
 b=q9EMEdq9l0dw8CDtumoPFtwm2vrXILImcrGnDlZRFNYE2NuQgWVM8iNPrmgSSL1VIr
 iu9keBr7Af7einzSix9KoNUe+tjFP1InFeqMYbFFVC34Qj9PZbYAQ5VRVvU2S5wKTFKW
 NyCEhew6D3Ilwe5KsAU08vi0XOabSdm32WEzbgkJB7Y6A2DJtF3lU3EzmB3UpbEq0bTu
 mdTlPKClL7TGnGKm0meY27nesPC5+5eTAWO3uLul0QPPL4m6x++ZU4oRf3DnfyYKn2sv
 D+xpdj9QfF/TOYdleV0TYikx2J5jr6wNAHjWig3c02tqgBkA+pCcSaFbzHK50M0aUszf
 m46Q==
X-Gm-Message-State: AOJu0Yx1/7E6jXfR5rZMB1ZdXWvna36WjkFE40rznEYRZoBlPmy49+LV
 QaT5YxVZ/bxnqSjKstWtVpVW3GVSr/qAf7ESfZSzBNIerX8rnaVoY4pcfIdLy3Qk+gJ5rkmiC2w
 57CAEKAcuajsBMtCfAC2DN3iDJCz7/1iBeHUrfznJNKyRkls10fahAL3WjzZ4UgrikSDnxws74Y
 Bc4BV+0ZdZrNff/EEkN1zSeeUkHPNwYeuNNZTM
X-Received: by 2002:a17:906:4914:b0:a62:c238:b229 with SMTP id
 a640c23a62f3a-a6cdb9d57c7mr383519366b.74.1717836142683; 
 Sat, 08 Jun 2024 01:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/VDKWBzglee1m31xUtXloBLGDKmFs0mY/XTPCtZ72wbUsby1MpQ3SY7ezvuYek6GQTl/ypQ==
X-Received: by 2002:a17:906:4914:b0:a62:c238:b229 with SMTP id
 a640c23a62f3a-a6cdb9d57c7mr383518066b.74.1717836142077; 
 Sat, 08 Jun 2024 01:42:22 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6efae62543sm92067466b.187.2024.06.08.01.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/25] target/i386: convert XADD to new decoder
Date: Sat,  8 Jun 2024 10:41:07 +0200
Message-ID: <20240608084113.2770363-20-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 35 --------------------------------
 target/i386/tcg/decode-new.c.inc |  3 ++-
 target/i386/tcg/emit.c.inc       | 24 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a9cf1332b43..7a63c927c1f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -818,12 +818,6 @@ static void gen_movs(DisasContext *s, MemOp ot)
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_op_update2_cc(DisasContext *s)
-{
-    tcg_gen_mov_tl(cpu_cc_src, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-}
-
 /* compute all eflags to reg */
 static void gen_mov_eflags(DisasContext *s, TCGv reg)
 {
@@ -3006,35 +3000,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
     switch (b) {
         /**************************/
         /* arith & logic */
-    case 0x1c0:
-    case 0x1c1: /* xadd Ev, Gv */
-        ot = mo_b_d(b, dflag);
-        modrm = x86_ldub_code(env, s);
-        reg = ((modrm >> 3) & 7) | REX_R(s);
-        mod = (modrm >> 6) & 3;
-        gen_op_mov_v_reg(s, ot, s->T0, reg);
-        if (mod == 3) {
-            rm = (modrm & 7) | REX_B(s);
-            gen_op_mov_v_reg(s, ot, s->T1, rm);
-            tcg_gen_add_tl(s->T0, s->T0, s->T1);
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-            gen_op_mov_reg_v(s, ot, rm, s->T0);
-        } else {
-            gen_lea_modrm(env, s, modrm);
-            if (s->prefix & PREFIX_LOCK) {
-                tcg_gen_atomic_fetch_add_tl(s->T1, s->A0, s->T0,
-                                            s->mem_index, ot | MO_LE);
-                tcg_gen_add_tl(s->T0, s->T0, s->T1);
-            } else {
-                gen_op_ld_v(s, ot, s->T1, s->A0);
-                tcg_gen_add_tl(s->T0, s->T0, s->T1);
-                gen_op_st_v(s, ot, s->T0, s->A0);
-            }
-            gen_op_mov_reg_v(s, ot, reg, s->T1);
-        }
-        gen_op_update2_cc(s);
-        set_cc_op(s, CC_OP_ADDB + ot);
-        break;
     case 0x1b0:
     case 0x1b1: /* cmpxchg Ev, Gv */
         {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 64ec731bf4a..11ecd1c6c1d 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1188,6 +1188,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xb6] = X86_OP_ENTRY3(MOV,    G,v, E,b, None, None, zextT0), /* MOVZX */
     [0xb7] = X86_OP_ENTRY3(MOV,    G,v, E,w, None, None, zextT0), /* MOVZX */
 
+    [0xc0] = X86_OP_ENTRY2(XADD,       E,b, G,b,            lock),
+    [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
     [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
@@ -2611,7 +2613,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             case 0x00 ... 0x01: /* mostly privileged instructions */
             case 0x1a ... 0x1b: /* MPX */
             case 0xb0 ... 0xb1: /* cmpxchg */
-            case 0xc0 ... 0xc1: /* xadd */
             case 0xc7:          /* grp9 */
                 disas_insn_old(s, cpu, b + 0x100);
                 return;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2fbf2a5ce8c..42e41a7a87c 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4492,6 +4492,30 @@ static void gen_WRxxBASE(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_mov_tl(base, s->T0);
 }
 
+static void gen_XADD(DisasContext *s, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    decode->cc_dst = tcg_temp_new();
+    decode->cc_src = s->T1;
+    decode->cc_op = CC_OP_ADDB + ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_fetch_add_tl(s->T0, s->A0, s->T1, s->mem_index, ot | MO_LE);
+        tcg_gen_add_tl(decode->cc_dst, s->T0, s->T1);
+    } else {
+        tcg_gen_add_tl(decode->cc_dst, s->T0, s->T1);
+        /*
+         * NOTE: writing memory first is important for MMU exceptions,
+         * but "new result" wins for XADD AX, AX.
+         */
+        gen_writeback(s, decode, 0, decode->cc_dst);
+    }
+    if (decode->op[0].has_ea || decode->op[2].n != decode->op[0].n) {
+        gen_writeback(s, decode, 2, s->T0);
+    }
+}
+
 static void gen_XCHG(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->prefix & PREFIX_LOCK) {
-- 
2.45.1


