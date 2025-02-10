Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16494C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNb-0006cJ-Tb; Mon, 10 Feb 2025 11:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNP-0006Tv-Dv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNM-000115-T8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ex/ScBFVhhdirMLgu2m8pUq9UxLmECAJPY5+Do7m9JY=;
 b=AYtFeodqVFTsRFcwJHaOfMV54JVjaRQPhPf8ZipESSI9Nqd1TLDsQr8k8ldpV8MkaUWkc6
 cJ65y8E5qeCN06ZT8UwYAMtOE3Hp2x+OW48hXGquFLzHnnH9mKFVk6rdWgfv7CCmh0Za0b
 K0LY8fO2/SZyYMRgBPPBJwhdtavOS/k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-ts91LHQpMBO4xH-gxCTsww-1; Mon,
 10 Feb 2025 11:11:05 -0500
X-MC-Unique: ts91LHQpMBO4xH-gxCTsww-1
X-Mimecast-MFC-AGG-ID: ts91LHQpMBO4xH-gxCTsww
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E63C19560A0; Mon, 10 Feb 2025 16:11:04 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 490AF1956048; Mon, 10 Feb 2025 16:11:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/25] scripts/qemu-gdb: Support coroutine dumps in coredumps
Date: Mon, 10 Feb 2025 17:10:16 +0100
Message-ID: <20250210161034.76494-8-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Dumping coroutines don't yet work with coredumps.  Let's make it work.

We still kept most of the old code because they can be either more
flexible, or prettier.  Only add the fallbacks when they stop working.

Currently the raw unwind is pretty ugly, but it works, like this:

  (gdb) qemu bt
  #0  process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:788
  #1  0x000055ae6c0dc4d9 in coroutine_trampoline (i0=-1711718576, i1=21934) at ../util/coroutine-ucontext.c:175
  #2  0x00007f9f59d72f40 in ??? () at /lib64/libc.so.6
  #3  0x00007ffd549214a0 in ??? ()
  #4  0x0000000000000000 in ??? ()
  Coroutine at 0x7f9f4c57c748:
  #0  0x55ae6c0dc9a8 in qemu_coroutine_switch<+120> () at ../util/coroutine-ucontext.c:321
  #1  0x55ae6c0da2f8 in qemu_aio_coroutine_enter<+356> () at ../util/qemu-coroutine.c:293
  #2  0x55ae6c0da3f1 in qemu_coroutine_enter<+34> () at ../util/qemu-coroutine.c:316
  #3  0x55ae6baf775e in migration_incoming_process<+43> () at ../migration/migration.c:876
  #4  0x55ae6baf7ab4 in migration_ioc_process_incoming<+490> () at ../migration/migration.c:1008
  #5  0x55ae6bae9ae7 in migration_channel_process_incoming<+145> () at ../migration/channel.c:45
  #6  0x55ae6bb18e35 in socket_accept_incoming_migration<+118> () at ../migration/socket.c:132
  #7  0x55ae6be939ef in qio_net_listener_channel_func<+131> () at ../io/net-listener.c:54
  #8  0x55ae6be8ce1a in qio_channel_fd_source_dispatch<+78> () at ../io/channel-watch.c:84
  #9  0x7f9f5b26728c in g_main_context_dispatch_unlocked.lto_priv<+315> ()
  #10  0x7f9f5b267555 in g_main_context_dispatch<+36> ()
  #11  0x55ae6c0d91a7 in glib_pollfds_poll<+90> () at ../util/main-loop.c:287
  #12  0x55ae6c0d9235 in os_host_main_loop_wait<+128> () at ../util/main-loop.c:310
  #13  0x55ae6c0d9364 in main_loop_wait<+203> () at ../util/main-loop.c:589
  #14  0x55ae6bac212a in qemu_main_loop<+41> () at ../system/runstate.c:835
  #15  0x55ae6bfdf522 in qemu_default_main<+19> () at ../system/main.c:37
  #16  0x55ae6bfdf55f in main<+40> () at ../system/main.c:48
  #17  0x7f9f59d42248 in __libc_start_call_main<+119> ()
  #18  0x7f9f59d4230b in __libc_start_main_impl<+138> ()

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241212204801.1420528-4-peterx@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 79 +++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 20f76ed37b..e98fc48a4b 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -46,9 +46,60 @@ def get_jmpbuf_regs(jmpbuf):
         'r15': jmpbuf[JB_R15],
         'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
 
