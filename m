Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF07C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraBn-0008Uj-34; Wed, 05 Aug 2026 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBh-0008U4-HT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBf-0007KS-0T
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3A4GS1vpubnF8dlvXdHjd6RI2rRgkvNQkvZB1xfjVwU=;
 b=Cd+/PcY1+5x/s61EXIKatcP9eh1m3tghCgweNT6g+lVmUN4VlhJ0/MXaxeb+k6LX5MKdKw
 KQmJOiLpWcIDYrghuY2qEBb8uVsDECz+xfgOw2im/+9vGWoBqhTpqsqj/UAhg35ZO5QGm9
 7qaozlXq7RPhG0Qn98xnPbL7xIczSD0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-2XPe-kDBM5KDYoV6vqsXag-1; Wed,
 05 Aug 2026 07:53:29 -0400
X-MC-Unique: 2XPe-kDBM5KDYoV6vqsXag-1
X-Mimecast-MFC-AGG-ID: 2XPe-kDBM5KDYoV6vqsXag_1785930808
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26276195609E
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:53:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15AC2434; Wed,  5 Aug 2026 11:53:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:02 +0400
Subject: [PATCH 12/27] hw/usb/dev-smartcard-reader: fix
 RDR_to_PC_Parameters dwLength
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-12-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=l9YNs4XrELkSPSF5rfSgGqqOZRudYj/BBNDj5rHbBdg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOtOLlSrZcYYrYccK7b2wjHALrud7F44dsoI
 a6ArL63OwiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrQAKCRDa6OEJdZac
 5RilD/9lhf1g2e+UW3enTq56FHR3EXtgaKqViL+qkkF62yaKJPg5HNs6CtVfEdiZdGcKn/4t3p9
 Alva7aD+0GCSfCGs1Q4T7J7l+ia8SY9cRdH+5ZHQSyuQ0oBMxqvu7gqJCTCHboyCXABRm5mQSlI
 rwsiwWTsZqaOja4PlhtbcbR7NHgN9bu2uS2YhmCsVZtE1UHdXpZB3I54Ux2xGl04abuHbxmfi8f
 QUEx91f5Czc0suf9ZGaggJLYrWAIe38yBrXZia1wmK7z9+XDUT+G9dh5nTYIgeibrbVZmFn7pEe
 JJPW71Dx6JviKx6/xP7NRngQ4K6DqakQy/VIpcXK9l6RSAsgVPH36AD5NrBGT38DrW4Eco1gzLA
 vuBZpPxQsMLiLIVHh6B0tbUgM8ELH/jcSzWzR8v0NBY+a9KEuohakknelDV76q6FdNeHaHDrSLh
 02hAs4YZOAoo4oALBu2pK2483Yq2zBcVH2R4vo5lEWjeIZRozLjC3dIqrOOatDcLIbFfH0q+l9u
 8wPHtyIwmJRIWTtwUEemJo5pGe4gst+Pu1A2W3/NUssjuB54jLuUQY2xH0xt/E41pZBtAizSB7Y
 /iHLv/cUn4ogCShX4B/KSIQZiZetYrzdkfNQRjKlKESw5adgZPh7R9HviGVPkbN0a56y+jq7mFm
 3L/XChzyDeEMl5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

dwLength in the RDR_to_PC_Parameters response was always set to 0
instead of the protocol-dependent size mandated by the CCID spec
(5 for T=0, 7 for T=1). Since bulk_in->len is what determines how
many bytes the guest actually reads, the reservation size must also
match the wire message size.

Set dwLength from bProtocolNum and compute the reservation size
accordingly, so the guest receives a spec-compliant response.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 279fef03652b..16f248a0969f 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -748,19 +748,20 @@ static void ccid_write_slot_status(USBCCIDState *s, CCID_Header *recv)
 static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
 {
     CCID_Parameter *h;
+    uint32_t dwLength = s->bProtocolNum == 1 ? 7 : 5;
 
-    h = ccid_reserve_recv_buf(s, sizeof(CCID_Parameter));
+    h = ccid_reserve_recv_buf(s, sizeof(h->b) + sizeof(h->bProtocolNum) + dwLength);
     if (h == NULL) {
         return;
     }
     h->b.hdr.bMessageType = CCID_MESSAGE_TYPE_RDR_to_PC_Parameters;
-    h->b.hdr.dwLength = 0;
+    h->b.hdr.dwLength = cpu_to_le32(dwLength);
     h->b.hdr.bSlot = recv->bSlot;
     h->b.hdr.bSeq = recv->bSeq;
     h->b.bStatus = ccid_calc_status(s);
     h->b.bError = s->bError;
     h->bProtocolNum = s->bProtocolNum;
-    h->abProtocolDataStructure = s->abProtocolDataStructure;
+    memcpy(&h->abProtocolDataStructure, &s->abProtocolDataStructure, dwLength);
     ccid_reset_error_status(s);
     usb_wakeup(s->bulk, 0);
 }

-- 
2.55.0


