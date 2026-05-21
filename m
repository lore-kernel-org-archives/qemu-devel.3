Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38167CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3oe-0002xq-Q7; Thu, 21 May 2026 09:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ3ob-0002rr-95
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ3oZ-0006UP-KD
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOlUxy0YzNh0sNDdbP3tPts0AP13pJpoY3TgxxsOfSk=;
 b=Dv/qdvi1xDBS5wnafgSqCkAMkEdCchzYDPvAxnmLUzlps15Fcsd26bwdNcdp9+5ca0SBH6
 5zLLoE0KsXQz3sy3En1tMJXUCrVADjCNmHrj87tLNTu/EMGzN/X/5fyBa1wcMQ2pR8D95Y
 8fiC1YeoI9QAvN7gztexbiMq3PGqO+0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-vgmyOkr7MRODtc-sYvhgGA-1; Thu,
 21 May 2026 09:51:49 -0400
X-MC-Unique: vgmyOkr7MRODtc-sYvhgGA-1
X-Mimecast-MFC-AGG-ID: vgmyOkr7MRODtc-sYvhgGA_1779371507
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94ACE19560A6; Thu, 21 May 2026 13:51:47 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CEE41956053; Thu, 21 May 2026 13:51:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 24/29] qom: have object_set_props_keyval return bool
Date: Thu, 21 May 2026 14:49:38 +0100
Message-ID: <20260521134943.1714527-25-berrange@redhat.com>
In-Reply-To: <20260521134943.1714527-1-berrange@redhat.com>
References: <20260521134943.1714527-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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


