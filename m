Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E8C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Re-000777-Tr; Tue, 11 Jun 2024 10:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rd-00073O-5R
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rb-00063w-Cu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+nZnaF+LSRzSJx+IJ75gxTRSz7Q/aFv3RCPNcUp4a0=;
 b=NUwHBstkTpXPwHhRkX4yb25qCKENaiUz8tI5nNxSoKbaIXrWr3pg0ukXTF7HbnTjZWOkgM
 f3vk4D9KfTrNLCbphmskn5981A/p0/Z9ive8bj9Pgw3TxTwz7WQDYtBstjXuLt+oM81ZSB
 6UwCgxDNBcAEsktdBHdvIRfVt2WH99w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-JDrwa2G5P7mOkz1qA2UN7A-1; Tue, 11 Jun 2024 10:25:49 -0400
X-MC-Unique: JDrwa2G5P7mOkz1qA2UN7A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f2f8bd61dso72962666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115947; x=1718720747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+nZnaF+LSRzSJx+IJ75gxTRSz7Q/aFv3RCPNcUp4a0=;
 b=bXU9XxF1KKgdBuqTgORs3mwkclEj9bEJ4qE1nJS6PccsoCv0SsksRyFecasOoiA4sO
 FbEWobdyucWu3l3xx1OdZoC80qbjaZpXEpUYdhDSbaLR4PnZAIASTgwirn4SDALIYZM3
 Pjssyf9QsoCXk4y3qIZN7ot6VO1tgcfIlX9w2kMOzs2AP7Tx6l+YsOHVN3u4GTDILx6f
 M+LIVm5K1cyEvdiTPDEsSSlYCR+dhXVmwN8+VZVwDdyRw5r1mrmxhhAnbab3GWDr9zVr
 TcoBwirGJRb6HVjgValSdHOVMfpXnv4zVIWi2TjqCTx+9o1Hg3sPuhFiZy5re8kc+gCe
 RQAw==
X-Gm-Message-State: AOJu0Yxae0OOLU0thVVieJPfJZ9djf4E/NT0lYHSJ6FNMzIMHz1DcA/f
 4447kZdAEmGN7GmaBat56V8SJEaVoNkTSnqQnM9nlg4AaLFQ0xS6Ner9/GocZy0310l+sETaanY
 w/1LlS/jzVKBN0ipx96n3cP+whZ0xMW3WAaICXxlVJi/CByEQrrDzMoQYLqvqSeyqsPZJtqn967
 Mk1GdFS8KuObq8UGzRh83mCQcoujOxedt1iCKn
X-Received: by 2002:a17:906:f28c:b0:a6f:256d:7452 with SMTP id
 a640c23a62f3a-a6f256d750fmr316876366b.13.1718115947037; 
 Tue, 11 Jun 2024 07:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElhkOAGslMWeTahHB7OBiNPoxfOAyk1AZEwr7EL8JmDKuykJwDL8APNedCfbDyyRKi900xxg==
X-Received: by 2002:a17:906:f28c:b0:a6f:256d:7452 with SMTP id
 a640c23a62f3a-a6f256d750fmr316874466b.13.1718115946645; 
 Tue, 11 Jun 2024 07:25:46 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f29bda0c7sm174595866b.41.2024.06.11.07.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/25] target/i386: change X86_ENTRYwr to use T0,
 use it for moves
Date: Tue, 11 Jun 2024 16:25:08 +0200
Message-ID: <20240611142524.83762-11-pbonzini@redhat.com>
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

