Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6F606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S3GmgOyU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiF-0002Vz-WA; Wed, 18 Nov 2026 07:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei1-0002Oz-La
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehz-0004gn-2a
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wu2cnbgDBskcyka9CaKETIaQNAOUh00Cpvck6fwXvQA=;
 b=S3GmgOyUz5A0qz2ENQOp1ZPcRGUn801qX8NupeHzc5w+ge55KnH6L4iX2DWBgDS595biC4
 P1Wt1DTMwiuvu3JB95y8nQlH/FMYD8DJbslUhq2L14cLnm04LmIfDXOxj+Tq1FPWsOdSdn
 SgCuolcrkngNjgaYUre0M14B2gmEWLA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-9CxqavrXMAu3WyKPSCdatw-1; Wed,
 18 Nov 2026 12:24:13 +0000
X-MC-Unique: 9CxqavrXMAu3WyKPSCdatw-1
X-Mimecast-MFC-AGG-ID: 9CxqavrXMAu3WyKPSCdatw_1795004652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 503A71800559
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:12 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94EF018004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/26] target/i386/tcg: lower single-outcome nodes to
 OP_MATCH
Date: Wed, 18 Nov 2026 13:23:42 +0100
Message-ID: <20261118122357.659634-12-pbonzini@redhat.com>
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

When all the values of a node that do not raise #UD lead to the same
subtree, emit an OP_MATCH that tests for those values, followed by the
subtree or an OP_JMP to it.  This avoids the overhead of OP_SELECT or
OP_SWITCH with many empty rows for #UD.  The common cases are a line
with a single mandatory prefix, only memory or register operands, and
chk(i64)/chk(o64)/chk(nf0).

AI-used-for: tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/maketable_codegen.py      | 39 +++++++++++++++++++++++
 target/i386/tcg/test_maketable_codegen.py | 14 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/target/i386/tcg/maketable_codegen.py b/target/i386/tcg/maketable_codegen.py
index e4d05295a63..c58e75f415a 100644
--- a/target/i386/tcg/maketable_codegen.py
+++ b/target/i386/tcg/maketable_codegen.py
@@ -186,6 +186,37 @@ def selector(node: Node) -> str | int:
         else:
             return node.max_child - 1
 
+    def code_or_jmp(self, item: TrieItem) -> None:
+        # Emit the decoding of an item, or a jump if it requires more than one
+        # bytecode and it was already produced elsewhere.
+        if item.index is None:
+            self.code(item)
+        else:
+            self.program.steps.append(self.step_or_jmp(item))
+
+    @staticmethod
+    def match(node: Node) -> tuple[Step, TrieItem] | None:
+        # If all values that do not raise #UD lead to the same subtree,
+        # return the argument of an OP_MATCH that tests for them, and the
+        # subtree.
+        others = [c for c in node.children if c is not Leaf.UD]
+        if not others or any(c is not others[0] for c in others):
+            return None
+        values = [v for v, c in enumerate(node.children) if c is others[0]]
+        sel_arg: str | int
+        if node.sel == Sel.CPUID:
+            if values != [1]:
+                return None
+            sel_arg = f'X86_FEAT_{node.feature}'
+        elif node.sel == Sel.BYTE:
+            if len(values) != 1:
+                return None
+            sel_arg = values[0]
+        else:
+            assert len(node.children) <= 8
+            sel_arg = sum(1 << v for v in values)
+        return Step('MATCH', node.sel, sel_arg), others[0]
+
     def node(self, node: Node, map: int | None = None) -> int:
         if node.index is not None:
             return node.index
@@ -196,6 +227,14 @@ def node(self, node: Node, map: int | None = None) -> int:
             steps.append(Step('UD'))
             return node.index
 
+        match = self.match(node)
+        if match is not None:
+            # MATCH, then the only subtree that does not raise #UD.
+            steps.append(match[0])
+            self.code_or_jmp(match[1])
+            steps[node.index].target = self.ud()
+            return node.index
+
         select = self.select(node)
         if select:
             steps.append(select)
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
index ab1bfb5761b..309e5cf11fa 100644
--- a/target/i386/tcg/test_maketable_codegen.py
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -176,6 +176,20 @@ def test_rex2(self) -> None:
         got, _ = run(program, 1, {Sel.BYTE: 0x30, Sel.ENC: ENC_REX2, Sel.PREFIX: 0})
         self.assertIsNone(got)
 
+    def test_match(self) -> None:
+        # A single valid value, or several leading to the same line, need
+        # no empty rows.
+        program = self.check_equivalent(build('NP|66.0F 67   PACKUSWB   Vx,Hx,Wx   E4',
+                                              'F3.0F AE /0      RDxxBASE   Ry(w)',
+                                              'W1 63   MOVSXD   Gv(w),Ed   chk(o64)'))
+        self.assertNotIn(None, program.rows)
+        self.assertIn('MATCH', [step.kind for step in program.steps])
+
+    def test_shared_subtree(self) -> None:
+        # The ENC node for 0F D6 is reached from two prefixes.
+        lower(build('SSE|VEX.66.0F D6   MOVQ      Wdq(w),Vq   E5',
+                    'F3.0F D6           MOVq_dq   Vdq(w),Nq'))
+
     def test_entry_points(self) -> None:
         program = lower(build('00   ADD   Eb,Gb'))
         for map in range(1, 8):
-- 
2.56.0



