Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A3CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE8X-0001gc-N4; Mon, 15 Jun 2026 16:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8W-0001by-Mc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8V-0003Hk-7o
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCpYzzFfRLn/bDIA8NVh6qt0sPVB4g9t4vEWZhRt5xs=;
 b=UlVXHFblsTrp5Lo9xgMMpOL6an1QjQXPQvyeYZQpZkAg3FSJbAb5NrYG9ROSm7UxngNx+S
 hB2kWs2HQNRhawcse7j2S1onu35UZhQb4/TcWbO3Q8X+lAvlSvnxPc4Qq9GfWkmHyHEh1S
 pELGwCnQqNpaWNtDUWBROKKkdC2XoaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-b5CzKcXxMuOo_J7i1eLDIw-1; Mon,
 15 Jun 2026 16:42:19 -0400
X-MC-Unique: b5CzKcXxMuOo_J7i1eLDIw-1
X-Mimecast-MFC-AGG-ID: b5CzKcXxMuOo_J7i1eLDIw_1781556138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B9741955F56; Mon, 15 Jun 2026 20:42:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20E523008B37; Mon, 15 Jun 2026 20:42:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:18 +0400
Subject: [PATCH v2 52/53] memory: use object_property_add_link for
 container property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-52-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4Zmyoj53ITDcDim3Jbb45V8LSIPOURlFf4iisCH4NYs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQBy8BYODs8Rx1ENCdlFhuN0/ewajWU0+F6
 bk+dpqUTziJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5d59EAC6+SG1dWMcP5TrO2Fh4dOKikFWtvCCVIrx4Sd6Ae/vrXK81r8lzKAIEk5pB0Rz41ov/VT
 uhTbsNtkRqlVipmzwC860KuaJHi3cQoX+sHS2efFK7x1wP1GUjJ9TOA1CGehTcLBWGr6ANUPkXM
 lfUgaj0vChImow9f+mtEBQSkQ8mGBf6CepO1rzBBR8PM5RRP0F0WdfL7iVgu2ao+yJ6/3NeRJ6P
 /EEOou2Hj35gBuPxSdAXewO9cwiCvgogEsmXbCRZWX+HcybMGRONXQkkLYDswhy+t+/z8Jhakxf
 5j9bmptR0qnr1Fa3rfp4I+3ZJVG34KkwcMvPBaEejUm+aHHgc6wDNLapMeZxtX2PxYQgpVVUkpB
 grvJnnOI1IJ3Jjs5OF2ezlj3k9qFI9pYSOO3L7t4iwi3zwHVpOw1cmR+3/PBfnaiIl1n9RQLQYa
 u3B1f1jEShVShJrhhEGUDKXI1J51RUKcegD4nrhHX5V1rXbJ8jYJlS6q/MK9DU2nbM+23AVB2dm
 sdwlYS5yIORAhixAldT/nhqL7mRgcfp3Vf5bSJ75WxkLqPb41iGjUvWRzyTAi6b+BvDKP+gTIRy
 Nt0hAEws/ahJlMd7kdO4sipyAq8WY16czdi0yNSZvOIjYTGysGjmGmFVFSt+i+fVvWX3IcLUtVG
 yFlJiglikAnvO6w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


