Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784ADC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGyH-00059F-MA; Wed, 29 May 2024 06:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGyA-00051m-Bq
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGy8-0003NC-5b
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwF1CZkVPFaoB5L1KcjdmzvRfscLRg1sRwCs33bG7lg=;
 b=YmwmkT7B6ldSnSJhGLTej55yf0hnZoa3hiRGUCYADNq5nrcL94e4+PT1XlX4Px167cLPAP
 IsGsyxfdoZoMchnADSKl2yhjcGqK9e+AaNYFhzAYwixj9zRrdoDT4iaBO3Q653jSv5XIOL
 VIJKLYLDy1BAyjPMZmnsJeIT6/lH9Fw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-NhYlMHQzN1KEbm9BpAXH7A-1; Wed,
 29 May 2024 06:55:39 -0400
X-MC-Unique: NhYlMHQzN1KEbm9BpAXH7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5897C3806701;
 Wed, 29 May 2024 10:55:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 712FF105480A;
 Wed, 29 May 2024 10:55:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 22/22] qapi: Do not cast function pointers
Date: Wed, 29 May 2024 12:54:54 +0200
Message-ID: <20240529105454.1149225-23-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Using -fsanitize=undefined with Clang v18 causes an error if function
pointers are casted:

 qapi/qapi-clone-visitor.c:188:5: runtime error: call to function visit_type_SocketAddress through pointer to incorrect function type 'bool (*)(struct Visitor *, const char *, void **, struct Error **)'
 /tmp/qemu-ubsan/qapi/qapi-visit-sockets.c:487: note: visit_type_SocketAddress defined here
     #0 0x5642aa2f7f3b in qapi_clone qapi/qapi-clone-visitor.c:188:5
     #1 0x5642aa2c8ce5 in qio_channel_socket_listen_async io/channel-socket.c:285:18
     #2 0x5642aa2b8903 in test_io_channel_setup_async tests/unit/test-io-channel-socket.c:116:5
     #3 0x5642aa2b8204 in test_io_channel tests/unit/test-io-channel-socket.c:179:9
     #4 0x5642aa2b8129 in test_io_channel_ipv4 tests/unit/test-io-channel-socket.c:323:5
     ...

It also prevents enabling the strict mode of CFI which is currently
disabled with -fsanitize-cfi-icall-generalize-pointers.

The problematic casts are necessary to pass visit_type_T() and
visit_type_T_members() as callbacks to qapi_clone() and qapi_clone_members(),
respectively. Open-code these two functions to avoid the callbacks, and
thus the type casts.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2346
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240524-xkb-v4-3-2de564e5c859@daynix.com>
[thuth: Improve commit message according to Markus' suggestions]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qapi/clone-visitor.h | 37 +++++++++++++++++++++++-------------
 qapi/qapi-clone-visitor.c    | 30 ++++-------------------------
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/include/qapi/clone-visitor.h b/include/qapi/clone-visitor.h
index adf9a788e2..ebc182b034 100644
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
index c45c5caa3b..bbf953698f 100644
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


