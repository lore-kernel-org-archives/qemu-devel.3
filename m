Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76DCC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraCe-0001ac-Q5; Wed, 05 Aug 2026 07:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCZ-0001Os-CT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCX-0007Qc-Rd
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuuOQE1Tid/CLQqbvoiHs+GixDUg4AnBCGRpP4sQ6/E=;
 b=B04E0oLy+jpTgS8ipLntMg4ojvGgySttCT11LaQQ26bipEdLTh0Lo/ywfcdjz76X1GKgBf
 q+Y1cuZIbmKzMyfnvi9PgGPAWm1jOoJBYHBXc3WaoxYrq4eAO5wN4W38VvNTgTG+mtZ7i6
 0GmMPyieH5YNNbhiGf76u0ZSF3St15I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-HHiAAiULNPuYs8BMBR8pJA-1; Wed,
 05 Aug 2026 07:54:23 -0400
X-MC-Unique: HHiAAiULNPuYs8BMBR8pJA-1
X-Mimecast-MFC-AGG-ID: HHiAAiULNPuYs8BMBR8pJA_1785930863
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8EEC18001E1
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:54:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FB3C434; Wed,  5 Aug 2026 11:54:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:08 +0400
Subject: [PATCH 18/27] hw/usb/dev-smartcard-reader: handle Secure, Escape
 and SetDataRate commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-18-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3957;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+GeLYkQ66ayZBib1mFWIYosAh6K2QOV573zIujfNcEw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOujLmJmIvoMJdvkvkKR/aRUQdpBBOpAqGej
 NuDSiAzFG2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrgAKCRDa6OEJdZac
 5e7kD/9BYBfNcHmxbeT/1Oh+wewEtPGLMYhs9IVwCDcJe+k5+UGTpr/ge2gn49ji6H7dDCbVwb+
 mVBtsGXKUPgRhcA7bpT1iMeemXxzru5KRRNFpkz7tQefXBICSGx6SHyGReO60/5rOGwRo/m9/LG
 RYpC3eqX3Qvz4zd8Ytw9bnk/pGTYHsz8aTfDUARi096gCn4tQC7E9FEAF1vfg+efHygch9MGCQR
 zEG6ZJ2emnuTaOGKbR7Mq7ykR5QbiwDdQEdeufoYoTW2L14HsdIKUAq0e9evzlbSreCSEGXJED8
 gofYx4B4lTmGexG9gm53Yem8dy3umxC31nvF3dYYTGeCU7i5sWKc+pI/ItMsIl4QvScVrtP758x
 QhvZk7tuqF8DGXOUiU+Rj0s2NIUNJtGBGIlY0eAflJ/CCVGeGEvxKBj6MT0uxHv1fH5GUsyiEJN
 qKsS7tfEt0MYlRMDCb2iRu0nz6UNiXLvU/9bmn+HQxjiWe7/c+bxnMN1DOk5UwaFcRqmDvLhvSF
 rGYcY4LZm2j+gaUjTeNyxrGWnbxegaO/nXipGzgMbBM8MAcxK/kMJizrNBIEjAXuM0++hAwvU7e
 RWQaJbCNjy7DXgU+1rN+3E0KKylx/iBD6Ui6S4ngzKZYLqn6U53laq+P/BmR6sa8ggonzPVfiwO
 bf3YFihD9wKWfwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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
2.55.0


