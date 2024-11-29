Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC8DD729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4ql-0003mC-Ib; Fri, 29 Nov 2024 12:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qY-0003gq-Hq
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qW-0000wL-UD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjGCMqsjW1B5YuxiEfV5ODv2USRNF4jZygU4xmpzmEw=;
 b=Kyq8Q33e9Yry7iaYpSEd579ETaOgKs5iV1l+z2NtK3JmUnzjIrTSYAJozo7K32PvlK2uPM
 gNwDG7yaxPFTzkGWmXpgFDm05AT+tuOb17rrZ4hNAj+XwG6U1YGvbWtMYPAL1tipqxsR8e
 PpIIrRfDuoGvZ/0Io6RoYRB/Urife88=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Cj5iyRtPO46FzfE8GZEg6w-1; Fri,
 29 Nov 2024 12:31:55 -0500
X-MC-Unique: Cj5iyRtPO46FzfE8GZEg6w-1
X-Mimecast-MFC-AGG-ID: Cj5iyRtPO46FzfE8GZEg6w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D4121955DD2; Fri, 29 Nov 2024 17:31:54 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF8B71955F41; Fri, 29 Nov 2024 17:31:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/22] tests/functional: switch over to using
 self.data_file(...)
Date: Fri, 29 Nov 2024 17:31:09 +0000
Message-ID: <20241129173120.761728-12-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

This removes direct path manipulation to figure out the source dir

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_acpi_bits.py | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 4de5fae37e..948b134b16 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -41,7 +41,6 @@
 import tempfile
 import zipfile
 
-from pathlib import Path
 from typing import (
     List,
     Optional,
@@ -122,7 +121,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         self._vm = None
-        self._baseDir = None
 
         self._debugcon_addr = '0x403'
         self._debugcon_log = 'debugcon-log.txt'
@@ -137,26 +135,22 @@ def _print_log(self, log):
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
@@ -259,8 +253,6 @@ def setUp(self): # pylint: disable=arguments-differ
         super().setUp('qemu-system-')
         self.logger = self.log
 
-        self._baseDir = Path(__file__).parent
-
         prebuiltDir = os.path.join(self.workdir, 'prebuilt')
         if not os.path.isdir(prebuiltDir):
             os.mkdir(prebuiltDir, mode=0o775)
-- 
2.46.0


