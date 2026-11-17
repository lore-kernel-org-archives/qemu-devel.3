Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50345606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhEfx2Tf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNq-0006Yt-DI; Tue, 17 Nov 2026 08:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNo-0006Y7-Ru
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNn-000369-2Y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4t6VyO/l/uAQGoH822rv/6kOmEcDv36bSjYNhXgTi4=;
 b=IhEfx2TfQlG/LRBXtL4ZMzYhOmDwegEyOwyLcfaIkPTuSe0oXfE8gV/Jn1YQNqVoS6soXk
 vFQvxAP2tzgHAzeaU3lJIx7DST+SLyWXyk9psdR2rdWtXqf93EScldUsqJshnmiFNu1Qv9
 aY4hwgKmwFc09mScfLM0wTA/qoXyzTg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-7u8VpsLsMwmQB5_qHj10wA-1; Tue,
 17 Nov 2026 08:37:56 -0500
X-MC-Unique: 7u8VpsLsMwmQB5_qHj10wA-1
X-Mimecast-MFC-AGG-ID: 7u8VpsLsMwmQB5_qHj10wA_1794922675
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C78D41800551
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:37:55 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21D0341F
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:37:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] target/i386/tcg: fix SETCC(zu) optimization
Date: Tue, 17 Nov 2026 14:37:38 +0100
Message-ID: <20261117133750.322253-4-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With EVEX.ND=1, SETcc zero extends its result to the whole register, which
validate_evex_apx() requests with EXT_Unsigned.  QEMU is trying to
avoid the extension by changing the size of the operand, but it sets
a field of the row that is unused, because op1 is None.

Do it in gen_SETcc() instead.  The result of setcc is 0 or 1, so writing
the whole register has the same effect as the zero extension, and
gen_writeback() skips the extension.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 3 ---
 target/i386/tcg/emit.c.inc       | 8 ++++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 5b3d772d999..e985b128893 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2109,9 +2109,6 @@ static void decode_EVEX4cc(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 
     if (s->prefix & PREFIX_REPNZ) {
         *entry = setcc;
-        if (EVEX_APX_ND(s)) {
-            entry->s1 = X86_SIZE_q; /* optimization for zu */
-        }
     } else {
         *entry = (EVEX_APX_ND(s) ? cfcmov_nd1 : cfcmov_nd0)[EVEX_APX_NF(s)][mod == 3];
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index b3029f6fbbe..49d33223f41 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4136,6 +4136,14 @@ static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_setcc(s, decode->b & 0xf, s->T0);
+
+    /*
+     * With APX ZU, the written value requests zero extension.  Since T0 is
+     * 0 or 1, writing the whole register is the same and saves the extension.
+     */
+    if (decode->op[0].ext == X86_EXT_Unsigned && !decode->op[0].has_ea) {
+        decode->op[0].ot = MO_TL;
+    }
 }
 
 static void gen_SFENCE(DisasContext *s, X86DecodedInsn *decode)
-- 
2.56.0



