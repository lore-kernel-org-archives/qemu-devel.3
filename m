Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C037CCF2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB1x-0007kb-6P; Sat, 17 Oct 2026 16:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1A-0006O2-Kb; Sat, 17 Oct 2026 16:28:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB13-0003xs-AN; Sat, 17 Oct 2026 16:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268842; bh=Z+37PwjUJ7yxLliNYq69AncpPD48DSUwO+aZK4c6kR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qsPemA5a6CjVBFAD1gK/cOnz9c7ElXbesF+i2NDzUrQSZy16Qy/Oji46Szfx8lkSL
 aWnSNT24kpyna4iG24rssAXGIufIQ5i8YTQtWZR4vH7Ydp+wB5DXPLFtjhlVW1Rv9Z
 E3NwV7mwd+wUSm7plm9oa6z65AL69prVgdl76WQRTZD5JCHvTNvzSPWVzp2j9TcKx7
 2qpfvePEitoli4a4H103MlHUuVorBt95lCQ0R87NoyZK9DeGmmiyAc4iCBV2z+qOFl
 7QdxuzSuqq6zJVXNYxIvKRbZDbRLr5RKW+J6TDEzSChhb5DxRtyl/tyKy9Q68c0YnY
 NpXo1ALYBm4oA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 31A471DE74D;
 Sat, 17 Oct 2026 23:27:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C52A443424;
 Sat, 17 Oct 2026 23:27:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 18/73] hw/usb/dev-smartcard-reader: decode bulk-out
 length as little-endian
Date: Sat, 17 Oct 2026 23:25:36 +0300
Message-ID: <20261017202638.728621-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The CCID Rev 1.1 specification states in section 1.3, Document
Conventions, that fields larger than one byte are stored in
little-endian format. The bulk message header's dwLength field is a
four-byte field described in section 6, CCID Messages.

Decode dwLength with le32_to_cpu() before using it to assemble and
validate Bulk-OUT messages. This fixes message handling on big-endian
hosts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 069dcc103be7600f2197ecb202c8276022fc35d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 9cbacf08e7..4cb5f6e1a4 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -993,6 +993,7 @@ static const char *ccid_message_type_to_str(uint8_t type)
 static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
 {
     CCID_Header *ccid_header;
+    uint32_t payload_len;
 
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
         goto err;
@@ -1005,17 +1006,18 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     }
 
     ccid_header = (CCID_Header *)s->bulk_out_data;
-    if ((s->bulk_out_pos - 10 < ccid_header->dwLength) &&
+    payload_len = le32_to_cpu(ccid_header->dwLength);
+    if ((s->bulk_out_pos - 10 < payload_len) &&
         (p->iov.size == CCID_MAX_PACKET_SIZE)) {
         DPRINTF(s, D_VERBOSE,
                 "usb-ccid: bulk_in: expecting more packets (%u/%u)\n",
-                s->bulk_out_pos - 10, ccid_header->dwLength);
+                s->bulk_out_pos - 10, payload_len);
         return;
     }
-    if (s->bulk_out_pos - 10 != ccid_header->dwLength) {
+    if (s->bulk_out_pos - 10 != payload_len) {
         DPRINTF(s, 1,
                 "usb-ccid: bulk_in: message size mismatch (got %u, expected %u)\n",
-                s->bulk_out_pos - 10, ccid_header->dwLength);
+                s->bulk_out_pos - 10, payload_len);
         goto err;
     }
 
-- 
2.47.3


