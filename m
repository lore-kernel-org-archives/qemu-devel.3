Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97298CF538E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 14:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3cD3-0002Qw-MR; Wed, 23 Oct 2024 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3cCy-0002Pd-Co
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 10:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3cCv-0003ZS-UC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 10:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729693168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9X8a1pk6QPXgOz8I9lbIE4Pkv0zayzs8cQDEoOHjlWA=;
 b=LYo3R2yofYlj9yauoVcZq8XV9BqBCFa86wMkes3DNBoRckqG5lPjQzAGEWfo0q6OQHhUJB
 oqaWDo841z2bofEHFnVFzELuiTJt5z+bIz9C0fgXUbOjyvRuuix7XR+F5ZRwuT7xRb3QX9
 flwWH6NxZEjm/WBcUOGD799zMjWWaoQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-YEGqgEfUOv6e6iXm4G_0CA-1; Wed,
 23 Oct 2024 10:19:26 -0400
X-MC-Unique: YEGqgEfUOv6e6iXm4G_0CA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C1F119560B6; Wed, 23 Oct 2024 14:19:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D0441955F3B; Wed, 23 Oct 2024 14:19:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH] tests/functional: Fix the s390x and ppc64 tuxrun tests
Date: Wed, 23 Oct 2024 16:19:19 +0200
Message-ID: <20241023141919.930689-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

I forgot to add the tests to the meson.build file and looks
like I even managed to somehow mix up the hashsums in the
ppc64 test!

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build          | 3 +++
 tests/functional/test_ppc64_tuxrun.py | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 5ccc1aa66d..d4b675bf63 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -23,6 +23,7 @@ test_timeouts = {
   'ppc64_hv' : 1000,
   'ppc64_powernv' : 240,
   'ppc64_pseries' : 240,
+  'ppc64_tuxrun' : 240,
   's390x_ccw_virtio' : 240,
 }
 
@@ -133,6 +134,7 @@ tests_ppc64_system_thorough = [
   'ppc64_hv',
   'ppc64_powernv',
   'ppc64_pseries',
+  'ppc64_tuxrun',
 ]
 
 tests_rx_system_thorough = [
@@ -150,6 +152,7 @@ tests_riscv64_system_thorough = [
 tests_s390x_system_thorough = [
   's390x_ccw_virtio',
   's390x_topology',
+  's390x_tuxrun',
 ]
 
 tests_sh4_system_thorough = [
diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
index 552b53c97a..03b47e07f2 100755
--- a/tests/functional/test_ppc64_tuxrun.py
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -83,10 +83,10 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
 
     ASSET_PPC64_KERNEL = Asset(
         'https://storage.tuxboot.com/20230331/ppc64/vmlinux',
-        '1d953e81a4379e537fc8e41e05a0a59d9b453eef97aa03d47866c6c45b00bdff')
+        'f22a9b9e924174a4c199f4c7e5d91a2339fcfe51c6eafd0907dc3e09b64ab728')
     ASSET_PPC64_ROOTFS = Asset(
         'https://storage.tuxboot.com/20230331/ppc64/rootfs.ext4.zst',
-        'f22a9b9e924174a4c199f4c7e5d91a2339fcfe51c6eafd0907dc3e09b64ab728')
+        '1d953e81a4379e537fc8e41e05a0a59d9b453eef97aa03d47866c6c45b00bdff')
 
     def test_ppc64(self):
         self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64_KERNEL,
-- 
2.47.0


