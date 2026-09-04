Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402EEC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a84-00077e-3Q; Fri, 04 Sep 2026 16:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7X-00069k-3z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7V-0000Ds-Bu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16zsikAccAekmkNlHDOk/n8q3ix6f+yp74/a3MGeqiE=;
 b=GV8ENhQpG239a5zaRS35XmKq82+QBUp0O4u7AtcF1UhG+7DIbp/WEPQdwK46FZGZDKKgb3
 72H85vDu5NY9AbzvD6oR33i+xSL1w+8G6h8YPk9i5ISnIJod0240Pv/s+3zSvEhPvNLPz9
 rofqZsVnXjT2Yzv/0VhUwiZiz54u3Og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-a6KiYyppOs6AeW8x4hzkIQ-1; Fri,
 04 Sep 2026 16:02:36 -0400
X-MC-Unique: a6KiYyppOs6AeW8x4hzkIQ-1
X-Mimecast-MFC-AGG-ID: a6KiYyppOs6AeW8x4hzkIQ_1788552155
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75A591944DE9; Fri,  4 Sep 2026 20:02:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7F5130002F4; Fri,  4 Sep 2026 20:02:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:54 +0400
Subject: [PATCH v4 71/75] memory: use object_property_add_link for
 container property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-71-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Xu <peterx@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IsjJZSOq/U/MfHB1PwGbnjBDBup7eSiE3ULiQgoviDk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLMFEsbbQxjZJ92nLApZY6RfL3hSirNmVxra
 Y485gaOo66JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsizAAKCRDa6OEJdZac
 5bjLEACqAnGNDVR9U4A6Xzznxjon1JfDXR9Lsu2XjnQPbtxTo2lNaYEeVzmvSjqTDL1svrNu6rb
 rN8+PNJg5OmCiAKr/rRq/FE4nStPj58RKmgtu8A5z6x5/8u+8MAemdgK4csufUfHekWbw3IlvcD
 DFfgMF2Jv7Gd69vplKZVir+2PfQHtYfasRIf2/jQT5sWFIRMXHoMMuxBdJNLx/P+x5qZA3WU00w
 J1AyxcxMlWBG6qZdjCdmkReK4CwNP5dCNJgKoMgDeO+rH9J8LjUXsamRS7WtrhDLHfConj44q2M
 6nort0FDAvMg4Hkk89S/jEp0tvA5AL+rtJpuEYzWJUK5jwqAddLt4ZMFIJWFgGGN+SIRHh8soY7
 U52x1qZa7mJ4trAL7s1abKbo65UDl9+6Qn7pFlmi5gha4R3xC+aN4kHWVCxRwKymqlP9ts71uAX
 9+lTarap73o5ex4DBINtBnLDGNdlevEX0gYYN0Ej/TSROmVdtTQkH6HB00f0nmv0F7ApDNAoz48
 U9pIEcmUH+xbcUQNeLPXIX6mR8bCveTioGLt5ETJzqXZEPAzS/IG/qwkAbMFk0B0pwtHVa8PAQt
 aPy2Wvz/A8cuycUNdVX9JwpArIM4Gds3SbefEAFWT4eX1KmnOknnHiLZnGRrH26J4F3JcqiBNTx
 cwMeaPA7MKULC+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index ae768cba80bd..72ecb3115496 100644
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


