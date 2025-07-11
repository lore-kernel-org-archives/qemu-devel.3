Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755FBC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKfO-0004Rq-CQ; Fri, 11 Jul 2025 16:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdt-0003Ji-Ux
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdr-0003jI-AL
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+pg3U2MlgD5Mm9wqpVaAXbSZ7dQrwSODtzqh3LXUiqc=; b=gqum/FqlYUyLYXezRAi8VdbkVG
 XEbF/fyrjVSVZCAo8e/kV7I32Di9glLoROef3ppa/Ql7Na1MzvWDz2VlHvbTgR/i7jO0QCu5QPdey
 83mHh7oltPZC3MBa8sOcuHgy8+aMnnmzqXKqIcswvqLl+xfRUUvic/YdzQuJBUyG7yq+fuVJ+BVXI
 9U1QAHmcNaLlQfLBJ+6iaKoZoMNhWWZKhWXhSctzTicOSSpTYBCPJHX8RjXBhi00lmgJ3r6wde8Iw
 Mwe/Ic22foeuD7w8MxMxGc/Ty/R32tudj2CWjfl1SjfiEce8RTApjHPEO1ATFUoUCtMUoBcpHQnto
 WckpWKdaC+Q/jdJwd692jAZD8cecbwVlXs1FEWWAdFtZjn2K5GFAjkNeJsuHICK2quNfoEYsxGgOY
 ggKnGilCYSHNJ87XBu1wGNQJqehzgATipfMKhfpjyyjTE72e/nORzsV9nC/clC7OViIiwXxyoOTYS
 cDL98xPALQ3la/JRwshz5F3JTAQQhtyys3GmVFize1jXaAw9o6vGZkaCMeRz4vwdZfZ6Si3oxA7eQ
 v5l5KHrJu4ziIqjmGgNnmNfFjlL7Vp5U7OKgbSPWDmaIJfh/QXNo1q24UtVXow8AFEEYwmJV29JRF
 5j2C+09y0CvARHHhvq/GMiaMRxi5ndxsCM8CO07Lg=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKcC-000Bmy-ST; Fri, 11 Jul 2025 21:45:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri, 11 Jul 2025 21:46:32 +0100
Message-Id: <20250711204636.542964-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 3/7] esp.h: remove separate ESPState typedef
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


