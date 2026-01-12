Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF2C9EC91
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHv7-0005Jl-U6; Mon, 12 Jan 2026 08:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHui-0004i3-Nd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHug-0003vB-T9
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtfhL1a9UH5BQxL4ZZa3Nbu/LiMM+zNQx75TAiP+YNU=;
 b=eboW6U0io7X7yfed0wQDfeJvDBGZFTsCjoBu+eXgyLngepfgxOqi2w0fi7HHhRl21AiLjZ
 OB0DrW0xHUWWkrbwRQlMjBY71DNW13/AOWOlKsRmzAsVDIVU4wVk609BYS0mrEiE9FWFTC
 uYf4R/+1cnnTf6EvhKZjGrqDZ4pFGJc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AMzHkMnmMFyh4Ig-phMi6g-1; Mon, 12 Jan 2026 08:24:52 -0500
X-MC-Unique: AMzHkMnmMFyh4Ig-phMi6g-1
X-Mimecast-MFC-AGG-ID: AMzHkMnmMFyh4Ig-phMi6g_1768224291
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c196fa94049so2962147a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224291; x=1768829091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtfhL1a9UH5BQxL4ZZa3Nbu/LiMM+zNQx75TAiP+YNU=;
 b=MsO6/2hmNZ2lceFD4+qT+wEh9hG9nFhGEsTtjAfHYxvMHm0av+mUF8Bod5l/EBHqCg
 S8b8+gSUi5znjgCNHNwqF6T8KNKb6Etz7tCOr8VGTGuWumhx4AxwydmqIyJBVgVsIAny
 017vsWEJv3kdg5hCV+/l2gU2P5wxCVF4sTc/d+q/uHfjy/RPmExm5g3uDN3vwLTfknBM
 s3MrJ7BSKZNxlE3BDELxxQRosIhU5/m+chlS7i4BVJUIBHbQBWmKSgvklQrut1+Ukvzp
 2ZspVPP4EES9LXxpgq5eAT+U/YsFFxnFucc8oQkpoDU/WHLTA65GBan0ZhrIIVhV1JwW
 E2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224291; x=1768829091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AtfhL1a9UH5BQxL4ZZa3Nbu/LiMM+zNQx75TAiP+YNU=;
 b=vimXB/2g4rvqkqpsyNwW2YwjE/8EjeZ2BQoWkmK73HZm0B9/cyGlODpRoKUKIZWz8a
 fQdfi0YLIyfsYyulSP//Os7VSWBa8uI/E/o1TnD7nFWaeToU1eVLY6F5a1av0Dyt9gsQ
 PC5Rq54IchXLe7IsXlgyCPpeztTRAD/bhaKMNJFzcAA3DaTnqQUfuAUdQMX21ScgKMFo
 7dNLIrVVWigQYkKkgc6gPP8mp3fA6F8sFOz72B/7EMFwXQDzCycv5BGXeFCHffdAaN/7
 hd5aAA3aYYReMSqVsYTRBrSpbCkU9vBJh/iShFtW9KFCou2IORus6PbxNPpEqDXqxAl5
 Q/dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWTbvfLkiPDtzf1SkniBd9LtRB3x0xMWhq4G7hXxbA2+28USvymlGTmeekzZ88DNw/ua4p6EdGEc6d@nongnu.org
X-Gm-Message-State: AOJu0Yy6GwO+Aalf8TtljAxGGwug5hFZiYxzOgh/ESySCmBoy5xwrBvA
 rdXUliC0qnWW/HTA5NdcgdG0iDzDcc2yP9os0DltXbtXAzUfxSLtICbASMifaxSG4ibIKd5f1/K
 lG5OV8FynIAhLmA5M2+B2c/9gaj/fxdpd3eG2FQM579yY9HXQ2bGT0cFm
X-Gm-Gg: AY/fxX5qcLW9PQ7okCsGPhDcrDh5KYsOJLRhIHzOuE7agevH0Oaxwxe/w3xPE2iuR+E
 +OqhMSBWMjt2fRRxzzz3/WwdholVY29jK+tT8BmwRDx3Xwnp/7oh0R0Rw7ifpw+DArdw0u5iqzW
 5CChM4OL/f+WUUVM3CtmzRjin4174gl4bUO61re7f7PtnKHoU6mquZ2bq4Y57uDwIQut76ACVZY
 rYCXye1kpJoMrhn/vNNmpNs0EalnylHIs3IB69RsKcrEmbCh0B7HCtjVMRMSU1L+M5mm0x4IxvO
 hpczaPCUHWB3IAGwOWIzPHrn+g8vEWg4Y0wpJA4HNVK/YvUueAHtkFvlDWKhSTiVtu6qjWariX+
 uYVyv/Py0knovL/5uAw53o683drswTN7La53hdBfI7g4=
