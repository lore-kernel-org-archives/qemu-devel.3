Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F695C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCh-0006OA-Gn; Tue, 30 Jul 2024 18:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCf-0006HB-Mx
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCd-0006jb-OF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368380828d6so3211431f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378018; x=1722982818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXdSwZIkaei7IVXcOo85+RXKqlbMq+68sLXgYS3E5lM=;
 b=Bjkjlmx+97OBo1yFjl2ZIgRLBzvuaaDbVeYCFb3w4FRDnFqIHdo4tjFiti+xr/1eNK
 wtn0NfVqjHcNR0qIG3nepKRkMRHdsAz4uKj1zgGmkJCNSDcaRXcYVbHWQOYt2ZxzHPb3
 YfCKw0PciGUYGLdZ9NE+T4Jk0bTxPoO6A8ORVJWzsVrUwCf7ht4F2TW0Kljg6YvFouY4
 oWcaqXoJywDtO8nE3uOXuwZCg52Po57MqfIwS+OMpLkmPy6iRi9ohg0tIgsYAy+tZpQf
 f2l4xValW/8vQUwuDEHCyphmoLy93tfP4wlVbJHrVWC9cqhQPBFnXE8W1jYJ1zkdx2KA
 JwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378018; x=1722982818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXdSwZIkaei7IVXcOo85+RXKqlbMq+68sLXgYS3E5lM=;
 b=qyDka8q+wvI2idK9MFQwnpFXdAEWorCRubBM2zdPG33Jdw2jYKcopyD3MbO/d4A35r
 N+XBGv3l1Z6Dodb4eLpbRs3HSldYp7IS9bOZ8RUQJT8GMfaei/vIJ8h7YEb6Iki7kZ1a
 2tMOtxIB62iQgfoJyh+4OnGfb6S93sUg84mA6nCnyiPp+qUJScx/bsqb0uCRO1RKDaYc
 JtWZjY83D1q04qgdISNyrlbZQQf1Ac0sfV0NozUbYEjrzQW3fkiBuIzHzoxWtSRlPxMT
 H4iKM+fgqDfJN1kEBYOA5jpSpWMXqjMdSnlly2rOJgE3tUDfTpqLSLQ0CI9gkXvbI03e
 +mNw==
X-Gm-Message-State: AOJu0YziuGPZNqHSnSd7lFlz2FnM7UjcU56g2mLuyfVSSDqzIabuT2IZ
 6C/NTBoR9oA8WFr8C6kjK7gsEEuajUyDvkK1oMc/fLO7VW98EBUcQr0WQL45QB1ojBI+m7ENnB3
 LL2w=
X-Google-Smtp-Source: AGHT+IHqyTleIuS0FgbspsaU/uHbxfVL07LQTZxic5iDPlJ18yDWPptWlAdJ4yRM3xAu/yk5gsyEmQ==
X-Received: by 2002:a05:6000:1187:b0:367:9b22:28cb with SMTP id
 ffacd0b85a97d-36b5d0cd7fcmr7436738f8f.59.1722378018069; 
 Tue, 30 Jul 2024 15:20:18 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc7c3sm15519178f8f.49.2024.07.30.15.20.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:20:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] tests/avocado: mips: add hint for fetchasset plugin
Date: Wed, 31 Jul 2024 00:19:55 +0200
Message-ID: <20240730221957.34533-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
References: <20240730221957.34533-1-philmd@linaro.org>
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

From: Cleber Rosa <crosa@redhat.com>

Avocado's fetchasset plugin runs before the actual Avocado job (and
any test).  It analyses the test's code looking for occurrences of
"self.fetch_asset()" in the either the actual test or setUp() method.
It's not able to fully analyze all code, though.

The way these tests are written, make the fetchasset plugin blind to
the assets.  This adds some more code duplication, true, but it will
aid the fetchasset plugin to download or verify the existence of these
assets in advance.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240726134438.14720-3-crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 450d67be6a..b8b0a4df10 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -274,8 +274,7 @@ def test_mips64el_malta_5KEc_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
-        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
         kernel_path = self.workdir + "kernel"
         with lzma.open(kernel_path_xz, 'rb') as f_in:
             with open(kernel_path, 'wb') as f_out:
@@ -303,7 +302,8 @@ def test_mips_malta32el_nanomips_4k(self):
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page4k.xz')
         kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
-        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
     def test_mips_malta32el_nanomips_16k_up(self):
         """
@@ -316,7 +316,8 @@ def test_mips_malta32el_nanomips_16k_up(self):
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page16k_up.xz')
         kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
-        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
     def test_mips_malta32el_nanomips_64k_dbg(self):
         """
@@ -329,7 +330,8 @@ def test_mips_malta32el_nanomips_64k_dbg(self):
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page64k_dbg.xz')
         kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
 
     def test_aarch64_xlnx_versal_virt(self):
         """
-- 
2.45.2


