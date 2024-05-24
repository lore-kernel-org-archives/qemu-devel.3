Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D939C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 05:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sANbV-0008Cz-KT; Fri, 24 May 2024 01:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbS-0008CG-TA
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbQ-00015A-Ne
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8ea3e9543so449059b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716528987; x=1717133787;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AfvWh15VwJ7bsi1zE22Wn8t3fv0MNqUE1xgb1xRqaAQ=;
 b=mHfKrR1cXZMm2ZZ3ds1WlsFsSYyg0w1Pjv3uzXH45J0EN75t9ReqsmTy6PfyO5S2sC
 4h9zWltjnc/SDcLWqNN7EaWqW2aLxN2HLK2Wd0eVGjK4VhrmRyEKOw8zHxmbNCnF7u0x
 RJVFHu+Mpa8BrJCLQK1h9qMIkoc82BXH1nhnlLmA3CENeh4HB3XZirdWLOfp08cKOyT5
 kWn3MnNwOerQT8obMgUU21t18ooUyb2m8dzVIBl6K9jTkzI72W3on2J1qjNYiM6xQw0P
 oNrXxAA2eI8sIBTFfiJ1ABKbiuOytDxRXjUd6DIiy2xTyc8lRycZKTrvoWYJUyfY1wgQ
 5gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716528987; x=1717133787;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfvWh15VwJ7bsi1zE22Wn8t3fv0MNqUE1xgb1xRqaAQ=;
 b=inn1bmMEWFdSAtLq0a8kELn2MCEhQi3WRUQDhfGQyuUfeIV0EXlXrFRC+lNsQS/Jkr
 ikBcTc1LRtNfDxn7MVo5FBnolVlWLUdgp6VZR5LuAbGCLGkUWH0iKbep9H8T1DzZCeHR
 lytQA8zvtHg9JIJEbZyEC8fRQaYvcitBc4/ap4fuUwJlgR5T50uFC7sLUfSmPogxdLhW
 fUme4CXwm+auMlq5uSV15BIrzqyPfke52L62gNBVFj5aDPjBzSFTQw+Abr6hJHYcUDxV
 BshePkcta1Yz0Zct7yZM74p6Iug4fkKVAuPYK4I90YTnogfEde9LmQzyJumZNGUDzAAF
 hHAQ==
X-Gm-Message-State: AOJu0YwDJrjUrel7EPQDSssQ3vaAAmLFRwQM2sCq7a30HKWKQGgVtwJY
 jdpNvPsktU939NZJkIGCMXK+7hWATvQiVcD7jMN0A7A7mVHHF8xbFNKWnEcs++w=
X-Google-Smtp-Source: AGHT+IFG3fAGmsAARtFqlWWNC2/jCc7tD//SUhB73tK0XCnUrtlh0XI/XihPvDzmS0liqvJzastt7w==
X-Received: by 2002:a05:6a00:8c11:b0:6f0:b53c:dfb4 with SMTP id
 d2e1a72fcca58-6f8f3e7d47emr1398064b3a.22.1716528987279; 
 Thu, 23 May 2024 22:36:27 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-6f8fd4d58easm457201b3a.198.2024.05.23.22.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 22:36:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 May 2024 14:35:49 +0900
Subject: [PATCH v4 3/4] qapi: Do not cast function pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-xkb-v4-3-2de564e5c859@daynix.com>
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
In-Reply-To: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

-fsanitize=undefined complains if function pointers are casted. It
also prevents enabling teh strict mode of CFI which is currently
disabled with -fsanitize-cfi-icall-generalize-pointers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2346
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qapi/clone-visitor.h | 37 ++++++++++++++++++++++++-------------
 qapi/qapi-clone-visitor.c    | 30 ++++--------------------------
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index adf9a788e232..ebc182b034d7 100644
--- a/include/qapi/clone-visitor.h
+++ b/include/qapi/clone-visitor.h
@@ -11,6 +11,7 @@
 #ifndef QAPI_CLONE_VISITOR_H
 #define QAPI_CLONE_VISITOR_H
 
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 
 /*
@@ -20,11 +21,8 @@
  */
 typedef struct QapiCloneVisitor QapiCloneVisitor;
 
