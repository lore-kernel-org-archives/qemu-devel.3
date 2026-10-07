Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1584CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbm-0003Dy-Vr; Wed, 07 Oct 2026 12:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbC-0002ut-BF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbA-0006Kc-MF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUteue5Un51UDIxofue71q//2Bedj8A8FBOCUP1ApvY=;
 b=OH0dqsqF/oZUN4CfWy5PW52s+XSwtq1G7sYoFKb/WHR92O2pmJ7WD4/27ku3J9zsEwYq+A
 hoE4zWa4mCIupJYoGpYBPFOLuIHf6xS7ict1lW7pDrw+8D9iRmUgSK2yueQ6G81KQLKbir
 46U3bAVH49ROCxr6HSLab2Y7kvZPQVw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-6Bpx_TiCMpmxquIVvvr4AQ-1; Wed,
 07 Oct 2026 12:34:28 -0400
X-MC-Unique: 6Bpx_TiCMpmxquIVvvr4AQ-1
X-Mimecast-MFC-AGG-ID: 6Bpx_TiCMpmxquIVvvr4AQ_1791390867
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15B01800867; Wed,  7 Oct 2026 16:34:27 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 718F91956087; Wed,  7 Oct 2026 16:34:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/21] scripts/qemugdb: coroutine: Don't unwind past the
 outermost frame
Date: Wed,  7 Oct 2026 18:32:49 +0200
Message-ID: <20261007163302.332250-9-kwolf@redhat.com>
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

dump_backtrace() walks the frame pointer chain until rbp is NULL.
However, when glibc is built with no frame pointers, rbp is never NULL
during unwind.  Instead, we see garbage in the outermost frame.  This
results into:

  #17  0x5610b6e9f2d9 in main<+1720> () at ../qemu-io.c:674
  #18  0x7f26cc10230e in __libc_start_call_main<+125> () at
      ../sysdeps/nptl/libc_start_call_main.h:58
  Traceback (most recent call last):
    File "/.../scripts/qemugdb/coroutine.py", line 409, in invoke
      bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), is_coredump,
    File "/.../scripts/qemugdb/coroutine.py", line 296, in bt_jmpbuf
      dump_backtrace(regs)
    File "/.../scripts/qemugdb/coroutine.py", line 247, in dump_backtrace
      while rbp:
            ^^^
  gdb.MemoryError: Cannot access memory at address 0x4
  Error occurred in Python: Cannot access memory at address 0x4

As a fix, stop on the first link that can't be read.  Since
gdb.parse_and_eval() returns a lazy value, force the actual memory read
by wrapping it in int() and immediately catching potential gdb.MemoryError.

Fixes: 772f86839f77 ("scripts/qemu-gdb: Support coroutine dumps in coredumps")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20260804151743.937694-5-andrey.drobyshev@virtuozzo.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qemugdb/coroutine.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 649579378db..da395a1a13e 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -235,13 +235,24 @@ def dump_backtrace_patched(regs):
     out = run_with_pty(cmd).split('----split----')[1]
     gdb.write(out)
 
+def read_word(addr):
+    '''
+    Read a 64-bit word, None if that memory isn't accessible.
+    '''
+    try:
+        # gdb.parse_and_eval() returns lazy values.  Force memory access
+        # by wrapping in int()
+        return int(gdb.parse_and_eval(f"*(uint64_t *){hex(addr)}"))
+    except gdb.MemoryError:
+        return None
+
 def dump_backtrace(regs):
     '''
     Backtrace dump with raw registers, mimic GDB command 'bt'.
     '''
     # Here only rbp and rip that matter..
-    rbp = regs['rbp']
-    rip = regs['rip']
+    rbp = int(regs['rbp'])
+    rip = int(regs['rip'])
     i = 0
 
     while rbp:
@@ -250,8 +261,14 @@ def dump_backtrace(regs):
         # instruction instead of the CALL.  Here -1 would work for any
         # sized CALL instruction.
         print(f"#{i}  {hex(rip)} in {symbol_lookup(rip if i == 0 else rip-1)}")
-        rip = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)} + 8)")
-        rbp = gdb.parse_and_eval(f"*(uint64_t *)(uint64_t)({hex(rbp)})")
+
+        # The 'rbp != NULL' condition is insufficient: the outermost glibc
+        # frames might leave garbage in rbp if built without frame pointers.
+        # Break the loop on the frame that leads nowhere.
+        rip, rbp = read_word(rbp + 8), read_word(rbp)
+        if rip is None or rbp is None:
+            break
+
         i += 1
 
 def dump_backtrace_live(regs):
-- 
2.56.0


