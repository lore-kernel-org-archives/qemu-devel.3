Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A12C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuI-0003XA-Dr; Mon, 12 Jan 2026 08:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtm-0002yY-CP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtk-0003kb-Jn
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ee0IX6hHvccl+8/XECntlTv5CCz3pvXb+gKT8FpLR4Y=;
 b=h2xYiHp4XyfVAVBvRt6/nyYwrsyM9xZUaOElmByZSl629nUpvMYPBWIo8rai2rW0cqmDWQ
 5wskM5WqNxRRzdbQRGvFUQtwMWpsdoKgY9KUM6v3rE5EdKXYIm2OJ8kid0PZU9cdOCStTc
 N0TkO1kQVKkyNvE4j37j3/wlgOxuDeI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-wO_3CC98OcOHm8MD0GoYwA-1; Mon, 12 Jan 2026 08:23:54 -0500
X-MC-Unique: wO_3CC98OcOHm8MD0GoYwA-1
X-Mimecast-MFC-AGG-ID: wO_3CC98OcOHm8MD0GoYwA_1768224233
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-81f53036ac9so743074b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224233; x=1768829033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ee0IX6hHvccl+8/XECntlTv5CCz3pvXb+gKT8FpLR4Y=;
 b=O173YkY4qy/61e7Y1CQbGejMWKXa/WSmOdafLN5iqd4aOxR4RT1UVLO4PXCJqxiyax
 ktFiPD7l7b/FPAigVa+cybEU+M9qvjbAcKdBJujq5ERwzjMIAqYLF8dzxcU4VLsjHQJN
 3uSTwgBAILebqDQn2DUY31f6Cobx2LTiGaiwcwF9bYxTjc6W5PalNp6nzqsSKQ6NmoPs
 8bfDyc/URB0FPptQcnXx1ldEE1L5sAlNRAMGtL/Ny4Snuczeo3uzP/C4G3WyuXp7f4FJ
 p+cKWbteGsVSybDCv4WY2suyku/qVanuF950ukf3+nnH0rLkndwyKaqyajgg1gGvwomt
 Us4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224233; x=1768829033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ee0IX6hHvccl+8/XECntlTv5CCz3pvXb+gKT8FpLR4Y=;
 b=tcdfyA97v8oqkui3MeMfB587KLRwgtzhFVhoo+hB4TQ+qSKaVhtqg3xS0GUr9tn1Ex
 rXT0EB+XzeTo+ekuyP/wvYf9hpf0dmYrNndC2siCkZGS9eka4+5vwT1KHYapGfz/8rcp
 Q4m0cVWpw6AJ9W6fRRNKq7wPXmUsz4+WDsJ8modQ7HP/KV7kMI0LeX/mI/ZlexDH9I7/
 yar1WmgdnSK7dcs0EdevBM6du9Uny+LYXj/rfrZSieFS5GPziKeRdRDW3G4edA6ucitk
 4jAYz/l6juvRDzLGh7384e2x5tfIX+5k44h+ASE+bXs1eKpLMYcJSd58EnowNclzpbT1
 Yckw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Nz4J7xpDET7liUaH9iAS9Tl/ol+wTHeexORYRsyhcE8wo3nHiiHLOgKq8CAqXmkgYpU61lNirTpb@nongnu.org
X-Gm-Message-State: AOJu0YwQox87hmsjlRBda2TfrEdniBlMuvRxFh2fL4lXYNMHS+1D/8xE
 kfWK1yMpzNgpS4sYd1HLD/HdBcXgT4vvJ7Kh+amJTpV/u21BF9FB93liE+e+bDk2Km5wtn7OG4I
 qOEgEFaoO0FbAE+gTT5Kgo1JVW07uv+laiPhR3lwQHLPPb92OCFmadS7c
X-Gm-Gg: AY/fxX6HqjqLl45N4ZnMKtFEc1b00TdPLcOjU8zQ8evmKgYu657gMt3MjhGhO8HL5D/
 yfz3jPKMF1AtrL6+BU1mqBrwIbTZW4TKoQ739ANrQlKnDhxkpJsclFGXewllj6dSU0d0cwVa8f3
 SljXWepmTXeNTxPhQ2zb8INawnsp8+yPxR0zvgL+o27qpHOGLgVC+M7aj27f/hnokfmD4DwH9ib
 NU6+Ur6FUamQ6AVdJAVuwBXWqOPT+KL5A9M16z4SUyVDFKYPML1OFzbt3oeI95+8VQnYqJYgL64
 o4zVhOSGKwGa3HddnnMPbws1E09CTF2yh9oPMFrtYe3iemZACYYgn8yEotl9e/n2gzbnaCPj5nn
 HbAJARHpLwsEX9kRHq+thD6RxosvL/KoOhyzwWtZD83o=
X-Received: by 2002:a05:6a20:94c7:b0:33b:f418:c3e8 with SMTP id
 adf61e73a8af0-3898fa3a727mr15355686637.60.1768224233342; 
 Mon, 12 Jan 2026 05:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW5IqFVqSN65pDtE4PGMuY4aLgQBtBKkuKUPKSprVXmrxY+oO9PSVPyRmtfS9T8y5SFQHikQ==
X-Received: by 2002:a05:6a20:94c7:b0:33b:f418:c3e8 with SMTP id
 adf61e73a8af0-3898fa3a727mr15355671637.60.1768224233014; 
 Mon, 12 Jan 2026 05:23:53 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:52 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/32] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Mon, 12 Jan 2026 18:52:23 +0530
Message-ID: <20260112132259.76855-11-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 hw/i386/x86-common.c  | 50 ++++++++++++++++++++++++++++++++-----------
 include/hw/i386/x86.h |  5 ++++-
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c1c9224039..e58ab846d2 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1024,17 +1024,11 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
     memory_region_set_readonly(isa_bios, read_only);
 }
 
-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+int get_bios_size(X86MachineState *x86ms,
+                  const char *bios_name, char *filename)
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
@@ -1044,6 +1038,20 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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
+void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
+                         char *filename, int bios_size, bool isapc_ram_fw)
+{
+    ssize_t ret;
+
+    /* BIOS load */
     if (machine_require_guest_memfd(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
@@ -1072,7 +1080,26 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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
@@ -1084,9 +1111,6 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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
index 0dffba95f9..86f14a7d87 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -122,7 +122,10 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp);
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
-
+int get_bios_size(X86MachineState *x86ms,
+                  const char *bios_name, char *filename);
+void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
+                         char *filename, int bios_size, bool isapc_ram_fw);
 void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-- 
2.42.0


