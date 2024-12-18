Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31115E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrx9-0006kK-BG; Wed, 18 Dec 2024 06:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrx7-0006eG-Kt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrx5-0005pN-Vh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbcZHmjzHJRduhsQhH+ZO2ewFkMOoJ+O6L5jaHOvzeo=;
 b=dwDf//1zlpvbepqKrZlbATwe3c3RMdf4PNYiqLMPITH2EgqgQ9hIDzLRlE8JeqmH1wOPkA
 f8maAZjCJ2ugpmLLHN4wuNExbazV0OeF5/wVW9g/q/ihYAiJv535JK+h6qKzfgHaAnUHEI
 0Q6pfFWbOZCVftoUHKIV+I2O7j3+wYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-xIjN5b9QMHGmwJHH-Dfgng-1; Wed,
 18 Dec 2024 06:10:49 -0500
X-MC-Unique: xIjN5b9QMHGmwJHH-Dfgng-1
X-Mimecast-MFC-AGG-ID: xIjN5b9QMHGmwJHH-Dfgng
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0D0F1956048
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CFEF195605F; Wed, 18 Dec 2024 11:10:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 20/38] tests/functional: let cpio_extract accept filenames
Date: Wed, 18 Dec 2024 12:09:40 +0100
Message-ID: <20241218110958.226932-21-thuth@redhat.com>
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

Currently cpio_extract differs from tar_extract/zip_extract
in that it only allows a file-like object as input. Adapt it
to also support filenames.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-21-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/archive.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/archive.py b/tests/functional/qemu_test/archive.py
index a6fc97a557..bc448dee4a 100644
--- a/tests/functional/qemu_test/archive.py
+++ b/tests/functional/qemu_test/archive.py
@@ -8,7 +8,7 @@
 #  Thomas Huth <thuth@redhat.com>
 
 import os
-import subprocess
+from subprocess import check_call, run, DEVNULL
 import tarfile
 import zipfile
 
@@ -25,12 +25,18 @@ def tar_extract(archive, dest_dir, member=None):
         else:
             tf.extractall(path=dest_dir)
 
-def cpio_extract(cpio_handle, output_path):
+def cpio_extract(archive, output_path):
     cwd = os.getcwd()
     os.chdir(output_path)
-    subprocess.run(['cpio', '-i'],
-                   input=cpio_handle.read(),
-                   stderr=subprocess.DEVNULL)
+    # Not passing 'check=True' as cpio exits with non-zero
+    # status if the archive contains any device nodes :-(
+    if type(archive) == str:
+        run(['cpio', '-i', '-F', archive],
+            stdout=DEVNULL, stderr=DEVNULL)
+    else:
+        run(['cpio', '-i'],
+            input=archive.read(),
+            stdout=DEVNULL, stderr=DEVNULL)
     os.chdir(cwd)
 
 def zip_extract(archive, dest_dir, member=None):
-- 
2.47.1


