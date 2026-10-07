Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88620CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbn-0003F3-AF; Wed, 07 Oct 2026 12:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbI-0002xB-ET
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbG-0006Lo-L2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ga9IWDFIJdxkVUwl1Dj50P7zJfMzWcEDZR2roBnPnVs=;
 b=eoExjeQhi6NGKOi6yrTWynTZEZZ9IpepAqDDEa7yVkiX+9vze2R9IWG7rwP0Bk1A8cEKpM
 z7m0zgno1r4QKKpxazsI+Gr2gcPBOD22kwJOo/8yRXx2d+JaPI9hB6PsylzlUOFC8MtDwJ
 zE8oAcknjClMF0ZDeY5KijDusdP3yBk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-npxjga1AOxCebPI6SFvk8A-1; Wed,
 07 Oct 2026 12:34:35 -0400
X-MC-Unique: npxjga1AOxCebPI6SFvk8A-1
X-Mimecast-MFC-AGG-ID: npxjga1AOxCebPI6SFvk8A_1791390874
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF2E71955E87; Wed,  7 Oct 2026 16:34:34 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D3E01956087; Wed,  7 Oct 2026 16:34:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 12/21] scripts/qemugdb: coroutine: Speed up coroutine lookup in
 a coredump
Date: Wed,  7 Oct 2026 18:32:53 +0200
Message-ID: <20261007163302.332250-13-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

'qemu bt' on a coredump takes significant time before the first
coroutine frame is even printed.  The bulk of the delay is resolving a
name.

co_tls_current is a file static variable, and CoroutineUContext is defined
in the same compilation unit, so resolving either of them by name makes gdb
expand every symtab in the binary.

Look the static up with gdb.lookup_static_symbol(), which is served from
the gdb's in-memory index, and scope the type lookup to the symtab that
comes with it.  This significantly speeds up 'qemu bt' processing.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-9-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 3e0b37b73ea..21ed7cbaab8 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -313,7 +313,16 @@ def bt_jmpbuf(jmpbuf, is_coredump, detailed=False):
         dump_backtrace(regs)
 
 def co_cast(co):
-    return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
+    # Unscoped type lookup expands every symtab in the binary.
+    # Better scope it to the symtab of the ucontext backend
+    sym = gdb.lookup_static_symbol('co_tls_current')
+    if sym is not None:
+        co_type = gdb.lookup_type('CoroutineUContext',
+                                  sym.symtab.static_block())
+    else:
+        co_type = gdb.lookup_type('CoroutineUContext')
+
+    return co.cast(co_type.pointer())
 
 def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
@@ -416,7 +425,8 @@ def invoke(self, arg, from_tty):
             co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
         else:
             # Fallback to use hard-coded ucontext vars if it's coredump
-            co_ptr = gdb.parse_and_eval("co_tls_current")
+            sym = gdb.lookup_static_symbol("co_tls_current")
+            co_ptr = sym.value() if sym else gdb.parse_and_eval("co_tls_current")
 
         if co_ptr == False:
             return
-- 
2.56.0


