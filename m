Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24811D0E6EE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtw0-0007WX-97; Tue, 25 Nov 2025 09:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtuu-0007FI-At
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:29 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtun-0002Gr-IA
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=0ZzIpETCotko6Mfd/iA6fKVr3/KJRE0ECF6tAW/S2/E=; b=SniEUf6/J/tZ
 KZIgENN2FC24uqzTjfHLhjYtd9pAFvVeBWDcb3PWHOidQdT5rKw1IQ0J0cjf5jEkrVZZFOmhmZn1J
 +iUlLg/jUggLXaVMbEo+9t/cjNOknXmOjr4QVaP9EoO5Z2iWEOXDep/2KEJGcCYv4ltNSLm0eOmGh
 VWV1tMrMqwKBO9ENtKlH5Jf+QUxUdaUQZ3v3yNPR+d5T4y6QUKiBfwb0Op2BTRE8vlFSpV5YzYhlT
 wmPxqUktnHJapTTSPKVeYQBMnP++6Ho8CRoVCWJCD4lLo2a1zN9jXZ+3wSnxKT3jehv9al3TgrYmw
 uRlp9d9s1dk+kjPnFoSBSA==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vNtsz-003IJo-0j;
 Tue, 25 Nov 2025 15:20:56 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 4/4] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Date: Tue, 25 Nov 2025 16:21:05 +0200
Message-ID: <20251125142105.448289-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
References: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
coredumps") introduced coroutine traces in coredumps using raw stack
unwinding.  While this works, this approach does not allow to view the
function arguments in the corresponding stack frames.

As an alternative, we can obtain saved registers from the coroutine's
jmpbuf, copy the original coredump file into a temporary file, patch the
saved registers into the tmp coredump's struct elf_prstatus and execute
another gdb subprocess to get backtrace from the patched temporary coredump.

While providing more detailed info, this alternative approach, however, is
quite heavyweight as it takes significantly more time and disk space.
So, instead of making it a new default, let's keep raw unwind the default
behaviour, but add the '--detailed' option for 'qemu bt' and 'qemu coroutine'
command which would enforce the new behaviour.

That's how this looks:

  (gdb) qemu coroutine 0x7fda9335a508
  #0  0x5602bdb41c26 in qemu_coroutine_switch<+214> () at ../util/coroutine-ucontext.c:321
  #1  0x5602bdb3e8fe in qemu_aio_coroutine_enter<+493> () at ../util/qemu-coroutine.c:293
  #2  0x5602bdb3c4eb in co_schedule_bh_cb<+538> () at ../util/async.c:547
  #3  0x5602bdb3b518 in aio_bh_call<+119> () at ../util/async.c:172
  #4  0x5602bdb3b79a in aio_bh_poll<+457> () at ../util/async.c:219
  #5  0x5602bdb10f22 in aio_poll<+1201> () at ../util/aio-posix.c:719
  #6  0x5602bd8fb1ac in iothread_run<+123> () at ../iothread.c:63
  #7  0x5602bdb18a24 in qemu_thread_start<+355> () at ../util/qemu-thread-posix.c:393

  (gdb) qemu coroutine 0x7fda9335a508 --detailed
  patching core file /tmp/tmpq4hmk2qc
  found "CORE" at 0x10c48
  assume pt_regs at 0x10cbc
  write r15 at 0x10cbc
  write r14 at 0x10cc4
  write r13 at 0x10ccc
  write r12 at 0x10cd4
  write rbp at 0x10cdc
  write rbx at 0x10ce4
  write rip at 0x10d3c
  write rsp at 0x10d54

  #0  0x00005602bdb41c26 in qemu_coroutine_switch (from_=0x7fda9335a508, to_=0x7fda8400c280, action=COROUTINE_ENTER) at ../util/coroutine-ucontext.c:321
  #1  0x00005602bdb3e8fe in qemu_aio_coroutine_enter (ctx=0x5602bf7147c0, co=0x7fda8400c280) at ../util/qemu-coroutine.c:293
  #2  0x00005602bdb3c4eb in co_schedule_bh_cb (opaque=0x5602bf7147c0) at ../util/async.c:547
  #3  0x00005602bdb3b518 in aio_bh_call (bh=0x5602bf714a40) at ../util/async.c:172
  #4  0x00005602bdb3b79a in aio_bh_poll (ctx=0x5602bf7147c0) at ../util/async.c:219
  #5  0x00005602bdb10f22 in aio_poll (ctx=0x5602bf7147c0, blocking=true) at ../util/aio-posix.c:719
  #6  0x00005602bd8fb1ac in iothread_run (opaque=0x5602bf42b100) at ../iothread.c:63
  #7  0x00005602bdb18a24 in qemu_thread_start (args=0x5602bf7164a0) at ../util/qemu-thread-posix.c:393
  #8  0x00007fda9e89f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
  #9  0x00007fda9e83f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Peter Xu <peterx@redhat.com>
Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 11 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index e98fc48a4b..b1c7f96af5 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -10,6 +10,13 @@
 # or later.  See the COPYING file in the top-level directory.
 
 import gdb
+import os
+import re
+import struct
+import shutil
+import subprocess
+import tempfile
+import textwrap
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
@@ -77,6 +84,65 @@ def symbol_lookup(addr):
 
     return f"{func_str} at {path}:{line}"
 
