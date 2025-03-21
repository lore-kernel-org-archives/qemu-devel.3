Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC185C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEQ-0002P8-GR; Fri, 21 Mar 2025 14:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEL-0002CQ-FI
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEJ-00072q-Fn
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFRuN/PFPVxX94u+Hzbmt9NAGJi6Ilk0kcnMUquL6Qs=;
 b=aWWW0wVDPhDBJ1h+Am220U4r2yHUPXImS6bG9g2zihYV1jENWfO/gNV1Dd3E/iyBWnuVoK
 l2XyPpQiLQ1DZbCTTh6LcPXqpjBqarPXax6laqyllQUDqqvBX7wFmn0R6ZWKgRQ4w1sBb3
 W31KMICGM8KZSJBKA8XefQTFoi7Uuh8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ouCX0_8ZNcGbvSaagCP_HQ-1; Fri, 21 Mar 2025 14:36:25 -0400
X-MC-Unique: ouCX0_8ZNcGbvSaagCP_HQ-1
X-Mimecast-MFC-AGG-ID: ouCX0_8ZNcGbvSaagCP_HQ_1742582184
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac3db5469fbso177395066b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582183; x=1743186983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFRuN/PFPVxX94u+Hzbmt9NAGJi6Ilk0kcnMUquL6Qs=;
 b=I+FCEPYNYuHLpdTBi2ENaE4BXeGkABATkG+TvZu/sM50p9xLjGBf7KfcYxSRP7VNg0
 RYria92gbQOoS/cs8AyciIu1SnPyRZ4pEsPb9hj8o66ehOd6jfdcHDDoZyAEXyfS9NoW
 OBLWZhiUcDU2W5vLZdmz1uOMQldQarG6wM0WpMqNrBZ0l+AdcpayNsB3YDOfaNpayOhw
 EoDdun8gXPsZenVpnV7buastOuaY/OnpyMNIDWpsjjmoKRh5rl5V0RtekoZBjgRoMWwo
 o4mopd9WhsjOnzs/ZNZ9vqJNpn6VneDZd1b9EkY2GnTlOK939lhb4RVY3b84FNL146J3
 K1mQ==
X-Gm-Message-State: AOJu0Yzo0fM7zTRnycoXPPb36WA+EaYc5j/HLW0sCzg/gv3J5jkeAtM9
 E07B3VcQAdnQjZeDLypkROiFULibtH11y6XpZlA4pu/lN00sx83uFsgQOj97zoLQBfRoLJCZMrw
 7NfZt/o3MiIhZ3zPBswwTfWcIWMr4fjvJOhwZHglY0mtSplImJ0weptHdbUxCP95YchyRsQJQjW
 FXPZ4ZkGuVk0yVzzPGVNRX9wRd1BjUKdrsPA+6
X-Gm-Gg: ASbGnct0gL6vYGy83ilAF207txHmoLChNhXRuAMaYuwArcsv/WQhWriKtVULIbPiqER
 LLDQ1SU2QLSOsEguZZQ2GzC8IqUij/TmAS/6BqsNjpNFuUI1kjMxnk/8jyTX4jUzCEF51atRCdD
 6cn5Ke4yNVi97OLULa8IVvf1GZldsM8RGJmyw3kPyMmAuk3wXpMT3elQIOMKrUxpaoYd54IW5zN
 UhiICN6Qot4yp7z3AwBr7jAH6CbTgSCf1ydy5YYhROQzlmHZCFxqOGATeTztuLr8Gl4KtW7czCh
 VeL6UV7c2PWbKfwSXfaw
X-Received: by 2002:a17:907:1b2a:b0:ac3:c2eb:bd66 with SMTP id
 a640c23a62f3a-ac3f2273481mr503210366b.23.1742582182954; 
 Fri, 21 Mar 2025 11:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa9IgGJHQz9iQ+QdQGJLTsxMfUK5p/UA/0DHZpcL6IZcUW0E3j0mN830bCe1/30yEhzPwyeg==
X-Received: by 2002:a17:907:1b2a:b0:ac3:c2eb:bd66 with SMTP id
 a640c23a62f3a-ac3f2273481mr503205966b.23.1742582182430; 
 Fri, 21 Mar 2025 11:36:22 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef8676c2sm193538566b.9.2025.03.21.11.36.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/24] load_aout: replace bswap_needed with big_endian
