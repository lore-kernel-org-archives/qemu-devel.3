Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E577FEDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9b-0007mQ-Ug; Thu, 12 Feb 2026 01:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9V-0007iu-NS
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9U-0005F5-6c
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3dHz72pMGOzBjOAKTFnNPZbVkxnwyGphMFnDiAHDeY=;
 b=eEpcAihmvQn9vsatnPAL6WiQDB5jCZA1JT+hcBsjh0DCLV+HSrHnv4OzjEBwNfB1eLUkez
 3SR9Sm3ePrSSXHahlSq5Q0a04TJk86aqiMJtT58vQRVBdJeug2D/HdpiDfAb3wgW7vLIwT
 M77EpEAU2UVVYXh2YQb0DNRq6Q/sBIE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-J74VAOXYN0SG7A_8_mZs9g-1; Thu, 12 Feb 2026 01:26:08 -0500
X-MC-Unique: J74VAOXYN0SG7A_8_mZs9g-1
X-Mimecast-MFC-AGG-ID: J74VAOXYN0SG7A_8_mZs9g_1770877567
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aad3380076so9723005ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877567; x=1771482367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3dHz72pMGOzBjOAKTFnNPZbVkxnwyGphMFnDiAHDeY=;
 b=pN1hHD+GGixSSXlb7ldv3gDUFrjxbO8df96AfJu6bgHlXxen6/72vIj2RvR0a+JuGN
 irs7ULS397LvDOL7Bvsbam+ldXVf9Pl8iQHjQRqOX5i4+qZw9n+O53wn82ZZRxzKo8/a
 9L2uudHT31P8L0plA/vszol50+nhm8FM2nPAtjyd6Lh8RSS3IdgEx/ZnAI4faEiccQxV
 19l540wTm2ZzFflal4+iqEDIR5YoTagruFNqU51Oo30g5/U9DzjUQyNhUhVC1cJWx37M
 h3kR6gEft6wkGDnSqJyTo/zDWt4wNADRe6L9N7Dd3M/DVS6K14WfoNO4J5KVFiB9ekFK
 ZOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877567; x=1771482367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3dHz72pMGOzBjOAKTFnNPZbVkxnwyGphMFnDiAHDeY=;
 b=Y8xmWT/D2mtgN6sevfnj//v5FDONl/rlFi2pckjcm9ldH5yIuRyFQKkGGN0psyaic+
 fvvYl82Vtpe4QCU8SPsowVEptdceD+zkD8ibPtZIqlpuN//B9Pqa2zZYGMcQVhZtgc5r
 ue2s223JGM7DFLFbDWaMxQ6g69GcqV3BS/1oybafZTkt+akJFLNdgUcPAwuOsJcZt3Xn
 5cSKiUmJy2zHLgkwpOA09xlbyta6qRaw0gpM8TDU/SKHXU/blZffTDuuk9DAFEKwzqVT
 2apHFgDvxo95VYuPdLgtdEAqofLFXBxFCOENDnVWMHNE6d4d0RKHlCR0JkzQYRu/EsE3
 beYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMwjvSpepAVat7KJLDv9SbH2wOZNE77ZwxZYpNq57jP8brrB/UKz+JhSbMKX2v0Gc/EhIWBPpb5Xob@nongnu.org
X-Gm-Message-State: AOJu0YzateeEFxm8+eLKL9RVB5h3htuqOyaHpd/Qz22D1Y66gXZXM4ia
 MvB9wL7zRRTKx10T+7Pf5OzFY1pPL/TiWt7QMiMGfKhRJy5i1BNBJK3gFC1d2iUd1Vqju4zbNL3
 XBqdW/aeN6qLifMBudvbwLKQMPMYRrDVoOTDmEuTrcm1GVBbcodwRjBNU
X-Gm-Gg: AZuq6aLBIuzU+CrIcjE1/2DOwyZ5SOQOGCYXX8bbQ5bonIKDM1AbNX4YLiddxf691OI
 PXmb8L05aZlcosLehJoep9HMHd6IRbMJHqH8tomPp9OWKDQljpVpNf8ljq8qqCev4OO7L4pLoiq
 P/IgdFXXxYlf4im4fD/pppxUMkNJ5tXtEkQEzmoghLNrjIvYJ4YlU1paN+x97vsLOIiaexT2kud
 EJEc8xGYw40csFvwQVX38MThr71CjjI60RBY8Du+Q6xMBqOw2w27VmRod3qevs9seClgP/dfR2O
 9WTqqVimUR3iYe+eYrSYNCAu2H0V9h1aDHB6SzDF4K86+7eBk7tjA+g0FnNjNVhFNQVC6PcswiO
 1bwPXjRMakJp8pGuJxlkw30dWbvfzpBnYy+BjMSXJHJf4gWuNQRo/I8A=
X-Received: by 2002:a17:90b:3a83:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-35692ca72fdmr1269136a91.10.1770877566933; 
 Wed, 11 Feb 2026 22:26:06 -0800 (PST)
X-Received: by 2002:a17:90b:3a83:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-35692ca72fdmr1269119a91.10.1770877566499; 
 Wed, 11 Feb 2026 22:26:06 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:06 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 10/31] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Thu, 12 Feb 2026 11:54:54 +0530
Message-ID: <20260212062522.99565-11-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

For confidential guests, bios image must be reinitialized upon reset. This
is because bios memory is encrypted and hence once the old confidential
kvm context is destroyed, it cannot be decrypted. It needs to be reinitilized.
In order to do that, this change refactors x86_bios_rom_init() code so that
parts of it can be called during confidential guest reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c1c9224039..18f2e2cfb9 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1024,17 +1024,11 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
     memory_region_set_readonly(isa_bios, read_only);
 }
 
-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+static int get_bios_size(X86MachineState *x86ms,
+                         const char *bios_name, char *filename)
 {
-    const char *bios_name;
-    char *filename;
     int bios_size;
-    ssize_t ret;
 
-    /* BIOS load */
-    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename, NULL);
     } else {
@@ -1044,6 +1038,21 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
+
+    return bios_size;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
+                                char *filename, int bios_size,
+                                bool isapc_ram_fw)
+{
+    ssize_t ret;
+
+    /* BIOS load */
     if (machine_require_guest_memfd(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
@@ -1072,7 +1081,26 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
             goto bios_error;
         }
     }
-    g_free(filename);
+
+    return;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+{
+    int bios_size;
+    const char *bios_name;
+    g_autofree char *filename;
+
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
 
     if (!machine_require_guest_memfd(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
@@ -1085,8 +1113,4 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                                 (uint32_t)(-bios_size),
                                 &x86ms->bios);
     return;
-
-bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
 }
-- 
2.42.0


