Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF37DCAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcWz-0001fv-4o; Mon, 08 Sep 2025 10:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWw-0001ei-2k
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWi-0007Ae-8X
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaRG7OdBMmnrOpcGiK6L7gyA3PnpDfGguSRlhtavI80=;
 b=X6pUo4ZYdwvSILPxWa3IQGz3hSushaV9KmGCC1yTFL8+H0Dyh4r0465ic5B5MCQd7nhdCx
 bIGhugUzWQl9rfEtKA8oOCqDs7WreaOZojv70j4WoYWE0euKKabAyGH9jbYObgK2vcVDNt
 BHt3WyrKTFjlznWtiv/DcvQgK7yJnBQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-z2sAZP4xOrOj2aT-FD987w-1; Mon,
 08 Sep 2025 10:07:11 -0400
X-MC-Unique: z2sAZP4xOrOj2aT-FD987w-1
X-Mimecast-MFC-AGG-ID: z2sAZP4xOrOj2aT-FD987w_1757340430
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D10E719560AD; Mon,  8 Sep 2025 14:07:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2756E19540EE; Mon,  8 Sep 2025 14:07:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 7/8] qapi: switch to use QEMU_TEST_REGENERATE env var
Date: Mon,  8 Sep 2025 10:06:51 -0400
Message-ID: <20250908140653.170707-8-stefanha@redhat.com>
In-Reply-To: <20250908140653.170707-1-stefanha@redhat.com>
References: <20250908140653.170707-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QAPI_TEST_UPDATE env var can be set when running the QAPI
schema tests to regenerate the reference output. For consistent
naming with the tracetool test, change the env var name to
QEMU_TEST_REGENERATE.

The test is modified to provide a hint about use of the new
env var and it is also added to the developer documentation.document its usage.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20250819161053.464641-8-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/testing/main.rst    | 12 ++++++++++++
 tests/qapi-schema/test-qapi.py |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 11f05c0006..0662766b5c 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -178,6 +178,18 @@ parser (either fixing a bug or extending/modifying the syntax). To do this:
 
   ``qapi-schema += foo.json``
 
+The reference output can be automatically updated to match the latest QAPI
+code generator by running the tests with the QEMU_TEST_REGENERATE environment
+variable set.
+
+.. code::
+
+   QEMU_TEST_REGENERATE=1 make check-qapi-schema
+
+The resulting changes must be reviewed by the author to ensure they match
+the intended results before adding the updated reference output to the
+same commit that alters the generator code.
+
 .. _tracetool-tests:
 
 Tracetool tests
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 4be930228c..cf7fb8a6df 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -165,7 +165,7 @@ def test_and_diff(test_name, dir_name, update):
     if actual_out == expected_out and actual_err == expected_err:
         return 0
 
-    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
+    print("%s: %s" % (test_name, 'UPDATE' if update else 'FAIL'),
           file=sys.stderr)
     out_diff = difflib.unified_diff(expected_out, actual_out, outfp.name)
     err_diff = difflib.unified_diff(expected_err, actual_err, errfp.name)
@@ -173,6 +173,9 @@ def test_and_diff(test_name, dir_name, update):
     sys.stdout.writelines(err_diff)
 
     if not update:
+        print(("\n%s: set QEMU_TEST_REGENERATE=1 to recreate reference output" +
+               "if the QAPI schema generator was intentionally changed") % test_name,
+              file=sys.stderr)
         return 1
 
     try:
@@ -197,7 +200,7 @@ def main(argv):
     parser.add_argument('-d', '--dir', action='store', default='',
                         help="directory containing tests")
     parser.add_argument('-u', '--update', action='store_true',
-                        default='QAPI_TEST_UPDATE' in os.environ,
+                        default='QEMU_TEST_REGENERATE' in os.environ,
                         help="update expected test results")
     parser.add_argument('tests', nargs='*', metavar='TEST', action='store')
     args = parser.parse_args()
-- 
2.51.0


