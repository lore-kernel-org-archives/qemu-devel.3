Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE21C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgDZ-0004nY-5q; Wed, 24 Jul 2024 13:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCQ-00073k-Il
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCL-0005zX-Ug
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBPnFHA3/SvhdcYJ5iUG96GiCxN1rPqAFZwl1MsgMXY=;
 b=g0bZW351IPjhA/AV9Q/0QyjCEJLZTq8l2mFh8aRNxRj4f9fBHXzdOvC6KJJsyvTwBWE6sV
 XUxbj9XkpCBxIcak5hAh8kPsqFa8wjqMf+K/8jcaO/WqLpfmVdSL4hTiM9ABM8Hh/vajWj
 gVyGK7NAnJsu9vD9RKoBxvQsM6aG1NA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-pAsZrwHvO6SC4KcXw92fXA-1; Wed,
 24 Jul 2024 13:54:39 -0400
X-MC-Unique: pAsZrwHvO6SC4KcXw92fXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AEFB1956080; Wed, 24 Jul 2024 17:54:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 469371955D42; Wed, 24 Jul 2024 17:54:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 18/23] tests/functional: Convert the ppc_amiga avocado test
 into a standalone test
Date: Wed, 24 Jul 2024 19:52:36 +0200
Message-ID: <20240724175248.1389201-19-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use the Python standard zipfile module instead of avocado.utils for
extracting the ZIP file that we download here, and use the standard
subprocess module for running the "tail" command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                  |  1 +
 .../test_ppc_amiga.py}                        | 33 ++++++++++---------
 2 files changed, 19 insertions(+), 15 deletions(-)
 rename tests/{avocado/ppc_amiga.py => functional/test_ppc_amiga.py} (54%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 510dddfc49..74347cf545 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -55,6 +55,7 @@ tests_ppc_quick = [
 tests_ppc_thorough = [
   'ppc_405',
   'ppc_40p',
+  'ppc_amiga',
   'ppc_bamboo',
   'ppc_mpc8544ds',
   'ppc_virtex_ml507',
diff --git a/tests/avocado/ppc_amiga.py b/tests/functional/test_ppc_amiga.py
old mode 100644
new mode 100755
similarity index 54%
rename from tests/avocado/ppc_amiga.py
rename to tests/functional/test_ppc_amiga.py
index b6f866f91d..6fdb334346
--- a/tests/avocado/ppc_amiga.py
+++ b/tests/functional/test_ppc_amiga.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test AmigaNG boards
 #
 # Copyright (c) 2023 BALATON Zoltan
@@ -5,34 +7,35 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado.utils import process
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+import subprocess
+
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern, run_cmd
+from zipfile import ZipFile
 
 class AmigaOneMachine(QemuSystemTest):
 
     timeout = 90
 
     def test_ppc_amigaone(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:amigaone
-        :avocado: tags=device:articia
-        :avocado: tags=accel:tcg
-        """
         self.require_accelerator("tcg")
+        self.set_machine('amigaone')
         tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
         tar_url = ('https://www.hyperion-entertainment.com/index.php/'
                    'downloads?view=download&format=raw&file=25')
         tar_hash = 'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755'
-        zip_file = self.fetch_asset(tar_name, locations=tar_url,
-                                    asset_hash=tar_hash)
-        archive.extract(zip_file, self.workdir)
-        cmd = f"tail -c 524288 {self.workdir}/floppy_edition/updater.image >{self.workdir}/u-boot-amigaone.bin"
-        process.run(cmd, shell=True)
+        zip_file = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        with ZipFile(zip_file, 'r') as zf:
+            zf.extractall(path=self.workdir)
+        bios_fh = open(self.workdir + "/u-boot-amigaone.bin", "wb")
+        subprocess.run(['tail', '-c', '524288',
+                        self.workdir + "/floppy_edition/updater.image"],
+                        stdout=bios_fh)
 
         self.vm.set_console()
         self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
         self.vm.launch()
         wait_for_console_pattern(self, 'FLASH:')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


