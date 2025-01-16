Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B37CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRM7-00029q-Pi; Thu, 16 Jan 2025 10:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLy-000253-Bv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:15 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLw-00005l-QA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:14 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso6798625e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039611; x=1737644411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLP6MHIeVotcuU3w8Dkkpq3gJTXXHTzTWILY4ffGEXM=;
 b=RXZEbZEJ0bF1uCZh1deNL0hT2F/KcKZeMQlcOqvuppFaKMusP84z9q0FBBkx/9SQo+
 b/7I77yY7JBNsFd4V6aC2bqU4bI7Dh46t40OdGVcPs0TnyB7uVWuw7BtzHNsZtw8vKuV
 vF8PwcTwhsQJuGRMTxJ21l0zHAhgWmUPwUzkavr2r7rk60cXzvhNWqmAN0MhZ6icYC8N
 uIae8ZjxF0xyWR9zTIJrzEGvXkXdGGjAFpisPR3bpd9Jtnk+MWoZFgcCB8QqPyKnSnVm
 Atkzq8XtH2AXZdk0sUqpf2JznSzQ9o4J58CSIDNPHXTC4rIvGYVSTDJwOJ/MICjSiAgq
 w8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039611; x=1737644411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLP6MHIeVotcuU3w8Dkkpq3gJTXXHTzTWILY4ffGEXM=;
 b=RXp0Use/WfhL+d0r/pq+r0tEX71dti6oTcv129A1hMbxNoOdAF20V2FKHC55Bsjac/
 zFXb1EOioUudzc726YPwxpxx0TCiS6n+A9vbC1j6r+DFfiwxnXQ0NM9Xq8yndls3D5bW
 SVyMyHwNA+dQab88BHCBGg18kJdkwS4iMtGZYZu8MsW7M2srkQj50nRB2MbI/RkhOuJq
 +hbIiuRo1ZyA1gh5St2jDclm4K1NGhQL4ULuRv4luy5cvCLqdTLOPDro/GK+uA4fBF9/
 aIIlz6WY7qtSbpZsxvH58co1UCxxbvoPCKzYQ42IqBbqAEHckE79v86feAto3Un2XeM9
 yMMw==
X-Gm-Message-State: AOJu0YzA1UoteRZUzt4HdxWhFYAQAZ0UUyOpYLU4BpNZUA0HmJU0abwD
 enj0B5mgE3K3bx3qNKhCs/fISEonvJWoIvmDgtgdwrF/fOtV/uP3sCAKFc/UuDCsA+bA+BlaEIK
 zAg0=
X-Gm-Gg: ASbGncsNeEurWoSDWkLPhVgGe2oUUWTOHDII8US/ROKVqUjH4INkVt5uQgSRMLCkxmH
 FN84j4/rugTNnyomAtZhNsrObcAUco/w71Wyj6J8tE0e45zQ7PBGlLd3+BNFwU2hv4IUbMsQos3
 PEl6KW7/ce1orBj99mBAIGOs3rZ+8A8qvP4PWyt2AGYNS7WoxQTszIpaYsm2OAG50/flGhOamUu
 XI/GLtwzuvgQ6SJ8bzCdQDJKV34WS1dFXTmnCVJKEr9qGu72QPODJ+kHQZsLt9MHDmaKVP4GmE2
 89pPlE9RjAzbt8lweqvdijTSCYHcoQU=
X-Google-Smtp-Source: AGHT+IEgYDKRNJ2ZqmHOW+Uwb5j2NPJFWPziQeZT5yZXUNQYd2eOk4taK0ekUhtfYPEBQlrkO7wRDQ==
X-Received: by 2002:a05:600c:5115:b0:434:feb1:adae with SMTP id
 5b1f17b1804b1-436e266e823mr293591825e9.3.1737039610951; 
 Thu, 16 Jan 2025 07:00:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3282a63sm64775f8f.96.2025.01.16.07.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 05/13] hw/arm/virt: Remove
 VirtMachineClass::no_its field
Date: Thu, 16 Jan 2025 15:59:36 +0100
Message-ID: <20250116145944.38028-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The VirtMachineClass::no_its field was only used by
virt-2.7 machine, which got removed. Remove it and
simplify virt_instance_init() and virt_acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/arm/virt.h    |  1 -
 hw/arm/virt-acpi-build.c |  5 ++---
 hw/arm/virt.c            | 16 ++++++----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5d3b25509ff..463ac09615e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -117,7 +117,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool no_its;
     bool no_tcg_its;
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c9b13057a34..ccecea9e09b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -670,7 +670,6 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     const MemMapEntry *memmap = vms->memmap;
     AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -741,7 +740,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name() && !vmc->no_its) {
+        if (its_class_name()) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -974,7 +973,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name() && !vmc->no_its) {
+    if (its_class_name()) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eb27305dcd3..06530a5dbf8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3294,17 +3294,13 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    if (vmc->no_its) {
-        vms->its = false;
-    } else {
-        /* Default allows ITS instantiation */
-        vms->its = true;
+    /* Default allows ITS instantiation */
+    vms->its = true;
 
-        if (vmc->no_tcg_its) {
-            vms->tcg_its = false;
-        } else {
-            vms->tcg_its = true;
-        }
+    if (vmc->no_tcg_its) {
+        vms->tcg_its = false;
+    } else {
+        vms->tcg_its = true;
     }
 
     /* Default disallows iommu instantiation */
-- 
2.47.1


