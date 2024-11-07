Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85889D29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rFp-00072B-HI; Wed, 06 Nov 2024 20:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFm-0006sK-Sn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:24:07 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFj-0003Fw-Lj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:24:06 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so225835f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942640; x=1731547440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iED9jISqfSsG2m+ZE+lZ82AHUiDCp1mFbt2BJhqjoT8=;
 b=GqLflv8e+4eZPrPz/umye4BqOdqAcYl/hoDhINjbudkRswJKLm/ufy0nYT6fa4UThV
 30ezUJJXA/qCqQ5M48bNO3LNBCOXhnsgYLbKrcjZSux6dFWV/ZxXREGMiTNq4OGoIjI/
 3Ndk5XS9csDw10gu7ThJpbz5AhaGWzUdbilKExpX1HvJCJk6Xj9DeV1DdgFxA2r42vFw
 6sjNlkMLAchq+KgfcHc8nLqFIClLHpJT0UrQluePFpUMXZL+Je8jsgTwTJIB1IePr9oj
 +gcuOvJ8jS11RGCFIjBYWM/38+2W0HRF08dk79dilV+GPptm/Td4osw0aPtVd6I2/0jv
 bnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942640; x=1731547440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iED9jISqfSsG2m+ZE+lZ82AHUiDCp1mFbt2BJhqjoT8=;
 b=l9MQu2TtCSCHrRjz3AxF6qfqiX62quaDe3BUbLnY8snfIo/84IJ7Jk4DigpXCtoDQM
 4tk89WdQ4SzONmYWB6KSWx1eLebSm14tBDV8x+9eOa+v8G2+JmW8eXcwNntXCAmI+IX1
 dOkFBbHbe52gBkab+UKaAR601jzXPy1VQ3WM3vS4bmj584il6OjduPZoeXbz2bUw5hN0
 DeA4WtvrVdxtfhbr1ayOEI1kseG2TqxNlbEW7/B63EFEz2BkcRCFWbIqHHqvE+jchcWd
 1zezg0m9pXHw1keOYejfUWR6nqv5YCZzui0dBqrALqv2zhU039ndvKBx1nprsO2BmJpo
 8CkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXAUAIzDejf2EEY4ngtrlGWrvpZCaMU4TALJJEt2jRXcoLwRD6bPeHeySxcxFtsqjc0v865Pi88ZNF@nongnu.org
X-Gm-Message-State: AOJu0YzsCo5iCOjKRwX1nbqPTeiNjxeZr34mQ+XOwWgFhNagQg9HeK7I
 oK5opZvQOj5Zy9lI/f7Cj4mrQz18bS+QuRUsJe8iSORVWdlMAYeIhxsz1uyrgbc=
X-Google-Smtp-Source: AGHT+IHjFeI/PFHvlFVX8+hPeW42oyEfKMmWpd8wUfXVfwpaNWeEPw1QRGC7WhBHb8gqTBG5g65oWw==
X-Received: by 2002:a5d:4a4e:0:b0:37d:4318:d8e1 with SMTP id
 ffacd0b85a97d-380611376a9mr30745334f8f.23.1730942640518; 
 Wed, 06 Nov 2024 17:24:00 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707d3sm244265f8f.19.2024.11.06.17.23.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/16] tests/functional: Explicit endianness of microblaze
 assets
Date: Thu,  7 Nov 2024 01:22:21 +0000
Message-ID: <20241107012223.94337-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


