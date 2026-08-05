Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EB5C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraCq-00023f-DO; Wed, 05 Aug 2026 07:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCi-0001wE-Hy
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCg-0007RI-Sb
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZBhjxoc9FDfKhS6e23d1epvZEMzL+UHcqW72/TxVs8=;
 b=fXH7vEBtCnPh1N64SOUCXdZ+cJrHKRY9DluKpi9x8kDYMfyyjLXysdWZsIYvR5vKzn2opA
 u7FTvUHUHqm2+jYQ8xWlYNbCuIQ5WI9/ynYFeqsjLP6u3SdKs+AKSvWmQ9UlbzfihS+fd0
 7x8SqBane/ZgV81NScdsfYGkTINJJOs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-PChGU9wZM8SDxtBYDX_LMw-1; Wed,
 05 Aug 2026 07:54:32 -0400
X-MC-Unique: PChGU9wZM8SDxtBYDX_LMw-1
X-Mimecast-MFC-AGG-ID: PChGU9wZM8SDxtBYDX_LMw_1785930872
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18B57180034F
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:54:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 050861956041; Wed,  5 Aug 2026 11:54:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:09 +0400
Subject: [PATCH 19/27] hw/usb/dev-smartcard-reader: reject commands for
 invalid slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-19-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oHi+ugEI+1CrxuDbJP2mregTFzCdGRz1gev+6CPEJM4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOuGhJH7Eqm4bluUHVfPlHpD43D2/P9gJbsE
 qSi9Kp8KKKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrgAKCRDa6OEJdZac
 5bcwD/9NjLyKwmtEZnR4kFIbArTIktS6oTo/5wX6odTSJ3IPKkoDcG68+DN8l9quFX3yBn5s2k5
 H65jqAzfCwdiiwaZt/Au7WdsjXuhYupRKqcksLGjAYjsfkDWuurLPd9AiOhRJ8vX8GYu55L0Bx3
 HswVLi8uX18L0UKowLvrZX79bt2VA7W1ujCM0aD2O9x3amuEsnyVI/uFJnIQ79f7XJtYC2apH0D
 soJicFqeMen9plDKAbyOlCUAzk8L2DYsuhM+hYQgE/XiEZYEajpdblDCypHId2hrJqigW2kP8v5
 BFifTH7Vq1M1/smIHIpgWmopDfve+UVkPiSPwKeulQMt8OtAaSFO7si3ogKrONZLmNqd1ErY/d7
 AubThbo6Yet9zIl1OmGGjngT7rHK8tTp8wYiemb+3wCzFtSDUY6o24LzWTZaDxehRr5SQ9Ub7l4
 grTQS+how82WvMtz5oHFMs5DJ9KS31KuPD6LcZkT6AUENkCPkf9WEbyq+GyK1liDqBuFCV6MXSS
 TzkemeISY7WEqOvlWtkm4oyqhSEhZCGMkTxCuotulX6bp+fyjgveIUJrw6mrk5gqDvQPeg479eg
 oumHiPWJx7QJbqwnIzW/LwDCOno+pCQie7LGYlpZ2FNvkWhEdgC6eN/+/L/UJelamnVja7txNO+
 p341yev1YVgNXuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.55.0


