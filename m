Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D4DC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraDZ-0003b4-Gt; Wed, 05 Aug 2026 07:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDQ-0003F9-OI
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraDO-0007VI-OE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+mn8Fo4wRhA3/jQoXvREfwdebgX2hlAP3FIOa8NaHI=;
 b=eTgSNxyzSkhMi4ek0xwFnlGBD4+nNA1R470FyPfG5Ak40saV0FFLIhCWc1nKlj5qyuS0vO
 lI13Sgpbr5NnY8b9nb7OG/uET1rjTGpnsPKhU3Wb7fF9HvUBAVML08ddoREDhpt3w6qHb1
 3scL7ji2x8vhel8fl2yQJSqqzfO/8og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-_txZ32U7P36FGa2I13lCqg-1; Wed,
 05 Aug 2026 07:55:16 -0400
X-MC-Unique: _txZ32U7P36FGa2I13lCqg-1
X-Mimecast-MFC-AGG-ID: _txZ32U7P36FGa2I13lCqg_1785930915
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6C291956096
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:55:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE98D180049F; Wed,  5 Aug 2026 11:55:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:13 +0400
Subject: [PATCH 23/27] hw/usb/dev-smartcard-reader: validate per-command
 dwLength
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-23-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5043;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WXD5bjOCbmvtoyIanJkHCKNFdnCHhPyegVWy81kKbKw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOvwStEkUaNO5ugHbc1K4MKEk3rRwregzMh+
 AJGA5P0FyuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrwAKCRDa6OEJdZac
 5YIuEACNdXq3rFVzuIyTILCqcDj2360nHiKqfwEO6QakpN5e8kkG2P94Yur5czTgZDAGhLANkhP
 do6kVfxIxXw298zbvHwRfctaO8Ct8oExYdaDQ1KZ6A00oiiHTsNg1x69zCgjR5VbsENu8y58Ehn
 NFWzvcpnbnR9U5LeeDrZvoukjCI8KHjDNBPG7KEjkDKTkUYgfrNHUiYZuqp66wAQm98hvwtzo+r
 aYtAAEAaToBwKgOXk2q/uU2KL1dMEbbqs/zh2+zBKaMLQb34g6s3A3OTDq+vaG0VPiA7lE9nV72
 6ZSzT/1fXAjBWYBWI8MBcolF7SfTtAXUhibkYsaNk0ruxj49uQl1flqIduyLdNOZK2wKa6JdHQ5
 WOjHXkdNvWH8JcALT0KGLM9Q3AweekuWGkWhsH6DA9I2fx2b04axASLU9udeM2rJcyEEvZSVIXj
 IHzZZvj1a/YozZmkdTrM5wOMWXxIaj0ZNIdPxHyF+Y3fN396qxAFL7ZcgltwrJ69eK266adeTbm
 JiilcavHXJIvPXByjM3nkK3usqxsFxqbKPRPuOBuY94yIFON+grC8r24Si/O1bYTRykcBJVhhmi
 qskE1POCqYb2HA0ujaJCZpU+US7bgHHCCe/PiyKnd2WcLFfNNvOzsx9cRJJGuSoqpQ3os7LaH04
 mT3ZSOai6D5S0CQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The bulk-out parser validates that dwLength matches the received byte
count, but does not check whether dwLength is correct for each command
type before dispatch. For example, SetParameters copies protocol bytes
from the payload even when dwLength is zero, reading stale data left in
the fixed bulk_out_data buffer from earlier commands.

Add per-command dwLength checks before dispatching:
 - Commands with no payload (GetSlotStatus, IccPowerOn/Off,
   Get/ResetParameters, Mechanical): require dwLength == 0
 - SetParameters: require exactly 5 bytes for T=0 or 7 for T=1
 - SetDataRateAndClockFrequency: require exactly 8 bytes
 - XfrBlock: variable length, already bounded by the buffer
 - Secure, Escape: variable length, unsupported and no payload access

