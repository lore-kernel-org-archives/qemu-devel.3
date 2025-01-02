Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1265E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMtJ-0007oK-77; Thu, 02 Jan 2025 10:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMtC-0007fi-36
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMt8-0006ae-2J
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso11058474f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830808; x=1736435608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ko8bxyqNd4qTqbyGca0rSHQuh29/RSksetMq0xif/o=;
 b=EYKHu2WxyvQERoJCzsYT0RM3yejwYlDs2KSJtcwpbEJ3ESvXME5vUXBT2IOfAKyvZx
 EKw4h5aZQei74DREPtk/okV2D+IOikJKV9CfAeIr4ealghlukWnooss1uFsOtpIlaekd
 ciswDD0NvkntWeOvDI6pXXeMK1ljjwozUL7HL3yQ9ktZipdYoEXS8772rwBOo6TGOlJY
 J+mniYdfs7MLVhXNMAg4BDBZ4me6wL5ZcMxZyg1GnA7eDeE/7t/+6Npf1ABuBy0TG+Wf
 OxndqBJQ78T1h35YATkAPySglxf3T+PPMTRMKql5mjSVMS8pVwYgyswj0OZyibkjsvWt
 YIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830808; x=1736435608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ko8bxyqNd4qTqbyGca0rSHQuh29/RSksetMq0xif/o=;
 b=NajY4iKO1Hv8iRDOfRdhcEIPMAnIMI+y9scUkhyLsCZ+UI5VdNOWoctfhvhuzH3AkW
 kNNVPl8BTNx0CxhB+ng/0k/F0+5st4X09RxWXk2AYYbg7aL46rJ4oh47FXucU3QVGPtW
 Wt1We4+GQe+AtQOzGrB/XfrAupLKXzXDHnWWKuuzx3LHAKRsD1sEt1+FjIkESKx1pH4V
 GX6O3sCgJr75ceLO4AVYgw39ca8TcNf1EO5FxpOcSfvoP5DgM/abZRKy55Mu27RscohR
 FslqI8K6br0JBFSmXu80kxM6FaxuhVVDJRBvxcMhinth748tPmjreFBWpyxpyq63SEX/
 ah6g==
X-Gm-Message-State: AOJu0YwLz3xPdBckAE0LHoat01wepETvg+3MULg6OGijXndmwjvpCvjP
 TLw/R9CXCCEWGXU8C+i+KIoTgBC5FF6D8TJ1rC2fLf25mXN0AzvEW7XRUiKDWHkekwNvae6qWcT
 9IsrNjA==
X-Gm-Gg: ASbGncvVGmBdWC7hKfqrMj5/gbDuWssaGIBTe5td8c55pJe1Vm3dPsT+yfIJuxgyy9p
 5XpEOK3Ds4240heVE4B2OXURrsWsRMOGIzAuWvfls5d0X558oKGwFOuAEZEAWIreKVCDtGbTU+d
 RR1lBp4xrjT76ueiInudNfGEgU+t9jWP9dVgpa/hUCajsTlakJ8gmw7etqYn3NqXJxKQDeTFkS6
 TqAyUQrhp6ZOTUovdoMbYgzgrVkyc8Tz4d9IremACxG8Z+iRjRLdHERpVtmh2LTuLlwzYSZ+wRE
 rz/Q7EDZpXHUa1E79c6GFgCRbPq/VA8=
X-Google-Smtp-Source: AGHT+IETjNxYh6lM9uE81L2cdKi2yIWWQUE+ax3fNTBapCzDcb8l/y1pa+w2+eYqAqswW1gDMMjxSQ==
X-Received: by 2002:a05:6000:18a9:b0:386:3835:9fff with SMTP id
 ffacd0b85a97d-38a22406d43mr41647964f8f.59.1735830807887; 
 Thu, 02 Jan 2025 07:13:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4365c08afcbsm464912745e9.21.2025.01.02.07.13.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/10] qom: Use object_get_container()
Date: Thu,  2 Jan 2025 16:12:42 +0100
Message-ID: <20250102151244.59357-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


