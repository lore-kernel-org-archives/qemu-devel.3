Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAEACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0Y-0002Zf-Fz; Wed, 30 Sep 2026 11:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0S-0002Ub-Ma
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0Q-0000j6-2y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4WCzyxeLEnqop8Uya3q9OBPLKDNbeEY9ZKJooArDxM=;
 b=gBxTlWj5s8reBG8iaYHElHpuvH4RkeLMPjIuTKyD/LBmyXbZ3Hyh/uUh2MTE5CSzhLSmz1
 7eL3LHs6fzQHMaw+ymvQkLCb7yxXtqtPqL5zv0u2M92haWPRxp8G6WIGpr0yiL8Sle+wls
 AENQrez01XUGrIL+RxsmS5iSEoZ1QCg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-49Ha1vakMFGFizvQMp_wsg-1; Wed, 30 Sep 2026 11:13:59 -0400
X-MC-Unique: 49Ha1vakMFGFizvQMp_wsg-1
X-Mimecast-MFC-AGG-ID: 49Ha1vakMFGFizvQMp_wsg_1790781239
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so376316685a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781239; x=1791386039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J4WCzyxeLEnqop8Uya3q9OBPLKDNbeEY9ZKJooArDxM=;
 b=EKNMT/hXsWpeDh9ZtCG8Vg7PCcrxx0w5nlJJJMZzFvaaXD+OHD6no6lRWk/PWEObmQ
 tjRkPOeBaUMlEXZA4dUiHPESgOafhzdPPJVUdhhf3tK/TVdBYykMiWej00U2x6HnCR8p
 w5pebUPiElJkusBULANBA/JdDwNFoqQ3W5cKckl2dzV4Kwcl1KFSW01zk/67nAvXuAFo
 TybtCH9dm0DZLx921l0ZqncgaejdNg2tFN7hvOXmVJphbxLfJOf1uHzst4v9j20mJguR
 E4CquleBQdeePeIeR6xPcGdkiEds0VkUCMIruLkfOtNkwj5mZH3pWk4bsmAQ0PUwYmuf
 TJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781239; x=1791386039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J4WCzyxeLEnqop8Uya3q9OBPLKDNbeEY9ZKJooArDxM=;
 b=JL4jQPF2yYWhhLY9sPVAPwALVgue8YwP/FyhjnStrUoWzUqg5CNn2hBIf+MkYumZl1
 +ujbR7ieOe2aRdo94v1w4umCxwJIjtrQYRm17DCyOZCax4WoboVw15RR49RXne+95UBm
 2cvAqi91v9ok4e9Vixr6lImn9lOZeYM0tdCYls3yagQZTxicggdsTZVWm+fr0AiqNL/z
 WzhJAwA/JX7AG0exzP8OGj5gOWwDy2NbqhklwbGfhqrBDO/mupt6xDrZsLzsOWob9Sa2
 QKhdv2tLjuGSNdsSEaR2AsFvr5SmzmBh5imJOSZb4Ulu+CD2n91eAxoXe8exVGj95EIq
 B38A==
X-Gm-Message-State: AFuF++kzo6MM88YdIE+UHteunFr2STgX+JN8iifzfA88IpXDUN562vkd
 YuzgpM1yEkksw1XY1eidpezbdaCu2FOJ2IlLyy5gSmsExVu6NUl1ETOQZycYVuWmMlwXI5oa0QT
 LzfH1x/Ohm/yMVZbPUJ5paSd7Lo3tL3NXeyduNgAMF2gJe+jPxj85xVCxGak5GbsP3vxtxxdEbg
 lq2lW07OJSG3n252F4GU6DYTWh5QSoQQ2fNplKoP5d
X-Gm-Gg: AYBFou3AcN7Xs5l/uV18YCR7aKfXmrLC675Ou/4WcMC60n7gaAk/aQRM176C8LyCh9+
 SXonQWocLKso1Qeyc2swmr9z57ucxgBt5cxAOlfvtIdHKHIdN1KbTZQfA/qNSMpuvJxq6bNVfvf
 xjOz2iegmIc1ApNB2hKTmfBAAa7wBMa0l86+UVrpLpG0d+DsLjSVwmDWljwc6NW2S8ysp8XSwba
 5FD3Su4GrRAunj1YZy7Hb4+osvLBifKfdrECEu7cA8ByRN7XUDOVMlGQnxLUv1gKzuVGfLfduKf
 cJjPTu8Nx7N5X4fEl15sEbALpGUug8gIAKvDZLva56GGQNUWJj7XF7jTwnk9PMOCqoH9jqg=
X-Received: by 2002:a05:620a:298c:b0:93c:5ff3:2248 with SMTP id
 af79cd13be357-93ca9a65272mr254587585a.14.1790781238624; 
 Wed, 30 Sep 2026 08:13:58 -0700 (PDT)
X-Received: by 2002:a05:620a:298c:b0:93c:5ff3:2248 with SMTP id
 af79cd13be357-93ca9a65272mr254578185a.14.1790781237773; 
 Wed, 30 Sep 2026 08:13:57 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca82d36c4sm137695385a.29.2026.09.30.08.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 09/12] memory: Rename memory_region_init_ram_guest_memfd() to
 *_private()
Date: Wed, 30 Sep 2026 11:13:37 -0400
Message-ID: <20260930151340.2817042-10-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Differentiate it from fully shared guest-memfd use cases.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-10-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 10 +++++-----
 backends/igvm.c         |  4 ++--
 hw/i386/pc.c            |  4 ++--
 hw/i386/pc_sysfw.c      |  4 ++--
 hw/i386/x86-common.c    |  4 ++--
 system/memory.c         |  8 +++++---
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 96ab920e7d..027ca81bd2 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1358,11 +1358,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
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
index ec7bee428b..58f3097e85 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -291,8 +291,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
         imr->mr = g_new0(MemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
-                                                    region_name, size, errp)) {
+            if (!memory_region_init_ram_guest_memfd_private(
+                    imr->mr, NULL, region_name, size, errp)) {
                 g_free(imr->mr);
                 g_free(imr);
                 return NULL;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2fd90fa739..1ae0c4f614 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -874,8 +874,8 @@ void pc_memory_init(PCMachineState *pcms,
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
index b6a56ef1fd..6ff0b9baae 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -52,8 +52,8 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
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
index 59e92b1a1b..fa18bf1aec 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1037,8 +1037,8 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
 
     /* BIOS load */
     if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
-                                           bios_size, &error_fatal);
+        memory_region_init_ram_guest_memfd_private(
+            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
         if (is_tdx_vm()) {
             tdx_set_tdvf_region(&x86ms->bios);
         }
diff --git a/system/memory.c b/system/memory.c
index fa0a2cf563..f1910af8a0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3592,9 +3592,11 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
     return true;
 }
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
-                                        const char *name, uint64_t size,
-                                        Error **errp)
+bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
+                                                Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp)
 {
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
                                                 RAM_GUEST_MEMFD_PRIVATE, errp)) {
-- 
2.55.0


