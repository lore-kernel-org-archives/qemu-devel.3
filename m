Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC8AE909DA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsO8H-00050I-Qn; Tue, 17 Feb 2026 11:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vsO8F-0004zX-Oy
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vsO8B-0001rv-Gq
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771346456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DejpKVRZUPYFzZjdwhCH66CtHR46oA0qvkrBRbHip10=;
 b=SURr6btiXyuR+eurEAFa1UNRgmL0DsLLYWumAU/XXi8i2FLb5WMpf/miqIh4Xp4ZhqT4Mu
 Emi9sE9xLp3pqwSezRCR+374ltUl59dXOT6OghaCsnTK1DuZL96VTnVzMyf942v6tMxl3H
 q4dMyT/E/HJsIWI/hQLoqwZpCtZTm+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-xFUcS7ZDOr2oHRqHKQmN4g-1; Tue,
 17 Feb 2026 11:40:55 -0500
X-MC-Unique: xFUcS7ZDOr2oHRqHKQmN4g-1
X-Mimecast-MFC-AGG-ID: xFUcS7ZDOr2oHRqHKQmN4g_1771346454
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04AFC1955F11; Tue, 17 Feb 2026 16:40:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8950A30001A5; Tue, 17 Feb 2026 16:40:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached if
 they have a bus
Date: Tue, 17 Feb 2026 17:40:49 +0100
Message-ID: <20260217164049.543975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We still have a lot of devices that end up in /machine/unattached in
case the caller forgot to use object_property_add_child() to add it
to a proper location in the QOM tree. But at least for the devices
that get realized via qdev_realize() and that have a bus specified,
we can do better: Add the device automatically as a child to the bus
device instead! This way the QOM tree looks way more logical, with
way less devices hanging around in the /machine/unattached space.

While we're at it, use the type name as node name (instead of using
"device" like we did in the "unattached" space). But since these
entries might not be stable (they use a counting number in the square
brackets), the code also uses a "x-" prefix here to indicate that
this still might change in the course of time (once a board decides
to manually attach the device with a proper name instead).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/qdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 42641c5224e..5b773d0108a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -266,9 +266,19 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     assert(!dev->realized && !dev->parent_bus);
 
     if (bus) {
+        Object *obj = OBJECT(dev);
+
         if (!qdev_set_parent_bus(dev, bus, errp)) {
             return false;
         }
+
+        if (!obj->parent) {
+            static int count;
+            g_autofree char *name = g_strdup_printf("x-%s[%d]",
+                                                    object_get_typename(obj),
+                                                    count++);
+            object_property_add_child(OBJECT(bus), name, obj);
+        }
     } else {
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
-- 
2.53.0


