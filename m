Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B4DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpU9W-0001qS-Gr; Tue, 04 Mar 2025 10:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3429da65ff753b47654b7ae26607417c571a7cb1@kylie.crudebyte.com>)
 id 1tpU9M-0001q2-16; Tue, 04 Mar 2025 10:25:40 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3429da65ff753b47654b7ae26607417c571a7cb1@kylie.crudebyte.com>)
 id 1tpU9K-0006tZ-9y; Tue, 04 Mar 2025 10:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=620FshvAVPKcENtDD1iG6QmqaFxggLab8Oiyh7VhCtk=; b=ndqw+
 KSKSWH6XyN5tjTLjSHwYHHu59UhRVxhq6kNlQA/jB1qqJ2EkgMg+0xhsxNVb30R6t7jmjQraS/PUR
 KpmrNursAZhim+coYsnlQ3xuuSCK4/HHNH5n12nvQF+HWbA8Hc0AX4yZxMJtYpVuu8ppZqnRNsnCs
 K0kYFQNQlV9xa0JjWSIgyzz5nT4bTDB7Zn/yihnXkC3qxpHT76JAt7Mp1DDsAd1U2fCCrzWWiP6Qi
 SoeIyldaUru3QmgAdRxFZdjLHbXoNgqEf5ccSizdoE4n48eH62RipSuKjCBJEwot4DOlsNKJimLn6
 WxJgebcmzNUAoOMVgEGWr0BZRSkvc3qqMldSvJCp4u73QkT9uySs4UrVZtGH2NqaAeYLiQIm7/0Ik
 umbCzdG5++p4pSGMSZ3Wk8TgBWq/xN2aGIDdjMc6+Pq7QKUk/4YmW35c3Ics81YhABhuh1FxA8hEC
 FTRhMrSWrYx9y2KoaVeud8hfsuSQy7c7vxfgBmM5eGNl78TmE1/lWDvQ99b4ho0fjv8HejBzkWaXr
 oOnw87LBVnixtOBFC7a8bkLfh4EcTRhBE4sJzJ0YHBLvqJvZKUgyO39Wnuqa6MEGnMsTs7/N+chM5
 sJjq1Fe30c2DlpxgA50l8WE/Y4Na1t0XUKQ5rVcugB2rLvtK8LD0t9h0SWxqpI=;
Message-Id: <3429da65ff753b47654b7ae26607417c571a7cb1.1741101468.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1741101468.git.qemu_oss@crudebyte.com>
References: <cover.1741101468.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 4 Mar 2025 16:15:57 +0100
Subject: [PATCH 1/2] 9pfs: fix concurrent v9fs_reclaim_fd() calls
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    qemu-stable@nongnu.org
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=3429da65ff753b47654b7ae26607417c571a7cb1@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Even though this function is serialized to be always called from main
thread, v9fs_reclaim_fd() is dispatching the coroutine to a worker thread
in between via its v9fs_co_*() calls, hence leading to the situation where
v9fs_reclaim_fd() is effectively executed multiple times simultaniously,
which renders its LRU algorithm useless and causes high latency.

Fix this by adding a simple boolean variable to ensure this function is
only called once at a time. No synchronization needed for this boolean
variable as this function is only entered and returned on main thread.

Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 10 ++++++++++
 hw/9pfs/9p.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7cad2bce62..4f9c2dde9c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -435,6 +435,12 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
     GHashTableIter iter;
     gpointer fid;
 
+    /* prevent multiple coroutines running this function simultaniously */
+    if (s->reclaiming) {
+        return;
+    }
+    s->reclaiming = true;
+
     g_hash_table_iter_init(&iter, s->fids);
 
     QSLIST_HEAD(, V9fsFidState) reclaim_list =
@@ -510,6 +516,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
          */
         put_fid(pdu, f);
     }
+
+    s->reclaiming = false;
 }
 
 /*
@@ -4324,6 +4332,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
+    s->reclaiming = false;
+
     rc = 0;
 out:
     if (rc) {
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 5e041e1f60..259ad32ed1 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -362,6 +362,7 @@ struct V9fsState {
     uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
     uint16_t qp_affix_next;
     uint64_t qp_fullpath_next;
+    bool reclaiming;
 };
 
 /* 9p2000.L open flags */
-- 
2.39.5


