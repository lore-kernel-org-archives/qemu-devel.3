Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B06C54F32
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHiG-0007YY-3i; Wed, 28 Aug 2024 08:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHiA-0007S8-J9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHi9-0001CW-53
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=iDYp5gaIqo5J6zZ1j+lA7kex8q6EDB2TjHYn/k4kYzg=; b=a90FM8UQIokhtJjW6rY/VneWto
 +rVb0LxtKHzBql7hXC9TrWklNMkIeRcEeGK1iiAKxpAUNN1VK/B8kdf2fx+VV1tndz3t/ZfzpfltB
 0GNVqmTni2cwOjjqn8hb/tZrgO4WlnDbPk58S9P2+53dWGqP9Evgar1rvy5ct0ziZTZZ9YROne1fw
 K1cN0dNl/egywluwFbJ8eKTHLY/w7OaWTKWee63BpnY3Dp1L6XaiHt1FoK6FY222QsHeRtCFR9xCq
 Hegmve8BdYL8UFSshDdPV1k04CjtAZIxTjY6rAo9ZBd24YnEWzUvP0bhMGcfPaM7H3OpoNQr2xYZV
 IXXk97b/JzUrzv2QeJOLa/v40xDMuFEQ29+83cEkRhHUBCiGXDYms7uYV1l2SboISYo9J/mwcVh9e
 GDU6pIyhy2t3PupTyNSYyr9bYdHDrEPEUX6dppTu5QDZn5psl54C/feaR5ZFmFgiG0crE7iz/TQiI
 2UDbjVDBMIIWszWqtl2cCdR55p88Xdllejc4PW1yKF5XR7N3xky/2FwVipH6TpQwzWr8lU8HyEtLK
 D38MO7Mo4w5OHetTGYa1p445rNxJ4CzTVw7WO5wnU+D3P7qKNRkQpCsKSfENCHqmnE6DRjtb2P4Ip
 PPGAZfX9rgIPYDQ0PxeDvkOUNgqevHYP48Y6ZnN8c=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhq-000B8d-RS; Wed, 28 Aug 2024 13:23:26 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:56 +0100
Message-Id: <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 7/9] fifo8: add fifo8_peek_buf() function
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

This is a wrapper function around fifo8_peekpop_buf() that allows the caller to
peek into FIFO, including handling the case where there is a wraparound of the
internal FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/qemu/fifo8.h | 14 ++++++++++++++
 util/fifo8.c         |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d1d06754d8..d09984b146 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -76,6 +76,20 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  */
 uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
 
+/**
+ * fifo8_peek_buf:
+ * @fifo: FIFO to read from
+ * @dest: the buffer to write the data into (can be NULL)
+ * @destlen: size of @dest and maximum number of bytes to peek
+ *
+ * Peek a number of elements from the FIFO up to a maximum of @destlen.
+ * The peeked data is copied into the @dest buffer.
+ * Care is taken when the data wraps around in the ring buffer.
+ *
+ * Returns: number of bytes peeked.
+ */
+uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
+
 /**
  * fifo8_pop_bufptr:
  * @fifo: FIFO to pop from
diff --git a/util/fifo8.c b/util/fifo8.c
index 1031ffbe7e..a8f5cea158 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -140,6 +140,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     return fifo8_peekpop_buf(fifo, dest, destlen, true);
 }
 
+uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
+{
+    return fifo8_peekpop_buf(fifo, dest, destlen, false);
+}
+
 void fifo8_drop(Fifo8 *fifo, uint32_t len)
 {
     len -= fifo8_pop_buf(fifo, NULL, len);
-- 
2.39.2


