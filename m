Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B63FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHm9-0006C4-Dy; Tue, 18 Aug 2026 07:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHm5-000670-Fo
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHm4-00053a-1g
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUwogfZT8j66U+wmRNHB8GMYVd8uC9R3Hcxqc0YDI2k=;
 b=grBfIIj0SggHwrHKYzx5IYwACyNJ9kIB1755ivF9Rr/sP41tFnbCZXIKOJ4lMtffRa9M+Q
 bYtR5RFc8LBdnsh+0NoHL5Ow6iPdZZuly3am1MJoqwkdwa9kg6MN+UdIGfR26me4WamDG1
 rwthnhuLVD/Kvt/KyU2CX55Vue5aad8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-rPsbQ03ZNbm_sUodry4Jig-1; Tue,
 18 Aug 2026 07:14:30 -0400
X-MC-Unique: rPsbQ03ZNbm_sUodry4Jig-1
X-Mimecast-MFC-AGG-ID: rPsbQ03ZNbm_sUodry4Jig_1787051669
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D46F0180064B; Tue, 18 Aug 2026 11:14:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9238D1800346; Tue, 18 Aug 2026 11:14:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:37 +0400
Subject: [PATCH v3 10/74] qom: add object_property_set_default_enum()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-10-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=x2uoAD3RQmtcaAsu3VGc35pkyHzqtUK9RVDnHeUy4Ag=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD23SnDoOGbUQivR3hvLnJcoawAVV/R9FKDEA
 jfvdlWHYc2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9twAKCRDa6OEJdZac
 5cpRD/9cIW3r9sYG7GY4bY5cS+3inowhrBVEOUViFLeSdbsykkAhfkR2DDe9//5Qhsp8WA2LTiR
 /C/JevAGjTOeYH0Ribzq5VJV4xHqgeSAwnzz+UYeceUoFvsinbWxMxRQ7zpOp2+OrKOcXQkr3Id
 N7OK+FjFdTviHvAAhsFkjMjiVe5SsTjk2SRV0pGfCEPBr/bbV8Jl9St6TZu4eXFKDGdbUJDBqK+
 IDpxCvCKZFWZEuYZ1ICThttYHeGw6VlOhe3/8s1tlpXCwWzH0rGqAD2ViM3u/WLxlqLIptfK2nj
 cCXe6VvEfC5WlvONhJRh7wXeudnwgOUCk4/jz9raIcjyJa+j9fki9ak56wZL+aajTwrTpTASM4F
 3WNguav8y3GWmTTwwRuHGeuhFGhzvlrqXeYL1vcYZjpq5JXrYwTe4DV1gfh126+Y22JJU+3PUvf
 Uvvu03zvhr1ZbJnNAwwC+F6V+gqeFCUr902d4aedexLG9oGJbbY0k5qZguRL9kq9RE9+TLpy8xB
 HE/oV+Zg4NSU6JmhB3iM6sPY7omw5KSqAjxdMnIicZ3eHTlDO6lv8xtonHNJVBtIF2WRn3Rbv8/
 CZfcKKHHpeAite8KL20T15BPpGx49S4AEqZMx66SvrUsL2NOfpaU6ouEZ0uNFnQ21/QCOsynFbo
 CZvXPElsCapB+Zg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

A simple helper to set the default enum value from the integer value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 9 +++++++++
 qom/object.c         | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index a262eda8de2c..271d736956da 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1223,6 +1223,15 @@ void object_property_set_default_bool(ObjectProperty *prop, bool value);
  */
 void object_property_set_default_str(ObjectProperty *prop, const char *value);
 
+/**
+ * object_property_set_default_enum:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_enum(ObjectProperty *prop, int value);
+
 /**
  * object_property_set_default_list:
  * @prop: the property to set
diff --git a/qom/object.c b/qom/object.c
index 6224e643000b..93d44a9444ca 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1705,6 +1705,15 @@ void object_property_set_default_str(ObjectProperty *prop, const char *value)
     object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
 }
 
+void object_property_set_default_enum(ObjectProperty *prop, int value)
+{
+    assert(prop && prop->qapi_type && prop->qapi_type->lookup);
+
+    object_property_set_default(prop, QOBJECT(qstring_from_str(
+        qapi_enum_lookup(prop->qapi_type->lookup, value)
+    )));
+}
+
 void object_property_set_default_list(ObjectProperty *prop)
 {
     object_property_set_default(prop, QOBJECT(qlist_new()));

-- 
2.55.0.543.g5ebe2ebe4ea8


