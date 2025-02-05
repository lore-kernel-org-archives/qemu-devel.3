Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A5AC02198
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfhom-0006nV-Oi; Wed, 05 Feb 2025 11:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfhok-0006mZ-8x
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 10:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfhoi-0001Ku-Nr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 10:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738771195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fysQSNA1E970ViCFvsrSMcbTwNV0+wBLHllSL/r6qwc=;
 b=G5OdXD9QGjyPzhlkMpU4PqQUWB5n4/wcHD0jDNBiUAEXpglCyFRSkoSCoMX8lwPHBeQLre
 yrfyzKgKvxJW1xRdEZj4N8ExP/tQJc7MCR1hXau03pfSTpDPpWfOkOk78kkbBRTT1UuJ3S
 cln5lJxjRVa8alPHt2IyckUm1CtFTaQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-v0VYLq4kN0usPTmUcwozWg-1; Wed,
 05 Feb 2025 10:59:53 -0500
X-MC-Unique: v0VYLq4kN0usPTmUcwozWg-1
X-Mimecast-MFC-AGG-ID: v0VYLq4kN0usPTmUcwozWg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 632521800373; Wed,  5 Feb 2025 15:59:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FB6A195608D; Wed,  5 Feb 2025 15:59:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] tests/functional: skip test if QEMU_TEST_QEMU_BINARY is
 not set
Date: Wed,  5 Feb 2025 15:59:42 +0000
Message-ID: <20250205155946.2811296-2-berrange@redhat.com>
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

If QEMU_TEST_QEMU_BINARY is not set we currently assert in the setUp
function, resulting in a big traceback:

    TAP version 13
    Traceback (most recent call last):
      File "/var/home/berrange/src/virt/qemu/tests/functional/qemu_test/testcase.py", line 280, in setUp
        super().setUp('qemu-system-')
        ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
      File "/var/home/berrange/src/virt/qemu/tests/functional/qemu_test/testcase.py", line 196, in setUp
        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
        ~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    AssertionError: unexpectedly None : QEMU_TEST_QEMU_BINARY must be set

    not ok 1 test_ppc_405.Ppc405Machine.test_ppc_ref405ep
    1..1

For every other test pre-requisite that's missing we will mark the test
as skipped. This does the same for missing QEMU_TEST_QEMU_BINARY, such
that we get

    TAP version 13
    ok 1 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    ok 2 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_noapic_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    ok 3 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    ok 4 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    ok 5 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector_noapic # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    ok 6 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    ok 7 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_vapic # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
    1..7

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 869f3949fe..94541e8bfb 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -193,7 +193,9 @@ def assets_available(self):
         return True
 
     def setUp(self, bin_prefix):
-        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
+        if self.qemu_bin is None:
+            self.skipTest("QEMU_TEST_QEMU_BINARY env variable is not set")
+
         self.arch = self.qemu_bin.split('-')[-1]
         self.socketdir = None
 
-- 
2.47.1


