Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BC4D5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RAb-0006mc-3V; Fri, 08 Nov 2024 10:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RAC-0005w7-Pj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RAA-0005jy-Gq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:44 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so1558770f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080680; x=1731685480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iED9jISqfSsG2m+ZE+lZ82AHUiDCp1mFbt2BJhqjoT8=;
 b=zobhh/AjWUuBYpaYc3mxu3cJpxTiC7VwV/zqQOkOe5dVqGbCQUZhZmml+KZtoTeHN4
 UUcZFr5+6hXAiW6xTa5v8iSyA7T0mUIvkBJ0dm5ApHxxaGtoY/Oop2VLdBo38AImmEtT
 ku3XQWQPjzlZbnM9V5dxLK3A3sbQ4G73tk7I9JuvXHpZx/XbGT4Sk7jTtIBQ+UX8COkm
 a64uM2MagADmkEFqD3xhS907eRcprDukx4QfyGOvaNbgg7be79WvAis7/RW93c5FjpsX
 gKUUQbICKdsW46vGbbsD53LAXHqsyYkTNxsmjBWFXMYSPBQ2VIeuzP43lZtoBTU3IYbF
 dMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080680; x=1731685480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iED9jISqfSsG2m+ZE+lZ82AHUiDCp1mFbt2BJhqjoT8=;
 b=ITvFXjZejbq1zuR8bWZNCmSTt0uZCyu93acsdCrpCpnL+UzG6dCA395Qh3SjE4i0XQ
 U4bzi+uZK3H0yf3gnlj1wfvOv0iXt+/98O/3viOzJZP8jf5vuLhjR2iwsE/3kzyCe/fN
 lP+we0NxNsn05kUmQ6+d0KT8mcwbdb+F1WbezUDbjnzLXcf5DzcJpeME9WmfV+Z/Swvt
 mCIIJR/hS2C8osE6bqOe0EvPnKVfH3pqxCjyhHh6uS1mC2ot11eKs12i0Iq1ktTAjnb3
 6OXvKsXr67YUAJFYKWuOOdeR8P2kct+Pl8QMh/sUvZ+RiFU1yG3adkZgVjg33at2SMbN
 jdOw==
X-Gm-Message-State: AOJu0YzhTb1hJ+jTAFNiuTd4yh5JstRRlw90WB4469WpMa6Jm/86KHqS
 MooSMiEao34ttdOY+kqN7WMUbJSTOvETrA79opkybDu77UYcqsH4YwRjzIX/VhhsSIsrqzmiMEX
 w
X-Google-Smtp-Source: AGHT+IHmihiEeiOXJYjfAfeQYPnQtJxqiRThqNU6rLEZYOKNg1QtJWZydskC5U0RTnVYeYJx00bfmQ==
X-Received: by 2002:a05:6000:2588:b0:37d:3e8c:f708 with SMTP id
 ffacd0b85a97d-381f182eb79mr3406771f8f.20.1731080679908; 
 Fri, 08 Nov 2024 07:44:39 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea4f6sm5249033f8f.64.2024.11.08.07.44.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/17] tests/functional: Explicit endianness of microblaze
 assets
Date: Fri,  8 Nov 2024 15:43:16 +0000
Message-ID: <20241108154317.12129-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The archive used in test_microblaze_s3adsp1800.py (testing a
big-endian target) contains a big-endian kernel. Rename using
the _BE suffix.

Similarly, the archive in test_microblazeel_s3adsp1800 (testing
a little-endian target) contains a little-endian kernel. Rename
using _LE suffix.

These changes will help when adding cross-endian kernel tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 +++---
 tests/functional/test_microblazeel_s3adsp1800.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 4f692ffdb1..2b2f782270 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -17,14 +17,14 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800(self):
+    def test_microblaze_s3adsp1800_be(self):
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
+        file_path = self.ASSET_IMAGE_BE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index faa3927f2e..1aee5149fb 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -17,14 +17,14 @@ class MicroblazeelMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_LE = Asset(
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800(self):
+    def test_microblazeel_s3adsp1800_le(self):
         self.require_netdev('user')
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
+        file_path = self.ASSET_IMAGE_LE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
-- 
2.45.2


