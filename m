Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2030DCA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsh-0000OJ-OS; Thu, 01 Oct 2026 09:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsI-0008Du-LN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsG-0006Pg-LG
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DN7Mxa0B8HRLcN4XqlhXmrWW0C5sZzFO8HSNl+zMm0I=;
 b=AEzY4lm03QhoH+tWvxGKHSRxEY8/cPdNEIUvFbBpiNhcfuPl9kzhAvUHuBIyDkylC9tKwX
 gzA8L32VMD0v+f+fvAgMKaWMUw5UzPtwZPLgpWHDBHyv7iBw13dqH3NBauhIl65FvgjEpX
 /SlKkDg0ZoAwbk8B+Ykequps/wpr25U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-1DosZFyWMU2RgAu_BiZuag-1; Thu,
 01 Oct 2026 09:30:55 -0400
X-MC-Unique: 1DosZFyWMU2RgAu_BiZuag-1
X-Mimecast-MFC-AGG-ID: 1DosZFyWMU2RgAu_BiZuag_1790861453
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8067D19352FB; Thu,  1 Oct 2026 13:30:53 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A11A230000E4; Thu,  1 Oct 2026 13:30:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:58 +0400
Subject: [GIT PULL 19/27] hw/usb/dev-smartcard-reader: reject commands for
 invalid slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-19-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2809;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SM2yKYqDRqbJr7X/8a/vAfnwR98DbaY94wdf8nCxvnE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIjb80dAmcBdGoDC840+nG011Cl2x39k+On
 +SDBI+nJx+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5UsJD/4izFWuk6qSb+xcjueCSGe4+mmn956VWopayKZY8kBgkLur9TrlMLePTXfHPukvxM7OUOb
 ST6C35I/WOETmAQ3mTCVEwotl7tWr8H1xZJLrNKQLawHD/SwWRygWs9smF88vN4uvV12HYWl/MB
 /2GM22W4/vd6okGt3J81SakL3TxMysLZlAQrjPketdBsOXTgzl/909MvEB75LWQw0hI8Wo062Q/
 jQa/Jcs6OdwLi00FXnXYADNsHf3Il9+UOC4INWt9KXCF0JXYmiXwEHEcN3hG29nzm9vzAwuPI+l
 n7K6ukQFYq2KH9T4drDWeKN0LY1iWT63MM7t50wwfBk/v4y0Cb/y9I3rBi9ih4ecYMbTYNQZLOm
 txFXLRsMEYXw6tTESuEag1mo5ST7lGM6yyOS3YOhLwU+/0aTVhfVKRro69ZBgON7W5Gc6BZxg+9
 0f24+kyq3bwLa0tduHOAXRYY4fA9HFoc0dekWQiE/0PMT7c5t8ABaYRfA6VJ9ALKsMdf0Xn/2m/
 DkzBboKtX2nSfcml6SshWVeGVh8xobWHA/cO3rTXq+m7ATkRqdebqgnncollo6N0Q9HIJSm4GvR
 MHtafLtuYES9HRg+v/De1f7chHcQGxGlHvxhnBnEe8cR5HfvRt/VVw900xVyXRYyjAkYXl8D6sN
 gkBFVsX8vY9mz0g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

The descriptor advertises bMaxSlotIndex = 0 (single slot), but
ccid_handle_bulk_out() never validated bSlot. Commands addressed to
non-existent slots were silently processed against slot 0 state.

Reject them with bError = 5 (slot does not exist) per CCID Rev 1.1
section 6.2.7.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index e7bc5f6d4ae0..cc7356c77413 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -167,6 +167,7 @@ enum {
     ERROR_XFR_OVERRUN       = -4,
     ERROR_HW_ERROR          = -5,
     ERROR_CMD_SLOT_BUSY     = -32,
+    ERROR_SLOT_NOT_EXIST    = 5,
 };
 
 /* 6.2.6 RDR_to_PC_SlotStatus definitions */
@@ -1087,6 +1088,35 @@ static const char *ccid_message_type_to_str(uint8_t type)
     return "unknown";
 }
 
+/*
+ * Send the spec-mandated response type for the given command with the
+ * error already staged via ccid_report_error_failed().
+ */
+static void ccid_write_error_response(USBCCIDState *s, CCID_Header *recv)
+{
+    switch (recv->bMessageType) {
+    case CCID_MESSAGE_TYPE_PC_to_RDR_IccPowerOn:
+    case CCID_MESSAGE_TYPE_PC_to_RDR_XfrBlock:
+    case CCID_MESSAGE_TYPE_PC_to_RDR_Secure:
+        ccid_write_data_block_error(s, recv->bSlot, recv->bSeq);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_GetParameters:
+    case CCID_MESSAGE_TYPE_PC_to_RDR_ResetParameters:
+    case CCID_MESSAGE_TYPE_PC_to_RDR_SetParameters:
+        ccid_write_parameters(s, recv);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_Escape:
+        ccid_write_escape(s, recv);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_SetDataRateAndClockFrequency:
+        ccid_write_data_rate_and_clock(s, recv);
+        break;
+    default:
+        ccid_write_slot_status(s, recv);
+        break;
+    }
+}
+
 static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
 {
     CCID_Header *ccid_header;
@@ -1130,6 +1160,14 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         goto err;
     }
 
+    if (ccid_header->bSlot != 0) {
+        DPRINTF(s, 1, "usb-ccid: bad slot %d\n", ccid_header->bSlot);
+        ccid_report_error_failed(s, ERROR_SLOT_NOT_EXIST);
+        ccid_write_error_response(s, ccid_header);
+        s->bulk_out_pos = 0;
+        return;
+    }
+
     DPRINTF(s, D_MORE_INFO, "%s %x %s\n", __func__,
             ccid_header->bMessageType,
             ccid_message_type_to_str(ccid_header->bMessageType));

-- 
2.56.0.rc0.29.g47ce80527c56


