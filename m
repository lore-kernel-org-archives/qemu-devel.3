Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE7606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ImR5Evng
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTehx-0002MQ-2D; Wed, 18 Nov 2026 07:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehs-0002Lo-RD
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehq-0004BS-Bu
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVdg0kwDlTU1CbrqzrqqyiAzKkYVIlwOgwSvxrXFyRc=;
 b=ImR5Evngj6JIj5u5Sc4ObgbXnpLvPBpViqAqghYHQeNAawAbmH4uRi2EniOq1Zpv1mJvsD
 Ue2SnSDInxpXG+0F0w4GzM2HfBAhKerUygBss2dYj6yuOnxwuuGNGTo0MiDPqB8m8DWPgi
 4TfeBntr4uzvh7FwLTz1hyrPdaut1AI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-v2AeAo2UNtKjkw1lolb88Q-1; Wed,
 18 Nov 2026 07:24:04 -0500
X-MC-Unique: v2AeAo2UNtKjkw1lolb88Q-1
X-Mimecast-MFC-AGG-ID: v2AeAo2UNtKjkw1lolb88Q_1795004643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E6361800366
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:03 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B032A18004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/26] target/i386/tcg: restrict REX2 to opcodes where
 REX2 differs, no_rex2 where it is the same
Date: Wed, 18 Nov 2026 13:23:34 +0100
Message-ID: <20261118122357.659634-4-pbonzini@redhat.com>
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

REX2 is the same as the legacy encoding except in rows 4, 7, A and E
of map 0 and rows 3 and 8 of map 1, which the decoder reaches through
separate entry points.  Only allow REX2 lines in those rows, and do
not let legacy lines in those rows accept REX2, including via an
opcode range; this also means that chk(no_rex2) in REX2 lines is
non-sensical, so reject it.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode.def        |  3 ++-
 target/i386/tcg/maketable.py      | 20 ++++++++++++++++++++
 target/i386/tcg/test_maketable.py |  4 +++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index e18cc054ee5..59010401d4e 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -122,7 +122,8 @@
 //
 //     chk(a, ...)     checks from X86InsnCheck in decode-new.h, without the
 //                     X86_CHECK_ prefix.  i64 and o64 also choose between
-//                     lines for the same opcode.
+//                     lines for the same opcode.  no_rex2 removes the REX2
+//                     encoding from lines that would inherit it automatically.
 //
 //     cpuid(feature, ...)
 //                     one or more X86CPUIDFeatures that the instruction needs.
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 841c376c6b0..2a52307d97e 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -347,6 +347,10 @@ def parse_file(lines: list[str], filename: str = '<string>') -> list[Insn]:
     return insns
 
 
+# Rows of map 0 and 1 where REX2 differs from the legacy encoding.
+REX2_ROWS = {None: {0x4, 0x7, 0xA, 0xE}, '0F': {0x3, 0x8}}
+
+
 class SemanticError(Exception):
     def __init__(self, insn: Insn, msg: str):
         super().__init__(msg)
@@ -427,6 +431,14 @@ class Entry:
     def error(self, msg: str) -> SemanticError:
         return SemanticError(self.insn, msg)
 
+    def is_rex2(self) -> bool:
+        # Whether the opcodes are in the rows where REX2 differs from the
+        # legacy encoding
+        prefix = self.insn.prefix
+        rows = REX2_ROWS.get(prefix.map, set())
+        lo, hi = self.insn.opcode
+        return all((b >> 4) in rows for b in range(lo, hi + 1))
+
     def check_prefix(self) -> None:
         prefix = self.insn.prefix
         enc = prefix.encoding
@@ -455,6 +467,14 @@ def check_prefix(self) -> None:
         if enc == 'REX2' and prefix.map not in (None, '0F'):
             raise self.error(f'REX2 cannot encode map {prefix.map}')
 
+        # Elsewhere, REX2 is the same as the legacy encoding.
+        if enc == 'REX2' and not self.is_rex2():
+            raise self.error('REX2 lines are only needed for rows 4, 7, A, E of map 0 '
+                             'and 3, 8 of map 1')
+        checks = {arg for m in self.insn.modifiers if m.name == 'chk' for arg in m.args}
+        if enc == 'REX2' and 'no_rex2' in checks:
+            raise self.error('REX2 is incompatible with chk(no_rex2)')
+
     def check_opcode(self) -> None:
         lo, hi = self.insn.opcode
         # With +r, bits 0-2 of the opcode are the register number, so the
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index 0015bed9a23..b682d289184 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -321,7 +321,6 @@ def test_prefix(self) -> None:
             'EVEX.512.66.0F38.W1 00   VPSHUFB   Vx,Hx,Wx',
             'EVEX.LLZ.NP.MAP4.ND1.NF0 00   ADD   Bb,Eb,Gb',
             'REX2.NP.W0 A1   JMP_m   Iq(r)',
-            'REX2.0F 05   SYSCALL',
         ]
         for text in good:
             with self.subTest(text=text):
@@ -338,6 +337,9 @@ def test_prefix(self) -> None:
             'VEX.66 67   X   Vx',              # VEX without a map
             'EVEX.66 67   X   Vx',             # EVEX without a map
             'REX2.0F38 00   X   Vx',           # REX2 only has maps 0 and 1
+            'REX2.0F 05   SYSCALL',            # same as legacy
+            'REX2 A1..B0   X   Iq',            # partly same as legacy
+            'REX2 A1       X   Iq  chk(no_rex2)', # REX2 + no_rex2
         ]
         for text in bad:
             with self.subTest(text=text):
-- 
2.56.0



