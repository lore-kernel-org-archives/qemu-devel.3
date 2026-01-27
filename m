Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CAAD25939
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbS1-0006vc-AW; Tue, 27 Jan 2026 00:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRz-0006t5-Gg
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRx-0008NJ-Nh
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXSC3s03lHg3/fATZH9v66NS7KDKTjgOb+WvXAKQUM4=;
 b=ijgv0re5KFKTLUg2VErmfZOVXQWLBgrhOrCglGGyw7ZY8X6bFDHTgmj2urtw5tz9J4hhiT
 KjmvFEQMaHyXQ4gjkqRqmodSdJMn0T3anKlAI6hCTqzEn+leMLap5QsJSemo01FVTvgEVe
 k5so6l8BS5jCdh8nwE/Bx+JFVyvr2R4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-gzRjlQKpMUWAvIkhHKHpiw-1; Tue, 27 Jan 2026 00:17:11 -0500
X-MC-Unique: gzRjlQKpMUWAvIkhHKHpiw-1
X-Mimecast-MFC-AGG-ID: gzRjlQKpMUWAvIkhHKHpiw_1769491030
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34e5a9f0d6aso4699344a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491030; x=1770095830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXSC3s03lHg3/fATZH9v66NS7KDKTjgOb+WvXAKQUM4=;
 b=kXSXW1UNm6WFuiXvfof74xOjkhnI64PuyfqasabVc2ggPU8dxL2k0xrQXO3MASeBR/
 2Ac1djvYA8pWHkW2HPKSw0pD9m91LJsv1NQgs02/KwpkdnMTtdKeEiPTZ1bXK0bdyLG4
 0Ro40uSmx5ry/SWAWsCwC6H8fLEj2efP3WlnIID7jwtnBP8Tg4QWvFfYCRudjPB/bDwz
 pGSDM3QV5GBn1rUyUJ2wGbJ/dPsq1+OUAV9deKZhYxOfOBgFit2/ppsGDM/ShUH8dicu
 Mzku++rm6uWU267cDMhFO12wbdFzb8LpCZJ/liW1QyP4cDEcEEnb5z047e/BpNTUR+FP
 rBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491030; x=1770095830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vXSC3s03lHg3/fATZH9v66NS7KDKTjgOb+WvXAKQUM4=;
 b=SxufRi3DO75JR7hlizcR1N1BeijiiNNBsEUVZqUt7PiOz8mB5c3C6zrPoHiQWGyQ0P
 Nl2A99yWTppQMFOQUgchh8qtBO2lCA2uBSA2LT5xtyvA45GBAkX0NTL8zkiYLsmte/sE
 0TqIoFMpHcyJFWmuqr+I0bkDUChzgkpp5zl+PAiZeuhXGGmTvBBiNkHQvvu+mvwLTush
 XLsVXLGDeY/Pzl/UsHm7clZ544rPgZJSOjaK+lt7sudhKDlmzUK05HWZ3MFXg+m+NkTf
 2fh6uY/NRNcBgRK7Cae2Uq76Oc3525tN9yx0bH0xjqfksuTMZxi74O2eHpeXHf/Sm2ix
 1cDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKcTrO8EDGusvxZlza8TNKN1bGFUhj1u+6zYjquWjOUagMzRTnEM+Ij1QjqyDzHPkVengHum6Uni2c@nongnu.org
X-Gm-Message-State: AOJu0Ywf5yX5/4jIKz3BYNfbDhIeOcKlLQUz+OkPf/e9mfaY+lrQ7SpI
 mP6rnYhF7NmbH3eneT0RLPtkLJTOagQqI/vwJfkIDOpaU9JbbcClgtOZJ7kCQB94W5oI1q/xxxf
 9beQYkzB7kLtPtS8EGme2qzTqGrPbYAHxequ/PnoPt4An3zw3+4VBtxr1M+31A0/0
X-Gm-Gg: AZuq6aJNppZTpPpI3y7ULwVq7oC01eQRVwEkyqo08dtfQ4AYfGhIG3STyfiy/ZRh5Sp
 6i/hpOerq/RHigDV5w48x9kIs97bJ2tJR9Iwi5hGeMkaUm/XJcrLK0qxrIDeAwCUq1I3/ro65EV
 kiUE9/2G+kxf5tsxaiOQTYpQyCMEbl8xT7yjJ3rOlQYg1nR7T75eRhcfpIppw+37teS0Ryielsr
 cFV+FcAq9/2MzLsUm9Z8lgN5R99So7HCwg5l4kCSRZhPjKM6FwSKtmtgQCahA34tD4TxUYc80tt
 sKIzz/FvKFflr5LzV7PP3cFWD1Od79WUpk4QXKJ2B/uixp1/1AnPUXerMjZfIkWUz2fLLVAg7f+
 j6J9QEFnBcZTSC8w4vDe0c3T+g2/bJ8PI4CEw5PZylA==
X-Received: by 2002:a17:90b:28d0:b0:343:43bf:bcd7 with SMTP id
 98e67ed59e1d1-353ffb41134mr476683a91.13.1769491029742; 
 Mon, 26 Jan 2026 21:17:09 -0800 (PST)
X-Received: by 2002:a17:90b:28d0:b0:343:43bf:bcd7 with SMTP id
 98e67ed59e1d1-353ffb41134mr476669a91.13.1769491029367; 
 Mon, 26 Jan 2026 21:17:09 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:09 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 11/33] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Tue, 27 Jan 2026 10:45:39 +0530
Message-ID: <20260127051612.219475-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 hw/i386/x86-common.c  | 51 ++++++++++++++++++++++++++++++++-----------
 include/hw/i386/x86.h |  1 -
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c1c9224039..4469b4e152 100644
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
+    char *filename;
+
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
 
     if (!machine_require_guest_memfd(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
@@ -1084,9 +1112,6 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     memory_region_add_subregion(rom_memory,
                                 (uint32_t)(-bios_size),
                                 &x86ms->bios);
+    g_free(filename);
     return;
-
-bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
 }
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 0dffba95f9..bfdf97640d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -122,7 +122,6 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp);
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
-
 void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-- 
2.42.0


