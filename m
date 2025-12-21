Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA5E67495
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 02:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vX9QP-0002an-FX; Sat, 20 Dec 2025 21:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vX9QO-0002aM-3V
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 21:44:00 -0500
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1vX9QM-00046B-Nt
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 21:43:59 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1766285020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEgYMzOvq6jxNIvTmv23gY/0hM5CAwJFQpxXwpO4+9E=;
 b=IEhib4SKB2fkICaS6LBHf226uB4yiugK01zcxa+/Fh/CbVEgAT1L0WTnp/hUkv/LcMJYaP
 /oFOyDP6XCVsuqeh8nbXO19hdsK7wZNo4/E3Hask0s6uSLeHp289FWAZL74tYKx6OaQBdy
 MwVNLjbfCCy8baseGgLNO9AkxiP1OoA=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, mcascell@redhat.com,
 nakamurajames123@gmail.com, zhenwei pi <pizhenwei@tensorfer.com>,
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v2 1/2] hw/virtio/virtio-crypto: verify asym request size
Date: Sun, 21 Dec 2025 10:43:20 +0800
Message-ID: <20251221024321.143196-2-zhenwei.pi@linux.dev>
In-Reply-To: <20251221024321.143196-1-zhenwei.pi@linux.dev>
References: <20251221024321.143196-1-zhenwei.pi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b7;
 envelope-from=zhenwei.pi@linux.dev; helo=out-183.mta0.migadu.com
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

The total lenght of request is limited by cryptodev config, verify it
to avoid unexpected request from guest.

Fixes: CVE-2025-14876
Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
Reported-by: 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 hw/virtio/virtio-crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 517f2089c5..b20f299937 100644
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
2.43.0


