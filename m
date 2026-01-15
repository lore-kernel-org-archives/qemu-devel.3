Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B546D41174
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbi-00034F-2k; Thu, 15 Jan 2026 06:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbO-0001qf-7s
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbM-0003yT-Mj
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4ZP0M6LSe18tj6821SMJeDGGJkxkekrXzs8Be7PL+A=;
 b=KweCFEJ41TYUdr9AAQsh6kMAuyCgA7rGZ7myiywWnEhuVlWanJGwQ+ULSkXr1Ywlt65/lY
 ZHNY1H6XztIxpneDR7saSslvS2tv9zKjU47NDWyG95Tq0syO+rQNVUtXWVeQt8BkHk++xL
 3+BewVy8vFHvj92/hReajYjVghxNbs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-xoWcVTJpMLWn61_Aq4qtyA-1; Thu, 15 Jan 2026 06:33:18 -0500
X-MC-Unique: xoWcVTJpMLWn61_Aq4qtyA-1
X-Mimecast-MFC-AGG-ID: xoWcVTJpMLWn61_Aq4qtyA_1768476797
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo971880f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476797; x=1769081597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4ZP0M6LSe18tj6821SMJeDGGJkxkekrXzs8Be7PL+A=;
 b=nFUCLW1PWHOeEvLftWb+JrGPVKLQWNx65knQo/+N4SrBqn6stdwg4IATBSZRZrgys8
 8hmBgnXzov8iRnuemsbPD6eW22ovhGdmTafttggz/vABf73vGFYyK114jjeAkaC8GsS5
 8rhbRusd2wLRkx5g+xET5rxEmWvk+r925UDM95gIVEKBRsRBVyCXYXUe7fUb6WY7J6Jl
 yPif7+MnWQUJbtA8t7UbWoJq2mUI+ghrv8OYS/1lnesTZrC4TxyywgZYJhg0NsBfBkjx
 cV+j+CDs8sSx/3IUBZzn7d3wcbCqyu1X7XFQ6sIgIM8kXr8Lu5323F9cZFAU8pyNwhSs
 AcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476797; x=1769081597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s4ZP0M6LSe18tj6821SMJeDGGJkxkekrXzs8Be7PL+A=;
 b=mmAjmoenoARlomedMXAw2+HOi4unptwR0MvJZqMYIclT5dXeplJA1ClvyktFOO34+2
 Hbkj+8/5CNaEaZBt+zu9/pxjOoXgStfMKJuHFGn+CPm/nek6MuqQ0tE3BrdVX3vNj17J
 a8BmkPTWR8FhWKx2N4XtNbHiLhtyUu9AC0dWfjcHncT79pqjMgFXX7uV12se0ndi9ziF
 WxQVR9c9efnXgEIsQ7zH2WRyBBBjJrp2iJqcflc8EesQuOrYlvYKh4ynVsHKjRY46H5l
 bPme6xy8lLmdMf60uwT/Aec1JsDs0VdZyi3hQkqa4GYs3dtUw0eKou/Mhyj764M4qbNF
 tmHw==
X-Gm-Message-State: AOJu0YwoAzgMLaQnOKT49lWirQA4x/XEXjNv3Ib+whm67gSyLndZbPtI
 QTdvfDS0jRourJF0fYfneKLuFqZW+CPF5kWTZAxyc0WsWN+FdDKJOl5cK0ClRLLGqCQTCaSwMi7
 TAMYV3gXXeQa/8OSdMDqgZIcZqx4zNAG7m6dRVzif3bzN0IVnjg0J40OP+MAMWb3lgot7s3Mr8o
 tVC8BQbqicha7CuK56nTitJVrEayaLNyqQTlelhuhA
X-Gm-Gg: AY/fxX6igUmMrLJ/w54S/oDFSyLjjgroVzCEduBwRoEXPeLFPlnqg5Ct9E1/NBvF3QV
 dysNDh+vfkkfNFjQmHOTpYzX2pL2wr3lMAeJYSCAsbeKLYTlJ88tIoHsZQymHECDofwaT4tYtpc
 nY38xWq3Qjf76ao553pwpZpdH1aP7Y6WsJXy5l3Vozb+LGWdO/IcT8OfRw/+FqMS4/kniFsKtsJ
 D71wjJ/KcCjJTwhuMz6KxbIAJLYMEVrYPhYNEqoT/OQ18NTdreRZBMba7k96AqfbYiVmivZDLjV
 Py14xi00EEj6fRmuVbKhyM0Cs401lXS6g0wH5A/W1SmakSTuzx5BU3J53lb3PJbxMEo1facMggY
 CuIVhMtRqtynQRj8pHp04dhbjINUyBMglAOg685zjd0ZMGwQrKf8jhgL4KBbGDWT451RQ4JPFlu
 xdahtWBMJ6aptXig==
