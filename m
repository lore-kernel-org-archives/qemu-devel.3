Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3419EC021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEBF-0003lz-OX; Wed, 26 Feb 2025 04:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEBA-0003hE-Gb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEB1-00088C-Qm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSERffrpfYEoAfw1ldo2O2dJQsT+VdHRt+CLn44vlac=;
 b=YqP61ut+fPcyzAPLd9UArDRgdBGEUnVuc37mUlY/iX2LXbFDI0QQHEFrF4hp9fa3Fl/dwr
 K/0R+eOUlMl9rAM9xnf72upCKTcyW997kFmj2emM+D48mBaytBc0aeOapo5MeBf3GarMnr
 +Ua93Tir/m+xLZRdt+X2fVgucUezNbE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-bYPayA7yO0CcwOJWOIO94Q-1; Wed,
 26 Feb 2025 04:57:57 -0500
X-MC-Unique: bYPayA7yO0CcwOJWOIO94Q-1
X-Mimecast-MFC-AGG-ID: bYPayA7yO0CcwOJWOIO94Q_1740563876
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9202619783B3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:57:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DE33180035E; Wed, 26 Feb 2025 09:57:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 09/18] tests/functional: Convert the microblaze replay avocado
 tests
Date: Wed, 26 Feb 2025 10:57:22 +0100
Message-ID: <20250226095731.1172375-10-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Put the tests into a separate file now (since in the functional
framework, each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250218152744.228335-8-thuth@redhat.com>
---
 tests/avocado/replay_kernel.py             | 11 ---------
 tests/functional/meson.build               |  1 +
 tests/functional/test_microblaze_replay.py | 28 ++++++++++++++++++++++
 3 files changed, 29 insertions(+), 11 deletions(-)
 create mode 100755 tests/functional/test_microblaze_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 397f7500463..b2097afc302 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -296,14 +296,3 @@ def test_m68k_mcf5208evb(self):
                    '/qac-best-of-multiarch/download/day07.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
-
-    def test_microblaze_s3adsp1800(self):
-        """
-        :avocado: tags=arch:microblaze
-        :avocado: tags=machine:petalogix-s3adsp1800
-        """
-        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day17.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'ballerina.bin')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b68b4da6a3d..58f12f54d14 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -152,6 +152,7 @@ tests_m68k_system_thorough = [
 ]
 
 tests_microblaze_system_thorough = [
+  'microblaze_replay',
   'microblaze_s3adsp1800'
 ]
 
diff --git a/tests/functional/test_microblaze_replay.py b/tests/functional/test_microblaze_replay.py
new file mode 100755
index 00000000000..7484c4186f3
--- /dev/null
+++ b/tests/functional/test_microblaze_replay.py
@@ -0,0 +1,28 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on an microblaze machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class MicroblazeReplay(ReplayKernelBase):
+
+    ASSET_DAY17 = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day17.tar.xz'),
+        '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
+
+    def test_microblaze_s3adsp1800(self):
+        self.set_machine('petalogix-s3adsp1800')
+        kernel_path = self.archive_extract(self.ASSET_DAY17,
+                                           member='day17/ballerina.bin')
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar')
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


