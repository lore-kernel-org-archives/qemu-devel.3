Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E106E112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEM-0007P6-01; Wed, 11 Mar 2026 11:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCA-0002RI-6T; Wed, 11 Mar 2026 11:09:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LC8-0005mz-QM; Wed, 11 Mar 2026 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241483; bh=uIKZ9OHCybJ/gZkACDfYorTkJXG2LgGPSPVro8zrSvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kQEl0AHtM41lDJ3E/WfFfBYBLE7kpxR/XX9Yz8siFoh+X5RP6JMvMgTcR3/XX88OR
 ZPeAs+VOAupsd4iEOcLQpUxDR4SZr2vr1KeG0+btlX+YO2TJYIVIniyhxy3juGUlOc
 Z3W+u/6jarLPs82iPFKn3Cz74RP6Fh6V+L6GCVTy+1gZNec6z3W+zdFZIoKI1mogYQ
 18kdHnYCZmgMxwUrAZ9BjHSOrKhYWnUwen8JXIz6TB8x6abYsIGCN0dwTYz/BYRAvp
 nHKXZYTh0KIeiF+b7p5OPvJP4KOnXDth2dCtjmMARQGsuzr3v0Isw4fEHgQqT5swVR
 428/ZACITSjlg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5272B191EA3;
 Wed, 11 Mar 2026 18:04:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 36A8937C2E4;
 Wed, 11 Mar 2026 18:05:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "Halil Oktay (oblivionsage)" <cookieandcream560@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 32/46] block/vmdk: fix OOB read in vmdk_read_extent()
Date: Wed, 11 Mar 2026 18:03:08 +0300
Message-ID: <20260311150327.1084669-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
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
index 64051d55aa..af9387ee0e 100644
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


