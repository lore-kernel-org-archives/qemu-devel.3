Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA568C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiArZ-0006Mp-83; Wed, 12 Feb 2025 06:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArT-0006Jo-N9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:24:59 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArR-0004cu-Ko
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:24:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dd93a4e8eso3160373f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359494; x=1739964294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/5SvI1nZOETAaAlXL8oDs7D5HNrYsWDKjSPJuAoVFY=;
 b=JpWyRONXR10L1q5TXKiHCGj/zhqn4YTScOazJYL5vZFa1eAUWnTkamZEvtf+T7cEvl
 uZXvagF2F3ZKjNxrBMV206fZM2KD2ug7520QBr6+WTmqXpQdMxjFFuVNOdlSXX7SDZZ3
 FnMkJpO4TsbfkKMff5DnfGNjZQPCi0W6epgPBflXTaKs1ggLSeVxIkERofi6ObEI6a9K
 Y3JraFm1ZYKDN+HwW7C9flqj3hmFVjXWeDkiIrLw91Ioc7ng0e0qCIOyJPDEIOS/K8Az
 BDavkbQmCv0rMRTENjyLMJ+tqvgP5X+eI26Ams3UZEAygzh42UtsaLQFva/QkWT40otJ
 /bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359494; x=1739964294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/5SvI1nZOETAaAlXL8oDs7D5HNrYsWDKjSPJuAoVFY=;
 b=B7AJ9Ft4lBlTQcTKetwtdYibqvgF4kCZy4OXz0YY+PytIMrZmBC2v4JHVlXmbLdXFc
 XseO6z4cw8jEV459No6LJELTXAOtimSRBuGJNIYd0jbKN+Z4p3NSTKCpM+QBJ+JzmGjz
 ykyXG5N9GtI6U6v/lH1/JKT4JVUr3TlLBoyI1v3f+Yw2nN7ae3pzzKclKsqSQdevNhFG
 Ie8arhWjo81oRxsxeYteWQvPAtuRNsWPkvyEqd6t5N8k7YK+qtXjSrYGgC3lFkoIvvog
 jryHlO3m5CFFgClvZKjSedzRU0+WtMxfUh6RjX1xf28xhC5zJbfrVOqJ2bHzwRiowTTA
 B1gQ==
X-Gm-Message-State: AOJu0Yx6G2CD7YzsycQZh5I1Vva+zrxiNsV57sBu7hoHs4glcZKaaMxp
 gAhqqx7ivQHdWXTUsRcS5r83pacZbBJYkGlW/9iyUSeqLOqEFNksNFDphEx4LAXC48SXJRlwLrz
 heKQ=
X-Gm-Gg: ASbGnctHKq64QDj0D+cTSXWvFDrrt2td0RCMlUJGjREwkh6C/VxWyRApe1QgjPWYnfe
 nWAXqngC89ivEza6Kf2s5JRiocMkICNne818vXysvAxR2sw7BENLnk48pKL8WhATmLWktPXMBfv
 aqnrfrETtaeQ3rGmsFUKhTzkUe/Zat9uGDerP5phduuRz+c0ZeLvAcrDo/EFxUzSLNONgdhk31o
 L1WgIlZbFyfewmEP1qLbkJwePShayIG+6hrx4N93aYPf0xakE8bpCKE2GRxPI5QB0lBGf7CoKI7
 Xrj50chJhY2XVFM2QOYqJQ14aShLzAHA0qAbebW3aQYdpVWQ2PoDYOCUt4NRh8Sscw==
X-Google-Smtp-Source: AGHT+IEHeqNbECF/bGwOcVXkIHKnTY6WV4Iu1MYIRZAHJtYo7S1q3MW1Fam/j5W+rZJYVnILrqOkHQ==
X-Received: by 2002:a5d:4c88:0:b0:38d:d93b:5899 with SMTP id
 ffacd0b85a97d-38dea266daamr1950525f8f.21.1739359494210; 
 Wed, 12 Feb 2025 03:24:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc9ef8ac6sm14517102f8f.27.2025.02.12.03.24.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:24:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 08/11] tests/functional: Explicit endianness of microblaze
 assets
Date: Wed, 12 Feb 2025 12:24:10 +0100
Message-ID: <20250212112413.37553-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212112413.37553-1-philmd@linaro.org>
References: <20250212112413.37553-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-13-philmd@linaro.org>
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
index 5bf94d88dd8..ccebf5c2ce1 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -17,15 +17,15 @@ class MicroblazeelMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_LE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day05.tar.xz'),
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


