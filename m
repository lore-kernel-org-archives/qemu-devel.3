Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17544C982D9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ech-00067e-Mg; Thu, 17 Sep 2026 12:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcH-0005pW-VM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcE-0006rR-9i
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tp4k2TnLWm2690QQrf2eUErZJWedHgYyEX3pnFdeeD0=;
 b=M8GN7A+cq2fm3B/3Mgh93WKuPjHIp8Esb2WruUAH1ltaxGDPlYRau0c2rgy5o7KtZkhB/O
 eTROvi3biBMg2SoqBcUN5l5FKOes3MfM0zZba6V/TYS9j7VzPQ936zijTHrXghLYhp8m/U
 l1kZqjHrhFFbuWuwksb2OBluctjrHB8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-2cvvQTDKPjOsm0e9XJNkMg-1; Thu,
 17 Sep 2026 12:05:33 -0400
X-MC-Unique: 2cvvQTDKPjOsm0e9XJNkMg-1
X-Mimecast-MFC-AGG-ID: 2cvvQTDKPjOsm0e9XJNkMg_1789661132
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BDCD1828B22; Thu, 17 Sep 2026 16:05:32 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD83A300022B; Thu, 17 Sep 2026 16:05:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/14] qapi: add 'insecure-types' option for -compat argument
Date: Thu, 17 Sep 2026 17:05:13 +0100
Message-ID: <20260917160525.1275388-3-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This introduces a new 'insecure-types' option for the 'compat'
argument that accepts three values

 * accept: Allow any usage
 * reject: Reject with an error reported
 * warn: Allow any usage, with a warning reported

For historical compatibility it defaults to 'accept'.

The 'reject' and 'warn' values will take effect for any type
that has been explicitly marked insecure, or is lacking an
explicit declaration of its security status.

This new command line option is currently a no-op, but will
become functional as following patches enable the checks.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/compat-policy.h |  5 +++++
 qapi/compat.json             | 23 ++++++++++++++++++++++-
 qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index ea65e10744a..f5af2090692 100644
--- a/include/qapi/compat-policy.h
+++ b/include/qapi/compat-policy.h
@@ -24,6 +24,11 @@ bool compat_policy_input_ok(uint64_t features,
                             const char *kind, const char *name,
                             Error **errp);
 
+bool compat_policy_check_security(const CompatPolicy *policy,
+                                  const char *typename,
+                                  bool is_secure,
+                                  Error **errp);
+
 /*
  * Create a QObject input visitor for @obj for use with QMP
  *
diff --git a/qapi/compat.json b/qapi/compat.json
index 90b8d51cf27..b54f8eb3713 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -37,6 +37,23 @@
 { 'enum': 'CompatPolicyOutput',
   'data': [ 'accept', 'hide' ] }
 
+##
+# @CompatPolicySecurity:
+#
+# Policy for handling any devices or backends which do not provide a
+# security boundary to protect against untrusted environments
+#
+# @accept: Allow any usage
+#
+# @reject: Reject with an error reported
+#
+# @warn: Allow any usage, with a warning reported
+#
+# Since: 11.2
+##
+{ 'enum': 'CompatPolicySecurity',
+  'data': [ 'accept', 'reject', 'warn' ] }
+
 ##
 # @CompatPolicy:
 #
@@ -62,10 +79,14 @@
 # @unstable-output: how to handle unstable output (default 'accept')
 #     (since 6.2)
 #
+# @insecure-types: how to handle types that are not declared secure
+#     (default 'accept') (since 11.2)
+#
 # Since: 6.0
 ##
 { 'struct': 'CompatPolicy',
   'data': { '*deprecated-input': 'CompatPolicyInput',
             '*deprecated-output': 'CompatPolicyOutput',
             '*unstable-input': 'CompatPolicyInput',
-            '*unstable-output': 'CompatPolicyOutput' } }
+            '*unstable-output': 'CompatPolicyOutput',
+            '*insecure-types': 'CompatPolicySecurity' } }
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 3d849fe0347..38b1cec7a41 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -14,6 +14,7 @@
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qemu/ctype.h"
+#include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
 
 CompatPolicy compat_policy;
@@ -58,6 +59,35 @@ bool compat_policy_input_ok(uint64_t features,
     return true;
 }
 
+bool compat_policy_check_security(const CompatPolicy *policy,
+                                  const char *typename,
+                                  bool is_secure,
+                                  Error **errp)
+{
+    if (is_secure) {
+        return true;
+    }
+
+    switch (policy->insecure_types) {
+    case COMPAT_POLICY_SECURITY_ACCEPT:
+        return true;
+
+    case COMPAT_POLICY_SECURITY_REJECT:
+        error_setg(errp, "Type '%s' does not provide a security boundary "
+                   "to protect against untrusted data or actions", typename);
+        return false;
+
+    case COMPAT_POLICY_SECURITY_WARN:
+        warn_report("Type '%s' does not provide a security boundary "
+                    "to protect against untrusted data or actions", typename);
+        return true;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
     assert(val >= 0 && val < lookup->size);
-- 
2.55.0


