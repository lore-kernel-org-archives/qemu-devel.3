Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF88CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGye-0000Bu-HF; Tue, 04 Nov 2025 08:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyc-0000BA-Gw
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGya-0001K9-AA
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3YABwSRksIeg1jN6WqNygFuPhRG6KpB/68ixTpgyZw=;
 b=PKb4ptLPenlUiFgPr/Omg7r6pC7VT1tTTyaUDHknkxgsOB4pu3dX59YsxvsaIZ/xH2+oq9
 zOzUbC7NwxVGxwDOGsWKc9O9cKTBs+7rGfBA3HxwTfB9XyeGVqPuzIL+YP8d0hZAz7QTDD
 4yBUAM6RKT52P6q27+SPIGVXgN6kXQ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-FOU1j2TBOhKUQHWqfIyS3Q-1; Tue,
 04 Nov 2025 08:21:29 -0500
X-MC-Unique: FOU1j2TBOhKUQHWqfIyS3Q-1
X-Mimecast-MFC-AGG-ID: FOU1j2TBOhKUQHWqfIyS3Q_1762262489
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D126C19560AE; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3490E19560A2; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FBE821E6924; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/12] qapi/command: Avoid generating unused
 qmp_marshal_output_T()
Date: Tue,  4 Nov 2025 14:21:14 +0100
Message-ID: <20251104132125.4134730-2-armbru@redhat.com>
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
References: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qmp_marshal_output_T() is only ever called by qmp_marshal_C() for a
command C that returns type T.

We've always generated it as a static function on demand, i.e. when we
generate a call.

Since we split up monolithic generated code into modules (commit
252dc3105fc "qapi: Generate separate .h, .c for each module"), we do
this per module.  As noted in the commit message, this can result in
identical (static) qmp_marshal_output_T() in several modules.  Was
deemed not worth avoiding.

A bit later, we added 'if' conditionals to the schema language (merge
commit 5dafaf4fbce).

When a conditional definition uses a type, then its condition must
imply the type's condition.  We made this the user's responsibility.
Hasn't been an issue in practice.

However, the sharing of qmp_marshal_output_T() among commands
complicates matters.  To avoid both undefined function errors and
unused function warnings, qmp_marshal_output_T() must be defined
exactly when it's used.  It is used when any of the qmp_marshal_C()
calling it is defined, i.e. when any C's condition holds.

The generator uses T's condition instead.  To avoid both error and
warning, T's condition must be the conjunction of all C's conditions.

Unfortunately, this can be impossible:

* Conditional command returning a builtin type

  A builtin type cannot be conditional.  This is noted in a FIXME
  comment.

* Commands in multiple modules where the conjunction differs between
  modules

  An instance of this came up recently.  we have unconditional
  commands returning HumanReadableText.  If we add a conditional one
  to a module that does not have unconditional ones, compilation fails
  with "defined but not used".  If we make HumanReadableText
  conditional to fix this module, we break the others.

Instead of complicating the code to compute the conjunction, simplify
it: generate the output marshaling code right into qmp_marshal_C().

This duplicates it when multiple commands return the same type.  The
impact on code size is negligible: qemu-system-x86_64's text segment
grows by 1448 bytes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250804130602.903904-1-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[Commit message typos fixed]
---
 docs/devel/qapi-code-gen.rst | 25 ++++++++------------
 scripts/qapi/commands.py     | 44 ++++++++----------------------------
 2 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index d97602f464..3a632b4a64 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1809,27 +1809,13 @@ Example::
     $ cat qapi-generated/example-qapi-commands.c
     [Uninteresting stuff omitted...]
 
-    static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in,
-                                    QObject **ret_out, Error **errp)
-    {
-        Visitor *v;
-
-        v = qobject_output_visitor_new_qmp(ret_out);
-        if (visit_type_UserDefOne(v, "unused", &ret_in, errp)) {
-            visit_complete(v, ret_out);
-        }
-        visit_free(v);
-        v = qapi_dealloc_visitor_new();
-        visit_type_UserDefOne(v, "unused", &ret_in, NULL);
-        visit_free(v);
-    }
-
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp)
     {
         Error *err = NULL;
         bool ok = false;
         Visitor *v;
         UserDefOne *retval;
+        Visitor *ov;
         q_obj_my_command_arg arg = {0};
 
         v = qobject_input_visitor_new_qmp(QOBJECT(args));
@@ -1857,7 +1843,14 @@ Example::
             goto out;
         }
 
