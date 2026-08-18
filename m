Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D861AC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC89-0005NC-94; Tue, 18 Aug 2026 01:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC87-0005Hp-8H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC85-0003qG-G4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so5727559b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029972; x=1787634772; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YLd2wdLWmGn/myw/YqHvhA2qKd6cbpArYdUl+1k3wFU=;
 b=XKVCk7ShT/s+L59SpdBdhHn33068Ki5R5Ji6SxeE+sAIqESa7Vo51nL9xM0ZT3fS62
 X4rIpC0VupoRRtK7HGpDvhOxhqGZ82MJeyCWMkgWRYXfscSlVcX+T0gaEINqP20YKdxw
 7Cm6WM+VkliHEXcn9b5HQFhNaDdSZ0v2Y0lMCACW3LZj+pm2Vczd0Hl8989alfSIvw2t
 RvneuNqwm5Ggty4uXhrTYB6VBcMgCCX7HDFZgk7n/AX5FPVXeltBDqYX5UpgRLqWaqTH
 p2kFGE1HfDyEq4owj/LAp/G1rfi/dNkXEWVLUOySqom/YiWP1AEA9l5WZrlJN3DrvZ3W
 njKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029972; x=1787634772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YLd2wdLWmGn/myw/YqHvhA2qKd6cbpArYdUl+1k3wFU=;
 b=m81j0G4zm0d5vBgvkiPFGtdLvjjP6akKOEV/lEkhposampdgrjjsdeJrLiz2vhkyk4
 gUYpH0BA4Bo86AiM4BHZ4KMcWu52Q/7w9I+bejSV+elyjuD2sVaTlW/epBWcnrDx1VTx
 Km7+/Y4IPbIBw43q8moMqHDfjOJVK62OnNGecrXO73fDuhd8xGweWmiBU+vTyRyHq16W
 g/wivCtW6gVO/TtfsEE8JyFgyQ4r4l+0zQ8bQX802upqeLyjJXFhKhk75S/0enitOwBR
 vJ4WK6JB9Z1mVbQO11vuGAmyFmqPFTfZWbZZGGil4beuOZvnysYFcpKMm52/zYQyfjnm
 TWQw==
X-Gm-Message-State: AOJu0Yyjtk8eUMvRRw/EJYCxp/oOWMW9B+9vjVAYP61JHTb/K4gyN+gM
 wJ9tNJ/TA39vqbyLzscM9wHF4o4dF5gdYke5lNvv4eji9hOhNtIMHV3b
X-Gm-Gg: AR+sD1287rQ+2kpjMrLWi4PKNx/NsWayINURcXaCjugx4rYZMO9YTMyWUCB8NBFPXs2
 9Bn39Za8AQ3dPLXQeuuIChBOaIbvp2QzSCsD7SKsuHTQmNR8ckx9YyTXEwP5eqsOMqXMIcJQ3cJ
 Zwt4FsxGNTr1SIymvFORx+7IVHyUEkao4CTQSNn/7rv0F416eL6nz+a9lXYE94Ma5y8VS8hLl3u
 AoRrNZxvu2YfI7K9oklkVNr1a/dkoMr0w2rdG8RIU3vC60KC437bQ5ELmf+yrZ9zukE2DvCgSkP
 TAMfEQrjqH4gpGJR6g8D26i0Q1RgFijfuTJAj83iWKZm3oBCTa3Fy8Am3CE/GyjUReRvLA69kBF
 M4QfIsqRwP7ebZeMhJqR/JIQOeInVYK6hOdqohVUUAcqj9F9IGrJiQkJkniqtdVUGKPyFT2CQLQ
 HvDXMQSb4a9XIM7qSBwYQLvy69gKGGooJl/AF8mqL2PXc0pY4KT2IIAfCTgMUyUJ/Hf1GbIDUGh
 cgI
X-Received: by 2002:a05:6a00:2e99:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-84fddfce17amr29977836b3a.10.1787029972164; 
 Mon, 17 Aug 2026 22:12:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:51 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:27 -0700
