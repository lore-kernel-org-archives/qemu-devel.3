Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9TFzzdB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUxr-0003Hh-Pl; Thu, 12 Nov 2026 08:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUul-0006n4-Et
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUui-000688-O8
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufcCI4vQPg8BwrzfrNGnyAet9CxziKfMsXW2WeaWd28=;
 b=Z9TFzzdBwQABOC+Y0euk5DjcUXTlY+2U7dAQcWZwXfQidSmQakKqVjodlk5K3MDSX3hx11
 SNMjGYOR8atffy5pruAceSdLSKVM7hXmzHnPgm9mC4WZ1P09zzTjMJSR3M2FvqpLfUAWdl
 IzeZ134hzkTQIYg47ZEiuwL03f7VJuY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-J8yQleg4Me2UQFiui9HB7g-1; Thu,
 12 Nov 2026 08:32:26 -0500
X-MC-Unique: J8yQleg4Me2UQFiui9HB7g-1
X-Mimecast-MFC-AGG-ID: J8yQleg4Me2UQFiui9HB7g_1794490345
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A57D195606C; Thu, 12 Nov 2026 13:32:25 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EA34195608D; Thu, 12 Nov 2026 13:32:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 48/48] hw/virtio/virtio-mem: unconditionally expose
 'unplugged-inaccessible'
Date: Thu, 12 Nov 2026 13:30:54 +0000
Message-ID: <20261112133054.1977618-49-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yonggang Luo <luoyonggang@gmail.com>

With the multi-target work, the goal is to move to a single
unified QOM tree that applies universally across all targets.
This complements the migration away from instance level
properties to class level properties, which again aims to
ensure a statically defined stable QOM object model for each
class.

This requires that properties are either unconditionally
registered in the class, with invalid options rejected
at runtime (for example, during realize()), or that distinct
subclasses are used for specialized use cases that need a
distinct impl for some targets.

It is harmless to have the 'unplugged-inaccessible' property
registered unconditionally so take the simple option.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-mem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 546ea18b7c4..fb029581024 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -880,7 +880,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
             break;
         }
     } else {
-        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+        if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
+            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
+                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+            return;
+        }
     }
 
     if (vmem->dynamic_memslots &&
@@ -1573,9 +1577,6 @@ static const Property virtio_mem_properties[] = {
                      early_migration, true),
     DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
                      dynamic_memslots, false),
-};
-
-static const Property virtio_mem_legacy_guests_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
                             unplugged_inaccessible, ON_OFF_AUTO_ON),
 };
@@ -1640,9 +1641,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
-    if (virtio_mem_has_legacy_guests()) {
-        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
-    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.56.1


