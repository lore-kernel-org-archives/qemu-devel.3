Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F25CA5FF4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQw-0004hM-JA; Sun, 04 Oct 2026 06:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQs-0004OU-PB
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQr-0003U5-6H
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4iECetYAX5S5NWj4H12hCE6r3EGVFcApu9h9RLuvF8=;
 b=LAJ3anhJ7BnL3/VFQKW2iupWi7EhiNkggNnjxn3xYGqZP7Fm8N1yUiRJ0rCf7I6JWnBlED
 ZZDolEzNOv6Zt4o1nqcGC6s1UDWV3MCNJ3msbQ+EhsJVmee08ol7I3il9bpHMj9NeqOPDU
 +H/Bj0nZCERWF9/hr7PAc/iiauq4iOE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-x9bC-mR5PI6crauY2VPAmg-1; Sun,
 04 Oct 2026 06:26:58 -0400
X-MC-Unique: x9bC-mR5PI6crauY2VPAmg-1
X-Mimecast-MFC-AGG-ID: x9bC-mR5PI6crauY2VPAmg_1791109617
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BDFC1954204; Sun,  4 Oct 2026 10:26:57 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29EB340E; Sun,  4 Oct 2026 10:26:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:10 +0400
Subject: [PATCH 56/63] hw/input/adb-mouse: check for errors after parent
 realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-56-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Rbry219DTUybtfGB5pj/JABK3sCv4OsG8g6BnC8nqqQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklw02s7ml10L/nOOFpGsd0kkRaUpas0XXBv
 r4kOkzdaRyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5faoEACUghGG8OjFfX6++Mhyg8e3DcfBebYOXEjYNAG8FaqL+ABKtpErYWMYuib4iOsVxzVd5Jo
 Ekx9g8AiqdROJtiropNrX228VOhiGKNAnKR1qrFyZs1x6WnwG2OHQYTZLoGOPr2pT9eyNqAfap7
 cz0HVJNVPU5Dlya0o3Wo2CzOBaR1XNZ/4SFVhgOd331FN31mlofygtvb1mJCUw8k9+Iq7enAEE8
 h9PMQAyLQHNJBj23QMdGv4naiOzN1UEWmivlnfw5+UlvZNI6kIKESVk10lZa13smFmE/QyMRzHL
 8upaM1HdJQxAtWu1fJRqGA3AqnM4pENsmqKpsRWN+UxYVjqguEjTtKL2MGxfaOpvJEVXtbXecRn
 hvNMsJIiMzqxhkxRGDm+nOuHRxd5xf6vxXWBQQfux2tRt1vFY+mIyXiXnLgXZ/9RMexh1549/TZ
 y23OR/kSdhqSY8i95AUu0zMuwZkKNfThcay3ijDPX2FsXOBVxqLkQ5E66VKED66mHnZnuX9zpU0
 poTqRTTfnsKCio3Li+zDR8dqsL2smbLEqB7TJyK3rsW+vsorCQtilS1SSQy1yrLJ3t7Zl99oQtH
 +hOM5mXVb98t44TrX0GknuoUDg2hdjurWhJZs1FgB6XU5w4LUYGvtoY5cstUepatkV77XF+j2MC
 woydCrmglIb7Q1Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

adb_mouse_realizefn calls parent_realize but does not check for
errors before continuing. When the caller passes errp as NULL,
a failure is silently ignored and qemu_input_handler_register
runs on a device that failed to realize.

Use ERRP_GUARD() and check *errp to properly detect and
propagate errors regardless of the caller's errp value.

Fixes: 2e4a7c9c5df4 ("adb: QOM'ify ADB devices")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-mouse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 80584cce1c6b..f9f989930ba1 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "ui/console.h"
 #include "hw/input/adb.h"
+#include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "adb-internal.h"
@@ -274,7 +275,12 @@ static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
     MouseState *s = ADB_MOUSE(dev);
     ADBMouseClass *amc = ADB_MOUSE_GET_CLASS(dev);
 
+    ERRP_GUARD();
+
     amc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     s->hs = qemu_input_handler_register(dev, &adb_mouse_handler);
 }

-- 
2.56.0.rc0.29.g47ce80527c56


