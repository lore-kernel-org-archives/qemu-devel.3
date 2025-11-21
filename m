Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB9BCF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd7B-0004oE-Mn; Fri, 21 Nov 2025 21:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcoj-0004dW-PJ; Fri, 21 Nov 2025 20:53:38 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcmh-00062d-3A; Fri, 21 Nov 2025 20:53:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C401716CA47;
 Fri, 21 Nov 2025 21:44:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7873A321C83;
 Fri, 21 Nov 2025 21:44:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 12/81] io: release active GSource in TLS channel
 finalizer
Date: Fri, 21 Nov 2025 21:43:11 +0300
Message-ID: <20251121184424.1137669-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Daniel P. Berrangé <berrange@redhat.com>

While code is supposed to call qio_channel_close() before releasing the
last reference on an QIOChannel, this is not guaranteed. QIOChannelFile
and QIOChannelSocket both cleanup resources in their finalizer if the
close operation was missed.

This ensures the TLS channel will do the same failsafe cleanup.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 2c147611cf568eb1cd7dc8bf4479b272bad3b9d6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-tls.c b/io/channel-tls.c
index caf8301a9e..f8b03aa63c 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -337,6 +337,16 @@ static void qio_channel_tls_finalize(Object *obj)
 {
     QIOChannelTLS *ioc = QIO_CHANNEL_TLS(obj);
 
+    if (ioc->hs_ioc_tag) {
+        trace_qio_channel_tls_handshake_cancel(ioc);
+        g_clear_handle_id(&ioc->hs_ioc_tag, g_source_remove);
+    }
+
+    if (ioc->bye_ioc_tag) {
+        trace_qio_channel_tls_bye_cancel(ioc);
+        g_clear_handle_id(&ioc->bye_ioc_tag, g_source_remove);
+    }
+
     object_unref(OBJECT(ioc->master));
     qcrypto_tls_session_free(ioc->session);
 }
-- 
2.47.3


