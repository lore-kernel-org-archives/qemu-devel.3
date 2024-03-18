Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87948C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFEG-0001yy-9l; Mon, 18 Mar 2024 11:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFED-0001RU-AZ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:45 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFE3-000813-Rp
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:45 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e4b775e1d6so3181365a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776914; x=1711381714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgE3bLqYmURNZ5foTV5tmX1mGq2Gl0HCA4fK1Z1dU4Y=;
 b=HNTtH5TK6mUJb6Uy4dcAkZsYUrUNWU01jzSkBPbZPkk1ErGxo1g679xe5BE5C8E6Gi
 KmmJGicOdIpbxr/P89IpjM12bpK5nvLaL6bZtITGToeOlhDfOuzD17ktd7UQXVQ28coc
 Xy8yTosXIhM+3DcTAPWEiLEBvvwfaEInElG1AcAFdK8Hy9HEwKMNCQAOV8z7iVWT3Olu
 pktwgTT7n9ENjXRda9E3B7FNA7cvIIydQWRdlWi3izOOJKA5WvWlHPOMBmJctYj36/rL
 5JiBzgos+S1/2wnrWlf0zmPkECTiTVTwjPcn5Ox4RURyAeKcjs+pASLRwEbmZeugHJJ8
 Ws3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776914; x=1711381714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgE3bLqYmURNZ5foTV5tmX1mGq2Gl0HCA4fK1Z1dU4Y=;
 b=mFuOTcCzLstOQV/YgQXMOZUJOwj5gzXxVTUh7rj8KaBuaI7jlRUuee1VAGQoJrb7Nh
 RA6Utdql3Em4WnWFdQzg3Psl7mqRwZaeYFMlmrlll5jx2mXB+ivaVsnHdaLKOs3Ok7vg
 RrpOK2q4zdZHIl1uINXvgIbUC2Ie3OBngS+apiAjAzmJXF1PkolQcKyvkKU0o4CtxvmW
 80Ec/u6H6PvGq/IWPdodYUSqIUpTlVhhTW3Qf2x6NoVbB3eBo3NNSEmZmIkgfKMQE6tD
 s28+J5+REfgaOfe3ay18HNdiI7HPpBMCho5U9Xs64YY3gVBnfWGlOl8Ttqcj7OOObV+v
 POLA==
X-Gm-Message-State: AOJu0YxD45H0g5u32vmMY3OjRZfZw+JtGv2/XHw0U3BKuOJfJXiKZXXn
 xXO2x67dKDh1MymcyDoPNTM0uoOehdKQrO1RUaqxiuxq6dvsEU3uCFDxY3/Tboc=
X-Google-Smtp-Source: AGHT+IGfESP0nmp53QdR6tRaa0ATfrkvxEg9EnhAWgL3oJ04ccBMEhA8fRglwNfWQmMbgqfOJUMaSA==
X-Received: by 2002:a17:90a:5218:b0:29f:931a:8b63 with SMTP id
 v24-20020a17090a521800b0029f931a8b63mr6222374pjh.17.1710776914289; 
 Mon, 18 Mar 2024 08:48:34 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:34 -0700 (PDT)
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
Subject: [PATCH v5 21/24] tests/avocado: reverse_debugging.py test
 auto-snapshot mode
Date: Tue, 19 Mar 2024 01:46:18 +1000
Message-ID: <20240318154621.2361161-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

This runs the recording phase with a periodic auto-snapshot.

It also runs the machine for 5 seconds after creating the initial
address map, so as to alow time for a some auto snapshots to be
taken.

In the replay mode a reverse-debugging sequence is added where the
test is run to the end, and reverse-stepped from there. This should
load the last auto-snapshot taken.

The test hangs on x86-64 and aarch64 with autosnapshots, so it is
disabled for them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 185f055cf9..36e5e1be05 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -41,6 +41,9 @@ class ReverseDebugging(LinuxKernelTest):
     # first 10 instructions are stepped.
     verify_end = True
 
+    # Enable the autosnapshot test, requires long_trace = True.
+    autosnapshot = True
+
     # If first_step_workaround is true, check whether the first step moved
     # icount, and if not then step again.
     first_step_workaround = False
@@ -56,9 +59,14 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
             logger.info('replaying the execution...')
             mode = 'replay'
         vm.add_args('-gdb', 'tcp::%d' % port, '-S')
-        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
-                    (shift, mode, replay_path),
-                    '-net', 'none')
+        if self.autosnapshot:
+            vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init'
+                                   ',rrsnapmode=periodic,rrsnapcount=10,'
+                                   'rrsnaptime=1' % (shift, mode, replay_path))
+        else:
+            vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init'
+                                   % (shift, mode, replay_path))
+        vm.add_args('-net', 'none')
         vm.add_args('-drive', 'file=%s,if=none,id=disk0' % image_path)
         if args:
             vm.add_args(*args)
@@ -192,8 +200,12 @@ def reverse_debugging(self, shift=7, args=None):
 
         logger.info('continue running')
         self.gdb_cont_nowait(g)
-        logger.info('running for 1s...')
-        time.sleep(1)
+        if self.autosnapshot:
+            logger.info('running for 5s...')
+            time.sleep(5)
+        else:
+            logger.info('running for 1s...')
+            time.sleep(1)
         logger.info('stopping to read final icount')
         vm.qmp('stop')
         self.gdb_break(g)
@@ -322,6 +334,9 @@ class ReverseDebugging_X86_64(ReverseDebugging):
     # the trace precisely on x86.
     verify_end = False
 
+    # x86 doesn't like autosnapshot
+    autosnapshot = False
+
     def get_pc(self, g):
         return self.get_reg_le(g, self.REG_PC) \
             + self.get_reg_le(g, self.REG_CS) * 0x10
@@ -355,6 +370,9 @@ class ReverseDebugging_AArch64(ReverseDebugging):
     # the trace precisely on aarch64.
     verify_end = False
 
+    # aarch64 doesn't like autosnapshot
+    autosnapshot = False
+
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
-- 
2.42.0


