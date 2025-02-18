Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64430C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPW8-0007zO-RX; Tue, 18 Feb 2025 10:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPW5-0007ur-Mo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPW3-00083G-KM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRfKvGR+8jAFT6+AmAAHyKeK5vSHfj38tAANfksM8iE=;
 b=OHZf3w9fepxwKuskfiVeonsQlPj5CNut1+g9z9RR2SZ5uCZAWbZ/WrQ2mfA+60eqQf2sQ+
 j5dVRhVBShsPT4TCwYvDbfJduwva5M+ghvuJs2LaPZRM05pBact7KtIaaewhuZYa93HogQ
 hUTdvhu8HiIrV+B32E4Mj7/MapLi0Ss=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-gk-WQ32mP4WZrsM-vUhuTA-1; Tue,
 18 Feb 2025 10:28:03 -0500
X-MC-Unique: gk-WQ32mP4WZrsM-vUhuTA-1
X-Mimecast-MFC-AGG-ID: gk-WQ32mP4WZrsM-vUhuTA_1739892482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 758C31801A17; Tue, 18 Feb 2025 15:28:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F83D1800359; Tue, 18 Feb 2025 15:27:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/14] tests/functional: Convert the 32-bit ppc replay avocado
 tests
Date: Tue, 18 Feb 2025 16:27:34 +0100
Message-ID: <20250218152744.228335-5-thuth@redhat.com>
In-Reply-To: <20250218152744.228335-1-thuth@redhat.com>
References: <20250218152744.228335-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Put the tests into a separate file now (since in the functional
framework, each file is run with one specific qemu-system-* binary).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/replay_kernel.py      | 24 --------------------
 tests/functional/meson.build        |  1 +
 tests/functional/test_ppc_replay.py | 34 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 24 deletions(-)
 create mode 100755 tests/functional/test_ppc_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 412bf9e06e1..89ba6bb3e8b 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -363,27 +363,3 @@ def test_or1k_sim(self):
                    '/qac-best-of-multiarch/download/day20.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'vmlinux')
-
-    def test_ppc_g3beige(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:g3beige
-        """
-        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day15.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'invaders.elf',
-                                 args=('-M', 'graphics=off'))
-
-    def test_ppc_mac99(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:mac99
-        """
-        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day15.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'invaders.elf',
-                                 args=('-M', 'graphics=off'))
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index fec140ee1fe..15ead47769c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -199,6 +199,7 @@ tests_ppc_system_thorough = [
   'ppc_bamboo',
   'ppc_mac',
   'ppc_mpc8544ds',
+  'ppc_replay',
   'ppc_sam460ex',
   'ppc_tuxrun',
   'ppc_virtex_ml507',
diff --git a/tests/functional/test_ppc_replay.py b/tests/functional/test_ppc_replay.py
new file mode 100755
index 00000000000..8382070abd1
--- /dev/null
+++ b/tests/functional/test_ppc_replay.py
@@ -0,0 +1,34 @@
+#!/usr/bin/env python3
+#
+# Replay tests for ppc machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class PpcReplay(ReplayKernelBase):
+
+    ASSET_DAY15 = Asset(
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day15.tar.xz',
+        '03e0757c131d2959decf293a3572d3b96c5a53587165bf05ce41b2818a2bccd5')
+
+    def do_day15_test(self):
+        self.require_accelerator("tcg")
+        kernel_path = self.archive_extract(self.ASSET_DAY15,
+                                           member='day15/invaders.elf')
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar', args=('-M', 'graphics=off'))
+
+    def test_g3beige(self):
+        self.set_machine('g3beige')
+        self.do_day15_test()
+
+    def test_mac99(self):
+        self.set_machine('mac99')
+        self.do_day15_test()
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


