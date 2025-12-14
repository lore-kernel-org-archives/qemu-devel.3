Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA977D59D99
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 14:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUnZE-0003Au-09; Sun, 14 Dec 2025 09:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vUi7m-0001zj-BB
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 04:10:43 -0500
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vUi7j-00038u-Kf
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 04:10:42 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1765703430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iggrNO2Dxvo63J6+OiyErUibEGZbf8duM3p5uId6vEI=;
 b=s618xGAmYnw0cT9pZlPoJHMMHAYVuh24aeCQdmwkbNRiZAqw8RAG9+PWI/AWLqnt69eLl4
 JpNPddKfVOWusUzavyIpNp4JyN9B1JpqTJXaffSShjPs7WqZKWrybi7XTTrVfqiaglQaU0
 z9uR1irP/4+y9JC4OU3B+uSnaGeDO8Y=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, nakamurajames123@gmail.com,
 qemu-security@nongnu.org, mcascell@redhat.com,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH 1/2] hw/virtio/virtio-crypto: verify asym request size
Date: Sun, 14 Dec 2025 17:09:38 +0800
Message-ID: <20251214090939.408436-2-zhenwei.pi@linux.dev>
In-Reply-To: <20251214090939.408436-1-zhenwei.pi@linux.dev>
References: <20251214090939.408436-1-zhenwei.pi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ae;
 envelope-from=zhenwei.pi@linux.dev; helo=out-174.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The total lenght of request is limited by cryptodev config, verify it
to avoid unexpected request from guest.

Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
Reported-by: AM 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 hw/virtio/virtio-crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 517f2089c5..94dbf9d92d 100644
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
 
+    max_len = src_len + dst_len;
+    if (unlikely(max_len > vcrypto->conf.max_size)) {
+        virtio_error(vdev, "virtio-crypto asym too big length");
+        goto err;
+    }
+
     if (src_len > 0) {
         src = g_malloc0(src_len);
         len = iov_to_buf(iov, out_num, 0, src, src_len);
-- 
2.43.0


