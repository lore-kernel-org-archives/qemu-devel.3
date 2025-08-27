Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B068CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB1E-0006Af-F3; Wed, 27 Aug 2025 03:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1B-0005zS-RU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB16-00025E-Li
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hw05DEN12GaDQkcY6BGbXWXGRZS66qrZzkeFKOM+7s=;
 b=GPiJHxfmvpKnL8iW464nvCinHrUZQqXEiLK1azRANNLR/lt9rfyYju3TdNGPSRe9OI2J6k
 TsLIskafttGCH1tPdqO0D/zhpcl4pWeVMJhxT1nAnboZmd2yQjBT7ATfun2F5ry62khR1y
 +LB2dOMBcP4m8KUMQkL54L2YjDbZgHY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-5JvMhrQmMYCU388hfRNxWg-1; Wed,
 27 Aug 2025 03:56:19 -0400
X-MC-Unique: 5JvMhrQmMYCU388hfRNxWg-1
X-Mimecast-MFC-AGG-ID: 5JvMhrQmMYCU388hfRNxWg_1756281378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32ED119560A2; Wed, 27 Aug 2025 07:56:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C17101955F24; Wed, 27 Aug 2025 07:56:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/31] tests/functional: Move s390x tests into target-specific
 folders
Date: Wed, 27 Aug 2025 09:54:34 +0200
Message-ID: <20250827075443.559712-25-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded, thus move the
s390x tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-20-thuth@redhat.com>
---
 MAINTAINERS                                         |  6 +++---
 tests/functional/meson.build                        | 13 +------------
 tests/functional/s390x/meson.build                  | 13 +++++++++++++
 .../test_ccw_virtio.py}                             |  0
 .../test_pxelinux.py}                               |  0
 .../{test_s390x_replay.py => s390x/test_replay.py}  |  0
 .../test_topology.py}                               |  0
 .../{test_s390x_tuxrun.py => s390x/test_tuxrun.py}  |  0
 8 files changed, 17 insertions(+), 15 deletions(-)
 create mode 100644 tests/functional/s390x/meson.build
 rename tests/functional/{test_s390x_ccw_virtio.py => s390x/test_ccw_virtio.py} (100%)
 rename tests/functional/{test_s390x_pxelinux.py => s390x/test_pxelinux.py} (100%)
 rename tests/functional/{test_s390x_replay.py => s390x/test_replay.py} (100%)
 rename tests/functional/{test_s390x_topology.py => s390x/test_topology.py} (100%)
 rename tests/functional/{test_s390x_tuxrun.py => s390x/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6410a5f5fd..4a55a20f6a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1797,7 +1797,7 @@ S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
-F: tests/functional/test_s390x_*
+F: tests/functional/s390x
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1811,7 +1811,7 @@ F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
-F: tests/functional/test_s390x_pxelinux.py
+F: tests/functional/s390x/test_pxelinux.py
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1865,7 +1865,7 @@ F: hw/s390x/cpu-topology.c
 F: target/s390x/kvm/stsi-topology.c
 F: docs/devel/s390-cpu-topology.rst
 F: docs/system/s390x/cpu-topology.rst
-F: tests/functional/test_s390x_topology.py
+F: tests/functional/s390x/test_topology.py
 
 X86 Machines
 ------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7e7a6aa0c93..abaa4e00fca 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -29,10 +29,7 @@ subdir('ppc64')
 subdir('riscv32')
 subdir('riscv64')
 subdir('rx')
-
-test_s390x_timeouts = {
-  's390x_ccw_virtio' : 420,
-}
+subdir('s390x')
 
 test_sh4_timeouts = {
   'sh4_tuxrun' : 240,
@@ -59,14 +56,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_s390x_system_thorough = [
-  's390x_ccw_virtio',
-  's390x_pxelinux',
-  's390x_replay',
-  's390x_topology',
-  's390x_tuxrun',
-]
-
 tests_sh4_system_thorough = [
   'sh4_r2d',
   'sh4_tuxrun',
diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
new file mode 100644
index 00000000000..030b116039c
--- /dev/null
+++ b/tests/functional/s390x/meson.build
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_s390x_timeouts = {
+  'ccw_virtio' : 420,
+}
+
+tests_s390x_system_thorough = [
+  'ccw_virtio',
+  'pxelinux',
+  'replay',
+  'topology',
+  'tuxrun',
+]
diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
similarity index 100%
rename from tests/functional/test_s390x_ccw_virtio.py
rename to tests/functional/s390x/test_ccw_virtio.py
diff --git a/tests/functional/test_s390x_pxelinux.py b/tests/functional/s390x/test_pxelinux.py
similarity index 100%
rename from tests/functional/test_s390x_pxelinux.py
rename to tests/functional/s390x/test_pxelinux.py
diff --git a/tests/functional/test_s390x_replay.py b/tests/functional/s390x/test_replay.py
similarity index 100%
rename from tests/functional/test_s390x_replay.py
rename to tests/functional/s390x/test_replay.py
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/s390x/test_topology.py
similarity index 100%
rename from tests/functional/test_s390x_topology.py
rename to tests/functional/s390x/test_topology.py
diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_s390x_tuxrun.py
rename to tests/functional/s390x/test_tuxrun.py
-- 
2.50.1


