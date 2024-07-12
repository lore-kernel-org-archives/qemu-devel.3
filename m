Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BED5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCrW-0002d0-4r; Fri, 12 Jul 2024 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sSCrF-0002JO-4o; Fri, 12 Jul 2024 05:46:37 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sSCrC-0001Y6-MJ; Fri, 12 Jul 2024 05:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=LDdBUoqebPVHFuRAOp0wgoqPM6CEWFS92+GkInQpzvo=; b=thsFQTmz31tx
 SbCNgDx7+HOVg5xB65V9ZqTyjeK3pXtILrzjjARati76yUr+7Q0d/uGlEH87Vu23D+/kW6xaVVIuA
 roWWSxBRxJHEHXTCk4kD7KlytcIBh6sYPUrh1kIx3lx2X0Qa1P9PzwZBTXLNaGi/6fX4vmBLSNRx0
 zjpZ0Cq2klcRDZJpN/lTx4ypQ24oGpixJ1nU0+igQLu05Cw8KrDb6jwVfJt+0Ij4GFte8MsKjgZi4
 bYybS/btxY28HA5i1ke+qNl7pInaKZbG/wx2rxlGW46gEK+Xl8dSiRp4hdzTOHNo/K0QRL0BonDb2
 LVLu6/1Eev9zmch/JpNhJQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sSCqO-00Ceua-2P;
 Fri, 12 Jul 2024 11:46:17 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 0/2] Fix data corruption within preallocation
Date: Fri, 12 Jul 2024 12:46:15 +0300
Message-Id: <20240712094617.565237-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

v1 -> v2:

 * Patch 1/2: get rid of the lock. Instead, simply update the file_end
   field before the write_zeroes operation.

This patch implements a much simpler logic w/o the locking compared to
v1, and the problem seems to go away.  However there still might be
potential issues with the operations performed in other coroutines (e.g.
truncate) and outside of the coroutine context (preallocate_set_perm() /
preallocate_child_perm()).  So the comments on this are most welcome.

v1: https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00384.html

Andrey Drobyshev (1):
  iotests/298: add testcase for async writes with preallocation filter

Denis V. Lunev (1):
  block: zero data data corruption using prealloc-filter

 block/preallocate.c        |  8 +++++++-
 tests/qemu-iotests/298     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  4 ++--
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.39.3


