Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AB606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BObCQ81D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNXT-000767-Pn; Fri, 20 Nov 2026 07:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUNXG-0006ds-Tu
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUNXE-0006NN-R6
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795176968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ggfe95c43et3bV+Q/H7TlbZ1FsPNMkhdV3fEGX7y96E=;
 b=BObCQ81DFmw+ATwm5yEYDn2dTXbSgqJ6fgFCFIVTnXruYwjDhuZBXHFrDXBdeh1Uk/z427
 T5f2FRJ5b3nx0i1DFhHctXxNprPEjbrgj7xt1xO9KNOGzcW+4ZMLQSb/I8Pq6aD+uMHWuC
 TuOO3lRT9nEy5dBGYpN/eNsk6/w1TrE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-UorawhL0OOyuFO_jfe4MQg-1; Fri,
 20 Nov 2026 12:16:04 +0000
X-MC-Unique: UorawhL0OOyuFO_jfe4MQg-1
X-Mimecast-MFC-AGG-ID: UorawhL0OOyuFO_jfe4MQg_1795176961
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E1D7195419B; Fri, 20 Nov 2026 12:16:01 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8944430000E7; Fri, 20 Nov 2026 12:15:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 12/12] tests/functional: optionally display download progress
Date: Fri, 20 Nov 2026 12:14:58 +0000
Message-ID: <20261120121458.3723625-13-berrange@redhat.com>
In-Reply-To: <20261120121458.3723625-1-berrange@redhat.com>
References: <20261120121458.3723625-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If "QEMU_TEST_VERBOSE=1" is set then display the file download
progress. This is not enabled by default since meson buffers
output, but if running the test file directly it can be helpful
to see. This requires the 'tqdm' python package to be present
on the system and will have no effect if missing.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/functional.rst   |  6 ++++++
 tests/functional/qemu_test/asset.py | 29 +++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 60a427d175d..8aac3ef9508 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -329,6 +329,12 @@ default, but the location can be changed by setting the
 To force the test suite to re-download the cache, even if still valid,
 set the ``QEMU_TEST_REFRESH_CACHE`` environment variable.
 
+To see progress information during the downloads, set ``QEMU_TEST_VERBOSE``
+to ``1``. Since meson buffers output and only display it on completion,
+this is only suitable if running the test precaching directly::
+
+    QEMU_TEST_VERBOSE=1 ./run tests/functional/mips/test_malta.py
+
 Skipping tests
 --------------
 
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 7bebdd4d481..aa071ea1960 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -18,9 +18,13 @@
 import urllib.request
 from time import sleep
 from pathlib import Path
-from shutil import copyfileobj
 from urllib.error import HTTPError, URLError
 
+try:
+    from tqdm import tqdm
+except:
+    tqdm = None
+
 
 class AssetError(Exception):
     '''This exception will be raised if an asset is not usable'''
@@ -139,6 +143,14 @@ def _save_time_stamp(self):
         self.cache_file.with_suffix(".stamp").write_text(f"{int(time.time())}")
 
     def _try_to_fetch(self, tmp_cache_file):
+        def copyfileprog(prg, src, dst):
+            rd = src.read
+            wr = dst.write
+            while buf := rd(256 * 1024):
+                wr(buf)
+                if prg is not None:
+                    prg.update(len(buf))
+
         for _retries in range(3):
             try:
                 with tmp_cache_file.open("xb") as dst:
@@ -152,8 +164,21 @@ def _try_to_fetch(self, tmp_cache_file):
                         }
                     )
                     with urllib.request.urlopen(req) as resp:
-                        copyfileobj(resp, dst)
                         length_hdr = resp.getheader("Content-Length")
+                        verbose = os.environ.get("QEMU_TEST_VERBOSE", False)
+                        if tqdm is not None and verbose:
+                            args = {
+                                "desc": os.path.basename(self.url)
+                            }
+                            if length_hdr is not None:
+                                args["total"] = int(length_hdr)
+                            prg = tqdm(**args)
+                            try:
+                                copyfileprog(prg, resp, dst)
+                            finally:
+                                prg.close()
+                        else:
+                            copyfileprog(None, resp, dst)
 
                 # Verify downloaded file size against length metadata, if
                 # available.
-- 
2.56.1


