Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01864606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpKlUlo1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPInm-0005CT-GR; Fri, 06 Nov 2026 07:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPInT-00058W-IW
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPInS-0006UC-1a
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Kvsei8mb6ZYLzqPBeGIaDqNgytMYWNeC87lKQB99iM=;
 b=SpKlUlo154mSysHpBDpzOEWAzM/hN7BuaSeCdDNoazAWIlervfSaOaeLb3iBLDb2piQBzb
 YDndO4jWPTAHP7nQv8yg6SCbKKP6sj3dKPH9Ptx5wXWBh1ucCN1z5LgSYs1cKaFZ44fcuf
 BBd8vCRROjfcMRoSdgmVpC/wd5sJYbM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-IT0T2QYXNDaNu0D_d8gbLg-1; Fri,
 06 Nov 2026 07:11:50 -0500
X-MC-Unique: IT0T2QYXNDaNu0D_d8gbLg-1
X-Mimecast-MFC-AGG-ID: IT0T2QYXNDaNu0D_d8gbLg_1793967109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FE981955EAD; Fri,  6 Nov 2026 12:11:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D32EE1956047; Fri,  6 Nov 2026 12:11:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BE6321E6885; Fri, 06 Nov 2026 13:11:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 6/6] qom: Convert child and link properties to QAPI-aware
 registration
Date: Fri,  6 Nov 2026 13:11:43 +0100
Message-ID: <20261106121143.3771978-7-armbru@redhat.com>
In-Reply-To: <20261106121143.3771978-1-armbru@redhat.com>
References: <20261106121143.3771978-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Child and link properties get serialized as QOM paths, i.e. as
strings.  Use &str_type_info for them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261105080310.1656968-6-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


