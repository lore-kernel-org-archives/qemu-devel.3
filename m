Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC276C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54GJ-0005YL-Ik; Fri, 11 Sep 2026 12:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54GC-0005Ed-0e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G4-00061x-KP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wA5ZYh8MpPrdHBifS5Sy8EfpUvGUk61xfShZ6xpVkIk=;
 b=WP6VKgwFOxR8GyBYtLL0+Ks1iA39UUnkb8KNqBTShJcC180uAQ9m270lasQsdO5TIMRXAc
 x3I6UIOCywH1F6e/iAT+dF/eMs0AbsUh882FVaJClmpFfL5nX6GW8UdahK66T/cOtaMJKV
 mCZFB0U378J85J7w0Yq+W5d6PMX/wkI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-y0Yyrv1gOFecPOwqkR-pUA-1; Fri,
 11 Sep 2026 12:37:26 -0400
X-MC-Unique: y0Yyrv1gOFecPOwqkR-pUA-1
X-Mimecast-MFC-AGG-ID: y0Yyrv1gOFecPOwqkR-pUA_1789144644
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3F5D1801372; Fri, 11 Sep 2026 16:37:24 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE9751956042; Fri, 11 Sep 2026 16:37:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:41 +0400
Subject: [PATCH v5 07/62] qom: add qapi_type field to ObjectProperty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-7-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rBD21kRNCndFYKRVvLYoL4BXy2V04K02YlZGAo0wzbo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC229InmEFQ3M9fjUJJEOmY2qyk+DaobYfC+W
 nalf5qwf82JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttgAKCRDa6OEJdZac
 5f+eD/0YPTVPpBCeYQ+mTESOG+a81qEUPD7jNJ6WHsoNsbQW6sun5F/7ydJDZ3oMRKxo/wqdLCY
 B5XQ2YzpcbtEezHTB8PJMhirjCUTbsar7xy1McC3kUbbsk8V56c83q6WlJNfhsmqlrtWciU1Kcd
 YqyvbYk4KeKPiBdeu/MqjbwPcLs3czQvKBdfj6XC4B7r33MvQsFdyCW6XDFx5viO3q5WvLiGMJ+
 XcNvPIAWxWc3+bF1WUGznHxBALD8VVn35vmW1Mj8+teNsQGRPz74gVGVXHRRXGqVz0uLg9r1OIg
 tc4Oi26TiAuP91pK14gGIVgFekoKSQ7PIpY2t+BHqYWhNLEcRXR4nq48/gmWPvbZwHm7O8KDXHf
 XXeWKCIpJ0F4olxu1udFmNm+eVQ2czmj3BNo7C+0y+EzTznurKmxfY2hfni2hsDKzOTM3UmeMVp
 f3MHFn7Be4GqUm8wEKwGGYDVnCs0+X1Kkq4wLhzLTtOu1lX1YKxRKN7msAWbwNPT3oYIuBvGDd7
 0Q88GadU83p1oddi4pBVl2jP3qtpW5qFC/SIoF53CTPbSh++uewaaZAt8x+qOxJ9JnbFfeWMGnb
 dZapLJzPMZiWPMcW0Dwh2vYEeNPt4mPCweg/8VeuSnw/GgbNcxSmNQSiD5a2iMUhR+v7KZ+A5/p
 trGEzICYiJpYUJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for now,
but future patches will add means to make it non-null. The
QAPITypeInfo will then be used by QOM introspection to tie the
property to a QAPI type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 2 ++
 qom/object.c         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7ecd0f210fb6..7c7e69a2a1bb 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -15,6 +15,7 @@
 #define QEMU_OBJECT_H
 
 #include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-type-info.h"
 #include "qemu/module.h"
 
 struct TypeImpl;
@@ -91,6 +92,7 @@ struct ObjectProperty
     char *name;
     char *type;
     char *description;
+    const QAPITypeInfo *qapi_type;
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyResolve *resolve;
diff --git a/qom/object.c b/qom/object.c
index b1834a57cc9b..f782e21f1a30 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3112,6 +3112,7 @@ object_property_add_alias(Object *obj, const char *name,
                              property_release_alias,
                              prop);
     op->resolve = property_resolve_alias;
+    op->qapi_type = target_prop->qapi_type;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


