Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED836C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lb-0008HE-QM; Sat, 09 Mar 2024 14:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Jl-00071k-Tr
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:16 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Je-0003Gp-Qb
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:10 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d269b2ff48so48620111fa.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012303; x=1710617103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zPZ+tfLA0kEM+leCIAJpOJfakF+P7OF5niFNRbs0QA=;
 b=AHBwVgXq9ZG3/uDg62TUf5rnj5n6AJIgCw2RdDjkDn7Re4d2QILaZs2k5kW71jtwoh
 rm6zAao15W9zINZ3R2OKC+q/vdo6pbjLZ/UYX/3yMW5TSHtdn8pEMg1MQtHnENWpa/mG
 PJM8e57q+iJIWQS1ZIlwzvhWDEGA0GTjnOV1uvZVQ3sed7toNFxtDOIMDVW74UnUBRWt
 2ZWnl7R/uDmtqOU36ZSmwOIcV+s9IzmarAuFOMHq8O/l/7uF9zWW1LcHd4G+eljxvGNH
 2mNgOMIj13yIqI/ddN4mp5asQKSunHm1p96NKJCoNZGg73gPwQ6KAmDfQFg6Xvr6iLI3
 6hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012303; x=1710617103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zPZ+tfLA0kEM+leCIAJpOJfakF+P7OF5niFNRbs0QA=;
 b=Fo9rfDWgQaHDuz45XxuAmY3tUwVCt5OLkOk1+zIlsH4Q+iiehvFygxMCkSE4qwoFxl
 yaqyaHFwjU5Z0hsfUJ/YPzZdBGcKNNnonhzsGbmNh1AI+I5O2qDCgD67R1adMOERICWx
 Bryz+4VR/JTbxf1o8r4lehN3wI0/EX0cBU4ynzMBycygUjJUT9DXHDXJE9C1TTY9TqdS
 8fCtL8Rseg7xd9vmP46cbZtPvwBe0e+3ZqKpM9BiuBFl+k49dKFdgcR26UtsPugA+1+k
 RN6dzd6jBPoWAAeJxEYRFwwKQVS1sgkSTyYE1KJNG/0ORhIEu4QYyQk2bcpZ/8W5pBf4
 gI3A==
X-Gm-Message-State: AOJu0YySule8H/LhPN7RyyXnmPDW2I32ZKom16AqXNJa+x8gWZEVaBp0
 Yz4XeTAW8CzYN9SXLID6qJ2yFv+xS3d5l5Rxa5FIjcoNymQrbqtypCmT23scjH7IU9mNGfCrKCE
 K
X-Google-Smtp-Source: AGHT+IH24Ht406wouiE5qSs+XSE1JrmIm/ZKODAoIJUUNI0MaGtabmYkhIaVOzO3mcklEOuqeSwLfA==
X-Received: by 2002:a2e:87d3:0:b0:2d4:31a0:6adf with SMTP id
 v19-20020a2e87d3000000b002d431a06adfmr299482ljj.24.1710012303605; 
 Sat, 09 Mar 2024 11:25:03 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 cn19-20020a0564020cb300b0056828004c75sm1167790edb.51.2024.03.09.11.25.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PULL 28/43] docs/interop/firmware.json: Align examples
Date: Sat,  9 Mar 2024 20:21:55 +0100
Message-ID: <20240309192213.23420-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Adjust indentation for commit d23055b8db8 (qapi: Require descriptions
and tagged sections to be indented).

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240307-qapi-firmware-json-v2-1-3b29eabb9b9a@linutronix.de>
[PMD: Reword description using Markus suggestion]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/interop/firmware.json | 374 ++++++++++++++++++-------------------
 1 file changed, 187 insertions(+), 187 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index cc8f869186..a024f1b9bf 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -435,203 +435,203 @@
 #
 # Examples:
 #
-# {
-#     "description": "SeaBIOS",
-#     "interface-types": [
-#         "bios"
-#     ],
-#     "mapping": {
-#         "device": "memory",
-#         "filename": "/usr/share/seabios/bios-256k.bin"
-#     },
-#     "targets": [
-#         {
-#             "architecture": "i386",
-#             "machines": [
-#                 "pc-i440fx-*",
-#                 "pc-q35-*"
-#             ]
+#     {
+#         "description": "SeaBIOS",
+#         "interface-types": [
+#             "bios"
+#         ],
+#         "mapping": {
+#             "device": "memory",
+#             "filename": "/usr/share/seabios/bios-256k.bin"
 #         },
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-i440fx-*",
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "acpi-s4"
-#     ],
-#     "tags": [
-#         "CONFIG_BOOTSPLASH=n",
-#         "CONFIG_ROM_SIZE=256",
-#         "CONFIG_USE_SMM=n"
-#     ]
-# }
+#         "targets": [
+#             {
+#                 "architecture": "i386",
+#                 "machines": [
+#                     "pc-i440fx-*",
+#                     "pc-q35-*"
+#                 ]
+#             },
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-i440fx-*",
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "acpi-s4"
+#         ],
+#         "tags": [
+#             "CONFIG_BOOTSPLASH=n",
+#             "CONFIG_ROM_SIZE=256",
+#             "CONFIG_USE_SMM=n"
+#         ]
+#     }
 #
