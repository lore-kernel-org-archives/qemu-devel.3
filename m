Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5A606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMtrQhP7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnZI-0000cz-IO; Mon, 02 Nov 2026 03:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNnYx-0000DF-L8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNnYv-0005PE-Io
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793608720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZbxYKEIrb+qmJNYYs5HJfGBsZLggf+QHzMArzx+p7Q=;
 b=aMtrQhP7g3v9UKENuiFiIC6kv+kpDJJVM0Ayo5Idw8jeTs+/9XYv1ZsV6Kl37P2MLq/Fck
 tEd0TgzxVgUeWQDWUL+U2jRBl24po8L81KjfNok9bRI/mCzJiUSjHabDfK+55RYCzLcSIu
 v2l4jW1l50zsyiAPr5y+1v76wHIFOFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-YquunfakPdm0eiqVUubWgg-1; Mon,
 02 Nov 2026 03:38:39 -0500
X-MC-Unique: YquunfakPdm0eiqVUubWgg-1
X-Mimecast-MFC-AGG-ID: YquunfakPdm0eiqVUubWgg_1793608718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BB581953997
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 08:38:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDB2130001B9
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 08:38:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6742A21E6A04; Mon, 02 Nov 2026 09:38:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v8 14/56] qom: New object_property_add() etc. parameter
 @qapi_type
In-Reply-To: <8733tjvgb3.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 02 Nov 2026 08:33:04 +0100")
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-15-armbru@redhat.com>
 <179359759593.3177668.4375922821610706196.b4-review@b4>
 <8733tjvgb3.fsf@pond.sub.org>
Date: Mon, 02 Nov 2026 09:38:35 +0100
Message-ID: <87ld7bsk50.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marc-Andr=C3=A9, may I have your R-by with the appended fixup?

diff --git a/include/qom/object.h b/include/qom/object.h
index 9338f0b986..70d8ea3e29 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1189,7 +1189,7 @@ void object_unref(void *obj);
  */
 ObjectProperty *object_property_try_add(Object *obj, const char *name,
                                         const char *type,
-                                        QAPITypeInfo *qapi_type,
+                                        const QAPITypeInfo *qapi_type,
                                         ObjectPropertyAccessor *get,
                                         ObjectPropertyAccessor *set,
                                         ObjectPropertyRelease *release,
diff --git a/qom/object.c b/qom/object.c
index f244bff6ae..cd0590c3fd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1340,7 +1340,7 @@ void object_unref(void *objptr)
=20
 ObjectProperty *
 object_property_try_add(Object *obj, const char *name, const char *type,
-                        QAPITypeInfo *qapi_type,
+                        const QAPITypeInfo *qapi_type,
                         ObjectPropertyAccessor *get,
                         ObjectPropertyAccessor *set,
                         ObjectPropertyRelease *release,
@@ -1358,7 +1358,7 @@ object_property_try_add(Object *obj, const char *name=
, const char *type,
         for (i =3D 0; i < INT16_MAX; ++i) {
             char *full_name =3D g_strdup_printf("%s[%d]", name_no_array, i=
);
=20
-            ret =3D object_property_try_add(obj, full_name, type, NULL,
+            ret =3D object_property_try_add(obj, full_name, type, qapi_typ=
e,
                                           get, set, release, opaque, NULL);
             g_free(full_name);
             if (ret) {
@@ -1401,8 +1401,8 @@ object_property_add(Object *obj, const char *name, co=
nst char *type,
                     ObjectPropertyRelease *release,
                     void *opaque)
 {
-    return object_property_try_add(obj, name, type, NULL, get, set, releas=
e,
-                                   opaque, &error_abort);
+    return object_property_try_add(obj, name, type, qapi_type,
+                                   get, set, release, opaque, &error_abort=
);
 }
=20
 ObjectProperty *


