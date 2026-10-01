Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05D1CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsi-0000SG-3a; Thu, 01 Oct 2026 09:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsD-0008AX-GQ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsB-0006P8-3u
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQvwlMR7WJGHwGPjvK3E/5mXHq9s02IHsayg4Uy5eZ8=;
 b=eq7E1QyH3WN2Xrse8RGp1Pdw2kjN+ds11D1LLgmxRR/7/bui6aIKWD3PDhONx7iLhPs0ru
 Jd4VHRDZz5lyHMlpS09de8ewa4tPnzc3eAqh2/tIVs7PZVH78OLasiMDxqnw5zZLx78jio
 giR3Bn/DPQ0ntfYlW72784y91mJLuWU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-aKOExlNQOm2c8H8FWFgfDQ-1; Thu,
 01 Oct 2026 09:30:51 -0400
X-MC-Unique: aKOExlNQOm2c8H8FWFgfDQ-1
X-Mimecast-MFC-AGG-ID: aKOExlNQOm2c8H8FWFgfDQ_1790861450
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5179218015DE; Thu,  1 Oct 2026 13:30:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 884581800352; Thu,  1 Oct 2026 13:30:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:57 +0400
Subject: [GIT PULL 18/27] hw/usb/dev-smartcard-reader: handle Secure,
 Escape and SetDataRate commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-18-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4039;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5/u0AEmDWetIReYHl2Pewzh7es7Js72pCwhpZwcyf+U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIePipT89ITHU/lRiAE9c43t9Mwy0XM2Jww
 GlqO3j4AjGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5XYiEAChqFlqvnSbPZtNWvgCHIM0id+x73lsA9WRRIHeWp6OP/TXSoU3Ei29RzTqxAj6rX444gS
 xh7il/yZf+zCpFte66tiiGaS4ZcWqNqS8oNJ8aC/AUGC7oBZuuF79CIshMhJ3JLNvFTtVm9MR0d
 iPXSNP2EIAPcDqL62bbAvwmQZ0EMu1mkNvgV1M9xmcPmKmvJ0wYk4Fhar1EGHqEHrgE3sfTZL9C
 jdslpPGSLLUwDWGgABqNBbd/5Inzouzz7ToyhGV+bOXFmMideq7Ioh6p1XT2WfZ4vzt+mayREg7
 9zX0ziBih4k7X+igurfVbKRixc7kaAAnOJ3Ho0ImRhWAO/x9WinFrfn343bST8OadMxMW4kqbMg
 cdqJymFSFfHHBus2yW2hb0oGkccMrELdsl3GHJWO+W2mfAZiCZqFMTF5YaUk+HkC2Kuw19+spRe
 Q4vxqkVmLJcq+DVO8Mv2OrPN7T1Ti2XTqi30bGZQsPJ1kt+T/F5eHb6wCoq37DF2gXaLKEhKLUg
 PbaKHIURlvnfn1RvTUz0cSeqj7g2nGcbYfLivZQjOvVi1l0nOn1V5l6ZoRv5UQObSdUfc7zljUC
 FO7I8N+YrRVYwhtSIkWS9SwkGRuJEXdaPjKHNbYggKVxapBpxfr1st69ilLPrASOpw7ML7cr81F
 3JSMTprDUVO18tw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The CCID device defines message types for PC_to_RDR_Secure, Escape and
SetDataRateAndClockFrequency but the bulk-out handler lets them fall
through to the default case, which responds with RDR_to_PC_SlotStatus.
The CCID spec requires each command to use its own response type: Secure
must reply with RDR_to_PC_DataBlock, Escape with RDR_to_PC_Escape, and
SetDataRateAndClockFrequency with RDR_to_PC_DataRateAndClockFrequency.

Add explicit cases that report ERROR_CMD_NOT_SUPPORTED using the correct
response message types, along with the corresponding structs and
response writer functions.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 5ca50c111217..e7bc5f6d4ae0 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -232,6 +232,19 @@ typedef struct QEMU_PACKED CCID_DataBlock {
     uint8_t      abData[];
 } CCID_DataBlock;
 
+typedef struct QEMU_PACKED CCID_Escape {
+    CCID_BULK_IN b;
+    uint8_t      bRFU;
+    uint8_t      abData[];
+} CCID_Escape;
+
+typedef struct QEMU_PACKED CCID_DataRateAndClockFrequency {
+    CCID_BULK_IN b;
+    uint8_t      bRFU;
+    uint32_t     dwClockFrequency;
+    uint32_t     dwDataRate;
+} CCID_DataRateAndClockFrequency;
+
 /* 6.1.4 PC_to_RDR_XfrBlock */
 typedef struct QEMU_PACKED CCID_XferBlock {
     CCID_Header  hdr;
@@ -739,6 +752,43 @@ static void ccid_reset_error_status(USBCCIDState *s)
     s->bmCommandStatus = COMMAND_STATUS_NO_ERROR;
 }
 
+static void ccid_write_escape(USBCCIDState *s, CCID_Header *recv)
+{
+    CCID_Escape *h = ccid_reserve_recv_buf(s, sizeof(*h));
+    if (h == NULL) {
+        return;
+    }
+    h->b.hdr.bMessageType = CCID_MESSAGE_TYPE_RDR_to_PC_Escape;
+    h->b.hdr.dwLength = 0;
+    h->b.hdr.bSlot = recv->bSlot;
+    h->b.hdr.bSeq = recv->bSeq;
+    h->b.bStatus = ccid_calc_status(s);
+    h->b.bError = s->bError;
+    h->bRFU = 0;
+    ccid_reset_error_status(s);
+    usb_wakeup(s->bulk, 0);
+}
+
+static void ccid_write_data_rate_and_clock(USBCCIDState *s, CCID_Header *recv)
+{
+    CCID_DataRateAndClockFrequency *h = ccid_reserve_recv_buf(s, sizeof(*h));
+    if (h == NULL) {
+        return;
+    }
+    h->b.hdr.bMessageType =
+        CCID_MESSAGE_TYPE_RDR_to_PC_DataRateAndClockFrequency;
+    h->b.hdr.dwLength = cpu_to_le32(8);
+    h->b.hdr.bSlot = recv->bSlot;
+    h->b.hdr.bSeq = recv->bSeq;
+    h->b.bStatus = ccid_calc_status(s);
+    h->b.bError = s->bError;
+    h->bRFU = 0;
+    h->dwClockFrequency = 0;
+    h->dwDataRate = 0;
+    ccid_reset_error_status(s);
+    usb_wakeup(s->bulk, 0);
+}
+
 static void ccid_write_slot_status(USBCCIDState *s, CCID_Header *recv)
 {
     CCID_SlotStatus *h = ccid_reserve_recv_buf(s, sizeof(CCID_SlotStatus));
@@ -1123,6 +1173,18 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         ccid_report_error_failed(s, 0);
         ccid_write_slot_status(s, ccid_header);
         break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_Secure:
+        ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
+        ccid_write_data_block_error(s, ccid_header->bSlot, ccid_header->bSeq);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_Escape:
+        ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
+        ccid_write_escape(s, ccid_header);
+        break;
+    case CCID_MESSAGE_TYPE_PC_to_RDR_SetDataRateAndClockFrequency:
+        ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
+        ccid_write_data_rate_and_clock(s, ccid_header);
+        break;
     default:
         DPRINTF(s, 1,
                 "handle_data: ERROR: unhandled message type %Xh\n",

-- 
2.56.0.rc0.29.g47ce80527c56


