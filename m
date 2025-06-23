Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF327C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgAj-0003wH-UJ; Mon, 23 Jun 2025 08:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAI-0003AI-Oy
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAG-000147-IP
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so28467255e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681240; x=1751286040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtQNZzACUXAAbylIZWuCAJaOBU6QlQnouJAN5jXvi6I=;
 b=YGfZwPofegnI+ZMTvpDgWncTBpOAzVVbxl5lG5PlPyTxWVvcVHAqDe8KS8GlA3wYH5
 eyWZFlwIXXr5K6gPU5MY3iziTmSeBGivCZKC/2E26fob9rTHeAYs3xRENPTcYvxMWbb1
 XhGdvLuY2iZWl0u5TOsxnsMOGDQCpztjxDO7TjwL4JT6oW615RsNVHiRIb6uj4sSHPAP
 NrqjXLTbyF0cdyGmrMkhbC/tAQgS1+T/Cm1krZVlW7TpM6Pu/Kos2/I2P7ZhDYWL/kGJ
 jUgdMci2h2zZJsfeCfPpntYHJLkUs66vq+PxNMX4tKu1y4r8rdKfhlhjlHlC6gWoXgdV
 raQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681240; x=1751286040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtQNZzACUXAAbylIZWuCAJaOBU6QlQnouJAN5jXvi6I=;
 b=QeJV6q69DBd1qr9B0tcajRFHFmfHvEeACs0J1UZ9sTUPZmdXtTGLacIONEeTXcA0pW
 IcyodB5R6PrjWLzjo2/SOVfuYcbj75AVUY1u4EdTfHzQTs4s62TYxpdUn6c16bCT0hyK
 tSJS79YLltcHixN/+iez0TYvlX5+u1JQCi28fbDtn6TcpJMhSfESgXgRqRkSF3YnRYKz
 ffgbQrX4DiLHdRkYR0559d6y/juVFAUhmp1oJq9+w0ty6SZ92qWIxsVvhkw7KFXEi/PW
 EseP6qRC6VQ2Hqq37LYttQfDuyeKmFerP5puQAcUnzb/sBtLFZPfAKJXGm5WpAKlEUr2
 OBXg==
X-Gm-Message-State: AOJu0YxDHWJdxKGGCVKnfaEwLpMRO+PQfJTnFad0RfoM75bJqwIWgiWD
 Zsd7rLTe+HY1P0HOgP2rbyMvJmAcGfgyKMpaihZh2ykNdbUoOOqSezm60dZ0HDFJ4tIoMdu6gDR
 5cFvi
X-Gm-Gg: ASbGncuUgsr/hTU+i/tvsySEqHjteoRfjP9hUvAQNuhtv3o4oR1/ja58A9A6kZwNdhR
 XzfeKowbyAgQEZyrkGWuAZtGCNB+nlppbUYduj2gsso0TMK139F+y2BYiqk08HwIU42kQFF0Zwz
 nzs9uupuQrQ6DdnFRCyjxSWsKX9tpqrutC+CJR0801v43biuHo6do+05wAnx50cqYKHbBT3YdW7
 cVwd/4tUCuufBTOvpYvcxzKkzTzRl6n/nEcYC8RWvAu2eRJqF/LQARsR8V9ozsFHAazKbnt64xQ
 XRbknasHgtg8E4nGXXmMtexSsLjT3xWH+KG4s3ae+ihAovOd58am9FeA7wB7iNIefSQKLJORrey
 0GplKd3twMFFSf8Wp3Oqb/mXSpAlpxG3irGkZ
X-Google-Smtp-Source: AGHT+IGloUAr04yva76gXPckxz6WSYPWq4wDXpDI9HHEpLc89a3rsZ2d9KIpm2RuC3BaoxLIlkYNIg==
X-Received: by 2002:a05:6000:230e:b0:3a4:ef48:23db with SMTP id
 ffacd0b85a97d-3a6d12f9af7mr10894746f8f.59.1750681239899; 
 Mon, 23 Jun 2025 05:20:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f104f6sm9656927f8f.12.2025.06.23.05.20.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 22/26] tests/functional: Set sbsa-ref machine type in each
 test function
Date: Mon, 23 Jun 2025 14:18:41 +0200
Message-ID: <20250623121845.7214-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

fetch_firmware() is only about fetching firmware.
Set the machine type and its default console in
test_sbsaref_edk2_firmware().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
---
 tests/functional/test_aarch64_sbsaref.py         | 5 +++--
 tests/functional/test_aarch64_sbsaref_alpine.py  | 3 ++-
 tests/functional/test_aarch64_sbsaref_freebsd.py | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index e6a55aecfac..d3402f5080a 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -40,8 +40,6 @@ def fetch_firmware(test):
         with open(path, "ab+") as fd:
             fd.truncate(256 << 20)  # Expand volumes to 256MiB
 
-    test.set_machine('sbsa-ref')
-    test.vm.set_console()
     test.vm.add_args(
         "-drive", f"if=pflash,file={fs0_path},format=raw",
         "-drive", f"if=pflash,file={fs1_path},format=raw",
@@ -68,8 +66,11 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
     def test_sbsaref_edk2_firmware(self):
 
+        self.set_machine('sbsa-ref')
+
         fetch_firmware(self)
 
+        self.vm.set_console()
         self.vm.add_args('-cpu', 'cortex-a57')
         self.vm.launch()
 
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index 6108ec65a54..87769993831 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -26,8 +26,9 @@ class Aarch64SbsarefAlpine(QemuSystemTest):
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_alpine_linux(self, cpu=None):
-        fetch_firmware(self)
+        self.set_machine('sbsa-ref')
 
+        fetch_firmware(self)
         iso_path = self.ASSET_ALPINE_ISO.fetch()
 
         self.vm.set_console()
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 26dfc5878bb..3cddc082f3b 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -26,8 +26,9 @@ class Aarch64SbsarefFreeBSD(QemuSystemTest):
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_freebsd14(self, cpu=None):
-        fetch_firmware(self)
+        self.set_machine('sbsa-ref')
 
+        fetch_firmware(self)
         img_path = self.ASSET_FREEBSD_ISO.fetch()
 
         self.vm.set_console()
-- 
2.49.0


