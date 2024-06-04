Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9a-0006ZE-E1; Tue, 04 Jun 2024 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9Z-0006Yl-HK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9Y-0001Gt-0l
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nshYwZLSBkZ8aydLKTO7Ez7S8eYc459g0Uetg05gxRA=;
 b=CHRzx1/BNekNgg3GV4OSNrbw1dSaM+lfhmJWd4woubuf5+8zFKUuhhXVbiZzHQhsKtTqGk
 Lsv7m4mNXv5bQ0FsmJNqrVn/5yS9R4hYoHDAYGVfbWhalZrDcILOtBw3Xwi6CC1LYrX8i9
 Mx/NGwNVucjhxdiA4l59OtHwlSSF5wA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-DhOaNTAPPeCrFkdC-V9kHw-1; Tue, 04 Jun 2024 11:32:46 -0400
X-MC-Unique: DhOaNTAPPeCrFkdC-V9kHw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F28628007A1;
 Tue,  4 Jun 2024 15:32:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AC58492BCF;
 Tue,  4 Jun 2024 15:32:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/14] qapi: use "QAPI_FEATURE" as namespace for special
 features
Date: Tue,  4 Jun 2024 16:32:29 +0100
Message-ID: <20240604153242.251334-2-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This more clearly distinguishes the feature constants from other
QAPI constants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/util.h           | 4 ++--
 qapi/qapi-util.c              | 4 ++--
 qapi/qobject-output-visitor.c | 4 ++--
 scripts/qapi/gen.py           | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qapi/util.h b/include/qapi/util.h
index 20dfea8a54..7698e789a9 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -12,8 +12,8 @@
 #define QAPI_UTIL_H
 
 typedef enum {
-    QAPI_DEPRECATED,
-    QAPI_UNSTABLE,
+    QAPI_FEATURE_DEPRECATED,
+    QAPI_FEATURE_UNSTABLE,
 } QapiSpecialFeature;
 
 typedef struct QEnumLookup {
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 65a7d18437..6bcab11117 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -43,13 +43,13 @@ bool compat_policy_input_ok(unsigned special_features,
                             const char *kind, const char *name,
                             Error **errp)
 {
-    if ((special_features & 1u << QAPI_DEPRECATED)
+    if ((special_features & 1u << QAPI_FEATURE_DEPRECATED)
         && !compat_policy_input_ok1("Deprecated",
                                     policy->deprecated_input,
                                     error_class, kind, name, errp)) {
         return false;
     }
-    if ((special_features & (1u << QAPI_UNSTABLE))
+    if ((special_features & (1u << QAPI_FEATURE_UNSTABLE))
         && !compat_policy_input_ok1("Unstable",
                                     policy->unstable_input,
                                     error_class, kind, name, errp)) {
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 74770edd73..ca8be3fe06 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -214,9 +214,9 @@ static bool qobject_output_policy_skip(Visitor *v, const char *name,
 {
     CompatPolicy *pol = &v->compat_policy;
 
-    return ((special_features & 1u << QAPI_DEPRECATED)
+    return ((special_features & 1u << QAPI_FEATURE_DEPRECATED)
             && pol->deprecated_output == COMPAT_POLICY_OUTPUT_HIDE)
-        || ((special_features & 1u << QAPI_UNSTABLE)
+        || ((special_features & 1u << QAPI_FEATURE_UNSTABLE)
             && pol->unstable_output == COMPAT_POLICY_OUTPUT_HIDE);
 }
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 6a8abe0041..9c590a1c2e 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -41,7 +41,7 @@
 
 
 def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
-    special_features = [f"1u << QAPI_{feat.name.upper()}"
+    special_features = [f"1u << QAPI_FEATURE_{feat.name.upper()}"
                         for feat in features if feat.is_special()]
     return ' | '.join(special_features) or '0'
 
-- 
2.45.1


