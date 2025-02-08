Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE78C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 07:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfcu-00061C-38; Sat, 08 Feb 2025 02:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcs-00060m-3v
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:42 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcq-0007aF-Fa
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:41 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa0892f9bdso4052461a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 23:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739001099; x=1739605899;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dj8ygh4vHQ3IWs88c977D3eMuGw5gxEkT1B9kT9ojBI=;
 b=gtZ3n+CiYGMIN4KZbLuRh3r7UG0WD5zkxoj1vp9r9cy6XanAcGJ89OeJR255VA7rZ4
 9tSBPtga4auAa7KiqORpPVdPNOf2HDVdBVDESL8ohsy/euG2sxg8QrmgM88St9WkuOx2
 J69DveGZ6SuR7b/cpRnqgjN+yOM+a3u5TrGAZpDeYcAUNNJGI4vE0vwNOplyjdELKzUq
 G5+JtiAxHVUn/KxrpNeQxqJz5w6hkJoch2N/KZRe9KQPifIlyHM9oBtK4Y9P4c19KqTX
 jrkTmmEptpHxfJKhgnSkJCsTUnIP95GSdLLNR30anMLuT5f4MrOsxKNmo0v1qdYiq13B
 57vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739001099; x=1739605899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dj8ygh4vHQ3IWs88c977D3eMuGw5gxEkT1B9kT9ojBI=;
 b=EdT56EzHdNRqrL354q1vujOerh8KLc166XC72JvoYJIQs9LXYvWQH8vmyl6088YQf1
 Sc7g4A4vmIT+UdocjwfH/EqC665RYoTLxYoFn20AyGF2ewQor9bgFAt+EdDh4+wHl4Vd
 IYnwdSenTpA/b9i7BNfTVYN5oo2H+d3xLutwOjO390oueL78gSRof3KBRHfut7QT/6bI
 wR4P1VrGCaQBllX2P35rMuqauc4mvr63o/ta+cut/ZcJ97Iz3xWE7DYshhgkHf2jXta6
 wDmEgivtMuS+xmB1Dy1tq7bwf4mR0FU+membp1Rdq1GQirIZ0h72cz14hh0WQvjwug8p
 Vwyg==
X-Gm-Message-State: AOJu0YzpsYfYAweBU1AACBHLtAtSL9RKcr2R5s+jocrEauZPRUQG+Gvq
 CB+JPHGgX/vhzmU//V4WJa5ba4A0m5gdB6FotgEmd5tkp/3BWnYBxWmOFbZZP34=
X-Gm-Gg: ASbGncu5gz46J/9fraRQrVRT5VALYeAxiGgPTcpHznlsRroCLzeQmCd9CmqJSzvk8nh
 0z0qdmodlliHAiTVcAQzr/sZNN2OpGoNsVkXRWPnmSQljIgcN5eWb9ZI9xgjm92Va21EOuWnToe
 CJHH4pTF2MgDXO9RQp9UT2zP7Ldgm8KuIVxTWQV3hN0Hv2xZqDPRm6ayUhxZzbIQ7vsTJpyntpG
 6DPUVzZcdowpxnkK7aDD6DL4vYfaaPI4sZ6wyRfpOGZ7Ee79Xvisc/mgP7Q1J//I8tQHUlFEaVd
 g4rJFAUyudK+Y52GFzc=
X-Google-Smtp-Source: AGHT+IE7Ra8iD8s/TG01A3EUYSnmLXr3jSrTlD8vtUslNB34/1ASIXeBwDVb8Nr6wYW4ztks1InN/w==
X-Received: by 2002:a05:6a00:9286:b0:725:322a:9438 with SMTP id
 d2e1a72fcca58-7305d4135bemr9005357b3a.1.1739001099211; 
 Fri, 07 Feb 2025 23:51:39 -0800 (PST)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7307bfc03efsm188745b3a.160.2025.02.07.23.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 23:51:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 08 Feb 2025 16:51:09 +0900
Subject: [PATCH v5 3/4] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-virtio-v5-3-4376cb218c0f@daynix.com>
References: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
In-Reply-To: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
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
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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
index 073902431213c5be47197cb0d993d60cc2562501..cfab7b97091ad704b7f43d6ba6fcd8937ca5dfe3 100644
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


