Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6977CD15DB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v8u-0004Um-LV; Mon, 21 Oct 2024 12:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8j-0004JG-BA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2v8h-00047z-Kx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVieedyPJlknzVmD9/TMYpfZlftz/s1bAD6yv7JeyO8=;
 b=G6jnqsnctE0CAfV7ljv17U3KwpEbUfGri6+NZ/DaWuF8k7VNe5/kEEajEY0QrFWpurtXB3
 SCu0OhyIAct3OY7Y0scKCppcEMnFd82DBV3H/t5I4REQvyowkUM5Y369EadBBzkazuNX9D
 +CPStNvIX+eQU+dhIQ5mNg4L2PLV3WQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-jzoSfU1pN1OPYINvDUK4TA-1; Mon,
 21 Oct 2024 12:20:13 -0400
X-MC-Unique: jzoSfU1pN1OPYINvDUK4TA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 466831955F40
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 16:20:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BC301956056; Mon, 21 Oct 2024 16:20:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/6] ui: validate NUL byte padding in SASL client data more
 strictly
Date: Mon, 21 Oct 2024 17:19:57 +0100
Message-ID: <20241021161957.1431919-7-berrange@redhat.com>
In-Reply-To: <20241021161957.1431919-1-berrange@redhat.com>
References: <20241021161957.1431919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When the SASL data is non-NULL, the SASL protocol spec requires that
it is padded with a trailing NUL byte. QEMU discards the trailing
byte, but does not currently validate that it was in fact a NUL.
Apply strict validation to better detect any broken clients.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index a04feeb429..df2825797d 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -263,8 +263,14 @@ static int protocol_client_auth_sasl_step(VncState *vs, uint8_t *data, size_t le
     /* NB, distinction of NULL vs "" is *critical* in SASL */
     if (datalen) {
         clientdata = (char*)data;
-        clientdata[datalen-1] = '\0'; /* Wire includes '\0', but make sure */
-        datalen--; /* Don't count NULL byte when passing to _start() */
+        if (clientdata[datalen-1] != '\0') {
+            trace_vnc_auth_fail(vs, vs->auth, "Malformed SASL client data",
+                                "Missing SASL NUL padding byte");
+            sasl_dispose(&vs->sasl.conn);
+            vs->sasl.conn = NULL;
+            goto authabort;
+        }
+        datalen--; /* Discard the extra NULL byte padding when calling _start() */
     }
 
     err = sasl_server_step(vs->sasl.conn,
@@ -385,8 +391,14 @@ static int protocol_client_auth_sasl_start(VncState *vs, uint8_t *data, size_t l
     /* NB, distinction of NULL vs "" is *critical* in SASL */
     if (datalen) {
         clientdata = (char*)data;
-        clientdata[datalen-1] = '\0'; /* Should be on wire, but make sure */
-        datalen--; /* Don't count NULL byte when passing to _start() */
+        if (clientdata[datalen-1] != '\0') {
+            trace_vnc_auth_fail(vs, vs->auth,  "Malformed SASL client data",
+                                "Missing SASL NUL padding byte");
+            sasl_dispose(&vs->sasl.conn);
+            vs->sasl.conn = NULL;
+            goto authabort;
+        }
+        datalen--; /* Discard the extra NULL byte padding when calling _start() */
     }
 
     err = sasl_server_start(vs->sasl.conn,
-- 
2.46.0


