Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13EFC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraB6-0006zc-VS; Wed, 05 Aug 2026 07:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraB4-0006xF-2v
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraB2-0006z7-K7
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EaL3oGsmyoo9Mb8QtTF8RHLY3nHU3zHQv1/Tjv69qQ=;
 b=fiP07LfEN45kWbJGhXzPCWfxpp1u0XsmQmMD/eTJvndC/9hRuXyFjPZZ2fAOJyaOYSwblQ
 B3G3ZonRusGga5PBp8h819TZtKDfDw4LpK8xVa/WRBzkSAtVJ/yZ8jEOmZ7ZMBNl0Nqyc3
 66EHAG+cLr1Hb+qIAjyImCV6nQI2Adk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-cMp1aclYNSCeSZqwWM5i6w-1; Wed,
 05 Aug 2026 07:52:45 -0400
X-MC-Unique: cMp1aclYNSCeSZqwWM5i6w-1
X-Mimecast-MFC-AGG-ID: cMp1aclYNSCeSZqwWM5i6w_1785930765
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0AD119560BC
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:52:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18BA3434; Wed,  5 Aug 2026 11:52:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:58 +0400
Subject: [PATCH 08/27] hw/usb/dev-smartcard-reader: drop needless state fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-8-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mOnLqynUX3ypyc0K+pzAWTylprbsShk6E+l9SbJpIc4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOsx8Wi/X9E0EcgqsLFS7FLOcp9xWYz251+R
 +YcwzCAPxKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrAAKCRDa6OEJdZac
 5ffrD/9r5rGia/ajazxK2GAkKdOas9vYWiGiTN4GFIoJfgw7qZ9MPAuaR1zapJUOjRSZEGNq1wH
 NhCRxSzXXmyMnZ59A0RtZ5XBfQkeBVTKOj+HZhzuF+Zk2Jo56Cq+ltyMRXK4+OErqzmJ/ngeanV
 xozwnfE77/2XAkda3+W6KpMfHAHfXKLHmZy0gB0ELwd4Uf82GX+zuy614GSy42JpdUNlXsIdj4T
 HLUzowjQv208yraQMIjYml3386hvYBdtnar9a5DqdctIi4Tvun5aYO4BTwedpfth+WMlA0H6EYK
 um25UMlY/qh/qeHAOo4/FUbqimlBp6yx/J/a3z/NcbVOPtalgqyAF6gcKrDfLRAwhsVR5u9zeeJ
 iaLUaeVZt5ZR75zAzvwahN3GrUK2PuAXM/XqDN4/0jFBxOG3x2OGxGzMWMuGaqLpnm5zK8egsA+
 1msAfB5k6V8TeP6oObTF18SEnGJzy3l/8Nsac+PYngMEc8ykcS8wn+qnZA9pqqmt7PZYczw8VKH
 C5OrLoO99RYsL4izP7NbzKIukgggXVvpk40V+9izn4GrXojEbZNPT6HsPCLZkJryUzkJ/kH03SO
 ROZbYBFLh51CL9wXomyn9f717JgbpPxSEoyNUewIRsXOn0pGahqtqsK2P+I0XvAjTHr9LeQWzrD
 6rb+NMRcJLiv36g==
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

The field is never used, it could potentially do break on malicious
migration stream.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 1b8f0e10e172..c6a9faf00d6f 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -308,7 +308,6 @@ struct USBCCIDState {
     uint8_t  bmCommandStatus;
     uint8_t  bProtocolNum;
     CCID_ProtocolDataStructure abProtocolDataStructure;
-    uint32_t ulProtocolDataStructureSize;
     uint32_t state_vmstate;
     uint8_t  bmSlotICCState;
     uint8_t  powered;
@@ -762,9 +761,8 @@ static void ccid_write_slot_status(USBCCIDState *s, CCID_Header *recv)
 static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
 {
     CCID_Parameter *h;
-    uint32_t len = s->ulProtocolDataStructureSize;
 
-    h = ccid_reserve_recv_buf(s, sizeof(CCID_Parameter) + len);
+    h = ccid_reserve_recv_buf(s, sizeof(CCID_Parameter));
     if (h == NULL) {
         return;
     }
@@ -1447,7 +1445,7 @@ static const VMStateDescription ccid_vmstate = {
         VMSTATE_UINT8(bmCommandStatus, USBCCIDState),
         VMSTATE_UINT8(bProtocolNum, USBCCIDState),
         VMSTATE_BUFFER(abProtocolDataStructure.data, USBCCIDState),
-        VMSTATE_UINT32(ulProtocolDataStructureSize, USBCCIDState),
+        VMSTATE_UNUSED(4), /* was ulProtocolDataStructureSize */
         VMSTATE_STRUCT_ARRAY(bulk_in_pending, USBCCIDState,
                        BULK_IN_PENDING_NUM, 1, bulk_in_vmstate, BulkIn),
         VMSTATE_UINT32(bulk_in_pending_start, USBCCIDState),

-- 
2.55.0


