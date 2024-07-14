Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA70C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 07:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sStyj-0004pA-4z; Sun, 14 Jul 2024 03:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyh-0004nZ-Lj
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:03 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sStyf-0007eC-GJ
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 03:49:03 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-65fcf21002dso7360547b3.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720943340; x=1721548140;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iUYzEcnP1I3fIISMCAmJ4EzGqqLnO8BreYmG+l4tYic=;
 b=Z2Jov9x9rpGDWYiHFF1fw8HhoEmjHsY1ww3//FhMiaYG34jTTKihJePhRbSmO5VnVu
 V2dYJwzl+BfGRZb6f/ZbpFSd/SRZ9vyT2jTGn+FuQ2uZLVo/4Q0lszBBSTF6VsVFaYPR
 dcYk82cINhlJ6D9s7iPRCniNodOLoGlJf9EaAthWQo5AY+34HrsXm0gFBDQR7h+rKTIo
 LSDoYMKbKIdDtnVWaTCd90YP3PGbih1jJvC/9OJR9zLHDRm1EiPR+pjq+s0IsJZ/g9/W
 DMhLa6r+0Unf9Trz9lNk1n5mLjgWz3bue3JzbVyWhbhnSOLNgUETy/QMrZXg8DeM/JK6
 bwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720943340; x=1721548140;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUYzEcnP1I3fIISMCAmJ4EzGqqLnO8BreYmG+l4tYic=;
 b=SRsyQVBCPha23QX8jMyY05fykuU8yXRc1fTvNRVJPbzIaEuAaSZ+8zkOCVpUWuqM90
 pSOgo7YB8HyJN11kjlTirfFX4O0PRWa3yHhf6rQJipHUBnHQvqhaqUGXa7fhXzNyhck5
 ehXtSHelgV5UA4fEtitBPf8wLGb76ncVfrf78kJbou7Oje/Y/EEbK0A8eofFtgvAmdBL
 AUS1rBUdNk9tpshfdWOe0nR+WUH2Pe1sCdDezG+rlyiygteO/PQSQcTh0TlJKiI1sLNc
 FkHoblt7l/WQX/bi/Xw36M7Fxo3fwRhzoo/fcsbWiqx/5F7KAccmcu4ieb5q2aYMAPeB
 kmHA==
X-Gm-Message-State: AOJu0Yy8NOq2fDQphki0ec18QZSzzxR+tOwHHQU5KrBi1vZK7ySDaZYd
 CgOZCNvM0hwzHAkbxBUXirugV6Fn5nYRF2tQ08f+laHcyXF731TFVeZAH5BEwbI=
X-Google-Smtp-Source: AGHT+IFNp1jWibAMstpywqXLVPrejfhRCh/jR56Yu0Dt2JQlfBIxoJST+P3jhnoPzndVVDaRJCCLFw==
X-Received: by 2002:a05:690c:7442:b0:64b:9f5f:67b2 with SMTP id
 00721157ae682-658ef24c009mr194049447b3.31.1720943340142; 
 Sun, 14 Jul 2024 00:49:00 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ebb66b8sm2199455b3a.52.2024.07.14.00.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 00:48:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 16:48:31 +0900
Subject: [PATCH v2 1/4] qapi: Add visit_type_str_preserving()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-rombar-v2-1-af1504ef55de@daynix.com>
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
In-Reply-To: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::112b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yw1-x112b.google.com
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

visit_type_str_preserving() is mostly indentical with visit_type_str()
but leaves the value intact. This is useful when the caller may
interpret the value with a different type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qapi/visitor-impl.h   |  3 ++-
 include/qapi/visitor.h        | 20 ++++++++++++++++++++
 qapi/opts-visitor.c           |  7 +++++--
 qapi/qapi-clone-visitor.c     |  2 +-
 qapi/qapi-dealloc-visitor.c   |  4 ++--
 qapi/qapi-forward-visitor.c   |  4 +++-
 qapi/qapi-visit-core.c        | 17 +++++++++++++++--
 qapi/qobject-input-visitor.c  | 23 ++++++++++++-----------
 qapi/qobject-output-visitor.c |  2 +-
 qapi/string-input-visitor.c   |  2 +-
 qapi/string-output-visitor.c  |  2 +-
 11 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 2badec5ba460..7b61f55995b5 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -95,7 +95,8 @@ struct Visitor
     bool (*type_bool)(Visitor *v, const char *name, bool *obj, Error **errp);
 
     /* Must be set */
