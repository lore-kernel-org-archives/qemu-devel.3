Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93DFD729ED
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4rr-0007MT-He; Fri, 29 Nov 2024 12:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4rp-00076R-3j
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4rn-0001pS-9D
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=od46fyFHGQSX2N+7OwKJhq2uBvXEJxe08brTaemqLHY=;
 b=f5R1woGaZdDGGMaQQZ35UJh+/SjxuNiCK1YpQuNtnl2PpdczgXZLqOTY8mr6Zi8CTa4z99
 iQZipSrPsij2GvOalkv20XQXTN1pE7zjRH4Aq5LGu5BaEFyTFTKtRZXGrWHleyGkIuoSlI
 Ep8xoame6RRnrqFvQW+kEetLCDMu3Ns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-OvL5WP_HP1yKahp_l6qOPQ-1; Fri,
 29 Nov 2024 12:32:09 -0500
X-MC-Unique: OvL5WP_HP1yKahp_l6qOPQ-1
X-Mimecast-MFC-AGG-ID: OvL5WP_HP1yKahp_l6qOPQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48A0719560A5; Fri, 29 Nov 2024 17:32:08 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B51B1955F41; Fri, 29 Nov 2024 17:32:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/22] tests/functional: generalize archive_extract
Date: Fri, 29 Nov 2024 17:31:15 +0000
Message-ID: <20241129173120.761728-18-berrange@redhat.com>
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

There are many types of archives that the tests deal with, and
'archive_extract' suggests it can cope with any, rather than only
tar files. Rename the existing method to 'tar_extract' and add a
new method that can dynamically extract any zip, tar or cpio file
based on file extension.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/utils.py | 31 +++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index bafe7fb80e..8c1df8f8c2 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -14,6 +14,7 @@
 import shutil
 import subprocess
 import tarfile
+import zipfile
 
 from .cmd import run_cmd
 
@@ -38,7 +39,33 @@ def image_pow2ceil_expand(path):
             with open(path, 'ab+') as fd:
                 fd.truncate(size_aligned)
 
-def archive_extract(archive, dest_dir, member=None):
+def archive_extract(archive, dest_dir, format=None, member=None):
+    if format == "tar":
+        tar_extract(archive, dest_dir, member)
+    elif format == "zip":
+        zip_extract(archive, dest_dir, member)
+    elif format == "cpio":
+        if member is not None:
+            raise Exception("Unable to filter cpio extraction")
+        cpio_extract(archive, dest_dir)
+    elif format == "deb":
+        deb_extract(archive, dest_dir, "./" + member)
+    else:
+        raise Exception(f"Unknown archive format {format}")
+
+def guess_archive_format(path):
+    if ".tar." in path or path.endswith("tgz"):
+        return "tar"
+    elif path.endswith(".zip"):
+        return "zip"
+    elif path.endswith(".cpio"):
+        return "cpio"
+    elif path.endswith(".deb") or path.endswith(".udeb"):
+        return "deb"
+    else:
+        raise Exception(f"Unknown archive format for {path}")
+
+def tar_extract(archive, dest_dir, member=None):
     with tarfile.open(archive) as tf:
         if hasattr(tarfile, 'data_filter'):
             tf.extraction_filter = getattr(tarfile, 'data_filter',
@@ -62,7 +89,7 @@ def deb_extract(archive, dest_dir, member=None):
         (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
         file_path = stdout.split()[2]
         run_cmd(['ar', 'x', archive, file_path])
-        archive_extract(file_path, dest_dir, member)
+        archive_extract(file_path, dest_dir, format="tar", member=member)
     finally:
         os.chdir(cwd)
 
-- 
2.46.0


