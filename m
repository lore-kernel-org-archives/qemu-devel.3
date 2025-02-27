Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CEEC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekC-0006nE-UT; Thu, 27 Feb 2025 09:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnek9-0006h2-Ik
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnek5-0003TF-E4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740665999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=016GiMgPCDCxH4pGbauqv5pOlfa+t27Nzdjf4IvZ1wM=;
 b=NIEd3X8JA7vak89kixpWJSuSjCcUekhwR3jA17aDC8t7L/RW0Wip8hM9uyuxc5A6yueZ9p
 pX+Amg4PjwVNY9VfhsGJySrkn2UOa8wT2XA5DFMzoVwOFXGNvO3VKk2Y+gBiUyN+4KiNwI
 WptaVgshzKZah9s0OQxt6wY/ecMiJAc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-jB1P_j1OPVWp6v7kCFiAGA-1; Thu, 27 Feb 2025 09:19:58 -0500
X-MC-Unique: jB1P_j1OPVWp6v7kCFiAGA-1
X-Mimecast-MFC-AGG-ID: jB1P_j1OPVWp6v7kCFiAGA_1740665997
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abbae81829fso114065966b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665996; x=1741270796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=016GiMgPCDCxH4pGbauqv5pOlfa+t27Nzdjf4IvZ1wM=;
 b=OF6QWIdqEEHYPHWFfhA0Ho/etaw+1r6VcD9cQ5fYx9oTXd9a+6JuU2e2ZobU5X7P1+
 69GzpS1aQeqEo8DBNPIhwNt3wjwAqJ4tCxofZq0c8KP+kXbuQRMGBtJBsK7rtpplGNA6
 abch2DuTWV0GTLSynnppgkObYKowE+229YczKFNLvFj9zDE8O0RT4u4O18dN3KrhoTs7
 8mZetO5hd6f+w/tcJsxhC7j6ZBNhW8Eoum9H5Oxn3gdmKUvfVGPatfBNGaqDTntHVwte
 pxBZFImpml1nqNHeMCcdL3wo2pEUwYcwAT3Zf0cTOfvK1Chsu1VQr3W+sHXXXbkxjns9
 MfHg==
X-Gm-Message-State: AOJu0YyB7UCoWhIpoektzvK/Obkl8vsjhpa7hVPupzQnxEXDjsGRkJ5p
 2PGw/u0oa8u69mO62ntaoOADleJF/WXEsWb+UCvnqS8lcZpEBzGzlihTcfYW2Ck9plBKfjeHPx2
 hy25viC6BMQ8IV/1POFLJKy2Uko5G8gF6FVlQdvVGYw2oVpjqiKHvBzTYILUvo4d9ZKJnqWV4he
 QU4XOJvnMZSSXTLOz77kW19an5noINqalqY7xcnzk=
X-Gm-Gg: ASbGncsGHkMJjAiQq3mBD4fe69kyNRTI0aRPQMC4sOnC6LFw/qXFezDp7Op0UZIC27Y
 bEBz5rz+JdfvyaCUvVQ48s09+gYF0jR+uZjBCl9tYUA/Ww07EEiT4tIk1ANDpGvLa51dtmfRxCI
 /PC5g1Mq3h4m1hFtPd1VkYF+5QFqD+1sbKRWCIIskXWwCZ8iGlYx33degY+PXOJ/Z4dD/zWoxWg
 Sp67IMweMyLO1SFVGNhwLmDd9uVnsY9Arg7nPI75dCUNg+0ohTic8CotUboX+AdyRjnSrTLrR8N
 l99GmiKcKCOkFSRwSbHC
X-Received: by 2002:a17:906:3109:b0:aa6:7091:1e91 with SMTP id
 a640c23a62f3a-abed0c66947mr1240880666b.11.1740665995727; 
 Thu, 27 Feb 2025 06:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP/XSbmvFTNNThmAOiFlW/7Pija0uKgDmKhE89+TZfCvGl0FL/GGGOnlXiMjRl0FuK80btxA==
X-Received: by 2002:a17:906:3109:b0:aa6:7091:1e91 with SMTP id
 a640c23a62f3a-abed0c66947mr1240878666b.11.1740665995200; 
 Thu, 27 Feb 2025 06:19:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dcb12sm129184566b.74.2025.02.27.06.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:19:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 01/34] qom: Use command line syntax for default values in help
Date: Thu, 27 Feb 2025 15:19:19 +0100
Message-ID: <20250227141952.811410-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Link: https://lore.kernel.org/r/20250207-bool-v1-1-5749d5d6df24@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object_interfaces.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index f35d3313317..1ffea1a7288 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -4,9 +4,11 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-qom.h"
 #include "qobject/qobject.h"
+#include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qobject/qjson.h"
+#include "qobject/qstring.h"
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
-- 
2.48.1


