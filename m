Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D72C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQS3-0004gk-W1; Mon, 26 May 2025 01:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRd-0002vH-1z
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:19 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRX-0002KM-7S
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:12 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86dc3482b3dso1898598241.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748237529; x=1748842329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiA6hOZT8dbZS3oxbupOyToDge/JikBtR/d7vAGhdTw=;
 b=j3N+UtSDkLV/jcYWjBdYSUZHw9wgHc+3xR10vpCeqCMZETBcyXDich5w0lnTrWYJRc
 D1DSH2WnsRrRdKkIq/pOAYtWJzX1E2X2KwA7DgK8a/nDyqlq77YOuCPQ25PI3CUwMUzt
 TAvgS/zpSolU6GrPVGkwjE8poVDwycX5CVGH3JK8z57O+D7bOMOruAmMPS2rYJibcWeE
 X7r/RDOS2bsTXJwBsHG0FSE2ibQW+L7Aq23Mfdgpv8AwNorH1TcP4/yHyEQwi2jjlsVP
 vY5tMzLD+ObFLY4HXZxFEFSj69120s1aCIu6v6O7aeFcsl5vUvtlvaO39BLQdcFvdXdE
 vJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237529; x=1748842329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiA6hOZT8dbZS3oxbupOyToDge/JikBtR/d7vAGhdTw=;
 b=X/ux3wd3+DRABSRqLH/03FT5J57dlipMl0ZhO7frffNnbY7viFi82/vFkxo57KKjYl
 U8dnse0xNYsoAX1XwEdFKzdMb4vN36maVX/3hKU1b9kuEd+RII2JqndyDFNehu8hCTwi
 rZXGxWyeDb5Y+/xrB2NDezCA+2xDf5zcIfat/iYSkUUxp9jYWUmhPWqnOilYra0H3uQy
 uP6n+DlrSpPXdsXEnoBqoEgSmZ+Lbw6jyUaHhgGWMwrry6GHEPnyyEX+L9wBtWLXVnS7
 m4IjEXYkRgoAHETI/+J/BzbPkiKNAEJq1nZ/cEGlgiaI26uxc1PDAPvrrktSkpqatJtJ
 Twtw==
X-Gm-Message-State: AOJu0YynC9rc9Vwj7jY0VC/rhWl07qIelZ3yGer4aAfz2zUxKX3pqocJ
 hHTXBcsBVBK6R3FXO9YLZND4dD4D5IvF+SZ4jpc/ZKwoaHoLy2t1hJ+hzuupsumlEIDeb7OG1zx
 cK9AAT/c=
X-Gm-Gg: ASbGncuT7dDMOfAOTKCJEuk5aLIrZXKjwS+y03y6zzZ3GRENGdqnTY7hJPwYmt2LGt2
 Nrrnm5HZ386rshauXHyufgqID8ehP4S+qTSeh5P6Nvkt+9NnWayaMN8OZeR2EM5Juz8ur+OlbNT
 gdG4m74WU9BjzvmbOwE7+f5RFqxEPQDaGW3xyH6uEYaQcU/UyMR38NCKguvpzwWZcTJc8v2AraX
 XgqiedB/nEJ78jsYREMH1EAUIpU4gRNCN3MJvo6G3zN/xhohI1ZDoqkgToto74Dg/WPtG8z+4xt
 q+NJziPCf99790Dr4J6Tfg57SCQz/NRNTzQRU/u2+sNsZXgDPPsFV2N+XmVu3hPMGF6hT8fNBG6
 0UL2xmGl3xJL9AwIj9CCuLw==
X-Google-Smtp-Source: AGHT+IFN2lNK4zSXYTc+V8vX1GgVatJUToP0HcuvBCW3JIvZvNKnE0F9IyZPW+yKJjIbkdNmYKJk2w==
X-Received: by 2002:a05:6102:4407:b0:4e2:82b1:efe0 with SMTP id
 ada2fe7eead31-4e423d6eda2mr4871280137.1.1748237529338; 
 Sun, 25 May 2025 22:32:09 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e454da4378sm784310137.17.2025.05.25.22.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 22:32:08 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, mst@redhat.com, imammedo@redhat.com
Subject: [PATCH 4/5] tests/qtest/bios-tables-test: Add aarch64 ACPI PCI
 hotplug test
Date: Mon, 26 May 2025 05:31:22 +0000
Message-Id: <20250526053123.1434204-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526053123.1434204-1-gustavo.romero@linaro.org>
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x932.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a test to verify that the aarch64 'virt' machine correctly generates
the ACPI tables and AML code for PCI device hotplug.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp |  0
 tests/qtest/bios-tables-test-allowed-diff.h |  1 +
 tests/qtest/bios-tables-test.c              | 32 +++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..dc3ab24d05 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 216941dbb5..1bf45bc6e3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1643,6 +1643,37 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
 
 }
 
+static void test_acpi_aarch64_virt_pci_hotplug(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 512ULL * 1024 * 1024,
+        .variant = ".acpipcihp",
+    };
+
+   test_acpi_one(" -machine acpi-pcihp=on"
+                 " -cpu cortex-a57"
+                 " -m 512M"
+                 /*
+                  * We just pick address=0x04 for the root port to avoid
+                  * collisions with other PCI devices on the root bus (pcie.0).
+                  * It could be any other value that doesn't collide.
+                  *
+                  * The 'chassis' and 'slot' options equal to 1 have no special
+                  * meaning here, could be any integer, but we set them to known
+                  * values to keep the test consistent.
+                  */
+                 " -device pcie-root-port,bus=pcie.0,chassis=1,slot=1,addr=0x04.0x00",
+                 &data);
+
+    free_test_data(&data);
+}
+
 static void test_acpi_microvm_prepare(test_data *data)
 {
     data->machine = "microvm";
@@ -2584,6 +2615,7 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
+            qtest_add_func("acpi/virt/pcihp", test_acpi_aarch64_virt_pci_hotplug);
             qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
             qtest_add_func("acpi/virt/oem-fields",
                            test_acpi_aarch64_virt_oem_fields);
-- 
2.34.1


