Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9176C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgKW-0000eL-I0; Tue, 16 Jul 2024 07:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKV-0000Z7-6C
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKT-0003fB-OF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHN7AYgHuHljyH4exkRaU7dMz5pCsBSrCydjHlqdXLk=;
 b=gSuD+2iN/cZXJcH2wgJCSaIFxP+WGI9d2dSUee4PDRbS0jVzlaGP/5v0M9T8hyDdVl2zbY
 wDwbDtL+OinA+JMZJrWyOFSnNcZUJgCgcEEYwj4Q3ic9hmB70ezN1iOSLVcztsbrJcVf28
 qyHLcjqFCay7L9VhqEV4pGYZLKQxKlk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14--R4wowlLNDi4WVuRkOwxlw-1; Tue,
 16 Jul 2024 07:26:41 -0400
X-MC-Unique: -R4wowlLNDi4WVuRkOwxlw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A345E1944B25; Tue, 16 Jul 2024 11:26:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A2B31955F40; Tue, 16 Jul 2024 11:26:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 05/11] tests/functional: Implement fetch_asset() method for
 downloading assets
Date: Tue, 16 Jul 2024 13:26:08 +0200
Message-ID: <20240716112614.1755692-6-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

In the new python test framework, we cannot use the fetch_asset()
function from Avocado anymore, so we have to provide our own
implementation now instead. Thus add such a function based on the
urllib python module for this purpose.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index e73705d40a..77c3b14d34 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -11,6 +11,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import hashlib
+import urllib.request
 import logging
 import os
 import pycotap
@@ -23,6 +25,7 @@
 import unittest
 
 from pathlib import Path
+from shutil import copyfileobj
 from qemu.machine import QEMUMachine
 from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
                         tcg_available)
@@ -215,6 +218,39 @@ def setUp(self, bin_prefix):
         if not os.path.exists(self.workdir):
             os.makedirs(self.workdir)
 
+    def check_hash(self, file_name, expected_hash):
+        if not expected_hash:
+            return True
+        if len(expected_hash) == 40:
+            sum_prog = 'sha1sum'
+        elif len(expected_hash) == 64:
+            sum_prog = 'sha256sum'
+        elif len(expected_hash) == 128:
+            sum_prog = 'sha512sum'
+        else:
+            raise Exception("unknown hash type")
+        checksum = subprocess.check_output([sum_prog, file_name]).split()[0]
+        return expected_hash == checksum.decode("utf-8")
+
+    def fetch_asset(self, url, asset_hash):
+        cache_dir = os.path.expanduser("~/.cache/qemu/download")
+        if not os.path.exists(cache_dir):
+            os.makedirs(cache_dir)
+        fname = os.path.join(cache_dir,
+                             hashlib.sha256(url.encode("utf-8")).hexdigest())
+        if os.path.exists(fname) and self.check_hash(fname, asset_hash):
+            return fname
+        self.log.info("Downloading %s to %s...", url, fname)
+        dl_fname = fname + ".download"
+        with urllib.request.urlopen(url) as src:
+            with open(dl_fname, "wb+") as dst:
+                copyfileobj(src, dst)
+        if not self.check_hash(dl_fname, asset_hash):
+            os.remove(dl_fname)
+            raise Exception("Hash of " + url + " does not match")
+        os.rename(dl_fname, fname)
+        return fname
+
     def main():
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
-- 
2.45.2


