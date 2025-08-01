Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8C0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsUr-0006KJ-5h; Fri, 01 Aug 2025 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrS6-0003ZW-37
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrS4-0002if-9v
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpnhCcwDIEBXn79ys7hzaKqw8+rprwSuWv6GxyAzUVU=;
 b=ErW9TIuQS+trFDdS5MdxiuL+ccP6gSJ98PkIsz8/YK/548xMyBuanIbiV3L83eqK7amKwf
 cxaG3hzIVaj4/25FXAPzgQNc1T81xh+O1ppXG5vIfCwSOLC2IfyMWxQGrHzUKeJJE8q8HQ
 aOCnaeKTVrMLNOiz27YjSJYxBrkow4Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-hdGXGKj6O1qTRM7EuJOUYQ-1; Fri,
 01 Aug 2025 11:13:36 -0400
X-MC-Unique: hdGXGKj6O1qTRM7EuJOUYQ-1
X-Mimecast-MFC-AGG-ID: hdGXGKj6O1qTRM7EuJOUYQ_1754061215
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ED7A1801A02; Fri,  1 Aug 2025 15:13:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50CCB180035E; Fri,  1 Aug 2025 15:13:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 08/24] tests/functional: Move avr tests into architecture
 specific folder
Date: Fri,  1 Aug 2025 17:12:33 +0200
Message-ID: <20250801151251.751368-9-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
avr tests into a target-specific subfolder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                                 | 4 ++--
 tests/functional/avr/meson.build                            | 6 ++++++
 .../{test_avr_mega2560.py => avr/test_mega2560.py}          | 0
 tests/functional/{test_avr_uno.py => avr/test_uno.py}       | 0
 tests/functional/meson.build                                | 6 +-----
 5 files changed, 9 insertions(+), 7 deletions(-)
 create mode 100644 tests/functional/avr/meson.build
 rename tests/functional/{test_avr_mega2560.py => avr/test_mega2560.py} (100%)
 rename tests/functional/{test_avr_uno.py => avr/test_uno.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7a0ee7e6e..0cfd12ec77e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -221,7 +221,7 @@ S: Maintained
 F: docs/system/target-avr.rst
 F: gdb-xml/avr-cpu.xml
 F: target/avr/
-F: tests/functional/test_avr_*.py
+F: tests/functional/avr/
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
@@ -1247,7 +1247,7 @@ Arduino
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: hw/avr/arduino.c
-F: tests/functional/test_avr_uno.py
+F: tests/functional/avr/test_uno.py
 
 HP-PARISC Machines
 ------------------
diff --git a/tests/functional/avr/meson.build b/tests/functional/avr/meson.build
new file mode 100644
index 00000000000..7a2cb7099e7
--- /dev/null
+++ b/tests/functional/avr/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_avr_system_thorough = [
+  'mega2560',
+  'uno',
+]
diff --git a/tests/functional/test_avr_mega2560.py b/tests/functional/avr/test_mega2560.py
similarity index 100%
rename from tests/functional/test_avr_mega2560.py
rename to tests/functional/avr/test_mega2560.py
diff --git a/tests/functional/test_avr_uno.py b/tests/functional/avr/test_uno.py
similarity index 100%
rename from tests/functional/test_avr_uno.py
rename to tests/functional/avr/test_uno.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 708246b0d08..8b7b962d4d6 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -12,6 +12,7 @@ endif
 subdir('aarch64')
 subdir('alpha')
 subdir('arm')
+subdir('avr')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -77,11 +78,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_avr_system_thorough = [
-  'avr_mega2560',
-  'avr_uno',
-]
-
 tests_hppa_system_quick = [
   'hppa_seabios',
 ]
-- 
2.50.1


