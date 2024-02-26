Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D948C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWNS-0002GU-Ip; Mon, 26 Feb 2024 03:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNQ-0002Fw-Ms
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNO-0005el-Un
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:20 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc9222b337so9726195ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936217; x=1709541017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4W5DY/vLpNma2B3R605j+yEYtsdahqUXWCi7dM9lkhE=;
 b=DgKRyFeb04hyNciagcqrpSiJqXTuec6Nh3RMXBaN+wMMwP3p2l+FtMRAKwyx/JpMBp
 DOsdPC/uKI5Mq2xBTG47h9ETj+B8VLn+7L6kEe6/FQyPkL5O1wZAvVuS57b1AehhhwVX
 TXylOg97FBe6xrs29hmf3cySswNPfeGxmHucY1aMWQnyEuWJyxFAizEXuNQ1Py8cZLQj
 oTWMIMf5qzvbpLVIWqwyWS3qxFu19GYOFcbPwOltXm9mN4juSfNG2YZKJ/414SOupNTT
 BUBOCdSKmia2Ge4DcoUBdT4uwJjW5rV2/0MbRNBxEQAhKMyFzMvpqC/WR2561AfoQwHz
 cTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936217; x=1709541017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4W5DY/vLpNma2B3R605j+yEYtsdahqUXWCi7dM9lkhE=;
 b=eMu8FUDolX1TvxLsbhTgF4dlkapgttbWsgsHjG+Gh8dFs3CG0OuiKS1XSwj/DvxzaM
 BDDOAGOEV4VVFgZAP4i8st9ftXAoyjva8qyfZwHvX878K627cxYv2qF0KQ+pGDZQ0ecS
 DyxkaZlb8DIfGlGAOAEYXlHNRE0kopjswCQWEYhArknVhZP0nE9lbj+Iyh1xmbG76jZX
 xjN5Ohbbox3cdHjevZsUr83pWb7NH9uGlKmLoC/mvwus5qNHrTib00zlk5L/jHLcrwFA
 p8DFUEKRVeks5ejCWX3TtHL/YL9JU7Dv+87gpYaMlJSIrq13eH8Yds+TZtJSgHUPBfyF
 udaQ==
X-Gm-Message-State: AOJu0Yyseog8k1J6KD4ffANeEKYn8McTBR5LmL96oOdl0Q5RCIpVJA7v
 HJ9kSbmz/S0TPwVcPB+VcPt2XExCFHfwRrMvQELI01xeuGajSfQ6wGG4PlOJ
X-Google-Smtp-Source: AGHT+IGa6OUbcZXcaRjPLkXHTR540fCSVhTbmEq6AlF6ghYx1e1WCWAEzREcfnh0cu1N96gZ3OudyA==
X-Received: by 2002:a17:903:489:b0:1db:cbff:df15 with SMTP id
 jj9-20020a170903048900b001dbcbffdf15mr6538051plb.9.1708936217121; 
 Mon, 26 Feb 2024 00:30:17 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:16 -0800 (PST)
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
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 3/9] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Date: Mon, 26 Feb 2024 18:29:39 +1000
Message-ID: <20240226082945.1452499-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py         |  6 ++++--
 tests/avocado/replay_kernel.py | 16 ++++++++++++++++
 tests/avocado/replay_linux.py  | 15 +++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

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
index 10d99403a4..9b3ee6726b 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -13,6 +13,7 @@
 import shutil
 import logging
 import time
+import subprocess
 
 from avocado import skip
 from avocado import skipUnless
@@ -22,6 +23,11 @@
 from avocado.utils import process
 from boot_linux_console import LinuxKernelTest
 
+from pathlib import Path
+
+self_dir = Path(__file__).parent
+src_dir = self_dir.parent.parent
+
 class ReplayKernelBase(LinuxKernelTest):
     """
     Boots a Linux kernel in record mode and checks that the console
@@ -63,6 +69,8 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
             vm.shutdown()
             logger.info('finished the recording with log size %s bytes'
                         % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
         else:
             vm.wait()
             logger.info('successfully finished the replay')
@@ -70,6 +78,14 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
         logger.info('elapsed time %.2f sec' % elapsed)
         return elapsed
 
+    def run_replay_dump(self, replay_path):
+        try:
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  cwd=src_dir, stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
     def run_rr(self, kernel_path, kernel_command_line, console_pattern,
                shift=7, args=None):
         replay_path = os.path.join(self.workdir, 'replay.bin')
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index f3a43dc98c..e4539c5551 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -21,6 +21,11 @@
 from avocado.utils.path import find_command
 from avocado_qemu import LinuxTest
 
+from pathlib import Path
+
+self_dir = Path(__file__).parent
+src_dir = self_dir.parent.parent
+
 class ReplayLinux(LinuxTest):
     """
     Boots a Linux system, checking for a successful initialization
@@ -94,6 +99,8 @@ def launch_and_wait(self, record, args, shift):
             vm.shutdown()
             logger.info('finished the recording with log size %s bytes'
                 % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
             vm.wait()
@@ -108,6 +115,14 @@ def run_rr(self, args=None, shift=7):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
 
+    def run_replay_dump(self, replay_path):
+        try:
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  cwd=src_dir, stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
 @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
 class ReplayLinuxX8664(ReplayLinux):
     """
-- 
2.42.0


