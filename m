Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C93AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4XT-0002D4-5S; Thu, 06 Mar 2025 01:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XN-0002Am-5b
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:56 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tq4XL-0003Vh-BZ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:16:52 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2234e5347e2so3907675ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741241809; x=1741846609;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OLOTqxsnw4F4JJLwq/6kQuieMJFPp4Wc6Bq0bf8Xlig=;
 b=rx5e1EkNqtE3/F2iO3Hvc7CrvINnfsgHtHwWl9oDwH0XoGA/oG7hhFeAgo+p9Pv6Ji
 hY8wyoAAcr7PlNeh5YIJYEJpmzmf1DC2yDNQ0QcajVa2J7izQhUCNmnmOYQFM9dOgg2l
 XThXt4Ed8XCp/AeHtZkK2BUs4GBYkl4HfrqsGo142L7zGr4rHurjDWd/dn2yVdpvYCIO
 lLxuTtGknfBAhayOMgOqdPfQ1jYK7pUtM34mCuXxqAfG8UVD6fkr/bTxOd1ARzHTch9M
 uqdw8dL9Aqx25EyMA/ScqS7Els9oz/fHx3b60+Up3RWB1ivaz6q0gkuYBg6hrnZTkLOc
 oSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241809; x=1741846609;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLOTqxsnw4F4JJLwq/6kQuieMJFPp4Wc6Bq0bf8Xlig=;
 b=XUvgCAnDxmVu8NPaN2JtC3GR1reJz4YMjtpWwOiGqf5/YHIKWID79NeF+08G4POJyf
 D4bydqaa/to8k1bpBnsYVmHNvk7g2rIo4HUbFVkpq9I5lovx1sVw1uWoznY5l/5dezAW
 pIGVqz2sqeFcMY/CgeGlXSkM7X2BvnAKjqXUliAjIzGrVsNaOwFX+vTBzvKGuAfiwvJI
 nhHxv49KNnc2RL+8URnKyU63nKIu601R5UU28pNHZAff+WP3tRetueWgB76FqEL3qdoh
 PQt4eTXFwiyRuaz5CaAFEl7gftDk97rGTHFXEjT62HSPsl1WbGuuXUiqkEXXfl+OZBZ9
 wA8w==
X-Gm-Message-State: AOJu0YynJwdOVCsEAbAxyTun7pCjw/XQwpNEpm+V7jNmDMKSJ/bZ59+A
 tGgFPYiZhjkWAZGSPeAjfB+hfuNIZgcQTCMBcX8qBCJDkb+YyDAo5YUrGKqWta4=
X-Gm-Gg: ASbGncuuuuM+xWEzSdQ+kypDO80hbLHjC2Q0p9ZhoGveiad/Sx8SsBvEId4XHHaQWJ/
 hO6gDH313R08obEFSN6gYFQvZHU1HL0bJYKz9nYA0wXlr+h0Tezg9RQTdfJd/F80sG5bfWT3zbC
 uvPKOzJFk99mwOkEr4HipdV0qdUfQDjdIT7fS8IunSsyZ7TEKlZIZrXaQg7VJ4jXOKHAJDirYQl
 KL9M5+262MN1wosJuqsG9ssTuT7IJ9efONdI8mAM23rKxJPiServ9osuBHdJJbw1xSDlS/oteva
 6U7Z+5N6kPnnOcTkiIMcr81TLvaxNQIPgVkZBv5JXJnCZOfX
X-Google-Smtp-Source: AGHT+IGhDAQUhdj+WPs0WXC+p2k+n2erbuGkxErWenxDhcbHUomGbl61oyuOjT4kP1sLR2PUbLMLVg==
X-Received: by 2002:a17:902:da8c:b0:224:13c0:58e3 with SMTP id
 d9443c01a7336-22413c05b5fmr6975605ad.51.1741241809476; 
 Wed, 05 Mar 2025 22:16:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-224109e944csm4362025ad.74.2025.03.05.22.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 22:16:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 15:16:28 +0900
Subject: [PATCH v6 2/4] qapi: Accept bool for OnOffAuto and OnOffSplit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-virtio-v6-2-1235eab776d9@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

bool has representations of "on" and "off" different from
OnOffAuto/OnOffSplit:
- The command line syntax accepts on/yes/true/y and off/no/false/n for
  bool but only on and off for OnOffAuto.
- JSON uses true/false for bool but "on" and "off" for
  OnOffAuto/OnOffSplit.

This inconsistency causes some problems:
- Users need to take the underlying type into consideration to determine
  what literal to specify, increasing cognitive loads for human users
  and complexity for programs invoking QEMU.
- Converting an existing bool property to OnOffAuto/OnOffSplit will
  break compatibility.

Fix these problems by accepting bool literals for OnOffAuto/OnOffSplit.
This change is specific to OnOffAuto/OnOffSplit; types added in the
future may be defined as an alternate of bool and enum to avoid the
mentioned problems in the first place.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/core/qdev-properties.c | 17 ++++++++++++++++-
 scripts/qapi/visit.py     | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 0b52aad55516099917a4e9b71a920bc3da8a92ec..3462921841db74456284b91374955b6101f03bbc 100644
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
@@ -493,12 +494,26 @@ const PropertyInfo qdev_prop_string = {
 
 /* --- on/off/auto --- */
 
+static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_field_prop_ptr(obj, prop);
+    OnOffAuto value;
+
+    if (!visit_type_OnOffAuto(v, name, &value, errp)) {
+        return;
+    }
+
+    *ptr = value;
+}
+
 const PropertyInfo qdev_prop_on_off_auto = {
     .name = "OnOffAuto",
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
+    .set = set_on_off_auto,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 36e240967b687db10115ba375da3371898b7d95c..5844b64ad6b49a7b88e286dd35ab28b2755282d0 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -205,6 +205,29 @@ def gen_visit_list(name: str, element_type: QAPISchemaType) -> str:
 
 
 def gen_visit_enum(name: str) -> str:
+    if name in ('OnOffAuto', 'OnOffSplit'):
+        return mcgen('''
+
+bool visit_type_%(c_name)s(Visitor *v, const char *name,
+                 %(c_name)s *obj, Error **errp)
+{
+    bool b;
+    int i;
+
+    if (v->type == VISITOR_INPUT && visit_type_bool(v, name, &b, NULL)) {
+        *obj = b ? %(on)s : %(off)s;
+        return true;
+    }
+
+    b = visit_type_enum(v, name, &i, &%(c_name)s_lookup, errp);
+    *obj = i;
+
+    return b;
+}
+''',
+                     c_name=c_name(name),
+                     on=c_enum_const(name, 'on'), off=c_enum_const(name, 'off'))
+
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -355,6 +378,7 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor-impl.h"
 #include "%(visit)s.h"
 #include "%(prefix)sqapi-features.h"
 ''',

-- 
2.48.1


