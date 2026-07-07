Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C1FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aS-0002hV-Vp; Tue, 07 Jul 2026 07:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a9-0002Ns-Fw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a5-000860-2O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDzDpmo4+QFRTzMn4H6Lxwd+rcaH6jO5afJ5sji6jFQ=;
 b=FP0XFEWt95DswzAWKW+RKWnvJlfyrAEVCjzZeN6lCBU7lXCtPU5KsfEq1kO1UMHIxfkctM
 3GH+TQTgLmkln/t49gcNz/tC+556/sKwhHhATjsvoCvOuGgCdWuJM+PHLJwaKi3zet9iDV
 v5jPReY4xqx2drygN8B76o9zrX1pNKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-sCpheyfgOc2ym5vc48mvag-1; Tue,
 07 Jul 2026 07:03:10 -0400
X-MC-Unique: sCpheyfgOc2ym5vc48mvag-1
X-Mimecast-MFC-AGG-ID: sCpheyfgOc2ym5vc48mvag_1783422190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3A4D1954B3F
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6A8E180074C
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F04721E64B2; Tue, 07 Jul 2026 13:03:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 31/35] qom: add trace events for user creatable create/delete
 APIs
Date: Tue,  7 Jul 2026 13:02:56 +0200
Message-ID: <20260707110300.1918153-32-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-32-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object_interfaces.c | 11 +++++++++--
 qom/trace-events        |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 3216a754ed..d83c12744b 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -20,12 +20,14 @@
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/keyval.h"
+#include "trace.h"
 
 bool user_creatable_complete(UserCreatable *uc, Error **errp)
 {
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
     ERRP_GUARD();
 
+    trace_user_creatable_complete(uc, object_get_typename(OBJECT(uc)));
     if (ucc->complete) {
         ucc->complete(uc, errp);
     }
@@ -35,11 +37,16 @@ bool user_creatable_complete(UserCreatable *uc, Error **errp)
 bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp)
 {
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
+    bool ret = true;
 
+    trace_user_creatable_prepare_delete(uc, object_get_typename(OBJECT(uc)));
     if (ucc->prepare_delete) {
-        return ucc->prepare_delete(uc, errp);
+        ret = ucc->prepare_delete(uc, errp);
     }
-    return true;
+    trace_user_creatable_prepare_delete_result(
+        uc, object_get_typename(OBJECT(uc)),
+        *errp ? error_get_pretty(*errp) : NULL);
+    return ret;
 }
 
 void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
diff --git a/qom/trace-events b/qom/trace-events
index 44c63e72af..bac8472618 100644
--- a/qom/trace-events
+++ b/qom/trace-events
@@ -11,3 +11,8 @@ object_property_del_child(void *obj, const char *type, void *child, const char *
 object_property_parse(void *obj, const char *type, const char *name, const char *value) "obj=%p type=%s prop=%s value=%s"
 object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "type=%s->%s (%s:%d:%s)"
 object_class_property_add(const char *type, const char *name, void *value) "type=%s name=%s value=%p"
+
+# object_interfaces.c
+user_creatable_complete(void *obj, const char *type) "obj=%p type=%s"
+user_creatable_prepare_delete(void *obj, const char *type) "obj=%p type=%s"
+user_creatable_prepare_delete_result(void *obj, const char *type, const char *msg) "obj=%p type=%s msg=%s"
-- 
2.54.0


