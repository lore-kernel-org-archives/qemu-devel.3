Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61758CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbF-0008DB-Cm; Mon, 04 May 2026 07:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrb6-0007t2-Rf
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrb4-0000vH-V4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9+ErlHfhLuXXJDocSDtTnxTzm8IYph61vLIhuadgv4=;
 b=e40d0bgqZYGGl0yd0cH6qtpbHecQfpb07bEehZTZcygroUijeZGBfnGlAaUaPWYNzaEtrn
 jOMnaU5Gfe4JTYF9OfDQB7UBajDewIlclbMZmE+R/YUCn67KWgyVWoHk35xL8F7C6yXfln
 s6sSLBnilhAEioa+jICa+2soYSwe9Ho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-uMSpoYnrNdifZxl2Vf2cXA-1; Mon,
 04 May 2026 07:36:18 -0400
X-MC-Unique: uMSpoYnrNdifZxl2Vf2cXA-1
X-Mimecast-MFC-AGG-ID: uMSpoYnrNdifZxl2Vf2cXA_1777894577
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACA28195608B; Mon,  4 May 2026 11:36:17 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0A6F18001ED; Mon,  4 May 2026 11:36:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:59 +0400
Subject: [PATCH v2 11/46] hw/remote: guard listener unregister in finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-11-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 jag.raman@oracle.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cDsvGetIC+t+iBzuuM/zUrAZ/YOiA8vpcWaT/aLjS2w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsHm81Ro8UxB2SLtloX7GzTzB2sutTEZhOf
 6Xo1T/vbbeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5YRZEAC0UprmduhQmKs2IhVE1Xw7i/4D2Izj1nu5UqC4I7Q71XF1J0vbU0g5YCu2YOtK3n2zZeV
 iwXjR1UV/YSGHllxZohyF0Begoli3oeBJ7SXhqfjEXnEuLm7zmujalQQPBnkgLQDPUA1v4+Kwa2
 R6ac72rq/rk7XQEGHu51atJ7IjYE1cFPWMWcs+ThpKdXZyrhszcH20GDngjtGhKJ6atQ89ynUsA
 99REwWmi3q1TU3/oM5PEppV3nsgYs/W4cudCfsWTUPafDWVCXkkb7K9cuvU8HHSlpT6O8FIlr3M
 54E1qcNjrePvxsdEH6jBbMmY/iHCBrb8rdKOvC/8Pxmw8jeKWEqEcXDA04VtdIrtykaeBFHk82Y
 ofAfkc/gz+inT2lJh3/2rO4lpAygAqy5KMc9ZLG/sbMAEn7uMdF4nqTAKx9ZEep+QRuBzkPC9gf
 pfGHTnBMc5khuZ22FdRIyWHXzelkE0XOe3gfqdiJgtSt3IhYs4rurymrjl6D+hsuVTLQiBjOgTW
 loUm6eTBXRYdLUZBGNacW6Z1gFbTzv9zSIMDfsX9KUDeJ62vMxJ1eK+bzIZ6vVHiuXrH4f1m+wW
 R/puMpOqUNU2tNgmgg68W4nPkmZV6ssaoqc7WirA/i9tfV/dB5oS+extr5xAc8TvxbOzy0EzqOE
 Lr0DIOj9gJDWZYg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Guard the unregister by checking whether the listener callback was
set, which only happens right before registration.

This is probably better addressed by "[PATCH] qdev: test if DeviceListener
is in use". Just adding this patch for completeness.

Cc: jag.raman@oracle.com
Fixes: c7d80c7c1d9 ("multi-process: Associate fd of a PCIDevice with its object")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/remote/remote-obj.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 86192dc8dad..4e74ae76158 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -154,7 +154,9 @@ static void remote_object_finalize(Object *obj)
     RemoteObjectClass *k = REMOTE_OBJECT_GET_CLASS(obj);
     RemoteObject *o = REMOTE_OBJECT(obj);
 
-    device_listener_unregister(&o->listener);
+    if (o->listener.unrealize) {
+        device_listener_unregister(&o->listener);
+    }
 
     if (o->ioc) {
         qio_channel_shutdown(o->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);

-- 
2.54.0


