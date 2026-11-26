Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF36606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MmojMnih
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIi-0008DO-ON; Thu, 26 Nov 2026 05:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIZ-000884-K7
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-0006h6-MC
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNi5QXtt2pW5bHpggkU/ytWiBk0ZG0e1pI8kBR7VKYA=;
 b=MmojMnihs3EjsFholQ4Zc6QixDr218JZqAu+o4DlmaFI6PJtAerTcDmjUbNlawiU3sPQa6
 cf9mc8Jqd/G+zow7Xfzpj72TgQbENvjlSSHUU7LLIg7tB4C8vJbPrMHz3BNZg9zOW/ctTs
 QVgf2rPqaZx8HYA8t1kg6fD+y4HUV+8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-d-HprILPNi6MO-CkMqzRsw-1; Thu,
 26 Nov 2026 10:01:46 +0000
X-MC-Unique: d-HprILPNi6MO-CkMqzRsw-1
X-Mimecast-MFC-AGG-ID: d-HprILPNi6MO-CkMqzRsw_1795687305
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A796195604F; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 379A23000229; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8AB921E6887; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 08/16] qom: Wean "is link?" checks off ObjectProperty member
 @type
Date: Thu, 26 Nov 2026 11:01:31 +0100
Message-ID: <20261126100139.3557890-9-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Several functions parse member @type to decide whether it is a link.
Use new object_property_is_link() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h |  2 ++
 hw/ppc/spapr_drc.c   |  4 ++--
 qom/object.c         | 14 ++++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f43b13dfca7..b394ec642d3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1887,6 +1887,8 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                               ObjectPropertyLinkFlags flags);
 
 bool object_property_is_child(ObjectProperty *prop);
+bool object_property_is_link(ObjectProperty *prop);
+
 /**
  * object_resolve_and_typecheck:
  * @path: path to look up
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 7663f232e05..a10410c8ec3 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -882,7 +882,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
         g_autofree char *drc_name = NULL;
         uint32_t drc_index, drc_power_domain;
 
-        if (!strstart(prop->type, "link<", NULL)) {
+        if (!object_property_is_link(prop)) {
             continue;
         }
 
@@ -971,7 +971,7 @@ restart:
     while ((prop = object_property_iter_next(&iter))) {
         SpaprDrc *drc;
 
-        if (!strstart(prop->type, "link<", NULL)) {
+        if (!object_property_is_link(prop)) {
             continue;
         }
         drc = SPAPR_DR_CONNECTOR(object_property_get_link(drc_container,
diff --git a/qom/object.c b/qom/object.c
index 4a3c2a8f4a6..badc12fe4a8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2163,6 +2163,14 @@ bool object_property_is_child(ObjectProperty *prop)
     return false;
 }
 
+bool object_property_is_link(ObjectProperty *prop)
+{
+    if (object_property_is_child(prop)) {
+        return false;
+    }
+    return prop->qom_type != NULL;
+}
+
 const char *object_get_canonical_path_component(const Object *obj)
 {
     ObjectProperty *prop = NULL;
@@ -3084,8 +3092,7 @@ object_property_add_alias(Object *obj, const char *name,
                                            &error_abort);
 
     if (object_property_is_child(target_prop)) {
-        prop_type = g_strdup_printf("link%s",
-                                    target_prop->type + strlen("child"));
+        prop_type = g_strdup_printf("link<%s>", target_prop->qom_type);
     } else {
         prop_type = g_strdup(target_prop->type);
     }
@@ -3130,8 +3137,7 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     assert(target_prop);
 
     if (object_property_is_child(target_prop)) {
-        prop_type = g_strdup_printf("link%s",
-                                    target_prop->type + strlen("child"));
+        prop_type = g_strdup_printf("link<%s>", target_prop->qom_type);
     } else {
         prop_type = g_strdup(target_prop->type);
     }
-- 
2.55.0


