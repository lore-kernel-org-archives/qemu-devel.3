Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907D0C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jou-00033M-9v; Tue, 01 Sep 2026 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Jos-00033A-R3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Joq-0003HL-I9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788251172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4c5ivQVbkuDk6fUP3PFBGOabBLafo8LY6N/DAX/Y7E=;
 b=UmCWYNAQr79M6M+9CLOaZkY4iHGdtrt59+OnJpTFhnpBRlSbxUClItX7UGUxHhOwHflsOZ
 U8PAchPiZocNSHBDU5Ji515ByUHRwIvqrGXx5WYR53MRGWjA3Vw6e9uJIumaidUFt/fJ+E
 MpuHAIozWGf3m+HiSF3AIPfdY4aWEmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-sNBKPNL8NuSLdO-rU39QQQ-1; Tue,
 01 Sept 2026 04:26:00 -0400
X-MC-Unique: sNBKPNL8NuSLdO-rU39QQQ-1
X-Mimecast-MFC-AGG-ID: sNBKPNL8NuSLdO-rU39QQQ_1788251158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD2E18011C8; Tue,  1 Sep 2026 08:25:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 502E01955F01; Tue,  1 Sep 2026 08:25:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 64F871807DE4; Tue, 01 Sep 2026 10:25:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/13] edk2: drop 32-bit build config (ia32 and arm),
 update aarch64 vars
Date: Tue,  1 Sep 2026 10:25:37 +0200
Message-ID: <20260901082554.804169-5-kraxel@redhat.com>
In-Reply-To: <20260901082554.804169-1-kraxel@redhat.com>
References: <20260901082554.804169-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Upstream edk2 has dropped support for 32-bit architectures.
Remove the build config for these builds.

Update aarch64 config and test cases, aarch64 used to share
the 'vars' image with arm.

Drop references to the 32-bit builds in a number of places.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260824164751.1700783-5-kraxel@redhat.com>
---
 tests/functional/aarch64/test_virt_vbsa.py   |  2 +-
 tests/qtest/bios-tables-test.c               | 34 +++++++--------
 pc-bios/descriptors/50-edk2-i386-secure.json | 34 ---------------
 pc-bios/descriptors/60-edk2-aarch64.json     |  2 +-
 pc-bios/descriptors/60-edk2-arm.json         | 31 --------------
 pc-bios/descriptors/60-edk2-i386.json        | 33 ---------------
 pc-bios/descriptors/meson.build              |  3 --
 pc-bios/meson.build                          |  6 +--
 roms/edk2-build.config                       | 44 ++------------------
 9 files changed, 23 insertions(+), 166 deletions(-)
 delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
 delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
 delete mode 100644 pc-bios/descriptors/60-edk2-i386.json

diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
index 04b5ff0f9e8d..97293fb7883d 100755
--- a/tests/functional/aarch64/test_virt_vbsa.py
+++ b/tests/functional/aarch64/test_virt_vbsa.py
@@ -35,7 +35,7 @@ def append_firmware_blobs(self):
         Setup QEMU firmware blobs for boot.
         """
         code_path = self.build_file('pc-bios', 'edk2-aarch64-code.fd')
-        vars_source = self.build_file('pc-bios', 'edk2-arm-vars.fd')
+        vars_source = self.build_file('pc-bios', 'edk2-aarch64-vars.fd')
         vars_path = self.scratch_file('vars.fd')
         shutil.copy(vars_source, vars_path)
 
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 5cc526510ac1..9aadc1a1f6c3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1640,7 +1640,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 256ULL * MiB,
@@ -1671,7 +1671,7 @@ static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 256ULL * MiB,
@@ -1695,7 +1695,7 @@ static void test_acpi_aarch64_virt_pcie_root_port_hpoff(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 256ULL * MiB,
@@ -1809,7 +1809,7 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -1832,7 +1832,7 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
     };
@@ -1865,7 +1865,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_spcr(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * 1024 * 1024,
@@ -1945,7 +1945,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -2221,7 +2221,7 @@ static void test_acpi_aarch64_virt_tcg(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -2242,7 +2242,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
         .variant = ".topology",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -2265,7 +2265,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
         .variant = ".its_off",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * 1024 * 1024,
@@ -2284,7 +2284,7 @@ static void test_acpi_aarch64_virt_tcg_msi_gicv2m(void)
         .variant = ".msi_gicv2m",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * 1024 * 1024,
@@ -2303,7 +2303,7 @@ static void test_acpi_aarch64_virt_tcg_wdat(void)
         .variant = ".wdat",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -2322,7 +2322,7 @@ static void test_acpi_aarch64_virt_tcg_gtdt_wd(void)
         .variant = ".gwdt",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -2407,7 +2407,7 @@ static void test_acpi_aarch64_virt_viot(void)
         .variant = ".viot",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
@@ -2425,7 +2425,7 @@ static void test_acpi_aarch64_virt_smmuv3_legacy(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
     };
@@ -2464,7 +2464,7 @@ static void test_acpi_aarch64_virt_smmuv3_dev(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
     };
@@ -2683,7 +2683,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
         .arch = "aarch64",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
-        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .uefi_fl2 = "pc-bios/edk2-aarch64-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
         .ram_start = 0x40000000ULL,
         .scan_len = 128ULL * MiB,
diff --git a/pc-bios/descriptors/50-edk2-i386-secure.json b/pc-bios/descriptors/50-edk2-i386-secure.json
deleted file mode 100644
index d7108c1da05a..000000000000
--- a/pc-bios/descriptors/50-edk2-i386-secure.json
+++ /dev/null
@@ -1,34 +0,0 @@
-{
-    "description": "UEFI firmware for i386, with Secure Boot and SMM",
-    "interface-types": [
-        "uefi"
-    ],
-    "mapping": {
-        "device": "flash",
-        "executable": {
-            "filename": "@DATADIR@/edk2-i386-secure-code.fd",
-            "format": "raw"
-        },
-        "nvram-template": {
-            "filename": "@DATADIR@/edk2-i386-vars.fd",
-            "format": "raw"
-        }
-    },
-    "targets": [
-        {
-            "architecture": "i386",
-            "machines": [
-                "pc-q35-*"
-            ]
-        }
-    ],
-    "features": [
-        "acpi-s3",
-        "requires-smm",
-        "secure-boot",
-        "verbose-dynamic"
-    ],
-    "tags": [
-
-    ]
-}
diff --git a/pc-bios/descriptors/60-edk2-aarch64.json b/pc-bios/descriptors/60-edk2-aarch64.json
index 800a21bda691..94926172959c 100644
--- a/pc-bios/descriptors/60-edk2-aarch64.json
+++ b/pc-bios/descriptors/60-edk2-aarch64.json
@@ -10,7 +10,7 @@
             "format": "raw"
         },
         "nvram-template": {
-            "filename": "@DATADIR@/edk2-arm-vars.fd",
+            "filename": "@DATADIR@/edk2-aarch64-vars.fd",
             "format": "raw"
         }
     },
diff --git a/pc-bios/descriptors/60-edk2-arm.json b/pc-bios/descriptors/60-edk2-arm.json
deleted file mode 100644
index d5f1bba6cc82..000000000000
--- a/pc-bios/descriptors/60-edk2-arm.json
+++ /dev/null
@@ -1,31 +0,0 @@
-{
-    "description": "UEFI firmware for arm",
-    "interface-types": [
-        "uefi"
-    ],
-    "mapping": {
-        "device": "flash",
-        "executable": {
-            "filename": "@DATADIR@/edk2-arm-code.fd",
-            "format": "raw"
-        },
-        "nvram-template": {
-            "filename": "@DATADIR@/edk2-arm-vars.fd",
-            "format": "raw"
-        }
-    },
-    "targets": [
-        {
-            "architecture": "arm",
-            "machines": [
-                "virt-*"
-            ]
-        }
-    ],
-    "features": [
-        "verbose-static"
-    ],
-    "tags": [
-
-    ]
-}
diff --git a/pc-bios/descriptors/60-edk2-i386.json b/pc-bios/descriptors/60-edk2-i386.json
deleted file mode 100644
index 2f8dec74fecb..000000000000
--- a/pc-bios/descriptors/60-edk2-i386.json
+++ /dev/null
@@ -1,33 +0,0 @@
-{
-    "description": "UEFI firmware for i386",
-    "interface-types": [
-        "uefi"
-    ],
-    "mapping": {
-        "device": "flash",
-        "executable": {
-            "filename": "@DATADIR@/edk2-i386-code.fd",
-            "format": "raw"
-        },
-        "nvram-template": {
-            "filename": "@DATADIR@/edk2-i386-vars.fd",
-            "format": "raw"
-        }
-    },
-    "targets": [
-        {
-            "architecture": "i386",
-            "machines": [
-                "pc-i440fx-*",
-                "pc-q35-*"
-            ]
-        }
-    ],
-    "features": [
-        "acpi-s3",
-        "verbose-dynamic"
-    ],
-    "tags": [
-
-    ]
-}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index cdd0be01a356..63f1c00b6406 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -1,10 +1,7 @@
 if unpack_edk2_blobs and get_option('install_blobs')
   foreach f: [
-    '50-edk2-i386-secure.json',
     '50-edk2-x86_64-secure.json',
     '60-edk2-aarch64.json',
-    '60-edk2-arm.json',
-    '60-edk2-i386.json',
     '60-edk2-x86_64.json',
     '60-edk2-loongarch64.json',
     '60-edk2-riscv64.json'
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 2f470ed12942..f7412bf53e69 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -2,13 +2,9 @@ roms = []
 if unpack_edk2_blobs
   fds = [
     'edk2-aarch64-code.fd',
-    'edk2-arm-code.fd',
-    'edk2-arm-vars.fd',
+    'edk2-aarch64-vars.fd',
     'edk2-riscv-code.fd',
     'edk2-riscv-vars.fd',
-    'edk2-i386-code.fd',
-    'edk2-i386-secure-code.fd',
-    'edk2-i386-vars.fd',
     'edk2-x86_64-code.fd',
     'edk2-x86_64-secure-code.fd',
     'edk2-loongarch64-code.fd',
diff --git a/roms/edk2-build.config b/roms/edk2-build.config
index 9e45361fb445..fcf9da8c7681 100644
--- a/roms/edk2-build.config
+++ b/roms/edk2-build.config
@@ -33,29 +33,6 @@ PcdDxeNxMemoryProtectionPolicy = 0xC000000000007FD1
 # shim.efi has broken MemAttr code
 PcdUninstallMemAttrProtocol    = TRUE
 
-####################################################################################
-# i386
-
-[build.ovmf.i386]
-desc = ovmf build (32-bit)
-conf = OvmfPkg/OvmfPkgIa32.dsc
-arch = IA32
-opts = common
-plat = OvmfIa32
-dest = ../pc-bios
-cpy1 = FV/OVMF_CODE.fd edk2-i386-code.fd
-cpy2 = FV/OVMF_VARS.fd edk2-i386-vars.fd
-
-[build.ovmf.i386.secure]
-desc = ovmf build (32-bit, secure boot)
-conf = OvmfPkg/OvmfPkgIa32.dsc
-arch = IA32
-opts = common
-       ovmf.sb.smm
-plat = OvmfIa32
-dest = ../pc-bios
-cpy1 = FV/OVMF_CODE.fd edk2-i386-secure-code.fd
-
 ####################################################################################
 # x86_64
 
@@ -87,23 +64,6 @@ plat = MicrovmX64
 dest = ../pc-bios
 cpy1 = FV/MICROVM.fd  edk2-x86_64-microvm.fd
 
-####################################################################################
-# arm
-
-[build.armvirt.arm]
-desc = ArmVirt build, 32-bit (arm v7)
-conf = ArmVirtPkg/ArmVirtQemu.dsc
-arch = ARM
-opts = common
-       armvirt.silent
-pcds = nx.broken.shim.grub
-plat = ArmVirtQemu-ARM
-dest = ../pc-bios
-cpy1 = FV/QEMU_EFI.fd    edk2-arm-code.fd
-cpy2 = FV/QEMU_VARS.fd   edk2-arm-vars.fd
-pad1 = edk2-arm-code.fd  64m
-pad2 = edk2-arm-vars.fd  64m
-
 ####################################################################################
 # aarch64
 
@@ -114,10 +74,12 @@ arch = AARCH64
 opts = common
        armvirt.silent
 pcds = nx.broken.shim.grub
-plat = ArmVirtQemu-AARCH64
+plat = ArmVirtQemu-AArch64
 dest = ../pc-bios
 cpy1 = FV/QEMU_EFI.fd  edk2-aarch64-code.fd
+cpy2 = FV/QEMU_VARS.fd edk2-aarch64-vars.fd
 pad1 = edk2-aarch64-code.fd  64m
+pad2 = edk2-aarch64-vars.fd  64m
 
 ####################################################################################
 # riscv64
-- 
2.55.0


