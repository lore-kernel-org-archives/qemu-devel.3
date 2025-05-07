Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E754C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnye-0000eY-1x; Wed, 07 May 2025 19:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyc-0000dg-1S
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyY-00079W-OR
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:57 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b0b2d0b2843so229821a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659693; x=1747264493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmVgZ2T/BR9KDwjoUJTnrLXEqdGiV/GeYJSs5v9aKiI=;
 b=fXmHNQ9nUXJt/3Ai9Da6fTB5b+Jw8UZz7YPehttkWh7TdDu0xNhvgJ40XYFVMa+u8F
 MZnONw04g3Su6CSFbgx+aus65C21k+UCTiX3vfrC58AXYw7xzXQ2SdqmSQxZfn83ZuOx
 4EdA1i8I0uBP4MtNc5ruVPCaOAZaJSwqGF5eKVmQ4wlnFs48yeTke8jLK050OUQtC+IQ
 IDoPRCg1/CWBOTxJkM3AqIDLOGD197orkcUTsRbt2kFrDq0uXge+e07HRwDOep5ujnkT
 StIXJk1NWqtwnYyFHaPWJOdkIq+EbhL1XbFmLywAcZK8CQpYIBLm2exdPoEJyY6OKM52
 HXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659693; x=1747264493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmVgZ2T/BR9KDwjoUJTnrLXEqdGiV/GeYJSs5v9aKiI=;
 b=Twkk7ntKYAlVpIhFO2gZKwEQXd1/9jy/A+S85jD1TVwokOd+ten7owqLmJLg82VNzZ
 w9J36bG062ZKx2IrDJuZ6cSnYa8sndQV0Bn0LpbtVkmis5tzssc1lwIRw/fqDozy2/x/
 vmqv4PlEaNzsDohqZuqmXUG1IFrF+YqX3UrlznDuSXS5Pleg4TKTHHf8BHc9uiujUXkD
 OonuManvNe/JBmRAmpBuhqfjnCWI/T8mXz57YIwFl5umIqa/NCMLBttIU49vIk6nQEcO
 eQZgjUsvlsl/cd81tffe7Q504X4a8CjiFsAwcCLxG+f81mpWqqivwv23aKaNZT6PFUKs
 wdLA==
X-Gm-Message-State: AOJu0YzrcGuEOaph/iKaiFuBJvBEQ2Nl94HXOldcNa85mbBsoZNSaUpw
 +WXAn2/8z14VrSqO+5+e/xDgP304WtjECxchd1buZK75LVtewtVTbXSFI4kBqcH5PjG+vQ61jKr
 dFhgzDA==
X-Gm-Gg: ASbGncvsKtDX3Im4U+txRNlOrIga5/oLZt6VQh0Gk1XUZqCxoUvNM43CZV9t+7E2cdB
 j1w0Y/vD3hy8q8T5qULz0TS39qmb+0WV7I3OPIVqGAFdhIV7nLRNmuukZLi1TL4GmrGYySAZ7Ps
 kPFDdVHkPpyFN5EePVNFBTZi8fP4O5obPTtGBE2tzeBsplwud5hDG4QzGipFxhYxV4pPskms2Lg
 IaNK5L7D8fMEK58jJbOzLReXDyn95XsXvJhjBWqGVro9aCPCzCFma5t1I6eadb3Zp9SxUcKy4Q/
 Q80HKLuBXsWSquVXVHORu8IbK7qbOFW8iF4+IscnKPc2bJtjmtc=
X-Google-Smtp-Source: AGHT+IHiQkgsyoYL4DzZE0SLrS9XsTyACEsADCeyGYuWt88cAb0SIc6NpYgJoAQhy7sy0kOOe74IXw==
X-Received: by 2002:a17:903:22cd:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-22e5ee1d5a3mr77165335ad.48.1746659693218; 
 Wed, 07 May 2025 16:14:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 02/13] qapi/introspect: generate schema as a QObject directly
Date: Wed,  7 May 2025 16:14:32 -0700
Message-ID: <20250507231442.879619-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Instead of defining a const QLitObject, we implement a function to
directly return the QObject associated.

The benefit is that we can now have a non static definition for the
QLitObject, and so we can assign it using non static initializer.
This will be used in next commits to initialize a .hidden field per
element, at runtime.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 monitor/qmp-cmds-control.c              | 2 +-
 tests/unit/test-qobject-input-visitor.c | 6 +++---
 scripts/qapi/introspect.py              | 9 ++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 150ca9f5cb6..1d52d4ca8e9 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -203,7 +203,7 @@ static SchemaInfoList *zap_deprecated(SchemaInfoList *schema)
 
 SchemaInfoList *qmp_query_qmp_schema(Error **errp)
 {
-    QObject *obj = qobject_from_qlit(&qmp_schema_qlit);
+    QObject *obj = qmp_schema_qobject();
     Visitor *v = qobject_input_visitor_new(obj);
     SchemaInfoList *schema = NULL;
 
diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 84bdcdf702e..5d961325f95 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -1184,10 +1184,10 @@ static void test_visitor_in_fail_alternate(TestInputVisitorData *data,
 }
 
 static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *data,
-                                              const QLitObject *qlit)
+                                              QObject *qlit)
 {
     g_autoptr(SchemaInfoList) schema = NULL;
-    QObject *obj = qobject_from_qlit(qlit);
+    QObject *obj = qlit;
     Visitor *v;
 
     v = qobject_input_visitor_new(obj);
@@ -1202,7 +1202,7 @@ static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *data,
 static void test_visitor_in_qmp_introspect(TestInputVisitorData *data,
                                            const void *unused)
 {
-    do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
+    do_test_visitor_in_qmp_introspect(data, test_qmp_schema_qobject());
 }
 
 int main(int argc, char **argv)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 89ee5d5f176..e0269bef0ce 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -193,15 +193,18 @@ def visit_end(self) -> None:
         for typ in self._used_types:
             typ.visit(self)
         # generate C
-        name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
+        name = c_name(self._prefix, protect=False) + 'qmp_schema_qobject'
         self._genh.add(mcgen('''
 #include "qobject/qlit.h"
 
-extern const QLitObject %(c_name)s;
+QObject *%(c_name)s(void);
 ''',
                              c_name=c_name(name)))
         self._genc.add(mcgen('''
-const QLitObject %(c_name)s = %(c_string)s;
+QObject *%(c_name)s(void) {
+    const QLitObject res = %(c_string)s;
+    return qobject_from_qlit(&res);
+}
 ''',
                              c_name=c_name(name),
                              c_string=_tree_to_qlit(self._trees)))
-- 
2.47.2


