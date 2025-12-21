Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A7BE6748D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 02:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vX9QN-0002a6-1b; Sat, 20 Dec 2025 21:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vX9QK-0002Zg-T8
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 21:43:56 -0500
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vX9QJ-000470-Cc
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 21:43:56 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1766285028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmP6Wvk0KETdBC34SFuuuEpsYY5VRmQDyspL0DmBLGA=;
 b=bdnP6y7/N29p2vHUeAbE3WPHfhy9BAWEs1jzkj8RYxRVb/uMoyvnEdorJFCoPhurP4xlDc
 E7Dz+4lByNjdCJsdZA9sgfKeU9OPRXaAv/sqYAN36MCOIPpUhVrZQfS8CDA+diL7TJH3y+
 Tz9zJtp75uolczxPG2BofeKWSJzQuis=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, mcascell@redhat.com,
 nakamurajames123@gmail.com, zhenwei pi <pizhenwei@tensorfer.com>,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v2 2/2] cryptodev-builtin: Limit the maximum size
Date: Sun, 21 Dec 2025 10:43:21 +0800
Message-ID: <20251221024321.143196-3-zhenwei.pi@linux.dev>
In-Reply-To: <20251221024321.143196-1-zhenwei.pi@linux.dev>
References: <20251221024321.143196-1-zhenwei.pi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b4;
 envelope-from=zhenwei.pi@linux.dev; helo=out-180.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: zhenwei pi <pizhenwei@tensorfer.com>

This backend driver is used for demonstration purposes only, unlimited
size leads QEMU OOM.

Fixes: CVE-2025-14876
Fixes: 1653a5f3fc7 ("cryptodev: introduce a new cryptodev backend")
Reported-by: 이재영 <nakamurajames123@gmail.com>
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


