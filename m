Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4E0C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZR-0001LB-A2; Mon, 01 Jul 2024 12:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ2-0000eB-Qm
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ0-0005Pf-2k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42565697036so25316405e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850052; x=1720454852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n2HEIr2aWh0/VnzuRGuJ20MxeoVg0gSXyflQZjqPsQI=;
 b=ei9uNi0rMElC3vF+McJqdu1xBFGRADIvLgpiWBzr1txfJsExNjhfTrb36n68ceclJl
 DpzClZMMrddQNCMxTwxoWk6AJFD2gmilH+6UKi9lFrfXmwrIDA3583P338+7XxFl05cX
 450vSMsV6I7+xGGcECodyimjLZtnm9ByceRhOL0GH/suLQFhW+UI0MSIBHSATihEdYH3
 tugqEI2lFAy+TAofP6OD6zOEugH5T68kg6ahHurvWNLwoipMcEz4sZ9h4k/wke1WqOu/
 P0aZb8xkTGosQkNU1CX2zLxuHlD1E1tAbqNQc83++J7sg2JxS0bBOH8wNCFd1QjPxRIU
 cvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850052; x=1720454852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2HEIr2aWh0/VnzuRGuJ20MxeoVg0gSXyflQZjqPsQI=;
 b=RHK1DMYOYdubesGYlJLYHBdHcOImKwIumbDR7YHOS009H8Ke8sMk5GBwmzWuUKLieH
 Zhxtsk5O9eK68qV6pkvgyFURd44HcMAyVXEGw0WTGHMBjVFxuIAVbItTbLVnA4cy/E5B
 +b0HBwy23S8f7D5lUSJ0ScBEoZjG6IWXXdJvCIu1ARRp1OzBMRr8BftsiryRPchYJBad
 Zq7BlqcefW+mhRX5ZZFt/TgWsaJI/k2CXvWaJyA1SypRClh/Y4PyusnrzB6ezhlNVh79
 mzn1BcT4Ce//+b6NgxNjeMphSy5qPQgVVbsAosD/zZRxjNeV1V3UQqyTsQZuYNAxgJhf
 LKnw==
X-Gm-Message-State: AOJu0YyoY+lLRBe1CSNJNmUgdExJJh31vj5alSmm5yqElLYAdu2FAuw0
 6kSZIaxyv879tctqhMoRVx37OpI6YRWkIiXuuGWhnS4tEuoVC1jKP1QB3QqyaC6hZo+8lyc9IQh
 s8uE=
X-Google-Smtp-Source: AGHT+IFoZGZ2xOn6DoNX48Cyob/sCWMqhmcOmKkrPwzRqng0EGHIwXNsWlrU9iXNFHY4U7Ugdg9AJw==
X-Received: by 2002:a05:600c:1d14:b0:424:a401:f012 with SMTP id
 5b1f17b1804b1-4257984c6cfmr55374295e9.3.1719850052223; 
 Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] tests/avocado: update firmware for sbsa-ref
Date: Mon,  1 Jul 2024 17:07:04 +0100
Message-Id: <20240701160729.1910763-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Update firmware to have graphics card memory fix from EDK2 commit
c1d1910be6e04a8b1a73090cf2881fb698947a6e:

    OvmfPkg/QemuVideoDxe: add feature PCD to remap framebuffer W/C

    Some platforms (such as SBSA-QEMU on recent builds of the emulator) only
    tolerate misaligned accesses to normal memory, and raise alignment
    faults on such accesses to device memory, which is the default for PCIe
    MMIO BARs.

    When emulating a PCIe graphics controller, the framebuffer is typically
    exposed via a MMIO BAR, while the disposition of the region is closer to
    memory (no side effects on reads or writes, except for the changing
    picture on the screen; direct random access to any pixel in the image).

    In order to permit the use of such controllers on platforms that only
    tolerate these types of accesses for normal memory, it is necessary to
    remap the memory. Use the DXE services to set the desired capabilities
    and attributes.

    Hide this behavior under a feature PCD so only platforms that really
    need it can enable it. (OVMF on x86 has no need for this)

With this fix enabled we can boot sbsa-ref with more than one cpu core.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240620-b4-new-firmware-v3-1-29a3a2f1be1e@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 6bb82f2a03c..e854ec6a1af 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -37,18 +37,18 @@ def fetch_firmware(self):
 
         Used components:
 
-        - Trusted Firmware 2.11.0
-        - Tianocore EDK2 stable202405
-        - Tianocore EDK2-platforms commit 4bbd0ed
+        - Trusted Firmware         v2.11.0
+        - Tianocore EDK2           4d4f569924
+        - Tianocore EDK2-platforms 3f08401
 
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240528-140808/edk2/SBSA_FLASH0.fd.xz"
+            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "fa6004900b67172914c908b78557fec4d36a5f784f4c3dd08f49adb75e1892a9"
+        fs0_xz_hash = "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
@@ -57,9 +57,9 @@ def fetch_firmware(self):
         # Non-secure rom (UEFI and EFI variables)
         fs1_xz_url = (
             "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
-            "20240528-140808/edk2/SBSA_FLASH1.fd.xz"
+            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
         )
-        fs1_xz_hash = "5f3747d4000bc416d9641e33ff4ac60c3cc8cb74ca51b6e932e58531c62eb6f7"
+        fs1_xz_hash = "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
         tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash,
                                       algorithm='sha256')
         archive.extract(tar_xz_path, self.workdir)
-- 
2.34.1


