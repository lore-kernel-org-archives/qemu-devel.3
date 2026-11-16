Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36264606A894
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=frmFNkRl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OZ-0005hW-Dw; Mon, 16 Nov 2026 15:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Mm-0002CM-J7; Mon, 16 Nov 2026 15:31:55 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3MY-0004g9-TQ; Mon, 16 Nov 2026 15:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860767; bh=c4/EHS+/3cyG5IEqMLj4RUQYR7wmamFl9UBw1DrFxlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=frmFNkRlpnNCeAHwL3VWrkh26qRyYQEZvXsx3tqwlsWP/UCa9FPW6O3WHALcUlP1T
 heRawoaT3k4ZYgOAekDilRb88wvl/Uub9VoGbKvvvDIDCxWIxHGM9K0txcpFuFlS0j
 GkB65bAjpCQa/SksdgqX9JaXW/991aP7qx0aqLpWNbMLUlPIkHVt3NkGLguxuNR/sZ
 ZBs1wit7eej+PrbHJlMOVkJFw1XaDOsNwiw9/UWezgouEGrsG+YpWmicUbyQoVW/Hj
 hC+rIv38xQnc5UmE1U9mYC5AvrsX5AEQh9XLqGYOXxalTpZyqYkaUntKdZ2XoGG0Eg
 jCtsBqpXjDDBQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 639861E71C8;
 Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FEC845FBF4;
 Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 58472B8EAC; Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 51/63] block/vmdk: Reject a zero cluster_sectors
 parameter
Date: Mon, 16 Nov 2026 23:25:30 +0300
Message-ID: <20261116202554.535325-51-mjt@tls.msk.ru>
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

In vmdk_add_extent() we reject image files with an excessively large
cluster_sectors parameter, but have no lower bound.  In particular,
if the cluster_sectors is 0 then we will set l1_entry_sectors also to
0, and later crash with a SIGFPE for division by zero.

Reject a zero cluster_sectors value, unless this is a flat extent (in
which case cluster_sectors isn't relevant and the callsite always
passes us zero).

The worst case here is a self-denial-of-service with a QEMU crash,
so this is a hardening bug.

Cc: qemu-stable@nongnu.org
Fixes: b3976d3c8b89 ("VMDK: introduce VmdkExtent")
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4017
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-5-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 09153b7e5f8f90bda4c8d6a2ac39bedc9c6ba373)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vmdk.c b/block/vmdk.c
index 104f8da9d93..a9d32360a4f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -545,6 +545,11 @@ static int vmdk_add_extent(BlockDriverState *bs,
     BDRVVmdkState *s = bs->opaque;
     int64_t nb_sectors;
 
+    if (!flat && cluster_sectors == 0) {
+        error_setg(errp, "Invalid zero granularity, image may be corrupt");
+        return -EINVAL;
+    }
+
     if (cluster_sectors > 0x200000) {
         /* 0x200000 * 512Bytes = 1GB for one cluster is unrealistic */
         error_setg(errp, "Invalid granularity, image may be corrupt");
-- 
2.47.3


