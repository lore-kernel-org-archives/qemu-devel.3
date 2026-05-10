Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B2CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Tb-00010r-Fx; Sun, 10 May 2026 09:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4So-0000ad-Op
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Sn-0004XD-Cr
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96aVvIKYi/+IKghTyv8FAOjWg2CZgFa5wUJKmBhpQFs=;
 b=Rt4HRUvb9JMYQtd8L7P0pObEk4lzHZhFPMR7H4GNSxrFT5pbbFUnOk78B3oQhRbUclOU5k
 QqCqXi6fBhXlUAP87sT46JvMJ8bgfLmHpCFdbFXOrLJ5r1JlOhTw7YM3dzGfY8EMIsWxvo
 BHeky9ebJVzhoEmcClvjFBNDiFiKrtc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-v3UEtQPPMpmPpNQ1nVL5SQ-1; Sun,
 10 May 2026 09:44:54 -0400
X-MC-Unique: v3UEtQPPMpmPpNQ1nVL5SQ-1
X-Mimecast-MFC-AGG-ID: v3UEtQPPMpmPpNQ1nVL5SQ_1778420693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA4861800344
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:44:53 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0D221953952; Sun, 10 May 2026 13:44:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:04 +0400
Subject: [PATCH 07/54] qom: add qapi_type field to ObjectProperty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-7-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hiZ7iR3bOaD93l4sMZ0atw37En0Wxn36sEmBAxTmkJU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItuwzEJ7SSRaN3FthKesxRu7/uRtiiCxyBak
 3LGalOzE+SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5VfbD/46o0kotYQIWtHQeVD/6hBd+K9lk09rCxovQ9XnQqV7o+cusN2mRwAQLIYiJUPRh+QcK+c
 nlTmFuKzKFRChgB1U9WyVsNsc5GjplJVEzii0CtlTzMXo2/Nvtvl/uRj0ZvCupFZiO3lt6X8gzr
 Ggmnb2u30gcfSvamyYKDslSmzKE29d+ybFT0U5pYMA2Kg7/muZi5SQBg+xs20xz4QJ9gwBu84Nt
 9IungrCNSoi7GibfpXZWIgm2kuuLBTuhSxDw2LfevYBnmPJhiP+4TFsAxIRtM/XLt5Lkt2Dx2CD
 nLMcMRe/Sdy+E2+ov2FAdQB2m50DSZjthk02i2MXfilNSQTo5Q0GrlLVFhZcsk6vYmICUH2X+dt
 RPk3Zs0YUrmJsOtOQw04Qw0tNeeTZWnRP2yQTFpHh3mo4K5pHZRaJ7Ici4HtJ2DAv8rHR7L0grZ
 IKanhQAGx1vrHPN1QLn5nB1s9eaUgiMsEYLKFjZRp9zZUA/7sYxJgY/OSfwFPqGoN1+XNttZQa7
 Zc/ZjtpCBaNrMaRpdrQrqEKqvNldu4ACZUh8y3PCBcCJyFno4hwlLuRk0nnLf5P8LWbGA1kzNuM
 AfA0IzFuwHYavNQoG4FNzOJUR9UHSu+IbwdJOlveXqWuXoyR3nWZTu0LEXgM+nQfO/HmayXJGWC
 jg93MURaAI5QqFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for legacy
properties, set by new QAPI-aware registration wrappers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 2 ++
 qom/object.c         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 510885218ba..d47ae209170 100644
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
index f981e270440..dd657903f7c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2803,6 +2803,7 @@ object_property_add_alias(Object *obj, const char *name,
                              property_release_alias,
                              prop);
     op->resolve = property_resolve_alias;
+    op->qapi_type = target_prop->qapi_type;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }

-- 
2.54.0


