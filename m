Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF73BCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8Ph-0004YI-FJ; Fri, 12 Sep 2025 14:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8Pe-0004X5-GW
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8Pb-0005Hu-S1
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757701339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9PIrwR8q/fff+NsbcIl3VpywrA9+n/btYb7Q5rBJ1I=;
 b=MZFCMiV2u2XlaDMGtUSznuJJaWV7IQV4rNBbh4bJ1+KYt8GSs624KRCveh/7yQ4Q+tEo2I
 sQxvJy9NJy4H+PRdB4TI4RbsM9TWr+bH/YvIHFJUhn+OC8HEYwV/GxEJ7WtNr8O1LsgJ25
 +XY4b9nBipt+GOLBFkGo0f8blHQ1rLs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-0N50121DPxyi5d9sCNfSng-1; Fri,
 12 Sep 2025 14:22:17 -0400
X-MC-Unique: 0N50121DPxyi5d9sCNfSng-1
X-Mimecast-MFC-AGG-ID: 0N50121DPxyi5d9sCNfSng_1757701336
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E041800288
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 18:22:16 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 342041800446; Fri, 12 Sep 2025 18:22:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/6] tests/functional: use self.log for all logging
Date: Fri, 12 Sep 2025 19:22:00 +0100
Message-ID: <20250912182200.643909-7-berrange@redhat.com>
In-Reply-To: <20250912182200.643909-1-berrange@redhat.com>
References: <20250912182200.643909-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some tests are creating their on logger category which means any
output they log is not captured in base.log.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/aarch64/test_virt.py     |  4 +--
 tests/functional/arm/test_integratorcp.py |  3 +-
 tests/functional/mips64el/test_malta.py   |  3 +-
 tests/functional/replay_kernel.py         | 16 ++++-----
 tests/functional/reverse_debugging.py     | 41 +++++++++++------------
 tests/functional/x86_64/test_acpi_bits.py | 31 +++++++++--------
 6 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/tests/functional/aarch64/test_virt.py b/tests/functional/aarch64/test_virt.py
index 4d0ad90ff8..63071f9b51 100755
--- a/tests/functional/aarch64/test_virt.py
+++ b/tests/functional/aarch64/test_virt.py
@@ -72,8 +72,6 @@ def common_aarch64_virt(self, machine):
         self.set_machine('virt')
         self.require_accelerator("tcg")
 
-        logger = logging.getLogger('aarch64_virt')
-
         kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console()
@@ -91,7 +89,7 @@ def common_aarch64_virt(self, machine):
                          'rng-random,id=rng0,filename=/dev/urandom')
 
         # Also add a scratch block device
-        logger.info('creating scratch qcow2 image')
+        self.log.info('creating scratch qcow2 image')
         image_path = self.scratch_file('scratch.qcow2')
         qemu_img = get_qemu_img(self)
         check_call([qemu_img, 'create', '-f', 'qcow2', image_path, '8M'],
diff --git a/tests/functional/arm/test_integratorcp.py b/tests/functional/arm/test_integratorcp.py
index 4f00924aa0..23ae919359 100755
--- a/tests/functional/arm/test_integratorcp.py
+++ b/tests/functional/arm/test_integratorcp.py
@@ -77,7 +77,6 @@ def test_framebuffer_tux_logo(self):
                           command_line='screendump %s' % screendump_path)
         if 'unknown command' in res:
             self.skipTest('screendump not available')
-        logger = logging.getLogger('framebuffer')
 
         cpu_count = 1
         match_threshold = 0.92
@@ -88,7 +87,7 @@ def test_framebuffer_tux_logo(self):
         loc = np.where(result >= match_threshold)
         tux_count = 0
         for tux_count, pt in enumerate(zip(*loc[::-1]), start=1):
-            logger.debug('found Tux at position [x, y] = %s', pt)
+            self.log.debug('found Tux at position [x, y] = %s', pt)
         self.assertGreaterEqual(tux_count, cpu_count)
 
 if __name__ == '__main__':
diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index 8fdc49b300..170147bfcc 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -159,7 +159,6 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
                           command_line='screendump %s' % screendump_path)
         if 'unknown command' in res:
             self.skipTest('screendump not available')
-        logger = logging.getLogger('framebuffer')
 
         match_threshold = 0.95
         screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
@@ -171,7 +170,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         h, w = tuxlogo_bgr.shape[:2]
         debug_png = os.getenv('QEMU_TEST_CV2_SCREENDUMP_PNG_PATH')
         for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
-            logger.debug('found Tux at position (x, y) = %s', pt)
+            self.log.debug('found Tux at position (x, y) = %s', pt)
             cv2.rectangle(screendump_bgr, pt,
                           (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
         if debug_png:
diff --git a/tests/functional/replay_kernel.py b/tests/functional/replay_kernel.py
index 80795eb052..acb1d29a1b 100644
--- a/tests/functional/replay_kernel.py
+++ b/tests/functional/replay_kernel.py
@@ -32,15 +32,14 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
         # icount requires TCG to be available
         self.require_accelerator('tcg')
 
-        logger = logging.getLogger('replay')
         start_time = time.time()
         vm = self.get_vm(name='recording' if record else 'replay')
         vm.set_console()
         if record:
-            logger.info('recording the execution...')
+            self.log.info('recording the execution...')
             mode = 'record'
         else:
-            logger.info('replaying the execution...')
+            self.log.info('replaying the execution...')
             mode = 'replay'
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
                     (shift, mode, replay_path),
@@ -54,15 +53,15 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
         self.wait_for_console_pattern(console_pattern, vm)
         if record:
             vm.shutdown()
-            logger.info('finished the recording with log size %s bytes'
+            self.log.info('finished the recording with log size %s bytes'
                         % os.path.getsize(replay_path))
             self.run_replay_dump(replay_path)
-            logger.info('successfully tested replay-dump.py')
+            self.log.info('successfully tested replay-dump.py')
         else:
             vm.wait()
-            logger.info('successfully finished the replay')
+            self.log.info('successfully finished the replay')
         elapsed = time.time() - start_time
-        logger.info('elapsed time %.2f sec' % elapsed)
+        self.log.info('elapsed time %.2f sec' % elapsed)
         return elapsed
 
     def run_replay_dump(self, replay_path):
@@ -80,5 +79,4 @@ def run_rr(self, kernel_path, kernel_command_line, console_pattern,
                          True, shift, args, replay_path)
         t2 = self.run_vm(kernel_path, kernel_command_line, console_pattern,
                          False, shift, args, replay_path)
-        logger = logging.getLogger('replay')
-        logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
+        self.log.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index fbb5adbcce..be5d70f97f 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -35,14 +35,13 @@ class ReverseDebugging(LinuxKernelTest):
     endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
-        logger = logging.getLogger('replay')
         vm = self.get_vm(name='record' if record else 'replay')
         vm.set_console()
         if record:
-            logger.info('recording the execution...')
+            self.log.info('recording the execution...')
             mode = 'record'
         else:
-            logger.info('replaying the execution...')
+            self.log.info('replaying the execution...')
             mode = 'replay'
             vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
@@ -95,10 +94,8 @@ def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
     def reverse_debugging(self, shift=7, args=None):
-        logger = logging.getLogger('replay')
-
         # create qcow2 for snapshots
-        logger.info('creating qcow2 image for VM snapshots')
+        self.log.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
         qemu_img = get_qemu_img(self)
         if qemu_img is None:
@@ -106,7 +103,7 @@ def reverse_debugging(self, shift=7, args=None):
                           'create the temporary qcow2 image')
         out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
                            encoding='utf8')
-        logger.info("qemu-img: %s" % out)
+        self.log.info("qemu-img: %s" % out)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
 
@@ -117,13 +114,13 @@ def reverse_debugging(self, shift=7, args=None):
         last_icount = self.vm_get_icount(vm)
         vm.shutdown()
 
-        logger.info("recorded log with %s+ steps" % last_icount)
+        self.log.info("recorded log with %s+ steps" % last_icount)
 
         # replay and run debug commands
         with Ports() as ports:
             port = ports.find_free_port()
             vm = self.run_vm(False, shift, args, replay_path, image_path, port)
-        logger.info('connecting to gdbstub')
+        self.log.info('connecting to gdbstub')
         g = GDBRemote('127.0.0.1', port, False, False)
         g.connect()
         r = g.cmd(b'qSupported')
@@ -134,59 +131,59 @@ def reverse_debugging(self, shift=7, args=None):
         if b'ReverseContinue+' not in r:
             self.fail('Reverse continue is not supported by QEMU')
 
-        logger.info('stepping forward')
+        self.log.info('stepping forward')
         steps = []
         # record first instruction addresses
         for _ in range(self.STEPS):
             pc = self.get_pc(g)
-            logger.info('saving position %x' % pc)
+            self.log.info('saving position %x' % pc)
             steps.append(pc)
             self.gdb_step(g)
 
         # visit the recorded instruction in reverse order
-        logger.info('stepping backward')
+        self.log.info('stepping backward')
         for addr in steps[::-1]:
             self.gdb_bstep(g)
             self.check_pc(g, addr)
-            logger.info('found position %x' % addr)
+            self.log.info('found position %x' % addr)
 
         # visit the recorded instruction in forward order
-        logger.info('stepping forward')
+        self.log.info('stepping forward')
         for addr in steps:
             self.check_pc(g, addr)
             self.gdb_step(g)
-            logger.info('found position %x' % addr)
+            self.log.info('found position %x' % addr)
 
         # set breakpoints for the instructions just stepped over
-        logger.info('setting breakpoints')
+        self.log.info('setting breakpoints')
         for addr in steps:
             # hardware breakpoint at addr with len=1
             g.cmd(b'Z1,%x,1' % addr, b'OK')
 
         # this may hit a breakpoint if first instructions are executed
         # again
-        logger.info('continuing execution')
+        self.log.info('continuing execution')
         vm.qmp('replay-break', icount=last_icount - 1)
         # continue - will return after pausing
         # This could stop at the end and get a T02 return, or by
         # re-executing one of the breakpoints and get a T05 return.
         g.cmd(b'c')
         if self.vm_get_icount(vm) == last_icount - 1:
-            logger.info('reached the end (icount %s)' % (last_icount - 1))
+            self.log.info('reached the end (icount %s)' % (last_icount - 1))
         else:
-            logger.info('hit a breakpoint again at %x (icount %s)' %
+            self.log.info('hit a breakpoint again at %x (icount %s)' %
                         (self.get_pc(g), self.vm_get_icount(vm)))
 
-        logger.info('running reverse continue to reach %x' % steps[-1])
+        self.log.info('running reverse continue to reach %x' % steps[-1])
         # reverse continue - will return after stopping at the breakpoint
         g.cmd(b'bc', b'T05thread:01;')
 
         # assume that none of the first instructions is executed again
         # breaking the order of the breakpoints
         self.check_pc(g, steps[-1])
-        logger.info('successfully reached %x' % steps[-1])
+        self.log.info('successfully reached %x' % steps[-1])
 
         g.close()
 
-        logger.info('exiting gdb and qemu')
+        self.log.info('exiting gdb and qemu')
         vm.shutdown()
diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
index 8e0563a97b..9a2816533d 100755
--- a/tests/functional/x86_64/test_acpi_bits.py
+++ b/tests/functional/x86_64/test_acpi_bits.py
@@ -121,10 +121,10 @@ def __init__(self, *args, **kwargs):
         self._debugcon_log = 'debugcon-log.txt'
 
     def _print_log(self, log):
-        self.logger.info('\nlogs from biosbits follows:')
-        self.logger.info('==========================================\n')
-        self.logger.info(log)
-        self.logger.info('==========================================\n')
+        self.log.info('\nlogs from biosbits follows:')
+        self.log.info('==========================================\n')
+        self.log.info(log)
+        self.log.info('==========================================\n')
 
     def copy_bits_config(self):
         """ copies the bios bits config file into bits.
@@ -138,8 +138,8 @@ def copy_bits_config(self):
         self.assertTrue(os.path.exists(bits_config_file))
         self.assertTrue(os.path.exists(target_config_dir))
         shutil.copy2(bits_config_file, target_config_dir)
-        self.logger.info('copied config file %s to %s',
-                         bits_config_file, target_config_dir)
+        self.log.info('copied config file %s to %s',
+                      bits_config_file, target_config_dir)
 
     def copy_test_scripts(self):
         """copies the python test scripts into bits. """
@@ -163,8 +163,8 @@ def copy_test_scripts(self):
                 newfilename = os.path.splitext(filename)[0] + '.py'
                 shutil.copy2(os.path.join(bits_test_dir, filename),
                              os.path.join(target_test_dir, newfilename))
-                self.logger.info('copied test file %s to %s',
-                                 filename, target_test_dir)
+                self.log.info('copied test file %s to %s',
+                              filename, target_test_dir)
 
                 # now remove the pyc test file if it exists, otherwise the
                 # changes in the python test script won't be executed.
@@ -172,9 +172,9 @@ def copy_test_scripts(self):
                 if os.access(os.path.join(target_test_dir, testfile_pyc),
                              os.F_OK):
                     os.remove(os.path.join(target_test_dir, testfile_pyc))
-                    self.logger.info('removed compiled file %s',
-                                     os.path.join(target_test_dir,
-                                     testfile_pyc))
+                    self.log.info('removed compiled file %s',
+                                  os.path.join(target_test_dir,
+                                               testfile_pyc))
 
     def fix_mkrescue(self, mkrescue):
         """ grub-mkrescue is a bash script with two variables, 'prefix' and
@@ -216,7 +216,7 @@ def generate_bits_iso(self):
 
         self.fix_mkrescue(mkrescue_script)
 
-        self.logger.info('using grub-mkrescue for generating biosbits iso ...')
+        self.log.info('using grub-mkrescue for generating biosbits iso ...')
 
         try:
             if os.getenv('V') or os.getenv('BITS_DEBUG'):
@@ -225,7 +225,7 @@ def generate_bits_iso(self):
                                       stdout=subprocess.PIPE,
                                       stderr=subprocess.STDOUT,
                                       check=True)
-                self.logger.info("grub-mkrescue output %s" % proc.stdout)
+                self.log.info("grub-mkrescue output %s" % proc.stdout)
             else:
                 subprocess.check_call([mkrescue_script, '-o',
                                       iso_file, bits_dir],
@@ -238,11 +238,10 @@ def generate_bits_iso(self):
 
         self.assertTrue(os.access(iso_file, os.R_OK))
 
-        self.logger.info('iso file %s successfully generated.', iso_file)
+        self.log.info('iso file %s successfully generated.', iso_file)
 
     def setUp(self): # pylint: disable=arguments-differ
         super().setUp()
-        self.logger = self.log
 
         prebuiltDir = self.scratch_file('prebuilt')
         if not os.path.isdir(prebuiltDir):
@@ -333,7 +332,7 @@ def test_acpi_smbios_bits(self):
         # in batch mode and then automatically initiate a vm shutdown.
         self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
-        self.logger.debug("Checking console output ...")
+        self.log.debug("Checking console output ...")
         self.parse_log()
 
 if __name__ == '__main__':
-- 
2.50.1