Date: Fri, 21 Mar 2025 19:35:39 +0100
Message-ID: <20250321183556.155097-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Targets know whether they are big-endian more than they know if
the endianness is different from the host: the former is mostly
a constant, at least in machine creation code, while the latter
has to be computed with TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN or
something like that.

load_aout, however, takes a "bswap_needed" argument.  Replace
it with a "big_endian" argument; even though all users are
big-endian, it is cheap enough to keep the optional swapping
functionality even for little-endian boards.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/loader.h   | 2 +-
 hw/core/loader.c      | 4 ++--
 hw/ppc/mac_newworld.c | 7 +------
 hw/ppc/mac_oldworld.c | 7 +------
 hw/sparc/sun4m.c      | 9 +--------
 hw/sparc64/sun4u.c    | 9 +--------
 6 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 784a93d6c17..d280dc33e96 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -190,7 +190,7 @@ ssize_t load_elf(const char *filename,
 void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
 
 ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
-                  int bswap_needed, hwaddr target_page_size);
+                  bool big_endian, hwaddr target_page_size);
 
 #define LOAD_UIMAGE_LOADADDR_INVALID (-1)
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index ce6ff1b52e3..2e35f0aa905 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -226,7 +226,7 @@ static void bswap_ahdr(struct exec *e)
 
 
 ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
-                  int bswap_needed, hwaddr target_page_size)
+                  bool big_endian, hwaddr target_page_size)
 {
     int fd;
     ssize_t size, ret;
@@ -241,7 +241,7 @@ ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
     if (size < 0)
         goto fail;
 
-    if (bswap_needed) {
+    if (big_endian != HOST_BIG_ENDIAN) {
         bswap_ahdr(&e);
     }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab482..2d5309d6f55 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -197,11 +197,6 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     if (machine->kernel_filename) {
-        int bswap_needed = 0;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#endif
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
@@ -209,7 +204,7 @@ static void ppc_core99_init(MachineState *machine)
         if (kernel_size < 0) {
             kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     machine->ram_size - kernel_base,
-                                    bswap_needed, TARGET_PAGE_SIZE);
+                                    true, TARGET_PAGE_SIZE);
         }
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(machine->kernel_filename,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0dbcea035c3..b5814690f5a 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -153,11 +153,6 @@ static void ppc_heathrow_init(MachineState *machine)
     }
 
     if (machine->kernel_filename) {
-        int bswap_needed = 0;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#endif
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
@@ -165,7 +160,7 @@ static void ppc_heathrow_init(MachineState *machine)
         if (kernel_size < 0) {
             kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     machine->ram_size - kernel_base,
-                                    bswap_needed, TARGET_PAGE_SIZE);
+                                    true, TARGET_PAGE_SIZE);
         }
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(machine->kernel_filename,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a48d3622c5a..5aaafb40dac 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -233,20 +233,13 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
 
     kernel_size = 0;
     if (linux_boot) {
-        int bswap_needed;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#else
-        bswap_needed = 0;
-#endif
         kernel_size = load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
                                NULL, NULL, NULL, NULL,
                                ELFDATA2MSB, EM_SPARC, 0, 0);
         if (kernel_size < 0)
             kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
-                                    RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
+                                    RAM_size - KERNEL_LOAD_ADDR, true,
                                     TARGET_PAGE_SIZE);
         if (kernel_size < 0)
             kernel_size = load_image_targphys(kernel_filename,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8ab5cf0461f..d3cb7270ff5 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -168,13 +168,6 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
 
     kernel_size = 0;
     if (linux_boot) {
-        int bswap_needed;
-
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#else
-        bswap_needed = 0;
-#endif
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, kernel_entry,
                                kernel_addr, &kernel_top, NULL,
                                ELFDATA2MSB, EM_SPARCV9, 0, 0);
@@ -182,7 +175,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
             *kernel_addr = KERNEL_LOAD_ADDR;
             *kernel_entry = KERNEL_LOAD_ADDR;
             kernel_size = load_aout(kernel_filename, KERNEL_LOAD_ADDR,
-                                    RAM_size - KERNEL_LOAD_ADDR, bswap_needed,
+                                    RAM_size - KERNEL_LOAD_ADDR, true,
                                     TARGET_PAGE_SIZE);
         }
         if (kernel_size < 0) {
-- 
2.49.0


