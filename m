Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF783CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbc-00032M-Ve; Wed, 07 Oct 2026 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbA-0002ue-1O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb7-0006Jv-9W
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DlUSpkhjcJX2TcPaMqdYgGVc3UqWXGV4qqVDKdbspo=;
 b=ZXFBKL9xGCm97RwSnL3igk9ytJI3OPe1NBV5z+eCSZSVQ46M5e5MFV4PCB7UtHIT29UL6/
 m8bciRXnL42bDsh6p2rOKpN01c6Rx4g4LjWgT5HObofIv6gbIUzDTCEjIJTE/MZOIAmRPX
 zdLxVPj0o3hMWJBZrkXsU51sdeW90bI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-8IW7xmVJPzaoiybQXajq9w-1; Wed,
 07 Oct 2026 12:34:25 -0400
X-MC-Unique: 8IW7xmVJPzaoiybQXajq9w-1
X-Mimecast-MFC-AGG-ID: 8IW7xmVJPzaoiybQXajq9w_1791390864
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A61A1800594; Wed,  7 Oct 2026 16:34:24 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE3451956087; Wed,  7 Oct 2026 16:34:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/21] scripts/qemugdb: coroutine: Get rid of fallback pattern
 when dumping backtrace
Date: Wed,  7 Oct 2026 18:32:47 +0200
Message-ID: <20261007163302.332250-7-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently upon invocation of 'qemu bt' / 'qemu coroutine' we try live
process backtrace dump first, and if it fails - fallback to coredump.
That causes us needless work and catching an exception.  In my previous
commit 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining
detailed trace in coredump") class Coredump was introduced, and each
invocation already calls init_coredump().  Let's just pass the result of
this call further as a bool param and make a decision based upon it.
Apply the same pattern to obtaining coroutine pointer.

Note that we deliberately lose a safety net here: the bare except used to
swallow any failure of the live dump, not just the absence of a live
process, and silently fall back to the raw unwind.  Such a failure is now
reported to the user instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-3-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index d1e6722d14d..d3f31bab9fe 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -281,20 +281,19 @@ def dump_backtrace_live(regs):
             # restore previously selected frame in any case
             selected_frame.select()
 
-def bt_jmpbuf(jmpbuf, detailed=False):
+def bt_jmpbuf(jmpbuf, is_coredump, detailed=False):
     '''Backtrace a jmpbuf'''
     regs = get_jmpbuf_regs(jmpbuf)
-    try:
+    if not is_coredump:
         # This reuses gdb's "bt" command, which can be slightly prettier
         # but only works with live sessions.
         dump_backtrace_live(regs)
-    except:
-        if detailed:
-            # Obtain detailed trace by patching regs in copied coredump
-            dump_backtrace_patched(regs)
-        else:
-            # If above doesn't work, fallback to poor man's unwind
-            dump_backtrace(regs)
+    elif detailed:
+        # Obtain detailed trace by patching regs in copied coredump
+        dump_backtrace_patched(regs)
+    else:
+        # Obtain a non-detailed trace by poor man's unwind
+        dump_backtrace(regs)
 
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
@@ -353,7 +352,7 @@ def invoke(self, arg, from_tty):
 
         try:
             bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
-                      detailed=detailed)
+                      is_coredump, detailed=detailed)
         finally:
             coredump.restore_regs()
 
@@ -390,10 +389,10 @@ def invoke(self, arg, from_tty):
 
         gdb.execute("bt")
 
-        try:
+        if not is_coredump:
             # This only works with a live session
             co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
-        except:
+        else:
             # Fallback to use hard-coded ucontext vars if it's coredump
             co_ptr = gdb.parse_and_eval("co_tls_current")
 
@@ -407,7 +406,8 @@ def invoke(self, arg, from_tty):
                 if co_ptr == 0:
                     break
                 gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
-                bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
+                bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
+                          detailed=detailed)
         finally:
             coredump.restore_regs()
 
-- 
2.56.0


