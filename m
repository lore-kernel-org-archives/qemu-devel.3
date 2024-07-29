Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B2CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSIn-0008Gl-FL; Mon, 29 Jul 2024 11:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIl-0007yQ-NJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIf-00008Q-P9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so11731225e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266916; x=1722871716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXdSwZIkaei7IVXcOo85+RXKqlbMq+68sLXgYS3E5lM=;
 b=so0frPNnsN2O8ATzTRyytvUPJufmDis7tThJdjT0TqjVurhHgfQ8q16gs4KRNXygp1
 svhGNf7DCv60u/Cuqu5vUjk8KVmXDcobJ1LnFTKuTbNtF+8Ho+AgeQMUZsa4oxTo+4UG
 2Zcs7ur9pMFX/b7lGo6pN/IlAwSk70+vYzfbxUAEjcRwvRykV8nEqLraLpFlSdsP47HY
 yoAm18E3UL1V0lXgSu1kdOhsSGO7A/P7p+us9SDa2ECzQNgVxfiUZyHATge2BZvpEJ4T
 ShBUR8Lm7DR/sIfgSLKpkBsptC5CpK9tU2JXwUu1D//7Kqs7qK3jBRkucL/EElapcqZs
 AXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266916; x=1722871716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXdSwZIkaei7IVXcOo85+RXKqlbMq+68sLXgYS3E5lM=;
 b=S/KZQipT+X0c5SgI3boaYYdARG0LOWEDmK36oR46xewu4OjSNaOPbJGfYLYV+pPOWd
 ZYSWSzubt8VIg1BRPhH+OX0/TcPP2EXxiKJTZzxYLqMm+lCFawze7vH3gcclHGyYBoJH
 S6XJfrSdLZ+eyZnPPJxYY3PRvXz2b2PwLDzyZ5KezNYaqRLCMYd6LGZoMREyRXTV9gYR
 xwmmJEnyjFuuivTnSNegSnXLIN0pOgFoFVKbNYXxfQZugtVcBwfuGBofjGyRkpsPs2fv
 wy2XSX3tcU56IILbpBUciPZGyX3QEv2MOlq44WMDR1VSCKhSQIbEuMIuUSEueu221xs2
 +7bg==
X-Gm-Message-State: AOJu0YzeSDhnHkI1PfJZjuo+9p8PdGZ5kprAq50913jd5Ch2oB6tL1hh
 MPTgDpnhY/8gVOhSjVVGQFND0tg3EQ827WZs12pyPuJNoq5bCXQOZ83vpvLyDeI+OdmdZCV0lcz
 u
X-Google-Smtp-Source: AGHT+IEdWtE1I+hDS1jIAqotF7SzgvejyFnco1cDpZQYAdMcSH1EjBnn9KZfB5hOJAt/sAICkDES4w==
X-Received: by 2002:a05:600c:350c:b0:426:6981:1bd with SMTP id
 5b1f17b1804b1-42811e52330mr53491205e9.5.1722266915665; 
 Mon, 29 Jul 2024 08:28:35 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ef3f459fsm129574945e9.0.2024.07.29.08.28.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/14] tests/avocado: mips: add hint for fetchasset plugin
Date: Mon, 29 Jul 2024 17:27:13 +0200
Message-ID: <20240729152714.10225-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


