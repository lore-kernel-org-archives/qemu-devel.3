Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28B8C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB2C-0005pk-57; Mon, 28 Sep 2026 09:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0o-0005Jo-5F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0m-0004Nc-G8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvqi6imudO/cDeNotTPuYwAVUIDuXEBNJO2xyIztaJk=;
 b=H6GCStj1Tb6FXjKrt6160LWOEzTntltAmsLSuAFR9XYVBlOSOgWLE5W0OGb63xDmb6RnNJ
 zZ37rpgNTyc3CI44GSlVjJu97Zjx/OchHA5CYZQCzGOlATcvA6pfqOJt1VTsE6ZjWjwD0b
 JE3GW+WJsbrtnmpN+CkbxJmotgldpN0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-PzNJrtPAMrySVRiJ1VGTcg-1; Mon, 28 Sep 2026 09:03:13 -0400
X-MC-Unique: PzNJrtPAMrySVRiJ1VGTcg-1
X-Mimecast-MFC-AGG-ID: PzNJrtPAMrySVRiJ1VGTcg_1790600593
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c2939083cefso325627666b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600592; x=1791205392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uvqi6imudO/cDeNotTPuYwAVUIDuXEBNJO2xyIztaJk=;
 b=NEn2gMbnlHQy9RPJyGMbWIebNuXXnY+rncsXCB+xCfIjyS4ONN9W0YilofuhcPVTPS
 stFJbVkHyoAD+bOBBfH1I3q4SGCh0xwNH10zmlZxOJ0BmAgBC7erhlNIG0drMYjCNTb+
 IwxAY9fuBHrzk2jDTec0BoP533SZymmN+Nd7tz4iMhdSlzChZGfgPY/vOIkBubb9znRR
 IHEJSipxr051qpNXoQR2HahuumiDiYe3tenDtI4VLB5cw1R9krUlUMWa1SGnciRI1xN1
 4xKHl5Ex11dlh9SxcfkZ9C4jPXiRNT7/i0idEnnhicjMwwdULWVbFyd6G4KhQMzvTlay
 fuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600592; x=1791205392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uvqi6imudO/cDeNotTPuYwAVUIDuXEBNJO2xyIztaJk=;
 b=HGKb5KnnBXH7wfpuP5ho/3pxY9agRFxBMEtUNsM8k4hWGB8ygDPQG99Uca5+q21eNN
 kluHrVgVIOPb8N1gHSmPxjeLZ+UXSpk7233o6x5w0kGpUJM89Q1fj7DJJ6V4RIiEa5/j
 P7F/GOxCd4NtwoTEteC6a9Uelk7FUrgOBxHMh4h+Jx7CAL9TKPlRjrpyZdwC5/6CzRHZ
 Pcsl7QfOf7E4VEx0KLbcmWyP3FG4fFmmv1h6SWuFLXvZMbASc/F9t98PRadg911FZYFq
 j5yRwgnN7PKvhI2DKwsJ+YzScsPecSY2kLMPJCquJJ0d3mRsriYB5237L4SC9WCgzTVB
 5fWA==
X-Gm-Message-State: AFuF++lXugYZuv9rdeZXbjL89BY7U7LjKTR38asRXfmGoFgO7rMer4/5
 T2DxSgpt5F0/7jmCFEHjgOD2Plru7xfBY93ehFX+9yBWN/K3cGG1PvutHqkC9XkSvUKaU4cfqpD
 prNvhGAL+/572q5alaifFYLqlLXeMm2zTiWnoIJSy/DWebMhVvPfYrHCnJdKidKEk4nsalgqVSq
 kuTonNgTZrFt46eL3WulSVZbkvUZgIioWv/Tj7EzvA
X-Gm-Gg: AYBFou0LJ91njomj7JRFGeS484NqdZmTq0uQicAp3AMu/hxkQbF3YuQUQ31eWEfBrG2
 t1klzemGdM5kN+T/5fpAGqDi4O6eXp99h65OtVlCIukjSjgjkEZxaY1GdsQZ1joQJy1ajuWnrlQ
 ksaovFIBxQ/lLz1H8vMyyEz6icz4MfmTHnKw5/VBAxaxJsVT7CgsYNZZehmBPnd/k1l2qgVIK3T
 Wj56+We64hncH/YOO4YVzt585mlO8Kew6+J/maILIBZVI0MiW5o0qXX04089Ix5pztmQtqLEz4T
 L5bsV/3sbF2K+6h/c+gdcqCwWp/sGIhNFY2wQGOkJLPo6G58XDizKg9i8O3vZZWneP/xEt0eTVu
 CkxAT9dpzxR5MZtwWWvMdzOCEIlH9InYUKrmAdomh+14fpKNw1FydjVaowrB1w5mL9cKHjNw9+V
 7Qt8Uk
X-Received: by 2002:a17:907:d08f:b0:c26:36c4:858e with SMTP id
 a640c23a62f3a-c2ac249d86dmr1082095866b.25.1790600592417; 
 Mon, 28 Sep 2026 06:03:12 -0700 (PDT)
X-Received: by 2002:a17:907:d08f:b0:c26:36c4:858e with SMTP id
 a640c23a62f3a-c2ac249d86dmr1082092666b.25.1790600591893; 
 Mon, 28 Sep 2026 06:03:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dbd110c3esm276990166b.63.2026.09.28.06.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/30] target/i386/tcg: use standard operand order for BSF and
 BSR
Date: Mon, 28 Sep 2026 15:02:11 +0200
Message-ID: <20260928130228.877003-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 18 ++++++++----------
 target/i386/tcg/emit.c.inc       | 12 +++++-------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 07a627af5cf..3acac68977d 100644
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


