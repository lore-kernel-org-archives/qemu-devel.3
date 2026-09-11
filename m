Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D03C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Ga-0006Lr-2w; Fri, 11 Sep 2026 12:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54GC-0005Eb-0D
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54G4-00064b-K4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkTYx/29pXvG5zcNdkFguRYLLkRjW5IxZjj8tXCLuTE=;
 b=FJos/WaPn+RPswe7rpj1SB+6JLvbURDIVb0lcUOH8ClryPjAlMS46a5A6OPOwxk/+kg5AY
 1WXX0tSO/7sIGGejHmUfiiAyd8EkOh2nI00KtydQ34R498lvyDOdB9OTLooM2ySvIVyYJk
 bZrNKFY98IWKiYqLeTxmwxu3LI9EnPQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-f0fS8SN6NBGjEeHGEOD6jQ-1; Fri,
 11 Sep 2026 12:37:36 -0400
X-MC-Unique: f0fS8SN6NBGjEeHGEOD6jQ-1
X-Mimecast-MFC-AGG-ID: f0fS8SN6NBGjEeHGEOD6jQ_1789144655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81F7019539B0; Fri, 11 Sep 2026 16:37:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 845B81800351; Fri, 11 Sep 2026 16:37:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:44 +0400
Subject: [PATCH v5 10/62] qom/qmp: populate description & default-value in
 qom_property_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-10-7732a55b7760@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qmx3fiGa/Y4SU5dXuf1JYyfVNHr2dqaFvQawEIv62yY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC23ufO1tALL4LpNKJcGzW7vWCA1i3IiiWhfJ
 qpYVOnW8FKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttwAKCRDa6OEJdZac
 5QotD/9VXyhUL+tHQFyl4PYNB1NKNriKiTE0Dc/gbKIzEbDYwwcrf7PLnZxbK+aG9aHK3CP2SOX
 OLzqwaYnAG5eFIC86zrAPBEQeZINRuVVjVw6tlUTdbtVEZ5iLFKZGjDQm+iKyZl/e44cwaA5zWv
 8AUnNXV9guLg0TeoXoi0c81DFRqTG66HpxmRcnNZ5N7vF+SgVEnA0MyQjyF5PjFAtFESooRUJjg
 4UF9MAVx4Bc/heGnB/OxcQFpCpI/G/JMqHHDMATU/06cX46T31dKuF2Z6aUUxzT32up61Rw7xJv
 hfm9Cjdcf/oV+ROedzMZ7fmzYbJjlPGRakMm2O3CoIYi9QphPoycgPJy/cBO3bhFhc7E82yECXU
 B23Vp2OxnydeoGLenB8dsWs0qaRHQ3/p/3r1QKQ9AWxjGsvReP+ou5AxkGfSV52H4qNtUo/5LEk
 +6Zu4luek7BJDPQ92/u8HgG6ql8LZsMOiXnzsBFkrtavsmRtxEYJikrDrt5Mjn/cmHnSyhwMKpQ
 bmUI3WOO/yzAsuPsCgws7h4e+6zk6XS7n9K77ZY1rRa7VB4O02KW9EKqV7N319R4Pyx9BAu/Q8/
 kcOlHjKtDto4fWL3SVIn2IgcUyaPdM7aNOZt8le5IBJbMOCc8cL9ax9jOUZ7IKgiMp28vIDIr3v
 DyKb92Y/U6XMqmQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Move description and default_value population from the individual QMP
handlers into qom_property_info(), so all callers get them.

This also adds description and default-value to qom-list responses,
which previously only returned name and type. The handler doesn't care.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/qom-qmp-cmds.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 500930da14cb..2516b9871d90 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -35,6 +35,8 @@ static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
 
     info->name = g_strdup(prop->name);
     info->type = g_strdup(prop->type);
+    info->description = g_strdup(prop->description);
+    info->default_value = qobject_ref(prop->defval);
     if (prop->qapi_type) {
         assert(prop->qapi_type->masked_name);
         info->qapi_type = g_strdup(prop->qapi_type->masked_name);
@@ -220,8 +222,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
-
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
             strcmp(prop->name, "realized") == 0 ||
@@ -231,11 +231,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = qom_property_info(prop);
-        info->description = g_strdup(prop->description);
-        info->default_value = qobject_ref(prop->defval);
-
-        QAPI_LIST_PREPEND(prop_list, info);
+        QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
     }
 
     object_unref(obj);
@@ -272,12 +268,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info = qom_property_info(prop);
-
-        info->description = g_strdup(prop->description);
-        info->default_value = qobject_ref(prop->defval);
-
-        QAPI_LIST_PREPEND(prop_list, info);
+        QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
     }
 
     object_unref(obj);

-- 
2.55.0.543.g5ebe2ebe4ea8


