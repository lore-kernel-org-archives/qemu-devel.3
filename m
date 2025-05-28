Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77147C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDfP-0003hX-VL; Wed, 28 May 2025 06:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfJ-0003gH-P0
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfH-0007DK-8W
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlUQHTAuaVqvF8kv3Q5QXyGqMwCukrz0+7JZaW9TJ50=;
 b=ODiIQ2UUSiyXQZGQBmZ+aImNEOm/NME7CKtyYI/zZquUntS5jAed+nU0GrkbZWTwoj4+MI
 ya/4y4oUZyCd+4M/JU/VXbBJ9NxDNb+ZDTzqFN+FNxunIZtDAzwk7y4ucesblEQlm9oWhz
 XUagXJAw0RFlmaS/orASNsv7JaTWGu0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-l2KDWkhqNCaJmQKl93HbLg-1; Wed,
 28 May 2025 06:05:35 -0400
X-MC-Unique: l2KDWkhqNCaJmQKl93HbLg-1
X-Mimecast-MFC-AGG-ID: l2KDWkhqNCaJmQKl93HbLg_1748426734
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EB9E180036F; Wed, 28 May 2025 10:05:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B69318004A7; Wed, 28 May 2025 10:05:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/27] tests/functional: Test both microblaze s3adsp1800
 endianness variants
Date: Wed, 28 May 2025 12:04:47 +0200
Message-ID: <20250528100507.313906-8-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Now that the endianness of the petalogix-s3adsp1800 can be configured,
we should test that the cross-endianness also works as expected, thus
test the big endian variant on the little endian target and vice versa.
(based on an original idea from Philippe Mathieu-Daudé)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250515132019.569365-3-thuth@redhat.com>
---
 tests/functional/test_microblaze_s3adsp1800.py | 18 +++++++++++++-----
 .../functional/test_microblazeel_s3adsp1800.py |  6 +++++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c93fa14232b..f093b162c0a 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -25,12 +25,14 @@ class MicroblazeMachine(QemuSystemTest):
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def do_ballerina_be_test(self, machine):
-        self.set_machine(machine)
+    def do_ballerina_be_test(self, force_endianness=False):
+        self.set_machine('petalogix-s3adsp1800')
         self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
+        if force_endianness:
+            self.vm.add_args('-M', 'endianness=big')
         self.vm.launch()
         wait_for_console_pattern(self, 'This architecture does not have '
                                        'kernel memory protection')
@@ -39,12 +41,14 @@ def do_ballerina_be_test(self, machine):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
-    def do_xmaton_le_test(self, machine):
+    def do_xmaton_le_test(self, force_endianness=False):
         self.require_netdev('user')
-        self.set_machine(machine)
+        self.set_machine('petalogix-s3adsp1800')
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
+        if force_endianness:
+            self.vm.add_args('-M', 'endianness=little')
         tftproot = self.scratch_file('day13')
         self.vm.add_args('-nic', f'user,tftp={tftproot}')
         self.vm.launch()
@@ -59,9 +63,13 @@ def do_xmaton_le_test(self, machine):
 class MicroblazeBigEndianMachine(MicroblazeMachine):
 
     ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
+    ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE
 
     def test_microblaze_s3adsp1800_legacy_be(self):
-        self.do_ballerina_be_test('petalogix-s3adsp1800')
+        self.do_ballerina_be_test()
+
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test(force_endianness=True)
 
 
 if __name__ == '__main__':
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index ab59941d57a..915902d48bd 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -13,9 +13,13 @@
 class MicroblazeLittleEndianMachine(MicroblazeMachine):
 
     ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE
+    ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
 
     def test_microblaze_s3adsp1800_legacy_le(self):
-        self.do_xmaton_le_test('petalogix-s3adsp1800')
+        self.do_xmaton_le_test()
+
+    def test_microblaze_s3adsp1800_legacy_be(self):
+        self.do_ballerina_be_test(force_endianness=True)
 
 
 if __name__ == '__main__':
-- 
2.49.0


