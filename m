Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBF1C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWXy-0005bT-7e; Mon, 24 Aug 2026 11:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXw-0005Xq-F5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:12 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXt-0007C5-EO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:12 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c214321dc32so711258166b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585108; x=1788189908; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WJwqaddlExuj8k565K3Q7CEWlxwfLdXIcKUzKJqIN0Y=;
 b=SyFPXMnoDnR53e1dyUkanUcvDnbelCFvh3uwYlZ2E0rGUfHd1jnGGD/8zxRHDEShz0
 iCTWtFrUc4JgT8KRA0wpzeHxQQgFv+mEEVv1f4YjTVhht9hIKwDIv0fpH+OKVhGixrE8
 8LTgBaA8Bom/nmwtq4P11OkA+E2LkWaIdmqzSrXzHhpj9cVqnNobMGobD82mfhQy1KrD
 qI+FwvX3vWO25KR1XnD6jwS0ru+ewDQckVPK2aKMsGAUji+T0dxztzgR8iDWC19488Tw
 kXnUfaoOHolitmx/OtXXOoLIg7ZwkmDIJpw/j5srSB8r7NFVtjywtPrOT/eP8BUkXK4y
 3qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585108; x=1788189908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WJwqaddlExuj8k565K3Q7CEWlxwfLdXIcKUzKJqIN0Y=;
 b=brw38iaWFBjswmU6Lfsv2ZOBNbMdjWbXxVKYPGZaM9O5yobIniPpWNdhDNzsQJz8AQ
 p2S7qkxnc9pwbcyunoK3ioax7ecps8/qhb7yIg5hRTW4cPywrKJbIVhc0PYWYXN+VyMF
 6d8qEoFPFj4Ekhc42V4WV34YdsSjiNj6jhfpmynEKXcu/S0KUxShasSljKPtb50FvNMC
 f3Qh+Rm0M+Y6uKsv9yslsf1qCzQjETtMnjlxCVR5He0JBAe58SfxRq+DKjcpkWgQLN8W
 ppcpcDLjM87cnswwHHgBHrVFjonp+9zT8TGAy0Lt2UkB6nXaxMTk5isNUwhUfKyPhSTY
 4Fkw==
X-Gm-Message-State: AFuF++nYvgDSEvmnxg+5RkXhXuL+uEBFgvn4s8jXSRHvE4eiw4nWDHXh
 A6/U+0h7hVvKKbQJ4agZGyO61MNA6z0lQaM3Vqd6B6w/pJncPV/P+OcRrecY0H790h8=
X-Gm-Gg: AR+sD13KyGjspsUsP2rbLdeJZ3WBpExtBNOiWtOet5Ga1GzbAVS9bXkXljFKhcEdFu8
 qApo8Xj1i/U1bbJyU4+H+GB7RA7PsVwXslZQNe7uMxmr0kxxua2+5p1U6wMjY2UeHaTDJQ1avUD
 13CLQ9RrjUKjPJa5Kopv1g7ay36kxiKM40ZVc1+WNDRLXwwA0tOhd3bPi2jCMXN6we0ZYZXG8M+
 uHu6ZuIrQeYlj/uloxO9lDWDvBFHtDF4+q/KyAR3XRaeoRqC8BolrfNYDVmLMb8BfN5xthM840P
 fiXAtm6E/07jtvIyQLiOqO9Og5aj7+ylofKDZRoCy9oOUrIyNrKcWtSrfLKEYm8Si5sJdOvw6RV
 b89ccxBqgHWcPoJITUBvhvRjfOewYFLrszqFWPAs6zZXPQ8I/tednsbFXvDCCaZoa/ebHk3yXlU
 dQh3AEMdJ/UaZu28lQoJVNjJPxl8x2IqS5NyXnSQtwWbeG6r2BxauO2GJsCX84
X-Received: by 2002:a17:906:b286:b0:c21:752f:c44e with SMTP id
 a640c23a62f3a-c246a67492cmr2450696566b.16.1787585107685; 
 Mon, 24 Aug 2026 08:25:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24d6f203acsm290790166b.24.2026.08.24.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:25:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 65CBD5FAE2;
 Mon, 24 Aug 2026 16:25:02 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 24 Aug 2026 16:24:51 +0100
Subject: [PATCH v2 4/8] char-fe: implement qemu_chr_fe_backend_name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260824-fixes-for-11-2-v2-4-352c6b890402@linaro.org>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
In-Reply-To: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=16o9aOALfN4xkFpmwmkWkdn+kTLD6/M+CAi326lKzSg=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqjGJNe6mH5ki8B16GAGABc2EqP9oIVS4aNDGSy
 nc9Kp0JtAyJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoxiTQAKCRD70NsJWp4q
 RB3RB/4uLlgFy8NoIadYwryQpj1CzM+lWTx/wjpGU6SCyP/Y9PROSjqeVEpqtK/swiqZGGkwglG
 6tb4qmDsfPU3+e1Hsl9XyjobW4ZODOLYlDyo/ja0RcoBbwDE02NgFt1Ub4dlf2X9Tlq+KulyYrD
 Fzvnp+7VVhew4VlBB4J3YhsoCVVV6vKq81K6H1rGuEtGt5xa0fdePb5MdouZTDihC2w0YqAJDCQ
 39BaJtoOqFnuGCr6Psr3P/gFBOuboM03t1RqURLUzzFsGictFIXs4oLeZlo8Xq7joIet7hQflEU
 iNl8e56VoZV0bv/OxAuhk98cceJ9lizeHCwdHNm5kVE4+5uQ
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260810153503.2652324-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch fixes
  - r-b
---
 include/chardev/char-fe.h       | 13 ++++++++++++-
 backends/cryptodev-vhost-user.c |  8 +-------
 backends/rng-egd.c              |  8 +-------
 backends/vhost-user.c           |  8 +-------
 hw/char/imx_serial.c            |  4 ++--
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 5f8a6df17dc..a82894e1d51 100644
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
+ * qemu_chr_fe_backend_name:
+ *
+ * Returns: caller freeable string or NULL
+ */
+static inline char *qemu_chr_fe_backend_name(CharFrontend *c)
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


