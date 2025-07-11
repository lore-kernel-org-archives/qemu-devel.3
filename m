Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C28EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKg7-0005Er-5w; Fri, 11 Jul 2025 16:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdu-0003Jk-2u
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdp-0003iZ-Rp
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=+qXG//7cV/tOhO5HxZNci968/4W2bBKUGJuDsIaR8Dc=; b=QNGsXCccYFDH1oKSJEewNLrQDG
 3vEg+Xr20APDvQQ4kpnb1fLv7e/pviJWT+Vs9TaMwmvwEL4u8GngZSAeEFLbaq9SZkmciGSYxH3m6
 S7BvGpZ6cQpK+UkuLRVi3rs+DqdhwSSLM4f9frWiWvY3WgRl3K/UiMmFfNHvrJT5z7utb50YnSiun
 RacA2NC03tPBs2OPKUupjzkHvarXY+cnHcN8SUBA5rT92vk89ko5MMQeR0Tjvw+O+Wa7Ayktm0+Hu
 w/k2t3ECdOCzvw9h1Thk9QoeYnBTL1mbRlQhLL2S6l8qOVWM4D1K1zkXj2aVdytNHR888aStrpWqD
 zi3ApVU+h85iueoHsqf+uaoTUTCWNZ7vIf8MVNVVIBioNTSZ29B1doMQebawRiVkdvxlCNMFQXXb8
 y+9WB+8SqiTPK8Iyg1Jx5Ew8uYS2j+R7hhPuCaG9jYsmaGwnhGtUMbMMsGEBhTAzr8HU1SeQKagzy
 nH0DVYQUdk82vlznauvL4ruP8YtuYOgjaIx735uxeQHGd7cIwPVarvnkPYi0f4oK8a1qwFNXPEmRY
 BeOpA+mLRkTzT4SH4tVgbLX+oQWDwmcS/ujyFf3ECZ5/PUW0UxMThSEHmj9GGUFIewA8BNORwUXBf
 jcyrdJqdOLcmaegIeh3iaF8ku0Urw0nZhA2BUuqNY=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKcB-000Bmy-Ni; Fri, 11 Jul 2025 21:45:04 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri, 11 Jul 2025 21:46:29 +0100
Message-Id: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 0/7] esp.c: only allow ESP commands permitted in the
 current mode
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

This series contains a few minor tidy-ups along with an implementation of the
logic to only allow ESP commands permitted in the current mode. The motivation
is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
boot.

Patches 1 to 5 are simple tidy-ups from investigating the issue. Patch 6 adds
a new asc_mode variable to indicate the current ESP mode, whilst patch 7 implements
the feature which fixes GitLab issue #2464.

Note: this series is being reposted as both the SeaBIOS and SeaBIOS hppa binaries
currently distributed with QEMU have now been fixed so that they do not use an
illegal ESP command sequence.  

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v3:
- Fix typo in comments for patches 4 and 5 as pointed out by Phil
- Add R-B tags from Phil

v2:
- Rebase onto master
- Add patches 4 and 5 to avoid calling the DMA functions for zero-length transfers


Mark Cave-Ayland (7):
  esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL, CMD_SELATN
    and CMD_TI commands
  esp.c: improve comment in esp_transfer_data()
  esp.h: remove separate ESPState typedef
  esp.c: only call dma_memory_read function if transfer length is
    non-zero
  esp.c: only call dma_memory_write function if transfer length is
    non-zero
  esp.c: add asc_mode property to indicate the current ESP mode
  esp.c: only allow ESP commands permitted in the current asc_mode

 hw/scsi/esp.c         | 94 +++++++++++++++++++++++++++++++++++++------
 hw/scsi/trace-events  |  1 +
 include/hw/scsi/esp.h | 15 ++++++-
 3 files changed, 96 insertions(+), 14 deletions(-)

-- 
2.39.5


