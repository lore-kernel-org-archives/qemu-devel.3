Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0202E6400B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECl5-0006SK-Jm; Thu, 21 Nov 2024 14:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl3-0006Rg-Uz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECl2-0002YU-FH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlCjmMhOsETnaTyXAbRHACVEqc3kQ0Zh/uAJpxK1nFM=;
 b=ZshSu66os53hV1RdyuLeHLHNBos8h/ALnBVOhdIaa1Kl+tL2rvHRmmYl3RXw5qz6fugHHA
 T+Iy7dLU1Zzm0Mwx2ffs82tBEEJHMS+x0HguHILqeWU+kAhy173jazpHeGtGofFGYbqF4T
 L7uPam8u8sXLnSr0CxlWTeIfGQpMv4c=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-As8xvxmPOMGDG9TgWiYVRQ-1; Thu, 21 Nov 2024 14:22:26 -0500
X-MC-Unique: As8xvxmPOMGDG9TgWiYVRQ-1
X-Mimecast-MFC-AGG-ID: As8xvxmPOMGDG9TgWiYVRQ
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83acaa1f819so139143839f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216945; x=1732821745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlCjmMhOsETnaTyXAbRHACVEqc3kQ0Zh/uAJpxK1nFM=;
 b=aPEjh0Oc1eucaAgmmUlfApHPLSF4opQTFATyvlRoQvphNWuFX/OBo8WtPGvtD3WNte
 vHyhjeJd8Y0/p9Ca8p216nLygMXVQlKjw/OH2EDbwFfeCwHN/vq1aeJNCq5aOAIk2P9R
 dmDdUsYEukxgR0F/xwHsnPFUAcMc4zddD66uv0iChPYzui0cU3eL8XSzYxnrqk1K/x3y
 nwdFtokM00HCzAVcW2QV82Vl3Wn4mRjtEtWD9Eo/S3DAi3b4UDjXf6MH8z2ZkC+7T+yB
 277dMwRH5wg8BQxMd7AvQ3at0c8nrBXaYRENjUmNOAkoKPVApToyw+1fKjkgRWzLctVu
 1fUA==
X-Gm-Message-State: AOJu0Yywmmbg+SafsNtZiqCtHi4QkjON1rIizpj6rqAsJdRDIb88SNzH
 4MGJYzKu4iG1vkVXpCOt0tXGhm/gD0jgKaY0EjEXLGRZqJ9HX5N+PUx6FY1mxU5XbSk7Izsg/Af
 yBDwXAW+WgRtwmoTRMkiw33qc4Z/vEGrj1TwXAdBcaYWj01GwubKc+/V/wT5PPlBPI74etonX2W
 h5SGA2+1LXYoxm9Hj2ZM+rhCbbv2NJDPvv4A==
X-Gm-Gg: ASbGnctc9B/0JlCjSqi58AqKCLtB+q3c9LygkJ6zPFtF6SJGMDeYEWG0hSiMGxXAIxE
 OaJr2gsPcIB4R0gX22Q3y1c7Y4kKO5e2yT9brjY68FLp+StM0Lg5sMI+yL8yGda46rSV/d4BABc
 JVQZBXbtPfFhnvRI2yu0ghPFnZd9kO+i2hUpvGuzBHvdb8H1/9WaO8CdU2x6x4LXUqHn9qtvq3w
 94HwATcwluoaL61iZgMKjkSq+96Ime8XEXXUsu0QmDM95KPig3ezWaIsmmSPH8k1scahXtzqhp5
 TmZnApMga5d3ozo8un3GkONdRw==
X-Received: by 2002:a05:6602:6c0a:b0:837:7d54:acf1 with SMTP id
 ca18e2360f4ac-83ecdc5165fmr9753539f.2.1732216945552; 
 Thu, 21 Nov 2024 11:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEcrz4gsR2FCel784ZzHiMIHEQa6Iq+lDIdERLixZPsbyuVSNez3p4F297s/6ql0Xdi1xWIA==