X-Received: by 2002:a05:6a20:bea6:b0:35e:caf1:78e3 with SMTP id
 adf61e73a8af0-38982a6c207mr20155515637.11.1768224290909; 
 Mon, 12 Jan 2026 05:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY96bXNi4Bk++gexllrMsPS4J2NVfumHo947OsHBS3l13oBtBVibDqWvmb/E+ZxlJoiGC46g==
X-Received: by 2002:a05:6a20:bea6:b0:35e:caf1:78e3 with SMTP id
 adf61e73a8af0-38982a6c207mr20155496637.11.1768224290504; 
 Mon, 12 Jan 2026 05:24:50 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:50 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <aniisnha@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 32/32] tests/functional/x86_64: add functional test to
 exercise vm fd change on reset
Date: Mon, 12 Jan 2026 18:52:45 +0530
Message-ID: <20260112132259.76855-33-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A new functional test is added that exercises the code changes related to
closing of the old KVM VM file descriptor and opening a new one upon VM reset.
This normally happens when confidential guests are resetted but for
non-confidential guests, we use a special machine specific debug/test parameter
'x-change-vmfd-on-reset' to enable this behavior.
Only specific code changes related to re-initialization of SEV-ES, SEV-SNP and
TDX platforms are not exercized in this test as they require hardware that
supports running confidential guests.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                                   |  6 ++
 tests/functional/x86_64/meson.build           |  1 +
 .../x86_64/test_vmfd_change_reboot.py         | 75 +++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a55b649e8..11871fdd35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -150,6 +150,12 @@ F: tools/i386/
 F: tests/functional/i386/
 F: tests/functional/x86_64/
 
+X86 VM file descriptor change on reset test
+M: Ani Sinha <aniisnha@redhat.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: tests/functional/x86_64/test_vmfd_change_reboot.py
+
 Guest CPU cores (TCG)
 ---------------------
 Overall TCG CPUs
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index f78eec5e6c..784d9791cb 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -36,4 +36,5 @@ tests_x86_64_system_thorough = [
   'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
+  'vmfd_change_reboot',
 ]
diff --git a/tests/functional/x86_64/test_vmfd_change_reboot.py b/tests/functional/x86_64/test_vmfd_change_reboot.py
new file mode 100755
index 0000000000..3b33322880
--- /dev/null
+++ b/tests/functional/x86_64/test_vmfd_change_reboot.py
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+#
+# KVM VM file descriptor change on reset test
+#
+# Copyright © 2026 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from qemu.machine import machine
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+class KVMGuest(QemuSystemTest):
+
+    ASSET_UKI = Asset('https://gitlab.com/anisinha/misc-artifacts/'
+                      '-/raw/main/uki.x86-64.efi?ref_type=heads',
+                      'e0f806bd1fa24111312e1fe849d2ee69808d4343930a5'
+                      'dc8c1688da17c65f576')
+    ASSET_OVMF = Asset('https://gitlab.com/anisinha/misc-artifacts/'
+                       '-/raw/main/OVMF.stateless.fd?ref_type=heads',
+                       '58a4275aafa8774bd6b1540adceae4ea434b8db75b476'
+                       '11839ff47be88cfcf22')
+
+    def common_vm_setup(self):
+        self.require_accelerator("kvm")
+
+        self.vm.set_console()
+
+        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-smp", "2")
+        self.vm.add_args("-cpu", "host")
+        self.vm.add_args("-m", "2G")
+        self.vm.add_args("-nographic", "-nodefaults")
+
+        self.uki_path = self.ASSET_UKI.fetch()
+        self.ovmf_path = self.ASSET_OVMF.fetch()
+
+    def run_and_check(self):
+        self.vm.add_args('-kernel', self.uki_path)
+        self.vm.add_args("-bios", self.ovmf_path)
+        # enable KVM VMFD change on reset for a non-coco VM
+        self.vm.add_args("-machine", "q35,x-change-vmfd-on-reset=on")
+        # enable tracing
+        self.vm.add_args("-d", "trace:kvm_reset_vmfd")
+
+        try:
+            self.vm.launch()
+        except machine.VMLaunchFailure as e:
+            raise e
+
+        self.log.info('VM launched')
+        console_pattern = 'bash-5.1#'
+        wait_for_console_pattern(self, console_pattern)
+        self.log.info('VM ready with a bash prompt')
+
+        exec_command_and_wait_for_pattern(self, '/usr/sbin/reboot -f',
+                                          'reboot: machine restart')
+        console_pattern = '# --- Hello world ---'
+        wait_for_console_pattern(self, console_pattern)
+        self.vm.shutdown()
+        self.assertRegex(self.vm.get_log(),
+                         r'kvm_reset_vmfd \nINFO: virtual machine accel file '
+                         'descriptor has changed')
+
+    def test_vmfd_change_on_reset(self):
+        self.common_vm_setup()
+        self.run_and_check()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.42.0


