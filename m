Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7B1CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JAy-0002Uu-5n; Wed, 24 Sep 2025 02:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAv-0002UO-Pv
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAh-0006gs-9w
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeRkTPCaOQ4BFfDiWdF99N1t2c77iucL/acwXAdfPdY=;
 b=agQ9aKWF+suF2IC0A0cZKNR6IfY3+haOkJ14iczf5ajXvx1mmLZE9HgerihyYD0gyfc11K
 BghDpBJF9UsywXIWZWP9yfkEm0sz5aRQh4c4KRYWrw4TQ8B3qChsemmcHTPzWnIb7blDsm
 AE/Tyn6kysM6OeRu5xiT1ncmEAPD8aE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-1YTZxpriN_GIvvT0CT-ZUw-1; Wed,
 24 Sep 2025 02:40:02 -0400
X-MC-Unique: 1YTZxpriN_GIvvT0CT-ZUw-1
X-Mimecast-MFC-AGG-ID: 1YTZxpriN_GIvvT0CT-ZUw_1758696001
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E9921956089; Wed, 24 Sep 2025 06:40:01 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC3111955F19; Wed, 24 Sep 2025 06:39:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/12] tests/functional/m68k: Use proper polling in the
 next-cube test
Date: Wed, 24 Sep 2025 08:39:45 +0200
Message-ID: <20250924063956.519792-2-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Message-ID: <20250909074817.84661-1-thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


