Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A2CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrK-0007Qv-Bc; Thu, 01 Oct 2026 09:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrH-0007Q6-LS
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrE-00060i-1x
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZmbH2/gqfx6THgqOZHwDcdXnhArTAtbTDCTFsdTcTc=;
 b=c7M69yYWOcy7ZRqYAw2lXCTRJ1zFKAyjPLFY289jfWKXpuNsXLztyj9UWUHr+o1i9bA1eK
 mhWhyny3WtouJeLCj2a8IN50p6tuvJagvHOvPD2AskMvrEDJxKR53l1w8f6HOCvVvlUJaZ
 FD5eCzw7on2B4SdQNv8/qh1YVUJFPVo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-KxRaXhP3M_igJdh5lrJL_A-1; Thu,
 01 Oct 2026 09:29:52 -0400
X-MC-Unique: KxRaXhP3M_igJdh5lrJL_A-1
X-Mimecast-MFC-AGG-ID: KxRaXhP3M_igJdh5lrJL_A_1790861392
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB9D3190F9F5; Thu,  1 Oct 2026 13:29:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6503214; Thu,  1 Oct 2026 13:29:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:40 +0400
Subject: [GIT PULL 01/27] hw/usb/dev-smartcard-reader: validate interrupt
 transfer length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-1-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gd9+exY4PBpz0mUvPkUrJQXW6HE9iDS2lLF+QiYhkko=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHd4EJLQYu1qcXhvbakIhRY+34byVQPUdBu
 XJf+qkMZ/yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5c74D/95XmYyTCZ3nb59/cbyqU0LuejLHJSSKya0c268hx20M35iW0h/ybVRuf5hLLDvjUAzA4v
 dYTWBZBd6drFN/6bfOSahjzgXpSSXKFFlbwzo4sGg6x2s4beVnjhAuT8bkF9LvDT7tcsZ9caMSO
 keKfGDcei3TzTGONch4gg22OESRu/o9LGt7hJFRGOyrIPD0TqygOom8B0EQfT/HMevpcr3Zsc+I
 Y4FpP0lLs7A/r6ZJhbH9hz0q7AzcrTM3+K3ev9XaQQ9PgO6vQbvVVUS8HAg/krtkW+ZTWNbzFHw
 lkeAIlgL1Y0f79g5UCw/ZAwPxT6zGphcK3VATvT5IE+fypS4OeLR+bhtUKl2bH7OG3qcQInV81B
 F/wkF6yT7MoB4vFLh4O0gGth4zXePhoslCOPaBLvrV79ZJm5SLU20jwTh7UKLU+egTL07edIBvY
 T9TqXSdRCUN1LcsYnNAtLz7o0OxTNakXFJTLK/3YO/WxLL69QWaZNEV76RI+MPEZvWQv8JZTrr2
 14uGlfXFV1UN3JByh8Qs3AnEh0sXhIDS8lXnF9Bjswm4LJ5j1yanE6upi7WJDn1yf1Y+5IAiUDa
 F/mM163O02KglsQi+r+7Nw++AgOxjOR/xZ+k8TBJ709A/QtVIVkJAc67C8mu7PmpYqSC/zaqV2M
 uUmGndXAxfm/Bbw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
2.56.0.rc0.29.g47ce80527c56


