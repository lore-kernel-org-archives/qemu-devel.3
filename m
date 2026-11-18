Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFD606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFdS007Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiH-0002ZU-Hy; Wed, 18 Nov 2026 07:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei2-0002PF-Hh
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei0-0004jx-T8
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SAqmfS7sE0rnH3RkLJCXOs2DTneNXt7tqHFdmAnVCg=;
 b=QFdS007YQLCnvzbBnqKNTUkCBFnkoDn2rLaNpO4vpfs+/2bh84vTVygcZytpK9gnS956rs
 sV2A7foR3IiOOV//WOEnWRUu6T1+4grfljwdqR7EpKaPKqgIxbqN6IdgvwOzLy2e2CUnqM
 9IPHgCobn0o9pjVGJ13rSqdUjyK2b80=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-ewV8vhwbPoWRb0EIkXQBIw-1; Wed,
 18 Nov 2026 07:24:14 -0500
X-MC-Unique: ewV8vhwbPoWRb0EIkXQBIw-1
X-Mimecast-MFC-AGG-ID: ewV8vhwbPoWRb0EIkXQBIw_1795004653
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6994E19560B2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:13 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A535518011D3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/26] target/i386/tcg: do not reference emitters for
 instructions that are 64-bit only or privileged
Date: Wed, 18 Nov 2026 13:23:43 +0100
Message-ID: <20261118122357.659634-13-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc                |  4 +---
 target/i386/tcg/maketable_codegen.py      | 17 +++++++++++++++++
 target/i386/tcg/test_maketable_codegen.py | 17 +++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 96a7b08bc04..ab11c61344b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3757,12 +3757,10 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
-#ifdef CONFIG_USER_ONLY
-static void gen_unreachable(DisasContext *s, X86DecodedInsn *decode)
+G_GNUC_UNUSED static void gen_unreachable(DisasContext *s, X86DecodedInsn *decode)
 {
     g_assert_not_reached();
 }
-#endif
 
 #ifndef CONFIG_USER_ONLY
 static void gen_RDMSR(DisasContext *s, X86DecodedInsn *decode)
diff --git a/target/i386/tcg/maketable_codegen.py b/target/i386/tcg/maketable_codegen.py
index c58e75f415a..87353042cae 100644
--- a/target/i386/tcg/maketable_codegen.py
+++ b/target/i386/tcg/maketable_codegen.py
@@ -283,8 +283,25 @@ def c_code(program: Program, source: str) -> str:
             out.append(f'    [{i}] = {{}},')
             continue
         out.append(f'    [{i}] = {{  /* {entry.insn.filename}:{entry.insn.lineno} */')
+        guards = []
+        if not entry.accepts(Sel.MODE64, 0):
+            # The emitters of rows that exist only in 64-bit mode might not
+            # be defined in 32-bit builds.
+            guards.append('defined TARGET_X86_64')
+        elif any(m.name == 'chk' and {'cpl0', 'smm'} & set(m.args)
+                 for m in entry.insn.modifiers):
+            # Privileged instructions always fail the CPL0 check in user-only
+            # builds.
+            guards.append('!defined CONFIG_USER_ONLY')
+
         for name, value in row_fields(entry).items():
+            if guards and name == 'gen':
+                out.append('#if ' + ' && '.join(guards))
             out.append(f'        .{name} = {value},')
+            if guards and name == 'gen':
+                out.append('#else')
+                out.append('        .gen = gen_unreachable,')
+                out.append('#endif')
         out.append('    },')
     out.append('};')
     out.append('')
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
index 309e5cf11fa..8950816c292 100644
--- a/target/i386/tcg/test_maketable_codegen.py
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -246,6 +246,23 @@ def test_vex_and_svm(self) -> None:
         fields = row_fields(entry('9D   POPF   chk(vm86_iopl) svm(POPF)'))
         self.assertEqual((fields['intercept'], fields['has_intercept']), ('SVM_EXIT_POPF', 'true'))
 
+    def test_prot_guard(self) -> None:
+        # Rows that need 64-bit mode are empty in 32-bit builds.
+        out = c_code(lower(build('0F 07   SYSRET   chk(cpl0)')), 'test.def')
+        self.assertIn('#if !defined CONFIG_USER_ONLY\n        .gen = gen_SYSRET,\n#else\n', out)
+        self.assertIn('gen_unreachable', out)
+        out = c_code(lower(build('0F AA   RSM   chk(smm)')), 'test.def')
+        self.assertIn('#if !defined CONFIG_USER_ONLY\n        .gen = gen_RSM,\n#else\n', out)
+        self.assertIn('gen_unreachable', out)
+
+    def test_o64_guard(self) -> None:
+        # Rows that need 64-bit mode are empty in 32-bit builds.
+        out = c_code(lower(build('0F 05   SYSCALL   chk(o64)')), 'test.def')
+        self.assertIn('#if defined TARGET_X86_64\n        .gen = gen_SYSCALL,\n#else\n', out)
+        self.assertIn('gen_unreachable', out)
+        out = c_code(lower(build('D6      SALC      chk(i64)')), 'test.def')
+        self.assertNotIn('TARGET_X86_64', out)
+
     def test_immediate_in_op3(self) -> None:
         # Like X86_OP_ENTRY4 with op0 = None.
         fields = row_fields(entry('SSE|VEX.66.0F3A 60   PCMPESTRM   Vdq(r),Wdq,Ib   '
-- 
2.56.0



