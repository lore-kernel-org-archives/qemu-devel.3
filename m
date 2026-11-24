Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E9606A68F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmqfbAJz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVmK7-0007xX-Va; Tue, 24 Nov 2026 03:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xVmJg-0007s1-GB; Tue, 24 Nov 2026 03:55:57 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xVmJe-000707-Mq; Tue, 24 Nov 2026 03:55:55 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41DD0623DB;
 Tue, 24 Nov 2026 08:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1951F000C4;
 Tue, 24 Nov 2026 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795510552;
 bh=RLpw2901IpSNHN2ljf5T3UNbOXMdC/pMtJYql5b69Xc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BmqfbAJzQzR7wTSyNF95MfJaJS04WLg9g3nRr8anu+09z9n3r05chU3n4c47b+UFe
 lToasFuprRDEmX0cAr0JT91gTL95ha9GK1In/mAiuKeAQd9k3b6ckttC1RUy292JuJ
 JQX+/FcRqjL2MvxLY8SFjtxDV0bP8dvhOdUOBY835IU+4LEaWCWwf47EAfMAdk217A
 2jkBGZMYIWleqn83K+1OyEXcLyWqivAgZlPOi7crbDCBrbfhGVwO/6bZADiCF4zDwB
 B3zYBvxPPRng84jYWk14DkRrzMEWukztDUBN928CZDi//EDbePm616FRUM6VoMp9Lh
 FaaRFdGUw0z2A==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v18 04/10] qcow2: do not flush when a cache dependency is
 already set
Date: Tue, 24 Nov 2026 09:55:23 +0100
Message-ID: <20261124085529.1537572-5-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124085529.1537572-1-cassel@kernel.org>
References: <20261124085529.1537572-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sam Li <faithilikerun@gmail.com>

qcow2_cache_set_dependency() flushes the dependency cache whenever that
one has a dependency of its own, even if the dependency to set is
already in place. Return early in that case, which avoids a synchronous
flush for a caller that keeps setting the same dependency.

This is safe: flushing a cache flushes its dependency first, so a chain
is still written in order. With only the L2 table and refcount block
caches, the early return never skips a flush, as a chain needs a third
cache, such as the write pointer cache of a zoned image.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/qcow2-cache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 23d9588b08..73f2be3641 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -275,14 +275,23 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
 {
     int ret;
 
+    /*
+     * If the dependency graph is unchanged, nothing to do. This avoids
+     * a synchronous flush on every call below.
+     */
+    if (c->depends == dependency) {
+        return 0;
+    }
+
     if (dependency->depends) {
+        /* Flatten any chain on the dependency side as a cycle-breaker. */
         ret = qcow2_cache_flush_dependency(bs, dependency);
         if (ret < 0) {
             return ret;
         }
     }
 
-    if (c->depends && (c->depends != dependency)) {
+    if (c->depends) {
         ret = qcow2_cache_flush_dependency(bs, c);
         if (ret < 0) {
             return ret;
-- 
2.56.1


