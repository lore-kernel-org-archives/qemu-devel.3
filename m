Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5705C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraA4-0004fZ-2y; Wed, 05 Aug 2026 07:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraA3-0004fO-IZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraA2-0006jR-06
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BnZeIw3V0BAAz5LtSf1O+FSYGZT0ypBXRhLo46zAyU=;
 b=AA7suFxQhrL1U3AXCjDKAnez+M8x95w5AOvo2hdrlqpx6m3eXvj6aUbzkYpyzwHKz8uHU9
 GXknv1uLVB++4uZ71DtJCJrKTfcdHYayguv0kNsjVl/elZ/iuljPqlueiSbISWSdvEmY45
 SEJsxUR6e222AHRf7NLXz5NwGmlNP1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-C2m8xCafNseqB0B0IWh9RA-1; Wed,
 05 Aug 2026 07:51:30 -0400
X-MC-Unique: C2m8xCafNseqB0B0IWh9RA-1
X-Mimecast-MFC-AGG-ID: C2m8xCafNseqB0B0IWh9RA_1785930690
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C05731800846
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:51:29 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB449180049F; Wed,  5 Aug 2026 11:51:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:51 +0400
Subject: [PATCH 01/27] hw/usb/dev-smartcard-reader: validate interrupt
 transfer length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-1-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9lcrDRYO8GrZ8aSFNQ+D47jbFfVunNetUQ8wln6BisI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOrXPiAoimCuvz2mzvaadpKLgCCIkFsvz0Yz
 +JWrA2td82JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjqwAKCRDa6OEJdZac
 5VR+EAChAipm9j9Col+IY9bWcr4kfdLu8eT6gnqyrcSM2s+YHAmRWyvYIo9m9Yb7M/vK63qcAHC
 3ZKlk+Mgp18/0uGqRIeS5FUiejhfl9iFCmfRB2Q/B9HlSgBPFVwBoeerKQOvkOhGhP908nGc/YM
 bMbc33bVpMs6ap4QYsA8xn7I0TzmTWQD5eMleFOJMf8UDRWhnSAnSEJlYgYe3hRyMkK85R+/tY+
 eIe6Xxva+O3ggZeMderwbZ4kh1uviZYPS9Etzmi9n/TqUdYTBquZkWgtb7aS/8eJMUYQFsFs5ml
 tC6uktxpTQe2Qw4V9JpQTmH2Wl74kJDRhJU/vFo01bc9/Hp6PE0xC7j1Dbwn9DT2ARIcMm0Ku8C
 f+zZGHFYCZGn98m8wBhynU9RdBtW0yPeRu2tVW9LRQFGVygmKokVz0MGP87O8qhT77S6W4U5ebS
 KtfnS5p64nF1fKsFSlS/JPUmGR6+D3uZecP12+NEZ3iV0f5q+PrXeu8AM7M2Lyzowno+xOGLJTK
 onCQGsXyB3cbnUA4sHFKspuk/X7vvAolT54Dz4USCao/u4douC3zymbunvtrMjjOmSavYuxOMg6
 H+DDeaOupjbkZEWHs9ZkIgCBUcXMT7dSziVK+w5X9XsS40zLZlWdW/yD0bI9wIDTXNfDDiadhCM
 es+1jRDrSVpCS/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

A guest can submit an interrupt IN transfer shorter than the 2-byte
RDR_to_PC_NotifySlotChange message. usb_packet_copy() asserts that
the packet has enough space, so a zero- or one-byte request triggers
an assertion failure, crashing QEMU.

Check the transfer length before copying and stall the endpoint when
it is too short. The notification is preserved for a subsequent
properly-sized transfer.

Note: a later refactoring patch will switch to usb_packet_size(), but
this patch open-code p->iov.size for consistency with the rest of the
code.

Fixes: CVE-2026-18609
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4128
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 964c142d1066..bba97a2b19e6 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1122,6 +1122,10 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
             break;
         case CCID_INT_IN_EP:
             if (s->notify_slot_change) {
+                if (p->iov.size < 2) {
+                    p->status = USB_RET_STALL;
+                    break;
+                }
                 /* page 56, RDR_to_PC_NotifySlotChange */
                 buf[0] = CCID_MESSAGE_TYPE_RDR_to_PC_NotifySlotChange;
                 buf[1] = s->bmSlotICCState;

-- 
2.55.0


