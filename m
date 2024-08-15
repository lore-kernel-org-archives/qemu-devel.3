Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E14C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebnJ-0004LH-PZ; Thu, 15 Aug 2024 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn3-0003Tg-Is
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:25 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebn1-0000Dh-EN
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a309d1a788so1280888a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733362; x=1724338162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GlC9DIF5/JKDes/L5KgAf0CY2UX88jzKAHhIzM/8FI=;
 b=shfJg6BnSAzXePRmYEUPD+yAMCnFJtS4pebrhdhkZXDJDZ9v4/6M0URVi522DFJD/E
 F7KY/OzVI25iZBNzJfppJ+ggIqSg0UKmrhNVu6I3Q4+LAGxY+yqyJV405dYZoRyvmbHI
 nMlstNPnhJAcpHmwnh/oRtDs5rDZ7+yJo21o9Gvb10F1tnYHdtX3k5fxL6JNnLCcvir2
 K1H1+wgNPiNWC/rJnpsGp3UUpMB4zlYLCxWb7qBpdlJ9/KfWqyHTZxd2oEATNEvltpmZ
 Ue1uP+P0JqoBwfiXXRWOjmspRuhZc3gmd4uWL8VjC5umrrxhUVcMC5x+bsLov6i79eCD
 qJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733362; x=1724338162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GlC9DIF5/JKDes/L5KgAf0CY2UX88jzKAHhIzM/8FI=;
 b=xRmq+qsGzKG7c+LbYdYOav+sWeK/liMN4YyRMrJ+1cCBTNXKvjCtLqcOK1M6ZHzxrL
 OG7uFs2V8lDti0sCeOJZjyT8IRZkuF/QXYvNUaaqvBji8ojlF+p1IekZCNmIcM9a89xF
 S0YiPAs7zYASVvwIfZEZ2e3gaildDCNVPoEX/xZp6Oz/obYA92t7wJAJjiQYns/i+Cp8
 wTEz6lcX7am2XlCrTc+haNJ0uwyNRPQzmJuleBmPZJnvAl0WASKkzzQTmECTDIhLmM1s
 n5WViXZmPN2E8nFH1/CWflfJg6UnDVTEoBoaPyfwkCiwOss9GsZhypwoNBmG4mI4H3Ih
 BhoQ==
X-Gm-Message-State: AOJu0YzzvLyWc2MwApRQYrxZuUzyFZewbWwzH+ONQLs0EEh0/a4rIdpb
 vhvYktJbaoJZQcoqF1RutZrMXrHGRUCm6AJ6Wwpuw7asKsZRNF0ObB58KsK86Z3Bm4XqHbfoqhP
 m
X-Google-Smtp-Source: AGHT+IGgvsSlxO7bF8l2j62iweyr31Ounb8K+OodmdPj0zBP79s8zOkfZKaTslOaeUiG8gTdTMMXKg==
X-Received: by 2002:a17:907:d846:b0:a77:e55a:9e89 with SMTP id
 a640c23a62f3a-a8366ff435dmr421603466b.52.1723733360909; 
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383947b86sm113033866b.187.2024.08.15.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B65505FD21;
 Thu, 15 Aug 2024 15:49:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 11/21] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Date: Thu, 15 Aug 2024 15:49:01 +0100
Message-Id: <20240815144911.1931487-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nicholas Piggin <npiggin@gmail.com>

This runs replay-dump.py after recording a trace, and fails the test if
the script fails.

replay-dump.py is modified to exit with non-zero if an error is
encountered while parsing, to support this.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

gitlab with this change

v5: Update timeout to 180s because x86 was just exceeding 120s in
Message-Id: <20240813050638.446172-4-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-12-alex.bennee@linaro.org>

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
index 232d287c27..a668af9d36 100644
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
index b4673261ce..5916922435 100644
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
2.39.2


