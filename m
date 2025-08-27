Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6ACC8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB1i-0006xs-Ij; Wed, 27 Aug 2025 03:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1P-0006U7-Os
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1I-00026M-UO
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgEcGdB28fD8Vf6ADNwk5xyK2M3AR2jjInbm1MAxpf0=;
 b=PeYJu1IpjAUpHy0KiKavDLvaTy66biv628Z/RPOKnI8ux52ZkuMxwpJxbrhkPPWD9MPR+S
 AlRorUqjLrTv7H9Vynf+K0+H+0RGLVlYzfqlqCiGxZZo2Oy7jjJRCY6FApMBgdWjS3QQcu
 NmbzN1y+eVFHE2f5nqC1alt6zGZxWXc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-XzmVasJxNau_Yl3UJaH77A-1; Wed,
 27 Aug 2025 03:56:26 -0400
X-MC-Unique: XzmVasJxNau_Yl3UJaH77A-1
X-Mimecast-MFC-AGG-ID: XzmVasJxNau_Yl3UJaH77A_1756281385
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B58061800340; Wed, 27 Aug 2025 07:56:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC0291955F24; Wed, 27 Aug 2025 07:56:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/31] tests/functional: Move sparc/sparc64 tests into
 target-specific folders
Date: Wed, 27 Aug 2025 09:54:36 +0200
Message-ID: <20250827075443.559712-27-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
sparc tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-22-thuth@redhat.com>
---
 MAINTAINERS                                   |  6 +++---
 tests/functional/meson.build                  | 20 ++-----------------
 tests/functional/sparc/meson.build            | 10 ++++++++++
 .../test_migration.py}                        |  0
 .../test_replay.py}                           |  0
 .../test_sun4m.py}                            |  0
 tests/functional/sparc64/meson.build          | 10 ++++++++++
 .../test_migration.py}                        |  0
 .../test_sun4u.py}                            |  0
 .../test_tuxrun.py}                           |  0
 10 files changed, 25 insertions(+), 21 deletions(-)
 create mode 100644 tests/functional/sparc/meson.build
 rename tests/functional/{test_sparc_migration.py => sparc/test_migration.py} (100%)
 rename tests/functional/{test_sparc_replay.py => sparc/test_replay.py} (100%)
 rename tests/functional/{test_sparc_sun4m.py => sparc/test_sun4m.py} (100%)
 create mode 100644 tests/functional/sparc64/meson.build
 rename tests/functional/{test_sparc64_migration.py => sparc64/test_migration.py} (100%)
 rename tests/functional/{test_sparc64_sun4u.py => sparc64/test_sun4u.py} (100%)
 rename tests/functional/{test_sparc64_tuxrun.py => sparc64/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eddec0058e0..b46445ff5c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1755,7 +1755,7 @@ F: include/hw/nvram/sun_nvram.h
 F: include/hw/sparc/sparc32_dma.h
 F: include/hw/sparc/sun4m_iommu.h
 F: pc-bios/openbios-sparc32
-F: tests/functional/test_sparc_sun4m.py
+F: tests/functional/sparc/test_sun4m.py
 
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1768,8 +1768,8 @@ F: include/hw/pci-host/sabre.h
 F: hw/pci-bridge/simba.c
 F: include/hw/pci-bridge/simba.h
 F: pc-bios/openbios-sparc64
-F: tests/functional/test_sparc64_sun4u.py
-F: tests/functional/test_sparc64_tuxrun.py
+F: tests/functional/sparc64/test_sun4u.py
+F: tests/functional/sparc64/test_tuxrun.py
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ce713509e32..00d18dba3ce 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -32,6 +32,8 @@ subdir('rx')
 subdir('s390x')
 subdir('sh4')
 subdir('sh4eb')
+subdir('sparc')
+subdir('sparc64')
 
 test_x86_64_timeouts = {
   'acpi_bits' : 420,
@@ -54,24 +56,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_sparc_system_quick = [
-  'sparc_migration',
-]
-
-tests_sparc_system_thorough = [
-  'sparc_replay',
-  'sparc_sun4m',
-]
-
-tests_sparc64_system_quick = [
-  'sparc64_migration',
-]
-
-tests_sparc64_system_thorough = [
-  'sparc64_sun4u',
-  'sparc64_tuxrun',
-]
-
 tests_x86_64_system_quick = [
   'cpu_queries',
   'mem_addr_space',
diff --git a/tests/functional/sparc/meson.build b/tests/functional/sparc/meson.build
new file mode 100644
index 00000000000..88732becd81
--- /dev/null
+++ b/tests/functional/sparc/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_sparc_system_quick = [
+  'migration',
+]
+
+tests_sparc_system_thorough = [
+  'replay',
+  'sun4m',
+]
diff --git a/tests/functional/test_sparc_migration.py b/tests/functional/sparc/test_migration.py
similarity index 100%
rename from tests/functional/test_sparc_migration.py
rename to tests/functional/sparc/test_migration.py
diff --git a/tests/functional/test_sparc_replay.py b/tests/functional/sparc/test_replay.py
similarity index 100%
rename from tests/functional/test_sparc_replay.py
rename to tests/functional/sparc/test_replay.py
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/sparc/test_sun4m.py
similarity index 100%
rename from tests/functional/test_sparc_sun4m.py
rename to tests/functional/sparc/test_sun4m.py
diff --git a/tests/functional/sparc64/meson.build b/tests/functional/sparc64/meson.build
new file mode 100644
index 00000000000..2e04e7d4f3d
--- /dev/null
+++ b/tests/functional/sparc64/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_sparc64_system_quick = [
+  'migration',
+]
+
+tests_sparc64_system_thorough = [
+  'sun4u',
+  'tuxrun',
+]
diff --git a/tests/functional/test_sparc64_migration.py b/tests/functional/sparc64/test_migration.py
similarity index 100%
rename from tests/functional/test_sparc64_migration.py
rename to tests/functional/sparc64/test_migration.py
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/sparc64/test_sun4u.py
similarity index 100%
rename from tests/functional/test_sparc64_sun4u.py
rename to tests/functional/sparc64/test_sun4u.py
diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/sparc64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_sparc64_tuxrun.py
rename to tests/functional/sparc64/test_tuxrun.py
-- 
2.50.1


