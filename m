Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49576608B060
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbwEJdP8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuzo-0007xc-Ji; Mon, 02 Nov 2026 11:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNuzn-0007wt-1S
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:34:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNuzl-0002rL-G9
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fTwtRot0qQGVg0nR/KRGnqK0aBeabDfyMcYqq7wtPSk=;
 b=gbwEJdP8rCmvojoqXpXxaGVKR1b4RO5yNTo2VNwO3kByphweSsw6i/hjcxolI+g2ZjQF0J
 uxfkMudWnqrWFHMdsIAUarXmVhzG90QM7cHPEeI5P7RST+ezuyxZ7BOOidx6zWnIvVryue
 LVC4L1PBRW0xvb4tnKX8TKpxWUm/CJQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-0defPbIsPzKjBdetkfYfCg-1; Mon,
 02 Nov 2026 11:34:50 -0500
X-MC-Unique: 0defPbIsPzKjBdetkfYfCg-1
X-Mimecast-MFC-AGG-ID: 0defPbIsPzKjBdetkfYfCg_1793637290
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D998218005B1; Mon,  2 Nov 2026 16:34:49 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97C7F300019F; Mon,  2 Nov 2026 16:34:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] iotests: add --quiet arg to hide env variable dump
Date: Mon,  2 Nov 2026 16:34:47 +0000
Message-ID: <20261102163447.3613901-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every test run dumps a long list of environment variable settings.
While this is often useful, if you are trying to reproduce a bug
while repeatedly running a single test it can be quiet noisy. Add
a --quiet flag to 'check' which allows the env variable dump to
be hidden. With this is only prints out the tests being run and
the overall status on completion.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/check         | 4 +++-
 tests/qemu-iotests/testrunner.py | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 3941eac8e21..c8ba536970c 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -46,6 +46,8 @@ def make_argparser() -> argparse.ArgumentParser:
         description="Test run options",
         formatter_class=argparse.ArgumentDefaultsHelpFormatter)
 
+    p.add_argument('-q', '--quiet', action='store_true',
+                   help='reduce output verbosity to only test results')
     p.add_argument('-n', '--dry-run', action='store_true',
                    help='show me, do not run tests')
     p.add_argument('-j', dest='jobs', type=int, default=1,
@@ -230,6 +232,6 @@ if __name__ == '__main__':
         with TestRunner(env, tap=args.tap,
                         color=args.color) as tr:
             paths = [os.path.join(env.source_iotests, t) for t in tests]
-            ok = tr.run_tests(paths, args.jobs)
+            ok = tr.run_tests(paths, args.jobs, args.quiet)
             if not ok:
                 sys.exit(1)
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 729680da4aa..f35e65f805f 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -376,7 +376,8 @@ def run_test(self, test: str,
         sys.stdout.flush()
         return res
 
-    def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
+    def run_tests(self, tests: List[str], jobs: int = 1,
+                  quiet: bool = False) -> bool:
         n_run = 0
         failed = []
         notrun = []
@@ -384,9 +385,10 @@ def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
 
         if self.tap:
             print('TAP version 13')
-            self.env.print_env('# ')
+            if not quiet:
+                self.env.print_env('# ')
             print('1..%d' % len(tests))
-        else:
+        elif not quiet:
             self.env.print_env()
 
         test_field_width = max(len(os.path.basename(t)) for t in tests) + 2
-- 
2.56.0


