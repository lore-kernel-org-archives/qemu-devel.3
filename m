Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AC606A337
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRPB7LMc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiL-0002dR-MJ; Wed, 18 Nov 2026 07:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei7-0002RU-1J
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei5-0005KK-EY
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbBGBTGmT2usV2th9M0tIp++GIwJUTVbG/AjH3hvrBY=;
 b=FRPB7LMcni+kUbEV4yH/m5PKivYkrhdDtLrPdxjN63pzWFGgC3FdvZdwm5iOT8nEB5nhvV
 G0Lurp9/AbJxT6lNreSXoKhY3T3S/qMY/QlTn8L06tz7oJFnMx3aaXkKhYSMwZu9Hq3z67
 WRdXr0OiTuTLTiFm6M9G/7eMedsbcfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-SvvIc4phPr-yHwyWoPGdhg-1; Wed,
 18 Nov 2026 07:24:19 -0500
X-MC-Unique: SvvIc4phPr-yHwyWoPGdhg-1
X-Mimecast-MFC-AGG-ID: SvvIc4phPr-yHwyWoPGdhg_1795004658
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3BF818004E2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:18 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01DE918004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 17/26] target/i386/tcg: fetch the opcode byte in
 disas_insn() for REX2 map 0
Date: Wed, 18 Nov 2026 13:23:48 +0100
Message-ID: <20261118122357.659634-18-pbonzini@redhat.com>
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

For other encodings of the one-byte map, the opcode has already been
fetched by the time disas_insn() calls the decoder.  Do the same for
REX2 with M=0, so that decode_REX2_map0 does not have to fetch it
(like decode_root).

REX2 with M=1 still fetches the opcode byte in decode_REX2_map1, like
decode_0F does after the 0F prefix.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 49a40eebbc7..46e2121e2bb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1711,7 +1711,6 @@ static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
 static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
                         const X86OpEntry **map)
 {
-    *b = x86_ldub_code(env, s);
     const X86OpEntry *group = map[*b >> 4];
     *entry = group ? group[*b & 15] : UNKNOWN_OPCODE;
 }
@@ -1759,6 +1758,7 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
         &opcodes_0F[0xE0],
         &opcodes_0F[0xF0],
     };
+    *b = x86_ldub_code(env, s);
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
 
@@ -3188,7 +3188,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             s->rex_x = collapse_two_bits(rex2, 0x22) >> 1;
             s->rex_r = collapse_two_bits(rex2, 0x44) >> 2;
             s->vex_w = (rex2 >> 3) & 1;
-            decode_func = rex2 & 0x80 ? decode_REX2_map1 : decode_REX2_map0;
+            /* Leave b consistent with the non-REX2 encoding.  */
+            if (rex2 & 0x80) {
+                b = 0x0f;
+                decode_func = decode_REX2_map1;
+            } else {
+                b = x86_ldub_code(env, s);
+                decode_func = decode_REX2_map0;
+            }
         }
         break;
 #endif
-- 
2.56.0



