Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00907112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNX-0004jI-J7; Wed, 11 Mar 2026 15:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNV-0004dX-6t; Wed, 11 Mar 2026 15:37:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNT-0000VG-Ln; Wed, 11 Mar 2026 15:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=snqvXBZiy7swWW5vj6bRvOATZK4yLblfbZJNO3MMtsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ka+aB5vtWb85H8nIL37trQMwmrkVq5Qh6/T+Qaq8zRfs52+DetSv4AzS+lHVzLryw
 HLGdBngqUHQheKXPqQZPPTiaQWUM+aBW54bG7RdeWcLeyVhqepzzIJHOu7xAUaztOS
 r2APWhqsVflKZPMZ2Sy7c7Vi01qIuM+0J5MHkJ1cah/v73eGOUMNhMVMliN4hJxV/w
 ueYMNCpLNGGG/HDWLJx8MF7c0129dJaRyOS/ZaWiYfFNqtyWs/KOkIZ0e8uiV7r8c4
 yf/mDoCzP1B4bLtAbLOJTTtsLZmNYI15wd/BzGd1bCLXbynDNoRCDx5sgXa9qWQzHF
 lMnvZQ1SbkSzg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ED74719210B;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 318A837C470;
 Wed, 11 Mar 2026 22:35:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "Halil Oktay (oblivionsage)" <cookieandcream560@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 35/53] block/vmdk: fix OOB read in vmdk_read_extent()
Date: Wed, 11 Mar 2026 22:34:28 +0300
Message-ID: <20260311193449.1096110-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Halil Oktay (oblivionsage)" <cookieandcream560@gmail.com>

Bounds check for marker.size doesn't account for the 12-byte marker
header, allowing zlib to read past the allocated buffer.

Move the check inside the has_marker block and subtract the marker size.

Fixes: CVE-2026-2243
Reported-by: Halil Oktay (oblivionsage) <cookieandcream560@gmail.com>
Signed-off-by: Halil Oktay (oblivionsage) <cookieandcream560@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit cfda94eddb6c9c49b66461c950b22845a46a75c9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vmdk.c b/block/vmdk.c
index 89e89cd10e..cd8b4ec7c8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1951,10 +1951,10 @@ vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
         marker = (VmdkGrainMarker *)cluster_buf;
         compressed_data = marker->data;
         data_len = le32_to_cpu(marker->size);
-    }
-    if (!data_len || data_len > buf_bytes) {
-        ret = -EINVAL;
-        goto out;
+        if (!data_len || data_len > buf_bytes - sizeof(VmdkGrainMarker)) {
+            ret = -EINVAL;
+            goto out;
+        }
     }
     ret = uncompress(uncomp_buf, &buf_len, compressed_data, data_len);
     if (ret != Z_OK) {
-- 
2.47.3


