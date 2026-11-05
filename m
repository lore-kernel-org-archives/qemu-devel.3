Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F87606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ISbUhYo6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsRV-0006tQ-98; Thu, 05 Nov 2026 03:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOsRN-0006sW-Mp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:03:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOsRL-0005OE-PB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793865798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IP88lOr/I0lCLejvkbrvDEqaGtxg4HlAAcFPUmwhgE=;
 b=ISbUhYo6MwcQ0RaHRXrprVMTmzjWZvBffMrf6wPnT7WcoZAs5dNW3paBaiIJaLOea0PWX3
 FcJMcqV/W1+d7U6xnv20d+Hx1RxNOe1kPuzCXaN6oQ4019TFMzA0YKKxgyldxV8me1xYwP
 QVJBTPP9rRl5hVPHGTX5c5yY4XxL1As=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-vmxv7Q_JNe-fxn0KSn2hFQ-1; Thu,
 05 Nov 2026 03:03:17 -0500
X-MC-Unique: vmxv7Q_JNe-fxn0KSn2hFQ-1
X-Mimecast-MFC-AGG-ID: vmxv7Q_JNe-fxn0KSn2hFQ_1793865796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E81F180130E
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 08:03:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D53B1956087
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 08:03:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09E2321E6884; Thu, 05 Nov 2026 09:03:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 5/5] qom: Convert child and link properties to QAPI-aware
 registration
Date: Thu,  5 Nov 2026 09:03:10 +0100
Message-ID: <20261105080310.1656968-6-armbru@redhat.com>
In-Reply-To: <20261105080310.1656968-1-armbru@redhat.com>
References: <20261105080310.1656968-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Child and link properties get serialized as QOM paths, i.e. as
strings.  Use &str_type_info for them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 774a976c8b..9276b7a435 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1914,7 +1914,7 @@ object_property_try_add_child(Object *obj, const char *name,
 
     type = g_strdup_printf("child<%s>", object_get_typename(child));
 
-    op = object_property_try_add(obj, name, type, NULL,
+    op = object_property_try_add(obj, name, type, &str_type_info,
                                  object_get_child_property,
                                  NULL, object_finalize_child_property,
                                  child, errp);
@@ -2109,7 +2109,7 @@ object_add_link_prop(Object *obj, const char *name,
 
     full_type = g_strdup_printf("link<%s>", type);
 
-    op = object_property_add(obj, name, full_type, NULL,
+    op = object_property_add(obj, name, full_type, &str_type_info,
                              object_get_link_property,
                              check ? object_set_link_property : NULL,
                              object_release_link_property,
@@ -2146,7 +2146,7 @@ object_class_property_add_link(ObjectClass *oc,
 
     full_type = g_strdup_printf("link<%s>", type);
 
-    op = object_class_property_add(oc, name, full_type, NULL,
+    op = object_class_property_add(oc, name, full_type, &str_type_info,
                                    object_get_link_property,
                                    check ? object_set_link_property : NULL,
                                    object_release_link_property,
-- 
2.55.0


