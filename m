Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482ECCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJRE-00054e-5r; Sun, 04 Oct 2026 06:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQx-0004nI-8t
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQv-0003Uh-GW
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VL/CtSiakI/0oQi2XAUKymy2Z3RN6MVRibEppnHbyhg=;
 b=HxfgsYHRIEzOIWzO5PC/6+S/7z/4At71vEODRVZvEMZnFKIqOCiyQmIwjvr8mMm+cd7vVQ
 jof3BY06mfNTObIf4vW6fzOK7HrVJQhyP1WvfsN1sjtn5ldNPUgQ47yEFVuaeDwM+bNRnX
 rv7jj3/txt6YyruGk/Fux1zH6dg95hY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-jitGhmzOMAKY71c5cJ-2UQ-1; Sun,
 04 Oct 2026 06:27:01 -0400
X-MC-Unique: jitGhmzOMAKY71c5cJ-2UQ-1
X-Mimecast-MFC-AGG-ID: jitGhmzOMAKY71c5cJ-2UQ_1791109620
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C3F61955F3C; Sun,  4 Oct 2026 10:27:00 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656761956047; Sun,  4 Oct 2026 10:26:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:11 +0400
Subject: [PATCH 57/63] hw/input/adb-mouse: add unrealize handler to
 unregister input
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-57-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VMolbXYcx+r++JLOAQnRDbJvuF0SMBTg8zV4aB8U7/c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklKPjWZGuvXvjDOvXFAqXRAPJT0bp00bRpS
 flDyhABxySJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5WAAEACaeXvnWEs3M3UT997e9ZVAUcv3jNuBrzS38+Zt6qzh4esg+gsYFgNu6vLycj6e1Bx41/5
 je5zrg9BbsfVvLcjjYiXwCBnopUMOEhT4cdlzTqV+gWXUdLuGm5mWkTYggxOldkqrDnSfjKXiHf
 foalUqiT1GSCv/FFJMVWUXpZ5QFSLDq/iTz8QTlESGvXeJ0ByecL3r1dGBihD3nqScxMuqPF82c
 E4jxNTVQTBfd9AIqEY6lKOkomRQU3st6V1FyWuLIjH7sOcGWRY6dzN+ibV7lgAzw61LgfkldhCm
 t/ARWYtp6UjDeYBP748BErwbIe//jkIyMngw+2LOTSkyACV87maG/ehu5ZMjeasJ0ByRe2L8xgt
 fH2sLbIq4t0MvGfCDTkcPebqMoaoSZY9J3mz21SOu6dpzqKv1jBNMqFeFZ3A+nQe5yO+YrXQcgl
 bagHs9+IXCRsET0cTtIoLKnnRvLYl2BK9M8Q1KKUYBVY6G8iekalelCZZwuX32iZAtkvNlhL0R9
 VfkPjDMRb8y2AKhfYDpQail45oMyEW24mMenOjQRdwZPqHWT7Crfc6pgmZqgy0ceQkR+ngOqGFo
 NzhGLGL9w+lbmpc6kfUxhGW6fzlCAjLbL41KjgBGTD+sDcEgg61S+ElzooOj27Gw/Gjh0YFHSV+
 jiW610mT7Q5mjOA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

The mouse device registers a QemuInputHandler during realize but
never unregisters it, leaking the handler on device removal.

Add an unrealize handler that calls
qemu_input_handler_unregister and chains to parent_unrealize
when present.

Fixes: 118e15191800 ("hw/input/adb-mouse: convert to use QemuInputHandler")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-mouse.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index f9f989930ba1..0f2ecf0fd88c 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -51,6 +51,7 @@ struct ADBMouseClass {
     /*< private >*/
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
 };
 
 #define ADB_MOUSE_BUTTON_LEFT   0x01
@@ -285,6 +286,17 @@ static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
     s->hs = qemu_input_handler_register(dev, &adb_mouse_handler);
 }
 
+static void adb_mouse_unrealizefn(DeviceState *dev)
+{
+    MouseState *s = ADB_MOUSE(dev);
+    ADBMouseClass *amc = ADB_MOUSE_GET_CLASS(dev);
+
+    g_clear_pointer(&s->hs, qemu_input_handler_unregister);
+    if (amc->parent_unrealize) {
+        amc->parent_unrealize(dev);
+    }
+}
+
 static void adb_mouse_initfn(Object *obj)
 {
     ADBDevice *d = ADB_DEVICE(obj);
@@ -300,6 +312,8 @@ static void adb_mouse_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_parent_realize(dc, adb_mouse_realizefn,
                                     &amc->parent_realize);
+    device_class_set_parent_unrealize(dc, adb_mouse_unrealizefn,
+                                      &amc->parent_unrealize);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
     adc->devreq = adb_mouse_request;

-- 
2.56.0.rc0.29.g47ce80527c56


