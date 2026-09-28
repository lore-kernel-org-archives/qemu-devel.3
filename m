Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D617CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB37-0007G6-S5; Mon, 28 Sep 2026 09:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1V-0005mr-Jh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1R-0004S4-3W
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWBVwdTR29SM4fQxCIJ6b+39nFZ+yQ4Vl5cCwN5HJgY=;
 b=b6nPEGkGPYVsOgF82B2rIuneeDVecJbHaOPIR2rOUSMo7FIq2g0/pcL84H+bzqSzROpppH
 fQePOyc8IFG1Q93yr1QE/TM3Cg1oikN3XlbjG8P6AQ2wfml6ge5WPNtt00WBiMrWVQY9y+
 NOXnafJghq5TrtbGa1poqCxcUUlcmBs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-yZmDW7K8P3u_5VMowGUXnA-1; Mon, 28 Sep 2026 09:03:54 -0400
X-MC-Unique: yZmDW7K8P3u_5VMowGUXnA-1
X-Mimecast-MFC-AGG-ID: yZmDW7K8P3u_5VMowGUXnA_1790600633
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so25702015e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600633; x=1791205433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BWBVwdTR29SM4fQxCIJ6b+39nFZ+yQ4Vl5cCwN5HJgY=;
 b=X9JVSxubZyc99+xP2v4ZbSwq6qViuHhqjei+zatBao7L5Q7V1LdBZts3EW/R6TU30C
 1NmKw7x+8kb4LgiH30G4pgq3H4WY1X+lYXd4hS9VGQ3rW6LOLRfDvoWrviYjmwNT16xP
 KzNAyrgwjfse0YCOgvZFdR4W9kvHGTkHgPvP5TRakXLNr0NqpMkVQgzC6mwEbSTbOSmr
 hSInFxqn+rA0C9Uey63TxhjI2KHtQyCR9FeYR8qqWplWp/wyjkI/ot6sDMm8BV3S5MI7
 BYIS9Z1xbwd9xh3jtxsqiZUrqPXeGrdKbh5M/52T0rkmxn+R6C8pFlTURChPh1aZ2nog
 2sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600633; x=1791205433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BWBVwdTR29SM4fQxCIJ6b+39nFZ+yQ4Vl5cCwN5HJgY=;
 b=sjIoaYdQw08rLEEwV1+qoLvtYRZTpQSyF2LSjcWOY5OLYApLXmUdoYLWMo570BBmwI
 KBDndJ5cw/IIERLGAk2pgm/XZkI23RCqZV2CnPzib+3FS42bSMc/ozIbid8rD78L3Scg
 zWM4DdkdSszE5/+pA717nC0pmqyBWU5GZDaJVs6OxkEjB/tOdsEY9ihcANhqknZ62hAv
 3SyXdevaKWpIDh+ppDjDqpm/ErH+AaPcn66GpmQRw6Gq80c6Xb/9WuprN+sORss/6LSF
 vDYnkW7Dqd+f79ENeAk4HH/3oj5coztsm0yZGw0Fmeq3iEaljJ73qYRCid7RD1P3HNvR
 YOaQ==
X-Gm-Message-State: AFuF++ma1Qz05jyarj9sCe8BOLNnrZbx/30A2IKMZtRJTmOx6vVabmP8
 GNuhQcK0CE7kZEv3XuL6s628n3vs44WmmjBGsKULK78wnWtYF9w4op36FbZFRxLSwD+rqnyh2Kx
 D169Pi4/R/IyN3jJiwVRniehKN/mWjhVY6KquiEOfGj18jPXc4d/X6ZLdZCQR4oS+VqfNJMYYfE
 RI5BEEx6ecx2Na8n8Gt/lCgM19VXvuWzHMb7/+KX+e
X-Gm-Gg: AYBFou2v8fDr+4RkY2UmNsWLZitFerKghQpZm+2Txg19OIz6YsAlbGOg1EXl7KbX3M6
 vj3NllT7q/7kAjpYWzeM7j5bfoUnv7sl9jE3x4nI+KCM7UnzCPipez8djbJuH2zoJiSN3Rhtblt
 0GLWlh9gPnQZpUlWQ+LSx5OZHT0c8VMWUQ+rkkgRikMas3DUyJ280YD1uzlm3A/iyiABLR7kuIf
 LJ5zOCdKSGm9JKWH6tPmGfLGBrhvfr2pzMGKyHchC0ce0b4kaMKXRdE5kRpHrtogj+AaUH75NGU
 KEaneLisr9mAp3QSTO10sUhZMFVmvzk4dfsJMg3Q445V4W3UFRftkvsfAvKJtkkWlXmMcNZsNhp
 bxLLRTGEyZM2e8325qCBaCaKbeF0uXXqGNndVGZ7JbpG5J6CzOX0E4NZUMJWfIx8kGdCiEAGorW
 mc2mXC
