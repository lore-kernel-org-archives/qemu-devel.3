Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DFC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwK0E-0000LG-7L; Tue, 18 Aug 2026 09:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwK0A-0008Bk-OZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwK09-0000mq-7h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787060232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NV4vU7xJ/sfqVFDKGMhjLy89zJHemxz+WxI8Cc9ZjaA=;
 b=H0yRnKs5vFJhWonqM8EApRaQzXB2wsIkYYvZJWW7+i4llwry8OYTDIdlFeaUtePe6L1MFo
 tQg83s024tTydu05+eeXDCSoQx8b4N/97zKf5NSnjfDjoAPlM8C+cjXwZ6W3+k1qmp6VVN
 a3KUTtgFWIIXtigpEmtKQiKuiBnIWPg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-eCwZ9M4tN02xeULFm4dFaw-1; Tue,
 18 Aug 2026 09:37:04 -0400
X-MC-Unique: eCwZ9M4tN02xeULFm4dFaw-1
X-Mimecast-MFC-AGG-ID: eCwZ9M4tN02xeULFm4dFaw_1787060223
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 280FC1955E7D; Tue, 18 Aug 2026 13:37:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F76E195608A; Tue, 18 Aug 2026 13:36:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 17:29:36 +0400
Subject: [PATCH v3 70/74] memory: use object_property_add_link for
 container property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-70-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t5V93ky8AHjt2AWFGdnZjqVczHh1F8gtqhIECiuT7J4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhF90jZgdg76F7sUgxpqWCrRmOfZma00eaLUVt
 dEM2zaDRguJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRfdAAKCRDa6OEJdZac
 5bycD/9Sip+2W/rMqUsTwURzYGOdPkjORi+Xy2KYC9c6QCWj4Z8lRYQuWFtDmQ8giicfUOjchfc
 H2RUbZ3hvDcmWcy6XMkGgjKSGdP/xiMsH1zQthinHqAd+blFkn0NUnFZl4V+ecZmORblfuNzdTJ
 XyCBMCQAlXmeR5m6htAtt/tJ5br5fTSk8tFcM86D1mnCB9N+JPpq/94L1/B02ToGIOLxCeVBh5I
 calzBjH0tfQu01+XVbqqxo3C15tLo1NrxCn3san9Bigj7Sg4k4U3GLsRfekQGh+7vvz4mA+lnKP
 KxqzhXoqAZKOAm9byz9iL/0urrleS45GdR25p85gwYjGs8s7qhZ8y+TtmQ1CPpeU25IPaBsLikB
 2C3OZZ5mKCBH+ogSqU+mYDZZQgWmgZwij9qGDghND+guHbo2KCsib/u8GkWe6nfsRDjG+svhbMx
 zGlILAadeTyGN0ru9vddCIc2bpBbV6czcSePk+Gfbmsf4HnZ5nPW2q0QrqE6aszAAnLxvh6KSNO
 T0rCSBA0seM1VnUV6Y57B7EkeCmpBd0nAQl77ug8dRvTUheW08XrPkRigqMt2k9pxnvlKhA23hZ
 ZboNB7luql3xYas1qV2rL668jLxd6eqQISDMjMAX7wpABYkcKJAmzJh8BUB6AuzY0JkOtHZZya9
 dl0CQBEIZpd/LFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace the hand-rolled container property with
object_property_add_link().

With check=NULL the link has no setter (read-only), matching the
existing behaviour. The built-in link getter and resolver are
functionally identical to the removed memory_region_get_container() and
memory_region_resolve_container(). The non-STRONG flag avoids refcount
interference: mr->container is managed externally by
memory_region_add/del_subregion().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 46a0dbaf6859..37660993e847 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1255,29 +1255,6 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
 
-static void memory_region_get_container(Object *obj, Visitor *v,
-                                        const char *name, void *opaque,
-                                        Error **errp)
-{
-    MemoryRegion *mr = MEMORY_REGION(obj);
-    char *path = (char *)"";
-
-    if (mr->container) {
-        path = object_get_canonical_path(OBJECT(mr->container));
-    }
-    visit_type_str(v, name, &path, errp);
-    if (mr->container) {
-        g_free(path);
-    }
-}
-
-static Object *memory_region_resolve_container(Object *obj, void *opaque,
-                                               const char *part)
-{
-    MemoryRegion *mr = MEMORY_REGION(obj);
-
-    return OBJECT(mr->container);
-}
 
 static void memory_region_get_priority(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
@@ -1301,7 +1278,6 @@ static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
 static void memory_region_initfn(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
-    ObjectProperty *op;
 
     mr->ops = &unassigned_mem_ops;
     mr->enabled = true;
@@ -1310,12 +1286,11 @@ static void memory_region_initfn(Object *obj)
     QTAILQ_INIT(&mr->subregions);
     QTAILQ_INIT(&mr->coalesced);
 
-    op = object_property_add(OBJECT(mr), "container",
-                             "link<" TYPE_MEMORY_REGION ">",
-                             memory_region_get_container,
-                             NULL, /* memory_region_set_container */
-                             NULL, NULL);
-    op->resolve = memory_region_resolve_container;
+    object_property_add_link(obj, "container",
+                             TYPE_MEMORY_REGION,
+                             (Object **)&mr->container,
+                             NULL, /* read-only: no check means no setter */
+                             0);
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);

-- 
2.55.0.543.g5ebe2ebe4ea8


