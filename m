Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E18BCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQf-0003Fd-IT; Sun, 04 Oct 2026 06:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQY-00035P-JR
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQX-0003RU-3I
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+XwlDxSz8o3BcKacI/qwHwPj8/wiUO6/Rh0V5ef+PA=;
 b=HyEJm209P3CpNBM1ME191HKbI6MkPi71uoCNO5OU2FXatnMlMHQnD+wjcAFCGLComfYMEy
 AMWYQrS5320jWbYE7wf+oSGCKyXceP7AjewfVVzA2S7u2R6g40tZd6ULWXt5i0IDPwTVzl
 dyOfx0jGSUMUXB18rLFHYo50gM+P0cw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-Kc47385GO3G5vrZZk8ifnw-1; Sun,
 04 Oct 2026 06:26:37 -0400
X-MC-Unique: Kc47385GO3G5vrZZk8ifnw-1
X-Mimecast-MFC-AGG-ID: Kc47385GO3G5vrZZk8ifnw_1791109596
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D8C51955E7F; Sun,  4 Oct 2026 10:26:36 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 126FF1800345; Sun,  4 Oct 2026 10:26:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:04 +0400
Subject: [PATCH 50/63] hw/input/adb: report error when too many devices are
 registered
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-50-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZsM+lXVUO9PSqk/eR9tI0K9z3M6PNX4kuMnOBUaWanA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkJ8+AQcPsD+TbFdwLvaIWOnXx9gmHh3Var
 zN/lFUpMrWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5aQvEACLirtFdLAAnpAx23tCaMSWoC5vDf6/3JpCN9U7R+kAsLVxZ5WdZ/X1ZbxnLB0Uo/H4n6i
 BSRqmroMyqcHXzdL3GKL6wIJA8OnRWI8tg2Gny0lKa6qp1C3XmdIsNuExBtBqYxLdOmqWb784RK
 TeQLi1Zy0rI9q7zzz6CITRhvJoUz79kzs1GcvaYJaAIhZ83jXNWerOxIpjjeG6YKy/MmYxcDRnm
 Fref/NrN4ET94hiRx+BvhgG8679+QJXuNaWNMjOBwF2Fawch3l7Gy0sEkTovyQGaDn1DneaHE7h
 DzOc/AyPt74ff4XPjg6K0jOQmoOG7WoDwGxGnhFKzBDFexuG6vhb5u59UF6vNODklL6lhk14MOv
 v8jNUPnceDxoqkxyUjaE2ALwrWUw6BSPV/5LEnJEYWruwFTVyYWym6kx+pnSORqSlyGNT6t4b/y
 uql26T+iZvImVm/CxD1waeuI//S/EvDqJj6SHv3sMXl2DSagMzU7tQ43C5UIIQS8PtUXfxnH7y6
 +GVM1Ln74I4zDf+xnFzz6ovQFprtgIb/FsqwLWcAiVjgsMZd4AqDgPzId4kzLA/UtN3YiALwCX6
 /4dOSPTyry/Y79nF43ghDzf00w4pcNzvqgjZkvAQnyRj0pQaNy3tHPszkfXsRFb1/1jsEdaplMa
 aF4ZJwCCwUV2s0A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

adb_device_realizefn() returns early when the bus is full but does
not set errp, so the caller has no way to know the device failed to
realize. Set an error so the failure is properly propagated.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 0606b2883038 ("adb: introduce realize/unrealize and VMStateDescription for ADB bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index b6319fa31535..54d00e2cd30c 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
 #include "hw/core/qdev-properties.h"
+#include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
@@ -308,6 +309,7 @@ static void adb_device_realizefn(DeviceState *dev, Error **errp)
     ADBBusState *bus = ADB_BUS(qdev_get_parent_bus(dev));
 
     if (bus->nb_devices >= MAX_ADB_DEVICES) {
+        error_setg(errp, "Too many ADB devices");
         return;
     }
 

-- 
2.56.0.rc0.29.g47ce80527c56


