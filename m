Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB534C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwm-0006MH-Dn; Tue, 04 Jun 2024 02:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvm-0004Yl-Qc
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvk-0007ci-SB
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bt9EMAvb2uqqlG2EVvh0go+BINiKLQvUIsp6j0IIbQ=;
 b=RRLpxGdGoYEraUWprkwGdxZuSjWRN7HnG6fdhVeReie4DhKCL7m1N2Uam9gIGZ3c7wnH+Z
 pneZN4QAmTadgUWWRKVPPIPP4UuFzsooLGVms9EJzZizgR6EEyP+xTTfg99NPFyou/W7hy
 VX+7bWBQj299SWWkHHoY2r8Y/MCle7o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Q_ngoZHJOIyKbhFsJP2nVQ-1; Tue, 04 Jun 2024 02:45:52 -0400
X-MC-Unique: Q_ngoZHJOIyKbhFsJP2nVQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52b950b3dc7so2001850e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483551; x=1718088351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bt9EMAvb2uqqlG2EVvh0go+BINiKLQvUIsp6j0IIbQ=;
 b=MOVxU4gdg6NH2c6VaA/4EtynysBeTYVX+hAPV0xAhUasQQJ1HPwwiHtsyQNz2kzV69
 VMJZGiYXBj1S92+GvGar4NIw8BBC4qUlZ6IkCHZsXI666FYRZ3Gb099C4mFFRQVajnaP
 6Wd0Jm8k7bLbkfJdNkYPOFcXUo6uUtKI0tBngQ7NEuY1t9isW0WcYGS+3qcr0HD5+wbF
 AbDQ8joo17uwxaNa4U7oz3xRT1rgeLUg6DgLLcmzv0zdCMr9gyNTfDYapw7yp9FRqQ0p
 8k0OIVFZOqs/Rek9XpWbIWFYrjThTjEkDRqlqM6voObY3WhoXdTkDnWpLn2E+3bWCBdv
 kXJw==
X-Gm-Message-State: AOJu0Yzc3tWUdJGSO3w5L3RnH/gR3I+zhm5A4W4SEp2uA2pj1NvxXGMa
 63C4wlNDJ5Jnu8quSiX9N9Q+vUJaPN+MvU+3HJpQsgfmqZ21Koean1kv2vyuTm9cOSZ2zIIEXKD
 kzvUWXhGMSF/WVz8LBtoyH06D+Du9M1hlzx8tq0lNspjgcSK2W8vMmGRILK1Zu4aa6M+aR7wYDY
 uDd1AIXiDoLSNmXvgOTzk6CzhZMnXPa42Rop6l
X-Received: by 2002:a19:2d1b:0:b0:52b:8c88:2d73 with SMTP id
 2adb3069b0e04-52b8c882e43mr7124679e87.52.1717483550811; 
 Mon, 03 Jun 2024 23:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbRr9D2dml/HvZIidIMaZJD6E+zQe2s0UM/Pv4pblvRIT+bBNC3JoJAXdOHQwA2XV0XBB7GA==
X-Received: by 2002:a19:2d1b:0:b0:52b:8c88:2d73 with SMTP id
 2adb3069b0e04-52b8c882e43mr7124665e87.52.1717483550382; 
 Mon, 03 Jun 2024 23:45:50 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ce1e4462sm394866466b.197.2024.06.03.23.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 35/45] hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is
 enabled
Date: Tue,  4 Jun 2024 08:43:59 +0200
Message-ID: <20240604064409.957105-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Brijesh Singh <brijesh.singh@amd.com>

As with SEV, an SNP guest requires that the BIOS be part of the initial
encrypted/measured guest payload. Extend sev_encrypt_flash() to handle
the SNP case and plumb through the GPA of the BIOS location since this
is needed for SNP.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-25-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/x86.h         |  2 +-
 target/i386/sev.h             |  2 +-
 hw/i386/pc_sysfw.c            | 12 +++++++-----
 hw/i386/x86-common.c          |  2 +-
 target/i386/sev-sysemu-stub.c |  2 +-
 target/i386/sev.c             |  5 +++--
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index b006f16b8d3..d43cb3908e6 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -154,6 +154,6 @@ void ioapic_init_gsi(GSIState *gsi_state, Object *parent);
 DeviceState *ioapic_init_secondary(GSIState *gsi_state);
 
 /* pc_sysfw.c */
-void x86_firmware_configure(void *ptr, int size);
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size);
 
 #endif
diff --git a/target/i386/sev.h b/target/i386/sev.h
index cc12824dd65..858005a119c 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -59,7 +59,7 @@ uint32_t sev_get_cbit_position(void);
 uint32_t sev_get_reduced_phys_bits(void);
 bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
 
-int sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp);
+int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);
 int sev_inject_launch_secret(const char *hdr, const char *secret,
                              uint64_t gpa, Error **errp);
 
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 9b8671c4412..7cdbafc8d22 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -148,6 +148,8 @@ static void pc_system_flash_map(PCMachineState *pcms,
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
+        hwaddr gpa;
+
         system_flash = pcms->flash[i];
         blk = pflash_cfi01_get_blk(system_flash);
         if (!blk) {
@@ -177,11 +179,11 @@ static void pc_system_flash_map(PCMachineState *pcms,
         }
 
         total_size += size;
+        gpa = 0x100000000ULL - total_size; /* where the flash is mapped */
         qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
                              size / FLASH_SECTOR_SIZE);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(system_flash), &error_fatal);
-        sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
-                        0x100000000ULL - total_size);
+        sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0, gpa);
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
@@ -196,7 +198,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
             if (sev_enabled()) {
                 flash_ptr = memory_region_get_ram_ptr(flash_mem);
                 flash_size = memory_region_size(flash_mem);
-                x86_firmware_configure(flash_ptr, flash_size);
+                x86_firmware_configure(gpa, flash_ptr, flash_size);
             }
         }
     }
@@ -249,7 +251,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     pc_system_flash_cleanup_unused(pcms);
 }
 
-void x86_firmware_configure(void *ptr, int size)
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
 {
     int ret;
 
@@ -270,6 +272,6 @@ void x86_firmware_configure(void *ptr, int size)
             exit(1);
         }
 
-        sev_encrypt_flash(ptr, size, &error_fatal);
+        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
     }
 }
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index ee9046d9a80..f41cb0a6a8b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1013,7 +1013,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
          */
         void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
         load_image_size(filename, ptr, bios_size);
-        x86_firmware_configure(ptr, bios_size);
+        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
     } else {
         memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
diff --git a/target/i386/sev-sysemu-stub.c b/target/i386/sev-sysemu-stub.c
index fc1c57c4113..d5bf886e799 100644
--- a/target/i386/sev-sysemu-stub.c
+++ b/target/i386/sev-sysemu-stub.c
@@ -42,7 +42,7 @@ void qmp_sev_inject_launch_secret(const char *packet_header, const char *secret,
     error_setg(errp, "SEV is not available in this QEMU");
 }
 
-int sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
+int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
     g_assert_not_reached();
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 06401f0526f..7b5c4b4874d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1484,7 +1484,7 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 }
 
 int
-sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
+sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
@@ -1841,7 +1841,8 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     /* zero the excess data so the measurement can be reliably calculated */
     memset(padded_ht->padding, 0, sizeof(padded_ht->padding));
 
-    if (sev_encrypt_flash((uint8_t *)padded_ht, sizeof(*padded_ht), errp) < 0) {
+    if (sev_encrypt_flash(area->base, (uint8_t *)padded_ht,
+                          sizeof(*padded_ht), errp) < 0) {
         ret = false;
     }
 
-- 
2.45.1


