Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F13C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 06:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBJC-0002nh-Rf; Wed, 26 Feb 2025 01:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnBJA-0002mq-Qf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:54:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnBJ9-00055O-5Z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740552852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9iz5FZEm27cVFJCrvBHWk56asqIj6AdSHP9C/j7TADg=;
 b=R8nQAdX7hi5w99VuwMj4PCj8STUjPmPRuS4CPnjNrGiELmPxUNoChp25TjWELwRKBzqox7
 EavDmMqa2LfC2/32R914yaE5xOXxh7Hx4AV0VtxuPzbbhwaYoikzdgOzUcPydy5CvpqzEY
 rzSJAxIWpKDLpS7r1cKe011NkZwqOpM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-QkwyMHe5MQy9wjiDKfSWNQ-1; Wed,
 26 Feb 2025 01:54:09 -0500
X-MC-Unique: QkwyMHe5MQy9wjiDKfSWNQ-1
X-Mimecast-MFC-AGG-ID: QkwyMHe5MQy9wjiDKfSWNQ_1740552848
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75F661955F28; Wed, 26 Feb 2025 06:54:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 792A71800949; Wed, 26 Feb 2025 06:54:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] tests/functional: Update the ppc64 pseries and pnv tests
Date: Wed, 26 Feb 2025 07:54:01 +0100
Message-ID: <20250226065401.197915-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The tests are using a now archived Fedora29 release. Switch to the
most recent Fedora41 release.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_ppc64_powernv.py | 6 +++---
 tests/functional/test_ppc64_pseries.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
index 685e2178ed78..a9da7905366e 100755
--- a/tests/functional/test_ppc64_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -18,9 +18,9 @@ class powernvMachine(LinuxKernelTest):
     good_message = 'VFS: Cannot open root device'
 
     ASSET_KERNEL = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
-         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
-        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
+        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
+         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
 
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
index fdc404ed033d..92317cddead1 100755
--- a/tests/functional/test_ppc64_pseries.py
+++ b/tests/functional/test_ppc64_pseries.py
@@ -18,9 +18,9 @@ class pseriesMachine(QemuSystemTest):
     good_message = 'VFS: Cannot open root device'
 
     ASSET_KERNEL = Asset(
-        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
-         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
-        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
+        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
+         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
 
     def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
         kernel_path = self.ASSET_KERNEL.fetch()
-- 
2.48.1


