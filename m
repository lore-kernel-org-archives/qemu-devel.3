Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A15606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=mbCwrJpb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OV-0005RO-2I; Mon, 16 Nov 2026 15:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Md-00025E-KP; Mon, 16 Nov 2026 15:31:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3MV-0004do-7R; Mon, 16 Nov 2026 15:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860766; bh=vus36do5RiczT+DgjZYEE3JlkMMlk10cdqgZxHDKPTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mbCwrJpbPS2+uHCn8lA4eJofmMLwqyrhZ+pwaWYvJwHaGbZj9SDUsqPkMLcCute+N
 9AGJZSgdGR+5s6cshuR9TfMZ+91a+AsAdwuu/z3IP7dvIKVLzkEvfUhdL3dWArazL3
 DxJ1Nzc0HAzg7d2w51lXnUxJsdYT54YNFceMIhaxXhqYqMUvGvOg6PyF2N7X3oeCKu
 GosDkUKWlD0hLzoCk3bzCIif7oubhggUvfahOk9wWxl1GnjF4QGvLNOPx9x24vKOpV
 xmnQpvcPvV1cGxTG7b07+HXHiGEW6DQtu7MwYwgNQP0fM2lPPDO3ZS/oEDGPYhQLoi
 JXlbzdiAdQA9Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D87471E71C7;
 Mon, 16 Nov 2026 23:26:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D41A545FBF3;
 Mon, 16 Nov 2026 23:26:06 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C8EACB8EAA; Mon, 16 Nov 2026 23:26:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 boy juju <agx1657748706@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 50/63] block/vmdk: Use larger types for byte counts in
 vmdk_read_extent()
Date: Mon, 16 Nov 2026 23:25:29 +0300
Message-ID: <20261116202554.535325-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In vmdk_read_extent() we use 'int' for cluster_bytes and buf_bytes.
However, cluster_bytes is extent->cluster_sectors * 512 and buf_bytes
is cluster_bytes * 2.  The maximum value for extent->cluster_sectors
(enforced in vmdk_add_extent()) is 0x20_0000, and so the worst case
for buf_bytes is 0x8000_0000, which overflows a signed int.

Make the variable types here int64_t, which matches the type used by
bdrv_co_pread()'s bytes argument and by extent->cluster_sectors.

The worst case thing that a malicious VMDK image could do is cause us
to try to g_malloc() 0xffffffff80000000, which will cause QEMU to
abort(), so this is a self-denial-of-service only, and so a hardening
bug rather than a security issue.

Cc: qemu-stable@nongnu.org
Fixes: 2b2c8c5dec6ba ("VMDK: read/write compressed extent")
Reported-by: boy juju <agx1657748706@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3843
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-4-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 53c06d5239b4a4cc21686710bce478207dfbaa6e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vmdk.c b/block/vmdk.c
index bc672107158..104f8da9d93 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1929,7 +1929,7 @@ vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
                  int64_t offset_in_cluster, QEMUIOVector *qiov, int bytes)
 {
     int ret;
-    int cluster_bytes, buf_bytes;
+    int64_t cluster_bytes, buf_bytes;
     uint8_t *cluster_buf, *compressed_data;
     uint8_t *uncomp_buf;
     uint32_t data_len;
-- 
2.47.3


