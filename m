Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1638C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIJ-00069H-5B; Tue, 18 Jun 2024 12:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHv-0005YB-3x
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbHt-0006yM-CX
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:26 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f177b78dcso715784366b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726543; x=1719331343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+nanogCLs1TtntQDLHWZlcaUmy7mJVDY5yva2wn6DY=;
 b=fe63QVUPQe1YaTN7jjaAbwpT2/EPMg1jqhO/7AHhh5reVCYgqXT86Q81dkB4NzaBUH
 c1gsuLjfHVwoz2nTAwRS9uz15KDJJAfu8WypCLh1uNu3z5HsIT/OSN8mvvcXFh4mnykd
 bcaEDUt6bl32zKNcquvE3Os5kwRpKdxd1ciom6ErF53Lj9fBBZCKdMOukLMD0x2GVvpI
 bivM9TlKjP2/5aovCWPSfMJO95WLeX/78el5928q0YUT4Y68+25bn7tEFMLHzhqBK0US
 sNhPWMcB0L1GnsVBUuzNxa23nHZjuKS7E7Y2TreiyftWSTlTgEuj/xJ7Y5Id7y8RObRg
 +/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726543; x=1719331343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+nanogCLs1TtntQDLHWZlcaUmy7mJVDY5yva2wn6DY=;
 b=OvJivHgBkHufxyu8Pyqn2b+c11bWM5HOPvTXMPgOPIvfNBW5jrza8blP0VOJi9GYQU
 Qckivl0IpuZXVP16jtRm4/QoLcISFy5zcAaI2QEFPMFU+wQh99yTXlSTYC47uNY2BG0B
 wzo0+d9Xedj49BtQ8LU1m2z8mBVImN/CEjXswoaemBAZctn6c1mgZPJXaOiNkxXHRUu1
 wWCVeeGi3Ih759UGAyUE90SADu/jAoPH1KdfZw1tfsT7Szdp1DLMK/8ewNMcj1gOG74T
 fDAwU4G/CUsuJRbGbZVWfHJ/iBR2StK7/gTwKyHOMewufPLyGMaGT3aHeqzUCVxbPNSG
 eang==
X-Gm-Message-State: AOJu0YzPvyREHX0N4rqKD9Qi0wzo2r3WEx50p/haEK7qde06WPKCMA6K
 Lf7ZYlTJjg37Dnw0GyQ5qq0+43jhTc+E7qMkX2WAYiBN19JXuQvkClhiYYkJ4WisYzJhIw6eVV0
 W
X-Google-Smtp-Source: AGHT+IEYm6KCv1UPgZBaWhtS1ipyZG10D1iX00EW9+lQFjEGUa6xlXQ+br8FpuyyT32RqcX8yPBRMQ==
X-Received: by 2002:a17:906:d296:b0:a6f:5c1a:c9a6 with SMTP id
 a640c23a62f3a-a6f60dc1fb3mr758303166b.62.1718726543200; 
 Tue, 18 Jun 2024 09:02:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd135esm632707466b.96.2024.06.18.09.02.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:02:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 17/76] hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
Date: Tue, 18 Jun 2024 17:59:39 +0200
Message-ID: <20240618160039.36108-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PCMachineClass::resizable_acpi_blob was only used by the
pc-i440fx-2.2 machine, which got removed. It is now always
true. Remove it, simplifying acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-18-philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/acpi-build.c | 10 ----------
 hw/i386/pc.c         |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 155a02b1b5..d01ddc4618 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -125,9 +125,6 @@ struct PCMachineClass {
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
-    /* resizable acpi blob compat */
-    bool resizable_acpi_blob;
-
     /*
      * whether the machine type implements broken 32-bit address space bound
      * check for memory.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f5d74e2b4b..eafc3761c8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2687,16 +2687,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * keep the table size stable for all (max_cpus, max_memory_slots)
      * combinations.
      */
-    /* Make sure we have a buffer in case we need to resize the tables. */
-    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-        !pcmc->resizable_acpi_blob) {
-        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-        warn_report("ACPI table size %u exceeds %d bytes,"
-                    " migration may not work",
-                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-        error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                     " or PCI bridges.\n");
-    }
     acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 21a9b7a5ae..a6d50df500 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1774,7 +1774,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


