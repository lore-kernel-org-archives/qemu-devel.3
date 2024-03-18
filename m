Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A8CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDw-0007WO-VO; Mon, 18 Mar 2024 11:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDp-0006f9-PM
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:23 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDn-0007z2-D8
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so4003068b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776896; x=1711381696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6v5RIqN05KI0hc+5mWXKMx4NLEtwOgII4cjIlr9z1c=;
 b=V5s8e2bIsqGlE+F1Ow3ByvYN1acSY3LdZDX8k3uNVMHKzPS0dcHFdY7wrPG6dAQhbk
 R2ee5uZi/UOznoiO0j2Kz4XH5qG+kyTMOlQE9bklaoou4iprwaXsLM9XswtLLpkDSW5Z
 KWA6HJkKVT0R5zjGF8ZuCUCreP6BP/+Ogso7Xn1PVvLWfoO7iXlzqKAQsaZBbdwzO8NT
 /sQfA/fhTQhQ/N09wGntpDYkjhkVIvZLaxvbdUMpSgpQHhH7SUlRlbPnLbCo9A9w4FG4
 1pJjbOyL/syrxi28/eHqtRD0yVy6dOEpd8nn/inh8vQyT8x/6vZy5X5XndTIhreY1eGp
 cU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776896; x=1711381696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6v5RIqN05KI0hc+5mWXKMx4NLEtwOgII4cjIlr9z1c=;
 b=aX7hFUnIXdCf/wJjyo2VlS0vrSi+Z5/pjc4Sxe+pw2djkequM+GuEGIoHLA+zAtwJO
 RhqiDJZAqMUJyn43caSvertA7GcGQsJy0KuoIzEjaZhYCq+Gb1tv9hhYfm4MgQxBqBSX
 DcikJwNt+9ECLxqbIgFEHIsuC7kFK7TCdB35elQ0r5b89NsoKUl8/+/WQuZ43UUMSAfc
 0D1y8XTFOxMSxW+61bIAUobMBpZ7B3/487dBM3wPPYlIP9etjWtxotIF3ZkWYomw3qBw
 HGx4vf1wLm4RG613fAlXk1RE4e+QKW21CUxMoxX1W/g1uJKDU3jxX4zmRuvyov6rzZAT
 PbJA==
X-Gm-Message-State: AOJu0Yww4MhTWEZAQkFidQzIIcn1Yd+XeeZ5gs4bZPu4hRP5dqMFpVMr
 r+bc38m2lGcBCeRGm3CjhW5KUlyauHYdOM91yC4Ve6q607GUPbAEgRAs3q0mMq4=
X-Google-Smtp-Source: AGHT+IH+cHz0Rby4vdmsY9QoFOKyCKlo+HbfsYU5RN+HtmE0hDtbUO3ldOFUVa7h/P/zdkmXAMmkcA==
X-Received: by 2002:a05:6a21:99aa:b0:1a3:4a3a:6e22 with SMTP id
 ve42-20020a056a2199aa00b001a34a3a6e22mr14624063pzb.24.1710776896259; 
 Mon, 18 Mar 2024 08:48:16 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:16 -0700 (PDT)
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
Subject: [PATCH v5 18/24] tests/avocado: reverse_debugging reverse-step at the
 end of the trace
Date: Tue, 19 Mar 2024 01:46:15 +1000
Message-ID: <20240318154621.2361161-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

The longer a trace is played for, the more chance there is for bugs
to cause it to go out of synch with the initial recording. Stepping
backward from the end of a trace can be a good way to find problems.

This extends the runtime of the record phase to 1 second, to build a
bigger trace, and it adds a replay test that runs to the end of the
trace, steps back then forward and verifies the pc.

x86_64 and aarch64 have problems with verifying the pc at the end of
the trace after reverse-stepping, so add a workaround to skip that
check for them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 65 +++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index bdc9082c85..c0cf580d5c 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -9,6 +9,7 @@
 # later.  See the COPYING file in the top-level directory.
 import os
 import logging
