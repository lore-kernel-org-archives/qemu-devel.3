Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFBC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp388-0008LN-ES; Mon, 03 Mar 2025 05:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp380-0008Bc-Ea; Mon, 03 Mar 2025 05:34:30 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37x-00078J-TU; Mon, 03 Mar 2025 05:34:28 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2feaca4e99cso5845822a91.0; 
 Mon, 03 Mar 2025 02:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998064; x=1741602864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0KecVzXq5Tev48eCkNDbbqeVEncl4n+Fdnz5kYlR8M=;
 b=UIbUKk0XPTCv0rsrd2k5t8t8iEO/dIvV6Taz1G66s3x6hSixudpm3Uoo/ZpjTZSB+j
 LC2Q8nDZZlofxITh94OB0tyP5IepNnMiTFe18N+Cp6mM+BFiPUEPXqf8cjBNpbh1M5zs
 1/V8guUtS5Jo0czri60TKZu55vTnYCaCfLQ4zQ9kNiNtsWSjXQOeZhHk3DdvvahSBvBQ
 ZgU0DTB+q9j3uo/qvYt72ejJ6teA9Jg0ycGIUgsxmFltv/M6siNq7D+3K7yakt+hCoip
 j3d3Lq0o0elbLuRbFSIRLmc51xA0Mk2/aXR1BYbjE9CeHgqOtD3J8xzvptw1xgFBepjg
 d3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998064; x=1741602864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0KecVzXq5Tev48eCkNDbbqeVEncl4n+Fdnz5kYlR8M=;
 b=OnGOjx4c1SWlmjCbQD9cIIsW1EAHRPY/vZBecQAKjIkrHefnvvX1pCl4MgDwPh6Ucr
 Jb7wUznEpVeb9MoNgGGmc0OTZ2LB179B9h20YJ4uvUO4UK+uVayPk/RimfF6hbVQTNvn
 0KiVqvyufHNgoIgWm6YtP6+bbn9uuz2lBWrHTZMlZOTkTGNv72JOeTsM51ZT4O4EL8gi
 vuA+S534oxa3BqTfoEi8LqtdMm9daPuIBT3nCuqlc/mXg21m/X6rr15ipN2X7e6gEq5N
 0hS7/jHBVVFYdEXWa2enlcoSFDu8C2MeY5K2Na/yuUnZO9VHlv4eFGWSQJZK4w1E0JXy
 xR9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUItIzAIq5W6vlCzcILXBBPOMAh5ThvBNf//Jp8JCXxzAwfhRBInt9K/b+parfipXh37OiFb5JkHSMf@nongnu.org
X-Gm-Message-State: AOJu0Yz1M0gr/rEy45Iq4Nq03xT8s+4lAKl+8Sz56AtT2R2INCx1XLTZ
 AkyohDof+TGVa4cXq+mmhQasAdpoRM31XDhrZeciYK424yBwBvJrB4cskQ==
X-Gm-Gg: ASbGncu8r/+QH8Xd19lgcXSzVtKC8C7iGlpQsIMj74YQwEEMnqrj4hmQyBcu92R2zne
 D7hScxgmFvzJG1f2TyP4WwvDE3zPgjc2Tvc4eP6tlPcr7JlHxfuD5nz2WWvovMMuxG4CX3akyfD
 8iW7uQwLY7toAWgUKob+crzpRsVMhzVJOcnW2aa8Dh1cslpeVx5sLirLSVxhV+W8jTFCqGjhS3q
 7HCp1Hkcj9/4pwHlhTl3gf7VjUbR12MSgMNakhTQvL58n5HLoYNeD1EQSSCnsDb1PuQv8SLX4Y+
 EDVkh3DXOj6qWr0uqhBUJNOKKx/qAkeH/yA2ELxY9sCpHr+RCMs=
X-Google-Smtp-Source: AGHT+IGulZ9X36pYMASI5tDWhozKNmvlA1u3866/f+rpZNWlt/W/2ezgBNaBG/HKeE0lLhg0ACtCLw==
X-Received: by 2002:a17:90b:3ecd:b0:2fe:b016:a6ad with SMTP id
 98e67ed59e1d1-2febab77398mr21536693a91.18.1740998061672; 
 Mon, 03 Mar 2025 02:34:21 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 6/6] ppc/pnv: Add a default formatted PNOR image
Date: Mon,  3 Mar 2025 20:33:57 +1000
Message-ID: <20250303103359.578994-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303103359.578994-1-npiggin@gmail.com>
References: <20250303103359.578994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The default PNOR image is erased and not recognised by skiboot, so NVRAM
gets disabled. This change adds a tiny pnor file that is a proper FFS
image with a formatted NVRAM partition. This is recognised by skiboot and
will persist across machine reboots.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS                 |   1 +
 docs/system/ppc/powernv.rst |   7 +++++++
 hw/ppc/pnv.c                |  16 +++++++++++++++-
 pc-bios/README              |  13 +++++++++++++
 pc-bios/meson.build         |   1 +
 pc-bios/pnv-pnor.bin        | Bin 0 -> 139264 bytes
 6 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/pnv-pnor.bin

