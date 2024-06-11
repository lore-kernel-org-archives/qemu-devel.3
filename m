Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F89C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Ri-0007C3-9z; Tue, 11 Jun 2024 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rf-00078A-UL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Re-00066a-AY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r53vxid38JkbalFZ2GcX310E1spILyRXBqF8wFBK08I=;
 b=M/ZtUlcwVwip859FOb88+5jsVfm6Kp/mLsO4t/cNfaR6TUzk6+YycFXpTY7FUeEo7adLmn
 1uki7uNkTgdtc/ztzLi49KPoUJsmersQMyFHhPwk0aOCJUBalqc+yzDHtsdt5gloLz/M5k
 xWn8QCYLPINaZgjJmkwBkB7unGAYEE0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-S2l6TIKANNmTkIkCNaSQNQ-1; Tue, 11 Jun 2024 10:25:51 -0400
X-MC-Unique: S2l6TIKANNmTkIkCNaSQNQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6f3f614e58so26546066b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115949; x=1718720749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r53vxid38JkbalFZ2GcX310E1spILyRXBqF8wFBK08I=;
 b=V1s/98l7zbXXyRW021FOiEd27oFSewOqssHMxi5GJFRiWQxcUH7PNUx4gpmOU/YMsj
 Mpn0ExH+HqZzf3b0sxTVKM0ZGZaFTPb53NXqNz2cxtteRs2LbdfUrEdwVYDG7XmHyuEH
 GEmScnIqZ1Dfx8KVL/cFtQeFwpaRATXjHU8bK+l3jIEw4XPD2hNxH0SZeaWJxWzr9Ru/
 smreaOP7kiFyfxeFADYmDKkuMMW4Mf6Y5F+kTDHAcAG1zvMt3Ysv82gEj7VUvv8+e2xO
 8FfJIu2QhQ5x4e6p7eLxpnOGXzhSCYToRTcTWJOEsBr7o/ogeR98WjPWn9TV5EfCovg/
 cfbw==
X-Gm-Message-State: AOJu0YzB1b2x1sKVlvOIiYKf9BoXEpPtCNm2rhAquYXAnZLJmyKmKebo
 n2wjN9xhbPegc/Pwk06/W7FMT0jGp8OX2wUyNkxUlW1HpcxEsqWMgwZ45oVzf0/OLegXUvUX1xJ
 J9l1zv+LFWmt7CtBEvYAbwmMunSv4zQCn8qMkis435a0nDu6OMcKW56hW0vDfDVB7n2uqMN7jPI
 rLOPUTexH3AmdiF+GYGa+b7jHDj1qWu5oFtqen
X-Received: by 2002:a17:907:72cc:b0:a6f:18e4:1871 with SMTP id
 a640c23a62f3a-a6f18e43821mr697883966b.56.1718115949647; 
 Tue, 11 Jun 2024 07:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGIqbN+/KwITOIRLXuMnGSZLVayFpRsZq5KKv9OMLomLRuga3oIvPiss//a+nFaXpbe88Y7Q==
X-Received: by 2002:a17:907:72cc:b0:a6f:18e4:1871 with SMTP id
 a640c23a62f3a-a6f18e43821mr697882066b.56.1718115949258; 
 Tue, 11 Jun 2024 07:25:49 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1c2b1e80sm304707166b.145.2024.06.11.07.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/25] target/i386: replace NoSeg special with NoLoadEA
Date: Tue, 11 Jun 2024 16:25:09 +0200
Message-ID: <20240611142524.83762-12-pbonzini@redhat.com>
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

This is a bit more generic, as it can be applied to MPX as well.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  5 +++--
 target/i386/tcg/decode-new.c.inc | 12 ++++--------
 target/i386/tcg/emit.c.inc       |  3 ++-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index f704698575f..46a96b220d0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -170,8 +170,9 @@ typedef enum X86InsnSpecial {
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
-    /* Do not apply segment base to effective address */
-    X86_SPECIAL_NoSeg,
+    /* Do not load effective address in s->A0 */
+    X86_SPECIAL_NoLoadEA,
+
     /*
      * Rd/Mb or Rd/Mw in the manual: register operand 0 is treated as 32 bits
      * (and writeback zero-extends it to 64 bits if applicable).  PREFIX_DATA
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d41002e2f5c..4f5fcdb88dd 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -193,7 +193,7 @@
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
-#define noseg .special = X86_SPECIAL_NoSeg,
+#define nolea .special = X86_SPECIAL_NoLoadEA,
 #define xchg .special = X86_SPECIAL_Locked,
 #define lock .special = X86_SPECIAL_HasLock,
 #define mmx .special = X86_SPECIAL_MMX,
@@ -1592,7 +1592,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0x8B] = X86_OP_ENTRYwr(MOV, G,v, E,v),
      /* Missing in Table A-2: memory destination is always 16-bit.  */
     [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
-    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, noseg),
+    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
     [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
     [0x8F] = X86_OP_GROUPw(group1A, E,v),
 
@@ -2524,11 +2524,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         assert(decode.op[1].unit == X86_OP_INT);
         break;
 
-    case X86_SPECIAL_NoSeg:
-        decode.mem.def_seg = -1;
-        s->override = -1;
-        break;
-
     case X86_SPECIAL_Op0_Mw:
         assert(decode.op[0].unit == X86_OP_INT);
         if (decode.op[0].has_ea) {
@@ -2585,7 +2580,8 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         gen_helper_enter_mmx(tcg_env);
     }
 
-    if (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea) {
+    if (decode.e.special != X86_SPECIAL_NoLoadEA &&
+        (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea)) {
         gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
     }
     if (s->prefix & PREFIX_LOCK) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 78d89db57cd..e6521632edd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1970,7 +1970,8 @@ static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LEA(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_mov_tl(s->T0, s->A0);
+    TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
+    gen_lea_v_seg_dest(s, s->aflag, s->T0, ea, -1, -1);
 }
 
 static void gen_LEAVE(DisasContext *s, X86DecodedInsn *decode)
-- 
2.45.1


