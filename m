Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E40CD98E7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4g-00034q-Rh; Mon, 15 Jun 2026 16:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4f-00034G-CR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4e-0002Gi-04
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyOQAUddVNtmDatH7lxL3sxCN4XPHqwBQyPQsmq5+cM=;
 b=PNGgG8xS5pHrdEBCyvIxolbeYT3y32Hm5wM97wB4xMJs+MXh5R93By564eUcETylKpi9Kw
 Eeynthzj3xRhtKsvQ4AOlJ2/6BjdQ9nU5c2TIvGHy1mfAjVG+9jVVZTWRqlruKG4ezAxLB
 N0rQhhouKku3zN3wKGo9YcmQCzddbGo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-XS1RV2gtMT2nR0UpR1kOEQ-1; Mon,
 15 Jun 2026 16:38:22 -0400
X-MC-Unique: XS1RV2gtMT2nR0UpR1kOEQ-1
X-Mimecast-MFC-AGG-ID: XS1RV2gtMT2nR0UpR1kOEQ_1781555901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06A9A1956065; Mon, 15 Jun 2026 20:38:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBEE6195419D; Mon, 15 Jun 2026 20:38:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:33 +0400
Subject: [PATCH v2 07/53] qom: add qapi_type field to ObjectProperty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-7-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DdWuVZOt3ryTUGsa9/KXofVoIx7nhAY+BCfyooCOOxg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOTZlLU5gcthweMlXCoDt04ljsnXdob8/8O
 dPDaxd76k+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5STAD/9y4/sRXAMVtH3HvKLgE6P9Pc/h250bU4pJOH81bLU1fS2jXwqDt1bxvKXuwQt5yVg5gNB
 W+pQiv9JT00wsH/CEf0g1L56YWUuCUJ50FaOqIGWMy14o8X8HwU2lwrLHN7WOQYUYwFWOqHsThO
 72wHpAdywey0U8pv9jaeDG5DJCzaeu81emCwx40tomRsNRqRWmBPE7B6Y8D7RjQWVBW9HfwW6ro
 aI0/f920t0YzUSg+rDhhUo6OICvA3gtYg5a46ha/z/wAMQnLIu4xCXA7YfNMDdUpyLwXNkM1pd5
 3khV0vxjY1kDsVMY9M8k+PFNV5d9JE/lyZF9O/zRZCAf42DiQMAYIR92mz/DHnsRkEsiQiYFYOD
 RGimGDWwld983b3antE/mCQ4lcQTan0xsNX0zpU37bTPZuRwcYfcmzt1VpabDcZVESyJAhzEmit
 HthXUrTAfBDOR6JZCWysVgu0aK2PCFjxsyw6RodTttkFk/jeoM9ihnxsd/UCwsfXphdjWQAHx55
 Ru0t6lMfewwDN7bbnx70auaUAjQ4uBde3ZuHqmyFUo1jbqnoZsGpJf7k5GYO6YX3XEx7PHnNs/3
 lVVfbgbK4TPE2P/MKG/DynZmsLfIsJHpd2lsGcnATB9PWF4icQ8tR5mkRi9ia5wL7+0mdmYzRPH
 e1gleXtNf0nbyHA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for legacy
properties, set by new QAPI-aware registration wrappers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 2 ++
 qom/object.c         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fcd..d96a9afe21d 100644
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
index 0ac201de4c1..a085e78557f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2983,6 +2983,7 @@ object_property_add_alias(Object *obj, const char *name,
                              property_release_alias,
                              prop);
     op->resolve = property_resolve_alias;
+    op->qapi_type = target_prop->qapi_type;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }

-- 
2.54.0


