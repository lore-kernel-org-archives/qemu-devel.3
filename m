Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319A0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZlT-00084n-9R; Tue, 30 Sep 2025 08:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlN-000829-Ru
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlB-0002OQ-CE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZs0n/5fRwnbCmGt8R7qRJ5scrzxiqpxl8tp0Ri0KqY=;
 b=hk7jlfenNJtodOlD8pj61nGusp13dXqJRSLlmi5Izv+lfFk19UJCE1lZaJidRg3z+m+FQD
 fW0rh23x9VQQTLBBV6fAOzMQsr0NAGuqmJlDa/Iw8UytzynElcr2R+3huldJ6pB8tX8Pf7
 G2mvTGOkK9VjVMhGhz8IKUcKTwTuHZE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-JOpgjZDOOLK2JhkXokQiyw-1; Tue,
 30 Sep 2025 08:47:03 -0400
X-MC-Unique: JOpgjZDOOLK2JhkXokQiyw-1
X-Mimecast-MFC-AGG-ID: JOpgjZDOOLK2JhkXokQiyw_1759236422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC8261956087; Tue, 30 Sep 2025 12:47:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02E3D1800446; Tue, 30 Sep 2025 12:47:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71CB121E6775; Tue, 30 Sep 2025 14:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 05/13] hw/remote/vfio-user: Clean up error reporting
Date: Tue, 30 Sep 2025 14:46:45 +0200
Message-ID: <20250930124653.321609-6-armbru@redhat.com>
In-Reply-To: <20250930124653.321609-1-armbru@redhat.com>
References: <20250930124653.321609-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VFU_OBJECT_ERROR() reports the error with error_setg(&error_abort,
...) when auto-shutdown is enabled, else with error_report().

Issues:

1. The error is serious enough to warrant aborting the process when
auto-shutdown is enabled, yet harmless enough to permit carrying on
when it's disabled.  This makes no sense to me.

2. Like assert(), &error_abort is strictly for programming errors.  Is
this one?  Vladimir Sementsov-Ogievskiy tells me it's not.  Should we
exit(1) instead?

3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
assert()."

This patch addresses just 3.  It adds a FIXME comment for the other
two.

Cc: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250923091000.3180122-6-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
[FIXME comment added, commit message adjusted accordingly]
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/remote/vfio-user-obj.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index ea6165ebdc..216b4876e2 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -75,12 +75,17 @@ OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
  */
 #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
     {                                                                     \
+        error_report((fmt), ## __VA_ARGS__);                              \
         if (vfu_object_auto_shutdown()) {                                 \
-            error_setg(&error_abort, (fmt), ## __VA_ARGS__);              \
-        } else {                                                          \
-            error_report((fmt), ## __VA_ARGS__);                          \
+            /*                                                            \
+             * FIXME This looks inappropriate.  The error is serious      \
+             * enough programming error to warrant aborting the process   \
+             * when auto-shutdown is enabled, yet harmless enough to      \
+             * permit carrying on when it's disabled.  Makes no sense.    \
+             */                                                           \
+            abort();                                                      \
         }                                                                 \
-    }                                                                     \
+    }
 
 struct VfuObjectClass {
     ObjectClass parent_class;
-- 
2.49.0