Just like X86_ENTRYr, X86_ENTRYwr is easily changed to use only T0.
In this case, the motivation is to use it for the MOV instruction
family.  The case when you need to preserve the input value is the
odd one, as it is used basically only for BLS* instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 48 ++++++++++++++++----------------
 target/i386/tcg/emit.c.inc       |  2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f9d3e2577b2..d41002e2f5c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -180,7 +180,7 @@
 #define X86_OP_ENTRYrr(op, op0, s0, op1, s1, ...)                 \
     X86_OP_ENTRY3(op, None, None, op0, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRYwr(op, op0, s0, op1, s1, ...)                 \
-    X86_OP_ENTRY3(op, op0, s0, None, None, op1, s1, ## __VA_ARGS__)
+    X86_OP_ENTRY3(op, op0, s0, op1, s1, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRY2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_ENTRY3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
 #define X86_OP_ENTRYw(op, op0, s0, ...)                           \
@@ -612,15 +612,15 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 /* five rows for no prefix, 66, F3, F2, 66+F2  */
 static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
     [0] = {
-        X86_OP_ENTRY3(MOVBE, G,y, M,y, None,None, cpuid(MOVBE)),
-        X86_OP_ENTRY3(MOVBE, G,w, M,w, None,None, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,y, M,y, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, G,w, M,w, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
         X86_OP_ENTRY2(CRC32, G,d, E,b, cpuid(SSE42)),
     },
     [1] = {
-        X86_OP_ENTRY3(MOVBE, M,y, G,y, None,None, cpuid(MOVBE)),
-        X86_OP_ENTRY3(MOVBE, M,w, G,w, None,None, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,y, G,y, cpuid(MOVBE)),
+        X86_OP_ENTRYwr(MOVBE, M,w, G,w, cpuid(MOVBE)),
         {},
         X86_OP_ENTRY2(CRC32, G,d, E,y, cpuid(SSE42)),
         X86_OP_ENTRY2(CRC32, G,d, E,w, cpuid(SSE42)),
@@ -1586,18 +1586,18 @@ static const X86OpEntry opcodes_root[256] = {
     [0x7E] = X86_OP_ENTRYr(Jcc, J,b),
     [0x7F] = X86_OP_ENTRYr(Jcc, J,b),
 
-    [0x88] = X86_OP_ENTRY3(MOV, E,b, G,b, None, None),
-    [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
-    [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
-    [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
-    /* Missing in Table A-2: memory destination is always 16-bit.  */
-    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None, op0_Mw),
-    [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
-    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,w, None, None),
+    [0x88] = X86_OP_ENTRYwr(MOV, E,b, G,b),
+    [0x89] = X86_OP_ENTRYwr(MOV, E,v, G,v),
+    [0x8A] = X86_OP_ENTRYwr(MOV, G,b, E,b),
+    [0x8B] = X86_OP_ENTRYwr(MOV, G,v, E,v),
+     /* Missing in Table A-2: memory destination is always 16-bit.  */
+    [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
+    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, noseg),
+    [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
     [0x8F] = X86_OP_GROUPw(group1A, E,v),
 
     [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
-    [0x99] = X86_OP_ENTRY3(CWD,    2,v, 0,v, None, None), /* rDX, rAX */
+    [0x99] = X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
     [0x9A] = X86_OP_ENTRYrr(CALLF, I_unsigned,p, I_unsigned,w, chk(i64)),
     [0x9B] = X86_OP_ENTRY0(WAIT),
     [0x9C] = X86_OP_ENTRY0(PUSHF,  chk(vm86_iopl) svm(PUSHF)),
@@ -1607,22 +1607,22 @@ static const X86OpEntry opcodes_root[256] = {
 
     [0xA8] = X86_OP_ENTRYrr(AND, 0,b, I,b),   /* AL, Ib */
     [0xA9] = X86_OP_ENTRYrr(AND, 0,v, I,z),   /* rAX, Iz */
-    [0xAA] = X86_OP_ENTRY3(STOS, Y,b, 0,b, None, None),
-    [0xAB] = X86_OP_ENTRY3(STOS, Y,v, 0,v, None, None),
+    [0xAA] = X86_OP_ENTRYwr(STOS, Y,b, 0,b),
+    [0xAB] = X86_OP_ENTRYwr(STOS, Y,v, 0,v),
     /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
     [0xAC] = X86_OP_ENTRYr(LODS, X,b),
     [0xAD] = X86_OP_ENTRYr(LODS, X,v),
     [0xAE] = X86_OP_ENTRYrr(SCAS, 0,b, Y,b),
     [0xAF] = X86_OP_ENTRYrr(SCAS, 0,v, Y,v),
 
-    [0xB8] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xB9] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBA] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBB] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBC] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBD] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBE] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
-    [0xBF] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xB8] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xB9] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBA] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBB] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBC] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBD] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBE] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
+    [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
 
     [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
     [0xC9] = X86_OP_ENTRY1(LEAVE, A,d64),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 797e6e81406..78d89db57cd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1796,7 +1796,7 @@ static void gen_IN(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[0].ot;
     TCGv_i32 port = tcg_temp_new_i32();
 
-    tcg_gen_trunc_tl_i32(port, s->T1);
+    tcg_gen_trunc_tl_i32(port, s->T0);
     tcg_gen_ext16u_i32(port, port);
     if (!gen_check_io(s, ot, port, SVM_IOIO_TYPE_MASK)) {
         return;
-- 
2.45.1