-void *qapi_clone(const void *src, bool (*visit_type)(Visitor *, const char *,
-                                                     void **, Error **));
-void qapi_clone_members(void *dst, const void *src, size_t sz,
-                        bool (*visit_type_members)(Visitor *, void *,
-                                                   Error **));
+Visitor *qapi_clone_visitor_new(void);
+Visitor *qapi_clone_members_visitor_new(void);
 
 /*
  * Deep-clone QAPI object @src of the given @type, and return the result.
@@ -32,10 +30,18 @@ void qapi_clone_members(void *dst, const void *src, size_t sz,
  * Not usable on QAPI scalars (integers, strings, enums), nor on a
  * QAPI object that references the 'any' type.  Safe when @src is NULL.
  */
-#define QAPI_CLONE(type, src)                                           \
-    ((type *)qapi_clone(src,                                            \
-                        (bool (*)(Visitor *, const char *, void **,     \
-                                  Error **))visit_type_ ## type))
+#define QAPI_CLONE(type, src)                                   \
+    ({                                                          \
+        Visitor *v_;                                            \
+        type *dst_ = (type *) (src); /* Cast away const */      \
+                                                                \
+        if (dst_) {                                             \
+            v_ = qapi_clone_visitor_new();                      \
+            visit_type_ ## type(v_, NULL, &dst_, &error_abort); \
+            visit_free(v_);                                     \
+        }                                                       \
+        dst_;                                                   \
+    })
 
 /*
  * Copy deep clones of @type members from @src to @dst.
@@ -43,9 +49,14 @@ void qapi_clone_members(void *dst, const void *src, size_t sz,
  * Not usable on QAPI scalars (integers, strings, enums), nor on a
  * QAPI object that references the 'any' type.
  */
-#define QAPI_CLONE_MEMBERS(type, dst, src)                              \
-    qapi_clone_members(dst, src, sizeof(type),                          \
-                       (bool (*)(Visitor *, void *,                     \
-                                 Error **))visit_type_ ## type ## _members)
+#define QAPI_CLONE_MEMBERS(type, dst, src)                                \
+    ({                                                                    \
+        Visitor *v_;                                                      \
+                                                                          \
+        v_ = qapi_clone_members_visitor_new();                            \
+        *(type *)(dst) = *(src);                                          \
+        visit_type_ ## type ## _members(v_, (type *)(dst), &error_abort); \
+        visit_free(v_);                                                   \
+    })
 
 #endif
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index c45c5caa3b89..bbf953698f38 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -149,7 +149,7 @@ static void qapi_clone_free(Visitor *v)
     g_free(v);
 }
 
-static Visitor *qapi_clone_visitor_new(void)
+Visitor *qapi_clone_visitor_new(void)
 {
     QapiCloneVisitor *v;
 
@@ -174,31 +174,9 @@ static Visitor *qapi_clone_visitor_new(void)
     return &v->visitor;
 }
 
-void *qapi_clone(const void *src, bool (*visit_type)(Visitor *, const char *,
-                                                     void **, Error **))
+Visitor *qapi_clone_members_visitor_new(void)
 {
-    Visitor *v;
-    void *dst = (void *) src; /* Cast away const */
-
-    if (!src) {
-        return NULL;
-    }
-
-    v = qapi_clone_visitor_new();
-    visit_type(v, NULL, &dst, &error_abort);
-    visit_free(v);
-    return dst;
-}
-
-void qapi_clone_members(void *dst, const void *src, size_t sz,
-                        bool (*visit_type_members)(Visitor *, void *,
-                                                   Error **))
-{
-    Visitor *v;
-
-    v = qapi_clone_visitor_new();
-    memcpy(dst, src, sz);
+    Visitor *v = qapi_clone_visitor_new();
     to_qcv(v)->depth++;
-    visit_type_members(v, dst, &error_abort);
-    visit_free(v);
+    return v;
 }

-- 
2.45.1


