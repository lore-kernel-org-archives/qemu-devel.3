Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC143CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBVrV-0000Sd-QL; Wed, 22 Oct 2025 06:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBVrU-0000SL-Ax
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBVrR-0000N6-Nm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761128068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPSzraC6QEHJmGEo+pLPMY9vcqHnjyTu9JEXZEWPdbM=;
 b=YP4UrwDPUIUYmiBdllpbiDBc8Jpg4v/n7zhAtF0LOdTsC3TrgJUah2LrjiOjit74ALEUHc
 4mIwVWNb8/XalqfHdlGUhReVBmJ8zElzCWrcL+EjyMarujdWONQHFou3y7WVKlrtt2zZ53
 7wPR/oO3fN1OM22OY/9SXTinjhPc49A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-3TsJz08EOTmKQ0A9fkUw5g-1; Wed,
 22 Oct 2025 06:14:25 -0400
X-MC-Unique: 3TsJz08EOTmKQ0A9fkUw5g-1
X-Mimecast-MFC-AGG-ID: 3TsJz08EOTmKQ0A9fkUw5g_1761128064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB40C1800D88; Wed, 22 Oct 2025 10:14:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B41B19540E7; Wed, 22 Oct 2025 10:14:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73EE721E6924; Wed, 22 Oct 2025 12:14:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, philmd@linaro.org
Subject: [PATCH 1/3] qdev: Change PropertyInfo method print() to return
 malloc'ed string
Date: Wed, 22 Oct 2025 12:14:18 +0200
Message-ID: <20251022101420.36059-2-armbru@redhat.com>
In-Reply-To: <20251022101420.36059-1-armbru@redhat.com>
References: <20251022101420.36059-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Simpler (more so after the next commit), and no risk of truncation
because the caller's buffer is too small.  Performance doesn't matter;
the method is only used for "info qdev".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-properties.h     | 2 +-
 hw/core/qdev-properties-system.c | 7 +++----
 hw/core/qdev-properties.c        | 9 ++++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 0197aa4995..60b8133009 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,7 +34,7 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     bool realized_set_allowed; /* allow setting property on realized device */
-    int (*print)(Object *obj, const Property *prop, char *dest, size_t len);
+    char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
                               const Property *prop);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1f810b7ddf..4e1afaac82 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -865,15 +865,14 @@ out:
     visit_end_alternate(v, (void **) &alt);
 }
 
-static int print_pci_devfn(Object *obj, const Property *prop, char *dest,
-                           size_t len)
+static char *print_pci_devfn(Object *obj, const Property *prop)
 {
     int32_t *ptr = object_field_prop_ptr(obj, prop);
 
     if (*ptr == -1) {
-        return snprintf(dest, len, "<unset>");
+        return g_strdup("<unset>");
     } else {
-        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
+        return g_strdup_printf("%02x.%x", *ptr >> 3, *ptr & 7);
     }
 }
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index b7e8a89ba5..422a486969 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1117,12 +1117,11 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
                                      Error **errp)
 {
     const Property *prop = opaque;
+    char *s;
 
-    char buffer[1024];
-    char *ptr = buffer;
-
-    prop->info->print(obj, prop, buffer, sizeof(buffer));
-    visit_type_str(v, name, &ptr, errp);
+    s = prop->info->print(obj, prop);
+    visit_type_str(v, name, &s, errp);
+    g_free(s);
 }
 
 /**
-- 
2.49.0


