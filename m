Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FAD2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XD2-0007oN-Ff; Wed, 23 Oct 2024 04:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD1-0007oD-PT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD0-0000JT-9z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=msqzWGYcv9Au49H/k1dTVXQtnssNULaw8wvTlGzlJUY=; b=zed8Qfmu190bBWJpU+Cyfzhxes
 nyZnk9wBdXjlDgu6YB1mLUR8zCv+20feEv7YVFs7nwCvkfNetinnU45CWX/0LZC/W1b9cD40DRExE
 KShyBbQCgNJBLxmbJ3V8V9wNibHM9TpanMfJ1ErR1LwRiXnBQPxI6fCpZJjDx2+vJjV/E+OqG+0Tx
 gWbMPQrMm1VV658UpPVaf/MMH/yKF8WRn/aBif5EHWCpHbAG3UCMcSKedKPYI9EAxp+MhcMaliDaz
 U759TJhxJ0gZn89pAo0FgE+Vg0IN3KhGBMdLCZBtBZ05dhhLJ0bD8ZGm0vY3Ayg4mD7hBtLWmZyPd
 GXsDEnNnQk/3NV7475963DlsreXXbXIY4OuIc+c4Hz1aUHyMTxi0onybv45Zgoz5gzKU9y2ubzwRZ
 t8HrxepSY5eq4ZoZK1rG3zRAYY8eFdXUrQWggcz/TqOzR0cn4jTohmpA+1YxMGC23e0TeUOMNqaUs
 Ui4tgdexy715/gTAambSw3qD4feZVQ+MawMSq/uD8JrcUmRATxUZYkrs0BxFZoT5a8Ph5ieqK9hAK
 Ld0yAB1P9xoYJF7nKs9JdGwVKvvnlt7M83y5Y152LdrdLBlsw00vHxsADvAT+vYzxcuT7rSCTc/1+
 l+e0FltEyCzs6ou/gxR1Dyh4T+3mvmhr0f9tplUuo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCg-0008EL-8W; Wed, 23 Oct 2024 09:58:58 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:18 +0100
Message-Id: <20241023085852.1061031-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/36] next-cube: remove 0x14020 dummy value from
 next_mmio_read()
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

This is a dummy value for the SCSI CSR which appears to have no effect when
removed. Eventually the reads/writes to this register will be directed
towards the WIP implementations in next_scr_readfn() and next_scr_writefn().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 7a503e0707..4e8e55a8bd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -286,10 +286,6 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
                         size << 3);
         break;
 
-    case 0x14020:
-        val = 0x7f;
-        break;
-
     default:
         val = 0;
         DPRINTF("MMIO Read @ 0x%"HWADDR_PRIx" size %d\n", addr, size);
-- 
2.39.5


