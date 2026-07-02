Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474D1C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJvd-0002wT-Ph; Thu, 02 Jul 2026 12:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJvN-0002PU-Ha
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJvL-0007EZ-GZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQj0JCB1akQrhv51W+qXyDVmG62q0GmK2q14wInELIQ=;
 b=OUYaNJJyhujvZpqrLdZJFhAj8xJoBXelOgdCRyTStHCEH4C3ZwENXafBF/uzjJYy8tEe4U
 hVMoXIcIURVcqhAUiCQfAj3cLEaEQUIBtv9Yas+ixN01whI4O5lalbE7GafuWPmjK4YSSk
 d0eYdNIfUnmddgrFPWOnCgInAeEhb2U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-t3aJDJzrNQuzqeQupG43Fg-1; Thu,
 02 Jul 2026 12:05:53 -0400
X-MC-Unique: t3aJDJzrNQuzqeQupG43Fg-1
X-Mimecast-MFC-AGG-ID: t3aJDJzrNQuzqeQupG43Fg_1783008351
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A60C119792DB; Thu,  2 Jul 2026 16:05:51 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC00A194510E; Thu,  2 Jul 2026 16:05:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v6 30/34] qom: add trace events for user creatable
 create/delete APIs
Date: Thu,  2 Jul 2026 17:03:33 +0100
Message-ID: <20260702160337.1910921-31-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object_interfaces.c | 11 +++++++++--
 qom/trace-events        |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ac992aa786..69bdb1807f 100644
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
@@ -36,11 +38,16 @@ bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp)
 {
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
     ERRP_GUARD();
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


