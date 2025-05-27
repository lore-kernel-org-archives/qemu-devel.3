Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B16C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvpU-0005aA-BG; Tue, 27 May 2025 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJvpS-0005Sv-FM
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:58 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJvpP-0006EA-HS
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:58 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-87decd1c427so939406241.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748358172; x=1748962972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RniEF1mf7TN4jF60DdYm0zWLKlVKKpJMW1uo5Rs5HEQ=;
 b=zMPIA1jSo2iSblif6zL8CjztKbijl0L9jjETGHd1Me6mJDt3fT408NBuotwu3Z7r2r
 2nVBoV8xbgHdQjqVzRTqt9oCleE7YiyLciCOqMs+z6eWPa6j9L89izQKQULDik19nIBo
 5RN5vQrFHCrtad79Syu8QDxGiTZYc250/K0GRNVnVAeCsccYKDwICpmKLzRJhTtcUKBa
 /frwY7IlrkU3OnTvtzxIWUOLp78QsB6msm/EkbSAkZOcy6CzqnWyfoVYEVsQJiq5TsE6
 /B6E5R5Yn5SsF8BxhPLq+CdADdAgbs+MySNtkRFTIpgJ7zt3HVFeAwuLZzLaGXbn2np2
 oXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358172; x=1748962972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RniEF1mf7TN4jF60DdYm0zWLKlVKKpJMW1uo5Rs5HEQ=;
 b=YSexNXqTZA+O+MPWp2HVtssXi5/wtLy53+sKHcOL1Fdo7yGq65CLDb6CM1aYwBExAT
 k0QsC7jpkVM2xUKYiiIlqAdK1vgSEBeKcZHLQYV53FX4pd9diBeuvgCIFYQQAhw62+Vr
 GTgiH2jPbp0tbGuU0hCn5cAo+nI0vimJYlpRyTI7ddiexW3bzlJ7L2mOWpuBxwDRc8BS
 +Pgp7FyMGky8KbpmHG8sBp6lbhnIG9o6LbKxO+462J7NC3tiTPV+6jvY5wxT9N157dSp
 I22uHKVVCJ8c6ItFfbbJNszxm8UvQR709kgVZlr4FUklabRdkUmsVhdvo+Zmo4kK+7aG
 RjBA==
X-Gm-Message-State: AOJu0YzJH3Kb2+5vb+xe7M2vTCec2mwishv73GJd+S9+s/g90FH8asqR
 M/r6fT2cn7PhMvlgjX8ddNe+mtitoIC0tusPciiYGbUK1J18rORDN0uxJY1ZaVk9OmHHW8GBgCl
 kB3jTqRU=
X-Gm-Gg: ASbGncsjAvHsyeSD4fa3s2iKhUFPyx4pepPD/jSjh2D83/808gPofnqwjvQH02GT1bY
 rSIhjMqNtIyc9lcX2GbLl1uLJAipbpdIkeOXSAngB65tOtD/rrFEThzD8uggy9cvZwfbIHt2iKJ
 B0e5tDXuXTTWgOi9v9wM5Kn7jANwF3iFJaoEhddLYzS6tMXMPMhaHTsg9YHW7gEApb/dqx/Hw2w
 J6W3VEYgzI0qT2WRc8WyBF57W2MjB2bWNxgh+fvcDXWMWYKP8Ms0o3GuFhxzNsyjKCVRJF8d8YT
 J9wY+Ckjt78oMQVRgMiP5NANGrJl60swDu0HvWSXaWlPTxiQQcGz3hNlxylF+qdLNWBExiT7V33
 00mPY6PcMB4TItUn2NiXEsA==
X-Google-Smtp-Source: AGHT+IEamKsspQzXxNvrx0hfrbFiwI9Yy1dIhoMMXDOZHKjNKDNxlne+0y+H39wK8Qh/YB1E5p1ejQ==
X-Received: by 2002:a05:6102:3590:b0:4cb:5d6c:9946 with SMTP id
 ada2fe7eead31-4e4240a654cmr10360291137.10.1748358172339; 
 Tue, 27 May 2025 08:02:52 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e51e94c9c2sm2189649137.23.2025.05.27.08.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:02:51 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 2/2] tests/functional/test_aarch64_hotplug_pci: Add test for
 ACPI PCI hotplug
Date: Tue, 27 May 2025 15:02:29 +0000
Message-Id: <20250527150229.1617074-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527150229.1617074-1-gustavo.romero@linaro.org>
References: <20250527150229.1617074-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x92e.google.com
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

Currently, test_aarch64_hotplug_pci only tests PCI hotplug using the
native PCI hotplug mechanism. Now that aarch64 supports PCI hotplug via
the ACPI mechanism it's time to support it in the test as well.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/test_aarch64_hotplug_pci.py | 24 +++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
index bb2c121503..862bb6746b 100755
--- a/tests/functional/test_aarch64_hotplug_pci.py
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -27,11 +27,26 @@ class HotplugPCI(LinuxKernelTest):
          'current/images/netboot/debian-installer/arm64/initrd.gz'),
         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
 
-    def test_hotplug_pci(self):
+    def run_vm_and_test_hotplug_pci(self, use_acpi_pci_hotplug=False):
+        """
+        Run an aarch64 VM and test the PCI hotplug mechanism by plugging and
+        unplugging a PCI network adapter to the VM. Proper plug and unplug of
+        the adapter is verified by checking if the network device is correctly
+        added and removed in Linux.
+
+        Parameters
+        ----------
+        use_acpi_pci_hotplug : bool
+            If true the ACPI PCI hotplug mechanim is used, otherwise the
+            Native PCIe Hotplug mechanism is used.
+        """
+
+        acpi_pci_hotplug = "on" if use_acpi_pci_hotplug else "off"
 
         self.set_machine('virt')
         self.vm.add_args('-m', '512M')
         self.vm.add_args('-cpu', 'cortex-a57')
+        self.vm.add_args('-machine', f"acpi-pcihp={acpi_pci_hotplug}")
         self.vm.add_args('-append',
                          'console=ttyAMA0,115200 init=/bin/sh')
         self.vm.add_args('-device',
@@ -70,5 +85,12 @@ def test_hotplug_pci(self):
                                           'ls -l /sys/class/net | wc -l',
                                           '2')
 
+    def test_native_pci_hotplug(self):
+        self.run_vm_and_test_hotplug_pci(use_acpi_pci_hotplug=False)
+
+    def test_acpi_pci_hotplug(self):
+        self.run_vm_and_test_hotplug_pci(use_acpi_pci_hotplug=True)
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.34.1


