Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57710F47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyD-0000bf-AR; Thu, 05 Mar 2026 12:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxy-0000Bf-OL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxo-0003j2-T9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Cd51VCF/vRvT+LsS0ZycT/RdLm1KBSg+Z/mg3jWnEo=;
 b=R5Ib9fScPlJs4DjLOPyNnaptcCQn9mrVUql4EbijFU3KtuknaWCdtDChZWm3O8dLRwKctQ
 ISY3ugj0ubkPdnvE8AZGR4T0496o2sM7BwtHh4M0aeHTvwOwACkc8KEB51hUzk/VH3ZJU7
 9hq2NjrAGcV8ZbV9oJjyHR5cPHHq8/E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-NJkPTRtdPzemmn705iZOyA-1; Thu,
 05 Mar 2026 12:58:16 -0500
X-MC-Unique: NJkPTRtdPzemmn705iZOyA-1
X-Mimecast-MFC-AGG-ID: NJkPTRtdPzemmn705iZOyA_1772733494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 629BA1955F3C; Thu,  5 Mar 2026 17:58:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 109683003E9E; Thu,  5 Mar 2026 17:58:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/38] hw/i3c: Add hotplug support
Date: Thu,  5 Mar 2026 18:56:54 +0100
Message-ID: <20260305175711.1119025-22-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

This adds support for hotplugging in I3C.
Conceptually this can be thought of as an I3C target being physically
socketed onto a board.
It is then the target's responsibility to go through the hot-join and
DAA process so it can participate on the bus.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-21-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index 22e6e226a76d..8a37099ce3ff 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/i3c/i3c.h"
+#include "hw/core/hotplug.h"
 #include "hw/core/qdev-properties.h"
 
 /*
@@ -26,6 +27,17 @@ static const Property i3c_props[] = {
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
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)
 {
     return i3c_init_bus_type(TYPE_I3C_BUS, parent, name);
@@ -633,6 +645,11 @@ static const TypeInfo i3c_types[] = {
         .parent = TYPE_BUS,
         .instance_size = sizeof(I3CBus),
         .class_size = sizeof(I3CBusClass),
+        .class_init = i3c_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { }
+        }
     },
     {
         .name = TYPE_I3C_TARGET,
-- 
2.53.0


