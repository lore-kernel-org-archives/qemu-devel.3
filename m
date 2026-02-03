Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B17E83063
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCB5-0006KH-HA; Tue, 03 Feb 2026 03:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAn-0005Up-KI; Tue, 03 Feb 2026 03:54:15 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAj-0003Po-QD; Tue, 03 Feb 2026 03:54:12 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:39 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:39 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v2 19/20] hw/i3c: Add hotplug support
Date: Tue, 3 Feb 2026 16:52:19 +0800
Message-ID: <20260203085229.1543287-20-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joe Komlodi <komlodi@google.com>

This adds support for hotplugging in I3C.
Conceptually this can be thought of as an I3C target being physically
socketed onto a board.
It is then the target's responsibility to go through the hot-join and
DAA process so it can participate on the bus.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index fb4bfe5aec..1ab95c4866 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/i3c/i3c.h"
+#include "hw/core/hotplug.h"
 #include "hw/core/qdev-properties.h"
 
 /*
@@ -26,11 +27,27 @@ static const Property i3c_props[] = {
     DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),
 };
 
+static void i3c_realize(BusState *bus, Error **errp)
+{
+    qbus_set_bus_hotplug_handler(bus);
+}
+
+static void i3c_class_init(ObjectClass *klass, const void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+    k->realize = i3c_realize;
+}
+
 static const TypeInfo i3c_bus_info = {
     .name = TYPE_I3C_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(I3CBus),
     .class_size = sizeof(I3CBusClass),
+    .class_init = i3c_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    }
 };
 
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)
-- 
2.43.0


