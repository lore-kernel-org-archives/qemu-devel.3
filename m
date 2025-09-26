Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87608CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v291n-00061I-VL; Fri, 26 Sep 2025 10:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291e-0005zN-AA
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v291T-0004ZO-Pb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91NIY/+BWmaWYBFQUoENSJBG3eYVje1UDElOofVBcos=;
 b=GpI8EBtHv9cpD2QxcgA5gOkvMPOtFCA7M8/EDP3TmT1JqClUuHHndQilAA9U/1eX0Ue9+X
 Uj/LdAXLvzdPw1jTdTIyDzVtjS0xvALIBWpFwyfRU9XHM0wP3i9r29P3/+Z0cS1cVUdZCT
 1VsCYDpovNo6nqufRMth7A66zU/wqnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-M11Detm7NL2nWA17a7_Sow-1; Fri,
 26 Sep 2025 10:02:03 -0400
X-MC-Unique: M11Detm7NL2nWA17a7_Sow-1
X-Mimecast-MFC-AGG-ID: M11Detm7NL2nWA17a7_Sow_1758895322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08D8518002B7; Fri, 26 Sep 2025 14:02:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 061EE19540EB; Fri, 26 Sep 2025 14:01:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 03/32] qapi: add 'insecure-types' option for -compat
 argument
Date: Fri, 26 Sep 2025 15:01:14 +0100
Message-ID: <20250926140144.1998694-4-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This introduces a new 'insecure-types' option for the 'compat'
argument that accepts three values

 * accept: Allow any usage
 * reject: Reject with an error reported
 * warn: Allow any usage, with a warning reported

For historical compatibility it defaults to 'accept'.

The 'reject' and 'warn' values will take effect for any type
that has been explicitly marked insecure, or is lacking an
explicit declaration of its security status.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/compat-policy.h |  5 +++++
 qapi/compat.json             | 24 +++++++++++++++++++++++-
 qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/qapi/compat-policy.h b/include/qapi/compat-policy.h
index ea65e10744..b2d0835c36 100644
--- a/include/qapi/compat-policy.h
+++ b/include/qapi/compat-policy.h
@@ -24,6 +24,11 @@ bool compat_policy_input_ok(uint64_t features,
                             const char *kind, const char *name,
                             Error **errp);
 
+bool compat_policy_check_security(CompatPolicy *policy,
+                                  const char *typename,
+                                  bool isSecure,
+                                  Error **errp);
+
 /*
  * Create a QObject input visitor for @obj for use with QMP
  *
diff --git a/qapi/compat.json b/qapi/compat.json
index 90b8d51cf2..dcef10a3a5 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -37,6 +37,24 @@
 { 'enum': 'CompatPolicyOutput',
   'data': [ 'accept', 'hide' ] }
 
+##
+# @CompatPolicySecurity:
+#
+# Policy for handling any devices or backends which
+# do not provide a security boundary to protect
+# against untrusted environments
+#
+# @accept: Allow any usage
+#
+# @reject: Reject with an error reported
+#
+# @warn: Allow any usage, with a warning reported
+#
+# Since: 10.2
+##
+{ 'enum': 'CompatPolicySecurity',
+  'data': [ 'accept', 'reject', 'warn' ] }
+
 ##
 # @CompatPolicy:
 #
@@ -62,10 +80,14 @@
 # @unstable-output: how to handle unstable output (default 'accept')
 #     (since 6.2)
 #
+# @insecure-types: how to handle types that are not declared
+#     secure (default 'accept') (since 10.2)
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
index 3d849fe034..ef982d903e 100644
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
 
+bool compat_policy_check_security(CompatPolicy *policy,
+                                  const char *typename,
+                                  bool isSecure,
+                                  Error **errp)
+{
+    if (isSecure) {
+        return true;
+    }
+
+    switch (policy->insecure_types) {
+    case COMPAT_POLICY_SECURITY_ACCEPT:
+        return true;
+
+    case COMPAT_POLICY_SECURITY_REJECT:
+        error_setg(errp, "Type '%s' does not provide a security boundary "
+                   "to protect against untrusted workloads", typename);
+        return false;
+
+    case COMPAT_POLICY_SECURITY_WARN:
+        warn_report("Type '%s' does not provide a security boundary "
+                    "to protect against untrusted workloads", typename);
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
2.50.1


