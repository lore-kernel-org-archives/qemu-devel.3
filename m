Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D6FC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPWx-00005H-PG; Tue, 18 Feb 2025 10:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWJ-00084V-4t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkPWG-0008AZ-8K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739892497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtRYsFYzDorC87+C3I+37TZhssiVs7RVySk+kixGxdg=;
 b=B/3qNX7RCJN0kMZPHxNHqHlMgSxex2Fi0/8O9GVdwraWI2nxOIQ0A66RHcaVqSw90vy+Kg
 7pA5BkwIMBsQPJ7yHiFjHtZML7e5RyPACfAokpEkjQqbVosnDPG/9700nx9vu6UHPXFW7U
 GoSq8JLdQIuVmHEefypATFHiTsdm6ZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-J0B06tXVPV-f9UUMNyT09Q-1; Tue,
 18 Feb 2025 10:28:05 -0500
X-MC-Unique: J0B06tXVPV-f9UUMNyT09Q-1
X-Mimecast-MFC-AGG-ID: J0B06tXVPV-f9UUMNyT09Q_1739892484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 927A81801A17; Tue, 18 Feb 2025 15:28:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.187])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 083B11800362; Tue, 18 Feb 2025 15:28:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/14] tests/functional: Convert the or1k replay avocado tests
Date: Tue, 18 Feb 2025 16:27:35 +0100
Message-ID: <20250218152744.228335-6-thuth@redhat.com>
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
 tests/avocado/replay_kernel.py       | 11 -----------
 tests/functional/meson.build         |  1 +
 tests/functional/test_or1k_replay.py | 27 +++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 11 deletions(-)
 create mode 100755 tests/functional/test_or1k_replay.py

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 89ba6bb3e8b..ef72b1622e4 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -352,14 +352,3 @@ def test_ppc64_e500(self):
                    '/qac-best-of-multiarch/download/day19.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'uImage')
-
-    def test_or1k_sim(self):
-        """
-        :avocado: tags=arch:or1k
-        :avocado: tags=machine:or1k-sim
-        """
-        tar_hash = '20334cdaf386108c530ff0badaecc955693027dd'
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day20.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        self.do_test_advcal_2018(file_path, 'vmlinux')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 15ead47769c..1c9fe67f037 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -184,6 +184,7 @@ tests_mips64el_system_thorough = [
 ]
 
 tests_or1k_system_thorough = [
+  'or1k_replay',
   'or1k_sim',
 ]
 
diff --git a/tests/functional/test_or1k_replay.py b/tests/functional/test_or1k_replay.py
new file mode 100755
index 00000000000..2b60a9372c5
--- /dev/null
+++ b/tests/functional/test_or1k_replay.py
@@ -0,0 +1,27 @@
+#!/usr/bin/env python3
+#
+# Replay test that boots a Linux kernel on an OpenRISC-1000 SIM machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from replay_kernel import ReplayKernelBase
+
+
+class Or1kReplay(ReplayKernelBase):
+
+    ASSET_DAY20 = Asset(
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day20.tar.xz',
+        'ff9d7dd7c6bdba325bd85ee85c02db61ff653e129558aeffe6aff55bffb6763a')
+
+    def test_sim(self):
+        self.set_machine('or1k-sim')
+        kernel_path = self.archive_extract(self.ASSET_DAY20,
+                                           member='day20/vmlinux')
+        self.run_rr(kernel_path, self.REPLAY_KERNEL_COMMAND_LINE,
+                    'QEMU advent calendar')
+
+
+if __name__ == '__main__':
+    ReplayKernelBase.main()
-- 
2.48.1


