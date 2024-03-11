Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73103C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfZ-0004QC-Vq; Mon, 11 Mar 2024 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfE-0003cE-RT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfD-0007SS-36
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e57a3bf411so1946373b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178933; x=1710783733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJbIVjuhRVi4haft9J+vCC4CMuONyFWVRLhrl1zM+vA=;
 b=Zh61yr5J09aF2WoToS/M1mHMlFmkR7N20M0N8GjGj1FlmSjJOUbkccX20ab0Fn54qZ
 BJUURP2pOmjiv5EJxumEOcItTDTIs8rBY/eSbjYq+UxaoY/IoqU7cCqZdGBiRLSFM30d
 Txn72UYtnYMt1sgc1E8LYqqe9yK2z9B0PFT2P8UnoTKlYncjq3petbWDphbQ31n3COZc
 Eqfuc89k/44rfDs0j0S0DBLlutNzoB/n2FyR5hIbQnsCnQ7nLDlKgLN3c9TGldqJ1mBU
 8Jw/o1KvfHn8E+abk0WH9TVwSYFrXnSDg6aiyV6axvRZuqYweys6WuZDjWSXfWefaI5D
 rT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178933; x=1710783733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJbIVjuhRVi4haft9J+vCC4CMuONyFWVRLhrl1zM+vA=;
 b=KcV7sipXjdMm0GvkZ2uA9U5ZmfLGmdcFhwiUi64zlyGN+Uzdy7CCscjOJkMz0uBz3l
 zzIlpkVKIrvGgtzNv51GaXtgw+9E3NhS9aGMoz/uQyAL7XXp8ir6BKwpeykGEKbA5Q7t
 KJiQ0iAz7eakhCLqa8788EZuAxt8YjnZsbbEqKj7NI969LHBSeSU85/80RFbrR2y5x0s
 wR+51r++LzBf7UTbph8OyoIRyrtd7heyYdeLtCj9xTWiVDD4TLXVyO7i7v73yJIJ6V9r
 aljkuz0q5gHiLj5u5/xwBEcSR4ClTgImzuDw2z22TeZSENsjq25Wugr5ChzFkn6eX3CF
 chKw==
X-Gm-Message-State: AOJu0YztEMGVYyl0hBS+f6D31knGeNDZ+TTso0Uc5Pc0GrF7mXfsk0I1
 Ue61ulwSNvn6hlspzSDd9EyxzBBttPpdjvcKntgJdCKJcX1J0O7cwjRoOMu0zIU=
X-Google-Smtp-Source: AGHT+IFkby1+lHxcyaFpPuw6Z+hPTch+XkzHcCmbXYVPyuicqjHt82HqJxngG04Q/6fnSD4YBVWDjg==
X-Received: by 2002:a05:6a20:d80b:b0:1a2:b33b:d6e0 with SMTP id
 iv11-20020a056a20d80b00b001a2b33bd6e0mr9512296pzb.59.1710178933375; 
 Mon, 11 Mar 2024 10:42:13 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:13 -0700 (PDT)
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
Subject: [PATCH v4 18/24] tests/avocado: reverse_debugging reverse-step at the
 end of the trace
Date: Tue, 12 Mar 2024 03:40:20 +1000
Message-ID: <20240311174026.2177152-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 50 +++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index c84fbcd8bd..635ff7bacc 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -9,6 +9,7 @@
 # later.  See the COPYING file in the top-level directory.
 import os
 import logging
+import time
 
 from avocado import skipUnless
 from avocado_qemu import BUILD_DIR
@@ -31,7 +32,7 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 10
+    timeout = 20
     STEPS = 10
     endian_is_le = True
 
@@ -87,6 +88,19 @@ def check_pc(self, g, addr):
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
@@ -159,8 +173,14 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
         logger.info('continue running')
         self.gdb_cont_nowait(g)
 
+        logger.info('running for 1s...')
+        time.sleep(1)
         logger.info('stopping to read final icount')
         vm.qmp('stop')
+        self.gdb_break(g)
+        last_pc = self.get_pc(g)
+        logger.info('saving position %x' % last_pc)
+        self.gdb_step(g)
         last_icount = self.vm_get_icount(vm)
         logger.info('shutdown...')
         vm.shutdown()
@@ -196,6 +216,34 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
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
+        if not x86_workaround:
+            self.check_pc(g, last_pc)
+            logger.info('found position %x' % last_pc)
+
+        logger.info('stepping backward')
+        self.gdb_bstep(g)
+
+        logger.info('stepping forward')
+        self.gdb_step(g)
+        if not x86_workaround:
+            self.check_pc(g, last_pc)
+            logger.info('found position %x' % last_pc)
+
+        logger.info('reversing to the start of the trace')
+        g.cmd(b'bc', b'T05thread:01;')
+
         # Step forward again
         logger.info('stepping forward')
         for addr in steps:
-- 
2.42.0


