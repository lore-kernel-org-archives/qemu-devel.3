Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E299C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 05:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgHJU-0007eA-6h; Fri, 07 Feb 2025 00:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgHJS-0007dh-NP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 00:54:02 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgHJQ-0003mc-Bn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 00:54:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f3328f72aso19641805ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 21:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738907638; x=1739512438;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jNbfp+IOewD+Bj2PvTx5EMEMOdfj7eLWaW/M6hpxtsY=;
 b=tEoR1IZFSQ/sScrFU883HW2pnp0B1SULsB/Y67XrP+8WDq3O46AAyeFGO6wiomeuzP
 5GmRxKhEXmOycjLfjhJDoF8TDOkdGMJ55B+k0mpE/MHhpYyjQDdDre5568jPz6zvYGKP
 rHYxIioGYlxuFBjXB342Mw30vl+xG8V7IHYL49wfZhVz51jKwhwwxJw1K2Z+tO4vIGeU
 KtEshcZqy67Y63D4545mcGhx4nEONkQU1hyhfn8f6Jt4yb2kWU0ZodPgcR4pwAI1/4W4
 M5U6+ujOcfhn4g1Sgzh0M65l1SOOGicC+4nluBWxd2ipjO1Yi26ilOoEhSQZ/NYX2xkK
 OKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738907638; x=1739512438;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNbfp+IOewD+Bj2PvTx5EMEMOdfj7eLWaW/M6hpxtsY=;
 b=Ruhd0u+haafwFb5jDF/9T2izyfa3OHzAw7d6bmkKbkUGxAZkBYvjm9Zadz/fFQLa0N
 4Xt/o0JQigkclvOQpFrOrh1FIx+MbekRYSi+gO5x7o2ajckhqCpw1Pp+8iMwiBPL9tDN
 5uZLL1iVwQpX5kgn37GTjqP2WAqQhk4lKEPGxEK0rX5ra8cX9i488czCBgMmS65T2iwN
 C6GoKBwpralJR9lrnr+LAU4EJ1LDSZTrqUcxSC1BJPI+IT3w6kILd8fSGtXHWWfpt9IA
 M+0v8NrebDUFKDtRioWZk6lsepOwGq8e6BQ9ky8A+Upjz//vf8YXU/2z/4VUtpvtvpol
 paiQ==
X-Gm-Message-State: AOJu0YyP9WR6o0ux+f+xsxrlXVdg3s42pcNAhZZF/deDwAIAOVoIr2d4
 hwlZp0Jc0snEhXCOypJIC1dsvQrWdVAgwiiN76hfnDY0Y3LudPZxoQ7fIkXXi5o=
X-Gm-Gg: ASbGncvgle3XRU2vkeIEG6Bu63HZ7lE86a1MGOcqNqYQIzypNnk6akG5r/Xa/FCvBSr
 4IupdhTdIlMb6dwScEjts/+cFMHwuuKlRWtezF3zZsJd/hZRUmjmlWF1mJuBp7Kw1l5GMfJI1bW
 fjY/ErA7DakYu45dqd2x/lwqGLDUnbuuEdNA1efVZruGc4jlaayvPrJ4O+WT20yvB69ppWSpFs5
 sZ+ADO+uGKXUwtn/Q8IqlkQU1J/dx3hkkcaTyQuOoCQAyAp3oACCRW4J9YqWRZnooIALdj7bWzU
 u8z7v1TefOXl9KCqXAQ=
X-Google-Smtp-Source: AGHT+IG491EH9xyurU60ShDpSK45H8jW0ZtDfA6OL4/VcOYocZkyBYR1XkbU5WMYA3duCdxG4q70MQ==
X-Received: by 2002:a05:6a21:2fc7:b0:1e6:b2d7:4cf0 with SMTP id
 adf61e73a8af0-1ee03b66867mr4001174637.41.1738907638026; 
 Thu, 06 Feb 2025 21:53:58 -0800 (PST)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73048bf13d7sm2268286b3a.99.2025.02.06.21.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 21:53:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 14:53:43 +0900
Subject: [PATCH] qom: Use command line syntax for default values in help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-bool-v1-1-5749d5d6df24@daynix.com>
X-B4-Tracking: v=1; b=H4sIAOafpWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNz3aT8/BxdSzNzIzPztBSDRCNTJaDSgqLUtMwKsDHRsbW1AMz8E7l
 WAAAA
X-Change-ID: 20250207-bool-967267fd0a25
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

object_property_help() uses the conventional command line syntax instead
of the JSON syntax. In particular,
- Key-value pairs are written in the command line syntax.
- bool description passed to the function says on/off instead of
  true/false.

However, there is one exception: default values are formatted into JSON.
While the command line and JSON syntaxes are consistent in many cases,
there are two types where they disagree:

string: The command line syntax omits quotes while JSON requires them.

bool: JSON only accepts true/false for bool but the command line syntax
      accepts on/off too, and on/off are also more popular than
      true/false. For example, the docs directory has 2045 "on"
      occurances while it has only 194 "true" occurances.
      on/off are also accepted by OnOffAuto so users do not have to
      remember the type is bool or OnOffAuto to use the values.

Omit quotes for strings and use on/off for bools when formatting
default values for better consistency.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qom/object_interfaces.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1a6f29c053e45bf5da5252f6ac1dfa4e85627f9f..f2450f8099c366864b56940e19c6a4bcc0d5e3a9 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -4,9 +4,11 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qom/object_interfaces.h"
@@ -177,9 +179,25 @@ char *object_property_help(const char *name, const char *type,
         g_string_append(str, description);
     }
     if (defval) {
-        g_autofree char *def_json = g_string_free(qobject_to_json(defval),
-                                                  false);
-        g_string_append_printf(str, " (default: %s)", def_json);
+        g_autofree char *def_json = NULL;
+        const char *def;
+
+        switch (qobject_type(defval)) {
+        case QTYPE_QSTRING:
+            def = qstring_get_str(qobject_to(QString, defval));
+            break;
+
+        case QTYPE_QBOOL:
+            def = qbool_get_bool(qobject_to(QBool, defval)) ? "on" : "off";
+            break;
+
+        default:
+            def_json = g_string_free(qobject_to_json(defval), false);
+            def = def_json;
+            break;
+        }
+
+        g_string_append_printf(str, " (default: %s)", def);
     }
 
     return g_string_free(str, false);

---
base-commit: 7433709a147706ad7d1956b15669279933d0f82b
change-id: 20250207-bool-967267fd0a25

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


