Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8115E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwD4-0003EJ-TU; Thu, 09 Jan 2025 12:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwD0-00030o-BH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:38 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCy-0000tc-7u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so754842f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443233; x=1737048033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fu8Vu673xpGHSEU3TsRnxhPoaDJwCSLcIbc+aa/VbVk=;
 b=vNTCrC03I1kA1P9lv4IKGfTW1cwJX+dqx6QGvOK7RoWWHk1JL393sBrGuL17NTOzv7
 C9vyHzNRKzH/m/s/+5/UfFoNo8IkL6oLVCJAmZfot9jCXB/z5O1x2a078Q6WR0ZkCPVm
 IvSUGBeMWZ1d6e4gcP7uLJ6wipbMLU2aH0x1iDf3P1RtAqjNdt1VPleK+kEVAkBKbDiq
 PKxB5Sm2k5DqtsyxR6tRcRVaSzDHaRvdrbYgKzYwvo6616v1p5AkM9DCvmooO47mnTg4
 teF4Q/XYf5bwNCGw4gQ0jWNz3/Vg7EOMh0QTl/No/JijpmvvcLZ3/eIVv8ZWXN9V8+WQ
 C47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443233; x=1737048033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fu8Vu673xpGHSEU3TsRnxhPoaDJwCSLcIbc+aa/VbVk=;
 b=UFGo2o++NflStOL+hA8BK8Zh10O7mnNG+LkJ2DS7+ypps+EkHEm+hmRQsQWy683mPi
 Ov5k6L03/7EML/2zVARBPXd2tnsBXyQ0cpS6b0iqG+QDm99Jn82PR2GRAjpW7135cW7A
 X2/yYqcnhXvyr+fIr10IRjP8LuBpWv8HhzBSWfrHe1/nCzEv0dvQiMmG5u+K/bHveJqZ
 YnDwodpo4jbIc3HhMxbeOBKYSXhPQJ8PcBZmqnpaG6SLxE7ry5n5Inf/DnvbogmsC77p
 jTQpgyjmacmxrK+fw+6taLlb6SxF/seIftj0AGRGaRLThytfPRMuas9eEcRqdPyAJ3Bs
 kOCg==
X-Gm-Message-State: AOJu0YyMXfK6RDQZXgJVtsop319/Uy5tzEsPtQv0AR8uSbIumZu+ML8l
 L3rueVodKEzQt2esX4JmPAxsGHJamnsaEb9Oy2JhEIQDhPF43KEIz8JgWD2mUve4IpgpEJtb+M1
 Whi8=
X-Gm-Gg: ASbGncuECFNdUTGOgYTpTKK5aZFncA7fKX0BgdIYL0CD0SyeBx+R4u/aADzVxhQrmqK
 fMWSM0SNvTYDb3p1MckZCaEl1E4WcyBlKMZvy092ZKkLzIWA+RWomnbX+ziARZUjOg9LS9y667z
 TySd+/LsQWzlDD55EIOBfmyuj8AlI6qqMjZz5/jhDjLpg+B3dIEGDY0UL3riHLc0qLl3gpJzR1+
 ObsXNezMYuiRk1lMiNQbFa5f7ay/A1ZU/NLZevssQlVHMJD0WUaF1LAfSNBuVKM5TDkfV7JeLOP
 EkshjKQOhRMNTaaCU2e1ofuPVgyfdU6bLOr5
X-Google-Smtp-Source: AGHT+IEGiXaB6FW/vO/gf2GWnn+Xd33BmrnC8hTxuJzXhqEDZikw+wRi/x0ZoPZF9rebXbAxYlxJLA==
X-Received: by 2002:a05:6000:184e:b0:385:f64e:f163 with SMTP id
 ffacd0b85a97d-38a87312f41mr6302388f8f.32.1736443233646; 
 Thu, 09 Jan 2025 09:20:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddd013sm62334295e9.24.2025.01.09.09.20.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/11] qom: Use object_get_container()
Date: Thu,  9 Jan 2025 18:19:45 +0100
Message-ID: <20250109171948.31092-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


