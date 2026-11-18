Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54A606A337
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/7qafqX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiI-0002cO-VA; Wed, 18 Nov 2026 07:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei3-0002QD-Kl
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei1-0004pY-Kv
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDLvb8+oyr4nDJjkPt9zZkESWATFzWRZo3Lo1DLyPWw=;
 b=f/7qafqXzJalPJmbXfPKdtEJ5OiV1Z1llf5gFcLWzAmaYeofK2N3LgvmkRThRyw3PYgn5s
 CtOg7muAx5KlIjA12VtEg42k8OsQJTBFDZ/Pqx84u5NnEHXt47eiSm00PYqkVt6mlZa44X
 9DXSgFcikqS+aahDZaOoWgTBY038dcE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-jcjxlPwnNZi3etyVMNvSaA-1; Wed,
 18 Nov 2026 07:24:15 -0500
X-MC-Unique: jcjxlPwnNZi3etyVMNvSaA-1
X-Mimecast-MFC-AGG-ID: jcjxlPwnNZi3etyVMNvSaA_1795004654
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 634CF18004E2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:14 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B373518004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 13/26] target/i386/tcg: defer the encoding check for rows
 with vex_class == 0
Date: Wed, 18 Nov 2026 13:23:44 +0100
Message-ID: <20261118122357.659634-14-pbonzini@redhat.com>
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

disas_insn() already raises #UD for VEX and EVEX if the row has vex_class
== 0.  For such lines, skip the check on the encoding constraint,
and look at it only if it is needed to separate the line from others
for the same opcode, for example EMMS and VZEROUPPER.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/maketable.py              | 20 +++++++++++++--
 target/i386/tcg/test_maketable.py         |  7 +++++
 target/i386/tcg/test_maketable_codegen.py | 31 +++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index f1af327bfca..bdcacf9ff48 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -414,6 +414,8 @@ class Sel(enum.Enum):
     7: frozenset([ENC_VEX, ENC_EVEX]),
 }
 
+VEX_EVEX = frozenset([ENC_VEX, ENC_EVEX])
+
 # Rows of map 0 and 1 where REX2 differs from the legacy encoding.
 REX2_ROWS = {None: {0x4, 0x7, 0xA, 0xE}, '0F': {0x3, 0x8}}
 
@@ -518,11 +520,16 @@ class Entry:
     map: int = field(init=False, default=0)
     constraints: Constraints = field(init=False, default_factory=dict)
 
+    # Constraints that are also checked when decoding the row.  The trie
+    # does not add a test for this entry alone, they are only taken into
+    # account if another entry does need to test the selector.
+    deferred: Constraints = field(init=False, default_factory=dict)
+
     # Selectors whose value is replaced when decoding (X86_OP_SET).
     sets: dict[Sel, int] = field(init=False, default_factory=dict)
 
     def accepts(self, sel: Sel, v: int) -> bool:
-        allowed = self.constraints.get(sel)
+        allowed = self.constraints.get(sel, self.deferred.get(sel))
         return allowed is None or v in allowed
 
     def constrains(self, sel: Sel, checked: frozenset[str]) -> bool:
@@ -554,6 +561,9 @@ def is_rex2(self) -> bool:
         lo, hi = self.insn.opcode
         return all((b >> 4) in rows for b in range(lo, hi + 1))
 
+    def vex_class_zero(self) -> bool:
+        return not any(m.name in EXCEPTION_CLASSES for m in self.insn.modifiers)
+
     def check_prefix(self) -> None:
         prefix = self.insn.prefix
         for items in (prefix.mandatory, prefix.encoding, prefix.l):
@@ -828,7 +838,12 @@ def compute_constraints(self) -> None:
         if not encs:
             raise self.error('no encoding of this line can reach its opcode map')
         if encs != ENCODINGS_FOR_MAP[self.map]:
-            c[Sel.ENC] = frozenset(encs)
+            # disas_insn() raises #UD for VEX and EVEX if vex_class is 0,
+            # so the trie does not need to exclude them.
+            if self.vex_class_zero() and ENCODINGS_FOR_MAP[self.map] - encs <= VEX_EVEX:
+                self.deferred[Sel.ENC] = frozenset(encs)
+            else:
+                c[Sel.ENC] = frozenset(encs)
 
         # WIG, LIG and LLIG accept all values, and decode as 0.
         if prefix.w == 'WIG':
