Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A23D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvk-0000BG-1D; Mon, 02 Mar 2026 03:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0005NP-H1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyul-0001xh-QP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4dK4avivBNGeqYlI88vyCawkYYLzQKNasCQb8HtPUA=;
 b=iPXXpCRdUCgPbaQu1KcBlkdwQ4MJuLWjZF7azRwVXwznxG/mGTyPsFfjCXWKhdPk7oyw/W
 wz+SjHEEjlmvpAV29H6vvzGETclz+kA8YWzJWiH4utCWRW2LaJZsKBWOPrXndlR0Cv7h2k
 FppcyR5eIMBB57M2zyS/xI6bSE/uhMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-6FrVXIwiPJCoEQbvOQt_OQ-1; Mon, 02 Mar 2026 03:46:04 -0500
X-MC-Unique: 6FrVXIwiPJCoEQbvOQt_OQ-1
X-Mimecast-MFC-AGG-ID: 6FrVXIwiPJCoEQbvOQt_OQ_1772441163
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso53794955e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441162; x=1773045962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4dK4avivBNGeqYlI88vyCawkYYLzQKNasCQb8HtPUA=;
 b=H0uhkgEms3fTRycgeaKoq75uytbmu4GA4laxj0aJJivAHn6A9MaujYcgR7l5TzlF1T
 vFucduPYcCa0+MixoqzD3dOBsT4me+NIKAWc9g0DrL+c6+gj92I5jg1XFE+gRs/noS53
 ozJRZl+aW/3bbcXwiPiWYzSdjD9zbBt+ScGqbu/kPUsJMhzOmZtr0ZFPNoz/ZBz/Fsc6
 mcuHGesj4RSxOHJk0wqQWkdMaQQN0bxJhScOwyRYr/q7RZ/ZZ9jxAjwceztapm5TtjjI
 ae8K3dPUvdyoSg+Z4rzBogVr0RiojZiaeIIf6KiOTxKkrR//fDfxHjPJJG9BvFk/rfya
 nTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441162; x=1773045962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4dK4avivBNGeqYlI88vyCawkYYLzQKNasCQb8HtPUA=;
 b=QwCRqBmW+/WuEM4edsn18zqiml6+zIy00RbJpEupciaLwnoZjnLafnzW5BwYatagjz
 PiTkFes/uvIEUTLSlliVP07NonAOdbpHb+U1lulepNwhhWPTCiCWr8BUhnQQev6BvA28
 ioEZZ/3aT9xT/XqHfP6V7uk0vIKzrt06Tpuvte17YfYiEGq2LwBI64Cq+2ZRLGLKHRps
 tLSO6lNMXYm1c3PFe1IM9htv9KHQGQvgfS7IsR1rBiIf1zczPGQM30F5Tvt93bWlHjtA
 G8ELNqDscn0j1DxIV6BouLycgpCqMqK0Qj7SPq754fZ1Azzrut+Ej1WSsjf7nfgoVK0O
 OAyg==
X-Gm-Message-State: AOJu0YzTf2zEfebzsM2L/4KRtNOvrwPFX9lmqCDBOesa5RrdWDLnwYj9
 aQ7k8EB3BJXLTKhVNc5Gc5iFoPWiMBEVHLE3+5Gyjdyu8VvF4iL86ZRfyh+UKCxW6Gj/zGQFLty
 s/BrLjYIaiR4Vuv9KJNZiRzhd0hGy1S2Zvx+gxmWYeWeYYSacxcHCBvNGW6LgbVHMEOmPAgr28l
 15hGmawONYAIr+Aj8P5rLD73/H/7HUBZ0UYQQ0nguj
X-Gm-Gg: ATEYQzzkUViWJcNlGUwaJOxUfilhGf0y6Tj1MrIxU10U8Y0t3rZcUFgeGbxUFrIKvLf
 NHN9a/YAlrx5ewcuYnYt8JReid6fuO1SsE5QZsSpO+dOLfH8F4gu2ureKPweLCaJTl6WlG7lzHm
 mopVD4IhP99z8xn6jo6efPxDmFCm4G+qBjLMLlixYJHxhYMN5Iuvne0niNbxel+CTbLpdAesdPC
 M6WOvMfOYsI6FLwFvWmbCyWd1eIOKRziUOV1878uNzfyd9miWH0PBAy3i/WeeVK3WaQWG2E7R0M
 EvgLT9WuhYxgZfhPCjScU/wV5++0AOyAsRmZkIiia52au4kGeepMPQR8krBnBt/DsTz4LrWr1VU
 roUSZPuWFRpCtdbqJWITJPw4bF3ngQFsGOVUUQ9Rkred6+8jel5I0SJXjvQvreGTtXi7H8h/fSm
 fzJr4vSW/oh8QXR7oq2jDKF+N/Gxc=
X-Received: by 2002:a05:600c:a4b:b0:483:71f7:2797 with SMTP id
 5b1f17b1804b1-483c9ba3785mr216754755e9.14.1772441162319; 
 Mon, 02 Mar 2026 00:46:02 -0800 (PST)
X-Received: by 2002:a05:600c:a4b:b0:483:71f7:2797 with SMTP id
 5b1f17b1804b1-483c9ba3785mr216754425e9.14.1772441161851; 
 Mon, 02 Mar 2026 00:46:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbd781sm233582865e9.8.2026.03.02.00.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 053/102] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Mon,  2 Mar 2026 09:42:48 +0100
Message-ID: <20260302084338.473368-54-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

For confidential guests, bios image must be reinitialized upon reset. This
is because bios memory is encrypted and hence once the old confidential
kvm context is destroyed, it cannot be decrypted. It needs to be reinitilized.
Towards that, this change refactors x86_bios_rom_init() code so that
parts of it can be called during confidential guest reset.
No functional chnage.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-13-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86-common.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index de4cd7650a4..c98abaf3689 100644
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
2.53.0


