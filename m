Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8116606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=He4nYoHw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWZ0q-0006cR-1H; Thu, 26 Nov 2026 07:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWZ0h-0006YQ-4c
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:55:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWZ0e-0007wJ-1i
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795697731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCBaVavLSBaEKDfw8YlN7n87s1g9xGYdARPCIFuncDA=;
 b=He4nYoHwem9BSGrfRkZGNEOTkplZZfwy3jtHtcnJZqefCI8mI/xK/OF/hZsRsA8QDi9ATr
 nw5acmuz0yNYBZnIUrsIz1ejqhAWyWigP4tPHLhYsVIomcM4tDGmSHVLi+8OQCI6you41R
 xJ9otQ/L8tNcnp2utTk8MrIhZkoFais=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-S1QOTWMZPsW8GD979Hng3w-1; Thu,
 26 Nov 2026 12:55:28 +0000
X-MC-Unique: S1QOTWMZPsW8GD979Hng3w-1
X-Mimecast-MFC-AGG-ID: S1QOTWMZPsW8GD979Hng3w_1795697728
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7EE7180075B
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 12:55:27 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46BDE1956086
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 12:55:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] target/i386/tcg: apply zero extension to 8- and 16-bit NDD
 destinations
Date: Thu, 26 Nov 2026 13:55:21 +0100
Message-ID: <20261126125524.2223648-2-pbonzini@redhat.com>
In-Reply-To: <20261126125524.2223648-1-pbonzini@redhat.com>
References: <20261126125524.2223648-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Section 3.1.2.4 of the APX spec says: "For an Intel® APX instruction
with an NDD (see items 2.(a) of Section 3.1.2.3.1), the destination GPR
(namely, the NDD) will get the instruction’s result in bits [OSIZE-1:0]
and, if OSIZE < 64b, have its upper bits [63:OSIZE] zeroed. In other words,
there is no merging of the old and new values at the NDD regardless of
the OSIZE or whether the NDD is one of the source operands."

For example,

        int a = 0xfffff;
        asm("addw %w2, %w1, %w0" : "+r"(a) : "r"(1));

should leave 0, not 0xf0000 in the destination register.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index bd9a94b3162..a10641995e0 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2083,7 +2083,7 @@ static void decode_EVEX4cc(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     /*
      * All EVEX-promoted register-destination conditional moves (all CFCMOV
      * cases except "CFCMOV rm, r", and three-operand CMOV) have zero-upper
-     * Note that this is specific to CMOV/CFCMOV, and not ZU!
+     * This is specific to CMOV/CFCMOV in that it applies even for NDD=0!
      *
      * For NDD=0, NF represents the direction.  For NDD=1, NF represents fault
      * suppression.
@@ -3016,6 +3016,8 @@ static bool validate_evex_apx(DisasContext *s, X86DecodedInsn *decode)
             s->vex_ndd = false;
         } else if (!s->vex_ndd) {
             goto illegal;
+        } else {
+            decode->e.ext0 = X86_EXT_Unsigned;
         }
         evex4_mask = 0x1C;
         break;
-- 
2.56.1