+import time
 
 from avocado import skipUnless
 from avocado_qemu import BUILD_DIR
@@ -31,10 +32,15 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
+    timeout = 30
     STEPS = 10
     endian_is_le = True
 
+    # If long_trace is true, record execution for some time, and verify
+    # reverse-stepping from the end of the trace as well. If false, only the
+    # first 10 instructions are stepped.
+    verify_end = True
+
     # If first_step_workaround is true, check whether the first step moved
     # icount, and if not then step again.
     first_step_workaround = False
@@ -91,6 +97,19 @@ def check_pc(self, g, addr):
         if pc != addr:
             self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
 
+    @staticmethod
+    def gdb_break(g):
+        # The avocado GDBRemote does not have a good way to send this break
+        # packet, which is different from others.
+        g._socket.send(b'\x03')
+        transmission_result = g._socket.recv(1)
+        if transmission_result == '-':
+            raise Exception("Bad ack")
+        result = g._socket.recv(1024)
+        response_payload = g.decode(result)
+        if response_payload != b'T02thread:01;':
+            raise Exception("Unexpected response" + response_payload.decode())
+
     @staticmethod
     def gdb_cont(g):
         g.cmd(b'c')
@@ -162,9 +181,15 @@ def reverse_debugging(self, shift=7, args=None):
 
         logger.info('continue running')
         self.gdb_cont_nowait(g)
-
+        logger.info('running for 1s...')
+        time.sleep(1)
         logger.info('stopping to read final icount')
         vm.qmp('stop')
+        self.gdb_break(g)
+
+        last_pc = self.get_pc(g)
+        logger.info('saving position %x' % last_pc)
+        self.gdb_step(g)
         last_icount = self.vm_get_icount(vm)
         logger.info('shutdown...')
         vm.shutdown()
@@ -200,6 +225,34 @@ def reverse_debugging(self, shift=7, args=None):
             self.check_pc(g, addr)
             logger.info('found position %x' % addr)
 
+        # Run to the end of the trace, reverse-step, and then reverse-continue
+        # back to the start, with no breakpoints. This allows us to get to the
+        # end of the trace and reverse step from there, without possibly
+        # hitting a breakpoint that prevents reaching the end, as can happen
+        # with the later breakpoint tests.
+        logger.info('running to the end of the trace')
+        vm.qmp('replay-break', icount=last_icount - 1)
+        # This should stop at the end and get a T02 return.
+        self.gdb_cont(g)
+        if self.vm_get_icount(vm) != last_icount - 1:
+            self.fail('failed to reach the end (icount %s, reached %s)' % ((last_icount - 1), self.vm_get_icount(vm)))
+        logger.info('reached end of trace')
+
+        if self.verify_end:
+            self.check_pc(g, last_pc)
+            logger.info('found position %x' % last_pc)
+
+            logger.info('stepping backward')
+            self.gdb_bstep(g)
+
+            logger.info('stepping forward')
+            self.gdb_step(g)
+            self.check_pc(g, last_pc)
+            logger.info('found position %x' % last_pc)
+
+        logger.info('reversing to the start of the trace')
+        g.cmd(b'bc', b'T05thread:01;')
+
         # Step forward again
         logger.info('stepping forward')
         for addr in steps:
@@ -250,6 +303,10 @@ class ReverseDebugging_X86_64(ReverseDebugging):
     # The initial step does not change pc on x86 for some reason.
     first_step_workaround = True
 
+    # Reverse stepping from a long-running trace does not reliably replay
+    # the trace precisely on x86.
+    verify_end = False
+
     def get_pc(self, g):
         return self.get_reg_le(g, self.REG_PC) \
             + self.get_reg_le(g, self.REG_CS) * 0x10
@@ -279,6 +336,10 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
+    # Reverse stepping from a long-running trace does not reliably replay
+    # the trace precisely on aarch64.
+    verify_end = False
+
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
-- 
2.42.0


