Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C77C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsZr-000153-M6; Fri, 01 Aug 2025 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSe-0007RY-7Y
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSc-0002pK-Bq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7M6lfprvgFAXg+quMJI8LoG9A9DKhI8YaGJtVnzbz54=;
 b=YhRqIGmhRVuNaSRFN+UeTojrg3GnP+EiOxbTv2XwL/25esrv3JlYCYny7eZQ+ltye8TwLw
 kjfImD8260v5myPLcOt6rS7alklBohG4bX9oo4A0DHvx99v0z+M4r4CaAay9/J74toD4LW
 5eGNmuTQxqJqzFmMF6wKoOZWE0kJC7A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-Sx-IOR0kO1eukR5cHQEjJw-1; Fri,
 01 Aug 2025 11:14:14 -0400
X-MC-Unique: Sx-IOR0kO1eukR5cHQEjJw-1
X-Mimecast-MFC-AGG-ID: Sx-IOR0kO1eukR5cHQEjJw_1754061253
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19AC19560AA; Fri,  1 Aug 2025 15:14:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3D901800B4F; Fri,  1 Aug 2025 15:14:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 24/24] tests/functional: Move the generic tests to a subfolder
Date: Fri,  1 Aug 2025 17:12:49 +0200
Message-ID: <20250801151251.751368-25-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This also removes the line for using tests from the main folder
since we do not have any tests left here. And while we're at it,
also mark the vnc test as generic now since it is not specific to x86.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                     |  8 ++++----
 tests/functional/generic/meson.build            | 14 ++++++++++++++
 .../{ => generic}/test_empty_cpu_model.py       |  0
 .../{ => generic}/test_info_usernet.py          |  0
 tests/functional/{ => generic}/test_version.py  |  0
 tests/functional/{ => generic}/test_vnc.py      |  0
 tests/functional/meson.build                    | 17 ++---------------
 tests/functional/x86_64/meson.build             |  1 -
 8 files changed, 20 insertions(+), 20 deletions(-)
 create mode 100644 tests/functional/generic/meson.build
 rename tests/functional/{ => generic}/test_empty_cpu_model.py (100%)
 rename tests/functional/{ => generic}/test_info_usernet.py (100%)
 rename tests/functional/{ => generic}/test_version.py (100%)
 rename tests/functional/{ => generic}/test_vnc.py (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 821a7a07ed6..06f82a309fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1971,7 +1971,7 @@ F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
 F: include/system/numa.h
 F: tests/functional/x86_64/test_cpu_queries.py
-F: tests/functional/test_empty_cpu_model.py
+F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
@@ -2192,7 +2192,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
-F: tests/functional/test_info_usernet.py
+F: tests/functional/generic/test_info_usernet.py
 F: docs/system/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
@@ -3126,7 +3126,7 @@ S: Supported
 F: include/qemu/option.h
 F: tests/unit/test-keyval.c
 F: tests/unit/test-qemu-opts.c
-F: tests/functional/test_version.py
+F: tests/functional/generic/test_version.py
 F: util/keyval.c
 F: util/qemu-option.c
 
@@ -3244,7 +3244,7 @@ F: include/ui/
 F: qapi/ui.json
 F: util/drm.c
 F: docs/devel/ui.rst
-F: tests/functional/test_vnc.py
+F: tests/functional/generic/test_vnc.py
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/generic/meson.build b/tests/functional/generic/meson.build
new file mode 100644
index 00000000000..013cc96fbf8
--- /dev/null
+++ b/tests/functional/generic/meson.build
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_generic_system = [
+  'empty_cpu_model',
+  'info_usernet',
+  'version',
+  'vnc',
+]
+
+tests_generic_linuxuser = [
+]
+
+tests_generic_bsduser = [
+]
diff --git a/tests/functional/test_empty_cpu_model.py b/tests/functional/generic/test_empty_cpu_model.py
similarity index 100%
rename from tests/functional/test_empty_cpu_model.py
rename to tests/functional/generic/test_empty_cpu_model.py
diff --git a/tests/functional/test_info_usernet.py b/tests/functional/generic/test_info_usernet.py
similarity index 100%
rename from tests/functional/test_info_usernet.py
rename to tests/functional/generic/test_info_usernet.py
diff --git a/tests/functional/test_version.py b/tests/functional/generic/test_version.py
similarity index 100%
rename from tests/functional/test_version.py
rename to tests/functional/generic/test_version.py
diff --git a/tests/functional/test_vnc.py b/tests/functional/generic/test_vnc.py
similarity index 100%
rename from tests/functional/test_vnc.py
rename to tests/functional/generic/test_vnc.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b1eec16add8..2a0c5aa1418 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -36,18 +36,7 @@ subdir('sparc')
 subdir('sparc64')
 subdir('x86_64')
 subdir('xtensa')
-
-tests_generic_system = [
-  'empty_cpu_model',
-  'info_usernet',
-  'version',
-]
-
-tests_generic_linuxuser = [
-]
-
-tests_generic_bsduser = [
-]
+subdir('generic')
 
 precache_all = []
 foreach speed : ['quick', 'thorough']
@@ -90,9 +79,7 @@ foreach speed : ['quick', 'thorough']
 
     foreach test : target_tests
       testname = '@0@-@1@'.format(target_base, test)
-      if fs.exists('test_' + test + '.py')
-        testfile = 'test_' + test + '.py'
-      elif fs.exists('generic' / 'test_' + test + '.py')
+      if fs.exists('generic' / 'test_' + test + '.py')
         testfile = 'generic' / 'test_' + test + '.py'
       else
         testfile = target_base / 'test_' + test + '.py'
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 696a9ecab42..d0b4667bb8a 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -16,7 +16,6 @@ tests_x86_64_system_quick = [
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
-  'vnc',
   'memlock',
 ]
 
-- 
2.50.1


