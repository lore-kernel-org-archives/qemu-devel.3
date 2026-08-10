Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392FFC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtS27-0001I7-9k; Mon, 10 Aug 2026 11:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtS20-0001Gx-16
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:35:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtS1y-0005BX-8J
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:35:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-495590dde14so25474215e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786376111; x=1786980911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=evoH7tn9HwlReMqq40LV/1k6FhTDd6/nIyj6oxDghDo=;
 b=OyawgGg4YLBxK7TbR2a6sra1r/Mih502xxF1tCwNL6KRGDhTNM3CXHY3MF9qA9yb+l
 mLX76eahxc9qkzUgTP7rtFVBE0/BiRQy2iGF6ifTbGX1tkryKmOHVpij4TGsmMCG953o
 WZhX+5+j8J7E7HqlwIWOhK4ZQ7/KBQ3iJyqx0ITTBU10hNksm5sPn2q7XM6VHl20dIIs
 +eL/ZTyANJSpSMlBwke1It8dj947YGtA2zVXEMpNeiCwn5RyAI4Lyt56Ql5Ll/DPlLZm
 KaXBbUA652v7yni+TCB00bz0iIt12IoLyF6/3P1d6MBu0eW2k3yXt7klMXA45WBdTx1G
 gnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376111; x=1786980911;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=evoH7tn9HwlReMqq40LV/1k6FhTDd6/nIyj6oxDghDo=;
 b=UcY7li4bwUfo2tKK+YU0W1311C4SPWUEQnWBQBOXVz5TSCF5qz3fJMdXc6dSmjQcxl
 ZKwSME7KnxwlUjIS0Mvigteo2+z75j4TXdSPmOePCEhpALUkuoR9hx8sHbElI3uFkaSO
 z4TmMfrNtbwkzOkydshQ/xzga4OUs/R1P0laWd3hxcr+hiO2OCy1U+7IhWooJjFKTESY
 TdOlB7zTdeYrgnGaXxIuMPMfQugqW7t+twb78TQ+SQIFM7e7N8+kLuJ7Rh0Xr70UBWrZ
 JEPQbqmJGYqxrMzAqH7X1JaK7zvbT0wf7Kup7OXQkK5c2BNNJ1yqwi/ORq+9jJhmLtUs
 wafQ==
X-Gm-Message-State: AOJu0Yx8cxqy/nk+I9do7fgMzbbF0ejOycjiRj/kGa5jlpohUqDapg0s
 qwB9uuJwjT0cf1mispYjaF6X7hbOhtmO9lC7BzzI35F6FQai0+sJiBoeSjpbQs0aEhM=
X-Gm-Gg: AR+sD11/iubqvEG7XDhX0DJv6jJFrtfQcJARawO3kgihNgy7BD+wYqnLaeJLttBLCCo
 hkXw9ffDwk5ED+8sWEkqVpxX0Fua7Zce5btWvqJLss0YW7bUCKK6lJIeLxu6QSiL4GNzr9VRyoQ
 HvPiPeP5vXwWC55LN1dqYD0AOi0r9+Fwe6a0Cq31s1ScVX+4KXsovgnhgH0GV0XveXXxU7wJkL8
 a/lbR/qeIvDwct1MroU4yYVDMLjsJpqALsQJrLmyOO23QG8Og7kPx5w7PKKIWo15w6HDnh1+5++
 3y2CTK+GNucb3ZhR7JzQEpXphuuwfe9efi1na4lZD+IykKFOgPqypBrkP7bM1WikjGm/IQdOX7d
 V6pA9jbazzTZVsIOL3J0qzjsgL+MKVoJJAbW6dmLp65npb5UprZkrzI3ui1RbhsM7FFbP3f6cxg
 iSwBLnpJ89ETaKBwYPeSOT4CgeJMI/tnzSGcqh8buZC9YOgGAduG3syttLT2Am
X-Received: by 2002:a05:600c:474a:b0:496:c361:fb96 with SMTP id
 5b1f17b1804b1-4994e6db5aemr522903295e9.0.1786376111158; 
 Mon, 10 Aug 2026 08:35:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002150952sm31646699f8f.15.2026.08.10.08.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:35:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A0FE5F83B;
 Mon, 10 Aug 2026 16:35:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:i.MX31 (kzm))
