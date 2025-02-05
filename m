Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B118C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfhot-0006p8-E6; Wed, 05 Feb 2025 11:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfhoq-0006oL-AK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:00:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfhoo-0001Lf-MA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738771201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZHuUSSEfLVR8YhjvWGcoC8+zUMIHyaTIZI83tFOw5M=;
 b=NAj2i8m2Z+aK6GCz6Q5Qi8aOe+ANixcMSxVtWCeUh60AtPcihxb5TbR6Vx0TVBAgogfwXC
 TYow2Q0dEyJbnz3ksEMJU9TwiP18V6gwgilEVbKVwLfp7PXdEihg4eIyMzoIIWvTwOD/3W
 VNO16oO20RIdmtmOeaNDk7nykgpDlcg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-fo0lflImNKOu8eWW-tJGsg-1; Wed,
 05 Feb 2025 10:59:58 -0500
X-MC-Unique: fo0lflImNKOu8eWW-tJGsg-1
X-Mimecast-MFC-AGG-ID: fo0lflImNKOu8eWW-tJGsg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E8721955ED9; Wed,  5 Feb 2025 15:59:57 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5678E195608D; Wed,  5 Feb 2025 15:59:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] tests/functional: set 'qemu_bin' as an object level field
Date: Wed,  5 Feb 2025 15:59:44 +0000
Message-ID: <20250205155946.2811296-4-berrange@redhat.com>
In-Reply-To: <20250205155946.2811296-1-berrange@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The 'qemu_bin' field is currently set on the class, despite being
accessed as if it were an object instance field with 'self.qemu_bin'.

This is no obvious need to have it as a class field, so move it into
the object instance.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/functional.rst      | 2 +-
 tests/functional/qemu_test/testcase.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index ecc738922b..bcb5509512 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -173,7 +173,7 @@ QEMU binary selection
 ^^^^^^^^^^^^^^^^^^^^^
 
 The QEMU binary used for the ``self.vm`` QEMUMachine instance will
-primarily depend on the value of the ``qemu_bin`` class attribute.
+primarily depend on the value of the ``qemu_bin`` instance attribute.
 If it is not explicitly set by the test code, its default value will
 be the result the QEMU_TEST_QEMU_BINARY environment variable.
 
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 332c782ebc..574c1942f2 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -33,7 +33,6 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
     arch = None
 
     workdir = None
@@ -193,6 +192,7 @@ def assets_available(self):
         return True
 
     def setUp(self):
+        self.qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
         if self.qemu_bin is None:
             self.skipTest("QEMU_TEST_QEMU_BINARY env variable is not set")
 
-- 
2.47.1


