Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2C9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRg-0001j6-Lb; Fri, 30 May 2025 00:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRK-0001MO-CV
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:55 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrQx-0005Gx-LK
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so1025599a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579608; x=1749184408;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pr5XbKXLi2V3KwlJ9cBsFoT8dIWtqHqQMkw/uTu+ycI=;
 b=UD+E13pfs6uFkSc/MUFDVqNWerCpDtIYo3I2f2MyO92gnq50rpsr8Lr9+ASVCS2waQ
 RWUH3bsiWoGcKCQ6mAgGCO3HJqOFg4MNooHHI81w6Frp/vFmmWHS9kaYjkkTFxlsDuNC
 beSw/yKsOiCJk/10+prJSNqoshQ2NHxEsC3AfibPVnkt3pd3I695qZ4DEHG/s7Tii4th
 Hk9vwpze0tru739fkejOCS3GCBnNC2jFnBzUj+710BoQPY49HzsJyytKbrg97dTIVfa7
 wX51AXPhFH6O8S6gq6UPoJZEglYfaWz47nnd7UI4AB32cw/63RACp4xYijri+k5ma8al
 FYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579608; x=1749184408;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pr5XbKXLi2V3KwlJ9cBsFoT8dIWtqHqQMkw/uTu+ycI=;
 b=kyohglIjeT87AZ5xgTDwCmXeeMu250Yb3F4p+Mn9bNvoHonfa5Y0roLyReEE4HT5la
 W3SfGQnZ0KWU1Ok/HcqylCbZSS4Y+q8r1yxEpd9SO5giUBBlleVvUG+OlzEgKQn7MZ1y
 UPJpQoXq4iYwiN0kMLzLk43ydSNKifeYl9Fo1+f4h5O7YWrbc4LiZnGMvqrTeWmNeOYf
 wPHK7Lto6iHsp0NrWI+6gkHQNG232mm81dV7LEBH+y084qRFgfTqJb/p8OxLUblgxHY+
 gkvi988AesM+DJlBvTCouBuIIA309N1U+GP0b295qy+NVu2xNre3aSKAdWVlaMkeeIYD
 b8aQ==
X-Gm-Message-State: AOJu0YyU4zSG6mkW3EXmfxUeENHNeSpxJJeIpOKTUr+wc3GJUClSiKEP
 pSIDtNkP9VCsJ1/xM8Ffvx+/3U2xRwvHbs5Ce3G33ngu/lpW4wCx9K5YUN8FHYmg+/6YU0EspHH
 yHBvy
X-Gm-Gg: ASbGncuTy6c+/BIib7PK/q/VOP+VRJ1u1+Rn1+oP+EdPz2jUf3NXFLhQj67RSjW4aU+
 FVGG/ujVR7n5ZxHpCIzLvTDlAY/dRWQpMf7DQ5g+sv2TyAiSTPGr7nRgEQGwb1IKNZLkNk3ZFdW
 NHdqDOhEekHFOGN+jnL28YFdEosXGDkl+WSe8+0TdbhoRG7uVe8uFe6/pEQ8wmtix0YgEU/zCg9
 QgpOP+hTCaryxKHG/x7ElGJM7o1tEx5SIT+1PUtkGAxCLJzl1Vxx3ADGbHI5VfKWOy/2hRhxR9F
 stDieQ7+MUXE2h0tg9WLAHi4AjyXdPnu+pLgV0KYO2sLp6U5Cj2y
X-Google-Smtp-Source: AGHT+IEDnw6rAjoTTSpcdEGLAwTRg4WtJABskwOWq5rR/2oJZuGLio/NTkPa1Q8j6sMtlbflvmegpQ==
X-Received: by 2002:a17:902:c952:b0:232:1daf:6f06 with SMTP id
 d9443c01a7336-23529a0a258mr31201755ad.47.1748579608319; 
 Thu, 29 May 2025 21:33:28 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b2eceb0288fsm763078a12.9.2025.05.29.21.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:33:16 +0900
Subject: [PATCH 1/6] qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-vdpa-v1-1-5af4109b1c19@daynix.com>
References: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
In-Reply-To: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
bool.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/qdev-properties.h | 18 ++++++++++++
 hw/core/qdev-properties.c    | 67 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 2c99856caacb..0197aa4995e6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -43,11 +43,22 @@ struct PropertyInfo {
     ObjectPropertyRelease *release;
 };
 
+/**
+ * struct OnOffAutoBit64 - OnOffAuto storage with 64 elements.
+ * @on_bits: Bitmap of elements with "on".
+ * @auto_bits: Bitmap of elements with "auto".
+ */
+typedef struct OnOffAutoBit64 {
+    uint64_t on_bits;
+    uint64_t auto_bits;
+} OnOffAutoBit64;
+
 
 /*** qdev-properties.c ***/
 
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
+extern const PropertyInfo qdev_prop_on_off_auto_bit64;
 extern const PropertyInfo qdev_prop_bool;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
@@ -100,6 +111,13 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                              \
                 .defval.u  = (bool)_defval)
 
+#define DEFINE_PROP_ON_OFF_AUTO_BIT64(_name, _state, _field, _bit, _defval) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_on_off_auto_bit64,         \
+                OnOffAutoBit64,                                             \
+                .bitnr    = (_bit),                                         \
+                .set_default = true,                                        \
+                .defval.i = (OnOffAuto)_defval)
+
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
     DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
                 .set_default = true,                         \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 147b3ffd16e2..b7e8a89ba5cd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,6 +2,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-visit-common.h"
 #include "qobject/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
@@ -180,7 +181,8 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(const Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &qdev_prop_bit64 ||
+           prop->info == &qdev_prop_on_off_auto_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -225,6 +227,69 @@ const PropertyInfo qdev_prop_bit64 = {
     .set_default_value = set_default_value_bool,
 };
 
+static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    OnOffAuto value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
+
+    if (p->auto_bits & mask) {
+        value = ON_OFF_AUTO_AUTO;
+    } else if (p->on_bits & mask) {
+        value = ON_OFF_AUTO_ON;
+    } else {
+        value = ON_OFF_AUTO_OFF;
+    }
+
+    visit_type_OnOffAuto(v, name, &value, errp);
+}
+
+static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    OnOffAuto value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
+
+    if (!visit_type_OnOffAuto(v, name, &value, errp)) {
+        return;
+    }
+
+    switch (value) {
+    case ON_OFF_AUTO_AUTO:
+        p->on_bits &= ~mask;
+        p->auto_bits |= mask;
+        break;
+
+    case ON_OFF_AUTO_ON:
+        p->on_bits |= mask;
+        p->auto_bits &= ~mask;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        p->on_bits &= ~mask;
+        p->auto_bits &= ~mask;
+        break;
+
+    case ON_OFF_AUTO__MAX:
+        g_assert_not_reached();
+    }
+}
+
+const PropertyInfo qdev_prop_on_off_auto_bit64 = {
+    .type = "OnOffAuto",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = prop_get_on_off_auto_bit64,
+    .set = prop_set_on_off_auto_bit64,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- bool --- */
 
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,

-- 
2.49.0


