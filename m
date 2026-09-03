Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C22C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fK-0002zJ-Hd; Thu, 03 Sep 2026 10:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fH-0002wF-3c
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fE-000491-JJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso36637205e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446619; x=1789051419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WH4NtQS27vnM9CBskaa8A4wfHHtgS6Dz+fFxVJqp21Q=;
 b=pfejoF+Ofi3GKurBUUMoHXgshxkkmbmy4FYjEYt395wEH7F4RQ+NEI0CuiVVzZRzdX
 R2JPVmOiXIRPh/CvA+PqTPVCoaj2/lYcv4e3/sZS9lK5Xz+uLZbXfK7IhZBRGB2cprDg
 9rOTkouulYJQR70zpW02zo/hXUOppmhLcCqOQp2CjGEmV26XaWESDeaSFLDpL1Y+NwUZ
 1IQp//puch/hIgXKoknaOqfYTEJFRUaiEs3G5WUGOCTfBv47hiZEHKMcF0Bmt3kPOkBn
 u+fSikDKCcnAFBwjNKH1dl2XCfTRkLdhqqs9rIvZ1e9PoSjI8Rmjb5/YoMf2uRFl78Df
 4FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446619; x=1789051419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WH4NtQS27vnM9CBskaa8A4wfHHtgS6Dz+fFxVJqp21Q=;
 b=bMzyRIUJ2mxa18BDJcVNhqD1X+kTmT8xvKxoLa6j6N3XaGed342cZgxt9oSD3TQ0Py
 wYs4PmXI0uc536Nu1nhoH3cLmrP93hk48Mi/+5BG5S5A88gR4kgqFaIFTrexUA54RCGr
 1QQLml7QqYMEadkxkIsUKjl+oow48/znTTlYA7KOsnoJkklG9douwCzPWBtPYchDuu87
 XDuNn40t+coeDQ6c9YzoiFpwQs83H8vqSrnIn4iIbMt/OHHSOI7ldBIPTUaWTg3qqCX0
 LwDJkctWmFObmX42J9Xudz8+9SaTG9x2ucmjEes9bu/uAkKIY+uDIRpjlxuqtGW+a4Ya
 zeIw==
X-Gm-Message-State: AFuF++nbY6qkY+W3Ltz0gvUwA1tLvjQIKwwV+/BWPuMhMFwf1g1y7afS
 Mm1YqiOPZP9hiEE2Wk0TQIPNhw4BFpcfvYlzZ8HGR/QI/OkkXyobtqVVI+JKWuXKHyp/VBOKDht
 5b7MF
X-Gm-Gg: AYBFou0+olaEeMH5VCIy28aExsyhOnvXk1126yCwKyCcTP+r5ZbH1tPW9jvGM3TlPj+
 sU/JVNHWe5/O7NYH+6qeMTAplza0PnsNg+eX9ixGCIQ87wItdAYxTeGTl0Y5tUm6eCM/7SCqgzI
 0xi1XEr/XjrmijTS/LLL5s+zAT8GkHyo1w/R7zaxfdtalTIB26PO5hjggVCj9p/cGM80/GikuLY
 ffjQmfxREsVQzm9tmLtl3jB9VYjDgAOXXZ1PyeNrI0cnDu7T882HgmxhlfsEJxPfs+S4zrMDchr
 OnltF0bc9bwLxpyQzZFbEEUD/XZhKJ9SgRZn+zP3yY4HP0aB3PpudBXopMyh/+mA4jN0By35PZg
 hZHUVjinAXVeHOG08BjudMqJDpsuHZnqHWLAnNgncJI6mrATgtBBKZtRoU+VIoQwntuSOLqrZG9
 Z1EOxV11/ZtIje32xVO7m3DexZaPnMYWBW0uYRkSzn5WUA59Dl7WkxaOwd
X-Received: by 2002:a05:600c:6296:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49ce581635bmr258106275e9.3.1788446618812; 
 Thu, 03 Sep 2026 07:43:38 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:38 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v7 24/25] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Thu,  3 Sep 2026 16:41:42 +0200
Message-ID: <20260903144143.2328870-25-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

These tests pass with parallels format. Add parallels to supporting
formats for these tests.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/256                      | 2 +-
 tests/qemu-iotests/299                      | 2 +-
 tests/qemu-iotests/304                      | 2 +-
 tests/qemu-iotests/tests/block-status-cache | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..1a4c9c6885 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -26,7 +26,7 @@ from iotests import log
 
 iotests.verify_virtio_scsi_pci_or_ccw()
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'])
 size = 64 * 1024 * 1024
 
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
index a7122941fd..d8c4399446 100755
--- a/tests/qemu-iotests/299
+++ b/tests/qemu-iotests/299
@@ -23,7 +23,7 @@ import iotests
 
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
 )
 
 nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index d465a519a9..03c7c1cbe3 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -23,7 +23,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
-iotests.script_initialize(supported_fmts=['qcow2'],
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
                           supported_protocols=['file'],
                           require_hmp=True)
 
diff --git a/tests/qemu-iotests/tests/block-status-cache b/tests/qemu-iotests/tests/block-status-cache
index 5a7bc2c149..ade3d5b169 100755
--- a/tests/qemu-iotests/tests/block-status-cache
+++ b/tests/qemu-iotests/tests/block-status-cache
@@ -131,5 +131,5 @@ class TestBscWithNbd(iotests.QMPTestCase):
 if __name__ == '__main__':
     # The block-status cache only works on the protocol layer, so to test it,
     # we can only use the raw format
-    iotests.main(supported_fmts=['raw'],
+    iotests.main(supported_fmts=['raw', 'parallels'],
                  supported_protocols=['file'])
-- 
2.53.0


