Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B059C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjWs-0004X1-PF; Wed, 05 Mar 2025 02:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjWo-0004Wd-DB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjWi-00077R-JI
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2DLL5DRuBp6sKC8Xt2pwlNQ1+iiI+ge2C9GP+hRBYU=;
 b=Zedon4GzKv0gUIi1oLr/SDKI0x0k3YeuOUx7FPeV/IjNpXC34e7zjeCxFZYMGhroj1uObE
 RW1aY6M/+XLItdaQtqLgTjfcf8gMA4uGG6N0SXMJTYpO4Gw/2jgYBEqGeNfH3zLXMtgVv6
 5ziaubvekKcEnlAlWyWdvJJ2TkfE7TA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-hobXsJ4pOpK09Sn_XN1iLA-1; Wed, 05 Mar 2025 02:50:46 -0500
X-MC-Unique: hobXsJ4pOpK09Sn_XN1iLA-1
X-Mimecast-MFC-AGG-ID: hobXsJ4pOpK09Sn_XN1iLA_1741161045
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22356964533so94490165ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161045; x=1741765845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2DLL5DRuBp6sKC8Xt2pwlNQ1+iiI+ge2C9GP+hRBYU=;
 b=iixYylZiH8D/HHS39MbWOTNdp+yEqAm1afk1c/AgDvo3SaaVJ/PRrKLVz12DltDRTI
 pGNCcUnQWRa/mHw2w1V38ahAueWTwfbklNhZdsGcbDctsdXuzpOBU8CRIqCHl3WbybYJ
 VOWDg5wRA1iXSpjkfYVuHNcwuOj9EFOJ810U8BSQspEZGbt3/BQyHbMhd+jQIijx2/Ph
 Pwqqim0NMONA8I7DTRwfXOZr1Qdr2qLz9yV8NiUoObrRD9vgg7rJS+z8BBPumr4LQpQI
 38xGGjHnV7DmmTeWCdESXhGCRubUGkXA9bzq/OUB8nnQwTkoNn68mfDZqtT886dnoDYU
 Iwrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKBGwzAQpV8Imt5syx+PMtdjoMBlQ4UTg+r5kgpahQbuz/VyodLsGxbiNv9N9mKxIvpQlVX0/FcjX3@nongnu.org
X-Gm-Message-State: AOJu0YwjHQYbJ6ytHp2nmwBFADRVZbimqscJKx9ohfC8dHL2UEX5ONDu
 zSI/RVr+TSbBwAhgOrJYWkvvLrLYec8NyoUsfGFuQj/l0DutYBZng4IjE8gNwfmEezuvIX5Ce/r
 OT5RSiwZh84VSyBqmGP1JxSGmFgT47mwiX/DLhLTRgifNM5HWRfM8
X-Gm-Gg: ASbGncvSGw3pLzkAnugIs5kR2xWsVh/El8Kdax689Wumzkq8h2yI9uJuufXpcyVjBj0
 /5SC1iyKaK0ZZ3cemsoCd0dJorBaE1Jjty0/r00Iz+H/xEg0mguH0ZTZUphpWf89/HEsZ1ElTLj
 aY3/HJwLVpI5ysSuqWGBobbM//kgM33v5Cr9GzJ7EFXtPt9LQRHy6wXRg3YD1It8jkAaKNQBjO9
 zyVa/TYCA9gnrQTVkht0zEIG7Nzi2nE6P7FRSY2v5eO3u77ese3qW6hWVPcUBHEBFR6KMeJESUi
 g2iLPMrshUAUwoweJwuj+agYpdg=
X-Received: by 2002:a17:902:ea12:b0:220:e63c:5aff with SMTP id
 d9443c01a7336-223f1d337ffmr26801065ad.47.1741161045025; 
 Tue, 04 Mar 2025 23:50:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZvzBg4wNLykVDCHdYyzRVJ+wzmr/bvPDVGwrPpDci52YtVAPgtiWrZaj9Zy6tGZTFjynv6Q==
X-Received: by 2002:a17:902:ea12:b0:220:e63c:5aff with SMTP id
 d9443c01a7336-223f1d337ffmr26800925ad.47.1741161044664; 
 Tue, 04 Mar 2025 23:50:44 -0800 (PST)
Received: from localhost.localdomain ([115.96.122.38])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-223501d2778sm107425355ad.36.2025.03.04.23.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 23:50:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 1/3] hw/i386: introduce x86_firmware_reconfigure api
Date: Wed,  5 Mar 2025 13:20:13 +0530
Message-ID: <20250305075015.26892-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250305075015.26892-1-anisinha@redhat.com>
References: <20250305075015.26892-1-anisinha@redhat.com>
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

Normally, there is no need to perform firmware reconfiguration once the
virtual machine has started. Hence, currently ovmf firmware parsing happens only
once. However, if the firmware changes betweeen boots then reconfiguration needs
to happen again. Firmware can change if for example the guest brings its own
firmware bundle and installs it with the help of the hypervisor[1]. Therefore,
this change introduces a new api with which firmware configuration steps can
be forced again.
This is mostly refactoring work. No functional changes. CI pipeline does not
break with this change.

1) https://pretalx.com/kvm-forum-2024/talk/HJSKRQ/

Message-ID: <20250228114230.306852-1-anisinha@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/pc_sysfw.c            | 26 ++++++++++++++++++--------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       |  5 +++++
 include/hw/i386/pc.h          |  1 +
 include/hw/i386/x86.h         |  1 +
 5 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1eeb58ab37..a9943d95c8 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -258,16 +258,9 @@ void pc_system_firmware_init(PCMachineState *pcms,
     pc_system_flash_cleanup_unused(pcms);
 }
 
-void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+static void x86_firmware_configure_sev(hwaddr gpa, void *ptr, int size)
 {
     int ret;
-
-    /*
-     * OVMF places a GUIDed structures in the flash, so
-     * search for them
-     */
-    pc_system_parse_ovmf_flash(ptr, size);
-
     if (sev_enabled()) {
 
         /* Copy the SEV metadata table (if it exists) */
@@ -282,3 +275,20 @@ void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
         sev_encrypt_flash(gpa, ptr, size, &error_fatal);
     }
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    /*
+     * OVMF places a GUIDed structures in the flash, so
+     * search for them
+     */
+    pc_system_parse_ovmf_flash(ptr, size);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
+
+void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size)
+{
+    invalidate_ovmf_parsed_metadata();
+    pc_system_parse_ovmf_flash(ptr, size);
+    x86_firmware_configure_sev(gpa, ptr, size);
+}
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b271..edf890a525 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     g_assert_not_reached();
 }
+
+void invalidate_ovmf_parsed_metadata(void)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 07a4c267fa..3244c17a7d 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -36,6 +36,11 @@ static bool ovmf_flash_parsed;
 static uint8_t *ovmf_table;
 static int ovmf_table_len;
 
+void invalidate_ovmf_parsed_metadata(void)
+{
+    ovmf_flash_parsed = false;
+}
+
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     uint8_t *ptr;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f..7b0d0c54f5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -211,6 +211,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
 void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
+void invalidate_ovmf_parsed_metadata(void);
 
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e..18c0d6851a 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -155,5 +155,6 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state);
 
 /* pc_sysfw.c */
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size);
+void x86_firmware_reconfigure(hwaddr gpa, void *ptr, int size);
 
 #endif
-- 
2.42.0


