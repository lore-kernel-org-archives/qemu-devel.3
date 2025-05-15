Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F20C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYW1-0008LF-Er; Thu, 15 May 2025 09:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYW0-0008Ky-Ah
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYVy-0003c6-Fk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747315245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PxA0XKCVx8Lt+/MFyfb4RNvjMzl4cOYRTInU7JAYUE=;
 b=Bq675dP+B1+c4dA9o2wq3m1pHMAT8Pmt0CilXct3q1H9SGRgK7qyvaaJQ9qJ87PVYtS5av
 wjLXC+e3WvC1lpyhk5Uy305gV07wI9LO2XSfg6TrGiNnOwbvwCXyfGPFdn2cuiqqU/QxpJ
 P82CZcQLpRH52RfwX4B21zJ0m7Gl4tQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-k8nomAaSPX6fY1Yh86I61Q-1; Thu,
 15 May 2025 09:20:42 -0400
X-MC-Unique: k8nomAaSPX6fY1Yh86I61Q-1
X-Mimecast-MFC-AGG-ID: k8nomAaSPX6fY1Yh86I61Q_1747315241
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BFF180099F; Thu, 15 May 2025 13:20:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03C9B1956094; Thu, 15 May 2025 13:20:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/4] tests/functional: Test both microblaze s3adsp1800
 endianness variants
Date: Thu, 15 May 2025 15:20:17 +0200
Message-ID: <20250515132019.569365-3-thuth@redhat.com>
In-Reply-To: <20250515132019.569365-1-thuth@redhat.com>
References: <20250515132019.569365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Now that the endianness of the petalogix-s3adsp1800 can be configured,
we should test that the cross-endianness also works as expected, thus
test the big endian variant on the little endian target and vice versa.
(based on an original idea from Philippe Mathieu-Daudé)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_microblaze_s3adsp1800.py  | 17 ++++++++++++-----
 .../functional/test_microblazeel_s3adsp1800.py  |  5 ++++-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c93fa14232b..c5e60b555c6 100755
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
@@ -61,7 +65,10 @@ class MicroblazeBigEndianMachine(MicroblazeMachine):
     ASSET_IMAGE_BE = MicroblazeMachine.ASSET_IMAGE_BE
 
     def test_microblaze_s3adsp1800_legacy_be(self):
-        self.do_ballerina_be_test('petalogix-s3adsp1800')
+        self.do_ballerina_be_test()
+
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test(force_endianness=True)
 
 
 if __name__ == '__main__':
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index ab59941d57a..9de27d09b75 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -15,7 +15,10 @@ class MicroblazeLittleEndianMachine(MicroblazeMachine):
     ASSET_IMAGE_LE = MicroblazeMachine.ASSET_IMAGE_LE
 
     def test_microblaze_s3adsp1800_legacy_le(self):
-        self.do_xmaton_le_test('petalogix-s3adsp1800')
+        self.do_xmaton_le_test()
+
+    def test_microblaze_s3adsp1800_legacy_be(self):
+        self.do_ballerina_be_test(force_endianness=True)
 
 
 if __name__ == '__main__':
-- 
2.49.0


