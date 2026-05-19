Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F23CCD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJxL-0008D5-6p; Tue, 19 May 2026 08:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJx1-0007eO-VL
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJx0-00018L-B3
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOlUxy0YzNh0sNDdbP3tPts0AP13pJpoY3TgxxsOfSk=;
 b=TIO5LLB0OEUyaO7O51ZXO/TGiQjH3rNCQtzLNX6yitDxKvvZ7A1Xzu4TJrYg1m53RMRBdh
 mTD2G+1ID910mrG7frnG/N2SENexsr647o9Fbc/wusniC7gY31hOZrGsOmgkE5Q4SW//bG
 daXAmcAkm6lvA8qDUAUzC4QgcFqFvyg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-67m3TkctOD-sx-Ky02NjXg-1; Tue,
 19 May 2026 08:53:32 -0400
X-MC-Unique: 67m3TkctOD-sx-Ky02NjXg-1
X-Mimecast-MFC-AGG-ID: 67m3TkctOD-sx-Ky02NjXg_1779195209
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8DE3180034E; Tue, 19 May 2026 12:53:29 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E11E1180056E; Tue, 19 May 2026 12:53:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 23/28] qom: have object_set_props_keyval return bool
Date: Tue, 19 May 2026 13:51:47 +0100
Message-ID: <20260519125153.1015315-24-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This matches the convention established by the object_set_props and
object_set_propv methods.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h    |  4 +++-
 qom/object_interfaces.c | 13 +++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 83b0cd01b5..822f56c87e 100644
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


