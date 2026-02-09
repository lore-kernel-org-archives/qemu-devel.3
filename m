Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC64E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWs-0007GG-CM; Mon, 09 Feb 2026 09:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSW0-00072g-4A
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVx-0005jL-He
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GPYTbIijqvYuqXnn3XuXd7bbQuY3nUYJe0SRBL25F8=;
 b=eZLrLLt/SD33zNZOnNrCqmzRheetZ043WzsqFrDw6R3ku80ZWU4oY2/HL8CZ2cFhiRNJlr
 L9dkGx5PziPmbUohjuUty4qImR+Kh6PavMkXlwht73vLrKkF6M+RBgVcEQgTCcCy1xOpoH
 FMiREJ5kX/cVSewpv/PZHhDBFP1FEeY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-2bkRSxdBNoaUKsjwYWSt4g-1; Mon,
 09 Feb 2026 09:45:21 -0500
X-MC-Unique: 2bkRSxdBNoaUKsjwYWSt4g-1
X-Mimecast-MFC-AGG-ID: 2bkRSxdBNoaUKsjwYWSt4g_1770648319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10DA719560B3; Mon,  9 Feb 2026 14:45:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBAF418004BB; Mon,  9 Feb 2026 14:45:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkrempa@redhat.com, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 4/9] scripts/qemugdb: coroutine: Add option for obtaining
 detailed trace in coredump
Date: Mon,  9 Feb 2026 09:45:02 -0500
Message-ID: <20260209144508.45268-5-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
References: <20260209144508.45268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 772f86839f ("scripts/qemu-gdb: Support coroutine dumps in
coredumps") introduced coroutine traces in coredumps using raw stack
unwinding.  While this works, this approach does not allow to view the
function arguments in the corresponding stack frames.

As an alternative, we can obtain saved registers from the coroutine's
jmpbuf, patch them into the coredump's struct elf_prstatus in place, and
execute another gdb subprocess to get backtrace from the patched temporary
coredump.

While providing more detailed info, this alternative approach, however, is
more invasive as it might potentially corrupt the coredump file. We do take
precautions by saving the original registers values into a separate binary
blob /path/to/coredump.ptregs, so that it can be restores in the next
GDB session.  Still, instead of making it a new deault, let's keep raw unwind
the default behaviour, but add the '--detailed' option for 'qemu bt' and
'qemu coroutine' command which would enforce the new behaviour.

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20251204105019.455060-5-andrey.drobyshev@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/coroutine.py | 257 +++++++++++++++++++++++++++++++++--
 1 file changed, 242 insertions(+), 15 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index e98fc48a4b..29f57ae84e 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -9,10 +9,119 @@
 # This work is licensed under the terms of the GNU GPL, version 2
 # or later.  See the COPYING file in the top-level directory.
 
+import atexit
 import gdb
+import os
+import pty
+import re
+import struct
+import textwrap
+
+from collections import OrderedDict
+from copy import deepcopy
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
+# Registers in the same order they're present in ELF coredump file.
+# See asm/ptrace.h
+PT_REGS = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10', 'r9',
+           'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax', 'rip', 'cs',
+           'eflags', 'rsp', 'ss']
+
+coredump = None
+
+
+class Coredump:
+    _ptregs_suff = '.ptregs'
+
+    def __init__(self, coredump, executable):
+        atexit.register(self._cleanup)
+
+        self.coredump = coredump
+        self.executable = executable
+        self._ptregs_blob = coredump + self._ptregs_suff
+        self._dirty = False
+
+        with open(coredump, 'rb') as f:
+            while f.read(4) != b'CORE':
+                pass
+            gdb.write(f'core file {coredump}: found "CORE" at 0x{f.tell():x}\n')
+
+            # Looking for struct elf_prstatus and pr_reg field in it (an array
+            # of general purpose registers).  See sys/procfs.h.
+
+            # lseek(f.fileno(), 4, SEEK_CUR): go to elf_prstatus
+            f.seek(4, 1)
+
+            # lseek(f.fileno(), 112, SEEK_CUR):
+            # offsetof(struct elf_prstatus, pr_reg)
+            f.seek(112, 1)
+
+            self._ptregs_offset = f.tell()
+
+            # If binary blob with the name /path/to/coredump + '.ptregs'
+            # exists, that means proper cleanup didn't happen during previous
+            # GDB session with the same coredump, and registers in the dump
+            # itself might've remained patched.  Thus we restore original
+            # registers values from this blob
+            if os.path.exists(self._ptregs_blob):
+                with open(self._ptregs_blob, 'rb') as b:
+                    orig_ptregs_bytes = b.read()
+                self._dirty = True
+            else:
+                orig_ptregs_bytes = f.read(len(PT_REGS) * 8)
+
+            values = struct.unpack(f"={len(PT_REGS)}q", orig_ptregs_bytes)
+            self._orig_ptregs = OrderedDict(zip(PT_REGS, values))
+
+            if not os.path.exists(self._ptregs_blob):
+                gdb.write(f'saving original pt_regs in {self._ptregs_blob}\n')
+                with open(self._ptregs_blob, 'wb') as b:
+                    b.write(orig_ptregs_bytes)
+
+        gdb.write('\n')
+
+    def patch_regs(self, regs):
+        # Set dirty flag early on to make sure regs are restored upon cleanup
+        self._dirty = True
+
+        gdb.write(f'patching core file {self.coredump}\n')
+        patched_ptregs = deepcopy(self._orig_ptregs)
+        int_regs = {k: int(v) for k, v in regs.items()}
+        patched_ptregs.update(int_regs)
+
+        with open(self.coredump, 'ab') as f:
+            gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
+            f.seek(self._ptregs_offset, 0)
+            gdb.write('writing regs:\n')
+            for reg in self._orig_ptregs.keys():
+                if reg in int_regs:
+                    gdb.write(f"  {reg}: {int_regs[reg]:#16x}\n")
+            f.write(struct.pack(f"={len(PT_REGS)}q", *patched_ptregs.values()))
+
+        gdb.write('\n')
+
+    def restore_regs(self):
+        if not self._dirty:
+            return
+
+        gdb.write(f'\nrestoring original regs in core file {self.coredump}\n')
+        with open(self.coredump, 'ab') as f:
+            gdb.write(f'assume pt_regs at 0x{self._ptregs_offset:x}\n')
+            f.seek(self._ptregs_offset, 0)
+            f.write(struct.pack(f"={len(PT_REGS)}q",
+                                *self._orig_ptregs.values()))
+
+        self._dirty = False
+        gdb.write('\n')
+
+    def _cleanup(self):
+        if os.path.exists(self._ptregs_blob):
+            self.restore_regs()
+            gdb.write(f'\nremoving saved pt_regs file {self._ptregs_blob}\n')
+            os.unlink(self._ptregs_blob)
+
+
 def pthread_self():
     '''Fetch the base address of TLS.'''
     return gdb.parse_and_eval("$fs_base")
