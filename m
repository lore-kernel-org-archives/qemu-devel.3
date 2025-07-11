Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A858DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDv2-0006rR-DW; Fri, 11 Jul 2025 09:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDuD-0004ar-AA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDuA-0003Rj-VK
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so18653085e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240909; x=1752845709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CVN1z+tWl9V2/IAeWcoVzag1iP6PIT5deFW+qz0vQnE=;
 b=HnyQyU86H1um2vo554ZqQd9/WsiKxr2azRN2sEVX2ftmBFItPe2jdYV8cK/jWkVPvH
 K00EXj8Cp1l+G+z6sBwtvbeLMuXn9RqGF6Heh8sRVQfxdzRpenr7PjOuQK9Hm/54c7qG
 XOygdxm1XK0/ZVOxCP8WlqDMo7X1BEHpQjHlRb6XSlPVLbzGxp+7PhkokY2L6v3mjtmG
 lTLAY3MfSbO/SupjovaoeFOuIWHXVSEC3Nf4EL+zKB9kUttSeADf+PyPJ763sBsV5B2e
 6elTxrvoneoKCMMPP/eflwiwh1XdVN2aH/s7oCN4OAfSuTV3otoe92BAhTqzbG/G1Pqk
 C6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240909; x=1752845709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVN1z+tWl9V2/IAeWcoVzag1iP6PIT5deFW+qz0vQnE=;
 b=BhkeGOhLHivdFHt3azoDVQWFKK+mMAIz3wSqb/vIP6oHpkAHlmqaviXnUdo0Weutsy
 InIsP3QxulTXzrN1CoyKYFTQXO+AAACsLSPFJwDrteHL2IO5hBsSNXpPaL+gbdXahKz6
 t/Kbc9uqflKD1PV3egIi4Ax6xDa5Jk3w7wWhgy3enor4aVOSHZONJU/ZgelaOv8CoHoR
 KgXbjduPCHIBe73hUbZM/C30RrjvS2po0rayyZBTIpOEDayF4WnNRNbVwlkoYnQyheiG
 SNQwGqyy4EfBtU+uQEER+p6vSwPYtf5oyrM5FviGAT7WhuC7e3pDmX3nTa5AwfSYp+hX
 TYeA==
X-Gm-Message-State: AOJu0YxZpPbJO5/5kXdSPtlAc2MfFFGriG/GGw16jyXuFz7+Z3N88Xi5
 hupC1eYcYIIGDf9i8P7olJ5ilLNXy3cqfi8O1htYxEUaw63/fdDI19asTAz81YMVBk6Bo6TSRNy
 16cvu
X-Gm-Gg: ASbGnctOJ0BKbaNxBNZk2+5paqpSH8pq2Qz0DGkEuUOy2IRuud6tYl2y4M8oIp7Bseb
 LGwQYLY+Z3C1CGFaSbZavLjBgInIqJiRV9U0jUtXWi6L1+RLZmUkw01aIZiQH1vrATe58J1YDBF
 LdEg/y6oYZ63h5FDCDmVGb7TReumEAHm0ksNHDkDAKeuZOxRuw4eh4gAlYWfExwD0S1Q1WqT+Po
 B9k2edf1bWz+QzClX7FlYeJv7gSSXujlN+fqzFTle52gxQxf0IK/OUWWA7OWdM6rBlOvTOH61nk
 56ElKf1jJEQL5695GmDoGYOJkOpreRxznSCOQzYTf3gJWUDgWJZWjG4qFFK2xREE1B7IpY3FPwO
 +nsy6dox0bMOkbNYVg7cqS9QeH+UnULW29wbbJuA=
X-Google-Smtp-Source: AGHT+IH9HxW9g+Zx/lTj0HcsoMmgK5ccTabBk6Ig2vhD9B+2vgvaPlBIquTLrseS91jpDvhTMcNoMw==
X-Received: by 2002:a05:600c:4746:b0:453:7713:476c with SMTP id
 5b1f17b1804b1-455bd8e63aemr21980345e9.2.1752240908883; 
 Fri, 11 Jul 2025 06:35:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] tests/functional: Add a test for the MAX78000 arm machine
Date: Fri, 11 Jul 2025 14:34:29 +0100
Message-ID: <20250711133429.1423030-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

Runs a binary from the max78000test repo used in
developing the qemu implementation of the max78000
to verify that the machine and implemented devices
generally still work.

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250711110626.624534-3-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/meson.build              |  1 +
 tests/functional/test_arm_max78000fthr.py | 48 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/functional/test_arm_max78000fthr.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 050c9000b95..cd67e6d734e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -138,6 +138,7 @@ tests_arm_system_thorough = [
   'arm_cubieboard',
   'arm_emcraft_sf2',
   'arm_integratorcp',
+  'arm_max78000fthr',
   'arm_microbit',
   'arm_orangepi',
   'arm_quanta_gsj',
diff --git a/tests/functional/test_arm_max78000fthr.py b/tests/functional/test_arm_max78000fthr.py
new file mode 100755
index 00000000000..a82980b0f7c
--- /dev/null
+++ b/tests/functional/test_arm_max78000fthr.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# Functional test that checks the max78000fthr machine.
+# Tests ICC, GCR, TRNG, AES, and UART
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class Max78000Machine(QemuSystemTest):
+
+    ASSET_FW = Asset(
+        'https://github.com/JacksonDonaldson/max78000Test/raw/main/build/max78000.bin',
+        '86940b4bf60931bc6a8aa5db4b9f7f3cf8f64dbbd7ac534647980e536cf3adf7')
+
+    def test_fthr(self):
+        self.set_machine('max78000fthr')
+        fw_path = self.ASSET_FW.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', fw_path)
+        self.vm.add_args('-device', "loader,file=" + fw_path + ",addr=0x10000000")
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'started')
+
+        # i -> prints instruction cache values
+        exec_command_and_wait_for_pattern(self, 'i', 'CTRL: 00010001')
+
+        # r -> gcr resets the machine
+        exec_command_and_wait_for_pattern(self, 'r', 'started')
+
+        # z -> sets some memory, then has gcr zero it
+        exec_command_and_wait_for_pattern(self, 'z', 'initial value: 12345678')
+        wait_for_console_pattern(self, "after memz: 00000000")
+
+        # t -> runs trng
+        exec_command_and_wait_for_pattern(self, 't', 'random data:')
+
+        # a -> runs aes
+        exec_command_and_wait_for_pattern(self, 'a',
+                'encrypted to : a47ca9dd e0df4c86 a070af6e 91710dec')
+        wait_for_console_pattern(self,
+                'encrypted to : cab7a28e bf456751 9049fcea 8960494b')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


