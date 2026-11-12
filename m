Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F5606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=btqtAp2G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXzD-0005SV-Ex; Thu, 12 Nov 2026 11:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRXz8-0005Os-W3
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRXz7-0003IR-AG
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794502153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qJHH2x1pQ+RxwoURxRdlSdV6WKbs/a4dytfUZ8d+mQ=;
 b=btqtAp2G2LPAzslYshVYAGD2kW18wYT7BnJaDNEAnXeIT0gbsQPGffbAnUhlm8eFUuu7a0
 MeSwr8a9DmkTWzxIrmkAMGru/+gqpAd/OSyedfNG0RZWZ9U06vWoTek5ZGIuTLvBO4snjx
 kTK9dwEYU0uS3U4qsmHT1cuUF3Jylwk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-FiUifY4dNgmIuLSHqgc7Aw-1; Thu,
 12 Nov 2026 11:49:07 -0500
X-MC-Unique: FiUifY4dNgmIuLSHqgc7Aw-1
X-Mimecast-MFC-AGG-ID: FiUifY4dNgmIuLSHqgc7Aw_1794502146
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1E6919560AD; Thu, 12 Nov 2026 16:49:06 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 664C4410; Thu, 12 Nov 2026 16:49:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/2] qapi: correctly mark 'ignore-unavailable' deprecated
Date: Thu, 12 Nov 2026 16:48:57 +0000
Message-ID: <20261112164857.2083799-3-berrange@redhat.com>
In-Reply-To: <20261112164857.2083799-1-berrange@redhat.com>
References: <20261112164857.2083799-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Follow the proper QAPI syntax for deprecations and mention it
in the documentation.

Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/deprecated.rst |  8 ++++++++
 qapi/trace.json           | 10 ++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0891bbc44de..a39feb23f5b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -182,6 +182,14 @@ execution.  This special treatment of ``"no"`` is deprecated.  Use an
 empty string instead.  In a future version, ``"no"`` will be treated as
 a plain file name.
 
+``ignore-unavailable`` in ``trace-event-set-state`` (since 11.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Trace events are now unconditionally built-in to all QEMU builds,
+so the concept of an 'unavailable' trace event no longer exists.
+The ``ignore-unavailable`` parameter in ``trace-event-set-state``
+thus has no effect and should no longer be used.
+
 Human Machine Protocol (HMP) commands
 -------------------------------------
 
diff --git a/qapi/trace.json b/qapi/trace.json
index 8533e378977..5792a436115 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -67,10 +67,14 @@
 # @enable: Whether to enable tracing.
 #
 # @ignore-unavailable: Do not match unavailable events with @name.
-#      Deprecated: since 11.2
 #
 # Since: 2.2
 #
+# Features:
+#
+# @deprecated: @ignore-unavailable no longer has any effect
+#    (since 11.2)
+#
 # .. qmp-example::
 #
 #     -> { "execute": "trace-event-set-state",
@@ -78,4 +82,6 @@
 #     <- { "return": {} }
 ##
 { 'command': 'trace-event-set-state',
-  'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool' } }
+  'data': {'name': 'str', 'enable': 'bool',
+           '*ignore-unavailable': { 'type': 'bool',
+                                    'features': ['deprecated'] } } }
-- 
2.56.1


