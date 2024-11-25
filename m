Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1B7D58090
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFYcC-0006AU-Hd; Mon, 25 Nov 2024 07:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tFYcB-0006A8-NJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:54:55 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tFYc9-0000QS-V0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:54:55 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53da6801c6dso3946376e87.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732539291; x=1733144091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dwwwu87koNylv50baHmKnTD/nJXqdX01a12g01r7Nmo=;
 b=OtI23E9V2ZdIE+csjDlp/vULuRjAnsaaGFvg2aGgitM9mnDUaUiKbrIKhkT8oNnG+4
 e+9RUJiv41Q2vCWzOT4K5FjIPHRSkDl+UaTOE0/bNzejG6OND3w6HYllKTjJC/niBEYE
 wdFQqqoAPbXlMAHqT/5d32PFNk+PlsSJhWIfr+IZcFD3nDkuIkyhBupPIvF7pYLfUyvj
 cXNNuFi+v7pNhrM1eVE1uYMC3/L3QRov5Qs0njnZh3FSxysZbqEB7nTXByJVI64dD5da
 uKB+UwEa7XtHIUxkPFnIuSgtBS3llCKMv1vHWnLVDhIwpyywuka4qQTM7VmrbeYI4V6C
 SXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732539291; x=1733144091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwwwu87koNylv50baHmKnTD/nJXqdX01a12g01r7Nmo=;
 b=fopKBO1I3uMT5GKKw4Eyd/P9i4bl7uBs2ya8MFFo6ON8FVZ7YFiNDggmB9gj/us/UF
 Ek//FijLtcdkWfQV3pG7qVSGzGX54sFgJ3qN4ggH/myPJpCF65AsyrhdPbm2FIHcnlpD
 DBYDSbkPpfIK3G03dYxDXyQ0D4s7KhxAj+GUyAZIIJr+sBgY9eS8Xkd8jry/2/Cx6mGl
 D6MswfWkouYzovitd57G9eEidT9QwCzgVY10wTZ8rUG+0hBsR8JwBv+nl962xiRBXyus
 DCbxjpy5xJPQbrwCAVhL4MZboPFW6boIylGaYwaATIOc+i4zKOT6ZgtuO1r8iJ6vk7qN
 C3WQ==
X-Gm-Message-State: AOJu0YzEc5p4MhUvV6qfKetPzpjHPZ0DueCiHkYA+mMZQi0XzCB5P/F1
 JqSNGA7QVfqFw36KfDQ/Ioe8oObtsZ/xd3piLA5rfF0qfrlk+j6cEy59d0PVTio+R2ojfRfwjdf
 i
X-Gm-Gg: ASbGncvYvZbOOyGwwQqhdUT10HCAn60htRGMDNCJ/cUpH0ZXhr93LuuhsJ2pXD3DIkb
 iN9jOyTIvZsnqK5k186Kp1WNoDQKHvJ5i/CLBVPdrWY7+A8NDklCHh/yYTt66PG/JHSmSbDVBOi
 EMwCmRUKkgTX8FJTQ4fxp4i4rEMkuqX7Xg/ki1x5e+t1a3Yjl3XK/ldXb1iXW/eZ6jK3R/u1Vn0
 R9ZhfCZCy+m4ZfFTP95M7SarfIuaKB+gXXBPwD81w5wcvutChpHMQOtPwsq3j8g7xVcm2XsD/62
 NzL3YrBN2AeWYNr8Rz57WVc3BA==
X-Google-Smtp-Source: AGHT+IEy4H3hve9Iz2HBTm5AFOS2yiLPIuHcIwVuMfGGH7fBbZUJjKRJWZ0ggIP8XGCO665ocadAHQ==
X-Received: by 2002:a05:6512:3b0a:b0:53d:d68b:501e with SMTP id
 2adb3069b0e04-53dd68b5041mr5158989e87.15.1732539291007; 
 Mon, 25 Nov 2024 04:54:51 -0800 (PST)
Received: from applejack.lan (83.11.10.28.ipv4.supernova.orange.pl.
 [83.11.10.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa54e15c169sm156764566b.67.2024.11.25.04.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 04:54:50 -0800 (PST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
Date: Mon, 25 Nov 2024 13:54:48 +0100
Message-ID: <20241125125448.185504-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12c.google.com
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

Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).

Used versions:

- Trusted Firmware v2.12.0
- Tianocore EDK2 stable202411
- Tianocore EDK2 Platforms code commit 4b3530d

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 9fda396b3a..3a09523265 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -25,9 +25,9 @@ def fetch_firmware(test):
 
     Used components:
 
-    - Trusted Firmware         v2.11.0
-    - Tianocore EDK2           4d4f569924
-    - Tianocore EDK2-platforms 3f08401
+    - Trusted Firmware         v2.12.0
+    - Tianocore EDK2           edk2-stable202411
+    - Tianocore EDK2-platforms 4b3530d
 
     """
 
@@ -63,13 +63,13 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
     ASSET_FLASH0 = Asset(
         ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
-         '20240619-148232/edk2/SBSA_FLASH0.fd.xz'),
-        '0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7')
+         '20241122-189881/edk2/SBSA_FLASH0.fd.xz'),
+        '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
 
     ASSET_FLASH1 = Asset(
         ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
-         '20240619-148232/edk2/SBSA_FLASH1.fd.xz'),
-        'c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee')
+         '20241122-189881/edk2/SBSA_FLASH1.fd.xz'),
+        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
 
     def test_sbsaref_edk2_firmware(self):
 
@@ -87,15 +87,15 @@ def test_sbsaref_edk2_firmware(self):
 
         # AP Trusted ROM
         wait_for_console_pattern(self, "Booting Trusted Firmware")
-        wait_for_console_pattern(self, "BL1: v2.11.0(release):")
+        wait_for_console_pattern(self, "BL1: v2.12.0(release):")
         wait_for_console_pattern(self, "BL1: Booting BL2")
 
         # Trusted Boot Firmware
-        wait_for_console_pattern(self, "BL2: v2.11.0(release)")
+        wait_for_console_pattern(self, "BL2: v2.12.0(release)")
         wait_for_console_pattern(self, "Booting BL31")
 
         # EL3 Runtime Software
-        wait_for_console_pattern(self, "BL31: v2.11.0(release)")
+        wait_for_console_pattern(self, "BL31: v2.12.0(release)")
 
         # Non-trusted Firmware
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
-- 
2.47.0


