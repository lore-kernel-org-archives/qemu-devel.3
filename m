Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0643CC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg09R-0008GV-9E; Thu, 06 Feb 2025 06:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09N-00089L-B3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:29 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09L-0000tQ-4L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:28 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38db6e13947so613845f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841665; x=1739446465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUtqHHDNY10ErvkSPLlzoR4cOpr1l8H4w8NugOOncxc=;
 b=gejhkmtELhwS6HCPVTvXkI1X8n5TYWGrteYyBJ5d+e6NE/YfuIbuwZwPQsFRN0mixZ
 oZykHXuyHSlpJOpjJ2AYMeCSuLN/EuTEgygbYlRXih00fQ+H7oT1l/6Oo9jUpdQdwChb
 sTec+3SdLsI1FG3Dt9RypDvXcJ+GFGi0tNC5ImM+3+fTUkFzARR2BbP4M1aVoGwMagyM
 g17hFQLxuRyw2K+Z+sRHcsBSFiI+3cXmbbv35NpMRpbSoc7zCrbF/aFx2OPc0bFu4ZcC
 EATU8V5jIPLzw2Ro63Go7sazSOTbBCgz20DBiqkD8pEOKGg1DIHrzkpOA9+RBdrI9A3u
 AWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841665; x=1739446465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUtqHHDNY10ErvkSPLlzoR4cOpr1l8H4w8NugOOncxc=;
 b=ph24uteMuk1/BNxufKYUAA8I62GCpApzMLzWAeofQKIx+TWZRdZCsDaq2uRHkHgii8
 pxzlgGe625f2kqn96s7UR6mDoh7d+iq+PgdVUaCtTAFleszs1Zuha0+OosPaOwJR6PzS
 xZg/3N8HlZCrA/FQ3kD+cW7IxgTKB5lsY6MRTb7TFhcM0SJ25Pz6+VXPaojQ1DMdaBUT
 NnUDU4oACPMaXRxQYeaagZTKGgKigqL2g8dZRMeuN2NUWuUaxgbu6fHsizkFhnuPjmoW
 5tVmU0HR5xB38zodOT3f/5Ayw8ots/Zs7U9LpJWMnPrl3ZBGnvaHrkyHuNxD26/DvNzH
 YQXA==
X-Gm-Message-State: AOJu0YzupCP/9MaY5VHF4flCaOufk2ErTjmztjwnPrj2xjmXbpVqRKjB
 upyXW83YiGyPVgMYPpoS960Zw5rxWE3pXVAUcHl+ICho3FxyQF92rEmosJg2b0v5TwhO8RiSy1K
 OPWU=
X-Gm-Gg: ASbGnctTzYDWJ3ARPjWmpY8tPYnaQm2O63dLnsz1D5YUFdxH5dD5ELHdzarcLkgi5L3
 BZo3dy62RX1W52TwLVe2t/CKVHaJZBUWqUivQ4NBIbRQB7EUrwkP1XA+WiEvi2gs2lLPFVt60DP
 hBHAjIBdZnsERmdNqUvt8bVQPancBbDRANB6MVaey3pbBEb5O586s8cG02Vr0/u8uSQuRYbC45e
 bStbqlx+IbD6thWzbfCZ3MTFPOe1fXTNB7rGNLA2ueh+TR8HY8G9Od5Lscug+OHtcQVudkB8Gfy
 ZL0pMx24ci/iAjCPV+O3SdyU3X1xQH6ogVNSmAnCgKczUPrI9nTaZlQVKUrTjuskWA==
X-Google-Smtp-Source: AGHT+IGbtCscjOwCjd3nVLy6xHl3L4GiHn41ULVvzBX/38XOdy1DspZ8V0B2KQRzs+b95GmLSOEpQA==
X-Received: by 2002:a5d:4f11:0:b0:38a:41a3:ac4 with SMTP id
 ffacd0b85a97d-38db4945801mr3939469f8f.45.1738841664926; 
 Thu, 06 Feb 2025 03:34:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd4b154sm1521480f8f.38.2025.02.06.03.34.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 13/16] tests/functional: Allow microblaze tests to take a
 machine name argument
Date: Thu,  6 Feb 2025 12:33:18 +0100
Message-ID: <20250206113321.94906-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
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

Make microblaze tests a bit more generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 7 +++++--
 tests/functional/test_microblazeel_s3adsp1800.py | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index fac364b1ea9..c4226f49cf3 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -20,8 +20,8 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800_be(self):
-        self.set_machine('petalogix-s3adsp1800')
+    def do_ballerina_be_test(self, machine):
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
@@ -34,5 +34,8 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def test_microblaze_s3adsp1800_legacy_be(self):
+        self.do_ballerina_be_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 5d353dba5d2..715ef3f79ac 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -21,9 +21,9 @@ class MicroblazeelMachine(QemuSystemTest):
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800_le(self):
+    def do_xmaton_le_test(self, machine):
         self.require_netdev('user')
-        self.set_machine('petalogix-s3adsp1800')
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
@@ -38,5 +38,8 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


