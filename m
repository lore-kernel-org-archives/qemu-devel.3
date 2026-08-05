Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB38C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraCF-0000Xu-Ey; Wed, 05 Aug 2026 07:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCD-0000Kz-Au
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraCB-0007N8-NL
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2LvSbpEtJbg0iXFtoQWnSmsjH8S4wATFWNebm0al14=;
 b=Y7bWVcUx8N8fPSOICDlNfLFO7JQUch/ccKuFoDF+BYzhAas3DbqxxFzVYbQP5M9ZZtOSa/
 SFz9j2nQ9/nqYIBGxoCRPWXx6GtluTy6IMw+2jUV7E73+nFiTj3/W4Km+/VX92bk0Mp16m
 SuGOU8bXCJ2T7mfF/Vczk00fh9OTJqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-l9WurMXWPQmYNEJmFqomCA-1; Wed,
 05 Aug 2026 07:53:51 -0400
X-MC-Unique: l9WurMXWPQmYNEJmFqomCA-1
X-Mimecast-MFC-AGG-ID: l9WurMXWPQmYNEJmFqomCA_1785930824
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DE0618005B3
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:53:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88B5A30001A2; Wed,  5 Aug 2026 11:53:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:04 +0400
Subject: [PATCH 14/27] hw/usb/dev-smartcard-reader: release short bulk-in
 responses with xHCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-14-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SXyXnV8aFURBX1WRd2SUK2xEo9JlBeWQEIYyVupgC9g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOtMcUQa1JVGIds+v3A7CB6xZqnMGAc3WBT0
 LVYQ4PYMmeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrQAKCRDa6OEJdZac
 5aVSEACBN3MYN5om4/YOAsLhPbdoB2rt8ENordKLEhIhaknsauv9yZunCyTjGBTVONNnHvEZkHJ
 POzWV5ords2X3k+/KtLp4JxQTXfiWPuSzLz9BOO/R+jGHeoWzWoVapGHMtcmIuyQ0Ij1rCrUcIJ
 HbTXHb0kLNb2L43q9/7V7SlkfSDjo+JHNvtvoG2DSq/nKkJkv3gq6byIl9gL1ypKzwDr5617zbK
 WBY0eZtknm5sHIfbFAMJ2bloOLssePsb+3YfnxCypld48UvnlN5Q/FQ6yJbD+5f+l/GhszmuKEE
 /QQqlaisyStDENqf/Vzfnmbv4qsXTYv2hPm0sB13albR9TjgvJ5oLcT0hYFDd27F0HChd+191SM
 AFZ8nB2I4qYy04emGoF3XGNVVZsu4V1pMOO2ll3j5SIt7Sq10c46bJhupP+NAWKjqOB7gqpPlV4
 vjNCF/zkPQS1Unh9tiVzcw/kh0kVcUriJR9ZsN8dKBvq8YeUgcqGH1jJSOuntb216MRy4F/o39h
 bxixJznGXbNRYyfzS6y149axyIhFaqWBgWwPD3uNdzAH2ziLgIi+RC2+DBFAHNMXZhFvK4GWPYj
 IVJ1ZrcuDs/3bul8hQuo6qpOWQER/CGVmZ3svsCyRaIl/jB6JNBhKgqm1EvmVqIsKf3/+Cc+ak4
 91jHGXYvuDsRMhw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

USBPacket describes the host controller's complete transfer request, not
necessarily one packet on the USB wire. xHCI maps the buffers from all
TRBs in a transfer descriptor into a single USBPacket, so p->iov.size
can be much larger than the CCID bulk endpoint's 64-byte wMaxPacketSize.

The smartcard reader kept a completed bulk-in response queued whenever
the last copied chunk was exactly 64 bytes. This is necessary when the
guest requested exactly 64 bytes: the next IN request must receive a
zero-length packet to mark the end of the response. It is wrong when
xHCI supplied a larger buffer, however. In that case the 64-byte result
is already short relative to the USBPacket and xHCI completes the TD.
Keeping the response current leaves it waiting for a ZLP request which
never arrives and prevents later smartcard responses from being
delivered. Release an exact-64-byte response when it is shorter than the
host controller request, while retaining it for a request of exactly one
maximum-sized packet.

This fixes smartcard reader with xHCI.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index d91376826c5c..699e236f624e 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1132,8 +1132,7 @@ err:
     s->bulk_out_pos = 0;
 }
 
-static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
-    unsigned int max_packet_size)
+static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
 {
     int len = 0;
 
@@ -1148,7 +1147,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
         }
         s->current_bulk_in->pos += len;
         if (s->current_bulk_in->pos == s->current_bulk_in->len
-            && len != max_packet_size) {
+            && (len != CCID_MAX_PACKET_SIZE || len < p->iov.size)) {
             ccid_bulk_in_release(s);
         }
     } else {
@@ -1180,7 +1179,7 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
     case USB_TOKEN_IN:
         switch (p->ep->nr) {
         case CCID_BULK_IN_EP:
-            ccid_bulk_in_copy_to_guest(s, p, dev->ep_ctl.max_packet_size);
+            ccid_bulk_in_copy_to_guest(s, p);
             break;
         case CCID_INT_IN_EP:
             if (s->notify_slot_change) {

-- 
2.55.0


