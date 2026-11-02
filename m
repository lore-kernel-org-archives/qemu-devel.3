Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78224606A5BC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CKg3evGH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDZ-0003Pl-L7; Mon, 02 Nov 2026 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD3-0003Ag-8S
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD1-0008PB-MQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=332r771SEtrMdRKM5twMkzBlQ+3eXs1IGKYZ2+XQir8=;
 b=CKg3evGH2++sbb6SUsCWfOAb/on9UJMtmDPhdujendCE0TqYPIQp4rqvjy7X/K/VZJlneZ
 gReDG3xTcpyGyNrLVj2hEiD6vduaiSOlF4pnas0/UwhaL8NOMr5O+KrlCiJCJkn3OBgkYp
 yw2O9hDfIYyKjT/4TozYtenNSGhxLRk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-bEe3EZC7Nk2FN41tLg5nFQ-1; Mon,
 02 Nov 2026 09:40:25 -0500
X-MC-Unique: bEe3EZC7Nk2FN41tLg5nFQ-1
X-Mimecast-MFC-AGG-ID: bEe3EZC7Nk2FN41tLg5nFQ_1793630424
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E0CF19539AA; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CD1C7E3; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21ADD21E6890; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 13/74] qapi: drop CompatPolicySecurity and use CompatPolicyInput
Date: Mon,  2 Nov 2026 15:39:17 +0100
Message-ID: <20261102144018.3212223-14-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Daniel P. Berrangé <berrange@redhat.com>

With 'CompatPolicyInput' gaining a 'warn' option, the 'insecure-input'
option can use the 'CompatPolicySecurity' type, dropping the former.
This replacement means that the 'insecure-input' option gains the
ability use the 'crash' policy option.

Note the error message for insecure-input changes from

   Type 'rtl8139' does not provide a security boundary
   to protect against untrusted data or actions

To

   Insecure QOM type rtl8139 disabled by policy
   This type does does not provide a security boundary
   to protect against untrusted data or actions

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261030141713.2841710-5-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json | 18 +-----------------
 qapi/qapi-util.c | 26 +++++++++++---------------
 2 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index 7146eab6b9..df7d1109c3 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -40,22 +40,6 @@
 { 'enum': 'CompatPolicyOutput',
   'data': [ 'accept', 'hide' ] }
 
-##
-# @CompatPolicySecurity:
-#     Policy for handling any devices or backends which do not provide
-#     a security boundary to protect against untrusted environments
-#
-# @accept: Allow any usage
-#
-# @reject: Reject with an error reported
-#
-# @warn: Allow any usage, with a warning reported
-#
-# Since: 11.2
-##
-{ 'enum': 'CompatPolicySecurity',
-  'data': [ 'accept', 'reject', 'warn' ] }
-
 ##
 # @CompatPolicy:
 #     Policy for handling problematic management interfaces.
@@ -91,4 +75,4 @@
             '*deprecated-output': 'CompatPolicyOutput',
             '*unstable-input': 'CompatPolicyInput',
             '*unstable-output': 'CompatPolicyOutput',
-            '*insecure-input': 'CompatPolicySecurity' } }
+            '*insecure-input': 'CompatPolicyInput' } }
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e5d8662f8b..e8ecc7346b 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -16,6 +16,7 @@
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
 
 CompatPolicy compat_policy;
 
@@ -68,27 +69,22 @@ bool compat_policy_check_security(const CompatPolicy *policy,
                                   bool is_secure,
                                   Error **errp)
 {
+    ERRP_GUARD();
+
     if (is_secure) {
         return true;
     }
 
-    switch (policy->insecure_input) {
-    case COMPAT_POLICY_SECURITY_ACCEPT:
-        return true;
-
-    case COMPAT_POLICY_SECURITY_REJECT:
-        error_setg(errp, "Type '%s' does not provide a security boundary "
-                   "to protect against untrusted data or actions", typename);
+    if (!compat_policy_input_ok1(policy->insecure_input,
+                                 "Insecure",
+                                 ERROR_CLASS_GENERIC_ERROR,
+                                 "QOM type", typename, errp)) {
+        error_append_hint(errp, "This type does does not provide a "
+                          "security boundary to protect against "
+                          "untrusted data or actions\n");
         return false;
-
-    case COMPAT_POLICY_SECURITY_WARN:
-        warn_report("Type '%s' does not provide a security boundary "
-                    "to protect against untrusted data or actions", typename);
-        return true;
-
-    default:
-        g_assert_not_reached();
     }
+    return true;
 }
 
 
-- 
2.55.0


