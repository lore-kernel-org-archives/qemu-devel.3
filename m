Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE5DE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTitL-0002SN-3Z; Fri, 03 Jan 2025 09:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitJ-0002Rc-10
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitD-0007FA-5c
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+e+kTxhD8RnkNKf7KBptdQDPJMksNIHWemz5ZQPZco=;
 b=KPYwqmmzGHfe18dXR3NwzlyggoLO849vp8wgZ+nQ7l3rq88RyXbgRu3iHmFYDHFLCf1wTE
 OnEq+rjzS7YegPoyXg6BdxOsfaqeDFJ1iQXfHCLjc+Lhpklm+SwU38sV901Di9X+i/IXFm
 ZTvwiOrgyrKVLJfyOskQ+0B+ePi3bx0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-6MPFr2UHPqakSDESJbauTQ-1; Fri,
 03 Jan 2025 09:42:59 -0500
X-MC-Unique: 6MPFr2UHPqakSDESJbauTQ-1
X-Mimecast-MFC-AGG-ID: 6MPFr2UHPqakSDESJbauTQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 290C0195608A; Fri,  3 Jan 2025 14:42:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 776E3300F9B5; Fri,  3 Jan 2025 14:42:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 06/10] hw/s390x/css-bridge: Remove the "css_dev_path" property
Date: Fri,  3 Jan 2025 15:42:28 +0100
Message-ID: <20250103144232.520383-7-thuth@redhat.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
References: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that the s390-ccw-virtio-2.6 and older machine types have been
removed, the "css_dev_path" property of the css-bridge is also not
used anymore and thus can be removed.

This way we finally get rid of the problem that has been described
in: https://gitlab.com/qemu-project/qemu/-/issues/2213

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/css-bridge.h |  1 -
 hw/s390x/css-bridge.c         | 16 +---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.h
index deb606d71f..4f874ed781 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -19,7 +19,6 @@
 /* virtual css bridge */
 struct VirtualCssBridge {
     SysBusDevice sysbus_dev;
-    bool css_dev_path;
 };
 
 #define TYPE_VIRTUAL_CSS_BRIDGE "virtual-css-bridge"
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 04ab1f6402..c48d5571b5 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -66,16 +66,8 @@ static char *virtual_css_bus_get_dev_path(DeviceState *dev)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
-    VirtualCssBridge *bridge =
-        VIRTUAL_CSS_BRIDGE(qdev_get_parent_bus(dev)->parent);
 
-    /*
-     * We can't provide a dev path for backward compatibility on
-     * older machines, as it is visible in the migration stream.
-     */
-    return bridge->css_dev_path ?
-        g_strdup_printf("/%02x.%1x.%04x", sch->cssid, sch->ssid, sch->devno) :
-        NULL;
+    return g_strdup_printf("/%02x.%1x.%04x", sch->cssid, sch->ssid, sch->devno);
 }
 
 static void virtual_css_bus_class_init(ObjectClass *klass, void *data)
@@ -120,11 +112,6 @@ VirtualCssBus *virtual_css_bus_init(void)
 
 /***************** Virtual-css Bus Bridge Device ********************/
 
-static const Property virtual_css_bridge_properties[] = {
-    DEFINE_PROP_BOOL("css_dev_path", VirtualCssBridge, css_dev_path,
-                     true),
-};
-
 static bool prop_get_true(Object *obj, Error **errp)
 {
     return true;
@@ -137,7 +124,6 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
 
     hc->unplug = ccw_device_unplug;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    device_class_set_props(dc, virtual_css_bridge_properties);
     object_class_property_add_bool(klass, "cssid-unrestricted",
                                    prop_get_true, NULL);
     object_class_property_set_description(klass, "cssid-unrestricted",
-- 
2.47.1


