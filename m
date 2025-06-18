Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EA1C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2v-00023g-56; Wed, 18 Jun 2025 02:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2j-000229-8r
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2f-0003x7-Cq
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nNbqaq73wvELgQmDX95TXQpt1EGVEYkXwH7FUiKjs7g=; b=MWZL1JlcNbluPRoyP1HW59x1Vp
 sODclLs4sX6R5zf+PnRUfCOrMbZZwc7/VMFTV3Co3PTlVnpH4nd06p1Sw+dxkVbgiSIKe6n7rGISz
 DyeDEzpRJJw5uYMNsVuFgYguAmynaHr+Q11xhY7Bu7OBs951XZTf7++X9a33L5DZ+SmIYz3KvbBoa
 g2pi6Gpp5bDE9qL2IbT587V4Graep7fUmkguYsTbwQsfpMzSinyMiTX8WJVk6cEFnB5j3UivQ3Zri
 RC1bh9stLmpBgtO4AtKcoIZ2HPI+j6AQ6lZx9jrsdrJnMMDtE8oU4Wm/ih6QVd9Eo3xRhm3nFtyzW
 S1DHrAK1uKI9CobtRNbVNQ6qWuQIsoij9EN83LGz2dlJrGL346ep1XtjC5nEVK7U530VKc3c50NnD
 WnjnJ2KkvmcRSUw7S0qOEwwNa7qFCF4e+SdgIHtTSKCh5Rgb/jEc+3tny24mV06Jh4AwzSzJD5Z3x
 LOjiVtH2Ny9FJAZcqaBIUhLi3e5T+QezCQXmtukdUCW6ukdpj/yl3R27aM1K76JxVdYY/b6YTJNbJ
 efhL8sbw0XldGJtqyVgnrz4wGK8Par6ff+bnu0DgCFpSR/2xCR5hEWRxoh1n7OvdIamvH37WWBuy/
 lkZIeBPaSguzHiA3pPvtcZGtknZh6YfaM3NCV2aB8=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm19-0007ok-4E; Wed, 18 Jun 2025 07:11:27 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:45 +0100
Message-Id: <20250618061249.743897-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 3/7] esp.h: remove separate ESPState typedef
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

This is not needed as it is now handled by the OBJECT_DECLARE_SIMPLE_TYPE() macro.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/scsi/esp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 533d856aa3..c9afcb7cac 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -14,8 +14,6 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
 #define ESP_FIFO_SZ 16
 #define ESP_CMDFIFO_SZ 32
 
-typedef struct ESPState ESPState;
-
 #define TYPE_ESP "esp"
 OBJECT_DECLARE_SIMPLE_TYPE(ESPState, ESP)
 
-- 
2.39.5


