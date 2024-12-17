Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA39E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbF2-00081O-KG; Tue, 17 Dec 2024 12:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEx-0007zn-IJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEn-0006Gk-Lj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:10 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so32523825e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455999; x=1735060799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BWF/weaINscBWPQRFGXtvePkQA4R6NzsQhHnlGcKylk=;
 b=XyQX1pCQ080ghv0bS9Ki+p55COnZvJAC3K0Vz4a6cIsRBV2ii/zk+lN0ggHhBeqpBD
 RkHAORYQfxy7yqgtVJ4LjEoVWITW6CzoNT7nkZnDHexdOI+ruA+YVMugnWRry/lCKzWz
 0v9gFVxi4TjgLMqjh7tNDw25nPschsf3thVj/7qbyDpHjh8sC5PNh6gmkSVJ+xsFdRhI
 NPriEysyZIofjjX+wUg3UYK+BaCgBz9jVM6rJ55VQpiHOcusEUPG4HhHn8hzAsm2XLRw
 urd3vcqAYCjr3VvX0SGoyu1gGUouCMM47W5NiGNUZiDdbH8EQmtszMdVMdQirjP9gauD
 S8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455999; x=1735060799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWF/weaINscBWPQRFGXtvePkQA4R6NzsQhHnlGcKylk=;
 b=hRokojAZjQBrUsNVm3AOaN9yegJpRmZFG3YNiAjERltA8hvbkwKMXSmgoTL66fs4cP
 Wd6GL6YTOWP8LwyxRaYXSzyDPQM0DWfftd1dhyQAR1f5zM1ol+VfUl0R0bMedn8ICDCg
 bb2aPd99934kF5ko+9nbtO/kYq0vbyPiZDSg7dcEILI4wWjoeRZRg6MoLOT5MUtYSFzC
 881q6uVQhbsHdPIaL52Ek2HeGCJufMoLpiQFOZHJvsx9I4Rm4iPLPKek7ldovdllAU0N
 3SDa9kqI12vGVGhiAOoLt3BNKYF2eeNZd+JaBmEFkJPNNKwRMUHSq0lfRjMYF2Ml2/l3
 7cCA==
X-Gm-Message-State: AOJu0YyW23IiNUFyY4aUDFbWVjyzU52JJsWBwiWUG20cE3waFNyLzTWU
 /jVsF/Kx5lQbyElgYT2dn4tHwQ7QUMybUGgR2jl2BKKZQLLyMag0nqvTTpICMI63Hdo59TKIbxg
 g
X-Gm-Gg: ASbGncsaG0VFHd0qTM+pRFUCApHA3BdQ7Dq24PmoWL0SrDi7G6B3y5+Cq9wMRDQVQA0
 0oRJSWIt4zIlE2KHUpg8Ot+tFh25YGU72Qp+i3WM6Jq1wBm73jDLO5ecHWNoIjsqEVJDGuHEcfx
 OB0B/WCrzBVYo0T5qzC33j7sRaPaotaDOlFm6duyvaxE+TVEAIJHY/kEiMyud7KNZpt0iOWGHA5
 wdW/il5SehPZq7qDI5Fk9oMED/bX6EfbZ8WB9WFTJ0B0zfi7vw/E1hI9FyTd1A=
X-Google-Smtp-Source: AGHT+IGKenUQAkzye6RB7pin32PGDGRtjE8fuvP0eo2rNTq5Wj+cMIQgQpQelEFc6X0CWbkh9Q1Ftg==
X-Received: by 2002:a5d:6d8e:0:b0:386:43c9:3ac2 with SMTP id
 ffacd0b85a97d-38880ad8785mr16337797f8f.15.1734455998956; 
 Tue, 17 Dec 2024 09:19:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] tests/functional: update sbsa-ref firmware used in test
Date: Tue, 17 Dec 2024 17:19:37 +0000
Message-Id: <20241217171937.3899947-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Update the URLs for the binaries we use for the firmware in the
sbsa-ref functional tests.

The firmware is built using Debian 'bookworm' cross toolchain (gcc
12.2.0).

Used versions:

- Trusted Firmware v2.12.0
- Tianocore EDK2 stable202411
- Tianocore EDK2 Platforms code commit 4b3530d

This allows us to move away from "some git commit on trunk"
to a stable release for both TF-A and EDK2.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20241125125448.185504-1-marcin.juszkiewicz@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 6db08da5221..52507af2bdc 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -24,9 +24,9 @@ def fetch_firmware(test):
 
     Used components:
 
-    - Trusted Firmware         v2.11.0
-    - Tianocore EDK2           4d4f569924
-    - Tianocore EDK2-platforms 3f08401
+    - Trusted Firmware         v2.12.0
+    - Tianocore EDK2           edk2-stable202411
+    - Tianocore EDK2-platforms 4b3530d
 
     """
 
@@ -62,13 +62,13 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
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
 
@@ -86,15 +86,15 @@ def test_sbsaref_edk2_firmware(self):
 
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
2.34.1


