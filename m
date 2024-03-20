Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F8AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyZt-00033A-E2; Wed, 20 Mar 2024 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZb-00030t-F6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmyZU-00035Q-Ch
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:13:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56b93b45779so2980372a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710951222; x=1711556022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XT2fjAt/fMm7dCx4w3sQ31zoFoyy4ckvjlYypijIbGY=;
 b=pUg270RY0q+8XL9rqsSA+epnm9vBmgBDcdyCdHOabKH30E6zZ/5Ie+r1E83gljqMzy
 R87fxWNtkkY7p3dqOnJQsPMj55F06efKgLTWysjTMX8puMlActB9wpaqym5O9ZHOXptd
 FYsble5TqTZTb1oJVhlqcvz592qSgxdRjXTbl7W4CpjB7G2wrTm6SMtJ2nh2SLBa1vK4
 fQoLUKHq4LJYipA0OJKWJZczrqL4TQkcLoyXAJJQMk6Kayv9u70Q+QiGaOIItPScvWNj
 +IkcvYEX/M9A/7N+SympkIJJmHkW9yIg1wlEH5GSx/988lol7iUijIYfujpCUybma9Bs
 s72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710951222; x=1711556022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XT2fjAt/fMm7dCx4w3sQ31zoFoyy4ckvjlYypijIbGY=;
 b=jBIC/C7l76L75b5+cbauNuM/7JLsOl8tajwMVJYpx3gM+9viMjr0fV4Sdz7TLJHAlK
 6/rVyJH3euRZatEp3BfMkwxUA6FIvJg6lyniZZfnG44Q3Zp6R/H2bzdWgxVb9Pka2YUT
 UjmiQ9nKMgPFh9z2Hn99VpU49ZBhxjr2h8kSRuerB0jvUSSmqu6aPfNjroi9AIMDOz/1
 aEoskUH57PG1n3EQ8ggQIu1YMLTbA7ilL+nXpjHVhSXRaljvQwITmhrEBThkerdKw1zB
 CQUFzyi8dgmeTCeDu3vnCq7miGkx/JqD0hpFXSXHrGwRMO5FgggPek47ENxDfZsApF6F
 8K3g==
X-Gm-Message-State: AOJu0Yye9BJbFVf+Vj04QDigkei2Eg0aciqOkVntolGOQAGXGVHxhb78
 W891eUh+CWdZ0NNQb0IRk1NDMGCVrXV55uG8BfinZWVU/wirZGl1E8BA5b7350c=
X-Google-Smtp-Source: AGHT+IFudNaXM2gnuh33UfASc7fqitFaLmimTl/j1gTIq9I4dccBlUsjBXAzDtSVqDpFmUo4NHL8cA==
X-Received: by 2002:a17:907:1b03:b0:a46:e51a:466e with SMTP id
 mp3-20020a1709071b0300b00a46e51a466emr4393621ejc.64.1710951222311; 
 Wed, 20 Mar 2024 09:13:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e25-20020a170906845900b00a449026672esm7463987ejy.81.2024.03.20.09.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:13:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 29FF55F8F1;
 Wed, 20 Mar 2024 16:13:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 2/5] tests/avocado: update sbsa-ref firmware
Date: Wed, 20 Mar 2024 16:13:37 +0000
Message-Id: <20240320161340.391798-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320161340.391798-1-alex.bennee@linaro.org>
References: <20240320161340.391798-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

We now have CI job to build those and publish in space with
readable urls.

Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).

Used versions:

- Trusted Firmware v2.10.2
- Tianocore EDK2 stable202402
- Tianocore EDK2 Platforms code commit 085c2fb

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240318-sbsa-ref-firmware-update-v3-1-1c33b995a538@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 528c7d2934..cbab793455 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -1,6 +1,6 @@
 # Functional test that boots a Linux kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023 Linaro Ltd.
+# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
 # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
 # SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 #
@@ -32,34 +32,36 @@ def fetch_firmware(self):
         """
         Flash volumes generated using:
 
-        - Fedora GNU Toolchain version 13.2.1 20230728 (Red Hat 13.2.1-1)
+        Toolchain from Debian:
+        aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
 
-        - Trusted Firmware-A
-          https://github.com/ARM-software/arm-trusted-firmware/tree/7c3ff62d
+        Used components:
+
+        - Trusted Firmware 2.10.2
+        - Tianocore EDK2 stable202402
+        - Tianocore EDK2-platforms commit 085c2fb
 
-        - Tianocore EDK II
-          https://github.com/tianocore/edk2/tree/0f9283429dd4
-          https://github.com/tianocore/edk2/tree/ad1c0394b177
-          https://github.com/tianocore/edk2-platforms/tree/d03a60523a60
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
-            "https://fileserver.linaro.org/s/rE43RJyTfxPtBkc/"
-            "download/SBSA_FLASH0.fd.xz"
+            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
+            "20240313-116475/edk2/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "cdb8e4ffdaaa79292b7b465693f9e5fae6b7062d"
-        tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash)
+        fs0_xz_hash = "637593749cc307dea7dc13265c32e5d020267552f22b18a31850b8429fc5e159"
+        tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
+                                      algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
         fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
 
         # Non-secure rom (UEFI and EFI variables)
         fs1_xz_url = (
-            "https://fileserver.linaro.org/s/AGWPDXbcqJTKS4R/"
-            "download/SBSA_FLASH1.fd.xz"
+            "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
+            "20240313-116475/edk2/SBSA_FLASH1.fd.xz"
         )
-        fs1_xz_hash = "411155ae6984334714dff08d5d628178e790c875"
-        tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash)
+        fs1_xz_hash = "cb0a5e8cf5e303c5d3dc106cfd5943ffe9714b86afddee7164c69ee1dd41991c"
+        tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
+                                      algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
         fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
 
@@ -96,15 +98,15 @@ def test_sbsaref_edk2_firmware(self):
 
         # AP Trusted ROM
         wait_for_console_pattern(self, "Booting Trusted Firmware")
-        wait_for_console_pattern(self, "BL1: v2.9(release):v2.9")
+        wait_for_console_pattern(self, "BL1: v2.10.2(release):")
         wait_for_console_pattern(self, "BL1: Booting BL2")
 
         # Trusted Boot Firmware
-        wait_for_console_pattern(self, "BL2: v2.9(release)")
+        wait_for_console_pattern(self, "BL2: v2.10.2(release)")
         wait_for_console_pattern(self, "Booting BL31")
 
         # EL3 Runtime Software
-        wait_for_console_pattern(self, "BL31: v2.9(release)")
+        wait_for_console_pattern(self, "BL31: v2.10.2(release)")
 
         # Non-trusted Firmware
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
-- 
2.39.2


