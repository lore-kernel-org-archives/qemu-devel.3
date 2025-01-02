Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13658E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaV-00047Q-Ji; Thu, 02 Jan 2025 16:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaU-00047A-D2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSaR-0001QG-Q8
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:38 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso81275625e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852714; x=1736457514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ko8bxyqNd4qTqbyGca0rSHQuh29/RSksetMq0xif/o=;
 b=bs6r9XfI9CPAGKRy6+ILYPYHxbmEEC3UgiIem5zOC6jM76HybTZKvihTc4BQwE0Gm1
 C/ILfZ7V35eXIuB07AfSP69uKjpojMNPsO1t2LXX/WsqFyml8NhvhH1b3ceVE6pDCWu/
 MqvV+8aImpp7PYjCWvkSLQzmtxMeKUSqWcHu7LfNq8/yMRAtfWm/opyqJ6zfmHkfrSTT
 j58qwJaE3pQqylmyvMHLF+/PDXa9SaOwcrNBOYX2+82oFVuC2Sv4benBnBuUoJc13Cov
 Kg9Q99X6dEUfIhJFzWanYvFzOh058Oyw7lV9iF0IYeeqbiU2LeWeBSIw7ZkXccp/Oi+X
 inpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852714; x=1736457514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ko8bxyqNd4qTqbyGca0rSHQuh29/RSksetMq0xif/o=;
 b=cXyWS1OBY5MusQnohn+YJrOtWJmB5oA3yKmtP3e4y/jp/MJjeksyjJri54rKl0PqSt
 SmRZfsT3W0uHvyO6Mn911yGrtWZeVN0N0eMxVNgpBGW2TtzTE2x02PJJxOz3WfAAx70A
 BQ28tHWqpYNOFtoX6XFVVmuTHq1Z3l60ZY4Nqcyh+O3O+PJUZ4P9KrVre4xL3HINH/tq
 oEz5Jb+J8ZAtUZNQPT2tb2W4A/YpbtPv8lY8ICEl6YZoUxaZPO8Znp0PaWHUj7SiLGdb
 VVHSxfN7ftrnQ+ypXxJcuO+ogSyHCptSH8/cSoYu8is5VDqNmfXgiovEHvEP1vspewwv
 e62Q==
X-Gm-Message-State: AOJu0Yz10ehBcI5ebKX9qfdSCfGVJXqHlHgSbN41856WyYHohpszJaq0
 v646hv1na9mUWO2xUx44QoURY6Ftf/Q4fRe9zwIdylqBaoTstPJCr3ODDZU1vP1Jczu6XvPJhJz
 C+022xQ==
X-Gm-Gg: ASbGnctJN32FHT9gbfPst4WpO7tyeZZZxI11cFykdOglxxcHVFJPA3gZAcIbUp86RZA
 4MmvCXN745cPPwUZsBPuhXwFdPg9U2Dn62uhh3AYYTWhRNRsK+EiC5Bg8udcEIlsfAroiLzwooX
 CQ19fX6uTH7/LnVOA7BN+C6LhpO/2gISG4dkClV/n2t+WwXG/CZXGs0n3csVQYdGRUEcdIdX6KI
 6fqb/3DuXHL6nxWix5sHM8VczQXtUHw1UEvBD7QSYBrB8caGYe3xoaD7b55naYasvO35fkROJEw
 CvT6EfnB1qzQsNqLtvJdxKwp+bNq1rM=
X-Google-Smtp-Source: AGHT+IHeKD+EqwcEplzZNb4Fx7FdqR28a2/UvMfDlfXCtQwz9iMGcCqmZMXsgJk/chSJt/DlBh8IeQ==
X-Received: by 2002:a05:600c:350c:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-43668b7850emr412736405e9.30.1735852714118; 
 Thu, 02 Jan 2025 13:18:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acabbsm38725112f8f.93.2025.01.02.13.18.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 6/8] qom: Use object_get_container()
Date: Thu,  2 Jan 2025 22:17:58 +0100
Message-ID: <20250102211800.79235-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Use object_get_container() whenever applicable across the tree.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-13-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/cryptodev.c | 4 ++--
 chardev/char.c       | 2 +-
 qom/object.c         | 2 +-
 scsi/pr-manager.c    | 4 ++--
 ui/console.c         | 2 +-
 ui/dbus-chardev.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 1157a149d02..1187b08dacf 100644
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
index 44ff116fcda..7705da5ad02 100644
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
index 81c06906d30..58897a79a76 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1774,7 +1774,7 @@ Object *object_get_root(void)
 
 Object *object_get_objects_root(void)
 {
-    return container_get(object_get_root(), "/objects");
+    return object_get_container("objects");
 }
 
 Object *object_get_internal_root(void)
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index fb5fc297309..1977d99ce0d 100644
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
index 5165f171257..914ed2cc76b 100644
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
index 1d3a7122a11..bf061cbc930 100644
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
2.47.1


