Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C209D690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcIo-0000ex-CQ; Thu, 28 Nov 2024 06:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1tGcIg-0000do-5u; Thu, 28 Nov 2024 06:03:10 -0500
Received: from smtpnm6-12.21cn.com ([182.42.119.59] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>)
 id 1tGcId-0003Az-Bx; Thu, 28 Nov 2024 06:03:09 -0500
HMM_SOURCE_IP: 192.168.137.232:0.1841577584
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-139.200.108.9 (unknown [192.168.137.232])
 by chinatelecom.cn (HERMES) with SMTP id 32438110001B2;
 Thu, 28 Nov 2024 18:53:33 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([139.200.108.9])
 by gateway-ssl-dep-6977f57994-b9pvf with ESMTP id
 6551d32c43094d3f94e4e04567072c54 for eblake@redhat.com; 
 Thu, 28 Nov 2024 18:53:36 CST
X-Transaction-ID: 6551d32c43094d3f94e4e04567072c54
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 139.200.108.9
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn
Subject: [PATCH 2/2] qapi/crypto: support enable encryption/decryption in
 parallel
Date: Thu, 28 Nov 2024 18:51:22 +0800
Message-Id: <608e6ae38d080acdcd1f28d0700b9e0b919ee2db.1732789721.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1732789721.git.tugy@chinatelecom.cn>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
In-Reply-To: <cover.1732789721.git.tugy@chinatelecom.cn>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
Received-SPF: pass client-ip=182.42.119.59; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Guoyi Tu <tugy@chinatelecom.cn>

add encrypt-in-parallel option to enable encryption/decryption
in parallel

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
---
 block/crypto.c       | 8 ++++++++
 block/crypto.h       | 9 +++++++++
 qapi/block-core.json | 6 +++++-
 qapi/crypto.json     | 6 +++++-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index c085f331ce..b02400fb26 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -212,6 +212,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
     .desc = {
         BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ENCRYPT_IN_PARALLEL(""),
         { /* end of list */ }
     },
 };
@@ -347,6 +348,13 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     }
 
     cryptoopts = qemu_opts_to_qdict(opts, NULL);
+
+    if (!g_strcmp0(qdict_get_try_str(cryptoopts,
+                   BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL), "on") ||
+        qdict_get_try_bool(cryptoopts,
+                           BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL, false)) {
+        crypto->encrypt_in_parallel = true;
+    }
     qdict_put_str(cryptoopts, "format", QCryptoBlockFormat_str(format));
 
     open_opts = block_crypto_open_opts_init(cryptoopts, errp);
diff --git a/block/crypto.h b/block/crypto.h
index dc3d2d5ed9..6729420941 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -46,6 +46,7 @@
 #define BLOCK_CRYPTO_OPT_LUKS_STATE "state"
 #define BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET "old-secret"
 #define BLOCK_CRYPTO_OPT_LUKS_NEW_SECRET "new-secret"
+#define BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL "encrypt-in-parallel"
 
 
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
@@ -130,6 +131,14 @@
                 "Empty string to erase",                        \
     }
 
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_ENCRYPT_IN_PARALLEL(prefix)     \
+    {                                                             \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL, \
+        .type = QEMU_OPT_BOOL,                                    \
+        .help = "perform encryption and decryption through "      \
+                "thread pool",                                    \
+    }
+
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QDict *opts, Error **errp);
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fd3bcc1c17..1e47b6ea80 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3365,12 +3365,16 @@
 #
 # @header: block device holding a detached LUKS header.  (since 9.0)
 #
+# @encrypt-in-parallel: perform encryption and decryption through
+#   thread pool
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsLUKS',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { '*key-secret': 'str',
-            '*header': 'BlockdevRef'} }
+            '*header': 'BlockdevRef',
+            '*encrypt-in-parallel': 'bool'} }
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
diff --git a/qapi/crypto.json b/qapi/crypto.json
index c9d967d782..91963c693f 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -192,10 +192,14 @@
 #     decryption key.  Mandatory except when probing image for
 #     metadata only.
 #
+# @encrypt-in-parallel: perform encryption and decryption through
+#   thread pool
+#
 # Since: 2.6
 ##
 { 'struct': 'QCryptoBlockOptionsLUKS',
-  'data': { '*key-secret': 'str' }}
+  'data': { '*key-secret': 'str',
+            '*encrypt-in-parallel': 'bool' }}
 
 ##
 # @QCryptoBlockCreateOptionsLUKS:
-- 
2.17.1