X-Received: by 2002:a05:600c:4e53:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-49fe66c8921mr218092075e9.5.1790600633260; 
 Mon, 28 Sep 2026 06:03:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4e53:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-49fe66c8921mr218091555e9.5.1790600632753; 
 Mon, 28 Sep 2026 06:03:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm25623766f8f.5.2026.09.28.06.03.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] target/i386/tcg: optimize CCMP
Date: Mon, 28 Sep 2026 15:02:25 +0200
Message-ID: <20260928130228.877003-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If possible, modify conditionally the input arguments to generate the
flags requested by dfv; this way CCMP can use CC_OP_SUB* instead of having
to compute the carry-out vector by hand.  This happens relatively often
for dfv=0, and also for dfv=sf for code produced by clang.

Of the combinations that cannot be optimized, both GCC and clang generate
dfv=zf.  GCC also generates OS and OSZ.

Do not bother doing this for CTEST; the savings are modest because it
does not need complex code to compute the carry-out vector (CC_SRC
is always 0).  In addition, trivially replacing the arguments to the AND
would only support dfv=0 (produced by -2 & 2) or dfv=S (produced by -2 &
-2), because TEST cannot produce any value where CF or OF are not zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 62 +++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c353d97ee74..531398d356b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1738,6 +1738,55 @@ static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, u
                        decode->cc_dst, tcg_constant_tl(dst));
 }
 
+static bool gen_ccmp_movcond(DisasContext *s, int cond, uint32_t dfv, MemOp ot)
+{
+    target_ulong op0, op1, max_int;
+
+    assert(cond != CCMP_F);
+    if (cond == CCMP_T) {
+        return true;
+    }
+
+    /*
+     * For some values of dfv, it's possible to overwrite operands
+     * instead of using CC_OP_CCMP.  The weird "16"s are to set AF==0.
+     */
+    max_int = MAKE_64BIT_MASK(0, (8 << ot) - 1);
+    switch(dfv) {
+    case 0:
+        op0 = 1, op1 = 0;
+        break;
+    case CC_P|CC_C:
+        op0 = 1, op1 = -16;
+        break;
+    case CC_S:
+        op0 = -3, op1 = 0;
+        break;
+    case CC_S|CC_P|CC_C:
+        op0 = 0, op1 = 16;
+        break;
+    case CC_O:
+        /*
+         * While for >8-bit results -max_int has 1 in the lower byte, for 8-bit
+         * results -max_int is 0x81, so it flips the parity flag.  Compensate
+         * in op1.
+         */
+        op0 = -max_int, op1 = 16 + (ot == MO_8);
+        break;
+    case CC_O|CC_S|CC_P|CC_C:
+        /* Same here. */
+        op0 = max_int, op1 = -1 - (ot == MO_8);
+        break;
+    default:
+        return false;
+    }
+
+    CCPrepare cc = gen_prepare_cc(s, cond, NULL);
+    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2, s->T0, tcg_constant_tl(op0));
+    tcg_gen_movcond_tl(cc.cond, s->T1, cc.reg, cc.reg2, s->T1, tcg_constant_tl(op1));
+    return true;
+}
+
 static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
 {
@@ -1746,16 +1795,15 @@ static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[1].ot;
     TCGv cout;
 
-    switch (cond) {
-    case CCMP_T:
-        gen_SUB(s, decode);
-        return;
-    case CCMP_F:
+    if (cond == CCMP_F) {
         decode->cc_op = CC_OP_EFLAGS;
         decode->cc_src = tcg_constant_tl(dfv);
         return;
-    default:
-        break;
+    }
+    if (gen_ccmp_movcond(s, cond, dfv, ot)) {
+        /* Including CCMP_T, aka "normal" CMP.  */
+        gen_SUB(s, decode);
+        return;
     }
 
     decode->cc_op = CC_OP_CCMPB + ot;
-- 
2.55.0


