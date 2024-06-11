Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E342CC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RZ-0006yu-TZ; Tue, 11 Jun 2024 10:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RX-0006y6-Tr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RW-00060f-9Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtwFdY029c9DH13NuI66i1ii4THqx1TIYPsVWSPAq9g=;
 b=Q5+KQUuF1rIrFPoT3tIH1qdD9GvSGNvtCqwW25q3hmen1HfTWeZsznaAd7vpGnQduYueR0
 CGo1rHwOEins/ftNWu7SgFSObU/HrrqQ435yDmwjLEmkHD1oZs8TtKZyVUUrpI3Wy4qLrz
 rBl3Z0x2N0H+BDuT7GQoXg6juD1I3lY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-aFforOMqP5Spx74ux1IxGA-1; Tue, 11 Jun 2024 10:25:43 -0400
X-MC-Unique: aFforOMqP5Spx74ux1IxGA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f2d98f41fso58614066b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115941; x=1718720741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtwFdY029c9DH13NuI66i1ii4THqx1TIYPsVWSPAq9g=;
 b=s5jvn3CSXJoVcIcGo9jeP/ixz6mj7O1n58zRDvgrF7nY0Lm2TJdaTbF7Q9imQkSiSZ
 LW6oX86aGfVxpGS2vpwiDJi/fywSpL6BRbFSvWgVdAdquIAqFEBZljB1lqOqgMGQGiM1
 MZLrKkYIyEXdrf8rnXgsxQKVmAMDrSawgjtTe74RJdO/XEHhfFRpQqPTGn4k6g50WY71
 jk8LeOnGtUWRqbjHS4L7oo+ef/RMM3DofwePOkQBaJaZMzmN1gFPYjy+PqCVitO+BE4D
 pO/ZZY8+KqIKXVETqfoBgYQDYYlkZ+yxVlmA14j5PjzEXOBd1pSdd+Wbv9/ChS2ZoRox
 1hLQ==
X-Gm-Message-State: AOJu0YxFqBe1Hd6QXT7Eq+k8d4H/z5QqZ82b3yzddGbSlMt3TLSSik+o
 ZBr81kuXk2UQOF8qlQD34LrlxAmxXDwo6dQ55B0r2TjUdygwxoVqUge8HB4f33/sJhoQ7/jouvd
 OKrTiuwO2lnSmXd0SdYcC5T835gdhB1H8W6mhBtOVoa4dFw6/ObiAGkicpe0M4SAOHhKg75y5kj
 KkvTIs4rkrqNmEDlr8FZO7Rj7ZZSOLPtTiixEO
X-Received: by 2002:a17:906:110d:b0:a6f:ce5:2877 with SMTP id
 a640c23a62f3a-a6f0ce52b29mr483955266b.51.1718115941651; 
 Tue, 11 Jun 2024 07:25:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF78kX3yKxqDVtv/nE6z4tx7SAHKUnHp9Skeu/yxKGbgQ7jvqwIERv0U+v+zC3i14JzIP/Rag==
X-Received: by 2002:a17:906:110d:b0:a6f:ce5:2877 with SMTP id
 a640c23a62f3a-a6f0ce52b29mr483953866b.51.1718115941346; 
 Tue, 11 Jun 2024 07:25:41 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6eff899fbbsm471277066b.212.2024.06.11.07.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/25] target/i386: put BLS* input in T1,
 use generic flag writeback
Date: Tue, 11 Jun 2024 16:25:06 +0200
Message-ID: <20240611142524.83762-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

This makes for easier cpu_cc_* setup, and not using set_cc_op()
should come in handy if QEMU ever implements APX.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc |  4 ++--
 target/i386/tcg/emit.c.inc       | 24 +++++++++---------------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index e7d88020481..380fb793531 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -633,7 +633,7 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
         {},
     },
     [3] = {
-        X86_OP_GROUP3(group17, B,y, E,y, None,None, vex13 cpuid(BMI1)),
+        X86_OP_GROUP3(group17, B,y, None,None, E,y, vex13 cpuid(BMI1)),
         {},
         {},
         {},
@@ -2604,7 +2604,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     }
 
     /*
-     * Write back flags after last memory access.  Some newer ALU instructions, as
+     * Write back flags after last memory access.  Some older ALU instructions, as
      * well as SSE instructions, write flags in the gen_* function, but that can
      * cause incorrect tracking of CC_OP for instructions that write to both memory
      * and flags.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2041ea9d04a..a25b3dfc6b5 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1272,40 +1272,34 @@ static void gen_BEXTR(DisasContext *s, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
-/* BLSI do not have memory operands and can use set_cc_op.  */
 static void gen_BLSI(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
-    tcg_gen_mov_tl(cpu_cc_src, s->T0);
-    tcg_gen_neg_tl(s->T1, s->T0);
+    /* input in T1, which is ready for prepare_update2_cc  */
+    tcg_gen_neg_tl(s->T0, s->T1);
     tcg_gen_and_tl(s->T0, s->T0, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
-/* BLSMSK do not have memory operands and can use set_cc_op.  */
 static void gen_BLSMSK(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
-    tcg_gen_mov_tl(cpu_cc_src, s->T0);
-    tcg_gen_subi_tl(s->T1, s->T0, 1);
+    /* input in T1, which is ready for prepare_update2_cc  */
+    tcg_gen_subi_tl(s->T0, s->T1, 1);
     tcg_gen_xor_tl(s->T0, s->T0, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
-/* BLSR do not have memory operands and can use set_cc_op.  */
 static void gen_BLSR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
 
-    tcg_gen_mov_tl(cpu_cc_src, s->T0);
-    tcg_gen_subi_tl(s->T1, s->T0, 1);
+    /* input in T1, which is ready for prepare_update2_cc  */
+    tcg_gen_subi_tl(s->T0, s->T1, 1);
     tcg_gen_and_tl(s->T0, s->T0, s->T1);
-    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
 static void gen_BOUND(DisasContext *s, X86DecodedInsn *decode)
-- 
2.45.1


