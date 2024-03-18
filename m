Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A4AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFCd-0002lH-5v; Mon, 18 Mar 2024 11:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCU-0002iU-QO
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:46:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCS-0007qk-Cm
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:46:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so3675198b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776815; x=1711381615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWOo89/EBibG8iMG/agMGDjbR7xyjWs28ccHoq9+4CA=;
 b=b/Q1AmHAV6/4HGeNtDJThM4IMQ8jZTb3k0PgMWSaGKqMRQxTTFBd9kyYHCMx8ArZFE
 3B0LifVtNgOCBjJjzUruFh1kEPp2o4qDL8ETLGNOK20xOtkxRLtvi2ZZ+ZH2hG3kjls7
 KjPc7QV7vGgcOs3USVEZkLqjC3zgigc3HU1YsfcknIdsjMBOIWpb9JvyhwqY+Kr0uEtP
 insiT8L9hlVlfiBtX3aFwsEH1qoSNpPfbHNIhajF6h7eiRmhaKLFjVzpCBP8RsN2INFF
 9oTlCVbI5OFedzIPC1owJZQ2ry49HNXT4RBEx5wvLSAD+BCwjIdK4Al87Tic0gj+Y0k2
 K7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776815; x=1711381615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWOo89/EBibG8iMG/agMGDjbR7xyjWs28ccHoq9+4CA=;
 b=HdE7cyD7RD5uZ2cZCBJ3BkJWtEhp/kkFPsp6APPQ/8O5nso4LD+5cRw7SUyml5wY6j
 VQEUxR/6FG11m09wTjGfbzeb9gOIgwWS+Yn8B02m9jNW9mZZ1jBrvqxwRLododMcovQc
 vQtvvYGYv7h90j4Jkhkqvc75YmutsjdQPBeveIt7NG/kgSrjQH7tmYwesVp8JDPIGKWQ
 ChwCw57KpD66P1sscMLu4B837KcUYD0ZRW/wwMhi+Z0pL2PjE12OVSYMWvV0GdkYPN3Y
 +310FD4EjTmEZkrmAZVYjPHLgg8VQHBPc67ZnIgA7BdXQ9tZje4K54eVUfGKsfJysXE1
 307A==
X-Gm-Message-State: AOJu0YwS+0/6dCkEs6vEPTeTvhURBktDl57abezYQbw01As2AMCLwqy9
 075MEDVBMliJqpM55F/o0k4ex6+fAvYbSsavd3FXkxKTsSctEE2IM2nntXhXG+s=
X-Google-Smtp-Source: AGHT+IG0tMnhWSl754DXZClCLjCPQTvdFEpyTzD79ySGKdmVNQZHMEkrpfBs28lPSxYAZn4QE0xoKw==
X-Received: by 2002:a05:6a20:c89b:b0:1a3:66e5:5c8f with SMTP id
 hb27-20020a056a20c89b00b001a366e55c8fmr2805111pzb.28.1710776809856; 
 Mon, 18 Mar 2024 08:46:49 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:46:49 -0700 (PDT)
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
Subject: [PATCH v5 03/24] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Date: Tue, 19 Mar 2024 01:46:00 +1000
Message-ID: <20240318154621.2361161-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This runs replay-dump.py after recording a trace, and fails the test if
the script fails.

replay-dump.py is modified to exit with non-zero if an error is
encountered while parsing, to support this.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py         |  6 ++++--
 tests/avocado/replay_kernel.py | 13 ++++++++++++-
 tests/avocado/replay_linux.py  | 10 ++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index b82659cfb6..4ce7ff51cc 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -21,6 +21,7 @@
 import argparse
 import struct
 import os
+import sys
 from collections import namedtuple
 from os import path
 
@@ -100,7 +101,7 @@ def call_decode(table, index, dumpfile):
         print("Could not decode index: %d" % (index))
         print("Entry is: %s" % (decoder))
         print("Decode Table is:\n%s" % (table))
-        return False
+        raise(Exception("unknown event"))
     else:
         return decoder.fn(decoder.eid, decoder.name, dumpfile)
 
@@ -121,7 +122,7 @@ def print_event(eid, name, string=None, event_count=None):
 def decode_unimp(eid, name, _unused_dumpfile):
     "Unimplemented decoder, will trigger exit"
     print("%s not handled - will now stop" % (name))
-    return False
+    raise(Exception("unhandled event"))
 
 def decode_plain(eid, name, _unused_dumpfile):
     "Plain events without additional data"
@@ -434,6 +435,7 @@ def decode_file(filename):
                                     dumpfile)
     except Exception as inst:
         print(f"error {inst}")
+        sys.exit(1)
 
     finally:
         print(f"Reached {dumpfile.tell()} of {dumpsize} bytes")
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 10d99403a4..22032f3230 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -13,6 +13,7 @@
 import shutil
 import logging
 import time
+import subprocess
 
 from avocado import skip
 from avocado import skipUnless
@@ -31,7 +32,7 @@ class ReplayKernelBase(LinuxKernelTest):
     terminates.
     """
 
-    timeout = 120
+    timeout = 180
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=1 panic=-1 '
 
     def run_vm(self, kernel_path, kernel_command_line, console_pattern,
@@ -63,6 +64,8 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
             vm.shutdown()
             logger.info('finished the recording with log size %s bytes'
                         % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
         else:
             vm.wait()
             logger.info('successfully finished the replay')
@@ -70,6 +73,14 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
         logger.info('elapsed time %.2f sec' % elapsed)
         return elapsed
 
+    def run_replay_dump(self, replay_path):
+        try:
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
     def run_rr(self, kernel_path, kernel_command_line, console_pattern,
                shift=7, args=None):
         replay_path = os.path.join(self.workdir, 'replay.bin')
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index f3a43dc98c..b3b91ddd9a 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -94,6 +94,8 @@ def launch_and_wait(self, record, args, shift):
             vm.shutdown()
             logger.info('finished the recording with log size %s bytes'
                 % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
             vm.wait()
@@ -108,6 +110,14 @@ def run_rr(self, args=None, shift=7):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
 
+    def run_replay_dump(self, replay_path):
+        try:
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
 @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
 class ReplayLinuxX8664(ReplayLinux):
     """
-- 
2.42.0


