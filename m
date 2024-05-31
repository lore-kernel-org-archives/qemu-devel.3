Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFBFC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD100-0004Ws-4g; Fri, 31 May 2024 08:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0004KY-Dn
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:21 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zV-0003PB-FY
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:19 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e724bc46c4so20200791fa.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157047; x=1717761847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ga8qaYVuw0C0KnS6BYgrkqsnKee3yNsBM+O4s8STdpM=;
 b=ARgcU35Z4Fb0USoP7zjtnNJWPxRgtfLqv0GUcrZkajHJg14magoy9CGEPPjgzrJIwm
 Wv9qEftDrltJxsT6mX+RGhw3k324Le2uVyy1DNS+nXxHdV2WWgJP1kSAxrOdzmQ8wrFq
 cngKOZ/eDe6TlyMUOcVBoAZ8914yEnLWlgnJ7npE0sN5AnCRCP8wT0Y8gChSnhs9r8QB
 kn/mEkuausHngxyobyuYO3TgcRRbw2oscRzvAzrNmBFE+OvFk0tCnlxnCJp1PfYUIQJd
 KlIfUTJdOSGjjcacQAI0tTlHhC2CrIKJu9je3X0OEzhdzQFlpHvYnfkj0EswX8AMiEq6
 dhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157047; x=1717761847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ga8qaYVuw0C0KnS6BYgrkqsnKee3yNsBM+O4s8STdpM=;
 b=OtFn861+emnlnCAaTD8wuSUYBkDsvrx/ZabBaiPR/WWADxdVHUMvjhwPDotbiP+vB9
 2y2HEQzIz/Zmf59raqDUP/ycrG33o9PmLpmjfYKi3qZ90fKkHqY/xWW7/B/o5WcatMaW
 dKOPCkMibVrAw2uNnu2UP2Vs4/qr71UpzaUqd41cOq9nfzi/Nb8XRVemxh9DLdIBc2Yo
 99KE+rG+8E0bnVzohB+LkQn8Jq01XdgRiFZxiYczpcnb9JTZlK9mTo9p56qlBLcmrf72
 yfPMFjdhrhCYhlxsab/Fe3kG9hIrNxzBkgUOD/KiU94nBNXqQ1Rs2FUgRsng7yXAFb6p
 XEXw==
X-Gm-Message-State: AOJu0YzIDm2JPautBLcu44zSqHaFiCl6C1H8ach6aG2/CvaxzywQ5RhU
 iRimbhmADJe+ME+wxvWT4PZ/DNWW5P88dznB+QLM4a54D8kCNAZewS2BhY9ETLmnYftCOYE3B+C
 +
X-Google-Smtp-Source: AGHT+IG2doZmMM6CCHiwAUAXI0RxeG9XCk+e1FnpTgQXB8gEeROQMDN+EkjNPK6WEVyLSULzBclJbA==
X-Received: by 2002:a05:651c:212:b0:2e9:870c:de1d with SMTP id
 38308e7fff4ca-2ea951e08d1mr11976261fa.39.1717157046941; 
 Fri, 31 May 2024 05:04:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/43] tests/avocado: update sbsa-ref firmware
Date: Fri, 31 May 2024 13:03:23 +0100
Message-Id: <20240531120401.394550-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Partial support for NUMA setup:
- cpu nodes
- memory nodes

Used versions:

- Trusted Firmware v2.11.0
- Tianocore EDK2 stable202405
- Tianocore EDK2 Platforms code commit 4bbd0ed

Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 98c76c1ff70..6bb82f2a03c 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -37,18 +37,18 @@ def fetch_firmware(self):
 
         Used components:
 
-        - Trusted Firmware 2.10.2
-        - Tianocore EDK2 stable202402
-        - Tianocore EDK2-platforms commit 085c2fb
+        - Trusted Firmware 2.11.0
+        - Tianocore EDK2 stable202405
+        - Tianocore EDK2-platforms commit 4bbd0ed
 
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240313-116475/edk2/SBSA_FLASH0.fd.xz"
+            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "637593749cc307dea7dc13265c32e5d020267552f22b18a31850b8429fc5e159"
+        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
@@ -57,9 +57,9 @@ def fetch_firmware(self):
         # Non-secure rom (UEFI and EFI variables)
         fs1_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240313-116475/edk2/SBSA_FLASH1.fd.xz"
+            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
         )
-        fs1_xz_hash = "cb0a5e8cf5e303c5d3dc106cfd5943ffe9714b86afddee7164c69ee1dd41991c"
+        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
         tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
@@ -98,15 +98,15 @@ def test_sbsaref_edk2_firmware(self):
 
         # AP Trusted ROM
         wait_for_console_pattern(self, "Booting Trusted Firmware")
-        wait_for_console_pattern(self, "BL1: v2.10.2(release):")
+        wait_for_console_pattern(self, "BL1: v2.11.0(release):")
         wait_for_console_pattern(self, "BL1: Booting BL2")
 
         # Trusted Boot Firmware
-        wait_for_console_pattern(self, "BL2: v2.10.2(release)")
+        wait_for_console_pattern(self, "BL2: v2.11.0(release)")
         wait_for_console_pattern(self, "Booting BL31")
 
         # EL3 Runtime Software
-        wait_for_console_pattern(self, "BL31: v2.10.2(release)")
+        wait_for_console_pattern(self, "BL31: v2.11.0(release)")
 
         # Non-trusted Firmware
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
-- 
2.34.1


