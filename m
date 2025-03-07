Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44F0C282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 09:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqU5Q-0000XD-3e; Fri, 07 Mar 2025 04:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5747469d3f039c53147e850b456943a1d4b5485c@kylie.crudebyte.com>)
 id 1tqU5I-0000V8-QV; Fri, 07 Mar 2025 04:33:39 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5747469d3f039c53147e850b456943a1d4b5485c@kylie.crudebyte.com>)
 id 1tqU5H-0002tn-0Y; Fri, 07 Mar 2025 04:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=vMLqbARWm6mQx7xwnh4PCPfiWB2q2QrFcmR6wdB05DY=; b=KLgZa
 2/6EKWVaskfXa/ofRNsqSbHt/MDTCoBwLJjIJlqPcS0R6iK7v9HQYn2pGebnl+d31Ww+OVGAdXtgA
 XLP2Ahp6OmhvhJ9qHwyAghoacOsn3kXU2Yb0K00YHBMyq6ZS2Z/Rol3MBtSljlsANN+PVSgmNlMis
 xoro/g9g3co0yW2G/vZU7q86FmT4sMybP/YONdfP966AFo6p+TbxzdbB/dE4XKfil/CORaO+nJZvM
 BJLwZq6eH2nmTiK5STv5bk0TX96ePo0uz5OgsxqZvPcImzld+73UNjIzD6JZ02rhaM2XiyEHLmdzP
 sPgLjJM5WPVpsyM6u7OqtEVp/LtlpArCQl5wieuslldqjcvOnQcVOqf8t9cn/o2lB5wS1mTAqYotv
 HNuD9G8MFk3kxMaPldJO/6tcxFJelNQFCZrSY/qNpa45SYP4IvoL+JJg2CpjovRkafFn94AFd1xix
 CgnDFYQPEoxog2M3iGG5HS2V8gR46xLGLrAzOXzO22oxS6FoCEiPVdRuon0s20a7oOphLpClP1jV8
 0O/0CfDfn5nj2rE3JX2g0ymhpD6ZXYe7STVP1QhhJF2ewW+lAothWUst7chpl8OOTlmwY80IV284D
 5CV3wTrsShv354ax8ZtCTEcqpxqJoQRmS2XRw/a7u4F/0tpPPmOCbkWauULeRo=;
Message-Id: <cover.1741339452.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 7 Mar 2025 10:24:12 +0100
Subject: [PATCH v2 0/2] 9pfs: v9fs_reclaim_fd() fixes
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    qemu-stable@nongnu.org
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=5747469d3f039c53147e850b456943a1d4b5485c@kylie.crudebyte.com;
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

Three fixes for 9p server's v9fs_reclaim_fd() function:

* Patch 1 fixes a concurrency issue.

* Patch 2 fixes a file descriptor leak and optimizes overall latency. On a test
  machine with ~800,000 FIDs, this reduced execution duration of
  v9fs_reclaim_fd() from 30ms to 1ms.

V2:
  - Patch 2: Decrement global variable total_open_fd on main thread, not
    on fs driver background thread.
  - Patch 2: Update commit log about file descriptor leak being fixed.

Christian Schoenebeck (2):
  9pfs: fix concurrent v9fs_reclaim_fd() calls
  9pfs: fix FD leak and reduce latency of v9fs_reclaim_fd()

 hw/9pfs/9p.c | 39 ++++++++++++++++++++++++++++++---------
 hw/9pfs/9p.h |  1 +
 2 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.39.5


