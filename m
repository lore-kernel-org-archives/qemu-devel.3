Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BFFC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeA-0002T0-Kf; Mon, 11 Mar 2024 13:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjdy-0002Rd-SG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjdv-0007Gi-Dz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:40:56 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e5760eeb7aso3333514b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178854; x=1710783654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8pTdHOu/KkX0pwRoNGA2mZXJ19/ldsaYMuXilqmIPg=;
 b=JelzcW+ML4w6Uiiftu3se+PVGmF1mQhgmO6nyYYe5fis0fUrfzECcEFsR3voqU8ryh
 1x6ubPqRRv8LJ8PqG81ecfOMIRzoWDJN3/2H5c8FTpIqofk6yvNlKQmuNKpDkfMb0m2P
 1QI3Vym/Vhrzu/9XPhdvsqNmd/2EeO8n+RrSmRS3ftjj0BQgt42cl9JeoPqENC7qW3rO
 6HGiJAXpSjrHILolduFsGFbqMMOCMzjPYt+wapnyaejHKJWKAEu8QRkNLSeu21yup9zz
 sa1JhH9mdcAUG2ux6ToS71H9qKyqE+WZ2Zv8twr+fFjwdQYO0zs0ocstnJyrFxgnS1w6
 /Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178854; x=1710783654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8pTdHOu/KkX0pwRoNGA2mZXJ19/ldsaYMuXilqmIPg=;
 b=sb67ZqeuKclQM63cO1ZQC6qjtSmhuvluE+JC58UVCP0QKL0sclfapAiSy7UWpEalMd
 o5FcGMlvrJwEn9goE+UNnDAEv0zar2/rj6m6OVcXnzbsMbaTss1WaDBfSxMNBx/ghOHU
 K+XH6Tqm6zHsUQrV1j4oLu3RHue8xVZ57ljTrFGxldBh0gI1vOVc7d1W/up61QydreEj
 2Mt5S17F6Z+NYic6YZjd50Rv1vlD0nMLwQN3H9xSsQNyah1gKpjOlX4fU1A65rdYDLFF
 IWUQcB1TbHwxBsHxCGqARdba6Z4A9VSM/bPeudsjSguNA1YJ+PqLGRrefpsK5WM0ntb8
 sqUA==
X-Gm-Message-State: AOJu0Ywa59yma8Uq94jeXcK4ywnnQShFKndJfdSA/Db112Q94HlXub7M
 exxiu2PE0A1rxe8Fvnn2GO3ONGmhUWEur79tnz6GkIgZvl5vvFXi3+nJoUsotws=
X-Google-Smtp-Source: AGHT+IGh2TZiYexDEXrWEPDhN2KGU3JWtYh+3S9FbRP4OEpZ3EaImwFAwix38Ra+7QCfRql1bNKRAQ==
X-Received: by 2002:a05:6a21:1a0:b0:1a1:8c28:c4a0 with SMTP id
 le32-20020a056a2101a000b001a18c28c4a0mr8694629pzb.30.1710178853701; 
 Mon, 11 Mar 2024 10:40:53 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:40:53 -0700 (PDT)
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
Subject: [PATCH v4 03/24] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Date: Tue, 12 Mar 2024 03:40:05 +1000
Message-ID: <20240311174026.2177152-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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
 tests/avocado/replay_kernel.py | 11 +++++++++++
 tests/avocado/replay_linux.py  | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

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
index 10d99403a4..2b61ed21d8 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -13,6 +13,7 @@
 import shutil
 import logging
 import time
+import subprocess
 
 from avocado import skip
 from avocado import skipUnless
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