diff --git a/MAINTAINERS b/MAINTAINERS
index 1911949526c..3cf39fb65cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1531,6 +1531,7 @@ F: include/hw/ppc/pnv*
 F: include/hw/pci-host/pnv*
 F: include/hw/ssi/pnv_spi*
 F: pc-bios/skiboot.lid
+F: pc-bios/pnv-pnor.bin
 F: tests/qtest/pnv*
 F: tests/functional/test_ppc64_powernv.py
 
diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index de7a807ac76..f3ec2cc69c0 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -195,6 +195,13 @@ Use a MTD drive to add a PNOR to the machine, and get a NVRAM :
 
   -drive file=./witherspoon.pnor,format=raw,if=mtd
 
+If no mtd drive is provided, the powernv platform will create a default
+PNOR device using a tiny formatted PNOR in pc-bios/pnv-pnor.bin opened
+read-only (PNOR changes will be persistent across reboots but not across
+invocations of QEMU). If no defaults are used, an erased 128MB PNOR is
+provided (which skiboot will probably not recognize since it is not
+formatted).
+
 Maintainer contact information
 ------------------------------
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 422913e631c..7085899c40e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -64,6 +64,8 @@
 #define FW_LOAD_ADDR            0x0
 #define FW_MAX_SIZE             (16 * MiB)
 
+#define PNOR_FILE_NAME          "pnv-pnor.bin"
+
 #define KERNEL_LOAD_ADDR        0x20000000
 #define KERNEL_MAX_SIZE         (128 * MiB)
 #define INITRD_LOAD_ADDR        0x28000000
@@ -942,7 +944,7 @@ static void pnv_init(MachineState *machine)
     uint64_t chip_ram_start = 0;
     int i;
     char *chip_typename;
-    DriveInfo *pnor = drive_get(IF_MTD, 0, 0);
+    DriveInfo *pnor;
     DeviceState *dev;
 
     if (kvm_enabled()) {
@@ -989,6 +991,18 @@ static void pnv_init(MachineState *machine)
      * Create our simple PNOR device
      */
     dev = qdev_new(TYPE_PNV_PNOR);
+    pnor = drive_get(IF_MTD, 0, 0);
+    if (!pnor && defaults_enabled()) {
+        fw_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, PNOR_FILE_NAME);
+        if (!fw_filename) {
+            warn_report("Could not find PNOR '%s'", PNOR_FILE_NAME);
+        } else {
+            QemuOpts *opts;
+            opts = drive_add(IF_MTD, -1, fw_filename, "format=raw,readonly=on");
+            pnor = drive_new(opts, IF_MTD, &error_fatal);
+            g_free(fw_filename);
+        }
+    }
     if (pnor) {
         qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor));
     }
diff --git a/pc-bios/README b/pc-bios/README
index 700dcaab523..6c14a8d4dcc 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -43,6 +43,19 @@
   run an hypervisor OS or simply a host OS on the "baremetal"
   platform, also known as the PowerNV (Non-Virtualized) platform.
 
+- pnv-pnor.bin is a non-volatile RAM image used by PowerNV, which stores
+  NVRAM BIOS settings among other things. This image was created with the
+  following command (the ffspart tool can be found in the skiboot source tree):
+
+  ffspart -s 0x1000 -c 34 -i pnv-pnor.in -p pnv-pnor.bin
+
+  Where pnv-pnor.in contains the two lines (no leading whitespace):
+
+  NVRAM,0x01000,0x00020000,,,/dev/zero
+  VERSION,0x21000,0x00001000,,,/dev/zero
+
+  skiboot is then booted once to format the NVRAM partition.
+
 - QemuMacDrivers (https://github.com/ozbenh/QemuMacDrivers) is a project to
   provide virtualised drivers for PPC MacOS guests.
 
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 51e95cc9031..34d6616c32b 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -70,6 +70,7 @@ blobs = [
   's390-ccw.img',
   'slof.bin',
   'skiboot.lid',
+  'pnv-pnor.bin',
   'palcode-clipper',
   'u-boot.e500',
   'u-boot-sam460-20100605.bin',
diff --git a/pc-bios/pnv-pnor.bin b/pc-bios/pnv-pnor.bin
new file mode 100644
index 0000000000000000000000000000000000000000..3e6f70014408e76d5aeca758c31113f3eee2da84
GIT binary patch
literal 139264
zcmeI#F-pWh6adg4Z3XuTYGvUiB3M|su2Hsktrl6cs9>qBjb1>#fLMAT?;zU=IwKJx
z*a&F???dwcWXPYH*UhM`jv}IHo|}}HBL*qOMt-$pRBkWk$LE*rZ%ti%rbu<}lm5^7
zyGJwKO}c-2yd93Ka_@J$yyjZ7{!*&*I3iaa$H()_!+57U+}$6xJFlm~&-t6P=jrax
z|F(F)%jXmX2oNAZfB*pk1PBlyK;XXu2d_m;C$p`K)9IwH|GL_@uexdi1PBlyK!5-N
z0t5&UAV8px0`rwYoYb>feb&d_+cN<I1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72y`WIy}24!
zt>~(+J_HC5AV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
jAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly&@X{6e@Sm%

literal 0
HcmV?d00001

-- 
2.47.1


