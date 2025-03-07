Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298E9C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 06:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRMq-000465-Pz; Fri, 07 Mar 2025 01:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqRMc-00044Q-W5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 01:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqRMa-0006ya-Sa
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 01:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741329554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/qUdH24ee/HUYBSZCO8t0ImAFGFtb/+CUvorB+vZAOc=;
 b=L18g3W62805U3OeK5yqZHdZGFv903lyawROIKtrtVGZiu8OQQyRX/CJU5kde/GQGbywyvr
 LY68N+UNG1lIy7JA77nlD+WJB3m1Vm6ME/tfQjTj2n+wQl8zutrD4QYZkANpEPw62XF1c/
 SvB749sKE/MTfXIJoBegFHo/jeePMfs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-xEok4JtpMxuAEIhymwYPxA-1; Fri,
 07 Mar 2025 01:39:09 -0500
X-MC-Unique: xEok4JtpMxuAEIhymwYPxA-1
X-Mimecast-MFC-AGG-ID: xEok4JtpMxuAEIhymwYPxA_1741329548
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F44D1809CA3
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 06:39:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1B3E1955DCE; Fri,  7 Mar 2025 06:39:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH] tests/functional/test_virtio_balloon: Only use KVM for
 running this test
Date: Fri,  7 Mar 2025 07:39:04 +0100
Message-ID: <20250307063904.1081961-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The virtio_balloon test is currently hanging for unknown reasons
when being run on the shared gitlab CI runners (which don't provide
KVM, thus it's running in TCG mode there). All other functional tests
that use the same asset (the Fedora 31 kernel) have already been
marked to work only with KVM in the past, so those other tests are
skipped on the shared gitlab CI runners. As long as the problem isn't
fully understood and fixed, let's do the same with the virtio_balloon
test to avoid that the CI is failing here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_virtio_balloon.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
index 082bf08c4e8..5877b6c408c 100755
--- a/tests/functional/test_virtio_balloon.py
+++ b/tests/functional/test_virtio_balloon.py
@@ -110,6 +110,7 @@ def assert_running_stats(self, then):
 
     def test_virtio_balloon_stats(self):
         self.set_machine('q35')
+        self.require_accelerator("kvm")
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
         diskimage_path = self.ASSET_DISKIMAGE.fetch()
@@ -122,7 +123,7 @@ def test_virtio_balloon_stats(self):
         # reset, we can reliably catch the clean stats again in BIOS
         # phase before the guest OS launches
         self.vm.add_args("-boot", "menu=on")
-        self.vm.add_args("-machine", "q35,accel=kvm:tcg")
+        self.vm.add_args("-accel", "kvm")
         self.vm.add_args("-device", "virtio-balloon,id=balloon")
         self.vm.add_args('-drive',
                          f'file={diskimage_path},if=none,id=drv0,snapshot=on')
-- 
2.48.1


