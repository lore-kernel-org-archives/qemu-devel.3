Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7CD606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LFZ856CG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOUlR-0006sI-2c; Wed, 04 Nov 2026 01:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOUl5-0006mf-Lh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 01:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOUl1-0002dE-Aw
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 01:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793774760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AVqcY8H3BpY+PvfoWZwCrHtPMDav6fFgDI4l/GAK0Y=;
 b=LFZ856CG+2a8B5ZRrUxE4xM8lcqQjiD5eguYTIAK/BHF4aRtXqMyCyyh/lfkev0JcIMJgR
 +G6yI6jM6JF6JotmD+aMBIHIzx8VL0JDSwHNy/RynB5z7EeXJCG1VFJhwCDQXPrv7hDZmV
 7yCcdSP62O9dYewgJ9CIejNmnhXDEPM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-S23INl-fNEKftHh0R7np4w-1; Wed,
 04 Nov 2026 01:45:57 -0500
X-MC-Unique: S23INl-fNEKftHh0R7np4w-1
X-Mimecast-MFC-AGG-ID: S23INl-fNEKftHh0R7np4w_1793774756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2992195609D; Wed,  4 Nov 2026 06:45:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E72430000E5; Wed,  4 Nov 2026 06:45:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C295521E6883; Wed, 04 Nov 2026 07:45:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 milesg@linux.ibm.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 4/4] qom: Convert alias properties to QAPI-aware registration
Date: Wed,  4 Nov 2026 07:45:52 +0100
Message-ID: <20261104064552.959862-5-armbru@redhat.com>
In-Reply-To: <20261104064552.959862-1-armbru@redhat.com>
References: <20261104064552.959862-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Pass the target property's QAPITypeInfo to object_class_property_add()
/ object_property_add().

Commit 53c674710b4 (qom: add qapi_type field to ObjectProperty)
already monkey-patched it in object_property_add_alias(), but not in
object_class_property_add_alias().  Delete that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index cd0590c3fd..774a976c8b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3099,13 +3099,13 @@ object_property_add_alias(Object *obj, const char *name,
     prop->target_name = g_strdup(target_name);
     prop->flags = 0;
 
-    op = object_property_add(obj, name, prop_type, NULL,
+    op = object_property_add(obj, name, prop_type,
+                             target_prop->qapi_type,
                              property_get_alias,
                              property_set_alias,
                              property_release_alias,
                              prop);
     op->resolve = property_resolve_alias;
-    op->qapi_type = target_prop->qapi_type;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }
@@ -3144,7 +3144,8 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     prop->target_name = g_strdup(target_name);
     prop->flags = OBJ_PROP_ALIAS_CLASS;
 
-    op = object_class_property_add(klass, name, prop_type, NULL,
+    op = object_class_property_add(klass, name, prop_type,
+                                   target_prop->qapi_type,
                                    property_get_alias,
                                    property_set_alias,
                                    property_release_alias,
-- 
2.55.0