Malformed messages are rejected with ERROR_BAD_DWLENGTH.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index a973a0396bb3..bee118cb4ff9 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -167,6 +167,7 @@ enum {
     ERROR_XFR_OVERRUN       = -4,
     ERROR_HW_ERROR          = -5,
     ERROR_CMD_SLOT_BUSY     = -32,
+    ERROR_BAD_DWLENGTH      = 1,
     ERROR_SLOT_NOT_EXIST    = 5,
 };
 
@@ -1180,9 +1181,15 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
             ccid_message_type_to_str(ccid_header->bMessageType));
     switch (ccid_header->bMessageType) {
     case CCID_MESSAGE_TYPE_PC_to_RDR_GetSlotStatus:
+        if (payload_len != 0) {
+            goto bad_length;
+        }
         ccid_write_slot_status(s, ccid_header);
         break;
     case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOn:
+        if (payload_len != 0) {
+            goto bad_length;
+        }
         DPRINTF(s, 1, "%s: PowerOn: %d\n", __func__,
                 ((CCID_IccPowerOn *)(ccid_header))->bPowerSelect);
         s->powered = true;
@@ -1193,6 +1200,9 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         ccid_write_data_block_atr(s, ccid_header);
         break;
     case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOff:
+        if (payload_len != 0) {
+            goto bad_length;
+        }
         ccid_reset_error_status(s);
         s->powered = false;
         ccid_write_slot_status(s, ccid_header);
@@ -1200,21 +1210,38 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     case CCID_MESSAGE_TYPE_PC_to_RDR_XfrBlock:
         ccid_on_apdu_from_guest(s, (CCID_XferBlock *)s->bulk_out_data);
         break;
-    case CCID_MESSAGE_TYPE_PC_to_RDR_SetParameters:
+    case CCID_MESSAGE_TYPE_PC_to_RDR_SetParameters: {
+        CCID_SetParameters *ph = (CCID_SetParameters *)s->bulk_out_data;
+        uint32_t protocol_num = ph->bProtocolNum & 3;
+        uint32_t expected = (protocol_num == 1) ? 7 : 5;
+
+        if (protocol_num <= 1 && payload_len != expected) {
+            goto bad_length;
+        }
         ccid_reset_error_status(s);
         ccid_set_parameters(s, ccid_header);
         ccid_write_parameters(s, ccid_header);
         break;
+    }
     case CCID_MESSAGE_TYPE_PC_to_RDR_ResetParameters:
+        if (payload_len != 0) {
+            goto bad_length;
+        }
         ccid_reset_error_status(s);
         ccid_reset_parameters(s);
         ccid_write_parameters(s, ccid_header);
         break;
     case CCID_MESSAGE_TYPE_PC_to_RDR_GetParameters:
+        if (payload_len != 0) {
+            goto bad_length;
+        }
         ccid_reset_error_status(s);
         ccid_write_parameters(s, ccid_header);
         break;
     case CCID_MESSAGE_TYPE_PC_to_RDR_Mechanical:
+        if (payload_len != 0) {
+            goto bad_length;
+        }
         ccid_report_error_failed(s, 0);
         ccid_write_slot_status(s, ccid_header);
         break;
@@ -1227,6 +1254,9 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         ccid_write_escape(s, ccid_header);
         break;
     case CCID_MESSAGE_TYPE_PC_to_RDR_SetDataRateAndClockFrequency:
+        if (payload_len != 8) {
+            goto bad_length;
+        }
         ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
         ccid_write_data_rate_and_clock(s, ccid_header);
         break;
@@ -1245,6 +1275,16 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     s->bulk_out_pos = 0;
     return;
 
+bad_length:
+    DPRINTF(s, 1,
+            "usb-ccid: bad dwLength %u for %s\n",
+            payload_len,
+            ccid_message_type_to_str(ccid_header->bMessageType));
+    ccid_report_error_failed(s, ERROR_BAD_DWLENGTH);
+    ccid_write_error_response(s, ccid_header);
+    s->bulk_out_pos = 0;
+    return;
+
 err:
     p->status = USB_RET_STALL;
     s->bulk_out_pos = 0;

-- 
2.55.0


