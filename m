Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB319C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4Xb-0002KM-Fx; Thu, 06 Mar 2025 01:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XT-0002D6-AQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:17:00 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XR-0003W1-Eo
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2234bec7192so5444305ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741241816; x=1741846616;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZxBk/fGR/dV8W/QywF6HTbYAQcdPlz1qBOC13iNfE1M=;
 b=q7TljaeCS7PE55s4gSA2cCBCN8DuPLpr1Q+g7GW9aR2hYp9XAj2k7kddXjq4aeM2Bb
 F20FZ8z+7VZZksdTqdPXlcPJf2gMJtn/znw1UVJdvVmgakKZAoSbKkCOjoZxqdAdvsrC
 ic8rmCg9ZFZWBZn38Hmgl3cM44bheb3Fzibfz5iAUDAqAJhVMyV+76MMiKVsG/OfSdOS
 fkMAH0ggmVNbv0eOZ4xBKYR7IAF/CFX+uPVZV0jz/Z6ECv6EtHFiM2lhgz8kDg7aOjJw
 rL+7w8FtZZ02Hn/gaEbIeiMSI6ztGFU37x3Wp3V8g+InLIqr7QlWnCfbFmJa45dQP0Ns
 HLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241816; x=1741846616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxBk/fGR/dV8W/QywF6HTbYAQcdPlz1qBOC13iNfE1M=;
 b=re46HZOEX5JRLb2gqdLjcQodZGEfaXnSFx43u4rka/ZJxe7NczAnhRsRkm+ur+DDeW
 xptsp3CiXqy0vPlsofgkZHoUC42xzwSSsN3FSA3+PUSVMJ7Pk8W4gsMeCtHrTKVe7ZED
 Lid0dAR2fOjJ4f+R91GwH7LRsEKhqaS/T7gNKeHf6K4sDl+QpwGNax0Kf3+X61gGaaCH
 e4YJoH+h8mSoPlb7nMkOVoMFUGwFYtVZBHTJKRj40iKei9mi6xYJYQahXPfY3pLXRuSY
 LsxM+fP4T3eWTXhOtw37/Ops8OoT0Ea7nnkEgAjJ0kwxK4UKRUFRHFnDJxO2i3usFZsU
 nWSA==
X-Gm-Message-State: AOJu0YzTBooyReng7y4fxX87EdphvboimkqV1b6uNxEJrqdCSYwpcLDz
 /sSa1jLbKw82uAFX4gMUz8gcqUobiMBQ+R9kJ+4xyICdgfpnMYjDpHByoCnq544=
X-Gm-Gg: ASbGnctVaEdyh0BR86l7zhiVC+LYiSwBQASPEIoCYk+RAJGgU+9dwAXXlrqbJkYFLNF
 QSHdIcgOjEtOiU5BnQDMV4QHxrJKBRZBukhVpzCEnpahCoALzBziXyiPleFCocuyWlxR7uwVER7
 d539RnAUo57/J0TSnHC0htFCrr8ke0pexZI/1L+Uq9m4nXlT8ulLTF5EXey+AjtgDpcb3vKOaec
 WvcbNt9gnvb02ksSxDGB7lkKWeHtek2T9Ao3fnpTndVvrYEuricVayQ5cvnXVNDFmCydJZMriIX
 nEWVLboyUJZYu6HXrl2XeP0ye1PlLQpCK7BkKuvjfufaJalm
X-Google-Smtp-Source: AGHT+IG1mxOhPXte33U8wwl5jxtymCcF5Xfqqr86JH2GDL90PfX2YFLJejn85IfRxNcTZNq0KAVW8w==
X-Received: by 2002:a05:6a21:a43:b0:1f3:323e:373e with SMTP id
 adf61e73a8af0-1f3494784c8mr10660598637.16.1741241815959; 
 Wed, 05 Mar 2025 22:16:55 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7369853818esm489888b3a.168.2025.03.05.22.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:16:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 15:16:29 +0900
Subject: [PATCH v6 3/4] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-virtio-v6-3-1235eab776d9@daynix.com>
References: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
In-Reply-To: <20250306-virtio-v6-0-1235eab776d9@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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
 hw/core/qdev-properties.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index bf27375a3ccdb238ef3327dd85d3d0a1431cbfbf..0d161325e8dc92d0e0e5aa9a1e2dd734f7a55cae 100644
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
 extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
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
index 3462921841db74456284b91374955b6101f03bbc..54fbcc9fa8d4b66003d9a66b1e6af61684c59ae4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -188,7 +188,8 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(const Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &qdev_prop_bit64 ||
+           prop->info == &qdev_prop_on_off_auto_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -233,6 +234,69 @@ const PropertyInfo qdev_prop_bit64 = {
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
+    .name  = "OnOffAuto",
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
2.48.1


