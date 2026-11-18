Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A50606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NrtX+oDd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiH-0002ZE-EK; Wed, 18 Nov 2026 07:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei8-0002Rn-LF
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei6-0005Tk-FU
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yOVCE9Z7e9+yUzCzvvDLmS2cKGgHsP7IUt7hrDdleA=;
 b=NrtX+oDdhct1HZrlRPZeNpGzGHAsPpVmPFQb9s+suv9Wal4+4pNR1imrOYhqnrwmv4QGZa
 46spQYE2HlO4CNWgG5hgM+HeVhsCV8KJ//d981KpH9fZkxgbRtaxgmm5dmENye0AiYxpDc
 yD+GmXWFuFFg6AYOuUVvP8BLzgdQljk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-TWoVUZKNMouDjarMQqut_g-1; Wed,
 18 Nov 2026 07:24:20 -0500
X-MC-Unique: TWoVUZKNMouDjarMQqut_g-1
X-Mimecast-MFC-AGG-ID: TWoVUZKNMouDjarMQqut_g_1795004659
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1FA3180034B
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:19 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 105E518004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 18/26] target/i386/tcg: convert REX2 map 0 to decode.def
Date: Wed, 18 Nov 2026 13:23:49 +0100
Message-ID: <20261118122357.659634-19-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Keep the C decoder for the shared rows until the legacy map is
converted, but switch to the new table for all REX2-specific rows,
whether filled in or not.  This is a temporary state anyway because
ultimately, legacy encoding and REX2 will share maps completely as
far as decode-new.c.inc is concerned; the differences between the
two entry points are embedded in the bytecode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 15 +++++++++------
 target/i386/tcg/decode.def       |  6 ++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 46e2121e2bb..1c5c6687419 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1704,10 +1704,6 @@ static const X86OpEntry opcodes_root[256] = {
 };
 
 #ifdef TARGET_X86_64
-static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
-    [1] = X86_OP_ENTRYr(JMP_m,   I,q, p_00 chk2(W0, no_adr)), /* JMPABS */
-};
-
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
                         const X86OpEntry **map)
 {
@@ -1728,14 +1724,21 @@ static void decode_REX2_map0(DisasContext *s, CPUX86State *env, X86OpEntry *entr
         NULL,
         &opcodes_root[0x80],
         &opcodes_root[0x90],
-        opcodes_rex2_map0_A0toAF,
+        NULL,
         &opcodes_root[0xB0],
         &opcodes_root[0xC0],
         &opcodes_root[0xD0],
         NULL,
         &opcodes_root[0xF0],
     };
-    decode_REX2(s, env, entry, b, opcode_rex2_map0);
+
+    /* The rows that differ from the legacy encoding are in decode.def.  */
+    if (opcode_rex2_map0[*b >> 4]) {
+        decode_REX2(s, env, entry, b, opcode_rex2_map0);
+    } else {
+        const X86OpEntry *row = decode_run(s, env, 0, b);
+        *entry = row ? *row : UNKNOWN_OPCODE;
+    }
 }
 
 static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 7ef0b1dd65b..658cbe7f7b9 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -200,6 +200,12 @@
 //       decode.def:867: 66.0F38 10                  PBLENDVB      Vx,Wx              E4 cpuid(SSE41): needs ENC=legacy
 //
 
+// REX2 map 0
+// ----------
+
+REX2.NP.W0 A1                   JMP_m         Iq                 chk(no_adr)   // JMPABS
+
+
 // 0F 38
 // -----
 
-- 
2.56.0



