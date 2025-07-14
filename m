Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B118C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH8K-0001yz-3D; Mon, 14 Jul 2025 07:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzp-00014J-1M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzl-0001s0-Un
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lldL9pDenZld4b2liWHX3EviL3nng8YFuNx50nxDsEk=;
 b=Dhovk0974ADcmEVOz7R29v8Z7g3geYkuqvO8PrpqJkY/ych43R4R5yze1GG8dZtMUQMnzE
 yYcjinZ9ylvqwt7KxejTHXQZyuGyejNt8v2b54s35wWTYH+CcrLCrMzluG3zU90a1Sp5U+
 NJoQdxNh3CzPslwYeyItdmZJjaoG9qk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-maeJKQx4MG-PNJjx1GTY0g-1; Mon, 14 Jul 2025 07:05:08 -0400
X-MC-Unique: maeJKQx4MG-PNJjx1GTY0g-1
X-Mimecast-MFC-AGG-ID: maeJKQx4MG-PNJjx1GTY0g_1752491108
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so15265525e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491107; x=1753095907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lldL9pDenZld4b2liWHX3EviL3nng8YFuNx50nxDsEk=;
 b=JRZoc/COWDEALQAJdmWr4NBmes/4Is5HA7RsWS5fDUEK57SYekJ9bK/PZRypxllbBB
 ngcia2euLMyQL6gXkygBKfcYHNiSaKUqDXQMExWNAm8cJyQsAUMMudf585gtZlRRLcub
 HCEcuAZaC2kmKPAa0FtFRoilAtOliAjyCXScs/7dS4WPLNWWyEVj8IwOTT8pMRhUT5Fy
 2Yf9Nmt8Ld1ioIiz6OdImP4Ff4PpPUtgmhUDtBVxLRHRRoQ/sj15HfkRGU/kU27BDSuZ
 tO8niXV8NeZ6b+a7arLI0UI/VYepd404bJ8EQbSLBaygBrnmS99JJK+NbGqs8hk2hBC4
 zZYw==
X-Gm-Message-State: AOJu0Yz5aQFKyxapfgv/SezeHaJar2xuC9UfV9en9jtx6pzCzvQyxxZg
 74LS7fgIM8rr+UD8PoCFqz1a7+giCVQu8QXXQ483P3ONGIUOWEcsQE3vWhjZ5qlREBX+8PiG2ZE
 ZrwX/SzzZSEV0CA2Z8tAAatTGb+e/jJZKC/R3dw6feKHAKEqLrQYkTpI6Hm/wTkhVEDdaN+bs5z
 TnZr2gEM997HmZAXOOSch6gNJ5AGicb/HGLrlAfOCx
X-Gm-Gg: ASbGncvy2+W5om9Qo28wpRtIuolN3fJ62Yt6zhGvrx4TlUjbDVpSd3Q7rEyQj9cbl5q
 AwzoKudosJIvVXHy4C1dX0gFY4XTcSaLG7Pekp0bChREOq4j9c/Y+JaALK78P+HujluFnpbJt3C
 mlIDNt1vqYFEndqOCXhYINPlQ5Edug3TB6ZlQuymn9/53Vlo5e6Yvk1fyp07k+HdNc+RLCz66Y1
 2TEnordb/zv/m97yzdYLFMPsmthAkJLUdhp8laG1N9BARIu86hcggvOLjC4OAxkZvS52l9vtHfj
 JuUD13zw9w3tsN4FnbuQCt8ut9ngc/wxYmsXvZX7xXU=
X-Received: by 2002:adf:9dd2:0:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3b5f2dfd169mr7852329f8f.31.1752491106680; 
 Mon, 14 Jul 2025 04:05:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXp1U0ZHGtSGaDOLmjQpht7GMjwD1UnEwuNAmrVUl86S1NREsLe4sv2qjnpUFJdwEtjjOw9Q==
X-Received: by 2002:adf:9dd2:0:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3b5f2dfd169mr7852284f8f.31.1752491106073; 
 Mon, 14 Jul 2025 04:05:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e262c6sm11919476f8f.85.2025.07.14.04.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Gerd Hoffman <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 21/77] i386/pc_sysfw: Ensure sysfw flash configuration does not
 conflict with IGVM
Date: Mon, 14 Jul 2025 13:03:10 +0200
Message-ID: <20250714110406.117772-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

When using an IGVM file the configuration of the system firmware is
defined by IGVM directives contained in the file. In this case the user
should not configure any pflash devices.

This commit skips initialization of the ROM mode when pflash0 is not set
then checks to ensure no pflash devices have been configured when using
IGVM, exiting with an error message if this is not the case.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/c6166cfe128933b04003a9288566b7affe170dfe.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 821396c16e9..1a12b635ad9 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -220,7 +220,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
+        /*
+         * If an IGVM file is specified then the firmware must be provided
+         * in the IGVM file.
+         */
+        if (!X86_MACHINE(pcms)->igvm) {
+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
+        }
         return;
     }
 
@@ -240,8 +246,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
     }
 
     if (!pflash_blk[0]) {
-        /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
+        /*
+         * Machine property pflash0 not set, use ROM mode unless using IGVM,
+         * in which case the firmware must be provided by the IGVM file.
+         */
+        if (!X86_MACHINE(pcms)->igvm) {
+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
+        }
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
@@ -257,6 +268,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
     }
 
     pc_system_flash_cleanup_unused(pcms);
+
+    /*
+     * The user should not have specified any pflash devices when using IGVM
+     * to configure the guest.
+     */
+    if (X86_MACHINE(pcms)->igvm) {
+        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
+            if (pcms->flash[i]) {
+                error_report("pflash devices cannot be configured when "
+                             "using IGVM");
+                exit(1);
+            }
+        }
+    }
 }
 
 void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
-- 
2.50.0


