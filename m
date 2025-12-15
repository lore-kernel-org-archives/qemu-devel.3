Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1378D5B86E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYr-0006h8-4F; Mon, 15 Dec 2025 15:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYQ-0006KQ-7s
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYO-0005pq-3i
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JnMxtrXTusXMIXSRjsHu7VxCqHT0zBV4fsUGeGwSgkQ=;
 b=eDEHr8UhMiOCGy9HVOtkLa568KU+aZDb2m06riB1gRFKr+QO3tcZ+e/qkuvKA7VC7MfGCA
 OJgK8oADJ+9IhYPMAxD1nEZMQ77RzpKOsX8YojY9mwlisYrhx0ZUeOYay+HRW1ig18wZZe
 AaJ69O+r/d3LtUwj+sS/b0+XTOnsKbE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-xOFcFoHeM06gmoiraHEPSQ-1; Mon, 15 Dec 2025 15:52:22 -0500
X-MC-Unique: xOFcFoHeM06gmoiraHEPSQ-1
X-Mimecast-MFC-AGG-ID: xOFcFoHeM06gmoiraHEPSQ_1765831942
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a3356a310so44021206d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831941; x=1766436741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnMxtrXTusXMIXSRjsHu7VxCqHT0zBV4fsUGeGwSgkQ=;
 b=N4rr5RQajsueO6oxhheyafh30BvZcaLsAAKAMzXnoS+HSHKuXoJgndFyRN+mcdGDMX
 fu1KY2+lYFWIkzZPJ4eyNsYmIuNQ2aaApToJjvP5FcxxCRNUHGyU+vznLtdEHlRCb9nK
 erF4ngPgiKt1KLMGY8/KZnFbCT4+obFSyZs0oF5izvOiMMftnUPwP2E39X3oJzOLJNO2
 B3BOUoX3kz//yx3l/EvH7Oq64vP8EQLE7N3IMOn4jrVQN5BrpDHja/0YbZ0fbeHy8TKR
 cw9ONBf46ZZCm6p5r0IZIpgYR5NKhIRtVxDncjLI1/eo393GSMD/UWI9XCeBSyFKtUZc
 f9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831941; x=1766436741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JnMxtrXTusXMIXSRjsHu7VxCqHT0zBV4fsUGeGwSgkQ=;
 b=C1fUIU4SkptxTrbNyXGGf0dAyncT8/+8yUHkAqWxiPp1u5TUpLG2OSGJFoSiOeSGb6
 Mpey97rPaOSpP8K1jyiJflMjU6Joxd5b2bIwffLMn8o3ybSnUBphFxC8aWoSau/PaYtL
 IN7vb+G54ltHKjlgULU7YCEAlXIVhgN8hlJlUvGZFioeoSWSVWS2cr/9vLT/nvnVre2/
 dEmm77LWd/SYxgjDIlpZ+tbJQ9dOTP6dEY2Is5uCA0+TdarVl/uF1pGKdA6NnceGxdhf
 pPG9xWKES8ibpudjnjanoqbrAl6Au1CFiXuajkWmdXSUlHsa0zNguESFsKf/n8ezKQZU
 FuRA==
X-Gm-Message-State: AOJu0YwbkshF2Tv0l8H1wiYarVJAOoIBYm6bdi8ZMavUvGqF4DWtloNY
 u+LEnwUq5ntDWgetNgPTS+GJkiXqzrjmU16hhwQBmHhOzvz+Ccqdk+ifBreZ+SNaci8/aXzTEEc
 oqPpwbfY6lyW1nrLOsMB+VpWvtn1aTLi19ifxhKKNOdpF/YA4SRKAH1QDkGzCnhuhCVO6lX5i2J
 XO9n+nLovF7Sbh8YU/R5gVqlDbg5poQvl2To1jyQ==
