Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72798D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XD0-0007nw-J7; Wed, 23 Oct 2024 04:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCy-0007nc-Ex
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCw-0000Im-U1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=KnhLnvuPCfcreyL9kUT0InkhJuyZNVMwBARkk6t8FjM=; b=mEQUI6QjxlUoNHoV1TwOxWRlg0
 U/A819GGKPYsI1hS9YxMalOR3fQ1YOh7VcP9pUgrNcTYybsNmmNZ7DivkyNwN9Im+Tqg0iDojv+Wr
 0hjmYApe41miGIxYS8O1E1AmhanZW527aZnGszB4uTkK3NOBbOES21YQVxMXVHYsrzuFL6RQXja+b
 YDM07eFEix6J29QBh7sx8fe2V17QCyZ5iqq90AjXAuImctHViuVrHwhURlJlkt4o2KRBzI9QxrDGp
 XOBixn7sz+spF9n/IeuL/w23CZCFWlrN454e3kCQ1zssMqMvOO11xhInegDRnl2KcwPnOXxqp9t33
 eiG6s4vYPLvNsQRmQ754AD4eyaewytVDVefwC3Zv5YwXYdAas8DalmBzOEVdOpcg4AgJLfKTRf54N
 s0xNtDvEN2dqN2Dp2YfrOHdmSoFRUADeQ+NYgBqv09m2tOcNPPjsBp8k8oBHNymHEyTbnv0aaDu0F
 YXifu2OGCKrxQfSIUPANgrPsRayrs2gUKab7yiuYMx3p25XwI0Xr5vjx/6HvpUDjByn49Smrl+XrA
 rrYKMJdiDW6j9tIGFOnaZ7qdE0njowH7WN4luLX9aD1tMgyVS8GDNWMndBVxE4gUlI6KDlHRLc1Bf
 0TUjTeILsntdiEZaggANRxadE0cyhuMLkkgFU0KuY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCb-0008EL-Ru; Wed, 23 Oct 2024 09:58:54 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:17 +0100
Message-Id: <20241023085852.1061031-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/36] next-cube: fix up compilation when DEBUG_NEXT is enabled
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These were accidentally introduced by my last series.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9832213e7e..7a503e0707 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -404,7 +404,7 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
 
     switch (addr) {
     case 0x14108:
-        DPRINTF("FDCSR Write: %x\n", value);
+        DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
         if (val == 0x0) {
             /* qemu_irq_raise(s->fd_irq[0]); */
         }
@@ -468,15 +468,15 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
             /* int_mask |= 0x1000; */
             /* s->scsi_csr_1 |= 0x80; */
         }
-        DPRINTF("SCSICSR Write: %x\n", val);
+        DPRINTF("SCSICSR Write: %"PRIx64 "\n", val);
         /* s->scsi_csr_1 = val; */
         break;
 
     /* Hardware timer latch - not implemented yet */
     case 0x1a000:
     default:
-        DPRINTF("BMAP Write @ 0x%x with 0x%x size %u\n", (unsigned int)addr,
-                val, size);
+        DPRINTF("BMAP Write @ 0x%x with 0x%"PRIx64 " size %u\n",
+                (unsigned int)addr, val, size);
     }
 }
 
@@ -585,7 +585,7 @@ static void next_dma_write(void *opaque, hwaddr addr, uint64_t val,
         break;
 
     default:
-        DPRINTF("DMA write @ %x w/ %x\n", (unsigned)addr, (unsigned)value);
+        DPRINTF("DMA write @ %x w/ %x\n", (unsigned)addr, (unsigned)val);
     }
 }
 
-- 
2.39.5


