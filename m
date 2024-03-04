Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA071C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9ZD-0007B5-Ep; Mon, 04 Mar 2024 09:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh9Z0-00078E-0X
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh9Yx-0006MI-FG
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709563506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLvvnawf8Y0JAJgS0FG+ATI5m0ZuxaniOd3uQ0mOM8A=;
 b=CGaNDI4m18auHMlMhJhN33JNRcn23b8SQpa7TaVQisIi10DtlbMnpcZ3VqJjSXWL9s/uQH
 E753OlxLCQ3u67Thlgb5GnYqOMFt91XazsRbDfEP78N7BDZiLn9SwJKl3Z2K8xoTdnejRa
 SRFCWja5COEzD06wTGX2cxDEtDEjBsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-9TdeOOI2OkWutwADUWbgIw-1; Mon, 04 Mar 2024 09:45:01 -0500
X-MC-Unique: 9TdeOOI2OkWutwADUWbgIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89150891F20;
 Mon,  4 Mar 2024 14:45:01 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEC882166B35;
 Mon,  4 Mar 2024 14:44:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] meson: detect broken clang 17 with -fzero-call-used-regs
Date: Mon,  4 Mar 2024 14:44:55 +0000
Message-ID: <20240304144456.3825935-2-berrange@redhat.com>
In-Reply-To: <20240304144456.3825935-1-berrange@redhat.com>
References: <20240304144456.3825935-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Clang 17 will segv if given  -fzero-call-used-regs and optimization
is enabled. Since upstream hasn't triaged the bug, distros are
increasingly shipping with broken Clang.

https://github.com/llvm/llvm-project/issues/75168
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=277474
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 0ef1654e86..762798f2ee 100644
--- a/meson.build
+++ b/meson.build
@@ -555,17 +555,24 @@ endif
 # Check further flags that make QEMU more robust against malicious parties
 
 hardening_flags = [
-    # Zero out registers used during a function call
-    # upon its return. This makes it harder to assemble
-    # ROP gadgets into something usable
-    '-fzero-call-used-regs=used-gpr',
-
     # Initialize all stack variables to zero. This makes
     # it harder to take advantage of uninitialized stack
     # data to drive exploits
     '-ftrivial-auto-var-init=zero',
 ]
 
+# Zero out registers used during a function call
+# upon its return. This makes it harder to assemble
+# ROP gadgets into something usable
+#
+# NB: CLang 17 is broken and SEGVs
+# https://github.com/llvm/llvm-project/issues/75168
+if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
+               name: '-fzero-call-used-regs=used-gpr',
+               args: ['-O2', '-fzero-call-used-regs=used-gpr'])
+    hardening_flags += '-fzero-call-used-regs=used-gpr'
+endif
+
 qemu_common_flags += cc.get_supported_arguments(hardening_flags)
 
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
-- 
2.43.0


