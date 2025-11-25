Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F3AD0E6EE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNtw1-0007Zu-Cx; Tue, 25 Nov 2025 09:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtuq-0007D1-JM
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:23 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vNtun-0002Gp-IL
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=ilp36NBlPLQr93J0yzcGFeFA9iIs3QVwY2rJPhUuDHM=; b=Ia1fb+bQnUS3
 78HU1iKnjcV8lcyzR4HlH9I2/wGaE4jMv0lgIWIrWNAhPr6JRsJfwy2AGxYcuHoJGA+Pij2T9y7/L
 EEu2J22hG0M3QNrzFS58oykGv57w6I0mH5L4nvsN0aW+OvxNgXY5b+rds8xnuycvckpqyj2a9wREP
 NQ4ZQeCd0SO8LEGTOxZcNDvzZ/GmCcrvVhCx9NWYhquSQB711jeL+wba0O8okO5oMCyhlsIqI2wa4
 U5J1xvcLppv6t02zEqYcBT5roTaog8zLKIabHIxXS5aXwqQTmL9bn/MQow3rYB0o2/d6+ooDQy0Ol
 7XLDH7sCFaO8aXeL4jvQpg==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vNtsy-003IJo-35;
 Tue, 25 Nov 2025 15:20:56 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 0/4] Fixes and improvements for scripts/qemugdb commands
Date: Tue, 25 Nov 2025 16:21:01 +0200
Message-ID: <20251125142105.448289-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Commands 'qemu mtree' and 'qemu timers' are currently not working.
Luckily, fixing them requires minimal effort.

The most interesting part is adding '--detailed' option into 'qemu bt'
and 'qemu coroutine' commands.  That is based on the previous downstream
work by Vladimir.  As this approach is much heavier than the current
stack unwinding, we add it as non-default behaviour.

Andrey Drobyshev (4):
  scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
    addresses
  scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
  scripts/qemugdb: timers: Improve 'qemu timers' command readability
  scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
    coredump

 scripts/qemugdb/coroutine.py | 126 ++++++++++++++++++++++++++++++++---
 scripts/qemugdb/mtree.py     |   2 +-
 scripts/qemugdb/timers.py    |  54 ++++++++++++---
 3 files changed, 162 insertions(+), 20 deletions(-)

-- 
2.43.5


