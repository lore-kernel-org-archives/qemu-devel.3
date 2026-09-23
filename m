Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E9BC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpd-0007lL-Bk; Wed, 23 Sep 2026 13:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnq-0006m3-Ms
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnf-0003h3-Ms
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7fTalcP4TrfpRkckJpydRMKC2cEbSRO/6w7tVKQpGU=;
 b=UyAsGG3o3C22D9VEYCJilcLrvMDB0Y32+XyI/INaFOXpv/Rq73+C7YuU4gRptccxe3Y2vv
 UrwqPSRqD+3fhUhG6IrQ0+M8x4QmvcjKm9nU5B1Mw789wUHJW9JVKU8CRR6iPGH3fKC1r0
 oRQIChWYIySxFi9/qsQhQcXaEHbAZKk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-huJkAiyQNbiNIbAXliJFJw-1; Wed, 23 Sep 2026 13:30:29 -0400
X-MC-Unique: huJkAiyQNbiNIbAXliJFJw-1
X-Mimecast-MFC-AGG-ID: huJkAiyQNbiNIbAXliJFJw_1790184628
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-487057d8a3eso101468f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184628; x=1790789428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B7fTalcP4TrfpRkckJpydRMKC2cEbSRO/6w7tVKQpGU=;
 b=LPwxNeuEihuS/kVwb6EK/2U451uwArX0B7Q1tESD7Y41sHoaxdCQftBWFnbgr3M50W
 oEZfcHQC4aGDvdM6vQyqXMdl8kkN4+kiD5w0x2SwZvJiNbvIm9pkA17aTfasoLQQwQCX
 WjZS9LoWnhqjEjIrLvl8uLviP0lTKQqvDyGMTXv0Kt3u/qcSLWXsOlX9Vird8xqCOT+e
 M+dYNez07fhEkvHpkmbx0M/NS9ObGYl/3O2n7W9qAJfCqbxBTs7vFr26966U/eemLKe3
 grPv/WJbNyZHKIJ1xlxAUPbYDy+Fxn8hjyNe65qxsn69N0qOFJXuh8CR+yVn4sGMhkLj
 f5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184628; x=1790789428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B7fTalcP4TrfpRkckJpydRMKC2cEbSRO/6w7tVKQpGU=;
 b=aVx9FSFBzE2VlJSbWr4HVgPK0zUXWVPSjB8QPq7yzIlxydcpsGo46+IRovWZjfLGkD
 7Zgc1Vy/6EMJu1Ds0xvY+S2vkChYtDa8MiTlnfPL2Mu0Bz178yPmJL8+GIooq7u9DMYr
 JqQTspw7DucK3niO5pdyI9KnGWgYLm98vtmRvvcLsMn6tNEvgDf+rzOCXknwBM+1274T
 YU5bUcI5bjDH+nda6KEbjVYNSriFb148tdQm2ip96klBs5JOBC3Ddtm6rVgMwOjARVbB
 59BZNYpzyuvtz9NlWUy9NJpTCRojR4KsIk19kLpiSuSAOdh4SRq1HXS606JEeWRSqUBK
 Tm/Q==
X-Gm-Message-State: AFuF++mUfIjCLG8VwHSyeUHPhMOa/5qJbmCUZ0SowBGqlHBU7xuB7cpB
 KSNWqHE6yAD+UVZ0CJ3xIfQ5XWuqnfyjpF7yY+stMv66x80jlTO59gsqgTSYQ/inGENJdi929+K
 0VzOJCRHaO5ApDC5zqirfjCWjNLebl2xzzbQpjFLH2v/orHy3oCf1t2439h8Nf1VlqM1S7Y/krn
 leYuqJgU+xMc/Di5U8JkoAL1IeHtRrld2SdpCOeYIx
X-Gm-Gg: AYBFou3Z2Nwi2x/iuspRJuXo+KBuIgpBrQnQ6ycOpCmrtQuzdEeaqvFY9zZ04GbPkpI
 7QXuHEnc8KUsdtBk/E6jq2gisTbJlRWSgLbFKmqQX7aHkHJGuGM/LuudpiS477sKHwRbUJ+lGvg
 DPBrMURxVb+KroRogFsBb6Py9wARTL50pV3e+Hg7GG48S3HNm75a8gILgu44S/Gz8WL68ONYWcE
 rBWz9XVn74OtvfetsTspgfSMvXl5fsBH+p/RkFlo4LTfHqfJus9cgyxiiD5smCvT1QBJqyek23m
 X3fdrg27ewwT/IhH3qhwcIn45HgDySGvah/2g4zMMQ5WIikkkaVNgMJLXMWegdSLv9+rSJwldsi
 hJ0loINhmQYLnLws3yi2f5vDvYv8NS9RE/uaWuzmUUS9aW9ZYt8+2i3dI2Y17S1oXaQ1waZI/gg
 pGQrTPB8cKDKbxq9M=