-        qmp_marshal_output_UserDefOne(retval, ret, errp);
+        ov = qobject_output_visitor_new_qmp(ret);
+        if (visit_type_UserDefOne(ov, "unused", &retval, errp)) {
+            visit_complete(ov, ret);
+        }
+        visit_free(ov);
+        ov = qapi_dealloc_visitor_new();
+        visit_type_UserDefOne(ov, "unused", &retval, NULL);
+        visit_free(ov);
 
         if (trace_event_get_state_backends(TRACE_QMP_EXIT_MY_COMMAND)) {
             g_autoptr(GString) ret_json = qobject_to_json(*ret);
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 7914227382..a82b5a2a5e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -14,15 +14,12 @@
 """
 
 from typing import (
-    Dict,
     List,
     Optional,
-    Set,
 )
 
 from .common import c_name, mcgen
 from .gen import (
-    QAPIGenC,
     QAPISchemaModularCVisitor,
     build_params,
     gen_features,
@@ -112,11 +109,7 @@ def gen_call(name: str,
 ''')
 
     if ret_type:
-        ret += mcgen('''
-
-    qmp_marshal_output_%(c_name)s(retval, ret, errp);
-''',
-                     c_name=ret_type.c_name())
+        ret += gen_marshal_output(ret_type)
 
     if gen_tracing:
         if ret_type:
@@ -142,22 +135,16 @@ def gen_call(name: str,
 def gen_marshal_output(ret_type: QAPISchemaType) -> str:
     return mcgen('''
 
-static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
-                                QObject **ret_out, Error **errp)
-{
-    Visitor *v;
-
-    v = qobject_output_visitor_new_qmp(ret_out);
-    if (visit_type_%(c_name)s(v, "unused", &ret_in, errp)) {
-        visit_complete(v, ret_out);
+    ov = qobject_output_visitor_new_qmp(ret);
+    if (visit_type_%(c_name)s(ov, "unused", &retval, errp)) {
+        visit_complete(ov, ret);
     }
-    visit_free(v);
-    v = qapi_dealloc_visitor_new();
-    visit_type_%(c_name)s(v, "unused", &ret_in, NULL);
-    visit_free(v);
-}
+    visit_free(ov);
+    ov = qapi_dealloc_visitor_new();
+    visit_type_%(c_name)s(ov, "unused", &retval, NULL);
+    visit_free(ov);
 ''',
-                 c_type=ret_type.c_type(), c_name=ret_type.c_name())
+                 c_name=ret_type.c_name())
 
 
 def build_marshal_proto(name: str,
@@ -209,6 +196,7 @@ def gen_marshal(name: str,
     if ret_type:
         ret += mcgen('''
     %(c_type)s retval;
+    Visitor *ov;
 ''',
                      c_type=ret_type.c_type())
 
@@ -308,11 +296,9 @@ def __init__(self, prefix: str, gen_tracing: bool):
             prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', None, __doc__,
             gen_tracing=gen_tracing)
-        self._visited_ret_types: Dict[QAPIGenC, Set[QAPISchemaType]] = {}
         self._gen_tracing = gen_tracing
 
     def _begin_user_module(self, name: str) -> None:
-        self._visited_ret_types[self._genc] = set()
         commands = self._module_basename('qapi-commands', name)
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
@@ -386,16 +372,6 @@ def visit_command(self,
                       coroutine: bool) -> None:
         if not gen:
             return
-        # FIXME: If T is a user-defined type, the user is responsible
-        # for making this work, i.e. to make T's condition the
-        # conjunction of the T-returning commands' conditions.  If T
-        # is a built-in type, this isn't possible: the
-        # qmp_marshal_output_T() will be generated unconditionally.
-        if ret_type and ret_type not in self._visited_ret_types[self._genc]:
-            self._visited_ret_types[self._genc].add(ret_type)
-            with ifcontext(ret_type.ifcond,
-                           self._genh, self._genc):
-                self._genc.add(gen_marshal_output(ret_type))
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_command_decl(name, arg_type, boxed,
                                             ret_type, coroutine))
-- 
2.49.0


