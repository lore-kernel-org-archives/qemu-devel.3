Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F0BCD8C8B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVloq-0000yC-DE; Sat, 06 Jun 2026 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wVlof-0000vg-7s
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 03:51:38 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wVloY-0002J5-Ur
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 03:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sx
 IjUI9grN9Ty2SfPalUrMOa43GiZ4mSE6hcB6PipsM=; b=VNUv7/5gA605TNi1Cx
 u0Ba82J++30fHpw9cV5v7tFJDx2AJyCs57wLvWwx38wsl/1fS6IUb1btdE0cr/8j
 EQ8uwVvFNAt8FSNlM72/7DyPl2AJ2+U39QdXkGa0qgYDdMSBtQj0BTgQXGLOAsjL
 RY0aSbMzDpMtgR3MPFj7jKVCE=
Received: from zinogre.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wCXn8yu0CNqsSoBBw--.35717S3; 
 Sat, 06 Jun 2026 15:48:01 +0800 (CST)
From: helei <lhestz@163.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, mst@redhat.com,
 helei <lhestz@163.com>
Subject: [PATCH] hw/virtio-crypto: enforce max akcipher key length
Date: Sat,  6 Jun 2026 15:47:56 +0800
Message-ID: <20260606074756.43804-2-lhestz@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606074756.43804-1-lhestz@163.com>
References: <20260606074756.43804-1-lhestz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXn8yu0CNqsSoBBw--.35717S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4fur4xWFyktw4xWF4fAFb_yoW8Gw13pr
 15J39Y9rZ8W3W7Kas3J3WSgry5Ca9xCF12kFWSgFZruF15Cw1vq3Wfu3W0grW3Zr48Gw1x
 ZrW8JFyvg34DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zipVbkUUUUU=
X-Originating-IP: [2409:8a00:18c7:4890:f871:89bf:55b1:618]
X-CM-SenderInfo: pokh23r26rljoofrz/xtbC0hHD7moj0LE0dAAA3G
Received-SPF: pass client-ip=220.197.31.4; envelope-from=lhestz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Introduce VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN. We set this hard
limit to 1MB, which mirrors the linux kernel's internal payload
restriction for the 'add_key' syscall.

Signed-off-by: helei <lhestz@163.com>
---
 hw/virtio/virtio-crypto.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 6fceb39681..06be93a0ac 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -25,6 +25,13 @@
 #include "system/cryptodev-vhost.h"
 
 #define VIRTIO_CRYPTO_VM_VERSION 1
+/*
+ * The virtio-crypto spec does not limit akcipher key lengths. To prevent
+ * guest-introduced OOM attacks via excessive host memory allocation, we
+ * enforce a 1MB limit. This aligns with the linux kernel's internal max
+ * payload limit for the add_key syscall.
+ */
+#define VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN ((1024 * 1024) - 1)
 
 typedef struct VirtIOCryptoSessionReq {
     VirtIODevice *vdev;
@@ -216,6 +223,12 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
+    if (keylen > VIRTIO_CRYPTO_MAX_AKCIPHER_KEY_LEN) {
+        error_report("virtio-crypto length of akcipher key is too large: %u",
+                     keylen);
+        return -VIRTIO_CRYPTO_ERR;
+    }
+
     if (keylen) {
         asym_info->key = g_malloc(keylen);
         if (iov_to_buf(iov, out_num, 0, asym_info->key, keylen) != keylen) {
-- 
2.43.0