-# {
-#     "description": "OVMF with SB+SMM, empty varstore",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
-#             "format": "raw"
+#     {
+#         "description": "OVMF with SB+SMM, empty varstore",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "requires-smm",
-#         "secure-boot",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a IA32",
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D SMM_REQUIRE",
-#         "-D SECURE_BOOT_ENABLE",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "requires-smm",
+#             "secure-boot",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a IA32",
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgIa32X64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D SMM_REQUIRE",
+#             "-D SECURE_BOOT_ENABLE",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
 #
-# {
-#     "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
-#             "format": "raw"
+#     {
+#         "description": "OVMF with SB+SMM, SB enabled, MS certs enrolled",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.secboot.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.secboot.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "enrolled-keys",
-#         "requires-smm",
-#         "secure-boot",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a IA32",
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgIa32X64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D SMM_REQUIRE",
-#         "-D SECURE_BOOT_ENABLE",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "enrolled-keys",
+#             "requires-smm",
+#             "secure-boot",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a IA32",
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgIa32X64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D SMM_REQUIRE",
+#             "-D SECURE_BOOT_ENABLE",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
 #
-# {
-#     "description": "OVMF with SEV-ES support",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/OVMF/OVMF_CODE.fd",
-#             "format": "raw"
+#     {
+#         "description": "OVMF with SEV-ES support",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/OVMF/OVMF_CODE.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/OVMF/OVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/OVMF/OVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "x86_64",
-#             "machines": [
-#                 "pc-q35-*"
-#             ]
-#         }
-#     ],
-#     "features": [
-#         "acpi-s3",
-#         "amd-sev",
-#         "amd-sev-es",
-#         "verbose-dynamic"
-#     ],
-#     "tags": [
-#         "-a X64",
-#         "-p OvmfPkg/OvmfPkgX64.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D FD_SIZE_4MB"
-#     ]
-# }
+#         "targets": [
+#             {
+#                 "architecture": "x86_64",
+#                 "machines": [
+#                     "pc-q35-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
+#             "acpi-s3",
+#             "amd-sev",
+#             "amd-sev-es",
+#             "verbose-dynamic"
+#         ],
+#         "tags": [
+#             "-a X64",
+#             "-p OvmfPkg/OvmfPkgX64.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D FD_SIZE_4MB"
+#         ]
+#     }
 #
-# {
-#     "description": "UEFI firmware for ARM64 virtual machines",
-#     "interface-types": [
-#         "uefi"
-#     ],
-#     "mapping": {
-#         "device": "flash",
-#         "executable": {
-#             "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
-#             "format": "raw"
+#     {
+#         "description": "UEFI firmware for ARM64 virtual machines",
+#         "interface-types": [
+#             "uefi"
+#         ],
+#         "mapping": {
+#             "device": "flash",
+#             "executable": {
+#                 "filename": "/usr/share/AAVMF/AAVMF_CODE.fd",
+#                 "format": "raw"
+#             },
+#             "nvram-template": {
+#                 "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
+#                 "format": "raw"
+#             }
 #         },
-#         "nvram-template": {
-#             "filename": "/usr/share/AAVMF/AAVMF_VARS.fd",
-#             "format": "raw"
-#         }
-#     },
-#     "targets": [
-#         {
-#             "architecture": "aarch64",
-#             "machines": [
-#                 "virt-*"
-#             ]
-#         }
-#     ],
-#     "features": [
+#         "targets": [
+#             {
+#                 "architecture": "aarch64",
+#                 "machines": [
+#                     "virt-*"
+#                 ]
+#             }
+#         ],
+#         "features": [
 #
-#     ],
-#     "tags": [
-#         "-a AARCH64",
-#         "-p ArmVirtPkg/ArmVirtQemu.dsc",
-#         "-t GCC48",
-#         "-b DEBUG",
-#         "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
-#     ]
-# }
+#         ],
+#         "tags": [
+#             "-a AARCH64",
+#             "-p ArmVirtPkg/ArmVirtQemu.dsc",
+#             "-t GCC48",
+#             "-b DEBUG",
+#             "-D DEBUG_PRINT_ERROR_LEVEL=0x80000000"
+#         ]
+#     }
 ##
 { 'struct' : 'Firmware',
   'data'   : { 'description'     : 'str',
-- 
2.41.0


