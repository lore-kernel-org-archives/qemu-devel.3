Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689ECE9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFwY-00025c-0L; Mon, 29 Dec 2025 11:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vaFwL-0001wm-0M; Mon, 29 Dec 2025 11:17:49 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1vaFwI-0005OJ-Gi; Mon, 29 Dec 2025 11:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=RHQ06Ay9ayNDOTQUjI5mQsuceKf7xehyCQI6bZPtdsc=; b=RW8FMCwC5VpR
 dYwSz43w70zy7oPtzgsx83yk15U9jYxraNOalfXtQ7OLjoH+bXiM/hVbWNUeqt1i56k03P9YDoahy
 sEIEGshESIkcFMPDDUGI3wwm4Ptv8UaY+uPKuGZPm1q5fpnyRpK7xHqLOPyMPcf9mulazMr9rFLfT
 LzWOiFlr9hCCWtFWrVVY079YT00f53Sv61Ki/9g+96GODRsCys1PmAVVAsyu//kA8Y8I+su0uHv04
 RXq2lS6DBNCE/W5GAkM2/JhHsoN9mKSJ3pKdq24mTmudeTAUSO5JswEzU/f8xtYd9zSjzro/MQPmG
 JXGyvN5kPbi0rnqEGaiC/A==;
Received: from [10.193.1.107] (helo=dev007.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1vaFvu-00Apz0-2M;
 Mon, 29 Dec 2025 17:17:32 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: den@openvz.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/3] block: create bdrv_advance_flush_gen() helper
Date: Mon, 29 Dec 2025 19:07:43 +0300
Message-ID: <20251229161740.758800-2-den@openvz.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229161740.758800-1-den@openvz.org>
References: <20251229161740.758800-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The patch creates helper to advance flush generation.

Right now there is the only place which handles bs->write_gen, but this
is going to be changed in the next patches. Unfortunately we need to
precisely control the moment of flush() when BDRV_REQ_FUA is passed
as a request flag. Generic processing inside bdrv_co_write_req_finish()
is too late.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/io.c                       | 2 +-
 include/block/block_int-common.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index d37da2e0ac5..f39ff862c11 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2147,7 +2147,7 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
 
     bdrv_check_request(offset, bytes, &error_abort);
 
-    qatomic_inc(&bs->write_gen);
+    bdrv_advance_flush_gen(bs);
 
     /*
      * Discard cannot extend the image, but in error handling cases, such as
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 80c54a6d09f..67552463dbe 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1373,6 +1373,11 @@ int bdrv_check_qiov_request(int64_t offset, int64_t bytes,
                             QEMUIOVector *qiov, size_t qiov_offset,
                             Error **errp);
 
+static inline void bdrv_advance_flush_gen(BlockDriverState *bs)
+{
+    qatomic_inc(&bs->write_gen);
+}
+
 bool cbw_filter_present(void);
 
 #ifdef _WIN32
-- 
2.43.5


