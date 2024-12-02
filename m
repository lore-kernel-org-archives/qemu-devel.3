Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E3FD78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6uz-0000pL-99; Mon, 02 Dec 2024 08:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6ux-0000p1-7w
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI6uv-0001LN-QD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733147808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlkG/2P74VKsHDGGorgrOLQ307sG7W2ApfFdIYm/k5A=;
 b=I1uxz89xjjty4BblaZqtQ3y+EsWNalC/a1e5fk4H7pKk2zqnXOy+CR7QGOkwGC/u8HQh9e
 NnB8Lz24p3O5YwGojsvad0SYKoPQ4At+qA0wFXrHTImXVTMjHmfUBEbX/Fw32sHQ9ARU21
 +DEqAp5bfs31I+h+icagmpVFfsHAaNc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-mILzdNsMNIqzT5OAyXU16A-1; Mon,
 02 Dec 2024 08:56:45 -0500
X-MC-Unique: mILzdNsMNIqzT5OAyXU16A-1
X-Mimecast-MFC-AGG-ID: mILzdNsMNIqzT5OAyXU16A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A0B91944DD3; Mon,  2 Dec 2024 13:56:44 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-206.str.redhat.com
 [10.33.192.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 774581956089; Mon,  2 Dec 2024 13:56:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] tests/functional/test_acpi_bits: Turn the test into a
 QemuSystemTest
Date: Mon,  2 Dec 2024 14:56:38 +0100
Message-ID: <20241202135640.80528-2-thuth@redhat.com>
In-Reply-To: <20241202135640.80528-1-thuth@redhat.com>
References: <20241202135640.80528-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By using QemuSystemTest as a base class, we can use the set_machine()
command to check whether the required machine is available in the
binary (otherwise this test is failing when QEMU has been compiled
without the default 'pc' machine type).

Message-ID: <20241128115019.591362-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_acpi_bits.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 3498b96787..e2f84414d7 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -50,7 +50,7 @@
 )
 from qemu.machine import QEMUMachine
 from unittest import skipIf
-from qemu_test import QemuBaseTest, Asset
+from qemu_test import QemuSystemTest, Asset
 
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
@@ -127,7 +127,7 @@ def base_args(self):
 @skipIf(not supported_platform() or missing_deps(),
         'unsupported platform or dependencies (%s) not installed' \
         % ','.join(deps))
-class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
+class AcpiBitsTest(QemuSystemTest): #pylint: disable=too-many-instance-attributes
     """
     ACPI and SMBIOS tests using biosbits.
     """
@@ -284,7 +284,7 @@ def generate_bits_iso(self):
         self.logger.info('iso file %s successfully generated.', iso_file)
 
     def setUp(self): # pylint: disable=arguments-differ
-        super().setUp('qemu-system-')
+        super().setUp()
         self.logger = self.log
 
         self._baseDir = Path(__file__).parent
@@ -354,6 +354,7 @@ def tearDown(self):
     def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
+        self.set_machine('pc')
         iso_file = os.path.join(self.workdir,
                                 'bits-%d.iso' %self.BITS_INTERNAL_VER)
 
@@ -388,4 +389,4 @@ def test_acpi_smbios_bits(self):
         self.parse_log()
 
 if __name__ == '__main__':
-    QemuBaseTest.main()
+    QemuSystemTest.main()
-- 
2.47.0


