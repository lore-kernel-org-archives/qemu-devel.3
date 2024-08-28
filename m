Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAC8C54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHiL-0007j8-0l; Wed, 28 Aug 2024 08:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHiH-0007f3-Ph
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHiG-0001DO-BC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8A2FICmUmjowEj9RLWXSg7/Kx8EQAw4oc04eFwo72Js=; b=rSZEKM8DBeC5Slg1ILZ2eBVoNg
 p6jsOBm6e4VQe3tAlI7sC75ihGSkJ3ncO/BIiYCaYDd9jwHpCwok+lstzaPJhSZ9C7bNwP3upJSSS
 XIOpXJ/NVYwxvmrlBDDdUcVlG9HrbzFAap34aE/r2LLXTet8ePJZhhoxQKG2w4sztJDbcDK43+q2y
 9EeaKWfnun8B/6eefn2A/hlcyv8PbZgZ1Joow7onAdTp0xyjo4hewSyQIVruM12/TMcCmNNpMPvLq
 8apwfXUffFCTuHtqQo8xppbDbyjAW+vz7D49r7IPJLklttxo7//XBum973i7vrrlwLyVp6veYOxVF
 sQ7f9DKXMZ/5GO83PTLCwJGZzTZ7Fc26DjjB60T4FshrtrwInMOy8NS0srznWu30i8lsJ0KPETDWH
 cGCGeYgn64J1nkSkQs3yY1a6ai4x0R9pjurVO9F6KiQniJWPVvoPXta8mf3tmQqSeD0nW3HmEZV+M
 oG0hX0QmOP1BcLYEeNdLRL2JAlMYkyyj2vR6Fi2qv6HLc0A8Udx4LlVTYhTak3I23nsmIMJWit6HJ
 8/PFUZCs/1XMNfyqGfoC4UrZyDYcDFtKfJyyXPHM0ibK4VgMy58YQVp51Uv+DxXKnq2o7657xCECO
 554uBduUFf8S9g8EBRFeuke7HTFyNvWPBLd52T394=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhv-000B8d-1O; Wed, 28 Aug 2024 13:23:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:57 +0100
Message-Id: <20240828122258.928947-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 8/9] fifo8: introduce fifo8_peek() function
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

This allows uses to peek the byte at the current head of the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/qemu/fifo8.h | 11 +++++++++++
 util/fifo8.c         |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d09984b146..4f768d4ee3 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -62,6 +62,17 @@ void fifo8_push_all(Fifo8 *fifo, const uint8_t *data, uint32_t num);
  */
 uint8_t fifo8_pop(Fifo8 *fifo);
 
+/**
+ * fifo8_peek:
+ * @fifo: fifo to peek from
+ *
+ * Peek the data byte at the current head of the FIFO. Clients are responsible
+ * for checking for emptyness using fifo8_is_empty().
+ *
+ * Returns: The peeked data byte.
+ */
+uint8_t fifo8_peek(Fifo8 *fifo);
+
 /**
  * fifo8_pop_buf:
  * @fifo: FIFO to pop from
diff --git a/util/fifo8.c b/util/fifo8.c
index a8f5cea158..a26da66ad2 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -71,6 +71,12 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
+uint8_t fifo8_peek(Fifo8 *fifo)
+{
+    assert(fifo->num > 0);
+    return fifo->data[fifo->head];
+}
+
 static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
                                            uint32_t skip, uint32_t *numptr,
                                            bool do_pop)
-- 
2.39.2


