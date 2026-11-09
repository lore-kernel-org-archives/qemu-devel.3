Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705B606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UL8PJjTR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQTxL-00047C-0Q; Mon, 09 Nov 2026 13:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xQTxE-00046y-Mm
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xQTxC-00029t-K6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794248324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=94HKhgd63UC2recRlNVLfdia338WUYdrqACerrLQ8tM=;
 b=UL8PJjTRCs6nCRDr0MV5l+42L+pYQ+SbRnkd3YPM7EqOFA1Nzs5OXKfvWPyj/QbgTghBC9
 a7mvUYxnJ5q1xD3viSAlLoppiODCvvUvVKShnC2fQJb84CHVG/hXr+H5pTGr5uWPd6IkNo
 tFbT6YvkSO9hVqofBmMTaEIC72Q07Kw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-Z3xLLfChN3C1JYN7qWJMsQ-1; Mon,
 09 Nov 2026 13:18:43 -0500
X-MC-Unique: Z3xLLfChN3C1JYN7qWJMsQ-1
X-Mimecast-MFC-AGG-ID: Z3xLLfChN3C1JYN7qWJMsQ_1794248322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 123751800107; Mon,  9 Nov 2026 18:18:42 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29770195608B; Mon,  9 Nov 2026 18:18:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PATCH] target/i386/tcg: all scalar instructions should be LIG
Date: Mon,  9 Nov 2026 19:18:39 +0100
Message-ID: <20261109181839.1042836-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the vex_lig modifier to other scalar instructions, both
defined via REPScalar and those listed as separate rows.
The current edition of the manual lists them this way, but
QEMU was either ignoring VEX.L but not resetting it, or
raising #UD on VEX.L=1.

Cc: Andrey Polivoda <apolivodaa433@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 48 +++++++++++++++-----------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index e985b128893..b91e3718cb5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -834,31 +834,31 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
 
     /* Should be exception type 2 or 3 but they do not have legacy SSE equivalents? */
     [0x98] = X86_OP_ENTRY3(VFMADD132Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x99] = X86_OP_ENTRY3(VFMADD132Sx,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0x99] = X86_OP_ENTRY3(VFMADD132Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0x9a] = X86_OP_ENTRY3(VFMSUB132Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x9b] = X86_OP_ENTRY3(VFMSUB132Sx,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0x9b] = X86_OP_ENTRY3(VFMSUB132Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0x9c] = X86_OP_ENTRY3(VFNMADD132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x9d] = X86_OP_ENTRY3(VFNMADD132Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0x9d] = X86_OP_ENTRY3(VFNMADD132Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0x9e] = X86_OP_ENTRY3(VFNMSUB132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0x9f] = X86_OP_ENTRY3(VFNMSUB132Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0x9f] = X86_OP_ENTRY3(VFNMSUB132Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
 
     [0xa8] = X86_OP_ENTRY3(VFMADD213Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xa9] = X86_OP_ENTRY3(VFMADD213Sx,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xa9] = X86_OP_ENTRY3(VFMADD213Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0xaa] = X86_OP_ENTRY3(VFMSUB213Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xab] = X86_OP_ENTRY3(VFMSUB213Sx,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xab] = X86_OP_ENTRY3(VFMSUB213Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0xac] = X86_OP_ENTRY3(VFNMADD213Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xad] = X86_OP_ENTRY3(VFNMADD213Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xad] = X86_OP_ENTRY3(VFNMADD213Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0xae] = X86_OP_ENTRY3(VFNMSUB213Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xaf] = X86_OP_ENTRY3(VFNMSUB213Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xaf] = X86_OP_ENTRY3(VFNMSUB213Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
 
     [0xb8] = X86_OP_ENTRY3(VFMADD231Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xb9] = X86_OP_ENTRY3(VFMADD231Sx,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xb9] = X86_OP_ENTRY3(VFMADD231Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0xba] = X86_OP_ENTRY3(VFMSUB231Px,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xbb] = X86_OP_ENTRY3(VFMSUB231Sx,  V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xbb] = X86_OP_ENTRY3(VFMSUB231Sx,  V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0xbc] = X86_OP_ENTRY3(VFNMADD231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xbd] = X86_OP_ENTRY3(VFNMADD231Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xbd] = X86_OP_ENTRY3(VFNMADD231Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
     [0xbe] = X86_OP_ENTRY3(VFNMSUB231Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
-    [0xbf] = X86_OP_ENTRY3(VFNMSUB231Sx, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
+    [0xbf] = X86_OP_ENTRY3(VFNMSUB231Sx, V,x,  H,x, W,x,  vex6 vex_lig cpuid(FMA) p_66),
 
     [0xc8] = X86_OP_ENTRY2(SHA1NEXTE,   V,dq, W,dq, cpuid(SHA_NI)),
     [0xc9] = X86_OP_ENTRY2(SHA1MSG1,    V,dq, W,dq, cpuid(SHA_NI)),
@@ -1064,7 +1064,7 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F10_reg[4] = {
         X86_OP_ENTRY3(MOVDQ,   V,x,  None,None, W,x, vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,   V,x,  None,None, W,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS,  V,x,  H,x,       W,x, vex5),
+        X86_OP_ENTRY3(VMOVSS,  V,x,  H,x,       W,x, vex5 vex_lig),
         X86_OP_ENTRY3(VMOVLPx, V,x,  H,x,       W,x, vex5), /* MOVSD */
     };
 
@@ -1087,7 +1087,7 @@ static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F11_reg[4] = {
         X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4_unal), /* MOVUPS */
         X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4_unal), /* MOVUPD */
-        X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex5),
+        X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex5 vex_lig),
         X86_OP_ENTRY3(VMOVLPx, W,x,  H,x,       V,q, vex5), /* MOVSD */
     };
 
@@ -1166,8 +1166,8 @@ static void decode_0F2A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     static const X86OpEntry opcodes_0F2A[4] = {
         X86_OP_ENTRY3(CVTPI2Px,  V,x,  None,None, Q,q),
         X86_OP_ENTRY3(CVTPI2Px,  V,x,  None,None, Q,q),
-        X86_OP_ENTRY3(VCVTSI2Sx, V,x,  H,x, E,y,        vex3),
-        X86_OP_ENTRY3(VCVTSI2Sx, V,x,  H,x, E,y,        vex3),
+        X86_OP_ENTRY3(VCVTSI2Sx, V,x,  H,x, E,y,        vex3 vex_lig),
+        X86_OP_ENTRY3(VCVTSI2Sx, V,x,  H,x, E,y,        vex3 vex_lig),
     };
     *entry = *decode_by_prefix(s, opcodes_0F2A);
 }
