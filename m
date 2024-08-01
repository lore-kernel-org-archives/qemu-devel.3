Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC096C49EA1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5R-0001kO-UK; Thu, 01 Aug 2024 13:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5P-0001ZF-4h
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5M-0005uM-59
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjmXgGzTx2PPKb6vl+5P/ivLVpqgVC1jTbbAHudRTVw=;
 b=Jo7IguMd1Pq2yl5w3NqP69WX7c0zJUROxM6DsEunw4PRYbrNp5BEwEGg+fCuevlfmylyOM
 vGY47G/Yc4C5//wk13Ree4A45R0hfyb7p6HNWTEaMmmNBgoHZ/pThmFrxxhD78QrHqsO5K
 Wnaoki0zKIFaCtQhzNuB0RkkBm5PHgQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-2HESJ0tjPXi3Capv2bcuUg-1; Thu,
 01 Aug 2024 13:59:28 -0400
X-MC-Unique: 2HESJ0tjPXi3Capv2bcuUg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A1791955D45; Thu,  1 Aug 2024 17:59:27 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 908D1195605A; Thu,  1 Aug 2024 17:59:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/6] qapi: use "QAPI_FEATURE" as namespace for features
Date: Thu,  1 Aug 2024 18:59:10 +0100
Message-ID: <20240801175913.669013-4-berrange@redhat.com>
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
index b377cb9c70..a693cac9ea 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -12,8 +12,8 @@
 #define QAPI_UTIL_H
 
 typedef enum {
-    QAPI_DEPRECATED,
-    QAPI_UNSTABLE,
+    QAPI_FEATURE_DEPRECATED,
+    QAPI_FEATURE_UNSTABLE,
 } QapiFeature;
 
 typedef struct QEnumLookup {
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 3d849fe034..48c8c867d3 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -43,13 +43,13 @@ bool compat_policy_input_ok(uint64_t features,
                             const char *kind, const char *name,
                             Error **errp)
 {
-    if ((features & 1u << QAPI_DEPRECATED)
+    if ((features & 1u << QAPI_FEATURE_DEPRECATED)
         && !compat_policy_input_ok1("Deprecated",
                                     policy->deprecated_input,
                                     error_class, kind, name, errp)) {
         return false;
     }
-    if ((features & (1u << QAPI_UNSTABLE))
+    if ((features & (1u << QAPI_FEATURE_UNSTABLE))
         && !compat_policy_input_ok1("Unstable",
                                     policy->unstable_input,
                                     error_class, kind, name, errp)) {
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 8902287caa..b13c94d913 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -214,9 +214,9 @@ static bool qobject_output_policy_skip(Visitor *v, const char *name,
 {
     CompatPolicy *pol = &v->compat_policy;
 
-    return ((features & 1u << QAPI_DEPRECATED)
+    return ((features & 1u << QAPI_FEATURE_DEPRECATED)
             && pol->deprecated_output == COMPAT_POLICY_OUTPUT_HIDE)
-        || ((features & 1u << QAPI_UNSTABLE)
+        || ((features & 1u << QAPI_FEATURE_UNSTABLE)
             && pol->unstable_output == COMPAT_POLICY_OUTPUT_HIDE);
 }
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index e6c80cce23..0ff29dc776 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -41,7 +41,7 @@
 
 
 def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
-    features = [f"1u << QAPI_{feat.name.upper()}"
+    features = [f"1u << QAPI_FEATURE_{feat.name.upper()}"
                 for feat in features if feat.is_special()]
     return ' | '.join(features) or '0'
 
-- 
2.45.2