@@ -1013,6 +1028,7 @@ def build_subtree(entries: list[Entry], start: int, cache: dict[CacheKey, TrieIt
     pos = next((i for i in range(start, len(SEL_ORDER))
                 if any(e.constrains(SEL_ORDER[i], checked) for e in entries)), None)
     sel = None if pos is None else SEL_ORDER[pos]
+
     item: TrieItem
     if sel is None:
         if len(entries) > 1:
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index a0759d3ad7f..b944c59882c 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -468,6 +468,13 @@ def test_mode64(self) -> None:
         self.assertEqual(self.emitter(trie, 0, byte=0x63, mode64=1, w=1), 'MOVSXD')
         self.assertEqual(self.emitter(trie, 0, byte=0x63, mode64=1, w=0), 'MOV')
 
+    def test_redundant_node(self) -> None:
+        trie = self.build('NP|66|F3|F2.0F 05   SYSCALL')
+        # All prefixes lead to SYSCALL, which has vex_class == 0.
+        self.assertNotIsInstance(trie.maps[1].children[0x05], Node)
+        for prefix in range(4):
+            self.assertEqual(self.emitter(trie, 1, byte=0x05, prefix=prefix), 'SYSCALL')
+
     def test_vex_implies_np(self) -> None:
         trie = self.build('VEX.128.0F.WIG 77   VZEROUPPER')
         self.assertEqual(self.emitter(trie, 1, byte=0x77, prefix=0, enc=ENC_VEX), 'VZEROUPPER')
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
index 8950816c292..446ed51ca6c 100644
--- a/target/i386/tcg/test_maketable_codegen.py
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -7,6 +7,7 @@
 import unittest
 
 from maketable import (
+    ENC_EVEX,
     ENC_LEGACY,
     ENC_REX2,
     ENC_VEX,
@@ -185,6 +186,36 @@ def test_match(self) -> None:
         self.assertNotIn(None, program.rows)
         self.assertIn('MATCH', [step.kind for step in program.steps])
 
+    def test_vex_class_zero(self) -> None:
+        # Without a VEX form, legacy opcodes do not need to check the encoding.
+        program = self.check_equivalent(build('00         ADD      Eb,Gb    lock',
+                                              '50..57+r   PUSH     Rd64(r)',
+                                              'NP.0F 67   PACKUSWB Pq,Qq'))
+        self.assertNotIn(Sel.ENC, [step.sel for step in program.steps])
+        # With an exception class, VEX and EVEX must still be #UD.
+        program = self.check_equivalent(build('NP.0F 67   PACKUSWB Vx,Hx,Wx E4(mmx)'))
+        got, _ = run(program, 1, {Sel.BYTE: 0x67, Sel.ENC: ENC_VEX})
+        self.assertIsNone(got)
+
+    def test_vex_class_zero_distinct(self) -> None:
+        # EMMS, VZEROUPPER and VZEROALL share opcode 0F 77 and are told apart by
+        # the encoding and by VEX.L; LDMXCSR is the legacy or VEX form of 0F AE /2.
+        program = self.check_equivalent(build('NP.0F 77             EMMS',
+                                              'VEX.NP.L0.0F 77      VZEROUPPER   E8',
+                                              'VEX.NP.L1.0F 77      VZEROALL     E8'))
+
+        got, _ = run(program, 1, {Sel.BYTE: 0x77, Sel.ENC: ENC_LEGACY, Sel.PREFIX: 0})
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'EMMS')
+        got, _ = run(program, 1, {Sel.BYTE: 0x77, Sel.ENC: ENC_VEX, Sel.PREFIX: 0, Sel.L: 0})
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'VZEROUPPER')
+        got, _ = run(program, 1, {Sel.BYTE: 0x77, Sel.ENC: ENC_VEX, Sel.PREFIX: 0, Sel.L: 1})
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'VZEROALL')
+        got, _ = run(program, 1, {Sel.BYTE: 0x77, Sel.ENC: ENC_EVEX, Sel.PREFIX: 0, Sel.L: 0})
+        self.assertIsNone(got)
+
     def test_shared_subtree(self) -> None:
         # The ENC node for 0F D6 is reached from two prefixes.
         lower(build('SSE|VEX.66.0F D6   MOVQ      Wdq(w),Vq   E5',
-- 
2.56.0



