Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703660895B6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jNw0joyZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtF6-0005gT-Gg; Mon, 02 Nov 2026 09:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD5-0003CA-Tf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD4-0008QV-0Z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFy744EbTKaof+XnsyO8USs/Oj5iICBKu5ik0mEUYt0=;
 b=jNw0joyZeRc5VuV9/388qICuexYsYUeCOdTBI0P5SsETerO/9hexvLLocTwaYsbu1kWl0n
 j+cjsewBOCWehgf0pAanVEh794YysAozm7PeVZcWHEDKCBRertD1iciqtXTe+JUmncoYkF
 LTVH0EKX67/6T45nnBmAgKivASDUtoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-qrjkENfvOce7OlH3CVxZMA-1; Mon,
 02 Nov 2026 09:40:26 -0500
X-MC-Unique: qrjkENfvOce7OlH3CVxZMA-1
X-Mimecast-MFC-AGG-ID: qrjkENfvOce7OlH3CVxZMA_1793630425
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07F5E180AC6C; Mon,  2 Nov 2026 14:40:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 715DD1956087; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1647921E688A; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 10/74] qapi: make 'CompatPolicy' the first arg in
 compat_policy_input_ok
Date: Mon,  2 Nov 2026 15:39:14 +0100
Message-ID: <20261102144018.3212223-11-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

The typical API design pattern is for a method to be named after
the type of the first arg passed into the method. For the
compat_policy_input_ok method, this points towards 'CompatPolicy'
being the first arg, matching compat_policy_check_security.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261030141713.2841710-2-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/compat-policy.h |  4 ++--
 qapi/qapi-util.c             | 16 ++++++++--------
 qapi/qapi-visit-core.c       |  4 ++--
 qapi/qmp-dispatch.c          |  2 +-
 qapi/qobject-input-visitor.c |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index f5af209069..df87d71643 100644
--- a/include/qapi/compat-policy.h
+++ b/include/qapi/compat-policy.h
@@ -18,8 +18,8 @@
 
 extern CompatPolicy compat_policy;
 
-bool compat_policy_input_ok(uint64_t features,
-                            const CompatPolicy *policy,
+bool compat_policy_input_ok(const CompatPolicy *policy,
+                            uint64_t features,
                             ErrorClass error_class,
                             const char *kind, const char *name,
                             Error **errp);
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 38b1cec7a4..93898f57a0 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -19,8 +19,8 @@
 
 CompatPolicy compat_policy;
 
-static bool compat_policy_input_ok1(const char *adjective,
-                                    CompatPolicyInput policy,
+static bool compat_policy_input_ok1(CompatPolicyInput policy,
+                                    const char *adjective,
                                     ErrorClass error_class,
                                     const char *kind, const char *name,
                                     Error **errp)
@@ -38,21 +38,21 @@ static bool compat_policy_input_ok1(const char *adjective,
     }
 }
 
-bool compat_policy_input_ok(uint64_t features,
-                            const CompatPolicy *policy,
+bool compat_policy_input_ok(const CompatPolicy *policy,
+                            uint64_t features,
                             ErrorClass error_class,
                             const char *kind, const char *name,
                             Error **errp)
 {
     if ((features & 1u << QAPI_DEPRECATED)
-        && !compat_policy_input_ok1("Deprecated",
-                                    policy->deprecated_input,
+        && !compat_policy_input_ok1(policy->deprecated_input,
+                                    "Deprecated",
                                     error_class, kind, name, errp)) {
         return false;
     }
     if ((features & (1u << QAPI_UNSTABLE))
-        && !compat_policy_input_ok1("Unstable",
-                                    policy->unstable_input,
+        && !compat_policy_input_ok1(policy->unstable_input,
+                                    "Unstable",
                                     error_class, kind, name, errp)) {
         return false;
     }
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 706c61e026..66d57dd447 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -410,8 +410,8 @@ static bool input_type_enum(Visitor *v, const char *name, int *obj,
     }
 
     if (lookup->features
-        && !compat_policy_input_ok(lookup->features[value],
-                                   &v->compat_policy,
+        && !compat_policy_input_ok(&v->compat_policy,
+                                   lookup->features[value],
                                    ERROR_CLASS_GENERIC_ERROR,
                                    "value", enum_str, errp)) {
         return false;
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 965cad6499..f2fb8f7976 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -185,7 +185,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
                   "The command %s has not been found", command);
         goto out;
     }
-    if (!compat_policy_input_ok(cmd->features, &compat_policy,
+    if (!compat_policy_input_ok(&compat_policy, cmd->features,
                                 ERROR_CLASS_COMMAND_NOT_FOUND,
                                 "command", command, &err)) {
         goto out;
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index c52d36997d..17d91746d3 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -667,7 +667,7 @@ static bool qobject_input_policy_reject(Visitor *v, const char *name,
                                         uint64_t features,
                                         Error **errp)
 {
-    return !compat_policy_input_ok(features, &v->compat_policy,
+    return !compat_policy_input_ok(&v->compat_policy, features,
                                    ERROR_CLASS_GENERIC_ERROR,
                                    "parameter", name, errp);
 }
-- 
2.55.0


