Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899EDC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy44-0006xs-Sr; Tue, 13 Aug 2024 16:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3u-0006AI-NJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3T-0006Ho-Lo
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-429d2d7be1eso1435125e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580622; x=1724185422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jT/o7Fq8lZPjdt1o7XFYsUh6vWp3xGW473B+uKXLYg=;
 b=ItYhHMNgyc4ZPBZx4a1aL5GvVcXkh8HBoFJ9leBFoTymoK+hmYEVAlvrToaTkCuxOm
 e2NPBW62GK5MdazcahKkEyQ1zpCl+p6ZvfJR2t91JJuq8uGwGiC7Oke4XNplyCGVt6r+
 EbnBggsbNgN+HvGsSX5NO4Xrdbuh479zqH1xVMBwaFIIBBqmf9AGvEU1BBN6HpGu6tAu
 3hcY/+J2AeMowABxlzYcN+encjfbQ3b+PIf0+KPrmba2Tr/dwIKiKmk16djYP6DmKwdM
 vvnvAraZmowZUFBesS8sXC41+z26i/n9qy945Cix018nC8J1kkjDEZf+Nl7uBbFKgBB7
 +ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580622; x=1724185422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jT/o7Fq8lZPjdt1o7XFYsUh6vWp3xGW473B+uKXLYg=;
 b=SNnU8AzileNHgSA+QiAvARbgMEaoL+Z1DMvkyskaq0pUmlwxbdbTFOljq0zbLE28GD
 2NeoXQ+pjDBkl0vh+6kyBIMo23HGdykD9sWPsA1xw3AZkc/tFh6s9qtdp3FfS6t4EjW7
 hhZOMMEPqxguK8NdudXzJN9b5t+UWIyxh1mZrDhczjWaDnfKgthEqAcqM4F/EgLnhh8I
 8Cum5OHwh8V7Dr5axDIQFXo5kVkOqDxA/0k9MiOfx2qAk0ghp3CBopW+WKCIAnlwn2LS
 GRUh4DX4a6Gf4sRRvRaN3+DzB8jMZXHrFStgfv9mxKJzFhOquYWKahCGFngdoySo1fHz
 7yOg==
X-Gm-Message-State: AOJu0Yya39y19iDdKDzmIpvzjhLXATp85yG7Q39TSSosJ4mbL3x00rxJ
 G1hFnlrbZurwKzkwMMtTBp6GibDl60/uOz7pP7zfR0+lof7u87aI/bU8BWzjQ3E=
X-Google-Smtp-Source: AGHT+IFh9WpnsQXKqfTkD/SNN/9bnil5c9EFEmprDaSC1+n1Y4K+gggOSupWRHpgSXbMjKT3Mw2XNQ==
X-Received: by 2002:a05:600c:4689:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-429d62f6d77mr33720805e9.14.1723580621586; 
 Tue, 13 Aug 2024 13:23:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750ef58sm151364125e9.16.2024.08.13.13.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 707085FCE1;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 11/21] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Date: Tue, 13 Aug 2024 21:23:19 +0100
Message-Id: <20240813202329.1237572-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


