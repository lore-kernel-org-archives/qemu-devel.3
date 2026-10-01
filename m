Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C0FCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsq-0000r2-Mt; Thu, 01 Oct 2026 09:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsS-0008QP-Sm
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsP-0006Qg-DH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgAjoKlWlgFbatzBUOK+3OCXUu7lHVO9JxwVqYlR4o0=;
 b=S1FK6EJamVHohIyHlBsFPPe3pbgp02b5YNqS+tWoT07mUF/u3gRbzXh9LKUeD7sjju0mGK
 szZnw2KG1vDKnGg1hn3xzZJCkAdSdh6sM8Di6hIHufELBaJdJSX0RVqnpKRAOwsqJvmtin
 CgEBbS3LX+UG1GVXYZJo20EVu2jl8NI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-IgYKrUROPqeC3XYZi3eM-w-1; Thu,
 01 Oct 2026 09:31:07 -0400
X-MC-Unique: IgYKrUROPqeC3XYZi3eM-w-1
X-Mimecast-MFC-AGG-ID: IgYKrUROPqeC3XYZi3eM-w_1790861466
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7C6193610C; Thu,  1 Oct 2026 13:31:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4CA41956086; Thu,  1 Oct 2026 13:31:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:02 +0400
Subject: [GIT PULL 23/27] hw/usb/dev-smartcard-reader: validate per-command
 dwLength
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-23-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=P1dRbwb8aB7dEsE7NIbX9x/0VcMM5uk/QA38FYSRtDc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBISdxkpUop+S1bCRy0rfhosEwsaMf6iA7s8
 kYCWu/COf6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5e1rEAC0ZPUBbpIksvPE09uF+iIM1DbNMVtiFc/KwMLRxMd1wGKXsTXL4Vt0XFhB1IuC7GBcwHf
 rGRdNrLWFyWN1RU1vfQ5AaU4lFAbetOxBtVvkKp3gMd2s8Fiy9I3M9nqRoYVFrYlgFI5GLbJGGO
 KgbpSht311RXyQ5qoZpdbc1TeW1elf4pe6x+yNoMA1bz6W/n2BunpFa3YtqOzOWc5VsjhHLJF0y
 CeKFA7QU/ta6/smdv/4vsU9wPll9sSsTgBQ5aFcTk7UESrgmpD0s3rKec38FN4f9llER+diuKo6
 tky2RHXVLXxjTnmQ59ljXLaD1HTdMdUMT3zM5LWHacupAhakuOltYj9ebLMowK9LpeAkTdChCnT
 Oj/WGfBE0hARf75vqArSKtJKLLkzVbiSzp61AcFZb1GzSaXrkP8dY/4YWYAP1prr6cYVCxzPHn9
 z3Jp7kzXFBu8h/1WO1f5r/l3o0g63Rw2QVQpKHXjAU7VkQwcErOeg44PNalSt2Iqp76d/J6geuR
 snCU3J/cncpswtlxanPneeF/uOT5jIdfd/N45XQ4T/fqersU0K3ZpTTwXC/knEanoZ7SQagdcIf
 yGu0u+vEJNmbs5A7fb6PTntnoiz73w08BChCQyGNnlblhKKPhy5jKe6RfPQG/k/Sr+LroKg7332
 j4qjZnfyFzSvT+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
2.56.0.rc0.29.g47ce80527c56