X-Received: by 2002:a05:6000:4023:b0:487:10b5:a88a with SMTP id
 ffacd0b85a97d-4886705fb90mr6170099f8f.9.1790184628494; 
 Wed, 23 Sep 2026 10:30:28 -0700 (PDT)
X-Received: by 2002:a05:6000:4023:b0:487:10b5:a88a with SMTP id
 ffacd0b85a97d-4886705fb90mr6170049f8f.9.1790184628082; 
 Wed, 23 Sep 2026 10:30:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889130sm8136855f8f.37.2026.09.23.10.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 02/17] target/i386/tcg: use standard operand order for BSF and
 BSR
Date: Wed, 23 Sep 2026 19:30:06 +0200
Message-ID: <20260923173021.317809-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

BSF and BSR currently pass their source as operand 0 and the old
destination as operand 2.  This nonstandard order was needed so that the
source could use zextT0.

Per-operand extensions now let operand 2 use zextT1, so that BSF and BSR
can use the normal X86_OP_ENTRY2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 18 ++++++++----------
 target/i386/tcg/emit.c.inc       | 12 +++++-------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index e8b21c77743..0e6175b8dbc 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -674,12 +674,11 @@ static void decode_0FB8(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* For BSF, pass 2op as the third operand so that we can use zextT0 */
     static const X86OpEntry opcodes_0FBC[4] = {
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0),
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
-        X86_OP_ENTRYwr(TZCNT, G,v, E,v,        zextT0), /* 0xf3 */
-        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1),
+        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0x66 */
+        X86_OP_ENTRYwr(TZCNT, G,v, E,v, zextT0), /* 0xf3 */
+        X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0xf2 */
     };
     if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
         *entry = opcodes_0FBC[0];
@@ -690,12 +689,11 @@ static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* For BSR, pass 2op as the third operand so that we can use zextT0 */
     static const X86OpEntry opcodes_0FBD[4] = {
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0),
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
-        X86_OP_ENTRYwr(LZCNT, G,v, E,v,        zextT0), /* 0xf3 */
-        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
+        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1),
+        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0x66 */
+        X86_OP_ENTRYwr(LZCNT, G,v, E,v, zextT0), /* 0xf3 */
+        X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0xf2 */
     };
     if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
         *entry = opcodes_0FBD[0];
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 54dc23ca624..abf40123035 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1396,7 +1396,6 @@ static void gen_BOUND(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
-/* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
 static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1404,7 +1403,7 @@ static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
     /* Only the Z bit is defined and it is related to the input.  */
     decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_LOGICB + ot;
-    tcg_gen_mov_tl(decode->cc_dst, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T1);
 
     /*
      * The manual says that the output is undefined when the
@@ -1412,10 +1411,9 @@ static void gen_BSF(DisasContext *s, X86DecodedInsn *decode)
      * real programs appear to depend on that.  Accomplish this
      * by passing the output as the value to return upon zero.
      */
-    tcg_gen_ctz_tl(s->T0, s->T0, s->T1);
+    tcg_gen_ctz_tl(s->T0, s->T1, s->T0);
 }
 
-/* Non-standard convention - on entry T0 is zero-extended input, T1 is the output.  */
 static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1423,7 +1421,7 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
     /* Only the Z bit is defined and it is related to the input.  */
     decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_LOGICB + ot;
-    tcg_gen_mov_tl(decode->cc_dst, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T1);
 
     /*
      * The manual says that the output is undefined when the
@@ -1432,8 +1430,8 @@ static void gen_BSR(DisasContext *s, X86DecodedInsn *decode)
      * by passing the output as the value to return upon zero.
      * Plus, return the bit index of the first 1 bit.
      */
-    tcg_gen_xori_tl(s->T1, s->T1, TARGET_LONG_BITS - 1);
-    tcg_gen_clz_tl(s->T0, s->T0, s->T1);
+    tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
+    tcg_gen_clz_tl(s->T0, s->T1, s->T0);
     tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
 }
 
-- 
2.55.0


