Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7517FCC056
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya3z-0000xF-1H; Fri, 06 Mar 2026 13:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya3x-0000w7-Dv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya3v-00062J-Rj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772822291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/ixJwhTmLKE/B7wma8nXLs9K2IWlmY5qpGMeH3Ckr8=;
 b=T+YlMJQ9tgFZDT5q4qPefBj58IX8Uyq7VGqy5h/4jS2zLL1nanSkKzjsKhkz7IxcfM4lkA
 QXuFYL40wlXkXWr2/54vW/irIrQQCTg005Hr4eAMHO+VpwrXziyvpuulTG3UPsE7Bf5BrA
 a/AoPf38DqwWaRnktc9YRYSiMMGWglM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-0Tgacjh-NRqdT-K_0VO7_Q-1; Fri,
 06 Mar 2026 13:38:09 -0500
X-MC-Unique: 0Tgacjh-NRqdT-K_0VO7_Q-1
X-Mimecast-MFC-AGG-ID: 0Tgacjh-NRqdT-K_0VO7_Q_1772822288
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78F93195608E; Fri,  6 Mar 2026 18:38:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5545F1800576; Fri,  6 Mar 2026 18:38:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/12] block/vmdk: fix OOB read in vmdk_read_extent()
Date: Fri,  6 Mar 2026 19:36:54 +0100
Message-ID: <20260306183705.410357-2-kwolf@redhat.com>
In-Reply-To: <20260306183705.410357-1-kwolf@redhat.com>
References: <20260306183705.410357-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block/vmdk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 89e89cd10e3..cd8b4ec7c88 100644
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
2.53.0


