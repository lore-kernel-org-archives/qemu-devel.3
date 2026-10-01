Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E07CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrd-0007dM-6Z; Thu, 01 Oct 2026 09:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrT-0007b8-V8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrP-00063S-OY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGb7bVxl71pK2JI9jeAzvy64NbfX5B2LGX/SdioEfnE=;
 b=AWieXnroFbvZd5zSjUkdc3CAw6L1B0iDBxKRHJoq7FZnifAVG8WK++mi6BjMKvHBDiF4i9
 r6xw7eBafWDck7oxNd2f6z4xUoGf4DjE9IZdVz3YYPQkJCnmKrAKg+bOcaWh9kfNyGd7xs
 I6QjZEUMW8jTKu6MZHe6UuHbkH841P8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-WKqq3ouFNlK_NE-5HTw9dw-1; Thu,
 01 Oct 2026 09:30:03 -0400
X-MC-Unique: WKqq3ouFNlK_NE-5HTw9dw-1
X-Mimecast-MFC-AGG-ID: WKqq3ouFNlK_NE-5HTw9dw_1790861402
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 160841977019; Thu,  1 Oct 2026 13:30:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3357D1800361; Thu,  1 Oct 2026 13:30:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:43 +0400
Subject: [GIT PULL 04/27] hw/usb/dev-smartcard-reader: decode bulk-out
 length as little-endian
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-4-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lvJc5DJaAPhL2Dub2eXYFx0OHUIFgKPZrlORX3sOSZI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHAFVJYpSew7vYXBVTrtav1O/L8yYYqRlLe
 t0f6PnO4duJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5bRlEAC7MOLkDXLj5i6LpFNjvz9epr1sfXbEgVsxgzWCXdzJq8RDRXppNkMaXk3P/THWwB2JCjb
 IXcyq7fS8HR2bZmAGkQOuxzdNeKB83KWUCG6TJz81clZuQ2xajIHithumXwsFWR3dacvew7C54l
 SBaQ9Ei27ncrZkjl0q266vkF5cJ6pLZOoTT3zPUuMpMPWtCnoBdZUSbiowiPpBDpxSn6qjq48zw
 83UG9yCZ8LetS2ZVUmmaHM0Cg1EwfUj3hfTv3+m9OiX93jLh23UBhtFxVDjK+q18yjXZSJWPk+X
 iOPNhi3K8M26R//uqcDC39/nFYfTwHRj1yjb18lUddTMJdZRbPCnHy/3hvO3rkvZPAm1NA5acVh
 VGbhf0Q+7lRce9kYrTiYED8xcLisFhW+l+4XfMzSRAv8djP9lRlwrl1/to6w3mJCgs7LwV7ThKB
 DCPbLtMkCw7qWrCp+XvzD2Q6gu3rV4Gh6LSeHF/cOHVDg6iSTY36h1NfyNLPe8QJoTscQsthibJ
 VQfQsp5mD0nhJGH3YsY/GU228hT/X8rVPHIaTPKowbiUJNql/IQq1S8MjbO8VTLb4XQVN9ZM+gD
 pqQITUZ0l05aly6uje/Vjmbu31xfmTxJTJbZau7zN9X+m59g2ohw8H7JrAxxKyyhEET+YEjnp9f
 NVhP9+0IvjQ8wTg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The CCID Rev 1.1 specification states in section 1.3, Document
Conventions, that fields larger than one byte are stored in
little-endian format. The bulk message header's dwLength field is a
four-byte field described in section 6, CCID Messages.

Decode dwLength with le32_to_cpu() before using it to assemble and
validate Bulk-OUT messages. This fixes message handling on big-endian
hosts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 9cbacf08e77d..4cb5f6e1a485 100644
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
2.56.0.rc0.29.g47ce80527c56


