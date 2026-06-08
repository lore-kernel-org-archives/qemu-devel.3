Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAEACD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsL-0002oR-5i; Mon, 08 Jun 2026 01:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrw-0001z0-Jq
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrt-0000mC-2v
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kORBPmEZIJMSQMsLcMufTbzpddl7gyDqe5MbRYQmXCc=;
 b=X4SDGp2QrwGwkldNprVlVF11qyBFjzXXJ+UFduD7vsqvJKHxvGuwFldevFxrTPfZ+Mylri
 GtVU4ibDVup+Gmz6/BDLikmGowOyFPj5ALNuIRiAyVngbVrUv4B/vqiHzZkwNALMizXlLt
 sF8HwwHp+ERiOf88f7BCaIZ1ab740yo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-51yx0cAzMV6QHh7417WJIA-1; Mon,
 08 Jun 2026 01:49:46 -0400
X-MC-Unique: 51yx0cAzMV6QHh7417WJIA-1
X-Mimecast-MFC-AGG-ID: 51yx0cAzMV6QHh7417WJIA_1780897785
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6777C195608B; Mon,  8 Jun 2026 05:49:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A71FD765; Mon,  8 Jun 2026 05:49:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/37] hw/i3c: keep _bytes aliases for renamed queue-capacity
 properties
Date: Mon,  8 Jun 2026 07:48:26 +0200
Message-ID: <20260608054826.346488-38-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>

The command-response/tx-rx/ibi queue-capacity properties were renamed
from "-bytes" to "-words".  The "-bytes" names are user-visible and
shipped in v11.0.0 (reachable via e.g.
-global driver=dw.i3c,property=tx-rx-queue-capacity-bytes,...), so
register them as aliases of the new names to keep existing command
lines working.

object_property_add_alias() forwards both reads and writes to the
target property, so the old names behave exactly as before; introspection
and qom-get/qom-set continue to work under either name.

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260604142207.2118098-4-jithu.joseph@oss.qualcomm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 0d32d9ce78a0..6386499dd9fc 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1830,6 +1830,27 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
     bc->ibi_finish = dw_i3c_ibi_finish;
 }
 
+/*
+ * The *-queue-capacity-bytes properties shipped in v11.0.0 under names that
+ * implied a byte count, but the values are 32-bit word counts (they are passed
+ * straight to fifo32_create()).  They were renamed to *-queue-capacity-words;
+ * keep the old names working as aliases so existing command lines using e.g.
+ * -global driver=dw.i3c,property=tx-rx-queue-capacity-bytes,... don't break.
+ */
+static void dw_i3c_init(Object *obj)
+{
+    static const char *const alias[][2] = {
+        { "command-response-queue-capacity-bytes",
+          "command-response-queue-capacity-words" },
+        { "tx-rx-queue-capacity-bytes", "tx-rx-queue-capacity-words" },
+        { "ibi-queue-capacity-bytes", "ibi-queue-capacity-words" },
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(alias); i++) {
+        object_property_add_alias(obj, alias[i][0], obj, alias[i][1]);
+    }
+}
+
 static const Property dw_i3c_properties[] = {
     DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
     DEFINE_PROP_UINT8("command-response-queue-capacity-words", DWI3C,
@@ -1868,6 +1889,7 @@ static const TypeInfo dw_i3c_types[] = {
         .name = TYPE_DW_I3C,
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(DWI3C),
+        .instance_init = dw_i3c_init,
         .class_init = dw_i3c_class_init,
     },
 };
-- 
2.54.0


