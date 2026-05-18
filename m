Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EA9CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvaS-0003rX-AC; Mon, 18 May 2026 06:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvaF-0003pZ-8i
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:52:27 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvaA-0000sD-QT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779101523; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=yiOq06laJ9OAIKjKUpt4VDwPVBagTZHRhpc52CFfiVU=;
 b=SUn0IauMOenirmzL/WHsjs7ZJdyIt3sHUbSQQrACRHsUPVOcoNMTp2iDExQc7udVVuWWHgh6E/12Z6gtbwrTbpX2vMKJ64Z5dFGAf8LhS787B90Ck7knvbO9Q6VT2r6zPZPuLS2r6WzSKz6rEsVmeR5QLZ36nhG9NZ1Tvpwpt2g=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R881e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X37tYzb_1779101516; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X37tYzb_1779101516 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 18:52:02 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 0/8] migration: cleanups, fixes and micro-optimizations
Date: Mon, 18 May 2026 18:51:47 +0800
Message-ID: <20260518105156.17626-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This series collects several small improvements to the migration
subsystem:

- Bug fix: off-by-one in multifd recv channel ID validation that
  could allow an out-of-bounds write (patch 5).
- Micro-optimizations: cache migrate_multifd_channels() in hot
  paths (patches 7-8), use stack-allocated bitmap instead of
  heap (patch 4), avoid per-element heap churn in vmstate ptr
  marker field (patch 3).
- Cleanups: collapse migration_fd_valid into a single boolean
  expression (patch 1), replace strcpy("") with explicit NUL
  termination (patch 2), merge thread-join and cleanup loops in
  multifd_recv_cleanup (patch 6).

No functional change intended except for the off-by-one fix in
patch 5.

Bin Guo (8):
  migration/fd: collapse migration_fd_valid into single boolean
    expression
  migration/global_state: replace strcpy("") with explicit NUL
    termination
  migration/vmstate: avoid per-element heap churn in vmsd ptr marker
    field
  migration/savevm: use stack-allocated bitmap in
    configuration_validate_capabilities
  migration/multifd: fix off-by-one in recv channel ID validation
  migration/multifd: merge thread-join and cleanup loops in
    multifd_recv_cleanup
  migration/multifd: cache migrate_multifd_channels() in send/recv hot
    paths
  migration/multifd: cache channel count in multifd_send_sync_main

 migration/fd.c           | 10 +---------
 migration/global_state.c |  2 +-
 migration/multifd.c      | 32 +++++++++++++++++--------------
 migration/savevm.c       |  5 ++---
 migration/vmstate.c      | 41 ++++++++++++++++------------------------
 5 files changed, 38 insertions(+), 52 deletions(-)

-- 
2.50.1 (Apple Git-155)