+def write_regs_to_coredump(corefile, set_regs):
+    # asm/ptrace.h
+    pt_regs = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10',
+               'r9', 'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax',
+               'rip', 'cs', 'eflags', 'rsp', 'ss']
+
+    with open(corefile, 'r+b') as f:
+        gdb.write(f'patching core file {corefile}\n')
+
+        while f.read(4) != b'CORE':
+            pass
+        gdb.write(f'found "CORE" at 0x{f.tell():x}\n')
+
+        # Looking for struct elf_prstatus and pr_reg field in it (an array
+        # of general purpose registers).  See sys/procfs.h
+
+        # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
+        f.seek(4, 1)
+        # lseek(f.fileno(), 112, SEEK_CUR): offsetof(struct elf_prstatus, pr_reg)
+        f.seek(112, 1)
+
+        gdb.write(f'assume pt_regs at 0x{f.tell():x}\n')
+        for reg in pt_regs:
+            if reg in set_regs:
+                gdb.write(f'write {reg} at 0x{f.tell():x}\n')
+                f.write(struct.pack('q', set_regs[reg]))
+            else:
+                # lseek(f.fileno(), 8, SEEK_CUR): go to the next reg
+                f.seek(8, 1)
+
+def clone_coredump(source, target, set_regs):
+    shutil.copyfile(source, target)
+    write_regs_to_coredump(target, set_regs)
+
+def dump_backtrace_patched(regs):
+    files = gdb.execute('info files', False, True).split('\n')
+    executable = re.match('^Symbols from "(.*)".$', files[0]).group(1)
+    dump = re.search("`(.*)'", files[2]).group(1)
+
+    with tempfile.NamedTemporaryFile(dir='/tmp', delete=False) as f:
+        tmpcore = f.name
+
+    clone_coredump(dump, tmpcore, regs)
+
+    cmd = ['script', '-qec',
+           'gdb -batch ' +
+           '-ex "set complaints 0" ' +
+           '-ex "set verbose off" ' +
+           '-ex "set style enabled on" ' +
+           '-ex "python print(\'----split----\')" ' +
+           f'-ex bt {executable} {tmpcore}',
+           '/dev/null']
+    out = subprocess.check_output(cmd, stderr=subprocess.DEVNULL)
+    out = out.split(b'----split----')[1].decode('utf-8')
+
+    os.remove(tmpcore)
+
+    gdb.write(out)
+
 def dump_backtrace(regs):
     '''
     Backtrace dump with raw registers, mimic GDB command 'bt'.
@@ -120,7 +186,7 @@ def dump_backtrace_live(regs):
 
     selected_frame.select()
 
-def bt_jmpbuf(jmpbuf):
+def bt_jmpbuf(jmpbuf, detailed=False):
     '''Backtrace a jmpbuf'''
     regs = get_jmpbuf_regs(jmpbuf)
     try:
@@ -128,8 +194,12 @@ def bt_jmpbuf(jmpbuf):
         # but only works with live sessions.
         dump_backtrace_live(regs)
     except:
-        # If above doesn't work, fallback to poor man's unwind
-        dump_backtrace(regs)
+        if detailed:
+            # Obtain detailed trace by patching regs in copied coredump
+            dump_backtrace_patched(regs)
+        else:
+            # If above doesn't work, fallback to poor man's unwind
+            dump_backtrace(regs)
 
 def co_cast(co):
     return co.cast(gdb.lookup_type('CoroutineUContext').pointer())
@@ -140,26 +210,60 @@ def coroutine_to_jmpbuf(co):
 
 
 class CoroutineCommand(gdb.Command):
-    '''Display coroutine backtrace'''
+    __doc__ = textwrap.dedent("""\
+        Display coroutine backtrace
+
+        Usage: qemu coroutine COROPTR [--detailed]
+        Show backtrace for a coroutine specified by COROPTR
+
+          --detailed       obtain detailed trace by copying coredump, patching
+                           regs in it, and runing gdb subprocess to get
+                           backtrace from the patched coredump
+        """)
+
     def __init__(self):
         gdb.Command.__init__(self, 'qemu coroutine', gdb.COMMAND_DATA,
                              gdb.COMPLETE_NONE)
 
+    def _usage(self):
+        gdb.write('usage: qemu coroutine <coroutine-pointer> [--detailed]\n')
+        return
+
     def invoke(self, arg, from_tty):
         argv = gdb.string_to_argv(arg)
-        if len(argv) != 1:
-            gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
-            return
+        argc = len(argv)
+        if argc == 0 or argc > 2 or (argc == 2 and argv[1] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 2 else False
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
+                  detailed=detailed)
 
 class CoroutineBt(gdb.Command):
-    '''Display backtrace including coroutine switches'''
+    __doc__ = textwrap.dedent("""\
+        Display backtrace including coroutine switches
+
+        Usage: qemu bt [--detailed]
+
+          --detailed       obtain detailed trace by copying coredump, patching
+                           regs in it, and runing gdb subprocess to get
+                           backtrace from the patched coredump
+        """)
+
     def __init__(self):
         gdb.Command.__init__(self, 'qemu bt', gdb.COMMAND_STACK,
                              gdb.COMPLETE_NONE)
 
+    def _usage(self):
+        gdb.write('usage: qemu bt [--detailed]\n')
+        return
+
     def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        argc = len(argv)
+        if argc > 1 or (argc == 1 and argv[0] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 1 else False
 
         gdb.execute("bt")
 
@@ -178,8 +282,8 @@ def invoke(self, arg, from_tty):
             co_ptr = co["base"]["caller"]
             if co_ptr == 0:
                 break
-            gdb.write("Coroutine at " + str(co_ptr) + ":\n")
-            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr))
+            gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
+            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.43.5


