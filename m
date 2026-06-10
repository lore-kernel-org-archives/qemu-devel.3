Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02BFCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIAg-0004sd-Ed; Wed, 10 Jun 2026 08:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIAe-0004em-24
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXIAc-0005BL-DJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhqhTJFLZh3M5NsQoKVQM5WgkJYYNLhVWxplZsJQlHY=;
 b=Hg0MOmPZ1ELMFJXgd/D8s91plmZqjYk117JQAkaBRXziCQLJKrXYNP9U7Q2F5FkbtdC01z
 1c2gpNrfw8DuuXUweA90lEoda1ncvV2u5mtXMjY/97nf5oH/0UqpJWYyhIHn7J2PXRuWYO
 g1gpSP2C/hUmBiwaxhYGevXUoJCYsms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-E81XfwVTOZa6OQKl_VpawA-1; Wed,
 10 Jun 2026 08:36:30 -0400
X-MC-Unique: E81XfwVTOZa6OQKl_VpawA-1
X-Mimecast-MFC-AGG-ID: E81XfwVTOZa6OQKl_VpawA_1781094989
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 570291845447; Wed, 10 Jun 2026 12:36:29 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F9F036535; Wed, 10 Jun 2026 12:36:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 32/35] qom: add trace events for user creatable
 create/delete APIs
Date: Wed, 10 Jun 2026 13:34:12 +0100
Message-ID: <20260610123415.2883603-33-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object_interfaces.c | 6 ++++++
 qom/trace-events        | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 6faa0b2fd9..2e618a7623 100644
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
@@ -37,9 +39,13 @@ bool user_creatable_prepare_delete(UserCreatable *uc, Error **errp)
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
     ERRP_GUARD();
 
+    trace_user_creatable_prepare_delete(uc, object_get_typename(OBJECT(uc)));
     if (ucc->prepare_delete) {
         ucc->prepare_delete(uc, errp);
     }
+    trace_user_creatable_prepare_delete_result(
+        uc, object_get_typename(OBJECT(uc)),
+        *errp ? error_get_pretty(*errp) : NULL);
     return !*errp;
 }
 
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


