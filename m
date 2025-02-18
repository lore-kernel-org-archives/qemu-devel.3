Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699A9C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPW8-0007y7-BL; Tue, 18 Feb 2025 10:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPW4-0007uf-QK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPW2-00082T-Dw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrzRQsmUSg26RJKvK/yk2RAmkG2ovAevp+Stcf8fqMU=;
 b=cXN9QEXX38GxtC1wP57qrRLPn90QXyVytM9j4Juch7dt/15MyeaBGoe3rpNL9BiI9tQSFo
 DIny/6dTkyvurmpfLq2Qmj1sIYk2aQ7RKVuuVSElydGum/H4MlfNOShzXC3nf/3SO0YNwV
 dsJA5PKWwJbo02omjOOrHup5V9m+kYI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-Gjlzz2oDOzCxDE1sY_Cnbw-1; Tue,
 18 Feb 2025 10:27:58 -0500
X-MC-Unique: Gjlzz2oDOzCxDE1sY_Cnbw-1
X-Mimecast-MFC-AGG-ID: Gjlzz2oDOzCxDE1sY_Cnbw_1739892477
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C64E1800570; Tue, 18 Feb 2025 15:27:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31EC81800359; Tue, 18 Feb 2025 15:27:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/14] tests/functional: Convert the sparc replay avocado test
Date: Tue, 18 Feb 2025 16:27:33 +0100
Message-ID: <20250218152744.228335-4-thuth@redhat.com>
In-Reply-To: <20250218152744.228335-1-thuth@redhat.com>
References: <20250218152744.228335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While we're at it, change the machine from SS-20 to SS-10 to
increase the test coverage a little bit (SS-20 is already
tested in the test_sparc_sun4m.py file).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py        | 12 ------------
 tests/functional/meson.build          |  1 +
 tests/functional/test_sparc_replay.py | 27 +++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)
 create mode 100755 tests/functional/test_sparc_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 54b8417d3d5..412bf9e06e1 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -387,15 +387,3 @@ def test_ppc_mac99(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'invaders.elf',
                                  args=('-M', 'graphics=off'))
-
-    def test_sparc_ss20(self):
-        """
-        :avocado: tags=arch:sparc
-        :avocado: tags=machine:SS-20
-        """
-        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day11.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'zImage.elf')
-
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ca57497174f..fec140ee1fe 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -260,6 +260,7 @@ tests_sparc_system_quick = [
 ]
 
 tests_sparc_system_thorough = [
+  'sparc_replay',
   'sparc_sun4m',
 ]
 
diff --git a/tests/functional/test_sparc_replay.py b/tests/functional/test_sparc_replay.py
new file mode 100755
index 00000000000..865d6486f99
--- /dev/null
+++ b/tests/functional/test_sparc_replay.py
@@ -0,0 +1,27 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on a sparc sun4m machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class SparcReplay(ReplayKernelBase):
+
+    ASSET_DAY11 = Asset(
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day11.tar.xz',
+        'c776533ba756bf4dd3f1fc4c024fb50ef0d853e05c5f5ddf0900a32d1eaa49e0')
+
+    def test_replay(self):
+        self.set_machine('SS-10')
+        kernel_path = self.archive_extract(self.ASSET_DAY11,
+                                           member="day11/zImage.elf")
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar')
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


