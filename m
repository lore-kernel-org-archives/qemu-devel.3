Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662B606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oy5YK0tW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTehz-0002N7-MN; Wed, 18 Nov 2026 07:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehv-0002M5-Ea
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeht-0004PN-Nw
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdOYjB6zs9oGmmrV8MnTwvrPf9dyGljpHb7DYEopyBk=;
 b=Oy5YK0tWJsXciyhmvrXTx2MH9FvFoiGzhtxTcvULsji6bwIhpkVOVjID6v46Z22lEMCpFZ
 iKLtYB84YoVd7plMg6n8QwHOXxkgN5bu5gbhdqKtji+bgvVIZM0wnRPeD4nS+ELto8fGNY
 Su0ZehjTL/R2dAVGiAUGbRsGddtrvf4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-d46N6zX3Pr-wZqeEfLrfYQ-1; Wed,
 18 Nov 2026 07:24:07 -0500
X-MC-Unique: d46N6zX3Pr-wZqeEfLrfYQ-1
X-Mimecast-MFC-AGG-ID: d46N6zX3Pr-wZqeEfLrfYQ_1795004646
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F2F01800359
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:06 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3AEC180055C
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 06/26] target/i386/tcg: only check the encoding when it
 matters
Date: Wed, 18 Nov 2026 13:23:37 +0100
Message-ID: <20261118122357.659634-7-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

VEX and EVEX never reach map 0, REX2 never reaches maps 2 and 3, and
maps 4 to 6 are EVEX only.  If only one encoding can reach the map,
drop the ENC constraint.  In particular, one-byte opcodes now only look
at the encoding in the rows where REX2 differs from the legacy encoding.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/maketable.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index a1ebc906899..17a46021be6 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -399,6 +399,19 @@ class Sel(enum.Enum):
     'EVEX': ENC_EVEX,
 }
 
+# Encodings that can reach each opcode map: VEX and EVEX start at map 1,
+# and REX2 cannot encode 0F 38 and 0F 3A (row 3 of map 1).
+ENCODINGS_FOR_MAP = {
+    0: frozenset([ENC_LEGACY, ENC_REX2]),
+    1: frozenset([ENC_LEGACY, ENC_REX2, ENC_VEX, ENC_EVEX]),
+    2: frozenset([ENC_LEGACY, ENC_VEX, ENC_EVEX]),
+    3: frozenset([ENC_LEGACY, ENC_VEX, ENC_EVEX]),
+    4: frozenset([ENC_EVEX]),
+    5: frozenset([ENC_EVEX]),
+    6: frozenset([ENC_EVEX]),
+    7: frozenset([ENC_VEX, ENC_EVEX]),
+}
+
 # Rows of map 0 and 1 where REX2 differs from the legacy encoding.
 REX2_ROWS = {None: {0x4, 0x7, 0xA, 0xE}, '0F': {0x3, 0x8}}
 
@@ -762,7 +775,13 @@ def compute_constraints(self) -> None:
         encs = set(ENCODINGS[e] for e in [prefix.encoding or 'LEGACY'])
         if ENC_LEGACY in encs and not self.is_rex2() and 'no_rex2' not in checks:
             encs.add(ENC_REX2)
-        c[Sel.ENC] = frozenset(encs)
+
+        # Only check the encoding if other encodings can reach the same map.
+        encs &= ENCODINGS_FOR_MAP[self.map]
+        if not encs:
+            raise self.error('no encoding of this line can reach its opcode map')
+        if encs != ENCODINGS_FOR_MAP[self.map]:
+            c[Sel.ENC] = frozenset(encs)
 
         # WIG, LIG and LLIG accept all values, and decode as 0.
         if prefix.w == 'WIG':
-- 
2.56.0



