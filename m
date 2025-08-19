Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0BCA0EF7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSG-0003JJ-PV; Tue, 19 Aug 2025 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSF-0003Ii-5A
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSD-0007C7-1f
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5X/rywS4xpnaJWI82edPdKMyskx1dznqkdXp2jLU9U=;
 b=fEw0MVvqXdVq5XcxQyLOF35doxOaz8W2zLhTH4xpU9+YQy/xtWDroo0gvioo7sdMlW2Pz+
 pJ1TTYGC2P9ca4suygVej3SfBLgNflRoqpVUKjCp1mDnpQK0RYAE9Y0yX6mDfJsE29T9OY
 eaiSpGv1SyX9eLY7V2KFfJUb1ciALz4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-Es6vnEvpPTW8fvj5smvdfw-1; Tue,
 19 Aug 2025 07:24:34 -0400
X-MC-Unique: Es6vnEvpPTW8fvj5smvdfw-1
X-Mimecast-MFC-AGG-ID: Es6vnEvpPTW8fvj5smvdfw_1755602673
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 449F81953963; Tue, 19 Aug 2025 11:24:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21C593000223; Tue, 19 Aug 2025 11:24:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/25] tests/functional: Move avr tests into architecture
 specific folder
Date: Tue, 19 Aug 2025 13:23:45 +0200
Message-ID: <20250819112403.432587-9-thuth@redhat.com>
In-Reply-To: <20250819112403.432587-1-thuth@redhat.com>
References: <20250819112403.432587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 1eb964feca4..d01afcbea6d 100644
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
@@ -1249,7 +1249,7 @@ Arduino
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
index 6989446d1c4..81eaa9c218c 100644
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


