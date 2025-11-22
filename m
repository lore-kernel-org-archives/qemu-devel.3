Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF515CFD2F3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMuoh-0008Vp-GA; Sat, 22 Nov 2025 16:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuoe-0008VH-9P; Sat, 22 Nov 2025 16:06:44 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuoV-0006hD-Jz; Sat, 22 Nov 2025 16:06:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C40816D302;
 Sun, 23 Nov 2025 00:03:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 24E9B3223D6;
 Sun, 23 Nov 2025 00:03:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 08/25] io: add trace event when cancelling TLS
 handshake
Date: Sat, 22 Nov 2025 23:55:26 +0300
Message-ID: <20251122210344.48374-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
References: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 003f15369de4e290a4d2e58292d96c5a506e4ee6)
(Mjt: pick this commit up so that the next changes applies (more) cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-tls.c b/io/channel-tls.c
index a91efb57f3..686271acf7 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -380,6 +380,7 @@ static int qio_channel_tls_close(QIOChannel *ioc,
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
 
     if (tioc->hs_ioc_tag) {
+        trace_qio_channel_tls_handshake_cancel(ioc);
         g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
     }
 
diff --git a/io/trace-events b/io/trace-events
index 3cc5cf1efd..d4c0f84a9a 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -43,6 +43,7 @@ qio_channel_tls_handshake_start(void *ioc) "TLS handshake start ioc=%p"
 qio_channel_tls_handshake_pending(void *ioc, int status) "TLS handshake pending ioc=%p status=%d"
 qio_channel_tls_handshake_fail(void *ioc) "TLS handshake fail ioc=%p"
 qio_channel_tls_handshake_complete(void *ioc) "TLS handshake complete ioc=%p"
+qio_channel_tls_handshake_cancel(void *ioc) "TLS handshake cancel ioc=%p"
 qio_channel_tls_credentials_allow(void *ioc) "TLS credentials allow ioc=%p"
 qio_channel_tls_credentials_deny(void *ioc) "TLS credentials deny ioc=%p"
 
-- 
2.47.3


