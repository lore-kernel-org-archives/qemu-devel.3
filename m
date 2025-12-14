Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C3D5B16D
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 15:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUnZE-0003BP-Q3; Sun, 14 Dec 2025 09:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vUi7n-000201-Nd
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 04:10:43 -0500
Received: from out-170.mta0.migadu.com ([91.218.175.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vUi7k-00039E-NQ
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 04:10:43 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1765703438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjccH9cASOhv8Xqy6ggla8HIcFFiQvPnmz2kFeaGjjw=;
 b=GE/rM1eyP6iMkeIurBP06z4wXr4YKlSPOEicEC6ZRHNO5eEFG6K+R8+cgYlNEcJdyh9Z4m
 xru7Jt2798iZsef0DV5sVSmW7eCuM0UZQ3Gk9TJD9VmDka8l2JiMTiRgN1JHD7Xz3LwkXp
 UD/rczU4Z8XaZIpWs/rzCILIMYM++NE=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, nakamurajames123@gmail.com,
 qemu-security@nongnu.org, mcascell@redhat.com,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH 2/2] cryptodev-builtin: Limit the maximum size
Date: Sun, 14 Dec 2025 17:09:39 +0800
Message-ID: <20251214090939.408436-3-zhenwei.pi@linux.dev>
In-Reply-To: <20251214090939.408436-1-zhenwei.pi@linux.dev>
References: <20251214090939.408436-1-zhenwei.pi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.170; envelope-from=zhenwei.pi@linux.dev;
 helo=out-170.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 14 Dec 2025 09:59:22 -0500
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

This backend driver is used for demonstration purposes only, unlimited
size leads QEMU OOM.

Fixes: 1653a5f3fc7 ("cryptodev: introduce a new cryptodev backend")
Reported-by: AM 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 backends/cryptodev-builtin.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

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
2.43.0


