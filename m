Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E709C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yqt-0001BF-DZ; Sun, 28 Apr 2024 03:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yql-0001AJ-US
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqk-0001D8-5X
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6eff9dc1821so3317464b3a.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714288885; x=1714893685;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QlVrW3f4Ke5SO0byxmwiuvJkH9a4CnlkCbNK4BK7taI=;
 b=XqON2Vqxz5KuwVrP161tx07IhwQ3FysvsRGZnnLim4Vb3ieDwKfbUSxnxR7S6Xau7k
 2Co7exjlISGtZifbBGDr4CnUZd93fAkH1YO6gv5CU1s839EAetXVZOtvHaLOdNHbOpda
 BIhtNy8GvT9ClkUQmcUVjMXvsnz/maL3B/ufQkwWBN29XXfWAtJcdPkeCKk8Dq/C/YKC
 iYto/rUtpt9JXCv0b59ZNkmfco02BvIo9+CvNrLD6KMuyGvbTKcQNNiZ1xEdS7AA+U4y
 5JiVX8cZTpRPv6vEEGqB5LkxPeGp8bTaoxNvVMQTI4eDFFgYONqBrJJOWP3F22fl2OP2
 T81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714288885; x=1714893685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlVrW3f4Ke5SO0byxmwiuvJkH9a4CnlkCbNK4BK7taI=;
 b=msFX8HEFEG2PdGjFKcdgxGR0PFnt1u1EUUrLmD6VU46oSA3Pc1Y4/Hsotg2y5qN+g9
 O5d7yyui0yvZ40a+etvnOajUm8qHdh6lSL19HylOm7FTXx83bDa7BYFNrkHh0ReMnGny
 d1uVXal969ZN/r2G+wwKt1euyCjebHyqZpXvxYTBZdl4yfc1IRWtRzqbN/cLOcMhr+ee
 NgCbLcbm3No36xdtc4Olqd6YQnmCvYj/RRlHoGA8ZK6d7zuLom85iyFHkMmZsD5LOkFm
 +HrkY5pq7br7ImB08BMUI0v3qM3MW038bYfG5sPk3E1YX5+Y1NJW2xeCv2iPq/KgUT/M
 DcQA==
X-Gm-Message-State: AOJu0Yw1p6IPTsq6K//gFpxTe1ami+J41l3HXBuFq7t6H2A8d0gmUvrM
 2HUokcYl4D5r2v0x/bOTbgIZKQAXYQjsuXfRfk2gFlvQxxjauMtKy3oXW8v4hsc=
X-Google-Smtp-Source: AGHT+IEdNDBGlgApJ1PREiNhep3OdKfnTgCIYx1Z1n9JvdwQk+hT6eMCOWnvZkMv9M6KFKISF754Hw==
X-Received: by 2002:aa7:91cf:0:b0:6f3:f963:505f with SMTP id
 z15-20020aa791cf000000b006f3f963505fmr1567196pfa.5.1714288884816; 
 Sun, 28 Apr 2024 00:21:24 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 r8-20020aa78448000000b006e724ccdc3esm17243362pfn.55.2024.04.28.00.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:21:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:21:07 +0900
Subject: [PATCH 1/3] qdev-properties: Add DEFINE_PROP_ON_OFF_AUTO_BIT64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-auto-v1-1-7b012216a120@daynix.com>
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
In-Reply-To: <20240428-auto-v1-0-7b012216a120@daynix.com>
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
Cc: qemu-devel@nongnu.org, 20240428-rss-v10-0-73cbaa91aeb6@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 hw/core/qdev-properties.c    | 65 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e27..afec53a48470 100644
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
index 7d6fa726fdf2..b96f54a1b912 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -188,7 +188,8 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &qdev_prop_bit64 ||
+           prop->info == &qdev_prop_on_off_auto_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -233,6 +234,68 @@ const PropertyInfo qdev_prop_bit64 = {
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
+    int value;
+    uint64_t mask = qdev_get_prop_mask64(prop);
+
+    if (!visit_type_enum(v, name, &value, &OnOffAuto_lookup, errp)) {
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
+    .name  = "bool",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .get = prop_get_on_off_auto_bit64,
+    .set = prop_set_on_off_auto_bit64,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- bool --- */
 
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,

-- 
2.44.0


