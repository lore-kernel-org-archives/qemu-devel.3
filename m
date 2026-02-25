Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DD1F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vS-00081C-Ns; Tue, 24 Feb 2026 22:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vQ-0007tX-Nb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vO-00088o-Vq
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8ysoIKaFAhpJTu9HD8Mj/a1enqePFAzbIF/YGXHVKg=;
 b=N4H7AsKBNp7ZA9Dqr/IdxgT62j3JYadANj29/vN+AuCKpDDg9OJ5FcUfL4xNvI/kD539K4
 LRABzPaLI9CZ20FhY9X+zBCq28F8H7bD5QYJS+iuUPdhJRFJkUW80YbYJUBlOAf2AoGq6f
 T3RTDpM+ph2KotoNHdmvkd4zBeHliKc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-HvpKwjpPNn2C35t9h52hMQ-1; Tue, 24 Feb 2026 22:50:53 -0500
X-MC-Unique: HvpKwjpPNn2C35t9h52hMQ-1
X-Mimecast-MFC-AGG-ID: HvpKwjpPNn2C35t9h52hMQ_1771991449
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad60525deso411715095ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991448; x=1772596248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8ysoIKaFAhpJTu9HD8Mj/a1enqePFAzbIF/YGXHVKg=;
 b=H+gDURnmco1BzxEgdHJ+wo/4OiSGHROMhWT8U247lwh/E2CsFK7BWJsONHsLBG45h0
 +s/VLOFmY49MCe07C0yfb/flwVV/cUj/t3Xjp4mJl1RodB+T2Z2wg/+uWxxgleOFOKEL
 fQCAT1ZvagCP7J/UjLEWVzu2TdnFrM0ZXtvw0se5rYN/fwkjqVoq3lza3PPLZoxsICk3
 9x+ld1x3aWimsyu1OTf2DWZnsgqqpPD2CPaBe7S+4jUVU9rbjruBjrVLXtuiuKgHQL3S
 Edss3ZWKwO7ZwSKgt+CYKLDhRFcbykBhiNBlYmwZR530npFPwNgB2uAYjEWxgAbHGxHI
 p+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991448; x=1772596248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U8ysoIKaFAhpJTu9HD8Mj/a1enqePFAzbIF/YGXHVKg=;
 b=Z61gaWT/dForrTfyKpBSJLYHzSQAu+5PHaZKsOO2CHzCJN90GrlYO8NOLli6H71VZo
 ckTZ8fdMs7jK9V9KeExVorNk0aGaefthNU8t1dXUhhcNP3R+xTmiA8K3NM68hUFB/wnR
 yQ/AUmMxyHxYPUmGQry/zlSGKFLrQW9dzkUpiXl5PaBGWB7hcumAnwsTo009hBWAU3pa
 9felE4k1rC6yYOjyxw8/7nyCnQwn8obJXxQWhVvKcRMG7viZvh/Bfk+j6YJSPO9A74O+
 AwZ0rSr3Ltcv9Y0ZABOwo08UlP3nfBnRVX3k33zo6uNUZEtfYSbcJ4JUoPKqbczLkHBR
 6HeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf/Tn9WoUxibFJS7fbE/THutpB1SfTa0XdeUeJFZ2e2YB1ACp4dOsYxAPAjbolOzhw4rr5/gkmrZgl@nongnu.org
X-Gm-Message-State: AOJu0YwPnTi7VX7X2aQ/eJrSVRhgtFiW7BbJ6QB10x4X/jcNzqiIYkML
 +uZYEFG6I7D8wD4Dkrj7aHrcXqj9yP5psfUG/sugqPcgdDP7xzMMEUvrITR1nSBBOO7mLAqtWm3
 Bw+EcYuqjCnaP8EgKbcdVXWwKsCCfv/Tc15hIFnJDVXeGU5CZvb3B7iPu
X-Gm-Gg: ATEYQzyrEKjPw6tVOuGVsC2JO+HPm2v/JEvM628w/h5qR1v28Oblq5dM9BmDIcibki4
 MXQgffJNfXxkbJyxlWl0TZ2b0Y1nQViPcuTsPJmd4Wos9yIH2wvXEzJ4wEQM+F2pDvfZ46CoK8l
 zkTjJZUx0m/Jby9k04FOS7Qz9K60Wxm/kFGkfSSoxeXXroahXSmVE1op3wQCCkDU2S1d/WBkRZC
 baGKbi3MiG10OXYxWckp2Pank+id/yr7muL+99wKc57Q3kUeMVew6+Sb6swtF+rLP3/HnogMpnK
 CXQ6zKGq1aplHFhpCPmQ67opo+NOtQLL+1hzw9atg+XC5wH2KUG0iCe4X9PJ51y4jbelCR1gAE2
 W9q5H9LGEu/O2vGSoo0ot44j4HC7Ku7FjV8ilUsvLeSZOPZ2/M6vLKXQ=
X-Received: by 2002:a17:903:1b4d:b0:29f:2f40:76c4 with SMTP id
 d9443c01a7336-2ad744e05demr139398005ad.34.1771991448549; 
 Tue, 24 Feb 2026 19:50:48 -0800 (PST)
X-Received: by 2002:a17:903:1b4d:b0:29f:2f40:76c4 with SMTP id
 d9443c01a7336-2ad744e05demr139397875ad.34.1771991448239; 
 Tue, 24 Feb 2026 19:50:48 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:47 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 12/35] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Wed, 25 Feb 2026 09:19:17 +0530
Message-ID: <20260225035000.385950-13-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Towards that, this change refactors x86_bios_rom_init() code so that
parts of it can be called during confidential guest reset.
No functional chnage.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index de4cd7650a..c98abaf368 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1020,17 +1020,11 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
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
@@ -1040,6 +1034,21 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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
@@ -1068,7 +1077,26 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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
@@ -1081,8 +1109,4 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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