X-Received: by 2002:a05:6602:6c0a:b0:837:7d54:acf1 with SMTP id
 ca18e2360f4ac-83ecdc5165fmr9750639f.2.1732216945208; 
 Thu, 21 Nov 2024 11:22:25 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:24 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 12/13] qom: Use object_get_container()
Date: Thu, 21 Nov 2024 14:22:01 -0500
Message-ID: <20241121192202.4155849-13-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use object_get_container() whenever applicable across the tree.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/cryptodev.c | 4 ++--
 chardev/char.c       | 2 +-
 qom/object.c         | 2 +-
 scsi/pr-manager.c    | 4 ++--
 ui/console.c         | 2 +-
 ui/dbus-chardev.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index d8bd2a1ae6..263de4913b 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -97,7 +97,7 @@ static int qmp_query_cryptodev_foreach(Object *obj, void *data)
 QCryptodevInfoList *qmp_query_cryptodev(Error **errp)
 {
     QCryptodevInfoList *list = NULL;
-    Object *objs = container_get(object_get_root(), "/objects");
+    Object *objs = object_get_container("objects");
 
     object_child_foreach(objs, qmp_query_cryptodev_foreach, &list);
 
@@ -557,7 +557,7 @@ static void cryptodev_backend_stats_cb(StatsResultList **result,
     switch (target) {
     case STATS_TARGET_CRYPTODEV:
     {
-        Object *objs = container_get(object_get_root(), "/objects");
+        Object *objs = object_get_container("objects");
         StatsArgs stats_args;
         stats_args.result.stats = result;
         stats_args.names = names;
diff --git a/chardev/char.c b/chardev/char.c
index a1722aa076..22fc5f7f76 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -48,7 +48,7 @@
 
 Object *get_chardevs_root(void)
 {
-    return container_get(object_get_root(), "/chardevs");
+    return object_get_container("chardevs");
 }
 
 static void chr_be_event(Chardev *s, QEMUChrEvent event)
diff --git a/qom/object.c b/qom/object.c
index 25316b9536..c9e53ed92c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1779,7 +1779,7 @@ Object *object_get_root(void)
 
 Object *object_get_objects_root(void)
 {
-    return container_get(object_get_root(), "/objects");
+    return object_get_container("objects");
 }
 
 Object *object_get_internal_root(void)
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index fb5fc29730..1977d99ce0 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -21,7 +21,7 @@
 #include "qemu/module.h"
 #include "qapi/qapi-commands-block.h"
 
-#define PR_MANAGER_PATH     "/objects"
+#define PR_MANAGER_PATH     "objects"
 
 typedef struct PRManagerData {
     PRManager *pr_mgr;
@@ -135,7 +135,7 @@ PRManagerInfoList *qmp_query_pr_managers(Error **errp)
 {
     PRManagerInfoList *head = NULL;
     PRManagerInfoList **prev = &head;
-    Object *container = container_get(object_get_root(), PR_MANAGER_PATH);
+    Object *container = object_get_container(PR_MANAGER_PATH);
 
     object_child_foreach(container, query_one_pr_manager, &prev);
     return head;
diff --git a/ui/console.c b/ui/console.c
index 5165f17125..914ed2cc76 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1160,7 +1160,7 @@ DisplayState *init_displaystate(void)
          * all QemuConsoles are created and the order / numbering
          * doesn't change any more */
         name = g_strdup_printf("console[%d]", con->index);
-        object_property_add_child(container_get(object_get_root(), "/backend"),
+        object_property_add_child(object_get_container("backend"),
                                   name, OBJECT(con));
         g_free(name);
     }
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index 1d3a7122a1..bf061cbc93 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -106,7 +106,7 @@ dbus_chardev_init(DBusDisplay *dpy)
     dpy->notifier.notify = dbus_display_on_notify;
     dbus_display_notifier_add(&dpy->notifier);
 
-    object_child_foreach(container_get(object_get_root(), "/chardevs"),
+    object_child_foreach(object_get_container("chardevs"),
                          dbus_display_chardev_foreach, dpy);
 }
 
-- 
2.45.0


