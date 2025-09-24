Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE3CAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JBe-0002fd-B6; Wed, 24 Sep 2025 02:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JB5-0002Wd-HF
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAn-0006iw-Ek
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io+NV+Ev+q4WrO5LChFMvPvsyJ+x/EqfXtbfwMi7ajU=;
 b=aztj5SDJZLuYvCofs2mvrW5lkrZN17IxItBuUiAwIyIOe5VsOG1tKqAxudAjFR3Gh10iEL
 QSbIa6e0N8dn4Ad9S5w1Vkhh1psAiQWgJGGqbvQhKGlTvnk1A0qdJWtgEQFLiN9xewqPlY
 gaGcOraQPgTS0ng0VcwYedH1UuQG6ak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-X-o0bXckONmzPXv_Dmy0lg-1; Wed,
 24 Sep 2025 02:40:12 -0400
X-MC-Unique: X-o0bXckONmzPXv_Dmy0lg-1
X-Mimecast-MFC-AGG-ID: X-o0bXckONmzPXv_Dmy0lg_1758696011
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70C4F19560AF; Wed, 24 Sep 2025 06:40:11 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58F3E1955F22; Wed, 24 Sep 2025 06:40:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/12] tests/functional: use self.log for all logging
Date: Wed, 24 Sep 2025 08:39:51 +0200
Message-ID: <20250924063956.519792-8-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Some tests are creating their on logger category which means any
output they log is not captured in base.log.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: drop changes to reverse_debugging.py (it's WIP in other patches)]
Message-ID: <20250912182200.643909-7-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/aarch64/test_virt.py     |  4 +--
 tests/functional/arm/test_integratorcp.py |  3 +--
 tests/functional/mips64el/test_malta.py   |  3 +--
 tests/functional/replay_kernel.py         | 16 +++++-------
 tests/functional/x86_64/test_acpi_bits.py | 31 +++++++++++------------
 5 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/tests/functional/aarch64/test_virt.py b/tests/functional/aarch64/test_virt.py
index 4d0ad90ff89..63071f9b517 100755
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
index 4f00924aa03..23ae919359d 100755
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
index 8fdc49b3005..170147bfcc2 100755
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
index 80795eb0520..acb1d29a1b5 100644
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
diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
index 8e0563a97b1..9a2816533d6 100755
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
2.51.0


