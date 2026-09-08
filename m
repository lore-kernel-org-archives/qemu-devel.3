Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74D0C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQV-0004rW-TQ; Tue, 08 Sep 2026 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQU-0004gU-AT
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQS-0007kT-P7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FKJYpNYvviIppUZpOKE9q1bfyaAWCl3mbITunIWloE=;
 b=epwMsVFBTgSQtDJp1tL1b82KOgwemOD013HfYD3vOaGvMFSXnOZWm3mKg+o8zp0zJGuHOU
 fbR9YrEUZQN/eq6x4Vzs+/f5pVX7SP6dmL3z8+7rYBiSls9zERn4Pi5vCM+UhUj9qUSmsx
 7kCb1LDDfIAFH8a1IxPB1oUN+WND35g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-1GeQz-JuM16o40TnFgjVww-1; Tue,
 08 Sep 2026 11:07:54 -0400
X-MC-Unique: 1GeQz-JuM16o40TnFgjVww-1
X-Mimecast-MFC-AGG-ID: 1GeQz-JuM16o40TnFgjVww_1788880073
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16BC51955EBA; Tue,  8 Sep 2026 15:07:53 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 189A51800641; Tue,  8 Sep 2026 15:07:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:58 +0400
Subject: [GIT PULL 15/15] memory: use object_property_add_link for
 container property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-15-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2riisB+zgx9gGdxSYmXi6ORcVCC97uBJTTxDzGoItCo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPv+HSczCviFKo2HvnMBmvJ5DkDSXw+7H4Z
 f3A7JRFzT+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5bXAD/0c/EwJrMElc4snQpvibm6XBrOdbaQP/AF6Diqg0Xl1tIVvP/9Ouhb3FfMmXMkGezPjFe2
 KYRcFzPrVeaDpDwkLTd2Wi/f4OgqMVdUNUfke3wbob0eGSX0xKy9V7pxHUQ8XXtKa86zHnW08Lv
 peZfqMz3odAq+Rq07VP6S1oGHXqsRN3kYfs2Od0fBpufiGoHNGHf5cc7m52p6hBmgNGjQOt5af8
 fuUWuBEzniOeM8XE+dFhPIyIVDRByhVsG7mdhG25orOJmxvX99H5IEQg682XW36uiauEmGQLL0V
 /I+4rj+BS0JzaEZ8k66FWXBeuxMpQ2FoyrU8mi9/ayO6ALyx3Y/KK8CleHWt208/JFg4JXFt4Eh
 UUNGQvyQ139MV3V7mJjzNC0K2xy7iXvTMFYe4dTgK/6jwrHD51OnkCocVuc8UM3V4Pux0VE0LKh
 MKLnNH87LIMTSD6iwakOI5KrvrdK+qhwQAw9m9sMbcBeW8Yss6BOemfKmA3cB2UQqzEvzj8uaJA
 w/uQE0+CJDvlUPyfAQ57fKgGyzLfYazoiVrvNTCn9O9QppvhsWbhCMB4XmWIFG5aM1HKOnuZv4a
 85WqkyJr+mx4+zoaJTKmWFUEfcj5VI54XlbrSVDuFjFUhU/baZm9w1ktoGOW6MfqzCMbegNUyc0
 kfLWoaFNXifRmcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index d4a0a5b81805..264dc90c0a55 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1254,29 +1254,6 @@ void memory_region_init(MemoryRegion *mr,
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
@@ -1300,7 +1277,6 @@ static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
 static void memory_region_initfn(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
-    ObjectProperty *op;
 
     mr->ops = &unassigned_mem_ops;
     mr->enabled = true;
@@ -1309,12 +1285,11 @@ static void memory_region_initfn(Object *obj)
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


