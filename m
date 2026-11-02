Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC0606F21A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtVhZYlI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDw-0003ZF-0L; Mon, 02 Nov 2026 09:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD4-0003Bm-Ow
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD1-0008PH-PU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdqFzmVVYGEziw8l4vB0HednyO2pPO+OjJhxsWZ61YM=;
 b=FtVhZYlI6WmPB0QPMtEYp5MvbqLbAk9TdUZkBHhzdXOOdGE9oCHlSqhQ5Qu5eCLXdD0O+B
 u4cJq72lAgMOC+CJ3A3pxnwlrQ6/WmaJf0xTeR/FRVH0OASNTPPwWGyWTI9hioWC2+vAfI
 MgyMeDUEvaOZDbD2Vw2bU6LHGL60G4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-_xC2qiVFN4OSghuRTEsoLw-1; Mon,
 02 Nov 2026 09:40:25 -0500
X-MC-Unique: _xC2qiVFN4OSghuRTEsoLw-1
X-Mimecast-MFC-AGG-ID: _xC2qiVFN4OSghuRTEsoLw_1793630424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E4A1802159; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B3BD300019F; Mon,  2 Nov 2026 14:40:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 18C6021E688B; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/74] qapi: add 'warn' option to CompatPolicyInput
Date: Mon,  2 Nov 2026 15:39:15 +0100
Message-ID: <20261102144018.3212223-12-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

This prints a warning on stderr every time a policy violation
is encountered, but accepts the input. Warning every time is
known to be annoying and sub-optimal, but the normal trick of
using warn_report_once() isn't possible in this scenario.

As a result 'warn' is not set as the default policy at this
time, despite other manually placed deprecation warnings being
emitted by default.

Future work will consider ways to reduce the warnings to be
once only, which would unlock the ability to use 'warn' by
default.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20261030141713.2841710-3-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/compat.json |  7 ++++++-
 qapi/qapi-util.c |  4 ++++
 qemu-options.hx  | 14 ++++++++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index d1fb74abf7..b183be15d4 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -17,10 +17,15 @@
 #
 # @crash: abort() the process
 #
+# @warn: Accept with warnings printed to stderr (Since: 11.2)
+#
+# .. note:: at this time, warnings will be printed on every policy
+#           check failure rather than once only.
+#
 # Since: 6.0
 ##
 { 'enum': 'CompatPolicyInput',
-  'data': [ 'accept', 'reject', 'crash' ] }
+  'data': [ 'accept', 'reject', 'crash', 'warn' ] }
 
 ##
 # @CompatPolicyOutput:
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 93898f57a0..fe0a6a57c8 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -28,6 +28,10 @@ static bool compat_policy_input_ok1(CompatPolicyInput policy,
     switch (policy) {
     case COMPAT_POLICY_INPUT_ACCEPT:
         return true;
+    case COMPAT_POLICY_INPUT_WARN:
+        warn_report("%s %s %s accepted by policy",
+                    adjective, kind, name);
+        return true;
     case COMPAT_POLICY_INPUT_REJECT:
         error_set(errp, error_class, "%s %s %s disabled by policy",
                   adjective, kind, name);
diff --git a/qemu-options.hx b/qemu-options.hx
index f72f30e246..854341e7a0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4693,9 +4693,9 @@ DEFHEADING()
 DEFHEADING(Debug/Expert options:)
 
 DEF("compat", HAS_ARG, QEMU_OPTION_compat,
-    "-compat [deprecated-input=accept|reject|crash][,deprecated-output=accept|hide]\n"
+    "-compat [deprecated-input=accept|reject|crash|warn][,deprecated-output=accept|hide]\n"
     "                Policy for handling deprecated management interfaces\n"
-    "-compat [unstable-input=accept|reject|crash][,unstable-output=accept|hide]\n"
+    "-compat [unstable-input=accept|reject|crash|warn][,unstable-output=accept|hide]\n"
     "                Policy for handling unstable management interfaces\n",
     QEMU_ARCH_ALL)
 SRST
@@ -4703,7 +4703,10 @@ SRST
     Set policy for handling deprecated management interfaces (experimental):
 
     ``deprecated-input=accept`` (default)
-        Accept deprecated commands and arguments
+        Accept deprecated commands and arguments silently
+    ``deprecated-input=warn``
+        Accept deprecated commands and arguments with repeated warnings
+        on stderr
     ``deprecated-input=reject``
         Reject deprecated commands and arguments
     ``deprecated-input=crash``
@@ -4719,7 +4722,10 @@ SRST
     Set policy for handling unstable management interfaces (experimental):
 
     ``unstable-input=accept`` (default)
-        Accept unstable commands and arguments
+        Accept unstable commands and arguments silently
+    ``unstable-input=warn``
+        Accept unstable commands and arguments with repeated warnings
+        on stderr
     ``unstable-input=reject``
         Reject unstable commands and arguments
     ``unstable-input=crash``
-- 
2.55.0


