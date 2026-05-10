Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C72CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4ar-0000AI-3p; Sun, 10 May 2026 09:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4ap-0008Oj-PX
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4ao-0006Ql-2O
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0vfuOhVza4nNb0TtZR3j3xGIuJ5GsdWW+k0W3gKgWU=;
 b=fOfhk4cYcl/yJ9A8WvCjP3nGn3Vy9E1no83TnJJ33dG2eDjsB4/3c6jcoQq/S0/fdkywZv
 FPi1aY1tovV0Sfn+7LODjrdsjjcxGEV6ObMnKnO8CWRFNt0gX9cYIuPaM84CiEuA2wzksi
 FejCUC0zZKBe1eE6PI9ARpuXENEcrM4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-2MURqV4FNcC7g9WfSL7Xfg-1; Sun,
 10 May 2026 09:53:12 -0400
X-MC-Unique: 2MURqV4FNcC7g9WfSL7Xfg-1
X-Mimecast-MFC-AGG-ID: 2MURqV4FNcC7g9WfSL7Xfg_1778421191
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32F5E1956096
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:53:11 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B84F1955D84; Sun, 10 May 2026 13:53:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:49 +0400
Subject: [PATCH 52/54] memory: use object_property_add_link for container
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-52-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HXMxxNqr+o3gGHkiksXT8rf4U6WekZ1b2dqHkPAQWHo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItxrF4xIHO1asoNvM6jUM1uuuWiJ4K45OJJF
 AKoxQN8J1WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcQAKCRDa6OEJdZac
 5UcTD/9CpMLA0XYpph+sr+TVHnzrf6VpaNziuvu0jx7wTgALpIUe82pesje6bY7aFgbdulpUpln
 jI/rjIVmqHPLRr9t/8zq1c1mvbJJ3dqOpcdU94O46u9HVDp8XR7w+tyVYXzZhk6/jIfYG8ToyCf
 VN85KFvrmLYmGDydniVV/wHHeNmtgRYZ8JHMitpgc2pnWQHJLOskQ4a2ZTeIh5Vo+FpKXPNb5Ba
 n5r1j0N5cvJFgiLhPfTJIaFcaZO40YFS3SB/axyJZ7ZwqAexcovg3WCjOwP/88qApDbofLV6Jki
 iNiqMoUisYIeTfpJx9k2L+eKG+vg01wGfu+DUtBfOs99h4SrakIrPPhIkT4hmkjTSdXtqrCPxqh
 c1GZamiWrHuAlCm8HcvWeG4n6hgquVnKF8CcjmUn801PbIKwubyT2k7w/104W3H1tYmKuPoB4xg
 ACvcN0oeijI1scgx0Ht/1rdL/cXa3DATiEvtXTUjsadr0HRYaJJkGMs9gIkvSWsm1mJ8xHjinxU
 2G8SVJf7Mg+Y6VZ1OShA9JCMc6sMOuRteERnOUqaJAkDfdp+LLlGwOd+1q96Yo/x25W1J3Ov6ko
 4v9BkPZNUf90cDYRBE+igNbpgDGxUOfoayH+MP10PoWkypTCjNHGKlrGdfNMb0PooW8JX/jyA8/
 48NusUQ9yTgyBSQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the hand-rolled container property with
object_property_add_link().

With check=NULL the link has no setter (read-only), matching the
existing behaviour. The built-in link getter and resolver are
functionally identical to the removed memory_region_get_container()
and memory_region_resolve_container(). The non-STRONG flag avoids
refcount interference — mr->container is managed externally by
memory_region_add/del_subregion().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 1f2d44ce8b4..d06b14d8338 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1253,29 +1253,6 @@ void memory_region_init(MemoryRegion *mr,
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
@@ -1299,7 +1276,6 @@ static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
 static void memory_region_initfn(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
-    ObjectProperty *op;
 
     mr->ops = &unassigned_mem_ops;
     mr->enabled = true;
@@ -1308,12 +1284,11 @@ static void memory_region_initfn(Object *obj)
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
2.54.0


