Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LRvq5VFP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIv-0008Lu-V6; Thu, 26 Nov 2026 05:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIa-00088o-VQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-0006gs-Ny
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUBHAV54AlQADW1hv60F+klj20fKlP5u49sNMJhN0Ts=;
 b=LRvq5VFPHiheChYHhWfJnilBYHKw1m7gR4t01Vjdvdt3sYocAywKginPN+mIFna0dwm+j0
 Pb13s/6Vg1SK7BseP+1P9EEs9+yPlkWBJlXgE17/m68uyNK9h3LEvYBxAEOoJ6l9CNA4AK
 EXFMCjl36qn46xup4FuZxhPq7dYdH8w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-IiYwYf0kP5GNOVtl7qEmDA-1; Thu,
 26 Nov 2026 10:01:46 +0000
X-MC-Unique: IiYwYf0kP5GNOVtl7qEmDA-1
X-Mimecast-MFC-AGG-ID: IiYwYf0kP5GNOVtl7qEmDA_1795687305
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B20931800679; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F5F41801A67; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D48A621E6886; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 07/16] qom: Wean "is child?" checks off ObjectProperty member
 @type
Date: Thu, 26 Nov 2026 11:01:30 +0100
Message-ID: <20261126100139.3557890-8-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

object_property_is_child() parses member @type to decide.  Check the
getter instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h |  1 +
 qom/object.c         | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index dbfc29a2d6a..f43b13dfca7 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1886,6 +1886,7 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+bool object_property_is_child(ObjectProperty *prop);
 /**
  * object_resolve_and_typecheck:
  * @path: path to look up
diff --git a/qom/object.c b/qom/object.c
index 14fd2f3d17e..4a3c2a8f4a6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -589,11 +589,6 @@ void object_initialize_child_internal(Object *parent,
                                        &error_abort, NULL);
 }
 
-static inline bool object_property_is_child(ObjectProperty *prop)
-{
-    return strstart(prop->type, "child<", NULL);
-}
-
 static void object_property_del_all(Object *obj)
 {
     g_autoptr(GHashTable) done = g_hash_table_new(NULL, NULL);
@@ -2159,6 +2154,15 @@ object_property_add_const_link(Object *obj, const char *name,
                                 NULL, OBJ_PROP_LINK_DIRECT);
 }
 
+bool object_property_is_child(ObjectProperty *prop)
+{
+    if (prop->get == object_get_child_property) {
+        assert(prop->qom_type);
+        return true;
+    }
+    return false;
+}
+
 const char *object_get_canonical_path_component(const Object *obj)
 {
     ObjectProperty *prop = NULL;
-- 
2.55.0


