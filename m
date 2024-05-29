Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B771C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsH-0000f2-5f; Wed, 29 May 2024 12:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLsD-0000d9-Oo
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:58 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLrx-0003IL-Vh
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a61b70394c0so265127366b.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998980; x=1717603780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLMfOIC0M6UjEiTjbHQfPonFA1Fbh58cXgqyObzz2H0=;
 b=DsLEgT+LeP5vwy+DFlqew/KR2R6dXZWPn8+XPxhx106d2xOLzaBoxUWAfsMoyIMzEW
 330TjaR7FuyFCLy6HwVUVMHhyl23CGx0gRl2ko06RIZO8T10B0kJdJbXV91GwlAuVCk0
 yKhipM+RRYDtXyeqQjaX40jiGkN1g2j6tqFCNM1Sta5/DNrGPtry5K1u3POONxc4kg0P
 tQm8ueKch+u7cPbSo3adm+WUhHTXrDp9O4GNHtMvgDJv1PW2Ld+HZkHoNmdT4d5PboXS
 uLA8YLPqG7elDL1BZABa3mG53wADCQRAlRgW6n+k5p/794ec0DmNKefyHGN17Q99yXk8
 DLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998980; x=1717603780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLMfOIC0M6UjEiTjbHQfPonFA1Fbh58cXgqyObzz2H0=;
 b=GY70xL5kIPsmpTVuMmx3xzkVlz5ycsiBGX84rzu00OlwJ9kwtAoMifv9RPMWtJZKn3
 x0wWRxyAyRXpAspyyPwVw1FwLEiVtoZGZjVWFAEvHhoC4nmdnGWHmbIXGUhblO99xIsd
 XeLJMrxViZ9ZWgMraHb7xAF2kQfIiMkfMDulZzZdUpdeIo0LJq/QqzIRwyWBsbqHpYrW
 daJRj7ptvu2S8d9JVEQw/Ll/wdQ6NT/QRWVzrQK/0ur8QZq6BLZfx1pL4+b4LYGQwnNw
 w9c8vitqm1gux9GwArG72kNd9krFhSWy4B3N3QE4Egdc/NSY4SZGUFm+UtfnNzmq3RER
 42ow==
X-Gm-Message-State: AOJu0Ywy2tvxVC5HBqkf4qsRaGpbfPk2Hya3W4QhBfjKrKfAXE3cyZCd
 9bIb7IWzqNtEpp7fpDovFrIS9dF1wjrXJjB+Dz9mWGGD+u+POxtPmis8X9gC0kg=
X-Google-Smtp-Source: AGHT+IGibP4ee9T4MPCyGEUiuvCqTiuPAc1oiOIKTjz/WIGnHqyNN02usNxYINKIHESZhVmkeDpmYQ==
X-Received: by 2002:a17:906:fb03:b0:a62:415b:b5c with SMTP id
 a640c23a62f3a-a62641a2a26mr966637966b.5.1716998980355; 
 Wed, 29 May 2024 09:09:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c934fd8sm727651966b.47.2024.05.29.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06C3F5FA95;
 Wed, 29 May 2024 17:09:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 10/10] tests/avocado: update sbsa-ref firmware
Date: Wed, 29 May 2024 17:09:34 +0100
Message-Id: <20240529160934.982373-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-Id: <20240528182917.91027-1-marcin.juszkiewicz@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 98c76c1ff7..6bb82f2a03 100644
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
2.39.2


