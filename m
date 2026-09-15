Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D261C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Mni-0006gA-S7; Tue, 15 Sep 2026 02:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6Mnf-0006fb-3F
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:37:51 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6MnY-0001Dd-V2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789454241; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=O/3GMptzb1vKo3c20lv2ZapZq0oWy8s8RzFdroAIFWA=;
 b=gZnjcX/wK0vfPtYwVmVXcGDlxRbofl5ezzpZcLO2cjIbH+bUDnqx2LG1aS9ytOmsfsZzphJPOoaJpaxD+2hzvzp1ObYTK07hYO0uzLQgB/ozYwKDoCIpUDa3Ige2FCRIOGf+er7kI053bxDrYuify8geLk9yj6j5BLD3puzzzuk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0XB0Kx0F_1789454239; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XB0Kx0F_1789454239 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 15 Sep 2026 14:37:20 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 0/2] migration/postcopy: shared-fault accounting and multifd
 docs
Date: Tue, 15 Sep 2026 14:37:17 +0800
Message-ID: <20260915063719.89031-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Two small patches from the same investigation of the postcopy
shared-page-fault path:

- Patch 1 documents that multifd and postcopy-ram can be enabled
  together since the 10.1 release, and how the two features interact.

- Patch 2 resolves the "TODO: support blocktime tracking" in
  postcopy_request_shared_page() by reporting faults taken by memory
  sharing processes (e.g. a vhost-user backend) with a foreign tid, so
  they show up in the latency reports without polluting the vCPU
  blocktime ones.

The patches are independent of each other; patch 2 was verified with a
vhost-user postcopy migration, where the shared faults now show up in
the latency reports and the page request accounting stays balanced.

Bin Guo (2):
  docs/migration: document that postcopy can be used with multifd
  migration/postcopy: account faults taken by memory sharing processes

 docs/devel/migration/postcopy.rst | 26 ++++++++++++++++++++++++++
 migration/postcopy-ram.c          | 26 ++++++++++++++++----------
 migration/postcopy-ram.h          | 10 ++++++++++
 3 files changed, 52 insertions(+), 10 deletions(-)

-- 
2.50.1 (Apple Git-155)


