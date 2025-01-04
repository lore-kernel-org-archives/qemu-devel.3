Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81691E77199
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyiW-0003CK-Qh; Sat, 04 Jan 2025 02:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyiJ-000397-0Q
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:51 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyiG-0004wY-TE
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:50 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so18102464a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976207; x=1736581007;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZNqJPsf/cYD6P0aHHAr+PPuSee4lD92uJoGO6q9V8Jc=;
 b=qQooVxx8GrgwncW+igRQLT1GY8Tz5xJGOW56pH6aVV4/3DZEkuNW1Vga3piFJiudtv
 Zd1lteGvFK3gwnEIbh5Kz+w3Px9kQLThuf3Uf2jhtMW28HE2xWvr0IKH09bA733X31ur
 evfwbuUypS2qO8UE+8/em9oaQNuUVE/SDtW1uOEiANDkFewvAFcYia+L/p500eHISw6p
 zDcssngnkjrXBf4IL2yAxzi8LjssCY7kMm9v7PvicUYy7xpy4FW6LRMyz0K1hLbobnZ1
 qnu/UBNSb/30JiTxumg4oPAe8KW4W767GAjebY9PIoTph4fI3yHciVl36sKsdOl8WyfQ
 l60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976207; x=1736581007;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNqJPsf/cYD6P0aHHAr+PPuSee4lD92uJoGO6q9V8Jc=;
 b=TV9hqZ4HoLI1K+3XhJ0twIZaf5PRgIr7fj8RJbpXt3M4N5v+2f4q6H6xkCej7/z9ld
 ASysyYs9FrrCOu7h1K+085/gt9oV8T/A56jinyb7ueB/bds09RMu9zIZZZgOzY304V+q
 IuHTLBYCVhq3hbG+Hop6fsrQste+2lfd3i1stZ/lf0RxKeh38sHIcxIOHMeRBs34+7nk
 1CaHJ0V71x/s2uV/rOmU1YGNbmH0nEOZAW2shAjF8vi/Ady+lw7JrKZhPzBMVvkQP8QK
 /kzZD5vz5vl0AaLdhHwxFpTpJVKULVNSR6Bhko9sNpaf9yYapdlq4kTSrtPa2u8e06j9
 8SIA==
X-Gm-Message-State: AOJu0YyhlYksInI3K4TJh7Agqwty3YRkjWTkRT/JuFVBagUzX2Ag71tY
 QJNudEtwbuH+5IqI3ZCAHGuxXrBjM04svR5X9bGRWqWmvoBDvUtvs9KlSiZPpog=
X-Gm-Gg: ASbGncuXaBuBRtb+QEvBRRk2LBf5+YqknL6HRIHcmFJUdbshpmwWn0HT/ub0359xxPO
 awsVIL/NiSgl36n2E5pQjJWBsHZulgpqMFFBzZgwIz5PDbB6b+8tzk6ZWIl2dbzZtQhGonvOVoz
 ISSQjZjyZrLguRbhG5aeujvvmRHTXvbsu5TsxKOHvEcoa3BDSVzlw45WPCRkLQZXFFjY7TABiaX
 wqzoFpxhBUw45SrBe6syOqdVaE0HzTZ2nDZ96J97J6eGNlZCAfYNqt2E31h
X-Google-Smtp-Source: AGHT+IEX6+A45ReHbsn6BNq6qM7GSsL7wf5QGmm8h/1KyjyI6nd0kAVOpk04mgoA9pT0BUlVfFPuKQ==
X-Received: by 2002:a17:90b:2551:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2f452eca3bbmr70470149a91.28.1735976207539; 
 Fri, 03 Jan 2025 23:36:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f2ed644846sm34741565a91.28.2025.01.03.23.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:36:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:36:06 +0900
Subject: [PATCH v3 2/3] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-virtio-v3-2-63ef70e9ddf3@daynix.com>
References: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
In-Reply-To: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
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
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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
index bf27375a3ccd..0d161325e8dc 100644
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
index 0081d79f9b7b..9be85cc6b7d6 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -187,7 +187,8 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(const Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &qdev_prop_bit64 ||
+           prop->info == &qdev_prop_on_off_auto_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -232,6 +233,69 @@ const PropertyInfo qdev_prop_bit64 = {
     .set_default_value = set_default_value_bool,
 };
 
+static void prop_get_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    int value;
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
+    visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp);
+}
+
+static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    Property *prop = opaque;
+    OnOffAutoBit64 *p = object_field_prop_ptr(obj, prop);
+    bool bool_value;
+    int value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
+
+    if (visit_type_bool(v, name, &bool_value, NULL)) {
+        value = bool_value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    } else if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
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
2.47.1


