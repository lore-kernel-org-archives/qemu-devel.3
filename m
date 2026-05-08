Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB4DCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLJKA-0000eH-Ow; Fri, 08 May 2026 07:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLJK9-0000dh-6O
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLJK7-0004qd-Mk
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778239491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gv7XNbd9kQXgqSxoNVB7sOMaqzg5QhpPsPiIElEcqmw=;
 b=ZlrD/ye6TrywjoDPCV4ErzYvoWjL6tujxIwFbt8HHZcslwLwR/TDa/CgmyAHS1+IjtVQQq
 yte1kGjl7YnXaEYk6DJdLoO59rYb5mSch98gIuquj0Wjf08n4X7USi77PQp5AyrKtDlXJ0
 bAA54Z4i4BIffkaWVKun0t9/xnMsPDg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-kxkOc_jEO4Gmi1U-QciARA-1; Fri,
 08 May 2026 07:24:47 -0400
X-MC-Unique: kxkOc_jEO4Gmi1U-QciARA-1
X-Mimecast-MFC-AGG-ID: kxkOc_jEO4Gmi1U-QciARA_1778239486
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEE5A195608E; Fri,  8 May 2026 11:24:46 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA237180034E; Fri,  8 May 2026 11:24:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 05/10] qom: have object_set_props_keyval return bool
Date: Fri,  8 May 2026 12:24:24 +0100
Message-ID: <20260508112429.643360-6-berrange@redhat.com>
In-Reply-To: <20260508112429.643360-1-berrange@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

This matches the convention established by the object_set_props and
object_set_propv methods.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h    |  4 +++-
 qom/object_interfaces.c | 13 +++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index d841c338a2..20a04cc4a9 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -924,8 +924,10 @@ bool type_print_class_properties(const char *type);
  *
  * For each key in the dictionary, parse the value string if needed,
  * then set the corresponding property in @obj.
+ *
+ * Returns: %true on success, %false on error.
  */
-void object_set_props_from_keyval(Object *obj, const QDict *qdict,
+bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
                                   bool from_json, Error **errp);
 
 /**
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 4377d65b76..50736b80c8 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -44,13 +44,14 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
     }
 }
 
-static void object_set_props_from_qdict(Object *obj, const QDict *qdict,
+static bool object_set_props_from_qdict(Object *obj, const QDict *qdict,
                                         Visitor *v, Error **errp)
 {
+    ERRP_GUARD();
     const QDictEntry *e;
 
     if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
-        return;
+        return false;
     }
     for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
         if (!object_property_set(obj, e->key, v, errp)) {
@@ -60,19 +61,23 @@ static void object_set_props_from_qdict(Object *obj, const QDict *qdict,
     visit_check_struct(v, errp);
 out:
     visit_end_struct(v, NULL);
+
+    return *errp == NULL;
 }
 
-void object_set_props_from_keyval(Object *obj, const QDict *qdict,
+bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
                                   bool from_json, Error **errp)
 {
+    bool ret;
     Visitor *v;
     if (from_json) {
         v = qobject_input_visitor_new(QOBJECT(qdict));
     } else {
         v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     }
-    object_set_props_from_qdict(obj, qdict, v, errp);
+    ret = object_set_props_from_qdict(obj, qdict, v, errp);
     visit_free(v);
+    return ret;
 }
 
 Object *user_creatable_add_type(const char *type, const char *id,
-- 
2.54.0


