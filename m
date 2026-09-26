Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659E9C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAN5I-000321-Tr; Sat, 26 Sep 2026 03:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAN5G-0002y8-CM; Sat, 26 Sep 2026 03:44:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAN5E-0003z1-Uk; Sat, 26 Sep 2026 03:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=Fv4cckRwZssfYcXemfrGKadrSWk8I4LgaDUfALFmOGE=; b=sViM5TTnBnQtRDlN28Td9d3pIu
 n5CFjlvfgat5iPjLeLuvf2fntOXYJlcCHdQCaFKJnPNYTjcbzU5gtQYLI2he0Eq9dXODDLayM/9e+
 rzTlx+DKlReGK7ga42RZpxWidVFOPYuPDRGrKsoqd6MnKUMU+Qs4lk/I76vUnRC8IJvWKDZR3n/ay
 hzoQqEFO5keNaEDbMhcWkJ+02M8DN7ih3sSZn/GGh/CwRPW3cZaSGPNx/D06QUl1FehC2FHEy0CZq
 NKCGRWk5TaUkTV9r3fgirEI66Eb8eo98Ljn4WPre+X8PK+SzW5CHChxZa49VyYyvbSTr+6zVaKaPo
 T/S4n1XCoCQCIu0O1NWaCGFYfB82bbMc97PqzDGcDSuWYebLSZ6Y8fxYNf6PEB1wehXIWUq4vWzrd
 ZRMj7r8Gkl2oEDc3E5WSqKRnZv3jH9ZX0Gyj9J3/uyqWNqycp9wfacPN20HGRyMdcoyGabG96GQ1u
 DNZTF3gJTeYd7lDogvL0kqNB4Cjut6B/OKdxn/Kon8hjL1CW+8IpxdilPmADjZJuxxxEfdTLYqT/c
 pRB6tykFI8GI9u+GaLAOcS1snRgbvkaThTpXHpCbeF9kl1A6fbzybsC8Vtr+qemujUBXyvoukMcMs
 o4jwNIbVzcBvUx0FqByWsv6Ay8HroJ7nF8+SqqCS8=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAN4e-00FrMk-Qu; Sat, 26 Sep 2026 08:43:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, den@openvz.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Date: Sat, 26 Sep 2026 08:44:01 +0100
Message-ID: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] ide/macio.c: use pmac_ide_transfer_cb() for disk DMA read
 callback
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

Since its original implementation the disk DMA callback pmac_ide_transfer_cb()
accidentally made use of the CDROM DMA read callback pmac_ide_atapi_transfer_cb()
for disk DMA reads instead of itself.

Fixes: be1e343995e ("macio: switch over to new byte-aligned DMA helpers")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 40fb4f3b4f3..a95e68083f4 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -180,7 +180,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
     switch (s->dma_cmd) {
     case IDE_DMA_READ:
         s->bus->dma->aiocb = dma_blk_read(s->blk, &s->sg, offset, 0x1,
-                                          pmac_ide_atapi_transfer_cb, io);
+                                          pmac_ide_transfer_cb, io);
         break;
     case IDE_DMA_WRITE:
         s->bus->dma->aiocb = dma_blk_write(s->blk, &s->sg, offset, 0x1,
-- 
2.47.3


