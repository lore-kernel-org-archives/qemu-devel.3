Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0150AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDt-0006xw-M6; Mon, 18 Mar 2024 11:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDl-0006dj-EE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:19 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDb-0007wl-Pt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6fb9a494aso2132723b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776885; x=1711381685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8gtVyvP+veMtIIGlxTAH51MS2c3Qecwre8NmRVXGX0=;
 b=kvznyEBWX9UW8v3tutpaom+FZxmF8xYazxzSB8D4qExuMl1XOgQkMglm2fr8jbXMdW
 JaImtPBjvqK0Je+mEXLOSuVzkzdQyg98y/3nhsxgY2ve8p0PnbMRuZ7WRNe5fJj5QvUS
 MTjuz3Rkhoba1vj88HqcmmnDvztAmKHkayLwVpPOv97iW9GsGjWaT3jgwpFDOeuZck1V
 ljL2lJN8l2DzhMXSMAdhESuU8gmo1QqpAVRfA1p8feOAxRyJIBzc9m0HKKqEVAqhzpo3
 lX/H+SYqqPEGzvYsZRIhcSM/NBdBY5kQWO4celytgPyxj6f4O3ORRgArtDYdIjqL6gG7
 lmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776885; x=1711381685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8gtVyvP+veMtIIGlxTAH51MS2c3Qecwre8NmRVXGX0=;
 b=DudwX+jgBLmL4rV5YlpGiD4zvlewxKlHtGkF0ZqcfcgpFWizWzjW+mn0k13dvREeEH
 hezlf36a8QF0jGxR8itPU8FfZkaHe8byPnXqW+wJJj7cK4+t6wDncHMGKV4PLvL1pUBb
 /KS64kOU/dZTX9l5XxNksZ9hITMZjKuWZvT6vVqLXvT5b1gvjBw8CZs79/iLKUEeCEN9
 VK35J4Rjf9j3ouNva4f7TVN1R8H+u1dAtWh6Azc4LCiEK5FRBsjFxumx0VK9Hg1KuJPY
 axW1OwemRvtkUVI1dUV/bXRRH3Le6q3Qqrcd8kHatSVREuzNI5s/LH43FPomlZZ7lUTh
 UhVg==
X-Gm-Message-State: AOJu0YzAnvqXXcYX0UcZ3nSL4U7iAfRdX0Hbqw5himGFe3l7uCzRycPN
 BicoUzcuz2O2MIMJ6Qr5hDWeMKbatKOA+JsmZj8/Tj7qU0rcWI/Xn0sKA5L2UnI=
X-Google-Smtp-Source: AGHT+IFswxqQ/0H+cTZPdXEgMz4qwDtL/gx6jUeM67U5cNtSjURwB4P2nAkNgy6xr9ur5wSQs9Q8Gg==
X-Received: by 2002:a05:6a20:3d12:b0:1a3:64ec:46a6 with SMTP id
 y18-20020a056a203d1200b001a364ec46a6mr3475267pzi.4.1710776884912; 
 Mon, 18 Mar 2024 08:48:04 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 16/24] tests/avocado: reverse_debugging.py verify addresses
 between record and replay
Date: Tue, 19 Mar 2024 01:46:13 +1000
Message-ID: <20240318154621.2361161-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

gdb is only attached in the replay phase, and the recorded trace is
single-stepped to build up an address map that is used to then verify
reverse-step and reverse-continue.

This change attaches gdb in the record phase, and builds the address
map by single-stepping the live machine. That address map is then
verified by single-stepping the replay, and then used for the same
reverse debug verification.

This is a stronger verifcation between the record and the replay phases,
as well as providing some testing of gdb operation in record mode.

x86_64 has problems with taking the first step, it does not advance the
icount, so a workaround is added for it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 68 +++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index e76cf54ad7..8a9578ad5a 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -35,6 +35,10 @@ class ReverseDebugging(LinuxKernelTest):
     STEPS = 10
     endian_is_le = True
 
+    # If first_step_workaround is true, check whether the first step moved
+    # icount, and if not then step again.
+    first_step_workaround = False
+
     def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
         vm = self.get_vm()
@@ -45,7 +49,7 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         else:
             logger.info('replaying the execution...')
             mode = 'replay'
