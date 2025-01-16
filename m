Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B35C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRNa-0004AX-JN; Thu, 16 Jan 2025 10:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMS-0002U6-Hc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:44 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMQ-0000Ea-Ge
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso9735095e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039640; x=1737644440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ras698VG4WQwvy9cNjVcAoc+PZd43poMNOebZYPMtOs=;
 b=xqerccLQbMAwDZRH2qd/hXBXqkuMp5afXauZXMAB6S29p2V1/ebz/eMwMwr+QtBfQZ
 nw3GM5eXKdxDAmwbhkGTalU13EttnCUaOxTz1x1Jecn0fLI4oI+3F9D7lyyiquioIPJV
 vquy5fCkXRpGq27oFng7V65lnkV+SNVw7+se8MSXcp/6A0X5trIO6LlSumMCzxhTbaZi
 lt6KMSpbGBGZMYD+UG389tl2DOXG//NRCbE+fvRUAq3RN7VBK3ekF4iMaTPRPAr91E5H
 5cWlWSkoX9nvFhVteuHHPtOMgUGjU8xXkmD2Uq6qzbKEkl9jhYRIVtvDsyW8+5zelROP
 mVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039640; x=1737644440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ras698VG4WQwvy9cNjVcAoc+PZd43poMNOebZYPMtOs=;
 b=HdWFaYqSRYf5lMUWfl5eECcmXMPUEWo3PwJZ6la1Ktmp9wjlhMXi2bqDyoK6YrG5p2
 49HnJMZ94dqeAAxktNUCLFZNMhADOTe8aigk4LGpQUEkfgfOB7hWmTK4HK3aRwWu5/71
 vJkr4+mxWZUHJBmhtf0fbwYGjDRZgXRi2Uf+qoM/y07xhdL2Rx4+6uygQVk8rOzcV6rQ
 3uQqgR9c/zg1XWtfLWbR3TMO87LTVri11TrRuYdPMHHzc1563KznzDrqy46xlxdq/9IY
 fUqfpzWuqsaw1InnX2NxfsYy0RhGjgJHMdmpJAK9o4EXikOYmyJaA0zl6jy4atoh22vS
 I+cQ==
X-Gm-Message-State: AOJu0YwR86kR8wKjXTlh8jxa9Q8ULwFZnzSRC3/SxAHyNl5qE7FJN92p
 EHeMTZR9JHiSqKNZnH5T69JEqIN3ViPwk5ocxlanyMSPx4WzWeOd/7hJfHC8Ow2CsepF9tm5H8w
 3Pjs=
X-Gm-Gg: ASbGnctKNnWl7YGBZTT6Yh0iFAr4O5G9ZHUcOyyqraWB+7UV238Jui30ldo9yh4UbJt
 ViqCO40EFZHGf78ePiano/giguwCfKoo/OQNWwTqi/xA9HbU4q+/7WrzRYr/zQD1JFaHRBEhxOq
 XaGDd/+anQETRwyZJVvraPS3t+l73M0CeEUA0RyD7NXMbiyWTIhjxruyMlUR6PrLoZv9shXu0ER
 bjFvU4pTlVBSyDQ5cj/bX7gmGyMzV6KMockWHxy89Bv1rRVk115BY5dQxarGYpd74foy1okdS7F
 JEXJ4UdoVbIwW1oOpLnfEUC8/GXQ37o=
X-Google-Smtp-Source: AGHT+IEGqt5LYyRNuNwxmPUwveStM/Hobp0oxMyS+M+bn3FFSVEdw5nSG3lX8GlolFGroj7GUlTNGw==
X-Received: by 2002:a05:600c:b55:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-436e2707f2cmr264915725e9.24.1737039639770; 
 Thu, 16 Jan 2025 07:00:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c73e7140sm63579865e9.0.2025.01.16.07.00.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 11/13] hw/arm/virt: Remove
 VirtMachineClass::smbios_old_sys_ver field
Date: Thu, 16 Jan 2025 15:59:42 +0100
Message-ID: <20250116145944.38028-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The VirtMachineClass::smbios_old_sys_ver field was
only used by virt-2.11 machine, which got removed.
Remove it and simplify virt_build_smbios().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9c531e28d04..b2cc012a402 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -118,7 +118,6 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
-    bool smbios_old_sys_ver;
     bool no_highmem_compact;
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 582a5aa077b..f15d6f230b4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1688,7 +1688,6 @@ static void virt_build_smbios(VirtMachineState *vms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(vms);
     MachineState *ms = MACHINE(vms);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area mem_array;
@@ -1698,8 +1697,7 @@ static void virt_build_smbios(VirtMachineState *vms)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name);
+    smbios_set_defaults("QEMU", product, mc->name);
 
     /* build the array of physical mem area from base_memmap */
     mem_array.address = vms->memmap[VIRT_MEM].base;
-- 
2.47.1