-    bool (*type_str)(Visitor *v, const char *name, char **obj, Error **errp);
+    bool (*type_str)(Visitor *v, const char *name, char **obj, bool consume,
+                     Error **errp);
 
     /* Must be set to visit numbers */
     bool (*type_number)(Visitor *v, const char *name, double *obj,
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 27b85d4700f2..b3ae3188edfb 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -654,6 +654,26 @@ bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp);
  */
 bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp);
 
+/*
+ * Visit a string value but do not consume it.
+ *
+ * @name expresses the relationship of this string to its parent
+ * container; see the general description of @name above.
+ *
+ * @obj must be non-NULL.  Input and clone visitors set *@obj to the
+ * value (always using "" rather than NULL for an empty string).
+ * Other visitors leave *@obj unchanged, and commonly treat NULL like
+ * "".
+ *
+ * This function must be called only with an input visitor.
+ *
+ * This is mostly identical with visit_type_str() but leaves the value intact.
+ * This is useful when the caller may interpret the value with a different
+ * type.
+ */
+bool visit_type_str_preserving(Visitor *v, const char *name, char **obj,
+                               Error **errp);
+
 /*
  * Visit a number (i.e. double) value.
  *
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 3d1a28b41918..e9fad756e189 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -347,7 +347,8 @@ processed(OptsVisitor *ov, const char *name)
 
 
 static bool
-opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
+opts_type_str(Visitor *v, const char *name, char **obj, bool consume,
+              Error **errp)
 {
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
@@ -363,7 +364,9 @@ opts_type_str(Visitor *v, const char *name, char **obj, Error **errp)
      * valid enum value; this is harmless because tracking what gets
      * consumed only matters to visit_end_struct() as the final error
      * check if there were no other failures during the visit.  */