@@ -1191,8 +1191,8 @@ static void decode_0F2C(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
         /* Listed as ps/pd in the manual, but CVTTPS2PI only reads 64-bit.  */
         X86_OP_ENTRY3(CVTTPx2PI,  P,q,  None,None, W,q),
         X86_OP_ENTRY3(CVTTPx2PI,  P,q,  None,None, W,dq),
-        X86_OP_ENTRY3(VCVTTSx2SI, G,y,  None,None, W,ss, vex3),
-        X86_OP_ENTRY3(VCVTTSx2SI, G,y,  None,None, W,sd, vex3),
+        X86_OP_ENTRY3(VCVTTSx2SI, G,y,  None,None, W,ss, vex3 vex_lig),
+        X86_OP_ENTRY3(VCVTTSx2SI, G,y,  None,None, W,sd, vex3 vex_lig),
     };
     *entry = *decode_by_prefix(s, opcodes_0F2C);
 }
@@ -1203,8 +1203,8 @@ static void decode_0F2D(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
         /* Listed as ps/pd in the manual, but CVTPS2PI only reads 64-bit.  */
         X86_OP_ENTRY3(CVTPx2PI,  P,q,  None,None, W,q),
         X86_OP_ENTRY3(CVTPx2PI,  P,q,  None,None, W,dq),
-        X86_OP_ENTRY3(VCVTSx2SI, G,y,  None,None, W,ss, vex3),
-        X86_OP_ENTRY3(VCVTSx2SI, G,y,  None,None, W,sd, vex3),
+        X86_OP_ENTRY3(VCVTSx2SI, G,y,  None,None, W,ss, vex3 vex_lig),
+        X86_OP_ENTRY3(VCVTSx2SI, G,y,  None,None, W,sd, vex3 vex_lig),
     };
     *entry = *decode_by_prefix(s, opcodes_0F2D);
 }
@@ -1452,8 +1452,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x2B] = X86_OP_GROUP0(0F2B),
     [0x2C] = X86_OP_GROUP0(0F2C),
     [0x2D] = X86_OP_GROUP0(0F2D),
-    [0x2E] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 p_00_66), /* VUCOMISS/SD */
-    [0x2F] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 p_00_66), /* VCOMISS/SD */
+    [0x2E] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 vex_lig p_00_66), /* VUCOMISS/SD */
+    [0x2F] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 vex_lig p_00_66), /* VCOMISS/SD */
 
     [0x38] = X86_OP_GROUP0(0F38),
     [0x3a] = X86_OP_GROUP0(0F3A),
@@ -3103,9 +3103,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         assert(e->vex_class == 1 || e->vex_class == 2 || e->vex_class == 4);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             e->vex_class = e->vex_class < 4 ? 3 : 5;
-            if (s->vex_l) {
-                goto illegal;
-            }
+            s->vex_l = 0;
             assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
             if ((s->modrm >> 6) != 3) {
                 e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;
-- 
2.56.0


