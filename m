Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE2C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFEQ-00032x-Is; Mon, 18 Mar 2024 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFEO-0002pd-KT
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:56 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFEM-0008C4-1p
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:56 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5a128e202b6so1717181eaf.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776932; x=1711381732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqoDDKkP+GbOfzk7xNz1OzEz1n2vIN3Se8uMqMxNw8A=;
 b=PwlFhFRautb4/dSLLZ3x6LdiBuOnQfJRP/YGKTF7NrjrEaCZYXUdvWnSd15jCPC9TN
 Hq6V5Zi7yS7FIYHpabA3Qq5fFQC6Fl8WhCKlPt6D8UvoYR5734hYp0L9r40YenFPoHKF
 1fJUjZQKv03GIFXk33flZ7cf9DtT22ducOEBtZabZKw8lehGXfQN1WqS5xcTGXJ+76nO
 5wtgH47oOQKZB/xxXBH6GO3gej1EGcYhVIK7VtDbNDHKvyV61xc2UPaSM0Le0t588rU/
 MZJB81LnevsnzL6LAN/LjYUgMMvrMfiN7VBbh5bHoM2OqgPjIxsLnLxNOrO5gnZ5cuF/
 mEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776932; x=1711381732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqoDDKkP+GbOfzk7xNz1OzEz1n2vIN3Se8uMqMxNw8A=;
 b=So1/P5KFLBLlzVqVqDwW78mpTE1nq8fyxqDYfW2Oc6Rvk29OpL9Ht9Z20kPQKUmOvT
 mKDy8pOkxOiDSFs8sjlAE3OhMuYz0WMHfOPtI0+sAu/AulhlLyX5dp0HX+ZMN3jL0468
 Q1dlzpBp/yh89AUTYVtnezc4gzojlqI4OshwqTJI6STQlnPWxi7JXCSo6KpWSvFrdGuT
 Ibl6pgfG2ul93cdiwLMyw2afyOhLeVihfvAlhaBL3IFB35Hhcs9NopaCkOAaoh2Ex75Z
 sNXXWuyqZW/yb+CnjzCU93TX5v0FKg7mDVymLnfRZFCdCwASBHYU0Ed2Eje1G3QtzHWu
 yd3w==
X-Gm-Message-State: AOJu0YyngBrVJpg3lffo2VT8KsiCTqmurv+dJV4Fi2eFPZ3sb0Hrj1sB
 LO7fSgW3KvvNF2ArKcISR4fiHqR10QhXrB0eetxOzNCqFrhM5HV13t4279glfz0=
X-Google-Smtp-Source: AGHT+IEdUnAgVzoQO7p6ZHSWnEE/I/zlzFc90WHOj+y3XTxBGMP/hMRiJOWu02fYV64aHwtzjIfYLQ==
X-Received: by 2002:a05:6358:5e81:b0:17e:6bfc:b31d with SMTP id
 z1-20020a0563585e8100b0017e6bfcb31dmr38736rwn.0.1710776932612; 
 Mon, 18 Mar 2024 08:48:52 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:52 -0700 (PDT)
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
Subject: [PATCH v5 24/24] tests/avocado: replay_linux.py add ppc64 pseries test
Date: Tue, 19 Mar 2024 01:46:21 +1000
Message-ID: <20240318154621.2361161-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc36.google.com
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

Add a ppc64 pseries test. IO in SLOF is very slow when running in
record-replay modes, so this test uses guestfish to extract the
kernel and initrd and boot them directly, bypassing SLOF.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_linux.py | 72 ++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index b3b74a367c..565a600130 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -11,8 +11,9 @@
 import os
 import logging
 import time
+import subprocess
 
-from avocado import skipUnless
+from avocado import skipIf, skipUnless
 from avocado_qemu import BUILD_DIR
 from avocado.utils import cloudinit
 from avocado.utils import network
@@ -55,6 +56,8 @@ def vm_add_disk(self, vm, path, id, device):
             '%s,drive=disk%s-rr%s' % (device, id, bus_string))
 
     def vm_add_cdrom(self, vm, path, id, device):
+        vm.add_args('-device',
+            '%s,drive=disk%s' % (device, id))
         vm.add_args('-drive', 'file=%s,id=disk%s,if=none,media=cdrom' % (path, id))
 
     def launch_and_wait(self, record, args, shift):
@@ -208,3 +211,70 @@ def test_virt_gicv3(self):
         self.run_rr(shift=3,
                     args=(*self.get_common_args(),
                           "-machine", "virt,gic-version=3"))
+
+# ppc64 pseries test.
+#
+# This machine tends to fail replay and hang very close to the end of the
+# trace, with missing events, which is still an open issue.
+#
+# spapr-scsi IO driven by SLOF/grub is extremely slow in record/replay mode,
+# so jump through some hoops to boot the kernel directly. With this, the test
+# runs in about 5 minutes (modulo hang), which suggests other machines may
+# have similar issues and could benefit from bypassing bootloaders.
+#
+ppc_deps = ["guestfish"] # dependent tools needed in the test setup/box.
+
+def which(tool):
+    """ looks up the full path for @tool, returns None if not found
+        or if @tool does not have executable permissions.
+    """
+    paths=os.getenv('PATH')
+    for p in paths.split(os.path.pathsep):
+        p = os.path.join(p, tool)
+        if os.path.exists(p) and os.access(p, os.X_OK):
+            return p
+    return None
+
+def ppc_missing_deps():
+    """ returns True if any of the test dependent tools are absent.
+    """
+    for dep in ppc_deps:
+        if which(dep) is None:
+            return True
+    return False
+
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+class ReplayLinuxPPC64(ReplayLinux):
+    """
+    :avocado: tags=arch:ppc64
+    :avocado: tags=accel:tcg
+    """
+
+    hdd = 'virtio-blk-pci'
+    cd = 'scsi-cd'
+    bus = None
+
+    def setUp(self):
+        super().setUp()
+
+        if not ppc_missing_deps():
+            # kernel, initramfs, and kernel cmdline are all taken by hand from
+            # the Fedora image.
+            self.kernel="vmlinuz-5.3.7-301.fc31.ppc64le"
+            self.initramfs="initramfs-5.3.7-301.fc31.ppc64le.img"
+            cmd = "guestfish --ro -a %s run " ": mount /dev/sda2 / " ": copy-out /boot/%s %s " ": copy-out /boot/%s %s " % (self.boot_path, self.kernel, self.workdir, self.initramfs, self.workdir)
+            subprocess.run(cmd.split())
+
+    @skipIf(ppc_missing_deps(), 'dependencies (%s) not installed' % ','.join(ppc_deps))
+    def test_pseries(self):
+        """
+        :avocado: tags=machine:pseries
+        """
+        kernel=os.path.normpath(os.path.join(self.workdir, self.kernel))
+        initramfs=os.path.normpath(os.path.join(self.workdir, self.initramfs))
+        cmdline="root=UUID=8a409ee6-3cb3-4b06-a266-39e2dae3e5fa ro no_timer_check net.fnames=0 console=tty1 console=ttyS0,115200n8"
+        self.run_rr(shift=3, args=("-device", "spapr-vscsi",
+                                   "-machine", "x-vof=on",
+                                   "-kernel", kernel,
+                                   "-initrd", initramfs,
+                                   "-append", cmdline))
-- 
2.42.0


