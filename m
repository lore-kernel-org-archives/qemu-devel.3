Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612AEC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 09:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmeb-0003QO-B4; Wed, 05 Jun 2024 05:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1sEmeZ-0003Q7-Jo
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:09:55 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1sEmeX-0007Sk-HO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:09:55 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ba43:94d2:9111:d35b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 1A6B51520F7E;
 Wed,  5 Jun 2024 11:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1717578591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2vRMGgEtG3Mc3jJIUV+Hm+Gs++97WF++6erVmoVB4U=;
 b=UgQXjBMJRmU6zagyyvDbjOnYVJB9VEUzr0H4wZQJgaQFh4eBKTFhrCI1crCPGPWH+S/vkf
 5RYavL14zEIP5nDrpL1plkHYgco7TflUqoELCXvPmAXhQZkcskx6NzKcxUIWeXLM7kHmHn
 UXyHpmLYWei7EPxKtiXhCpq1HIV245+OyTl7c6ymuqyn3C5SUleV2Zn7DlS989QMNFE3zL
 r15WK3LcD6RWyDXdlGImc9xefF8ERGwNBEErnEIUGbLxaijrv/Klw1e3MaCFDdyPxsO0zk
 O3heEHYNxSANCgj6T0EBBuDJcBnwIokabszyM9Wn48wJz2EAvCrrtKv1juzPxA==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com
Cc: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 2/2] qcow2: don't allow discard-no-unref when discard is not
 enabled
Date: Wed,  5 Jun 2024 11:06:41 +0200
Message-ID: <20240605090639.3402698-4-jean-louis@dupond.be>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605090639.3402698-2-jean-louis@dupond.be>
References: <20240605090639.3402698-2-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When discard is not set to unmap/on, we should not allow setting
discard-no-unref.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1ce7ebbab4..54c6b041b1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1156,6 +1156,12 @@ qcow2_update_options_prepare(BlockDriverState *bs, Qcow2ReopenState *r,
         ret = -EINVAL;
         goto fail;
     }
+    if (r->discard_no_unref && !(flags & BDRV_O_UNMAP)) {
+        error_setg(errp,
+                   "discard-no-unref is only valid with discard=unmap/on");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     switch (s->crypt_method_header) {
     case QCOW_CRYPT_NONE:
-- 
2.45.2


