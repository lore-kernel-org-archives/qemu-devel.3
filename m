Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4375EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAsW9-0003sQ-D7; Fri, 02 May 2025 11:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAsW7-0003rW-Tp
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAsW5-0005Eh-V8
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746200493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQ62A3MCY62mWXW1oMyGxVt/pkkUQ6ezdwuuGxH7Rf0=;
 b=QoDyD+bVInjGR6dBVOLn6cXASNa0aRB9nTcFegwEKm4YYnv8DzAe4Ed596Iylv242obzpz
 v48jFYkSxnSijm2dCvBCWvVigDxZGkY6r6/quuAk2b+tDYHnVeTiX6eVxNzWGU5akkocVI
 l1DmU/BLODIWusGEH+oU++C45TulX6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-AgDLWm4jO0yDzJvc3Qxj4w-1; Fri, 02 May 2025 11:41:31 -0400
X-MC-Unique: AgDLWm4jO0yDzJvc3Qxj4w-1
X-Mimecast-MFC-AGG-ID: AgDLWm4jO0yDzJvc3Qxj4w_1746200490
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39130f02631so612107f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 08:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746200490; x=1746805290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQ62A3MCY62mWXW1oMyGxVt/pkkUQ6ezdwuuGxH7Rf0=;
 b=HGagCO6tvRdwPgCKtCLuxuhcM+xUR2FpXgOVrzfr/cBBciV+NPIZ/+WBV3yxn0Karf
 a8h1hGEK/hJ5HQjfDVYLJddqGZVwMB/CwNeSRaIr7A0nd+930jmPbmc8Tjhu3TgfPIBc
 KJ6FV6KPnEtfsedvx8xYPcg28JGq7zINDPMhRZHTZ+OAWtZUmD1Iky3TtKmHqP3pBVMc
 gLyPnE6ZGbFv6tYVwEq9zt8QqOp4FnVPMxgZ+5HGJ08RIsMC8a7OWAJrarIvQ+NnJCn1
 XEy3KwNgkV0FXTjH8gQ90uLDvlWBXpderKwyOSXAXN8hm8XkfuUNw5Yk2lDUJpmnTtMA
 kpHQ==
X-Gm-Message-State: AOJu0Yz6O8ARPYSLyf8HyqhTV83ffJp6YwebwYNbzolQAWJa/lkUMEFl
 J0t/FqcIDN/bXVGEhxcJeB37qMG1nPJ5rq7rXtBQkLALVk124zGJHN8MuLa1t8mDdaLk94nvHKm
 ZAenKvSwE96zEmloN6zvBLvJPOLUVUpj+QZJ4jMOkHnc5y7HLo5P2jlQQkd0XSC4CIMuxLVgEp+
 164m1llMa8TkG9NikBFGJ3dpHB07qBkH5BhYOX
X-Gm-Gg: ASbGnctQRt5HhHn8+pjyvWGOwZTs8GdKpH5qdE6y+i/ZVAyB5InirpG2oy1uUG8DEoa
 xP8y/w/u1VY1IiIBp01xYD1BaQ/jVELXdm+Tcok8Dt4+eesi6yu4g2e5BFhVATRTsoNRirO6j3V
 QNfSL/6HcO5JOQDdWWTyjeyhvA9Yd2K7H+VunPkuQ9fX54j1SAZ7W/Jomnk+Z3WUkvc0n18dDDs
 NaO93a2k7yd0Gc/AE+Aryz1vMog5MfD4hcCoQeRyzjo8VUEQSxDfU9u71+lLLYlE1P4+CJ0RKMQ
 N3hmcCbwF74fGgc=
X-Received: by 2002:a05:6000:1845:b0:3a0:7b05:cfe4 with SMTP id
 ffacd0b85a97d-3a099ad1c2dmr3177279f8f.11.1746200489707; 
 Fri, 02 May 2025 08:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOZkRfJQVLpqouOYaFNVU4e0GibYdToVMW/hs+nHfuVAbtrJRAFPah2Qbq6TFVlitu6IbQNg==
X-Received: by 2002:a05:6000:1845:b0:3a0:7b05:cfe4 with SMTP id
 ffacd0b85a97d-3a099ad1c2dmr3177256f8f.11.1746200489316; 
 Fri, 02 May 2025 08:41:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b172b3sm2475103f8f.90.2025.05.02.08.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:41:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/i386: do not trigger IRQ shadow for LSS
Date: Fri,  2 May 2025 17:41:24 +0200
Message-ID: <20250502154125.152090-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502154125.152090-1-pbonzini@redhat.com>
References: <20250502154125.152090-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Because LSS need not trigger an IRQ shadow, gen_movl_seg can't just use
the destination register to decide whether to inhibit IRQs.  Add an
argument.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 27 ++++++++++++++++-----------
 target/i386/tcg/emit.c.inc  |  4 ++--
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8a641951cd1..a4e935b043b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2026,27 +2026,32 @@ static void gen_op_movl_seg_real(DisasContext *s, X86Seg seg_reg, TCGv seg)
 
 /* move SRC to seg_reg and compute if the CPU state may change. Never
    call this function with seg_reg == R_CS */
-static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src)
+static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit_irq)
 {
     if (PE(s) && !VM86(s)) {
         TCGv_i32 sel = tcg_temp_new_i32();
 
         tcg_gen_trunc_tl_i32(sel, src);
         gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
-        /* abort translation because the addseg value may change or
-           because ss32 may change. For R_SS, translation must always
-           stop as a special handling must be done to disable hardware
-           interrupts for the next instruction */
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        } else if (CODE32(s) && seg_reg < R_FS) {
+
+        /* For move to DS/ES/SS, the addseg or ss32 flags may change.  */
+        if (CODE32(s) && seg_reg < R_FS) {
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
         gen_op_movl_seg_real(s, seg_reg, src);
-        if (seg_reg == R_SS) {
-            s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
-        }
+    }
+
+    /*
+     * For MOV or POP to SS (but not LSS) translation must always
+     * stop as a special handling must be done to disable hardware
+     * interrupts for the next instruction.
+     *
+     * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
+     * might have been set above.
+     */
+    if (inhibit_irq) {
+        s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
     }
 }
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e3166e70a5b..1a7fab9333a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -342,7 +342,7 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         break;
     case X86_OP_SEG:
         /* Note that gen_movl_seg takes care of interrupt shadow and TF.  */
-        gen_movl_seg(s, op->n, s->T0);
+        gen_movl_seg(s, op->n, v, op->n == R_SS);
         break;
     case X86_OP_INT:
         if (op->has_ea) {
@@ -2382,7 +2382,7 @@ static void gen_lxx_seg(DisasContext *s, X86DecodedInsn *decode, int seg)
     gen_op_ld_v(s, MO_16, s->T1, s->A0);
 
     /* load the segment here to handle exceptions properly */
-    gen_movl_seg(s, seg, s->T1);
+    gen_movl_seg(s, seg, s->T1, false);
 }
 
 static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
-- 
2.49.0


