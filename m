Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B50D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hV-0001yY-TP; Fri, 12 Dec 2025 10:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hV-0001yA-8Q
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hT-0005hU-Nw
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKeUZPc4i8r5RqBQh7JN1YPGnsgStLJoY8vQlAxmBok=;
 b=JTvgPh5uYJW3ZSo9hzDN9FCL9M8EkC6N+kcipf2PTA6sejRuhP3UMJjKrdJif+HzUfndxQ
 RzU4tv+pPTpkqA0lCi2cgD8Bj2gkHIRDCQzrVaRZvPJdg/BHFLp1dxDYcsec1EsZvsHwgG
 5xAxJMskX0TMGPbqJ2lgHSbynjeNAvI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-NaWAr19zN_-G8qVRxElkwg-1; Fri, 12 Dec 2025 10:04:53 -0500
X-MC-Unique: NaWAr19zN_-G8qVRxElkwg-1
X-Mimecast-MFC-AGG-ID: NaWAr19zN_-G8qVRxElkwg_1765551893
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-295952a4dd6so13066625ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551892; x=1766156692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKeUZPc4i8r5RqBQh7JN1YPGnsgStLJoY8vQlAxmBok=;
 b=aokp78rkPurY58XiZ1Ww4bke3E6X0sfJF5AGy6K+20wM9+vgtYNj8K58QldZQG9S5h
 GQzWbdXcvxUBnUkR1svevhICqGx4njKWzGd1xGM7j6epx9VDi5UA8azaJ70sA/NBh7VR
 XajEFu5cywAZ0MvXyOfhX0/DjfUoi//DWQ6hrE8JQj2bVj49q4X422OBA8bSpKcC0aKj
 jnEJhvvxfa+KeRIY3dGznxHk4MkaRupcjY/V358etvRn/f12DBDSBgoI0YqMzCjbFNHf
 FIaiSdEkpn1aEGyPxo2FOy7bf2uQR7hFy5aoyrWAH9B/M5BHQ0Y0SMsodTXY5S5x0ops
 rSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551892; x=1766156692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cKeUZPc4i8r5RqBQh7JN1YPGnsgStLJoY8vQlAxmBok=;
 b=XASYVQgVTxiyEzz/rNt8COqwWtr1VLKnvdr5E603za6YIvfPSKqh+b6CoFH6P6iUMu
 HpOnJki4R5HOLxafaL5TcnFkiivUFqk9vhubhL6EFtJQ1qCfIqTS4rIpotC3gp2g/oAG
 hcBc4S12W9PgN5YidhsCft2dvk6+UHUeIaD6gVhFNklieM8qtZ/4vI5F7fM2at1cK/ce
 Tcci2tkKOLWPvqQDkckrjOMYpvpRAD4SRy/gcjI8eYWiC0gGUPmlasphBKhfxYiRLgfP
 ksm4QTyj+VqY/7qD+6NybZf9H/yeWwW4yJELlJnEl6guW0WZmhGCbhM2c6k3U+Eqp4sP
 0hwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIjMoglhH7o3WFDn7HxFA733j9B2bu+iSUZwq5WIuH3ncxvUlmhep2AbIZ9QFB7QupJAPAN1aGYlI7@nongnu.org
X-Gm-Message-State: AOJu0YyinOYN4Oir1j13UG1mB3Jr7A6zvHkzbL1swfZwJKF8R0HAuBaJ
 xvH0hphiP6nEpWnJRsfSQNu28kryXeso3gxPf8lv2J4ZufXcu7DGs6cLKEyy73fA0Uykt2j6Rlx
 XjZ9P0E+1bbjO+hNV292U11uZlyOePS0UH8CgHTV0nAYDVfOp6kj9kNJA
X-Gm-Gg: AY/fxX5TsMklwwR0DXaw7yfoYn8VpBLCH1HGcmUS1q8h7Xr2bY1mIkty+NG3ZoHkRBr
 QFRqzAn4ofw+wYFmP3PKEFMAxnacXMk7NXeEetgjK8T61D6CQ3OmjvZ91vQxe+yn8jITeMEe6pk
 XR7bWO9wjeeKMTk8Nb/vqf15VXKJPx7OM2dSZqVmBJQC1vNdxcvI3xud1G3AQdkqHKrTibt/5JC
 IWdhMM7Y8TnP8tAiE4KaAYqOjiFtrN0wFNzSXyZqJetHaTm8SECExjSWJpGULVr2UYOmhneW5BD
 6bAXGLj7nCtKTQFJ7gHAH4ugdYKKJnauK7PBDoDgDWyi59SHmXOPiAKNcjPb9j4AzVuWJ9gSgHN
 878y+RPqcYAmzn/a9ydZg7SH/OEEPJQ3uVUkLh6n9Ggw=
X-Received: by 2002:a17:903:ac4:b0:29f:13d2:1c71 with SMTP id
 d9443c01a7336-29f24d7350cmr26334035ad.7.1765551892361; 
 Fri, 12 Dec 2025 07:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9If50C4EjDHIO7qHkYNkUYveZgS1Ff2+daiW3CTqx8dYl3Yx+9HFbHDddk6CK2Hrz9tXt5w==
X-Received: by 2002:a17:903:ac4:b0:29f:13d2:1c71 with SMTP id
 d9443c01a7336-29f24d7350cmr26333535ad.7.1765551891826; 
 Fri, 12 Dec 2025 07:04:51 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:51 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 08/28] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Fri, 12 Dec 2025 20:33:36 +0530
Message-ID: <20251212150359.548787-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index c844749900..81fa4f47fb 100644
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
index 8755cad50a..8871f95891 100644
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


