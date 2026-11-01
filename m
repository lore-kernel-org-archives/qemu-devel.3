Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE415606A33A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cljZxV7P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLD-0006kX-ED; Sun, 01 Nov 2026 04:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSLB-0006j1-22
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL9-0007tu-IQ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDGIVjlcjalBdZgH4OhsxYmbKmXTHW0DzsQJ/j869F4=;
 b=cljZxV7PnG+r808q7gRORKtIWkZwXyWe3jg73S9ZxFE1ZTggc/qBj8z443G0/6ixFvnYfX
 rvsVogzvJpuqJyG+PB9fwPR2jpH9OBwh4nacCyD65d+Hit00yMLGTmhRX9V66RqOFhUwiF
 +1pk/rE2r2+8CM4T6kX0XsBYXPqT+bE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-6QJQWiLHOPiPzSQpEmrleQ-1; Sun,
 01 Nov 2026 04:59:00 -0500
X-MC-Unique: 6QJQWiLHOPiPzSQpEmrleQ-1
X-Mimecast-MFC-AGG-ID: 6QJQWiLHOPiPzSQpEmrleQ_1793527139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F2981801339; Sun,  1 Nov 2026 09:58:59 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AE441800446; Sun,  1 Nov 2026 09:58:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 04/10] target/i386/tcg: reject VEX.NP for MMX instructions
Date: Sun,  1 Nov 2026 10:58:45 +0100
Message-ID: <20261101095851.1557351-5-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MMX instructions do not have a VEX encoding, so reject VEX instructions
with no prefix for instructions that use X86_SPECIAL_MMX.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2756953c744..65fd402c17f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2425,6 +2425,12 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     decode->mem = (AddressParts){ def_seg, base, index, scale, disp };
 }
 
+static bool is_mmx(const DisasContext *s, const X86OpEntry *e)
+{
+    return (e->special == X86_SPECIAL_MMX &&
+            !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA)));
+}
+
 static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp *ot)
 {
     switch (size) {
@@ -2470,8 +2476,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         return true;
 
     case X86_SIZE_dq: /* SSE/AVX 128-bit */
-        if (e->special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, e)) {
             *ot = MO_64;
             return true;
         }
@@ -2489,8 +2494,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         return true;
 
     case X86_SIZE_x:  /* 128/256-bit, based on operand size */
-        if (e->special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, e)) {
             *ot = MO_64;
             return true;
         }
@@ -2605,8 +2609,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         goto get_reg;
 
     case X86_TYPE_V:  /* reg in the modrm byte selects an XMM/YMM register */
-        if (decode->e.special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, &decode->e)) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
@@ -2625,8 +2628,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         goto get_modrm;
 
     case X86_TYPE_W:  /* XMM/YMM modrm operand */
-        if (decode->e.special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, &decode->e)) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
@@ -2638,8 +2640,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         goto get_modrm_reg;
 
     case X86_TYPE_U:  /* R/M in the modrm byte selects an XMM/YMM register */
-        if (decode->e.special == X86_SPECIAL_MMX &&
-            !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
+        if (is_mmx(s, &decode->e)) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
@@ -3135,12 +3136,15 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     case 4:
     case 5:
     case 7:
-        if (s->prefix & PREFIX_VEX) {
+        if (is_mmx(s, e)) {
+            if (s->prefix & PREFIX_VEX) {
+                goto illegal;
+            }
+        } else if (s->prefix & PREFIX_VEX) {
             if (!(s->flags & HF_AVX_EN_MASK)) {
                 goto illegal;
             }
-        } else if (e->special != X86_SPECIAL_MMX ||
-                   (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+        } else {
             if (!(s->flags & HF_OSFXSR_MASK)) {
                 goto illegal;
             }
@@ -3694,8 +3698,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
     }
 
-    if (decode.e.special == X86_SPECIAL_MMX &&
-        !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+    if (is_mmx(s, &decode.e)) {
         gen_helper_enter_mmx(tcg_env);
     }
 
-- 
2.56.0



