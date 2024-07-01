Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFQp-0004om-DT; Mon, 01 Jul 2024 07:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w.bumiller@proxmox.com>)
 id 1sOFQi-0004nn-Pd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:42:45 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w.bumiller@proxmox.com>)
 id 1sOFQg-0006hS-2Q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:42:44 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CFCF745F18;
 Mon,  1 Jul 2024 13:42:30 +0200 (CEST)
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/2] change some odd-looking atomic uses
Date: Mon,  1 Jul 2024 13:42:28 +0200
Message-Id: <20240701114230.193307-1-w.bumiller@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=w.bumiller@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

I spotted the weird-looking pattern of:
    atomic_set(atomic_load() <some operation> N)
in a few palces and one variable in the graph-lock code which was used with
atomics except for a single case, which also seemed suspicious.

I'm not sure if there are any known compiler-optimizations or ordering
semantics already ensuring that these operations are indeed working correctly
atomically, so I thought I'd point them out and ask about it by sending
patches.

In patch 2 the ordering is changed (see the note in its mail)

Wolfgang Bumiller (2):
  graph-lock: make sure reader_count access is atomic
  atomics: replace fetch-use-store with direct atomic operations

 block/graph-lock.c | 8 +++-----
 util/aio-posix.c   | 3 +--
 util/aio-win32.c   | 3 +--
 util/async.c       | 2 +-
 4 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.39.2



