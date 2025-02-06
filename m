Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0D6C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg09L-00080Y-3Y; Thu, 06 Feb 2025 06:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09I-0007qo-BH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:24 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09G-0000tB-E6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so38130f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841660; x=1739446460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lrz/Z9U2Uf5jpDeQ6Q5rMzyggw9C9+W1C5t50i9qAk=;
 b=NAz9wARYgv/PzUKvKwRbyaH1JfknC+PQJclHCGM1CtTMSN4vqMwsk0LpLLI1XRrhvU
 yHDtsejuQjcXdxOM6PydYZU9vvBDplEYKobN6m+55jbyEalsThTTyv9i9cTdGpZUZO9e
 gLWAaibqvp2SoNO8wS8MTgQSOFC6ZnORmh6ParBbud3hNhH/CDOe0/cvGhSrrXO2TWN1
 4qfO4XfLgaCOGARzQaQvRILgn0+MqE2Nhi77K4TLbeXUv+dwRpKUA3WxEpE84hBwCQOB
 Jrog7xvjtoq5yBxwBnaSXFITzIZl7PBJc/vsi5F9jhjUVCTPl8GuTp4S51kvxdUoR6VT
 fiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841660; x=1739446460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lrz/Z9U2Uf5jpDeQ6Q5rMzyggw9C9+W1C5t50i9qAk=;
 b=Wi5V24IS5BQIs9lwIvT7bk4XnKo1k4CqwE6l212xk0WCQAJXUDAecwvqdwZp+qn7w3
 /tawJuAL2pk2e+k1GL+KXUuCgOUryTeI76iK4VL/1+xBhSudfjb/g6LESpeLvuppbtVw
 nBWo1jAiu8NVcB/UueDYY4HEBQn32PqAWdPpffTlMCOGDBP05TkPgJaT9Fa7CB/9iC18
 VLd2SW1GGxdR4rEqNY3i2PC8RGmSUEdb2fHETWpUeKq1/VU9cE4J/KKJkhc6BRertT/h
 op9Bpie9KYY5Bj6yyvfdzzXorPb+1N/3Ld5DWLQ2W+Dco3d1gnUVcsqGKNff/aeqBBls
 fTIg==
X-Gm-Message-State: AOJu0Yw7xbst/HO/dG8iaAXpA4Pl4Tax9xjdkn/lPRnHRd87pLNF8Jsz
 m/ZGBd2lrPKFiAcVl+2ZWbs63pwEJWuTcDvDcb9FlY0JdheWLTCMzeMrT7gGe95giPYjGtX5Ctl
 oBtU=
X-Gm-Gg: ASbGncv5P5IeWpRQDvItU8j9pWuy3pUAzVaJ2iN+J+5fCEIN/ZyGaQMa470gFy0Ar/M
 qXJymgOZKuY1E6jTiTGKa7ntFj9wpOJtCg64FEayIpWg/wfn//TYAH+PQiJXcgc5+uGI3XCp1WG
 ZEqYs4PbW3VivKrn74CR0sd+G5uAO3rWpoEY7+IX1AcSkvdx4jztG3Jjdg15RGISN+AKG+z9fAE
 f0qnle1SY+iL/bT1b2/Xt7V7aq7tjglasx31g97kZvPxd/IvnEH8IyipP0T5JikTk5NSiFEsAUO
 YMyzmiQb0/m/f3Qv/Lrd/fT21RmzjwmlbwcVNxUtS2NUyOEIQdMHRqe9kJryqZlCmw==
X-Google-Smtp-Source: AGHT+IHSDN8kBjQRCQ5mSO3oLw9OrLEYqGdwuk01GVJ2tJpjZEe4C415ElC+Zz1peCauC4IwLvRW7A==
X-Received: by 2002:a5d:64a1:0:b0:38c:5e03:5d9 with SMTP id
 ffacd0b85a97d-38db48bce45mr5672009f8f.16.1738841660255; 
 Thu, 06 Feb 2025 03:34:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc33939f3sm487320f8f.17.2025.02.06.03.34.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 12/16] tests/functional: Explicit endianness of microblaze
 assets
Date: Thu,  6 Feb 2025 12:33:17 +0100
Message-ID: <20250206113321.94906-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 +++---
 tests/functional/test_microblazeel_s3adsp1800.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2c4464bd05a..fac364b1ea9 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -15,14 +15,14 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800(self):
+    def test_microblaze_s3adsp1800_be(self):
         self.set_machine('petalogix-s3adsp1800')
-        self.archive_extract(self.ASSET_IMAGE)
+        self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index c382afe6bfa..5d353dba5d2 100755
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
-        self.archive_extract(self.ASSET_IMAGE)
+        self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
         tftproot = self.scratch_file('day13')
-- 
2.47.1


