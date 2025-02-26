Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81661C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEBP-0003v6-Ah; Wed, 26 Feb 2025 04:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEBA-0003hh-Lw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEB6-00088g-G0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbpZbhX5LbRfzG6MxMmxS+H4h4+M3IbECVmgzhGt7Qo=;
 b=gfp6WSymyb/YabsM1OdVCsM4t+PNekDgDYbtxQ76tAz5+TRUEWTfzflWLa3DrVQ1mBlmbJ
 NTDYl9CliCaj3XXFASojDwtSTl4YptFBDwcg2lqC8C4niSGO4slPeFo/0gh9OgUamUwBfa
 /S0CQn0J69/yyZ95wEWA2SM/RiUQU74=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-7uOv2NcuMvmyimspDMVwqg-1; Wed,
 26 Feb 2025 04:58:05 -0500
X-MC-Unique: 7uOv2NcuMvmyimspDMVwqg-1
X-Mimecast-MFC-AGG-ID: 7uOv2NcuMvmyimspDMVwqg_1740563885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11F0A1800872
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:58:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B44C91800358; Wed, 26 Feb 2025 09:58:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 13/18] tests/functional: Convert the s390x replay avocado tests
Date: Wed, 26 Feb 2025 10:57:26 +0100
Message-ID: <20250226095731.1172375-14-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Put the tests into a separate file now (in the functional framework,
each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250218152744.228335-12-thuth@redhat.com>
---
 tests/avocado/replay_kernel.py        | 15 --------------
 tests/functional/meson.build          |  1 +
 tests/functional/test_s390x_replay.py | 28 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 15 deletions(-)
 create mode 100755 tests/functional/test_s390x_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 4347d202742..49543604613 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -161,18 +161,3 @@ def test_aarch64_virt(self):
         console_pattern = 'VFS: Cannot open root device'
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
-
-    def test_s390x_s390_ccw_virtio(self):
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/29/Everything/s390x/os/images'
-                      '/kernel.img')
-        kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=sclp0'
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=9)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e8b934d7f5f..acab5364281 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -248,6 +248,7 @@ tests_rx_system_thorough = [
 
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
+  's390x_replay',
   's390x_topology',
   's390x_tuxrun',
 ]
diff --git a/tests/functional/test_s390x_replay.py b/tests/functional/test_s390x_replay.py
new file mode 100755
index 00000000000..33b5843adae
--- /dev/null
+++ b/tests/functional/test_s390x_replay.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on an s390x machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class S390xReplay(ReplayKernelBase):
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+         'releases/29/Everything/s390x/os/images/kernel.img'),
+        'dace03b8ae0c9f670ebb9b8d6ce5eb24b62987f346de8f1300a439bb00bb99e7')
+
+    def test_s390_ccw_virtio(self):
+        self.set_machine('s390-ccw-virtio')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=sclp0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=9)
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


