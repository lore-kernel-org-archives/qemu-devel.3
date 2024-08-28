Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541DEC54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHhu-0006Rc-TZ; Wed, 28 Aug 2024 08:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhq-0006P4-0n
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHho-0001Ae-HU
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Whi/OJqkMAmmCjgxXKWJaew88JUq9AzmR4knGJiiXTY=; b=UVFLvsTnoazAzV0jbwjpVU7y5T
 CM0NUKsNXco+lFY4Cc+1WFTiuPNjFfKoOFpvaKSyBQZOlnh6s/Elb9ihCwisMqMSkeXcayoth8KyM
 0qg33CeeVvAFapEsvYvHJGlJy00BLroNlACS+cz8Qm2CbxnyvTNsmZiGyAWsLqDBtS8WXLJNx2eQw
 ZY2iVvJiR9p004EcoZO1lo30fE35IRbIXBp5rOIrX4ociS2x+aBKMhi/2C6rInVCw3Y0hMTGf8Q6U
 9kA/LYY0hKPvkKKghq+rO0JG7XdFqv9dqP5HuR/ODUP1YA2hNQP05j9ploR7wq02U7zFiHd2+qFaF
 7t6AHRU0oFOIotZ+LZVEhpWvov6iI/xwYEllks9FAy1jtFtg2C4sOpzTfUb2RYSclWY5AA1ILjhS0
 3Aj7fYWmoZoFI9dMilpUVPjxstSVjX17GWeGDvsgstxXGA6k4lVhFkRkY61rZ2Kyxbxo87AKhf7Ph
 gpPrGh+Io8fDgt2Kn70p8u9WgH/jC6CTxRupymjFtfw/cJvnM7pWxhC9z1Ip0wG2W4RXID4ShIRGG
 +9Qp2VKEAMOEc51oPXemcHtDimdwQ9/x8Y/nXUafI7efI3Cg8FmpINETFH5WxImr6eakFstQamjVt
 8SymRxrbPWTsvnW26l2Q1QJmFLlzaJATizFmwawxg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhV-000B8d-Kv; Wed, 28 Aug 2024 13:23:05 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:51 +0100
Message-Id: <20240828122258.928947-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/9] fifo8: introduce head variable for fifo8_peekpop_bufptr()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rather than operate on fifo->head directly, introduce a new head variable which is
set to the value of fifo->head and use it instead. This is to allow future
adjustment of the head position within the internal FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 61bce9d9a0..5faa814a6e 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -75,11 +75,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
                                            uint32_t *numptr, bool do_pop)
 {
     uint8_t *ret;
-    uint32_t num;
+    uint32_t num, head;
 
     assert(max > 0 && max <= fifo->num);
-    num = MIN(fifo->capacity - fifo->head, max);
-    ret = &fifo->data[fifo->head];
+    head = fifo->head;
+    num = MIN(fifo->capacity - head, max);
+    ret = &fifo->data[head];
 
     if (do_pop) {
         fifo->head += num;
-- 
2.39.2


