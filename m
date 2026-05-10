Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0825CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4ay-0001UI-U3; Sun, 10 May 2026 09:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4aw-0001Am-VV
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4av-0006RL-7Y
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAiIwDFNhKTjy1wUXIZY/njao/HKRmnjb6K05LMnizs=;
 b=K4q/OIq3n/Mvfh+hOWOnplecfP9kWpsCK0n4xRzUPFEbxbA7EgHTLy1rgEBmsVLS30II0I
 mH3RNzSRP6tETxjFdn4/WKqZ81D+F7EFHfaNzPNNUKeAAyYiOw5SiEOo9I7dkxBiSaxmcn
 Ppr3IkzhPlJjlbkIf66lwLKti/KriR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-84u0wfT0NgyfpHG6KRN7hw-1; Sun,
 10 May 2026 09:53:18 -0400
X-MC-Unique: 84u0wfT0NgyfpHG6KRN7hw-1
X-Mimecast-MFC-AGG-ID: 84u0wfT0NgyfpHG6KRN7hw_1778421197
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4725F19560A7
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:53:17 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 155BF19560A7; Sun, 10 May 2026 13:53:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:50 +0400
Subject: [PATCH 53/54] qom: drop free-form property typename registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-53-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=j8k4RT5G1PHBwcE2vQ0BwXA7M2uZzRADNZTy4/j7E0A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItx6XY/BNLSJFCV4ejk0PiIcfJk0oJLP/7ZF
 1MVxXV8B2WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcQAKCRDa6OEJdZac
 5WyDD/44Iv2SNZeXh5+k3op9tcAU5Hcx6QhH2nNy5vxN0GwmIsWvDpSi2OtakhXz3X8NCp0N5Cc
 51ZQ7veo/ekrdAs5+oiCwjhyMS5W8W+CyaaENkfhi3+KYMZUE6q1nwBi4jyW4RMjAgrXrJ6qGdU
 mIlNVVlRK3lBNNa3UbkowdSLRuTZoK/vhZJGcIB/TcP64xBDHHSVUslgv94OKO3Azg4vWxDIFk4
 8vU7xwY06UtOJfsjqePrWbbyPKicNeIFYNGhZltQ7fTzL/5idBUjH+Xq5jdtWVrotafGD/sgZNM
 HWWgzSHV0wgE6l8yRLybB+klf36Mp/XGNrG694daOB1yTp17uFz6DWrbqdMQOVcvkOXZVV9oXvl
 zpi/BWNCvNMTdyL/EPBzv7zTouAz8Owjmhcp/omj7nbPPNbcfU2wGOvqHllHHNT8w6RzXcVKJaX
 mob7C+b+1APwcZtU7TZ0njpJxjmWVr1HMd4Senj+DDN10WKYf6YMBDphin7D9VM8c/zfLz13gmO
 RgePzPIbPmT+qVrj4H9CDGOlWIVwCQ8AI3PcGhPybsrh8+z4Sosgs4ockeArRi15F2PYiF8Qcwd
 nPia5N2zS0pBC8PJ4b9+26/H3Ubqb5i6rH/0RIg3fk+As1nOtZGKc4FFov/6yqLBfkllmMFDgdh
 mk2bfpvNnBwKeFA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All properties must now use builtin registration helpers
or QAPI-based properties.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 36 ------------------------------------
 qom/object.c         |  4 ++--
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index d0134a94281..ba2df54258b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1084,44 +1084,8 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
                                         ObjectPropertyRelease *release,
                                         void *opaque, Error **errp);
 
-/**
- * object_property_add:
- * Same as object_property_try_add() with @errp hardcoded to
- * &error_abort.
- *
- * @obj: the object to add a property to
- * @name: the name of the property.  This can contain any character except for
- *  a forward slash.  In general, you should use hyphens '-' instead of
- *  underscores '_' when naming properties.
- * @type: the type name of the property.  This namespace is pretty loosely
- *   defined.  Sub namespaces are constructed by using a prefix and then
- *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
- *   'link' namespace would be 'link<virtio-net-pci>'.
- * @get: The getter to be called to read a property.  If this is NULL, then
- *   the property cannot be read.
- * @set: the setter to be called to write a property.  If this is NULL,
- *   then the property cannot be written.
- * @release: called when the property is removed from the object.  This is
- *   meant to allow a property to free its opaque upon object
- *   destruction.  This may be NULL.
- * @opaque: an opaque pointer to pass to the callbacks for the property
- */
-ObjectProperty *object_property_add(Object *obj, const char *name,
-                                    const char *type,
-                                    ObjectPropertyAccessor *get,
-                                    ObjectPropertyAccessor *set,
-                                    ObjectPropertyRelease *release,
-                                    void *opaque);
-
 void object_property_del(Object *obj, const char *name);
 
-ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
-                                          const char *type,
-                                          ObjectPropertyAccessor *get,
-                                          ObjectPropertyAccessor *set,
-                                          ObjectPropertyRelease *release,
-                                          void *opaque);
-
 /**
  * object_property_set_default_bool:
  * @prop: the property to set
diff --git a/qom/object.c b/qom/object.c
index 1e6c3a9f91d..c378d20c4db 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1225,7 +1225,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
     return prop;
 }
 
-ObjectProperty *
+static ObjectProperty *
 object_property_add(Object *obj, const char *name, const char *type,
                     ObjectPropertyAccessor *get,
                     ObjectPropertyAccessor *set,
@@ -1236,7 +1236,7 @@ object_property_add(Object *obj, const char *name, const char *type,
                                    opaque, &error_abort);
 }
 
-ObjectProperty *
+static ObjectProperty *
 object_class_property_add(ObjectClass *klass,
                           const char *name,
                           const char *type,

-- 
2.54.0


