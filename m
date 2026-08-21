Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6821EC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPQx-0001Io-Ev; Fri, 21 Aug 2026 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPQu-0001CN-2k
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:21 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPQs-0000jH-Ld
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787319433; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ZTSCMSzTohnTLiZgJFnsCTROTVrT/tvOxSVH4ruU1yk=;
 b=aR7NVbxuQeHXNYKENs/RRARD8xMiZsB8rfqKw+4+SDhLUr4Ryj5ngPAynr0O+yf3exgZyw
 kphS1uAPZ7o9TfBWECTDlK2mizP8P+CF8I0QG2E0qIjxkwnowXeVMWk3ocht0c3BINoRhJ
 5D/n4QFJWocB+r/9CjR/SDXrfoA0V4Njum+bl9sTHTAKWSX2i9yumBFpG3DRmYLf+IaWpn
 CP9wwSqG1i49WjOCxViKWO6RCngOnZue19ndSx0S1GD1cb2BcfjuG75DgQSR3uYg4xdF+u
 KomqU/GGPBASs6Cl/kDqBiU9BHX5x5Axmsu/9X99mzen+w4gjJ6GPS7oLG7N4Q==
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Fri, 21 Aug 2026 21:35:57 +0800
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2 1/3] migration/rdma: Fix write-side shutdown
Message-Id: <20260821133559.3815727-2-yanfei.xu@bytedance.com>
References: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a885488+77e147+nongnu.org+yanfei.xu@bytedance.com>
In-Reply-To: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.111;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-111.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qio_channel_rdma_shutdown() reads rdmain for both the input and
output contexts.  As a result, a write-side shutdown marks the input
context as errored while leaving the output context active.  A shutdown
of both directions also fails to stop the output context.

Read rdmaout from the output context so each shutdown direction marks
the corresponding RDMA context as errored.

Fixes: 54db882f073a ("migration: implement the shutdown for RDMA QIOChannel")
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 438419d189..e17ace62b0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2982,7 +2982,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
     RCU_READ_LOCK_GUARD();
 
     rdmain = qatomic_rcu_read(&rioc->rdmain);
-    rdmaout = qatomic_rcu_read(&rioc->rdmain);
+    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
 
     switch (how) {
     case QIO_CHANNEL_SHUTDOWN_READ:
-- 
2.20.1

