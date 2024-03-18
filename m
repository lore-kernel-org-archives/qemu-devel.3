Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3D0C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFE2-0007r8-8L; Mon, 18 Mar 2024 11:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDw-0007RL-6r
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:28 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDr-0007ze-H0
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:27 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c1a2f7e1d2so2937403b6e.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776902; x=1711381702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vChGyrdMAwhGNcUz/tevOgrJdP+StcBef0qjQjfUcXs=;
 b=Ir2+eH/Xaks/awcpxsz22giE0TcUfME2txLzh8Z2+1k0k0cAHIrvRN/JVy+/COJbRY
 cdq3AcQxgzl0h13pJUJKjWLPwRm7nUfelVs/sRznkPzMwZ7jC29F5cXTMKuY77GZ0BOi
 xAPU5iSq9zK0WjW6NTS9l3+8h0u/S6F5R1LQZDuzESDkGiurqM/n+vDHXeKijsMCpKLP
 /tPEjVxCowFfX9Ln9c7AEkKNPxifBw5whdPchKiOjFdSXaTVt6fycXS2yg4iqzobVXmD
 S0k/uoZ3/DOT1GrSTN89aOlSSmBMVt8fdyL1bHYnVOjzn30jJyA/CpNbaAC0itYFQtSy
 WSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776902; x=1711381702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vChGyrdMAwhGNcUz/tevOgrJdP+StcBef0qjQjfUcXs=;
 b=tj1PtYPwLGjs6eRm0rlg9EUOpO9seVRdTjrNGnGw7I8+8YA3lhFryZwihX7lXTzVTX
 lNQi5vaaIw3gQoaiDYyOnPnsGY2DVI2KrtT2OwvY20NG7Dh9IZdNsTXj4kId0ct9X+7f
 cJTUHNrby0llCbz7sZmpU3+An4A4Q4UBA2IricFhxOZAZ1HjBXvl1+0A7tQnQVSF5bYz
 Y5UqrKHWUnGTqNhmNf/IeyGzDp714xU7iiEylx/QQQ7+genKRkuW3L8UcQHYibuRFS43
 TwwciO4UMUOO5vQnunn9URJQ9+BotSuYm8/FzD0rdZt4hCfWpx0h5+9L6MObGQAwAALG
 Ogtg==
X-Gm-Message-State: AOJu0YyVny4LMWRdnVAE4owEMCb8Jgp3OpA7xUNeP+KSCdq7d0gBa3Ft
 znm1RNeHFQEwdlJrOxmsBmg6TzUSBYlgzzqaTekgvoIGyCCI9+ChRtXVmNN5kuE=
X-Google-Smtp-Source: AGHT+IH+xu9UG0qY5T3oCoz48+mzAT1WNd+fxXiFmnh1dJQorE2yMYpLRQTEZ4x54/XXgd7uxJjP/A==
X-Received: by 2002:a05:6808:13d3:b0:3c2:c82:904f with SMTP id
 d19-20020a05680813d300b003c20c82904fmr14360335oiw.58.1710776902250; 
 Mon, 18 Mar 2024 08:48:22 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:22 -0700 (PDT)
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
Subject: [PATCH v5 19/24] tests/avocado: reverse_debugging.py add snapshot
 testing
Date: Tue, 19 Mar 2024 01:46:16 +1000
Message-ID: <20240318154621.2361161-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
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

Make a manual snapshot halfway though initial building of the address
map in record mode.

This will cause the reverse-step and reverse-continue tests to load that
snapshot when beginning from later points in the trace, exercising the
post-initial snapshot saving and loading.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index c0cf580d5c..185f055cf9 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -59,7 +59,7 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
                     (shift, mode, replay_path),
                     '-net', 'none')
-        vm.add_args('-drive', 'file=%s,if=none' % image_path)
+        vm.add_args('-drive', 'file=%s,if=none,id=disk0' % image_path)
         if args:
             vm.add_args(*args)
         vm.launch()
@@ -133,6 +133,14 @@ def gdb_bstep(g):
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
+    @staticmethod
+    def vm_snapshot(vm):
+        return vm.qmp('snapshot-save',
+                      {'job-id': 'snapshot-job',
+                       'tag': 'manual',
+                       'vmstate': 'disk0',
+                       'devices': []})
+
     def reverse_debugging(self, shift=7, args=None):
         logger = logging.getLogger('replay')
 
@@ -171,6 +179,9 @@ def reverse_debugging(self, shift=7, args=None):
             pc = self.get_pc(g)
             logger.info('saving position %x' % pc)
             steps.append(pc)
+            if i == self.STEPS//2:
+                logger.info('saving VM snapshot at step %x...' % i)
+                self.vm_snapshot(vm)
             self.gdb_step(g)
             if self.first_step_workaround and i == 0 and self.vm_get_icount(vm) == 0:
                 logger.warn('failed to take first step, stepping again')
@@ -217,7 +228,9 @@ def reverse_debugging(self, shift=7, args=None):
             self.gdb_step(g)
             logger.info('found position %x' % addr)
 
-        # Try reverse stepping
+        # Try reverse stepping. The manual snapshot taken in the record
+        # phase should be used for reverse-stepping until the machine
+        # reverses to an icount older than the snapshot.
         logger.info('stepping backward')
         for addr in steps[::-1]:
             self.gdb_bstep(g)
@@ -242,6 +255,8 @@ def reverse_debugging(self, shift=7, args=None):
             self.check_pc(g, last_pc)
             logger.info('found position %x' % last_pc)
 
+            # This should load the last snapshot taken. Could that be verified
+            # with QMP?
             logger.info('stepping backward')
             self.gdb_bstep(g)
 
-- 
2.42.0


