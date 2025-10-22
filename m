Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EE7CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBVrZ-0000TM-2i; Wed, 22 Oct 2025 06:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBVrX-0000Sx-5E
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBVrV-0000NW-Fe
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761128072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhfG16hvXCbVCWGnPZmAYWx+63yuz7s4f2/aWRtWMNA=;
 b=fI4wbQ7+FdYIGxzBU8+Gm7ODcnoxb10fHWlO5z8eAmdQ4jCrapc1pkC04SLqo7ovIjUS1H
 hOxcee467C0DR10Xm8d9uAWEcbihUto0Nhi3Cok6o7hY2knabm6zckCaqBqpfUMuFtN/NP
 iEVjmdfj2C7+uXiYFEGayGBjhm5FGH4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-MbEVyagxM1SYMn3btLKjrg-1; Wed,
 22 Oct 2025 06:14:25 -0400
X-MC-Unique: MbEVyagxM1SYMn3btLKjrg-1
X-Mimecast-MFC-AGG-ID: MbEVyagxM1SYMn3btLKjrg_1761128064
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5477180AE12; Wed, 22 Oct 2025 10:14:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57FC01800597; Wed, 22 Oct 2025 10:14:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B4DA21E6935; Wed, 22 Oct 2025 12:14:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, philmd@linaro.org
Subject: [PATCH 3/3] qdev: Legacy properties are now unused, drop
Date: Wed, 22 Oct 2025 12:14:20 +0200
Message-ID: <20251022101420.36059-4-armbru@redhat.com>
In-Reply-To: <20251022101420.36059-1-armbru@redhat.com>
References: <20251022101420.36059-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c | 46 ---------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969..46a12652f4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1108,51 +1108,6 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     object_class_property_set_description(oc, name, prop->info->description);
 }
 
-/**
- * Legacy property handling
- */
-
-static void qdev_get_legacy_property(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
-{
-    const Property *prop = opaque;
-    char *s;
-
-    s = prop->info->print(obj, prop);
-    visit_type_str(v, name, &s, errp);
-    g_free(s);
-}
-
-/**
- * qdev_class_add_legacy_property:
- * @dev: Device to add the property to.
- * @prop: The qdev property definition.
- *
- * Add a legacy QOM property to @dev for qdev property @prop.
- *
- * Legacy properties are string versions of QOM properties.  The format of
- * the string depends on the property type.  Legacy properties are only
- * needed for "info qtree".
- *
- * Do not use this in new code!  QOM Properties added through this interface
- * will be given names in the "legacy" namespace.
- */
-static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop)
-{
-    g_autofree char *name = NULL;
-
-    /* Register pointer properties as legacy properties */
-    if (!prop->info->print && prop->info->get) {
-        return;
-    }
-
-    name = g_strdup_printf("legacy-%s", prop->name);
-    object_class_property_add(OBJECT_CLASS(dc), name, "str",
-        prop->info->print ? qdev_get_legacy_property : prop->info->get,
-        NULL, NULL, (Property *)prop);
-}
-
 void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
 {
     /* We used a hole in DeviceClass because that's still a lot. */
@@ -1165,7 +1120,6 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
     for (size_t i = 0; i < n; ++i) {
         const Property *prop = &props[i];
         assert(prop->name);
-        qdev_class_add_legacy_property(dc, prop);
         qdev_class_add_property(dc, prop->name, prop);
     }
 }
-- 
2.49.0


