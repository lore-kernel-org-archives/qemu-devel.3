Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49130C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQ4J-0005IS-4D; Thu, 13 Aug 2026 03:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuQ4H-0005I8-5g
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuQ4D-0003Hw-7A
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786606890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CIbpWjUtvkvAnhrymOxcwx4Ktsvc8OETpWaURWWsthY=;
 b=SMg1soDCV/UhQWolt+3+pImKN7vdXlm0EtgevJf8Y/SQ/xD6Z8ptRWObA95g7izN8kCFAT
 KgNCZ8cA1d8GF0pWIVGMF5sIy+xrwyy0Hx+eQg2abz+c/gUXMs7QJLsNBSlG+AOnC6pLVb
 Te6jtlZuUSAFZJEvuRW+znw76uPgDB8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-aFmeWqSlMEi7IxrruDQFow-1; Thu,
 13 Aug 2026 03:40:52 -0400
X-MC-Unique: aFmeWqSlMEi7IxrruDQFow-1
X-Mimecast-MFC-AGG-ID: aFmeWqSlMEi7IxrruDQFow_1786606852
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1AA4195609D
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 07:40:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB23B180049F; Thu, 13 Aug 2026 07:40:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] crypto: fix build against nettle >= 4
Date: Thu, 13 Aug 2026 11:40:48 +0400
Message-ID: <20260813074048.3624651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

sha.h has been deprecated. It seems we could just rely on sha1.h/sha2.h
for older versions too, but I didn't check.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4184
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 crypto/hash-nettle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 53f68301efb5..c0ebb44e11f0 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -23,8 +23,14 @@
 #include "qapi/error.h"
 #include "crypto/hash.h"
 #include "hashpriv.h"
+#include <nettle/version.h>
 #include <nettle/md5.h>
+#if NETTLE_VERSION_MAJOR >= 4
+#include <nettle/sha1.h>
+#include <nettle/sha2.h>
+#else
 #include <nettle/sha.h>
+#endif
 #include <nettle/ripemd160.h>
 #ifdef CONFIG_CRYPTO_SM3
 #include <nettle/sm3.h>
-- 
2.55.0.543.g5ebe2ebe4ea8


