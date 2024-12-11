Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17516E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQVL-0006yi-IO; Wed, 11 Dec 2024 12:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVH-0006nM-VP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLQVG-0001EV-B5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733938081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRAg+ecU2fQgJvt3zts9WwuvnhsBR5JkwUhpt9zQUzE=;
 b=V2LxhR3E+LbPbanCtA2XBWW58Tak5rvVixmpymZwJRh1Glvqjd4NgB2mkozfqJeudPV1PI
 YysEQUg/pvHtq4GFZhvNFVNe1zhfyPwItzsG2G3PdpOL4BBBjtGm5+P+C8Um7HJpZQxTEc
 Uo9SOSNLg4jqNJ4VdAY8Y/Xh1Ahbg24=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-oXETMg3bMsGO-iBhTQQ5zw-1; Wed,
 11 Dec 2024 12:27:54 -0500
X-MC-Unique: oXETMg3bMsGO-iBhTQQ5zw-1
X-Mimecast-MFC-AGG-ID: oXETMg3bMsGO-iBhTQQ5zw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 967991956058; Wed, 11 Dec 2024 17:27:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E9BB1956048; Wed, 11 Dec 2024 17:27:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 21/31] tests/functional: add a generalized archive_extract
Date: Wed, 11 Dec 2024 17:26:37 +0000
Message-ID: <20241211172648.2893097-22-berrange@redhat.com>
In-Reply-To: <20241211172648.2893097-1-berrange@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

There are many types of archives that the tests deal with. Provide
a generalized 'archive_extract' that can detect the format and
delegate to the appropriate helper for extraction. This ensures
that all archive extraction code follows the same design pattern.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/archive.py  | 58 ++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index fe6cbe3a8a..665c482d13 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -16,3 +16,4 @@
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
     skipIfMissingImports
+from .archive import archive_extract
diff --git a/tests/functional/qemu_test/archive.py b/tests/functional/qemu_test/archive.py
index bc448dee4a..c439d9413a 100644
--- a/tests/functional/qemu_test/archive.py
+++ b/tests/functional/qemu_test/archive.py
@@ -10,8 +10,10 @@
 import os
 from subprocess import check_call, run, DEVNULL
 import tarfile
+from urllib.parse import urlparse
 import zipfile
 
+from .asset import Asset
 from .cmd import run_cmd
 
 
@@ -56,3 +58,59 @@ def deb_extract(archive, dest_dir, member=None):
         tar_extract(file_path, dest_dir, member)
     finally:
         os.chdir(cwd)
+
+'''
+@params archive: filename, Asset, or file-like object to extract
+@params dest_dir: target directory to extract into
+@params member: optional member file to limit extraction to
+
+Extracts @archive into @dest_dir. All files are extracted
+unless @member specifies a limit.
+
+If @format is None, heuristics will be applied to guess the format
+from the filename or Asset URL. @format must be non-None if @archive
+is a file-like object.
+'''
+def archive_extract(archive, dest_dir, format=None, member=None):
+    if format is None:
+        format = guess_archive_format(archive)
+    if type(archive) == Asset:
+        archive = str(archive)
+
+    if format == "tar":
+        tar_extract(archive, dest_dir, member)
+    elif format == "zip":
+        zip_extract(archive, dest_dir, member)
+    elif format == "cpio":
+        if member is not None:
+            raise Exception("Unable to filter cpio extraction")
+        cpio_extract(archive, dest_dir)
+    elif format == "deb":
+        if type(archive) != str:
+            raise Exception("Unable to use file-like object with deb archives")
+        deb_extract(archive, dest_dir, "./" + member)
+    else:
+        raise Exception(f"Unknown archive format {format}")
+
+'''
+@params archive: filename, or Asset to guess
+
+Guess the format of @compressed, raising an exception if
+no format can be determined
+'''
+def guess_archive_format(archive):
+    if type(archive) == Asset:
+        archive = urlparse(archive.url).path
+    elif type(archive) != str:
+        raise Exception(f"Unable to guess archive format for {archive}")
+
+    if ".tar." in archive or archive.endswith("tgz"):
+        return "tar"
+    elif archive.endswith(".zip"):
+        return "zip"
+    elif archive.endswith(".cpio"):
+        return "cpio"
+    elif archive.endswith(".deb") or archive.endswith(".udeb"):
+        return "deb"
+    else:
+        raise Exception(f"Unknown archive format for {archive}")
-- 
2.46.0


