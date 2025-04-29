Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF5EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDv-0007DA-6n; Tue, 29 Apr 2025 07:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDj-0006wy-QV; Tue, 29 Apr 2025 07:33:52 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDe-0008Fa-Du; Tue, 29 Apr 2025 07:33:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2A4B461323;
 Tue, 29 Apr 2025 14:33:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-3PGDmJAX; Tue, 29 Apr 2025 14:33:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926421;
 bh=klMsBhm4nQV+bJbcH/oarfEWSHGxoD1YQoQrrYEdnVM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=JsnQkAtcfsMB/5tBEjPhnSGYbtymjzCEF7cUWoYf3kAyxaiCurqs0iVV7F7CUHkgz
 WkLWjerGO2nGebNOK244WwQuudi0y4KbYE1iM7QVmLN1m2FOa75kru6whhm2Pk1Pea
 nr9x4nG7ZwTnsjTFpmEMY0/RsbwA34jkkMQkVXBA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 4/8] block: allow commit to unmap zero blocks
Date: Tue, 29 Apr 2025 14:33:29 +0300
Message-ID: <20250429113335.423535-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

Non-active block commits do not discard blocks only containing zeros,
causing images to lose sparseness after the commit. This commit fixes
that by writing zero blocks using blk_co_pwrite_zeroes rather than
writing them out as any other arbitrary data.

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20241026163010.2865002-5-libvirt-e6954efa@volkihar.be>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 0fbf684728..4938714e0f 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -149,19 +149,39 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset,
     }
 
     if (ret & BDRV_BLOCK_ALLOCATED) {
-        assert(bytes < SIZE_MAX);
+        if (ret & BDRV_BLOCK_ZERO) {
+            /*
+             * If the top (sub)clusters are smaller than the base
+             * (sub)clusters, this will not unmap unless the underlying device
+             * does some tracking of these requests. Ideally, we would find
+             * the maximal extent of the zero clusters.
+             */
+            ret = blk_co_pwrite_zeroes(s->base, offset, bytes,
+                                       BDRV_REQ_MAY_UNMAP);
+            if (ret < 0) {
+                error_in_source = false;
+                goto fail;
+            }
+        } else {
+            assert(bytes < SIZE_MAX);
 
-        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
-        if (ret < 0) {
-            goto fail;
-        }
+            ret = blk_co_pread(s->top, offset, bytes, buf, 0);
+            if (ret < 0) {
+                goto fail;
+            }
 
-        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
-        if (ret < 0) {
-            error_in_source = false;
-            goto fail;
+            ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
+            if (ret < 0) {
+                error_in_source = false;
+                goto fail;
+            }
         }
 
+        /*
+         * Whether zeroes actually end up on disk depends on the details of
+         * the underlying driver. Therefore, this might rate limit more than
+         * is necessary.
+         */
         block_job_ratelimit_processed_bytes(&s->common, bytes);
     }
 
-- 
2.48.1


