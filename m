Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B37CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB1o-0007NV-KX; Wed, 27 Aug 2025 03:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1R-0006Vq-4a
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1M-00027C-2W
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xB7Qj89OL/MK0qBsLMFZJOOzDym0ut5qvoN+/SrZJ58=;
 b=h64808MQqDAQpdh3UDDSZDtEPDqRVzcWOU/pzIQe3jPbaMa72p97prG9puH3urArA7xVLm
 cHCrCEpR4WJYnxrqu/o1w1AkknMP6BMPawz4jGch25I+VGLBrYwd+bmIy6WThbsvgoL4vU
 5z4654G6b2ZPTv83Uqr6uzcuFO6+Y5M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-_4K3OgD7NqalyJh0gEMDjg-1; Wed,
 27 Aug 2025 03:56:36 -0400
X-MC-Unique: _4K3OgD7NqalyJh0gEMDjg-1
X-Mimecast-MFC-AGG-ID: _4K3OgD7NqalyJh0gEMDjg_1756281395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27C2A19560B8; Wed, 27 Aug 2025 07:56:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C66171955F24; Wed, 27 Aug 2025 07:56:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 29/31] tests/functional: Move the generic tests to a subfolder
Date: Wed, 27 Aug 2025 09:54:39 +0200
Message-ID: <20250827075443.559712-30-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This also removes the line for using tests from the main folder
since we do not have any tests left here. And while we're at it,
also mark the vnc test as generic now since it is not specific to x86.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-25-thuth@redhat.com>
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
index 792d2d6f2de..625fe67b41d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1976,7 +1976,7 @@ F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
 F: include/system/numa.h
 F: tests/functional/x86_64/test_cpu_queries.py
-F: tests/functional/test_empty_cpu_model.py
+F: tests/functional/generic/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
@@ -2197,7 +2197,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
-F: tests/functional/test_info_usernet.py
+F: tests/functional/generic/test_info_usernet.py
 F: docs/system/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
@@ -3134,7 +3134,7 @@ S: Supported
 F: include/qemu/option.h
 F: tests/unit/test-keyval.c
 F: tests/unit/test-qemu-opts.c
-F: tests/functional/test_version.py
+F: tests/functional/generic/test_version.py
 F: util/keyval.c
 F: util/qemu-option.c
 
@@ -3252,7 +3252,7 @@ F: include/ui/
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


