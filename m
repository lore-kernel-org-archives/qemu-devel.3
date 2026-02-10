Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243F5EA8109
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmk5-0004M1-VR; Tue, 10 Feb 2026 07:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmii-0000Vd-71; Tue, 10 Feb 2026 07:19:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmig-0001qL-5w; Tue, 10 Feb 2026 07:19:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2222187DE3;
 Tue, 10 Feb 2026 15:16:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F34C360CF7;
 Tue, 10 Feb 2026 15:17:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, zhenwei pi <pizhenwei@tensorfer.com>,
 =?UTF-8?q?=EC=9D=B4=EC=9E=AC=EC=98=81?= <nakamurajames123@gmail.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 79/85] hw/virtio/virtio-crypto: verify asym request
 size
Date: Tue, 10 Feb 2026 15:16:43 +0300
Message-ID: <20260210121657.69363-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260210151548@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260210151548@cover.tls.msk.ru>
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

The total lenght of request is limited by cryptodev config, verify it
to avoid unexpected request from guest.

Fixes: CVE-2025-14876
Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
Reported-by: 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251221024321.143196-2-zhenwei.pi@linux.dev>
(cherry picked from commit 91c6438caffc880e999a7312825479685d659b44)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index a1b3c90618..3a3de080a4 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -767,11 +767,18 @@ virtio_crypto_handle_asym_req(VirtIOCrypto *vcrypto,
     uint32_t len;
     uint8_t *src = NULL;
     uint8_t *dst = NULL;
+    uint64_t max_len;
 
     asym_op_info = g_new0(CryptoDevBackendAsymOpInfo, 1);
     src_len = ldl_le_p(&req->para.src_data_len);
     dst_len = ldl_le_p(&req->para.dst_data_len);
 
+    max_len = (uint64_t)src_len + dst_len;
+    if (unlikely(max_len > vcrypto->conf.max_size)) {
+        virtio_error(vdev, "virtio-crypto asym request is too large");
+        goto err;
+    }
+
     if (src_len > 0) {
         src = g_malloc0(src_len);
         len = iov_to_buf(iov, out_num, 0, src, src_len);
-- 
2.47.3