-def bt_jmpbuf(jmpbuf):
-    '''Backtrace a jmpbuf'''
-    regs = get_jmpbuf_regs(jmpbuf)
+def symbol_lookup(addr):
+    # Example: "__clone3 + 44 in section .text of /lib64/libc.so.6"
+    result = gdb.execute(f"info symbol {hex(addr)}", to_string=True).strip()
+    try:
+        if "+" in result:
+            (func, result) = result.split(" + ")
+            (offset, result) = result.split(" in ")
+        else:
+            offset = "0"
+            (func, result) = result.split(" in ")
+        func_str = f"{func}<+{offset}> ()"
+    except:
+        return f"??? ({result})"
+
+    # Example: Line 321 of "../util/coroutine-ucontext.c" starts at address
+    # 0x55cf3894d993 <qemu_coroutine_switch+99> and ends at 0x55cf3894d9ab
+    # <qemu_coroutine_switch+123>.
+    result = gdb.execute(f"info line *{hex(addr)}", to_string=True).strip()
+    if not result.startswith("Line "):
+        return func_str
+    result = result[5:]
+
+    try:
+        result = result.split(" starts ")[0]
+        (line, path) = result.split(" of ")
+        path = path.replace("\"", "")
+    except:
+        return func_str
+
+    return f"{func_str} at {path}:{line}"
+
+def dump_backtrace(regs):
+    '''
+    Backtrace dump with raw registers, mimic GDB command 'bt'.
+    '''
+    # Here only rbp and rip that matter..
+    rbp = regs['rbp']
+    rip = regs['rip']
+    i = 0
+
+    while rbp:
+        # For all return addresses on stack, we want to look up symbol/line
+        # on the CALL command, because the return address is the next
+        # instruction instead of the CALL.  Here -1 would work for any
+        # sized CALL instruction.
+        print(f"#{i}  {hex(rip)} in {symbol_lookup(rip if i == 0 else rip-1)}")
+        rip = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)} + 8)")
+        rbp = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)})")
+        i += 1
+
+def dump_backtrace_live(regs):
+    '''
+    Backtrace dump with gdb's 'bt' command, only usable in a live session.
+    '''
     old = dict()
 
     # remember current stack frame and select the topmost
@@ -69,6 +120,17 @@ def bt_jmpbuf(jmpbuf):
 
     selected_frame.select()
 
+def bt_jmpbuf(jmpbuf):
+    '''Backtrace a jmpbuf'''
+    regs = get_jmpbuf_regs(jmpbuf)
+    try:
+        # This reuses gdb's "bt" command, which can be slightly prettier
+        # but only works with live sessions.
+        dump_backtrace_live(regs)
+    except:
+        # If above doesn't work, fallback to poor man's unwind
+        dump_backtrace(regs)
+
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
 
@@ -101,10 +163,15 @@ def invoke(self, arg, from_tty):
 
         gdb.execute("bt")
 
-        if gdb.parse_and_eval("qemu_in_coroutine()") == False:
-            return
+        try:
+            # This only works with a live session
+            co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
+        except:
+            # Fallback to use hard-coded ucontext vars if it's coredump
+            co_ptr = gdb.parse_and_eval("co_tls_current")
 
-        co_ptr = gdb.parse_and_eval("qemu_coroutine_self()")
+        if co_ptr == False:
+            return
 
         while True:
             co = co_cast(co_ptr)
-- 
2.48.1


