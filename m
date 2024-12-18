Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D72E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrwx-0006WI-8L; Wed, 18 Dec 2024 06:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwv-0006VZ-9S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrws-0005Ji-Eb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/QjKv1R0AhQuUFehQsQg9Di7Nd4MAmaklYof9ekMiQ=;
 b=OEzMkOIOGbsPodhAaLsFgLOItuUdtXgMUnsr24hMFggsdhgairzXisGS8r/lNfvNuqP3lw
 ez2UlHCk/XTLagQnckpWZOi9ZLpLUhTCdgRMuFT/f4kluesf/+DavgqhPEM6qjfzI0umbI
 7SnRC1G5irPLuryqH7KfOhlnbsk9xeo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-HQJy2N4tO-CkcwlLKCUQQg-1; Wed,
 18 Dec 2024 06:10:33 -0500
X-MC-Unique: HQJy2N4tO-CkcwlLKCUQQg-1
X-Mimecast-MFC-AGG-ID: HQJy2N4tO-CkcwlLKCUQQg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F271C195608F
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8756119560AD; Wed, 18 Dec 2024 11:10:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 13/38] tests/functional: switch over to using
 self.data_file(...)
Date: Wed, 18 Dec 2024 12:09:33 +0100
Message-ID: <20241218110958.226932-14-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes direct path manipulation to figure out the source dir

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-14-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_acpi_bits.py | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 8763ea0822..59d0383563 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -38,7 +38,6 @@
 import tarfile
 import zipfile
 
-from pathlib import Path
 from typing import (
     List,
     Optional,
@@ -119,7 +118,6 @@ class AcpiBitsTest(QemuSystemTest): #pylint: disable=too-many-instance-attribute
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         self._vm = None
-        self._baseDir = None
 
         self._debugcon_addr = '0x403'
         self._debugcon_log = 'debugcon-log.txt'
@@ -134,26 +132,22 @@ def _print_log(self, log):
     def copy_bits_config(self):
         """ copies the bios bits config file into bits.
         """
-        config_file = 'bits-cfg.txt'
-        bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
-                                       'bits-config')
+        bits_config_file = self.data_file('acpi-bits',
+                                          'bits-config',
+                                          'bits-cfg.txt')
         target_config_dir = os.path.join(self.workdir,
                                          'bits-%d' %self.BITS_INTERNAL_VER,
                                          'boot')
-        self.assertTrue(os.path.exists(bits_config_dir))
+        self.assertTrue(os.path.exists(bits_config_file))
         self.assertTrue(os.path.exists(target_config_dir))
-        self.assertTrue(os.access(os.path.join(bits_config_dir,
-                                               config_file), os.R_OK))
-        shutil.copy2(os.path.join(bits_config_dir, config_file),
-                     target_config_dir)
+        shutil.copy2(bits_config_file, target_config_dir)
         self.logger.info('copied config file %s to %s',
-                         config_file, target_config_dir)
+                         bits_config_file, target_config_dir)
 
     def copy_test_scripts(self):
         """copies the python test scripts into bits. """
 
-        bits_test_dir = os.path.join(self._baseDir, 'acpi-bits',
-                                     'bits-tests')
+        bits_test_dir = self.data_file('acpi-bits', 'bits-tests')
         target_test_dir = os.path.join(self.workdir,
                                        'bits-%d' %self.BITS_INTERNAL_VER,
                                        'boot', 'python')
@@ -256,8 +250,6 @@ def setUp(self): # pylint: disable=arguments-differ
         super().setUp()
         self.logger = self.log
 
-        self._baseDir = Path(__file__).parent
-
         prebuiltDir = os.path.join(self.workdir, 'prebuilt')
         if not os.path.isdir(prebuiltDir):
             os.mkdir(prebuiltDir, mode=0o775)
-- 
2.47.1


