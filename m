Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A2ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB0p-0005fn-4I; Wed, 27 Aug 2025 03:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0n-0005aS-Aj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0h-00022t-Kj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ze5qPOuGLKnVkR5KLj+nn4VWFqwAbTgA1XG4RhaSjEE=;
 b=ffHIgXTbXOvogjdWN3ENGi2IFxBB6SQN/hI8uLgVBKCzixzZ6t2zqFdGVsi+DJQhaLRyp2
 2kWQJNZQnlBIpD+CaH0oapLf8duGWsMMpXFnR6RdF5W+078p8GVzttPe9N3UepxfuIMqtg
 IXcAoqfJ5MyPuALBGu1qK0oqlbM2JwU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-uCCYX1BMNQmK6W9DAfxXRA-1; Wed,
 27 Aug 2025 03:55:52 -0400
X-MC-Unique: uCCYX1BMNQmK6W9DAfxXRA-1
X-Mimecast-MFC-AGG-ID: uCCYX1BMNQmK6W9DAfxXRA_1756281351
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 506B51955F68; Wed, 27 Aug 2025 07:55:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F4BE1955F24; Wed, 27 Aug 2025 07:55:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/31] tests/functional: Move m68k tests into architecture
 specific folder
Date: Wed, 27 Aug 2025 09:54:27 +0200
Message-ID: <20250827075443.559712-18-thuth@redhat.com>
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
m68k tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-13-thuth@redhat.com>
---
 MAINTAINERS                                              | 8 ++++----
 tests/functional/m68k/meson.build                        | 9 +++++++++
 .../{test_m68k_mcf5208evb.py => m68k/test_mcf5208evb.py} | 0
 .../{test_m68k_nextcube.py => m68k/test_nextcube.py}     | 0
 .../functional/{test_m68k_q800.py => m68k/test_q800.py}  | 0
 .../{test_m68k_replay.py => m68k/test_replay.py}         | 0
 .../{test_m68k_tuxrun.py => m68k/test_tuxrun.py}         | 0
 tests/functional/meson.build                             | 9 +--------
 8 files changed, 14 insertions(+), 12 deletions(-)
 create mode 100644 tests/functional/m68k/meson.build
 rename tests/functional/{test_m68k_mcf5208evb.py => m68k/test_mcf5208evb.py} (100%)
 rename tests/functional/{test_m68k_nextcube.py => m68k/test_nextcube.py} (100%)
 rename tests/functional/{test_m68k_q800.py => m68k/test_q800.py} (100%)
 rename tests/functional/{test_m68k_replay.py => m68k/test_replay.py} (100%)
 rename tests/functional/{test_m68k_tuxrun.py => m68k/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 716127e831d..e188de813fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1312,7 +1312,7 @@ F: hw/m68k/mcf_intc.c
 F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
-F: tests/functional/test_m68k_mcf5208evb.py
+F: tests/functional/m68k/test_mcf5208evb.py
 
 NeXTcube
 M: Thomas Huth <huth@tuxfamily.org>
@@ -1320,7 +1320,7 @@ S: Odd Fixes
 F: hw/m68k/next-*.c
 F: hw/display/next-fb.c
 F: include/hw/m68k/next-cube.h
-F: tests/functional/test_m68k_nextcube.py
+F: tests/functional/m68k/test_nextcube.py
 
 q800
 M: Laurent Vivier <laurent@vivier.eu>
@@ -1346,7 +1346,7 @@ F: include/hw/m68k/q800-glue.h
 F: include/hw/misc/djmemc.h
 F: include/hw/misc/iosb.h
 F: include/hw/audio/asc.h
-F: tests/functional/test_m68k_q800.py
+F: tests/functional/m68k/test_q800.py
 
 virt
 M: Laurent Vivier <laurent@vivier.eu>
@@ -1361,7 +1361,7 @@ F: include/hw/intc/goldfish_pic.h
 F: include/hw/intc/m68k_irqc.h
 F: include/hw/misc/virt_ctrl.h
 F: docs/specs/virt-ctlr.rst
-F: tests/functional/test_m68k_tuxrun.py
+F: tests/functional/m68k/test_tuxrun.py
 
 MicroBlaze Machines
 -------------------
diff --git a/tests/functional/m68k/meson.build b/tests/functional/m68k/meson.build
new file mode 100644
index 00000000000..e29044a6d73
--- /dev/null
+++ b/tests/functional/m68k/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_m68k_system_thorough = [
+  'mcf5208evb',
+  'nextcube',
+  'replay',
+  'q800',
+  'tuxrun',
+]
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/m68k/test_mcf5208evb.py
similarity index 100%
rename from tests/functional/test_m68k_mcf5208evb.py
rename to tests/functional/m68k/test_mcf5208evb.py
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/m68k/test_nextcube.py
similarity index 100%
rename from tests/functional/test_m68k_nextcube.py
rename to tests/functional/m68k/test_nextcube.py
diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/m68k/test_q800.py
similarity index 100%
rename from tests/functional/test_m68k_q800.py
rename to tests/functional/m68k/test_q800.py
diff --git a/tests/functional/test_m68k_replay.py b/tests/functional/m68k/test_replay.py
similarity index 100%
rename from tests/functional/test_m68k_replay.py
rename to tests/functional/m68k/test_replay.py
diff --git a/tests/functional/test_m68k_tuxrun.py b/tests/functional/m68k/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_m68k_tuxrun.py
rename to tests/functional/m68k/test_tuxrun.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e2e66dcf523..d32dd4a371f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -16,6 +16,7 @@ subdir('avr')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -81,14 +82,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_m68k_system_thorough = [
-  'm68k_mcf5208evb',
-  'm68k_nextcube',
-  'm68k_replay',
-  'm68k_q800',
-  'm68k_tuxrun',
-]
-
 tests_microblaze_system_thorough = [
   'microblaze_replay',
   'microblaze_s3adsp1800'
-- 
2.50.1