-            vm.add_args('-gdb', 'tcp::%d' % port, '-S')
+        vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
                     (shift, mode, replay_path),
                     '-net', 'none')
@@ -87,6 +91,17 @@ def check_pc(self, g, addr):
         if pc != addr:
             self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
 
+    @staticmethod
+    def gdb_cont(g):
+        g.cmd(b'c')
+
+    @staticmethod
+    def gdb_cont_nowait(g):
+        # The avocado GDBRemote does not have a good way to disconnect or
+        # continue without waiting for a reply, so open-code our own here.
+        data = g.encode(b'c')
+        g._socket.send(data)
+
     @staticmethod
     def gdb_step(g):
         g.cmd(b's', b'T05thread:01;')
@@ -117,11 +132,40 @@ def reverse_debugging(self, shift=7, args=None):
         replay_path = os.path.join(self.workdir, 'replay.bin')
         port = find_free_port()
 
+        steps = []
+
         # record the log
         vm = self.run_vm(True, shift, args, replay_path, image_path, port)
+        logger.info('connecting to gdbstub')
+        g = gdb.GDBRemote('127.0.0.1', port, False, False)
+        g.connect()
+        r = g.cmd(b'qSupported')
+        if b'qXfer:features:read+' in r:
+            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
+
+        if self.vm_get_icount(vm) != 0:
+            self.fail('icount does not start at zero')
+
+        # save the addresses of the first STEPS instructions executed
+        logger.info('stepping forward')
+        for i in range(self.STEPS):
+            pc = self.get_pc(g)
+            logger.info('saving position %x' % pc)
+            steps.append(pc)
+            self.gdb_step(g)
+            if self.first_step_workaround and i == 0 and self.vm_get_icount(vm) == 0:
+                logger.warn('failed to take first step, stepping again')
+                self.gdb_step(g)
+        if self.vm_get_icount(vm) != self.STEPS:
+            self.fail('icount (%d) does not match number of instructions stepped' % self.vm_get_icount(vm))
+
+        logger.info('continue running')
+        self.gdb_cont_nowait(g)
+
         while self.vm_get_icount(vm) <= self.STEPS:
             pass
         last_icount = self.vm_get_icount(vm)
+        logger.info('shutdown...')
         vm.shutdown()
 
         logger.info("recorded log with %s+ steps" % last_icount)
@@ -139,23 +183,23 @@ def reverse_debugging(self, shift=7, args=None):
         if b'ReverseContinue+' not in r:
             self.fail('Reverse continue is not supported by QEMU')
 
+        # Try single stepping
         logger.info('stepping forward')
-        steps = []
-        # record first instruction addresses
-        for _ in range(self.STEPS):
-            pc = self.get_pc(g)
-            logger.info('saving position %x' % pc)
-            steps.append(pc)
+        for addr in steps:
+            # verify addresses match what initial execution saw
+            self.check_pc(g, addr)
             self.gdb_step(g)
+            logger.info('found position %x' % addr)
 
-        # visit the recorded instruction in reverse order
+        # Try reverse stepping
         logger.info('stepping backward')
         for addr in steps[::-1]:
             self.gdb_bstep(g)
+            # verify addresses match what initial execution saw
             self.check_pc(g, addr)
             logger.info('found position %x' % addr)
 
-        # visit the recorded instruction in forward order
+        # Step forward again
         logger.info('stepping forward')
         for addr in steps:
             self.check_pc(g, addr)
@@ -175,7 +219,7 @@ def reverse_debugging(self, shift=7, args=None):
         # continue - will return after pausing
         # This could stop at the end and get a T02 return, or by
         # re-executing one of the breakpoints and get a T05 return.
-        g.cmd(b'c')
+        self.gdb_cont(g)
         if self.vm_get_icount(vm) == last_icount - 1:
             logger.info('reached the end (icount %s)' % (last_icount - 1))
         else:
@@ -201,6 +245,10 @@ class ReverseDebugging_X86_64(ReverseDebugging):
 
     REG_PC = 0x10
     REG_CS = 0x12
+
+    # The initial step does not change pc on x86 for some reason.
+    first_step_workaround = True
+
     def get_pc(self, g):
         return self.get_reg_le(g, self.REG_PC) \
             + self.get_reg_le(g, self.REG_CS) * 0x10
-- 
2.42.0