Subject: [RFC PATCH] char-fe: implement qemu_chr_fe_backend_name
Date: Mon, 10 Aug 2026 16:35:02 +0100
Message-ID: <20260810153503.2652324-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

A number of chardev users where calling qemu_chr_fe_get_driver() which
is discouraged as it blocks backend hotswap. As the pattern is common
and need for the string is transitory add a helper and keep
qemu_chr_fe_get_driver() for those that really need the funkiness of
poking around the backend setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/chardev/char-fe.h       | 13 ++++++++++++-
 backends/cryptodev-vhost-user.c |  8 +-------
 backends/rng-egd.c              |  8 +-------
 backends/vhost-user.c           |  8 +-------
 hw/char/imx_serial.c            |  4 ++--
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 5f8a6df17dc..13218d04c8d 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -52,7 +52,8 @@ void qemu_chr_fe_deinit(CharFrontend *c, bool del);
  * associated Chardev.
  * Note: avoid this function as the driver should never be accessed directly,
  *       especially by the frontends that support chardevice hotswap.
- *       Consider qemu_chr_fe_backend_connected() to check for driver existence
+ *       Consider qemu_chr_fe_backend_connected() to check for driver
+ *       existence or qemu_chr_fe_backend_name() if you need the name.
  */
 Chardev *qemu_chr_fe_get_driver(CharFrontend *c);
 
@@ -70,6 +71,16 @@ bool qemu_chr_fe_backend_connected(CharFrontend *c);
  */
 bool qemu_chr_fe_backend_open(CharFrontend *c);
 
+/**
+  * qemu_chr_fe_backend_name:
+  *
+  * Returns: caller freeable string or NULL
+  */
+static inline char * qemu_chr_fe_backend_name(CharFrontend *c)
+{
+    return (c->chr && c->chr->label) ? g_strdup(c->chr->label) : NULL;
+}
+
 /**
  * qemu_chr_fe_set_handlers_full:
  * @c: a CharFrontend
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index cc478d9902d..3334e280a27 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -373,13 +373,7 @@ cryptodev_vhost_user_get_chardev(Object *obj, Error **errp)
 {
     CryptoDevBackendVhostUser *s =
                       CRYPTODEV_BACKEND_VHOST_USER(obj);
-    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
-
-    if (chr && chr->label) {
-        return g_strdup(chr->label);
-    }
-
-    return NULL;
+    return qemu_chr_fe_backend_name(&s->chr);
 }
 
 static void cryptodev_vhost_user_finalize(Object *obj)
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 1d92bd71cf7..c2207f40c5c 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -126,13 +126,7 @@ static void rng_egd_set_chardev(Object *obj, const char *value, Error **errp)
 static char *rng_egd_get_chardev(Object *obj, Error **errp)
 {
     RngEgd *s = RNG_EGD(obj);
-    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
-
-    if (chr && chr->label) {
-        return g_strdup(chr->label);
-    }
-
-    return NULL;
+    return qemu_chr_fe_backend_name(&s->chr);
 }
 
 static void rng_egd_finalize(Object *obj)
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 380d8250233..46dadb74800 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -152,13 +152,7 @@ static void set_chardev(Object *obj, const char *value, Error **errp)
 static char *get_chardev(Object *obj, Error **errp)
 {
     VhostUserBackend *b = VHOST_USER_BACKEND(obj);
-    Chardev *chr = qemu_chr_fe_get_driver(&b->chr);
-
-    if (chr && chr->label) {
-        return g_strdup(chr->label);
-    }
-
-    return NULL;
+    return qemu_chr_fe_backend_name(&b->chr);
 }
 
 static void vhost_user_backend_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index fb41ee2ac50..8ac4efbb5e9 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -278,10 +278,10 @@ static void imx_serial_write(void *opaque, hwaddr offset,
                              uint64_t value, unsigned size)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
+    g_autofree char *label = qemu_chr_fe_backend_name(&s->chr);
     unsigned char ch;
 
-    trace_imx_serial_write(chr ? chr->label : "NODEV", offset, value);
+    trace_imx_serial_write(label ? label : "NODEV", offset, value);
 
     switch (offset >> 2) {
     case 0x10: /* UTXD */
-- 
2.47.3


