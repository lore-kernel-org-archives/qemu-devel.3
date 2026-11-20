Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C441606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M8k8h5JJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNXL-0006of-KT; Fri, 20 Nov 2026 07:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUNXE-0006ZY-L4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUNXB-0006Ly-N0
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795176965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SLTl67ILFmADmNBfehKS86bzFqZRjZXR6jhC/n4zuw=;
 b=M8k8h5JJKN1Cv577xmloamc9bmlkhkH7XXGppzZesS+I2R/wWhdbCWH51w5GcF5Q/tnj7z
 57JLj8msMZvo6DOiUUQBCcvJDBfG2975nBaymxrhbf5iUhTgZzGmvMetm4L1B5Z5csmBv9
 tJS88/iUJU6xFJFgKJFh+mUN3gFg3pU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-XJ0ZLggTOee_Av2o3L4Z4w-1; Fri,
 20 Nov 2026 12:15:59 +0000
X-MC-Unique: XJ0ZLggTOee_Av2o3L4Z4w-1
X-Mimecast-MFC-AGG-ID: XJ0ZLggTOee_Av2o3L4Z4w_1795176957
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E1F318002CA; Fri, 20 Nov 2026 12:15:57 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C32AF30000E3; Fri, 20 Nov 2026 12:15:52 +0000 (UTC)
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
Subject: [PATCH 11/12] tests/functional: only run pre-cache once per class
Date: Fri, 20 Nov 2026 12:14:57 +0000
Message-ID: <20261120121458.3723625-12-berrange@redhat.com>
In-Reply-To: <20261120121458.3723625-1-berrange@redhat.com>
References: <20261120121458.3723625-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When precaching assets, we iterate over test cases, downloading
all assets in the class containing the test suite. This often
results in iterating over assets in the class multiple times.

If we fail to download an asset from a non-transient problem,
it will not end up in the cache, and so the subsequent iterations
will retry the failed download again wasting time, as well as
making the logs more verbose.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/asset.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 313efcf7626..7bebdd4d481 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -273,11 +273,13 @@ def fetch(self):
         return str(self.cache_file)
 
     @staticmethod
-    def precache_test(test):
+    def precache_test(test, done):
         '''
         Look for variables starting with "ASSET_" and try to fetch the asset
         that is specified there.
         '''
+        if test.__class__ in done:
+            return
         log = logging.getLogger('qemu-test')
         log.setLevel(logging.DEBUG)
         handler = logging.StreamHandler(sys.stdout)
@@ -295,18 +297,19 @@ def precache_test(test):
                         raise
                     log.error("%s: skipping asset precache", e)
 
+        done[test.__class__] = True
         log.removeHandler(handler)
 
     @staticmethod
-    def precache_suite(suite):
+    def precache_suite(suite, done):
         '''
         Iterate through all tests/suites in a suite and precache their assets
         '''
         for test in suite:
             if isinstance(test, unittest.TestSuite):
-                Asset.precache_suite(test)
+                Asset.precache_suite(test, done)
             elif isinstance(test, unittest.TestCase):
-                Asset.precache_test(test)
+                Asset.precache_test(test, done)
 
     @staticmethod
     def precache_suites(path, cache_tstamp):
@@ -316,5 +319,5 @@ def precache_suites(path, cache_tstamp):
         loader = unittest.loader.defaultTestLoader
         tests = loader.loadTestsFromNames([path], None)
 
-        Asset.precache_suite(tests)
+        Asset.precache_suite(tests, {})
         Path(cache_tstamp).touch()
-- 
2.56.1