-    processed(ov, name);
+    if (consume) {
+        processed(ov, name);
+    }
     return true;
 }
 
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index bbf953698f38..90e6641835a7 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -108,7 +108,7 @@ static bool qapi_clone_type_bool(Visitor *v, const char *name, bool *obj,
 }
 
 static bool qapi_clone_type_str(Visitor *v, const char *name, char **obj,
-                                Error **errp)
+                                bool consume, Error **errp)
 {
     QapiCloneVisitor *qcv = to_qcv(v);
 
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index ef283f296601..6b0f957047d5 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -62,9 +62,9 @@ static void qapi_dealloc_end_list(Visitor *v, void **obj)
 }
 
 static bool qapi_dealloc_type_str(Visitor *v, const char *name, char **obj,
-                                  Error **errp)
+                                  bool consume, Error **errp)
 {
-    if (obj) {
+    if (obj && consume) {
         g_free(*obj);
     }
     return true;
diff --git a/qapi/qapi-forward-visitor.c b/qapi/qapi-forward-visitor.c
index e36d9bc9ba7e..891282e0c3b3 100644
--- a/qapi/qapi-forward-visitor.c
+++ b/qapi/qapi-forward-visitor.c
@@ -180,6 +180,7 @@ static bool forward_field_type_bool(Visitor *v, const char *name, bool *obj,
 }
 
 static bool forward_field_type_str(Visitor *v, const char *name, char **obj,
+                                   bool consume,
                                    Error **errp)
 {
     ForwardFieldVisitor *ffv = to_ffv(v);
@@ -187,7 +188,8 @@ static bool forward_field_type_str(Visitor *v, const char *name, char **obj,
     if (!forward_field_translate_name(ffv, &name, errp)) {
         return false;
     }
-    return visit_type_str(ffv->target, name, obj, errp);
+    return (consume ? visit_type_str : visit_type_str_preserving)(
+        ffv->target, name, obj, errp);
 }
 
 static bool forward_field_type_size(Visitor *v, const char *name, uint64_t *obj,
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 6c13510a2bc7..89b52fc99202 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -336,7 +336,8 @@ bool visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
     return v->type_bool(v, name, obj, errp);
 }
 
-bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
+static bool visit_type_str_common(Visitor *v, const char *name, char **obj,
+                                  bool consume, Error **errp)
 {
     bool ok;
 
@@ -346,13 +347,25 @@ bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
     assert(!(v->type & VISITOR_OUTPUT) || *obj);
      */
     trace_visit_type_str(v, name, obj);
-    ok = v->type_str(v, name, obj, errp);
+    ok = v->type_str(v, name, obj, consume, errp);
     if (v->type & VISITOR_INPUT) {
         assert(ok != !*obj);
     }
     return ok;
 }
 
+bool visit_type_str(Visitor *v, const char *name, char **obj, Error **errp)
+{
+    return visit_type_str_common(v, name, obj, true, errp);
+}
+
+bool visit_type_str_preserving(Visitor *v, const char *name, char **obj,
+                               Error **errp)
+{
+    assert(v->type & VISITOR_INPUT);
+    return visit_type_str_common(v, name, obj, false, errp);
+}
+
 bool visit_type_number(Visitor *v, const char *name, double *obj,
                        Error **errp)
 {
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f110a804b2ae..facbbf01bd27 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -174,13 +174,13 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
 }
 
 static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
-                                            const char *name,
+                                            const char *name, bool consume,
                                             Error **errp)
 {
     QObject *qobj;
     QString *qstr;
 
-    qobj = qobject_input_get_object(qiv, name, true, errp);
+    qobj = qobject_input_get_object(qiv, name, consume, errp);
     if (!qobj) {
         return NULL;
     }
@@ -416,7 +416,7 @@ static bool qobject_input_type_int64_keyval(Visitor *v, const char *name,
                                             int64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    const char *str = qobject_input_get_keyval(qiv, name, errp);
+    const char *str = qobject_input_get_keyval(qiv, name, true, errp);
 
     if (!str) {
         return false;
@@ -467,7 +467,7 @@ static bool qobject_input_type_uint64_keyval(Visitor *v, const char *name,
                                              uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    const char *str = qobject_input_get_keyval(qiv, name, errp);
+    const char *str = qobject_input_get_keyval(qiv, name, true, errp);
 
     if (!str) {
         return false;
@@ -507,7 +507,7 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
                                            bool *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    const char *str = qobject_input_get_keyval(qiv, name, errp);
+    const char *str = qobject_input_get_keyval(qiv, name, true, errp);
 
     if (!str) {
         return false;
@@ -522,10 +522,10 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
 }
 
 static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
-                                   Error **errp)
+                                   bool consume, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, consume, errp);
     QString *qstr;
 
     *obj = NULL;
@@ -544,10 +544,11 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
 }
 
 static bool qobject_input_type_str_keyval(Visitor *v, const char *name,
-                                          char **obj, Error **errp)
+                                          char **obj, bool consume,
+                                          Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    const char *str = qobject_input_get_keyval(qiv, name, errp);
+    const char *str = qobject_input_get_keyval(qiv, name, consume, errp);
 
     *obj = g_strdup(str);
     return !!str;
@@ -578,7 +579,7 @@ static bool qobject_input_type_number_keyval(Visitor *v, const char *name,
                                              double *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    const char *str = qobject_input_get_keyval(qiv, name, errp);
+    const char *str = qobject_input_get_keyval(qiv, name, true, errp);
     double val;
 
     if (!str) {
@@ -635,7 +636,7 @@ static bool qobject_input_type_size_keyval(Visitor *v, const char *name,
                                            uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    const char *str = qobject_input_get_keyval(qiv, name, errp);
+    const char *str = qobject_input_get_keyval(qiv, name, true, errp);
 
     if (!str) {
         return false;
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 74770edd73c6..36a9fc245b79 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -173,7 +173,7 @@ static bool qobject_output_type_bool(Visitor *v, const char *name, bool *obj,
 }
 
 static bool qobject_output_type_str(Visitor *v, const char *name, char **obj,
-                                    Error **errp)
+                                    bool consume, Error **errp)
 {
     QObjectOutputVisitor *qov = to_qov(v);
     if (*obj) {
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 3f1b9e9b4137..6562bbe3cfd4 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -336,7 +336,7 @@ static bool parse_type_bool(Visitor *v, const char *name, bool *obj,
 }
 
 static bool parse_type_str(Visitor *v, const char *name, char **obj,
-                           Error **errp)
+                           bool consume, Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
 
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 5115536b1539..9a8cca0d5c68 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -269,7 +269,7 @@ static bool print_type_bool(Visitor *v, const char *name, bool *obj,
 }
 
 static bool print_type_str(Visitor *v, const char *name, char **obj,
-                           Error **errp)
+                           bool consume, Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
     char *out;

-- 
2.45.2


