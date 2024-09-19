Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8585CDD57A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwy-00078Q-Oz; Thu, 19 Sep 2024 09:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwW-0005Sw-No
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwT-00015H-34
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cae6bb895so7712975e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751487; x=1727356287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AphQX4ql+BAtHg5yWLKAQ+5iWJXZHPjOafSUz9y3vMM=;
 b=Z6ntYAfPdPWmiElpYnv7lXPib7zLSXRJ4rVf7pJrhz9EqqtruX7g1fkxpDq39G9BFv
 FRFI4J6Bc2fvziux7oTb5eYpIr6J3bRncLjJ6cRarPgVZKMLKKTezR+jR4a1YccvTrM2
 cpZLBhiFnfVeE+LphRLkSYZBv6Omn0SbWbaePd82RUOAj9xQqI+SfZEZ+HsfynTlitYQ
 yVBY5gQW8jbUSV3Clg+/VHD7SkzyEyr0YuW3E88yKXFR7WIo1oOiEfKZYpfvGUbnwB7c
 YU8CbI49yGinE8QRtLZs3RD2emxBOwdsBKhw4Iw5y3QU3x2Mt9CbQ1vCedPpfslXJRI9
 iT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751487; x=1727356287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AphQX4ql+BAtHg5yWLKAQ+5iWJXZHPjOafSUz9y3vMM=;
 b=lHRkE12hDO9M0aPkPr3ae91z8bsTlm4UWeLfv7ASpXN5Y8L+dJeykzPahfFMdZUNND
 4IvsJu2G8iYfnr7I4w5BQHVZvkYnTvaZXI38ng5zlg9S64o67m3tBdlhTZPOci5Hh+lO
 4IOO6bU26d/DdcSwckRwvIQCrPkUbJgM3117HYtaB32nbpduyoJUjjqkPV21RY+Z/x8Y
 rhU0c5g0ZW9mc45DwF9tBYzyZyVC+C7w+Tgv2Jw8tOG+DRz4pQmfLPuu7yD2y7zNWFI/
 cpUmMM3Om0ECCyZN8+CT2aBfO6lqeQtMg1hyBF+Wsht3+VxT/M/av2lxR5fPKc6anO/b
 k/QQ==
X-Gm-Message-State: AOJu0YzbUWqSaHvo80uK4ckZXpYppPJnve+SkMUTpS40qLRrRbixB+vN
 jKME39+yJHVDZ/qYZGGhAV5nrSJwuuiHoMhmc9oMyv7/Vmw9ZS4vQHmq+JlwkAS1enErU8x4Dn7
 y
X-Google-Smtp-Source: AGHT+IGkmf+CjGpxjMfkAu037xnBDDsEAxLdzvVG0L955VtzT1Ori6Xi568avdZw57x74boDa11V3A==
X-Received: by 2002:a05:600c:19c6:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-42cdb5913f2mr173613295e9.31.1726751486623; 
 Thu, 19 Sep 2024 06:11:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/38] tests: add FreeBSD tests for aarch64/sbsa-ref
Date: Thu, 19 Sep 2024 14:11:00 +0100
Message-Id: <20240919131106.3362543-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
than OpenBSD (7.3 we use is already EoL). Also bugfixes are backported
so we can stay on 14.x for longer.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240910-b4-move-to-freebsd-v5-2-0fb66d803c93@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 43 +++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 528882f4fa9..89d0b9587a8 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Functional test that boots a Linux kernel and checks the console
+# Functional test that boots a kernel and checks the console
 #
 # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
 # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
@@ -184,5 +184,46 @@ def test_sbsaref_openbsd73_max(self):
         self.boot_openbsd73("max")
 
 
+    ASSET_FREEBSD_ISO = Asset(
+        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
+         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
+        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461')
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_freebsd14(self, cpu=None):
+        self.fetch_firmware()
+
+        img_path = self.ASSET_FREEBSD_ISO.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-drive", f"file={img_path},format=raw,snapshot=on",
+        )
+        if cpu:
+            self.vm.add_args("-cpu", cpu)
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Welcome to FreeBSD!')
+
+    def test_sbsaref_freebsd14_cortex_a57(self):
+        self.boot_freebsd14("cortex-a57")
+
+    def test_sbsaref_freebsd14_default_cpu(self):
+        self.boot_freebsd14()
+
+    def test_sbsaref_freebsd14_max_pauth_off(self):
+        self.boot_freebsd14("max,pauth=off")
+
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_sbsaref_freebsd14_max_pauth_impdef(self):
+        self.boot_freebsd14("max,pauth-impdef=on")
+
+    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    def test_sbsaref_freebsd14_max(self):
+        self.boot_freebsd14("max")
+
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.34.1


