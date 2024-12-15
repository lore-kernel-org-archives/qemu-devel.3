Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FABE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaA-0004Uy-GK; Sun, 15 Dec 2024 04:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka6-0004Tx-NK
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka5-0006xG-9q
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukTF0xScWnwWrNf37BS8Dvw3/BbLdE6czijwzXoGkA0=;
 b=S0h+nIzYfulDje8D4ljl9qYOqcNFgtjghucMpEkylEz9QjHXrbaHRBxzRNILZfO9sqnosd
 M00TdWQ5EkbeI5tP91dVurxeWJREbHwQnnwoThGXMXlKQuD2+OsqUsgBKs0lXX3UDDfcz7
 oF6eUZ9Ljoaez4TfXCFHEg1eglsSh14=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-0zbCm8A8MbCGKU4nIVwoZw-1; Sun, 15 Dec 2024 04:06:26 -0500
X-MC-Unique: 0zbCm8A8MbCGKU4nIVwoZw-1
X-Mimecast-MFC-AGG-ID: 0zbCm8A8MbCGKU4nIVwoZw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385f0829430so2144036f8f.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253584; x=1734858384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ukTF0xScWnwWrNf37BS8Dvw3/BbLdE6czijwzXoGkA0=;
 b=mTJEzzn048u+WQoMr15BwoLah+KvFeD/VV6Xa8Zh3WQw0KENucuUvY1O2Bcn6oS/OA
 Xv+8/nMNOXfsjo8XQ3toemmBkir9vu5o+4QCOlsJrC0Ftm7lD+WsN0LrAk+vaNhSwihd
 9g/lBX+5Po26vQD/hxAAN6vxqPMYhLKGT2FtrgGyaMu3bOK1E3tbTiCkyObEbfzH1bQU
 ImZnGg10dlgX/L0xT/Rx/VvC7wCAGJiMHgK7Ce2vLNKat8aBlKYqAF5k0+0EJf/22j98
 LiK6533LZItSat92j5sTNewateqEulQvrYaEFNMsuqRc34TH3zFLasMnjjUtROadReJN
 E09A==
X-Gm-Message-State: AOJu0Yx7jbnOERtg/rdfxePViopr6Psv3iQjcPl9c3L6qBJxyK0Ou7fj
 MigvGpDX8sDaXcrid2NAowrplPsyOpCed7bgjAU1UGI3Q8GlKzASbP7P1ZB90V8KMuPfc/ep9j8
 yprbu4H9DgnkON/4ws1K5b1a9hkYLxyYv2a4DUy8KN4e4NwkFguXclel7McE/iHPvdgSRCrN0NY
 ULCyajIikoxX4wJFl4teWgwLOXct9+8r6evQZK
X-Gm-Gg: ASbGncvxGH9cqUGwO1uHTSQM4BYWxzbWmsNFPbZyMEfovfsuj6kJVYMY1SHan/g9ubZ
 xZm7iFi4tWV/iXsT3Z8hX1Rn+ep40lCxqfSREH7j/WQBhTay6k07gDheW5gAkY3SXXWzxwuDhbi
 VIKHH3XnAujJn7efh3f/AADU8asnJ9tcTEX2SW7eDWaG78P+WEnNCzHv1grABcB/zH1LC4aYpRX
 GAQ86sf4MwelnnPRgLeNxPLYt/iZzpZLxPRZjKtAQYYZO4P5hKZS8n4k4w=
X-Received: by 2002:a05:6000:4028:b0:385:e2d5:cdf2 with SMTP id
 ffacd0b85a97d-38880ad9012mr7274926f8f.19.1734253584228; 
 Sun, 15 Dec 2024 01:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHAN2oz3cKZJNmOxqBXHzhiMft+Hoq67j4HogMJMuTdek6KGOLUEpTOXmQovdQXS+PSJyUnQ==
X-Received: by 2002:a05:6000:4028:b0:385:e2d5:cdf2 with SMTP id
 ffacd0b85a97d-38880ad9012mr7274895f8f.19.1734253583745; 
 Sun, 15 Dec 2024 01:06:23 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016275sm4678765f8f.24.2024.12.15.01.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 03/13] target/i386: unify REP and REPZ/REPNZ generation
Date: Sun, 15 Dec 2024 10:06:02 +0100
Message-ID: <20241215090613.89588-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It only differs in a single call to gen_jcc, so use a "bool" argument
to distinguish the two cases; do not duplicate code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 39 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 99e989d4b22..8bf6aa1fcf6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1309,14 +1309,18 @@ static void gen_outs(DisasContext *s, MemOp ot)
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
-/* Generate jumps to current or next instruction */
-static void gen_repz(DisasContext *s, MemOp ot,
-                     void (*fn)(DisasContext *s, MemOp ot))
+static void do_gen_rep(DisasContext *s, MemOp ot,
+                       void (*fn)(DisasContext *s, MemOp ot),
+                       bool is_repz_nz)
 {
     TCGLabel *l2;
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    if (is_repz_nz) {
+        int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
+        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
+    }
     /*
      * A loop would cause two single step exceptions if ECX = 1
      * before rep string_insn
@@ -1324,28 +1328,25 @@ static void gen_repz(DisasContext *s, MemOp ot,
     if (s->repz_opt) {
         gen_op_jz_ecx(s, l2);
     }
+    /*
+     * For CMPS/SCAS there is no need to set CC_OP_DYNAMIC: only one iteration
+     * is done at a time, so the translation block ends unconditionally after
+     * this instruction and there is no control flow junction.
+     */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 }
 
+static void gen_repz(DisasContext *s, MemOp ot,
+                     void (*fn)(DisasContext *s, MemOp ot))
+
+{
+    do_gen_rep(s, ot, fn, false);
+}
+
 static void gen_repz_nz(DisasContext *s, MemOp ot,
                         void (*fn)(DisasContext *s, MemOp ot))
 {
-    TCGLabel *l2;
-    int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
-
-    l2 = gen_jz_ecx_string(s);
-    fn(s, ot);
-    gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-    gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
-    if (s->repz_opt) {
-        gen_op_jz_ecx(s, l2);
-    }
-    /*
-     * Only one iteration is done at a time, so the translation
-     * block ends unconditionally after this instruction and there
-     * is no control flow junction - no need to set CC_OP_DYNAMIC.
-     */
-    gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
+    do_gen_rep(s, ot, fn, true);
 }
 
 static void gen_helper_fp_arith_ST0_FT0(int op)
-- 
2.47.1


