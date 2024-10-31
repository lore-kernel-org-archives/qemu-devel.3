Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E0D767F6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZId-0007GM-Nt; Thu, 31 Oct 2024 13:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZIK-0006x8-En
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6ZIJ-0006ci-2m
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730396954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIHchk5A+qmFPbVcaW/HDCHq1ocANqAi6V5O6CgBR6s=;
 b=fYgVO6xdvnISfPqdooqv0WjxpGvHNyzk1WnOlzwmLFm3vYDHHNfaiQVj3XlK56vtNmMir6
 u9kNBbvV5l2z6iLD7Vt3q50xw9QBFdkzrITEkRM4S8v6Jryku+WJ4bLTqpqqT2GQAX/AfJ
 o+vpLeCuOhDa75CwkQyNuiDK+1ADwFg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-9UFnUiuFPK6z10Mj6pLjlQ-1; Thu,
 31 Oct 2024 13:49:04 -0400
X-MC-Unique: 9UFnUiuFPK6z10Mj6pLjlQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DDE41955F41; Thu, 31 Oct 2024 17:49:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8175930001A3; Thu, 31 Oct 2024 17:48:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PULL 09/14] next-cube: fix up compilation when DEBUG_NEXT is enabled
Date: Thu, 31 Oct 2024 18:48:27 +0100
Message-ID: <20241031174832.6574-10-thuth@redhat.com>
In-Reply-To: <20241031174832.6574-1-thuth@redhat.com>
References: <20241031174832.6574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These were accidentally introduced by my last series.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241023085852.1061031-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.0


