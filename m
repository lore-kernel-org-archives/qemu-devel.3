Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63344606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dkqq2eEP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJNp-0006YD-2W; Tue, 17 Nov 2026 08:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNn-0006Xo-Lc
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJNm-00035k-5F
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJNt3/ihgiA7wrTRpTmrsWfi9v5xQ9uDbiaHQsILxco=;
 b=dkqq2eEPjUXKkRtzBD/vJNIxweAOLkd8+ytVjj5TGPERPQ9NZlSpOMS1Abp5ZAmY86fxo9
 umZlHqIm8mjHaMM0z3TNT43l4B0bYHdCE2kB/5ligruaVqNZYUwLJ2OyT5wNGuUpgtG42/
 KD/elQNhSewqCathFhP0uLY5vHVSEgA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655--1Tnb-M0Oy-Cf-rNVequrA-1; Tue,
 17 Nov 2026 08:37:54 -0500
X-MC-Unique: -1Tnb-M0Oy-Cf-rNVequrA-1
X-Mimecast-MFC-AGG-ID: -1Tnb-M0Oy-Cf-rNVequrA_1794922673
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A117219560BA
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:37:53 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3440428
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 13:37:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] target/i386/tcg: fix CPUID checks for TZCNT and LZCNT
Date: Tue, 17 Nov 2026 14:37:36 +0100
Message-ID: <20261117133750.322253-2-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

decode_0FBC() decodes F3 0F BC as TZCNT only if the CPU has ABM, and
decode_0FBD() decodes F3 0F BD as LZCNT only if the CPU has BMI1.  The
features are the other way round: TZCNT is part of BMI1, and LZCNT is
part of ABM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index aa22014786f..b51b2f1ae9d 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -688,7 +688,7 @@ static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
         X86_OP_ENTRYwr(TZCNT, G,v, E,v, zextT0), /* 0xf3 */
         X86_OP_ENTRY2(BSF,    G,v, E,v, zextT1), /* 0xf2 */
     };
-    if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
+    if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
         *entry = opcodes_0FBC[0];
     } else {
         *entry = *decode_by_prefix(s, opcodes_0FBC);
@@ -703,7 +703,7 @@ static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
         X86_OP_ENTRYwr(LZCNT, G,v, E,v, zextT0), /* 0xf3 */
         X86_OP_ENTRY2(BSR,    G,v, E,v, zextT1), /* 0xf2 */
     };
-    if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
+    if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
         *entry = opcodes_0FBD[0];
     } else {
         *entry = *decode_by_prefix(s, opcodes_0FBD);
-- 
2.56.0



