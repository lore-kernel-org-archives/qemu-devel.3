Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RheusU7L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3pV-00050g-5k; Wed, 28 Oct 2026 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pB-0004vO-87
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3p8-0007gB-6w
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Nw1q2JSdXJhjqPl43S5WHTGvP3/xUVXyKO/+5mZUbs=;
 b=RheusU7Lcoasqd2u5EXpHkcHbstNppO2H04TbDc7byloCFyQP5Z8ALYN8VPlVcy+fHzC7p
 +tTApWeEizhehduwWcSXciLe1EKWGlBYvpFu5sXC+cTTg8l21gJkQR2epCLHNVpuIwzRsL
 zUuPvlWnWhXnbhsLfnnhL+CaRYAIFBA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-XjqR3QxfML-yMvg0cQcs_A-1; Wed,
 28 Oct 2026 09:36:10 -0400
X-MC-Unique: XjqR3QxfML-yMvg0cQcs_A-1
X-Mimecast-MFC-AGG-ID: XjqR3QxfML-yMvg0cQcs_A_1793194570
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C600D1800DB5
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:36:09 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7AC030002CB; Wed, 28 Oct 2026 13:36:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/8] qapi: add 'warn' option to CompatPolicyInput
Date: Wed, 28 Oct 2026 13:35:57 +0000
Message-ID: <20261028133603.1893289-3-berrange@redhat.com>
In-Reply-To: <20261028133603.1893289-1-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

This prints a warning on stderr every time a policy violation
is encountered, but accepts the input.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/compat.json |  4 +++-
 qapi/qapi-util.c |  4 ++++
 qemu-options.hx  | 12 ++++++++----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/qapi/compat.json b/qapi/compat.json
index 0f90ea1f524..dfa3fea0577 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -17,10 +17,12 @@
 #
 # @crash: abort() the process
 #
+# @warn: Accept with a warning printed to stderr (Since: 11.2)
+#
 # Since: 6.0
 ##
 { 'enum': 'CompatPolicyInput',
-  'data': [ 'accept', 'reject', 'crash' ] }
+  'data': [ 'accept', 'reject', 'crash', 'warn' ] }
 
 ##
 # @CompatPolicyOutput:
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 93898f57a05..f81a171a5b1 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -28,6 +28,10 @@ static bool compat_policy_input_ok1(CompatPolicyInput policy,
     switch (policy) {
     case COMPAT_POLICY_INPUT_ACCEPT:
         return true;
+    case COMPAT_POLICY_INPUT_WARN:
+        warn_report("%s %s %s disabled by policy",
+                    adjective, kind, name);
+        return true;
     case COMPAT_POLICY_INPUT_REJECT:
         error_set(errp, error_class, "%s %s %s disabled by policy",
                   adjective, kind, name);
diff --git a/qemu-options.hx b/qemu-options.hx
index f72f30e246d..16d9c6c9072 100644
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
@@ -4703,7 +4703,9 @@ SRST
     Set policy for handling deprecated management interfaces (experimental):
 
     ``deprecated-input=accept`` (default)
-        Accept deprecated commands and arguments
+        Accept deprecated commands and arguments silently
+    ``deprecated-input=warn``
+        Accept deprecated commands and arguments with warning on stderr
     ``deprecated-input=reject``
         Reject deprecated commands and arguments
     ``deprecated-input=crash``
@@ -4719,7 +4721,9 @@ SRST
     Set policy for handling unstable management interfaces (experimental):
 
     ``unstable-input=accept`` (default)
-        Accept unstable commands and arguments
+        Accept unstable commands and arguments silently
+    ``unstable-input=warn``
+        Accept unstable commands and arguments with warning on stderr
     ``unstable-input=reject``
         Reject unstable commands and arguments
     ``unstable-input=crash``
-- 
2.56.0


