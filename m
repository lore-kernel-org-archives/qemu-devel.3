Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EC2E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxs-0003JY-Ml; Wed, 18 Feb 2026 06:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxo-0003H0-KF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxm-0007sV-LJ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESypFcrxb/PTVt2Aex0/LJ0mDUhQITS4Sl+F/ZJ54Aw=;
 b=H4nMefWIlsuV2kHxWUMM35i8Q++6x6y3alJsV6wCStpJH621LYaKUOgbuAb8RTi/VKFq6i
 anWOmiDOy0xC/a8/9vM3frymwagoJkupixL9PhcXj7afajTvLL2IqYrBJ7IcQvM8PokwkQ
 sdHUpg+3WNRAna7l6oF0+YM5KpfHneU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-IJKgoeJcOEq1wt5YYhc7zA-1; Wed, 18 Feb 2026 06:43:24 -0500
X-MC-Unique: IJKgoeJcOEq1wt5YYhc7zA-1
X-Mimecast-MFC-AGG-ID: IJKgoeJcOEq1wt5YYhc7zA_1771415004
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a946c0e441so53228685ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415004; x=1772019804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESypFcrxb/PTVt2Aex0/LJ0mDUhQITS4Sl+F/ZJ54Aw=;
 b=FegC1TRRgZwGYsLKs70w8DS3WbNkxIwr1K9exu2Hx0E67ge9PMuPRFdlhjYlG3couN
 04ZkkwJFGpr1OH58+MdHkzsyZcvd5Kt/L32OJjgEvnkDlVJACqNFFoW5cN7WDgKYRsyc
 cgActER41JpyOJ0ue9g8ecAl+re+UiIEMsZ6lY7rZU+0xnC2YTVogQFxYd3d+KKmUZ+T
 T6zH+pNDABQOFYnKDk9qdMFKtz4W159sxPCx0VKanMx5gamm19eNspYiQQuSj1XVNb2T
 0RJXTcKGFR+037/4a5kP7TU2qOojTasifBWKov7QEbxZ+z21j4hNUMb/37Mdegsa7AvA
 3B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415004; x=1772019804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ESypFcrxb/PTVt2Aex0/LJ0mDUhQITS4Sl+F/ZJ54Aw=;
 b=YMBNhsweDy6VemfkhNnXuU1nacp4yIcHd1F/FL0A9ViS63ffUMu6P7nbFSIhVyYnSl
 /Mnh273JnsCQMSRciKdugQrScd/+kjDcy7kYzqnnKn5gD/2gzsxhWmG+4s8EiWIAMZH2
 4Ft3xoQV+l8euHDep7v3PImhGhNoZR4rOreMiFSeUH8nNP6Az69DE0BUm4fIm0CdLUJt
 BRoiAA3kzzrcryzb3b3Q7KB1WQsSpdpSVi6ZVR7QzV5HggFKWhT5JTRix7NcI6qKGzwP
 M0buZVh+TPiDTyzXxdrhA5ts0V+nuWsfdV0MZ19jw+Lpo87Rlv0b5KZ40RYKEFVl0uIy
 O7+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNPISosw8jLsJL+886q9yg79zPL68H0h7oyVRk5aAksnUzwIoBOxJ653g5eezPHdkk7CEHdIywoFuX@nongnu.org
X-Gm-Message-State: AOJu0YxLoRNwUWBAnyILgynVpE5/mW8R4+zFjf3c29GGSnT2xURBdRwX
 vAxE1veu4Amakerxzt9THoI+azqFQnvClEfrvKajJafHh/cxAgOhP3CbWnaWJyCsb3LVzY1CFVY
 mXx2rJlhkqqisxOKOYtJAF2f1BazIg/x4SKia5incAVouE/150V05BNPg
X-Gm-Gg: AZuq6aLW+c8sV9jBQdwPYqbFGWZykZ3phe2wwNE8g+5o/FfGam4FNwx0KSn1rmLbRw8
 czq0e6+/WPjF4TVD+wuTawuokAafTSKFvcxZauh5CRK5r5IvemY5LBXMloikfIQ3Ivc+6RPd4Zc
 /hmh7+Edxv//dMhCFqSNvQKLiouU2dvGBOaJMPTWUUyY1vu27JHw3RaxckTOLyYJsi9FYQRh1J4
 5qGXZu+C7oLFOMKR7nte+VcJ/itoolRg+phpM6raT/Ze3gcd9VRkhWLsqkX5eUbfnlA88gE/p1K
 BIYtocKyaeWMx29a5sTPB+DSTEKhJbRfLzcvwU5ABy6aqA0PSfOByEup4ThgAHe1zweBftbiL2U
 O2xPFimlDXyYYbeKtyFVfviA/wLOAM3YVZprDmKqHp1HDVdvoO4xT
X-Received: by 2002:a17:903:2409:b0:2a8:ac0f:9ae9 with SMTP id
 d9443c01a7336-2ad50f95240mr15769645ad.41.1771415003656; 
 Wed, 18 Feb 2026 03:43:23 -0800 (PST)
X-Received: by 2002:a17:903:2409:b0:2a8:ac0f:9ae9 with SMTP id
 d9443c01a7336-2ad50f95240mr15769395ad.41.1771415003303; 
 Wed, 18 Feb 2026 03:43:23 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:23 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 12/34] hw/i386: export a new function x86_bios_rom_reload
Date: Wed, 18 Feb 2026 17:12:05 +0530
Message-ID: <20260218114233.266178-13-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Confidential guest smust reload their bios rom upon reset. This is because
bios memory is encrypted and upon reset, the contents of the old bios memory
is lost and cannot be re-used. To this end, export a new x86 function
x86_bios_rom_reload() to reload the bios again. This function will be used in
the subsequent patches.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c  | 21 +++++++++++++++++++++
 include/hw/i386/x86.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c98abaf368..a420112666 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1085,6 +1085,27 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
     exit(1);
 }
 
+void x86_bios_rom_reload(X86MachineState *x86ms)
+{
+    int bios_size;
+    const char *bios_name;
+    char *filename;
+
+    if (memory_region_size(&x86ms->bios) == 0) {
+        /* if -bios is not used */
+        return;
+    }
+
+    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+
+    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+    load_image_size(filename, ptr, bios_size);
+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+}
+
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 23be627437..a85a5600ce 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -125,6 +125,7 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
+void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-- 
2.42.0


