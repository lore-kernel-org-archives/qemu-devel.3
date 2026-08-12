Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1834C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7rW-0001gM-6k; Wed, 12 Aug 2026 08:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rU-0001ec-9i
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rS-00089H-Je
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso12782455e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786536909; x=1787141709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3aAZ1Qz9d3rQwutTATeE2uSnDxeHOQSNQO9Jv6Voyg=;
 b=FZkzLsOgKu4QOKbi5OEGxyPwHZoA3cX0tcfmFmrV5VdjxeLqoD7rlc3adjDITxcyId
 MCRM3proW5jd/qX6Ym9zR49l7rCKVD7etO4HlDdIZdDxU5NtAGqEiD65MCGiwyrCghT9
 zaNZDCYlJBEk59WTVVJKmQ3cPSkw33E5A/5/QZhSdtZFb2Q6bj3d+cYOEeW12H2Itj14
 P+QOog73aJK4nEWfEJl0SUhHHZZ5TlBPE86JgAq9svLjc2dqZdQzaZXJO0LZhTKiFgrt
 D7/+o+ubgAIMZiLR/SsFtUcZz4+jTUFbPahZgWyaNFE1Ht0A52+8IjbjLeW0Fh7/G87A
 0/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536909; x=1787141709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3aAZ1Qz9d3rQwutTATeE2uSnDxeHOQSNQO9Jv6Voyg=;
 b=mxi19aj6GqjUKhwNI+nHEee9iALRkwfTnfxaZGy6etO4PKZ2NWI0K1gpduJQYqyBlh
 v6wcvJPgjriga9Hs33BqgkR+wfotOjXETPYC35jZ1u3J57j4Wbod+GEmNM3I0e4YuJn2
 ghrh/JJVfVCDnHTdELQYhgVf4R/DoXWeX91512M3hT1uyGV88pjwAJjQ8zu3SXYdpUqI
 de3TjSQe8W9Pu0+zU6L5+Ke6hQ6+nandjwf3kUfQZHt9O8EdLkwClJfI9R1U3Ku6aU8G
 lJ9aS+JUJKLuaxLlFMrneZZAyHZ2qoyORO4OWpFnJhl/W1/ZABoNzRsFLlEGDziHERyU
 m8cg==
X-Gm-Message-State: AOJu0YxgCYePPXIICkQe9tPzZUGSmaCHVyAWV7rsmmRGRCmXjLFHYGfF
 PAvvQ+lUGWGRUcV9aTXrSqRbfOGZ8URXmAJyij++P+UixQ/eo2xa64EHdP/5mmeqf7G2VB+zFfa
 E/w0E
X-Gm-Gg: AR+sD10nx9811CA+fJc3fCVlhK8g7dsTKM0CBZqcs9qfciypcHfVPCGGHuQEfkIeIRh
 bnD4uf678U+rDf40UUB3hhikVwc03Ixw8eQAhdJ7U63rCk4hNEjLcp6njih064lEpa516TDTDhc
 3Caw36WOLfvAFZZ2FdP+t53c9QC+xD378GQsV+hXAEHbI5HKM9D5ho2eq2IkzV2ST47Hz3vEa/8
 dTulD0e/RNR6ZD+77CykUuGBALIJwQxIDluTZY0URIBIeaZfjBBAlJf+sdIyhTLaas2/pAbei9/
 EDj8D8MsyEOwMOGsPnflf4htFRNvuXUSHjLlt3xgDr8BtVD75tetiwS0vqQZEKzr5Y+K82fTbMT
 Kyv6nCksx9MfnADPG7YSlGmBhI4HmkDYGXg4RkNNn9Jt+W3WwhbH3YAJFrMoyqMmPcuSGwSN89k
 sz43TSISvkMD/iX+nyz3XZ8rcqiHQYfeAmizLw2w+ALPddj6V2dqDqMJ6711Q=
X-Received: by 2002:a05:600c:154d:b0:499:51f0:a9b2 with SMTP id
 5b1f17b1804b1-4997c0fe6a0mr56837145e9.1.1786536908653; 
 Wed, 12 Aug 2026 05:15:08 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad267c2sm49069945e9.0.2026.08.12.05.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:15:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 4/4] tests/qemu-iotests/qom-set-drive: replace with a
 differently sized node
Date: Wed, 12 Aug 2026 14:15:00 +0200
Message-ID: <20260812121500.1034178-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
References: <20260812121500.1034178-1-den@openvz.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All images in this test have the same size, so the test never reaches
the size change path of bdrv_replace_child_bs(). Add a node of a
different size and point a device at it.

The notification itself is not visible over QMP, so this only covers the
block layer side. What the device does with it is checked by
tests/qtest/virtio-scsi-test.c.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/qom-set-drive     | 14 +++++++++++---
 tests/qemu-iotests/tests/qom-set-drive.out |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/tests/qom-set-drive b/tests/qemu-iotests/tests/qom-set-drive
index ec8ddac4fd..52d7eb96da 100755
--- a/tests/qemu-iotests/tests/qom-set-drive
+++ b/tests/qemu-iotests/tests/qom-set-drive
@@ -24,12 +24,15 @@ import iotests
 from iotests import imgfmt, log, qemu_img_create, QMPTestCase
 
 image_size = 1 * 1024 * 1024
-images = [os.path.join(iotests.test_dir, f'{i}.img') for i in range(0, 4)]
+images = [os.path.join(iotests.test_dir, f'{i}.img') for i in range(0, 5)]
+
+# node4 is deliberately larger, to cover a replacement which changes the size
+image_sizes = [image_size] * 4 + [2 * image_size]
 
 class TestQOMSetDrive(QMPTestCase):
     def setUp(self) -> None:
-        for image in images:
-            qemu_img_create('-f', imgfmt, image, str(image_size))
+        for image, size in zip(images, image_sizes):
+            qemu_img_create('-f', imgfmt, image, str(size))
 
         self.vm = iotests.VM()
         for i, image in enumerate(images):
@@ -68,6 +71,11 @@ class TestQOMSetDrive(QMPTestCase):
         log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
                         property='drive'))
 
+        log(self.vm.qmp('qom-set', path='/machine/peripheral/no-iot',
+                        property='drive', value='node4'))
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
+                        property='drive'))
+
 if __name__ == '__main__':
     iotests.activate_logging()
     # LUKS would require special key-secret handling in add_blockdevs()
diff --git a/tests/qemu-iotests/tests/qom-set-drive.out b/tests/qemu-iotests/tests/qom-set-drive.out
index 7fc243dca6..6f6e5e2b31 100644
--- a/tests/qemu-iotests/tests/qom-set-drive.out
+++ b/tests/qemu-iotests/tests/qom-set-drive.out
@@ -4,6 +4,8 @@
 {"return": "node1"}
 {"return": {}}
 {"return": "node3"}
+{"return": {}}
+{"return": "node4"}
 .
 ----------------------------------------------------------------------
 Ran 1 tests
-- 
2.53.0