@@ -77,6 +186,55 @@ def symbol_lookup(addr):
 
     return f"{func_str} at {path}:{line}"
 
+def run_with_pty(cmd):
+    # Create a PTY pair
+    master_fd, slave_fd = pty.openpty()
+
+    pid = os.fork()
+    if pid == 0:  # Child
+        os.close(master_fd)
+        # Attach stdin/stdout/stderr to the PTY slave side
+        os.dup2(slave_fd, 0)
+        os.dup2(slave_fd, 1)
+        os.dup2(slave_fd, 2)
+        os.close(slave_fd)
+        os.execvp("gdb", cmd) # Runs gdb and doesn't return
+
+    # Parent
+    os.close(slave_fd)
+
+    output = bytearray()
+    try:
+        while True:
+            data = os.read(master_fd, 65536)
+            if not data:
+                break
+            output.extend(data)
+    except OSError: # in case subprocess exits and we get EBADF on read()
+        pass
+    finally:
+        try:
+            os.close(master_fd)
+        except OSError: # in case we get EBADF on close()
+            pass
+
+    # Wait for child to finish (reap zombie)
+    os.waitpid(pid, 0)
+
+    return output.decode('utf-8')
+
+def dump_backtrace_patched(regs):
+    cmd = ['gdb', '-batch',
+           '-ex', 'set debuginfod enabled off',
+           '-ex', 'set complaints 0',
+           '-ex', 'set style enabled on',
+           '-ex', 'python print("----split----")',
+           '-ex', 'bt', coredump.executable, coredump.coredump]
+
+    coredump.patch_regs(regs)
+    out = run_with_pty(cmd).split('----split----')[1]
+    gdb.write(out)
+
 def dump_backtrace(regs):
     '''
     Backtrace dump with raw registers, mimic GDB command 'bt'.
@@ -120,7 +278,7 @@ def dump_backtrace_live(regs):
 
     selected_frame.select()
 
-def bt_jmpbuf(jmpbuf):
+def bt_jmpbuf(jmpbuf, detailed=False):
     '''Backtrace a jmpbuf'''
     regs = get_jmpbuf_regs(jmpbuf)
     try:
@@ -128,8 +286,12 @@ def bt_jmpbuf(jmpbuf):
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
@@ -138,28 +300,90 @@ def coroutine_to_jmpbuf(co):
     coroutine_pointer = co_cast(co)
     return coroutine_pointer['env']['__jmpbuf']
 
+def init_coredump():
+    global coredump
+
+    files = gdb.execute('info files', False, True).split('\n')
+
+    if not 'core dump' in files[1]:
+        return False
+
+    core_path = re.search("`(.*)'", files[2]).group(1)
+    exec_path = re.match('^Symbols from "(.*)".$', files[0]).group(1)
+
+    if coredump is None:
+        coredump = Coredump(core_path, exec_path)
+
+    return True
 
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
+        argc = len(argv)
+        if argc == 0 or argc > 2 or (argc == 2 and argv[1] != '--detailed'):
+            return self._usage()
+        detailed = True if argc == 2 else False
+
+        is_coredump = init_coredump()
+        if detailed and not is_coredump:
+            gdb.write('--detailed is only valid when debugging core dumps\n')
             return
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        try:
+            bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])),
+                      detailed=detailed)
+        finally:
+            coredump.restore_regs()
 
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
+
+        is_coredump = init_coredump()
+        if detailed and not is_coredump:
+            gdb.write('--detailed is only valid when debugging core dumps\n')
+            return
 
         gdb.execute("bt")
 
@@ -173,13 +397,16 @@ def invoke(self, arg, from_tty):
         if co_ptr == False:
             return
 
-        while True:
-            co = co_cast(co_ptr)
-            co_ptr = co["base"]["caller"]
-            if co_ptr == 0:
-                break
-            gdb.write("Coroutine at " + str(co_ptr) + ":\n")
-            bt_jmpbuf(coroutine_to_jmpbuf(co_ptr))
+        try:
+            while True:
+                co = co_cast(co_ptr)
+                co_ptr = co["base"]["caller"]
+                if co_ptr == 0:
+                    break
+                gdb.write("\nCoroutine at " + str(co_ptr) + ":\n")
+                bt_jmpbuf(coroutine_to_jmpbuf(co_ptr), detailed=detailed)
+        finally:
+            coredump.restore_regs()
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
-- 
2.52.0


