Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F8C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVsuV-00009G-NX; Mon, 22 Jul 2024 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuC-0008Sa-2R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsu9-0007b9-0T
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721654199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gk4rCoCpCVDctVcDfpO3boXvsn1RZsX53vx5eXStXjw=;
 b=MzsvZ4SF1D2xFqEBLk42a/Mx/O3F7pFYJJ0DexKv1tsTqfQ1YpX33SdNGbave2bsublwcK
 aiGRpk1r2WrQ69cvus3pKeGCiOYBYUfsoW1SCxnFajO2b/v3BAWn8jFYzxq5Tr8vlhuG0I
 AkLVXD995gzxqqT9hPaRdX7ztk1WjVU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-XIrgixGVP4mqPpRH8lohgw-1; Mon,
 22 Jul 2024 09:16:37 -0400
X-MC-Unique: XIrgixGVP4mqPpRH8lohgw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99B3819792E4; Mon, 22 Jul 2024 13:16:36 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBE15193495B; Mon, 22 Jul 2024 13:16:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] crypto: drop gnutls debug logging support
Date: Mon, 22 Jul 2024 14:16:09 +0100
Message-ID: <20240722131611.2820041-4-berrange@redhat.com>
In-Reply-To: <20240722131611.2820041-1-berrange@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GNUTLS already supports dynamically enabling its logging at runtime by
setting the env var 'GNUTLS_DEBUG_LEVEL=10', so there is no need to
re-invent this logic in QEMU in a way that requires a re-compile.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/init.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/crypto/init.c b/crypto/init.c
index fb7f1bff10..2d6dfa3091 100644
--- a/crypto/init.c
+++ b/crypto/init.c
@@ -34,13 +34,6 @@
 
 #include "crypto/random.h"
 
-/* #define DEBUG_GNUTLS */
-#ifdef DEBUG_GNUTLS
-static void qcrypto_gnutls_log(int level, const char *str)
-{
-    fprintf(stderr, "%d: %s", level, str);
-}
-#endif
 
 int qcrypto_init(Error **errp)
 {
@@ -53,10 +46,6 @@ int qcrypto_init(Error **errp)
                    gnutls_strerror(ret));
         return -1;
     }
-#ifdef DEBUG_GNUTLS
-    gnutls_global_set_log_level(10);
-    gnutls_global_set_log_function(qcrypto_gnutls_log);
-#endif
 #endif
 
 #ifdef CONFIG_GCRYPT
-- 
2.45.2


