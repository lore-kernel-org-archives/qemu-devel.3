Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E247C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfa-0004Sq-6X; Mon, 11 Mar 2024 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfV-00041w-S9
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjfS-0007TN-So
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e6381df003so4061662b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178949; x=1710783749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/XlsIofD/wjudMNjmydpE++GM2AoH7AyjDFCwRpOIY=;
 b=dKdExSpyAo4Vhr7tHH27ytmWMj+M+xBGOpsQWILHSyYs19GbBhiSdJtu+l1X9x1EeH
 /ZjuH72ahjw7xapcArzM4SbtEVMFP5b2JdDRMcMi3YJOplFQ6XLcECEClqxnQ8jfw7CY
 4uc7EhBH8/zO9SvqaSkPdqxpKUtz8SCT33hcSpuoWLAQ0+jzeGZ9KoX7O109u20/C/SU
 VLmrzZsFaK3hlWyBO0i1NsufYLqqizzmn+pQci4/fcCF8jNZv9tjhCAxL9f3B+beXCCo
 ZMKtqRJK1udEtU9aawbyAVTQT+9IeMYdK18sopHB8PITo+Bzz31qFnLiwcWtJza73oF3
 +18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178949; x=1710783749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/XlsIofD/wjudMNjmydpE++GM2AoH7AyjDFCwRpOIY=;
 b=rM4SnzpUaONQeHv32aVxrjo6JCZu4ypM65xKOZgLhdoovxxPyEtlFp0jGM9WH/Yt4x
 NLa3f+EdsKkKJVxBedbkEMRlsBj53M3p7fcmBuBCNLOpUxLPySeZxSXxJLfsjTKBezO0
 HFnrFxKnRDHKG8R0nDskA2IeFAWEVNXl5Xl0oBnWav4i5awgnWJ5JqB2caIPTHbOxHoI
 EFffN6FK4qPyVMYOxa9idm4FdL1lXz+SurOcL294Ml9kPn7VWVpm2Jt3I6WuZXXrB+lP
 Ol6YXc7YjNOEybq1lEHdN2TSWIi9tix7vLNh5TkU3WRw1Md2S5FNf32v8cmuLCDDwPd4
 6GZw==
X-Gm-Message-State: AOJu0Yx+tWGWQsNIchoePQSGdV0oY5lzcclR5OXaCQRNxeWjtMlaNg5W
 Q86pYZcX8WsMITwEXlEednTmbcA7ibs7Ix8usY3l6eAMky0MVMEyp/4TOWfBKzI=
X-Google-Smtp-Source: AGHT+IF27GH2svtB2AKfHjQECJ98Nk3FJalKkgFnfyhrJpQ12c7nv8jDjsv/9cMHTZT89BAqbdEjEg==
X-Received: by 2002:a05:6a20:914c:b0:1a1:8bdc:9dc2 with SMTP id
 x12-20020a056a20914c00b001a18bdc9dc2mr8921709pzc.31.1710178949094; 
 Mon, 11 Mar 2024 10:42:29 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:28 -0700 (PDT)
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
Subject: [PATCH v4 21/24] tests/avocado: reverse_debugging.py test
 auto-snapshot mode
Date: Tue, 12 Mar 2024 03:40:23 +1000
Message-ID: <20240311174026.2177152-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
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
 tests/avocado/reverse_debugging.py | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 4bf4e6e1e5..67b72ce519 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -32,9 +32,11 @@ class ReverseDebugging(LinuxKernelTest):
     that the execution is stopped at the last of them.
     """
 
-    timeout = 20
+    timeout = 30
     STEPS = 10
     endian_is_le = True
+    # x86-64 and aarch64 hang with autosnapshot so turn it off by default
+    autosnapshot = False
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
         logger = logging.getLogger('replay')
@@ -47,9 +49,14 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
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
@@ -184,8 +191,12 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
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
@@ -365,6 +376,7 @@ def test_ppc64_pseries(self):
         # to take the 'hit a breakpoint again' path. That's not a problem,
         # just slightly different than the other machines.
         self.endian_is_le = False
+        self.autosnapshot = True
         self.reverse_debugging()
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/1992
-- 
2.42.0


