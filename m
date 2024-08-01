Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AE6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5N-0001YJ-MR; Thu, 01 Aug 2024 13:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5L-0001Ww-G0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5J-0005tv-Du
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7HvUIXAXJn9znDcZm8ZI4f/9vM4z7F+XF2q7bM5v1w=;
 b=L6sxR1EC0ieYRu9H6s8whTIJJPGR9Yi/fwISXIkkzvoByTnXV+j9ZwVb8Fvc4kM2B4DPdd
 Y1vbEptNZOHhuBy1Q7XZV2fyBcP3LbW3EG/6GPLeJkw2JV0cvjUjl5xQmbBI1XibuzDzEb
 4TTtzoDPKpTkkymn3/sATjVcPiam1qI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-z1ZogPgzPkGsb_dUIKAiLw-1; Thu,
 01 Aug 2024 13:59:21 -0400
X-MC-Unique: z1ZogPgzPkGsb_dUIKAiLw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B950319560A2; Thu,  1 Aug 2024 17:59:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED9B119560AA; Thu,  1 Aug 2024 17:59:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/6] qapi: change 'unsigned special_features' to 'uint64_t
 features'
Date: Thu,  1 Aug 2024 18:59:08 +0100
Message-ID: <20240801175913.669013-2-berrange@redhat.com>
In-Reply-To: <20240801175913.669013-1-berrange@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The "special_features" field / parameter holds the subset of schema
features that are for internal code use. Specifically 'DEPRECATED'
and 'UNSTABLE'.

This special casing of internal features is going to be removed, so
prepare for that by renaming to 'features'. Using a fixed size type
is also best practice for bit fields.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/compat-policy.h  |  2 +-
 include/qapi/qmp/dispatch.h   |  4 ++--
 include/qapi/util.h           |  4 ++--
 include/qapi/visitor-impl.h   |  4 ++--
 include/qapi/visitor.h        | 12 ++++++------
 qapi/qapi-forward-visitor.c   |  8 ++++----
 qapi/qapi-util.c              |  6 +++---
 qapi/qapi-visit-core.c        | 12 ++++++------
 qapi/qmp-dispatch.c           |  2 +-
 qapi/qmp-registry.c           |  4 ++--
 qapi/qobject-input-visitor.c  |  4 ++--
 qapi/qobject-output-visitor.c |  6 +++---
 scripts/qapi/types.py         |  2 +-
 13 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index 8b7b25c0b5..ea65e10744 100644
--- a/include/qapi/compat-policy.h
+++ b/include/qapi/compat-policy.h
@@ -18,7 +18,7 @@
 
 extern CompatPolicy compat_policy;
 
-bool compat_policy_input_ok(unsigned special_features,
+bool compat_policy_input_ok(uint64_t features,
                             const CompatPolicy *policy,
                             ErrorClass error_class,
                             const char *kind, const char *name,
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index f2e956813a..e0ee1ad3ac 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -33,7 +33,7 @@ typedef struct QmpCommand
     /* Runs in coroutine context if QCO_COROUTINE is set */
     QmpCommandFunc *fn;
     QmpCommandOptions options;
-    unsigned special_features;
+    uint64_t features;
     QTAILQ_ENTRY(QmpCommand) node;
     bool enabled;
     const char *disable_reason;
@@ -43,7 +43,7 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
 
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options,
-                          unsigned special_features);
+                          uint64_t features);
 const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
                                    const char *name);
 void qmp_disable_command(QmpCommandList *cmds, const char *name,
diff --git a/include/qapi/util.h b/include/qapi/util.h
index b8254247b8..b377cb9c70 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -14,11 +14,11 @@
 typedef enum {
     QAPI_DEPRECATED,
     QAPI_UNSTABLE,
-} QapiSpecialFeature;
+} QapiFeature;
 
 typedef struct QEnumLookup {
     const char *const *array;
-    const unsigned char *const special_features;
+    const uint64_t *const features;
     const int size;
 } QEnumLookup;
 
diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 2badec5ba4..7beb0dbfa5 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -115,11 +115,11 @@ struct Visitor
 
     /* Optional */
     bool (*policy_reject)(Visitor *v, const char *name,
-                          unsigned special_features, Error **errp);
+                          uint64_t features, Error **errp);
 
     /* Optional */
     bool (*policy_skip)(Visitor *v, const char *name,
-                        unsigned special_features);
+                        uint64_t features);
 
     /* Must be set */
     VisitorType type;
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 27b85d4700..f6a9b0743f 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -463,29 +463,29 @@ bool visit_optional(Visitor *v, const char *name, bool *present);
 /*
  * Should we reject member @name due to policy?
  *
- * @special_features is the member's special features encoded as a
- * bitset of QapiSpecialFeature.
+ * @features is the member's special features encoded as a
+ * bitset of QapiFeature.
  *
  * @name must not be NULL.  This function is only useful between
  * visit_start_struct() and visit_end_struct(), since only objects
  * have deprecated members.
  */
 bool visit_policy_reject(Visitor *v, const char *name,
-                         unsigned special_features, Error **errp);
+                         uint64_t features, Error **errp);
 
 /*
  *
  * Should we skip member @name due to policy?
  *
- * @special_features is the member's special features encoded as a
- * bitset of QapiSpecialFeature.
+ * @features is the member's special features encoded as a
+ * bitset of QapiFeature.
  *
  * @name must not be NULL.  This function is only useful between
  * visit_start_struct() and visit_end_struct(), since only objects
  * have deprecated members.
  */
 bool visit_policy_skip(Visitor *v, const char *name,
-                       unsigned special_features);
+                       uint64_t features);
 
 /*
  * Set policy for handling deprecated management interfaces.
diff --git a/qapi/qapi-forward-visitor.c b/qapi/qapi-forward-visitor.c
index e36d9bc9ba..6e9a784a9f 100644
--- a/qapi/qapi-forward-visitor.c
+++ b/qapi/qapi-forward-visitor.c
@@ -246,7 +246,7 @@ static void forward_field_optional(Visitor *v, const char *name, bool *present)
 }
 
 static bool forward_field_policy_reject(Visitor *v, const char *name,
-                                        unsigned special_features,
+                                        uint64_t features,
                                         Error **errp)
 {
     ForwardFieldVisitor *ffv = to_ffv(v);
@@ -254,18 +254,18 @@ static bool forward_field_policy_reject(Visitor *v, const char *name,
     if (!forward_field_translate_name(ffv, &name, errp)) {
         return true;
     }
-    return visit_policy_reject(ffv->target, name, special_features, errp);
+    return visit_policy_reject(ffv->target, name, features, errp);
 }
 
 static bool forward_field_policy_skip(Visitor *v, const char *name,
-                                      unsigned special_features)
+                                      uint64_t features)
 {
     ForwardFieldVisitor *ffv = to_ffv(v);
 
     if (!forward_field_translate_name(ffv, &name, NULL)) {
         return true;
     }
-    return visit_policy_skip(ffv->target, name, special_features);
+    return visit_policy_skip(ffv->target, name, features);
 }
 
 static void forward_field_complete(Visitor *v, void *opaque)
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 65a7d18437..3d849fe034 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -37,19 +37,19 @@ static bool compat_policy_input_ok1(const char *adjective,
     }
 }
 
-bool compat_policy_input_ok(unsigned special_features,
+bool compat_policy_input_ok(uint64_t features,
                             const CompatPolicy *policy,
                             ErrorClass error_class,
                             const char *kind, const char *name,
                             Error **errp)
 {
-    if ((special_features & 1u << QAPI_DEPRECATED)
+    if ((features & 1u << QAPI_DEPRECATED)
         && !compat_policy_input_ok1("Deprecated",
                                     policy->deprecated_input,
                                     error_class, kind, name, errp)) {
         return false;
     }
-    if ((special_features & (1u << QAPI_UNSTABLE))
+    if ((features & (1u << QAPI_UNSTABLE))
         && !compat_policy_input_ok1("Unstable",
                                     policy->unstable_input,
                                     error_class, kind, name, errp)) {
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 6c13510a2b..706c61e026 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -141,21 +141,21 @@ bool visit_optional(Visitor *v, const char *name, bool *present)
 }
 
 bool visit_policy_reject(Visitor *v, const char *name,
-                         unsigned special_features, Error **errp)
+                         uint64_t features, Error **errp)
 {
     trace_visit_policy_reject(v, name);
     if (v->policy_reject) {
-        return v->policy_reject(v, name, special_features, errp);
+        return v->policy_reject(v, name, features, errp);
     }
     return false;
 }
 
 bool visit_policy_skip(Visitor *v, const char *name,
-                       unsigned special_features)
+                       uint64_t features)
 {
     trace_visit_policy_skip(v, name);
     if (v->policy_skip) {
-        return v->policy_skip(v, name, special_features);
+        return v->policy_skip(v, name, features);
     }
     return false;
 }
@@ -409,8 +409,8 @@ static bool input_type_enum(Visitor *v, const char *name, int *obj,
         return false;
     }
 
-    if (lookup->special_features
-        && !compat_policy_input_ok(lookup->special_features[value],
+    if (lookup->features
+        && !compat_policy_input_ok(lookup->features[value],
                                    &v->compat_policy,
                                    ERROR_CLASS_GENERIC_ERROR,
                                    "value", enum_str, errp)) {
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 176b549473..d411eebf4e 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -173,7 +173,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
                   "The command %s has not been found", command);
         goto out;
     }
-    if (!compat_policy_input_ok(cmd->special_features, &compat_policy,
+    if (!compat_policy_input_ok(cmd->features, &compat_policy,
                                 ERROR_CLASS_COMMAND_NOT_FOUND,
                                 "command", command, &err)) {
         goto out;
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index 485bc5e6fc..bfcabec526 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -17,7 +17,7 @@
 
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options,
-                          unsigned special_features)
+                          uint64_t features)
 {
     QmpCommand *cmd = g_malloc0(sizeof(*cmd));
 
@@ -28,7 +28,7 @@ void qmp_register_command(QmpCommandList *cmds, const char *name,
     cmd->fn = fn;
     cmd->enabled = true;
     cmd->options = options;
-    cmd->special_features = special_features;
+    cmd->features = features;
     QTAILQ_INSERT_TAIL(cmds, cmd, node);
 }
 
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f110a804b2..ff9c726de3 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -664,10 +664,10 @@ static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 }
 
 static bool qobject_input_policy_reject(Visitor *v, const char *name,
-                                        unsigned special_features,
+                                        uint64_t features,
                                         Error **errp)
 {
-    return !compat_policy_input_ok(special_features, &v->compat_policy,
+    return !compat_policy_input_ok(features, &v->compat_policy,
                                    ERROR_CLASS_GENERIC_ERROR,
                                    "parameter", name, errp);
 }
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 74770edd73..8902287caa 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -210,13 +210,13 @@ static bool qobject_output_type_null(Visitor *v, const char *name,
 }
 
 static bool qobject_output_policy_skip(Visitor *v, const char *name,
-                                       unsigned special_features)
+                                       uint64_t features)
 {
     CompatPolicy *pol = &v->compat_policy;
 
-    return ((special_features & 1u << QAPI_DEPRECATED)
+    return ((features & 1u << QAPI_DEPRECATED)
             && pol->deprecated_output == COMPAT_POLICY_OUTPUT_HIDE)
-        || ((special_features & 1u << QAPI_UNSTABLE)
+        || ((features & 1u << QAPI_UNSTABLE)
             && pol->unstable_output == COMPAT_POLICY_OUTPUT_HIDE);
 }
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 0dd0b00ada..7bc3f8241f 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -71,7 +71,7 @@ def gen_enum_lookup(name: str,
     if feats:
         ret += mcgen('''
     },
-    .special_features = (const unsigned char[%(max_index)s]) {
+    .features = (const uint64_t[%(max_index)s]) {
 ''',
                      max_index=max_index)
         ret += feats
-- 
2.45.2


