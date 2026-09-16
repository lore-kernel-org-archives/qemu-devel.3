Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87077C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kL8-000885-4i; Wed, 16 Sep 2026 03:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kL1-0007zR-7v; Wed, 16 Sep 2026 03:45:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kKy-0005Fk-W8; Wed, 16 Sep 2026 03:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544614; bh=zxWmyasIhfgT6vc02V3XvzJfGY16yMLjXFGy4NUaMjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pOxiwrX4wQYTqMWo1XSRUs9PXi+8VK72ZhROuSoqvun0bzfjcQauULtjlfG9Al1WW
 j2NUhFekd+4RcMcCxxYuyn3vDdHFFfqxnDeVaIl8l6yf4Ak1244/c46qB4HRhEY0kd
 UTCj6fHGQsI9ONIVKRMZsU5QW18DMgHl2+Zt82ob4tdLTXlzZWYCrp7SjmzRlUC6Q4
 W4eLSAD80Z38F1SvrYU/wPi1sCBsEgQDeeEPSz/yxj+txPDVALV+6+LlRF2A5sqx1/
 0SX7fIT9IcrVIaa8Q9ohkwonSkj1LWBHv7dO7+a8tRNv44L1n2gJ5WQalxWbcb6DTh
 8FgwArx9/WmQw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB6BF1D55A4;
 Wed, 16 Sep 2026 10:43:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B268429B4B;
 Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 518035A6ED; Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 22/49] i386/vapic: unref MemoryRegion if
 vapic_map_rom_writable fails
Date: Wed, 16 Sep 2026 10:42:40 +0300
Message-ID: <20260916074346.671467-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

memory_region_find returns the memory region with an elevated
reference count.  Drop the reference count also if the memory
region cannot be mapped writable.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cfa6e2c52ca8f756461fe41f4ce40e61a82fd914)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 2069a4b962a..c914d96d946 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -608,11 +608,13 @@ static int vapic_map_rom_writable(VAPICROMState *s)
 
     /* read ROM size from RAM region */
     if (rom_paddr + 2 >= memory_region_size(section.mr)) {
+        memory_region_unref(section.mr);
         return -1;
     }
     ram = memory_region_get_ram_ptr(section.mr);
     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
     if (rom_size == 0 || rom_size > OPTION_ROM_END - rom_paddr) {
+        memory_region_unref(section.mr);
         return -1;
     }
 
-- 
2.47.3


