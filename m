Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D583CCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvt5j-0007Rb-UE; Tue, 09 Sep 2025 03:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvt5i-0007RI-4q
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvt5Z-0004ev-7c
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757404104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ULHd9tfIZQEbCnwMnKQBnRIR0s2ba1HeMMVACVRgL2g=;
 b=GFnMv6Sq1Y8UElpzQ1SEctdMelIfyy3yctUJ8RBJ5NVBt9H2rRE/enrCj1q7xHARUVHcd9
 MLGXxZJVUKoODZaSF7zSU4k5vgtZIed7cwlYdxurEie12AMt/lLOSWrrai1ubT3DhrWSRG
 4MZHxQaLEildnsmEkVnc3X73JKvq0wg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-58kmEukKOZK6IqNxYyN4HA-1; Tue,
 09 Sep 2025 03:48:21 -0400
X-MC-Unique: 58kmEukKOZK6IqNxYyN4HA-1
X-Mimecast-MFC-AGG-ID: 58kmEukKOZK6IqNxYyN4HA_1757404100
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6992519560B3; Tue,  9 Sep 2025 07:48:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1188318003FC; Tue,  9 Sep 2025 07:48:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH] tests/functional/m68k: Use proper polling in the next-cube
 test
Date: Tue,  9 Sep 2025 09:48:17 +0200
Message-ID: <20250909074817.84661-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

The next-cube tests currently sleep for 2 seconds to wait for the
guest's display to come up with the expected results. That's bad
since there is still a theoretical race left here, and since there
are two subtests, the whole test takes more than 4 seconds this way.

Looking at what the firmware does, there is a better way instead of
blindly waiting for two seconds: The firmware is writing some values
to the FPU registers during a test (and never touches them again
afterwards, so we can be sure about the final values), so we can
poll for the right values in those registers to know when we reached
a state when the display is initialized for sure. We just have to
also make sure to not look for text anymore that is only printed
after the FPU test has been done by the guest firmware.

This way the whole tests finishes in less than 1 second here, and
there should be no race condition here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index c1610e58456..e5e1c69dcbd 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -29,8 +29,15 @@ def check_bootrom_framebuffer(self, screenshot_path):
         self.vm.launch()
 
         self.log.info('VM launched, waiting for display')
-        # TODO: wait for the 'displaysurface_create 1120x832' trace-event.
-        time.sleep(2)
+        # Wait for the FPU test to finish, then the display is available, too:
+        while True:
+            res = self.vm.cmd('human-monitor-command',
+                              command_line='info registers')
+            if ("F0 = 400e 8400000000000000" in res and
+                "F1 = 400e 83ff000000000000" in res and
+                "F2 = 400e 83ff000000000000" in res):
+                break
+            time.sleep(0.1)
 
         res = self.vm.cmd('human-monitor-command',
                           command_line='screendump %s' % screenshot_path)
@@ -56,10 +63,10 @@ def test_bootrom_framebuffer_ocr_with_tesseract(self):
         self.check_bootrom_framebuffer(screenshot_path)
         lines = tesseract_ocr(screenshot_path)
         text = '\n'.join(lines)
+        self.assertIn('Backplane slot', text)
+        self.assertIn('Ethernet address', text)
         self.assertIn('Testing the FPU', text)
-        self.assertIn('System test failed. Error code', text)
-        self.assertIn('Boot command', text)
-        self.assertIn('Next>', text)
+
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