X-Received: by 2002:a5d:64c5:0:b0:431:2ff:128f with SMTP id
 ffacd0b85a97d-434ce63e092mr3481059f8f.6.1768476796998; 
 Thu, 15 Jan 2026 03:33:16 -0800 (PST)
X-Received: by 2002:a5d:64c5:0:b0:431:2ff:128f with SMTP id
 ffacd0b85a97d-434ce63e092mr3481017f8f.6.1768476796532; 
 Thu, 15 Jan 2026 03:33:16 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a666sm5332763f8f.6.2026.01.15.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 4/6] target/i386/tcg: merge decode_modrm and
 decode_modrm_address split
Date: Thu, 15 Jan 2026 12:33:04 +0100
Message-ID: <20260115113306.126905-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115113306.126905-1-pbonzini@redhat.com>
References: <20260115113306.126905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Unlike the older code in translate.c, mod=11b *is* filtered out earlier
by decode_modrm, and it would have returned bogus code.  Since the register
case is so simple, just inline decode_modrm_address into its caller instead
of removing the "if".

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 64 ++++++++++++--------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b00ea3e86e8..662d1d707d0 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2007,33 +2007,34 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = opcodes_root[*b];
 }
 
-/* Decompose an address.  */
-static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
-                                         int modrm, bool is_vsib)
+/* Decode the MODRM and SIB bytes into a register or memory operand.  */
+static void decode_modrm(DisasContext *s, CPUX86State *env,
+                         X86DecodedInsn *decode, X86DecodedOp *op)
 {
-    int def_seg, base, index, scale, mod, rm;
-    target_long disp;
-    bool havesib;
-
-    def_seg = R_DS;
-    index = -1;
-    scale = 0;
-    disp = 0;
-
-    mod = (modrm >> 6) & 3;
-    rm = modrm & 7;
-    base = rm | REX_B(s);
+    int modrm = get_modrm(s, env);
+    int mod = (modrm >> 6) & 3;
+    int rm = modrm & 7;
+    bool is_vsib = decode->e.vex_class == 12;
+    bool havesib = false;
 
     if (mod == 3) {
-        /* Normally filtered out earlier, but including this path
-           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
-        goto done;
+        op->n = rm;
+        if (op->unit != X86_OP_MMX) {
+            op->n |= REX_B(s);
+        }
+        return;
     }
 
+    /* Decompose an address.  */
+    int def_seg = R_DS;
+    int base = rm | REX_B(s);
+    int index = -1;
+    int scale = 0;
+    target_ulong disp = 0;
+
     switch (s->aflag) {
     case MO_64:
     case MO_32:
-        havesib = 0;
         if (rm == 4) {
             int code = x86_ldub_code(env, s);
             scale = (code >> 6) & 3;
@@ -2042,7 +2043,7 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
                 index = -1;  /* no index */
             }
             base = (code & 7) | REX_B(s);
-            havesib = 1;
+            havesib = true;
         }
 
         switch (mod) {
@@ -2127,26 +2128,9 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
         g_assert_not_reached();
     }
 
- done:
-    return (AddressParts){ def_seg, base, index, scale, disp };
-}
-
-static int decode_modrm(DisasContext *s, CPUX86State *env,
-                        X86DecodedInsn *decode, X86DecodedOp *op)
-{
-    int modrm = get_modrm(s, env);
-    if ((modrm >> 6) == 3) {
-        op->n = (modrm & 7);
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_B(s);
-        }
-    } else {
-        op->has_ea = true;
-        op->n = -1;
-        decode->mem = decode_modrm_address(env, s, get_modrm(s, env),
-                                           decode->e.vex_class == 12);
-    }
-    return modrm;
+    op->has_ea = true;
+    op->n = -1;
+    decode->mem = (AddressParts){ def_seg, base, index, scale, disp };
 }
 
 static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp *ot)
-- 
2.52.0