Subject: [PATCH RFC v2 12/13] backends/cryptodev-vhost-user: add memory
 isolation bool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-12-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=3359;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=eS7iavmbL0ampAG6cVubHx6sNBExzuvb7v9JapDYYmM=;
 b=QQC2OuLiUfEcGY5CpgdYwdIVlG/TPTJH7ZlmxUHZmp1sA4tGb7tfTiqnQlBPGifcZORQ+JMwD
 6K2JrArn0J5Ct+0HPw1nnvuKpOOZIgruSX4qtfleJJy8I0Q4U1EiBIx
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a memory_isolation property to CryptoDevBackendVhostUser and
add add it as an optional member of CryptodevVhostUserProperties
in qapi.

This is needed to be able to specify memory isolation for
cryptodev-vhost-user objects, and the bool will eventually be
passed to vhost_user_init() in a future patch.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 backends/cryptodev-vhost-user.c | 28 +++++++++++++++++++++++++++-
 qapi/qom.json                   |  8 +++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index fa1f9b76d3..be8631446b 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -49,6 +49,7 @@ struct CryptoDevBackendVhostUser {
     CharFrontend chr;
     char *chr_name;
     bool opened;
+    bool memory_isolation;
     CryptoDevBackendVhost *vhost_crypto[MAX_CRYPTO_QUEUE_NUM];
 };
 
@@ -213,7 +214,7 @@ static void cryptodev_vhost_user_init(
         }
     }
 
-    if (!vhost_user_init(&s->vhost_user, &s->chr, false, errp)) {
+    if (!vhost_user_init(&s->vhost_user, &s->chr, s->memory_isolation, errp)) {
         return;
     }
 
@@ -392,6 +393,27 @@ static void cryptodev_vhost_user_finalize(Object *obj)
     g_free(s->chr_name);
 }
 
+static void cryptodev_vhost_user_set_mem_isolation(Object *obj, bool value,
+                                                   Error **errp)
+{
+    CryptoDevBackendVhostUser *s =
+                      CRYPTODEV_BACKEND_VHOST_USER(obj);
+
+    if (s->opened) {
+        error_setg(errp, "Property 'memory-isolation' can no longer be set");
+    } else{
+        s->memory_isolation = value;
+    }
+}
+
+static bool cryptodev_vhost_user_get_mem_isolation(Object *obj, Error **errp)
+{
+    CryptoDevBackendVhostUser *s =
+                      CRYPTODEV_BACKEND_VHOST_USER(obj);
+
+    return s->memory_isolation;
+}
+
 static void
 cryptodev_vhost_user_class_init(ObjectClass *oc, const void *data)
 {
@@ -407,6 +429,10 @@ cryptodev_vhost_user_class_init(ObjectClass *oc, const void *data)
                                   cryptodev_vhost_user_get_chardev,
                                   cryptodev_vhost_user_set_chardev);
 
+    object_class_property_add_bool(oc, "memory-isolation",
+                                   cryptodev_vhost_user_get_mem_isolation,
+                                   cryptodev_vhost_user_set_mem_isolation);
+
 }
 
 static const TypeInfo cryptodev_vhost_user_info = {
diff --git a/qapi/qom.json b/qapi/qom.json
index c55776af7d..1024027195 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -350,11 +350,17 @@
 # @chardev: the name of a Unix domain socket character device that
 #     connects to the vhost-user server
 #
+# @memory-isolation: disable direct access from vhost-user back-end
+#     to guest memory.  The back-end will instead access data via
+#     bounce buffers residing in the QEMU virtual address space.
+#     (default: false) (Since 11.2)
+#
 # Since: 2.12
 ##
 { 'struct': 'CryptodevVhostUserProperties',
   'base': 'CryptodevBackendProperties',
-  'data': { 'chardev': 'str' },
+  'data': { 'chardev': 'str',
+            '*memory-isolation': 'bool' },
   'if': 'CONFIG_VHOST_CRYPTO' }
 
 ##

-- 
2.43.0


