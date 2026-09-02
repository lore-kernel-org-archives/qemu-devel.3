Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E02CC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1eBh-0007J6-R0; Wed, 02 Sep 2026 02:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hburaylee@gmail.com>)
 id 1x1eBg-0007AR-1m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:11:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hburaylee@gmail.com>)
 id 1x1eBe-00031y-70
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:11:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1004920a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788329464; x=1788934264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3VBqAwKWuCdfCQg8dFgT/lfRQgMVOIAx0SMPjfe6wxY=;
 b=HVp86mDrjQvVvSXWXw58MauhrTqe1LSy+s8ZUr4BYSnH1WJgbQk3yT5DWw56UBvKiI
 ApXqNIaZan7KUgVSeJ2MwkJULHekx4hJFoMImPjOrH6Y5A3lwu+35YH0u1S8yz5rhRLz
 Mj/WGf6AdRkv1FpphCjrgRyBEO0h6OsoB7tDoChEgDDCS5ZgdGIzQklxZzK0R+GDIVIj
 IHzRe8B5n+75FirCkqUZBROwNpmJhtKEHuwYz7ZSojAnEF8fLeqwtJLV9en9pnqlW6ql
 SlxyQjY+HVLrqCh5wc/FlKOLj/IostDl+RSP3/KlyFGhts6u1cE37A67lGDNRPOwY06m
 dAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788329464; x=1788934264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VBqAwKWuCdfCQg8dFgT/lfRQgMVOIAx0SMPjfe6wxY=;
 b=TpW2lAPCnmWaJRxcZF+lxklveWTI6bHy1kfjHhYx+JXuZRy+5zgUts9RUksods47AS
 ZeM0bSbQngV40WZSTa0AJcoLqevSAHTZ/0pY8bT/JncEF3c+L94mMm9FAhK653fwmsct
 ipHFtNl2fw+JKXHsQYCrCRZQHwa7Az/jU6yGGXwcny3BqlmqbFVV9F7WKKARwjaP93x0
 8MPUVIJCizjSsfWCJ+lWCfK1kV7yCKkWqAhopajqk9FBlpKesb46+oPWnNkPDSUJNsbh
 qDRx4R2ErtxN97/xG1lIS6TYIkDTyT+TVMCr1fNjd/jQeW7ihONEYPiJk03uoxvv3m8v
 hQWQ==
X-Gm-Message-State: AFuF++lV96buQuG1b8x8DRIid5aV5lU7X/9m5nQwZjEbDJFuGQFt40ZN
 ARIusEECTU4wsCUbrNcBePWXf2Z0i5If9i/3b6itGfHa7Hak6oJc9JSYXjsdpTmC
X-Gm-Gg: AYBFou2RWsR7+2U7LW9VinDErq0lsXFMZ25Z+AvGiJV89nEcnq8/BXc8dmcCdD9JyKQ
 z9XBjO2ltD/sGipbEHpQ/dIaSqpHxmMXJVegWuyQ8aDyOVpwTzSkmUHxoOxwZlvZ34C4tgdrwSG
 2U5nV4UBUW8t3BT00H10ZDMQYtS69a/R9vgj2HsVeB5HQJmqVOhB5wvY8mINCXDJviBpyenCY6o
 6FUgS9WKxRsDSe3G0AeAWoHxuappC0YLWCiEnKuIOn1IQe8QYkCRs4UkpE+//QPAieERv2H6c7B
 iXmVU4YunJGq3a1e6lJMQ94o5jijmwZc96CwGDxOTWYNDZVkZMAj6cpGayAG4KC3UFPGlJJ6nPT
 ecQqU3RIa2Ral/MkmjQ6fjxzSiU0oeYr0D0iQ3aODdLAXkOKJmwFCcwRatn3fhrbqPtnAQe1el6
 l4lmwzISP7Mb6KxYUFX5fM7fnsd5KHH0rTHGZ0WIOAXUUmkE0oLTVYgryJczjAPDLczHc5
X-Received: by 2002:a17:90b:3b81:b0:398:9be5:b41d with SMTP id
 98e67ed59e1d1-39aee2650cdmr3084978a91.24.1788329463542; 
 Tue, 01 Sep 2026 23:11:03 -0700 (PDT)
Received: from Lenovo-raylee.lan ([219.142.227.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d4a61d6sm9392441a91.8.2026.09.01.23.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 23:11:02 -0700 (PDT)
From: Ray Lee <hburaylee@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, richard.henderson@linaro.org,
 Ray Lee <hburaylee@gmail.com>
Subject: [PATCH] hw/i386: reserve the initrd in e820 for direct kernel boot
Date: Wed,  2 Sep 2026 14:10:56 +0800
Message-ID: <20260902061056.118917-1-hburaylee@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=hburaylee@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With -kernel/-initrd, x86_load_linux() places the initrd at the top
of low RAM but does not reserve that range in e820.  SeaBIOS
allocates virtio vrings top-down from the same area, so with enough
devices the vrings overlap the initrd and firmware DMA corrupts it.

Reserve the initrd range in the e820 table; SeaBIOS and OVMF both
honor "etc/e820" reservations when setting up their memory
allocators.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4396
Signed-off-by: Ray Lee <hburaylee@gmail.com>
---
 hw/i386/x86-common.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 8f9419e7d3..4e85fde987 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -38,6 +38,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/core/loader.h"
+#include "e820_memory_layout.h"
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
@@ -744,6 +745,13 @@ void x86_load_linux(X86MachineState *x86ms,
 
                 initrd_addr = (initrd_max - initrd_size) & ~4095;
 
+                /*
+                 * Keep firmware (e.g. SeaBIOS) from allocating over the
+                 * initrd at the top of RAM.
+                 */
+                e820_add_entry(initrd_addr, QEMU_ALIGN_UP(initrd_size, 4096),
+                               E820_RESERVED);
+
                 fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
                 fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
                 fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
@@ -889,6 +897,13 @@ void x86_load_linux(X86MachineState *x86ms,
 
         initrd_addr = (initrd_max - initrd_size) & ~4095;
 
+        /*
+         * Keep firmware (e.g. SeaBIOS) from allocating over the initrd
+         * at the top of RAM.
+         */
+        e820_add_entry(initrd_addr, QEMU_ALIGN_UP(initrd_size, 4096),
+                       E820_RESERVED);
+
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
         fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
-- 
2.53.0


