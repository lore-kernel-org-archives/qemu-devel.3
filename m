Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BC4CDE008
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchXF-00056g-SQ; Thu, 25 Jun 2026 06:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wchXD-00056D-8C
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:42:15 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wchX1-0006iY-KW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=G0
 ytJBKH6ieo2ArfDwfcC6VgasgMg/pQ2KxrNKkOdlY=; b=erSzAm/VwytZ7UzagU
 i9/e/Bh0G+T2dXqsM78RdPL+6LtYYdmMjFjkshy82G6YhnwcM27yQWmcWX/SCDhv
 glapkMGg4h9pBj+iIQVktgTLgxAVaDHj4iRKtsboPordKpqdEJ6A6qoRk2qB961w
 niHVcb4ZaULqV375+LpLLDhNU=
Received: from zinogre.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgBXQmosBT1qIiv2DQ--.25072S3;
 Thu, 25 Jun 2026 18:38:37 +0800 (CST)
From: helei <lhestz@163.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, mst@redhat.com,
 helei <lhestz@163.com>
Subject: [PATCH RESEND v2 1/1] hw/virtio-crypto: enforce max akcipher key
 length
Date: Thu, 25 Jun 2026 18:38:36 +0800
Message-ID: <20260625103836.3835-2-lhestz@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625103836.3835-1-lhestz@163.com>
References: <20260625103836.3835-1-lhestz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgBXQmosBT1qIiv2DQ--.25072S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWDuw4DZF47KF48Gw4Durg_yoW3urb_A3
 yku3yxWw4rXF10va1UArWrWr12g3WfAFnF9FZIg3W8A3Wxta1DJF1xJrs5WF47Z3y8JF45
 GF45Ars0gw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRD9ND5UUUUU==
X-Originating-IP: [117.129.70.70]
X-CM-SenderInfo: pokh23r26rljoofrz/xtbC8w02YWo9BS1gxQAA3z
Received-SPF: pass client-ip=117.135.210.5; envelope-from=lhestz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

enforce the global max_size boundary for akcipher session creation

Signed-off-by: helei <lhestz@163.com>
---
 hw/virtio/virtio-crypto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 6fceb39681..79e2acb56c 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -216,6 +216,12 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
+    if (unlikely(keylen > vcrypto->conf.max_size)) {
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