X-Gm-Gg: AY/fxX6VoPLsSGuZmQRcPNs2Ogo/g95sKJeeQXs9E4iSR7kdNahLr8j3e4Hbi42pIKW
 3TAaDAeFB4NYdBC8j3YDr6zhNG5h4o5mgkt8hgFM+9kHGdSg27Sfh3H4o+9gc3Abgt/9R3WPLHW
 vn/1d0k4uCALorCdgJHaG/W7PrqUmPxT3+GZJsIRNgPo0KW3pINexVqGGzn7VgtQd/Ly+rFx24S
 NhH7Cp3TvyEhiC3XMFpZNCDwx9oj2plGTcvvgy7/ejW8p4tccSse8uVPEpnB2r0X/7quXkeGsx1
 GzrMsnO0k2XBfzWAAZ5OzxTlh+mSjp82wClDEEcfR1Hg1NWANvjnhVMY8Ya1i3/+BvqJzQpGoYK
 F
X-Received: by 2002:a05:6214:5bc6:b0:882:3bc7:1909 with SMTP id
 6a1803df08f44-8887e0fd8dfmr173823336d6.37.1765831941429; 
 Mon, 15 Dec 2025 12:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtC2B1Bs+WJtJ64cYFnO/hAfp9LsJnsdyV8d0bJxMXIFybc8OnE4R7KhEcp1u29oA52MWTIg==
X-Received: by 2002:a05:6214:5bc6:b0:882:3bc7:1909 with SMTP id
 6a1803df08f44-8887e0fd8dfmr173822966d6.37.1765831940959; 
 Mon, 15 Dec 2025 12:52:20 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 10/12] memory: Rename memory_region_init_ram_guest_memfd()
 to *_private()
Date: Mon, 15 Dec 2025 15:52:01 -0500
Message-ID: <20251215205203.1185099-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Differenciate it from fully shared guest-memfd use cases.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 10 +++++-----
 backends/igvm.c         |  4 ++--
 hw/i386/pc.c            |  4 ++--
 hw/i386/pc_sysfw.c      |  4 ++--
 hw/i386/x86-common.c    |  4 ++--
 system/memory.c         | 10 +++++-----
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 9b58303bb8..b3d000a563 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1693,11 +1693,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
-                                        Object *owner,
-                                        const char *name,
-                                        uint64_t size,
-                                        Error **errp);
+bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
+                                                Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp);
 
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
diff --git a/backends/igvm.c b/backends/igvm.c
index 905bd8d989..91631829e5 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -221,8 +221,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             g_strdup_printf("igvm.%X", region_identifier);
         igvm_pages = g_new0(MemoryRegion, 1);
         if (ctx->cgs && ctx->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
-                                                    region_name, size, errp)) {
+            if (!memory_region_init_ram_guest_memfd_private(
+                    igvm_pages, NULL, region_name, size, errp)) {
                 return NULL;
             }
         } else {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2d55ceb5e..41dfbbdcf0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -963,8 +963,8 @@ void pc_memory_init(PCMachineState *pcms,
     if (!is_tdx_vm()) {
         option_rom_mr = g_malloc(sizeof(*option_rom_mr));
         if (machine_require_guest_memfd_private(machine)) {
-            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
-                                            PC_ROM_SIZE, &error_fatal);
+            memory_region_init_ram_guest_memfd_private(
+                option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE, &error_fatal);
         } else {
             memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                                 &error_fatal);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1c37258654..ad55d4eba6 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -53,8 +53,8 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
     if (machine_require_guest_memfd_private(MACHINE(pcms))) {
-        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
-                                           isa_bios_size, &error_fatal);
+        memory_region_init_ram_guest_memfd_private(
+            isa_bios, NULL, "isa-bios", isa_bios_size, &error_fatal);
     } else {
         memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                                &error_fatal);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 33ac7fb6e9..27854a9164 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1045,8 +1045,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         goto bios_error;
     }
     if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
-                                           bios_size, &error_fatal);
+        memory_region_init_ram_guest_memfd_private(
+            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
         if (is_tdx_vm()) {
             tdx_set_tdvf_region(&x86ms->bios);
         }
diff --git a/system/memory.c b/system/memory.c
index d70968c966..28810dcb29 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3746,11 +3746,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
     return true;
 }
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
-                                        Object *owner,
-                                        const char *name,
-                                        uint64_t size,
-                                        Error **errp)
+bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
+                                                Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp)
 {
     DeviceState *owner_dev;
 
-- 
2.50.1


