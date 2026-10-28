Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C43606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIEgrKGd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3pZ-00051w-0J; Wed, 28 Oct 2026 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pN-0004y1-Ti
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pC-0007h2-Fs
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mqwlJ2cpKXvG3aCVAUW6xKejx28WZYL1+my44fhoRE=;
 b=jIEgrKGdDbdhpxG+C/mV9Z3DX3OI/cClMnoJhEu3Fh4r5Z11/45nOBjrNE8MGEgKPFn/iq
 N2rEtGZbfGusme3+lA6SC5MaZ/+DX6BHbSpPwWP/ku0yifn0caK/0jP4pIuejNdMYQGUuX
 IRpp4bmmaFTOgEyEOC9H7UAZsCsQ0rI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-YIfRtW-MORGRODfZhlFddA-1; Wed,
 28 Oct 2026 09:36:09 -0400
X-MC-Unique: YIfRtW-MORGRODfZhlFddA-1
X-Mimecast-MFC-AGG-ID: YIfRtW-MORGRODfZhlFddA_1793194568
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76605195606E
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:36:08 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B992F30002D1; Wed, 28 Oct 2026 13:36:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/8] qapi: make 'CompatPolicy' the first arg in
 compat_policy_input_ok
Date: Wed, 28 Oct 2026 13:35:56 +0000
Message-ID: <20261028133603.1893289-2-berrange@redhat.com>
In-Reply-To: <20261028133603.1893289-1-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The typical API design pattern is for a method to be named after
the type of the first arg passed into the method. For the
compat_policy_input_ok method, this points towards 'CompatPolicy'
being the first arg, matching compat_policy_check_security.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/compat-policy.h |  4 ++--
 qapi/qapi-util.c             | 16 ++++++++--------
 qapi/qapi-visit-core.c       |  4 ++--
 qapi/qmp-dispatch.c          |  2 +-
 qapi/qobject-input-visitor.c |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index f5af2090692..df87d716439 100644
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
index 38b1cec7a41..93898f57a05 100644
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
index 706c61e0260..66d57dd447a 100644
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
index 965cad64998..f2fb8f7976c 100644
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
index c52d36997df..17d91746d3a 100644
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
2.56.0


