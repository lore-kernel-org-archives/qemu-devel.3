Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EABC61CE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 18:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMWfX-0001Yi-Mb; Tue, 03 Jun 2025 14:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMWfW-0001Xt-7F
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMWfU-0006el-Ah
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748976439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kz0dI54XAaJ9n+WO7qmUxWmrA/roIpl99yBQfi8JVtU=;
 b=F0M6bwInLmAVBtRw0XWoySStUyfJu8rb92hiJRI8c9mQbNDEm1CD9Lz8Kh89BNJxc+S8hh
 /AQgs5nQUgbm5mA8c8X9Qr+mwO0wX7PvdCYqNEDTtu+KpJo782/f86Bvg5s7Vb8s/lCDAF
 FWj7kOqfxYDKsbuUMF5384JxlQ+NJ0s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-xz_LWkf_Moie3npey7y8VA-1; Tue,
 03 Jun 2025 14:47:16 -0400
X-MC-Unique: xz_LWkf_Moie3npey7y8VA-1
X-Mimecast-MFC-AGG-ID: xz_LWkf_Moie3npey7y8VA_1748976434
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A97219560AA; Tue,  3 Jun 2025 18:47:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.37])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6BB319560AF; Tue,  3 Jun 2025 18:47:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional: Speed up the avr_mega2560 test
Date: Tue,  3 Jun 2025 20:47:10 +0200
Message-ID: <20250603184710.25651-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

We can simply check for the expected pattern on the console,
no need to wait for two seconds here to search for the pattern
in the log at the end.

While we're at it, also remove the obsolete "timeout" variable
from this test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_avr_mega2560.py | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/functional/test_avr_mega2560.py b/tests/functional/test_avr_mega2560.py
index 8e47b4200b1..6359b72af39 100755
--- a/tests/functional/test_avr_mega2560.py
+++ b/tests/functional/test_avr_mega2560.py
@@ -18,12 +18,10 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-import time
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
-from qemu_test import QemuSystemTest, Asset
 
 class AVR6Machine(QemuSystemTest):
-    timeout = 5
 
     ASSET_ROM = Asset(('https://github.com/seharris/qemu-avr-tests'
                        '/raw/36c3e67b8755dcf/free-rtos/Demo'
@@ -40,13 +38,12 @@ def test_freertos(self):
         self.set_machine('arduino-mega-2560-v3')
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
+        self.vm.set_console()
         self.vm.launch()
 
-        time.sleep(2)
-        self.vm.shutdown()
+        wait_for_console_pattern(self,
+                        'XABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWXA')
 
-        self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',
-                self.vm.get_log())
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.49.0


