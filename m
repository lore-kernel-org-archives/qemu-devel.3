Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7F5EA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmim-0000u7-TF; Tue, 10 Feb 2026 07:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmgn-0004l0-HO; Tue, 10 Feb 2026 07:17:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmgl-00012A-AH; Tue, 10 Feb 2026 07:17:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 287F7187DC0;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6CC0360CE5;
 Tue, 10 Feb 2026 15:15:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, zhenwei pi <pizhenwei@tensorfer.com>,
 =?UTF-8?q?=EC=9D=B4=EC=9E=AC=EC=98=81?= <nakamurajames123@gmail.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 88/95] cryptodev-builtin: Limit the maximum size
Date: Tue, 10 Feb 2026 15:15:10 +0300
Message-ID: <20260210121526.68598-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
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

From: zhenwei pi <pizhenwei@tensorfer.com>

This backend driver is used for demonstration purposes only, unlimited
size leads QEMU OOM.

Fixes: CVE-2025-14876
Fixes: 1653a5f3fc7 ("cryptodev: introduce a new cryptodev backend")
Reported-by: 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251221024321.143196-3-zhenwei.pi@linux.dev>
(cherry picked from commit 7b913094c703641a0442bb1d1165323a019c591c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 0414c01e06..55a3fbd27b 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -53,6 +53,8 @@ typedef struct CryptoDevBackendBuiltinSession {
 
 #define CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN    512
 #define CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN  64
+/* demonstration purposes only, use a limited size to avoid QEMU OOM */
+#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
 
 struct CryptoDevBackendBuiltin {
     CryptoDevBackend parent_obj;
@@ -98,12 +100,7 @@ static void cryptodev_builtin_init(
                          1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_MAC;
     backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
     backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
-    /*
-     * Set the Maximum length of crypto request.
-     * Why this value? Just avoid to overflow when
-     * memory allocation for each crypto request.
-     */
-    backend->conf.max_size = LONG_MAX - sizeof(CryptoDevBackendOpInfo);
+    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;
     backend->conf.max_cipher_key_len = CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN;
     backend->conf.max_auth_key_len = CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN;
     cryptodev_builtin_init_akcipher(backend);
-- 
2.47.3


