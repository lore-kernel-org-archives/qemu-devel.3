Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7560BC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 07:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfcm-0005zH-HZ; Sat, 08 Feb 2025 02:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcl-0005yt-3H
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:35 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcj-0007Vu-FE
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:34 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso70012605ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 23:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739001092; x=1739605892;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xJPqyACVWuy+f95M2UxICBXYp3QYbJ6h2gyeOOlBE4s=;
 b=OfpFnJoeD5GsgGstYowUTLncEqupk25y3AEg+5oQ2KBdxdz8lyNl7YdSGe7EBS5TTk
 P0d7170HftmJR2ObooBkPL5BtjJo5jp2X1+iqX8CALyOxFzEFMGsquROgPOwfwB195L6
 yajHWjKIJ5ApIqnSEZ5fFvJq5Pzak612kVK0To4k6PtxMOV1WqXhMohT/rd5z+8/ayxv
 k0riY5LjMu/dKAhcoyw4zhmm9k6i8CyGPwLrgRx7E9e8duAE74ZdSWKphtfkDfrPz/ma
 Ux6blGzUIv3k4hHogY5rGOqY99T5jUaaIMkwx7pO3QkhG9v4dmhlWNP5v98EKUQXrR+n
 gM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739001092; x=1739605892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJPqyACVWuy+f95M2UxICBXYp3QYbJ6h2gyeOOlBE4s=;
 b=TGbM9BCdJ0ewk2sBz8mm2WiwC011QC7ZnBLeDiZoPVLoW+hKn3sG5j/KQGL3ZGr3Hu
 eS3DWLOVFo8XEy1iGqXgrdth3gCRMUImZ/4M3KsO0Hfo57NutwwJbK2NLYExftRQXoFB
 fiM2k4FDWPGdlfc0HxItRRhSwxW1RJ/OclfmOzwXmcYnagWvoqlhsSEKKsrecaFhfYCG
 G3Qn1ZEdNHrvHAnFN6gx6YZjtthdMNRUFGz/vIk8WebKs3fS4GTwHhDrrUI9B68ZaL/n
 gKhJsZdbFJltutkQgod55CrWeLrXiaUPqQuXTkz1Op4EWJ83hQnK3ABhE+em3nEL1LfX
 sG5Q==
X-Gm-Message-State: AOJu0YwFhKoOD7iSXdY+exn4UlGqheY16I4+eIYpoGS4qWbSLFe+gOcw
 9WcvuRHhZs0aVP0FwdPBJ67PJkmvurp991cd7A75tVAvjWv9mqUKW64fZKNYYb4=
X-Gm-Gg: ASbGncvTObqLfsEmpB7Gj93tv6UB2qCHaIAGb9gQmOJG/ji5DYzVfjV5Ya7u69CMuu9
 VMQCvTDTVDBQh4qrQqLSfsmCrj9vvdumn3V/McazL3aXlPzvsITRYTtkLlCKgVqCbWCQNVutdjK
 lOHV3IaMzhPuYHPdePUXq1yjIayoqEG/BdlDZtRZgaI5ajjCrD4IHUBREXsEkKu9Ok7N5vUfTnk
 T3114UeZYJsdMOxP+f+cL/BQq3Olt67sv9emcPP5hsRoez64VeH5dClNd0laBkNv8T7/IHSr09Y
 o+06FceGO63g76i4Rd8=
X-Google-Smtp-Source: AGHT+IHlCnrLQEnc4bz1UYyArmKAbb0ibEPs/DkUUG+6WboIMattskGZZmvy/vF8M4qY43vnNeQENg==
X-Received: by 2002:a05:6a21:458a:b0:1e1:3970:d75a with SMTP id
 adf61e73a8af0-1ee03a21d7fmr11713144637.9.1739001091923; 
 Fri, 07 Feb 2025 23:51:31 -0800 (PST)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73048a9d063sm4156905b3a.34.2025.02.07.23.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 23:51:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 08 Feb 2025 16:51:08 +0900
Subject: [PATCH v5 2/4] qapi: Accept bool for OnOffAuto and OnOffSplit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-virtio-v5-2-4376cb218c0f@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
index 434a76f5036edd2091a9c79525b8e102582637be..073902431213c5be47197cb0d993d60cc2562501 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,6 +2,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-visit-common.h"
 #include "qapi/qmp/qlist.h"
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
index 12f92e429f6bafc091f74af88c1b837d08c7f733..221373b165aa95bceb4eb50a557edf0e5b4c01f7 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -209,6 +209,29 @@ def gen_visit_list(name: str, element_type: QAPISchemaType) -> str:
 
 
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
@@ -359,6 +382,7 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor-impl.h"
 #include "%(visit)s.h"
 ''',
                                       visit=visit))

-- 
2.48.1


