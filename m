Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18980CA5FF7
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQs-0004Hv-6I; Sun, 04 Oct 2026 06:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQg-0003Qs-VR
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQf-0003Sd-Kf
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwHxUKtf9XkTzSwrabwOJmk+wty/IKUHX2kgOWAauhg=;
 b=JBt0ikw1eYaD2XrIxECofvCllqse3bf1cRvx2DPmakhUZMQLZeFGLsE/BS5gQ77ZaSRnAc
 1sg7e9O0l8AtEvdfXlZaKaYsebw9Q5UJ804MUBORgiNXrAwgyzzP5Tq+kEW6Nkgw8yo1jJ
 lSkw4y7RviIQY0kqel1i6wqQlGnjwc8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-lI5sqV79MJaPvqxWoaHVeA-1; Sun,
 04 Oct 2026 06:26:47 -0400
X-MC-Unique: lI5sqV79MJaPvqxWoaHVeA-1
X-Mimecast-MFC-AGG-ID: lI5sqV79MJaPvqxWoaHVeA_1791109606
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9377119540D8; Sun,  4 Oct 2026 10:26:46 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 994AE19560AB; Sun,  4 Oct 2026 10:26:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:07 +0400
Subject: [PATCH 53/63] hw/input/adb-kbd: check for errors after parent realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-53-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=N3xOeWJEPbSvQn5YuMhDfW129MwwyOSHXEBPdJS9XIo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklv0zRXXrG2lHapArLR2VuNMP+myKyhPgok
 iFyVJQ8mzKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5ThFEACKZsK8TqFWt9wz6somfIg8mQIoevB2fEku7ARuknpo8mX90IhOc5wPV0D1l3IfKQfrfbW
 QF4GMB6gnrm7pQS84Py/EFzscG3mXQwOmxxKmtH25TJHjgbgOXfom1/C2Pd7njqAIJzdN3878aD
 d6iUT7nK742hyvlVANQOTCRsjK6On7voWqHjhty19j7RHGFg5vPtg7/EyM9wRI8af341g0Yo+1A
 sgFmB79XO9sws1Qy3f+eD0nLrtv3JvGPbNOHQdy/UtJWlF/AEptgvxXp/tXSG9Qo9hk6LSWdOAE
 RH0/BBTnkQPjWiE6N6rp9BGYMBBzwxfR4PHR2dUEMl+fHrIwGnTaceUS0LZ8mBWT/ax0wTlwo0N
 ZFJKI66zdrFamsMo8x53TEaGuu6pU4JxTZPRsO4L/L5SK2nzbTxwU0QxaECr6eJAMrfo1IZaLwD
 76nZ1qM+BJ3VzvguoGGbvCETCoFji/7wmB2XBr/yCki3IXHm8y7W5iJo+I5sxWWNWK3OMOPN0dQ
 DDxj5EruxHzr830JuuTaEpiFWOO6w0Tqa/9gz+rzDUfvcLuzJZ/TPi3F7SjGRfTw2JPzxnnOipr
 BaiTFJcL53+G+4LveSFVY21xb7ZEiYdD9SthgvUthRACkPDBTwZ/QWFdOFMdvTmUdXI+b4Jv4ab
 a6SCOfb5GOwVzCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

adb_kbd_realizefn calls parent_realize but does not check for
errors before continuing. When the caller passes errp as NULL,
a failure is silently ignored and qemu_input_handler_register
runs on a device that failed to realize.

Use ERRP_GUARD() and check *errp to properly detect and
propagate errors regardless of the caller's errp value.

Fixes: 77cb0f5aafc8 ("Split adb.c into adb.c, adb-mouse.c and adb-kbd.c")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-kbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 8635354f024c..d4a131dc1295 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
+#include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "standard-headers/linux/input-event-codes.h"
@@ -385,7 +386,12 @@ static void adb_kbd_realizefn(DeviceState *dev, Error **errp)
     KBDState *s = ADB_KEYBOARD(dev);
     ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
 
+    ERRP_GUARD();
+
     akc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
     s->hs = qemu_input_handler_register(dev, &adb_keyboard_handler);
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


