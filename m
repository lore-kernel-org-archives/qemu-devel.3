Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EOVMn+du
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc1D-00061l-I3; Sun, 01 Nov 2026 15:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzf-0004rN-Pp
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbza-00079f-Ds
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJjhP1BkvYlI8yYC+l6PVE20U9iCYk6O6nPiXkZNmHw=;
 b=EOVMn+duQpQywzQ24NP0S7W/Id4ud++EDuTqnOLMm4yvpEpEjw6IVP8/0RAtkuzAx2SRv9
 XnF1CVLRLLXW0jvrjJdz0qs0Z7i6VYpVIG5bijNDtehm9BMaGxP3qOMQ6XIu2fo9Ddp5EF
 4llxc0IwayQ/Un2SO04EDN3UEUJnIqE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-ek-ULeB6MmmJIUPN-aAK8A-1; Sun,
 01 Nov 2026 15:17:24 -0500
X-MC-Unique: ek-ULeB6MmmJIUPN-aAK8A-1
X-Mimecast-MFC-AGG-ID: ek-ULeB6MmmJIUPN-aAK8A_1793564243
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63A831800616
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FD73000B78
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC9CA21E688A; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 10/56] qom: add qapi_type field to ObjectProperty
Date: Sun,  1 Nov 2026 21:16:31 +0100
Message-ID: <20261101201717.3911097-11-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for now,
but future patches will add means to make it non-null. The
QAPITypeInfo will then be used by QOM introspection to tie the
property to a QAPI type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 2 ++
 qom/object.c         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 90c1a34e49..e9b380462d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -15,6 +15,7 @@
 #define QEMU_OBJECT_H
 
 #include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-type-info.h"
 #include "qemu/module.h"
 
 struct TypeImpl;
@@ -91,6 +92,7 @@ struct ObjectProperty
     char *name;
     char *type;
     char *description;
+    const QAPITypeInfo *qapi_type;
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyResolve *resolve;
diff --git a/qom/object.c b/qom/object.c
index 96498f3d00..c34b47312f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3171,6 +3171,7 @@ object_property_add_alias(Object *obj, const char *name,
                              property_release_alias,
                              prop);
     op->resolve = property_resolve_alias;
+    op->qapi_type = target_prop->qapi_type;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }
-- 
2.55.0


