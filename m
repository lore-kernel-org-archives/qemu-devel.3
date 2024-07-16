Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805E2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjNG-0003oA-4y; Tue, 16 Jul 2024 10:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTjN6-0003Dv-VD; Tue, 16 Jul 2024 10:41:41 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTjMy-0002gp-7g; Tue, 16 Jul 2024 10:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=vMsADx4ymxP9MpsntD3Dfq6Xy1cjaErQd3cNm6PiniY=; b=FiZSTgcuJ1nH
 MpUYyhXo9+sI5Ll3zui21a1UvBaNiFetQRpQgI7nO++By/YUD2gKW9hoFDLSbi2oNjql0xNidWibw
 9BVhfvT+iDcDfzjprZ/IHwakk7BgLP84fwFpZM9yGtUla19cwZl2EG9OaxcRyOkmsjAmGFiOzeqev
 DbVW6Z7HcAmhCqxECqKuzXAY6KmeH2LVEFe45nPMBeBqHKIHtZ7onUkqnPj1xsxzFIG9R7WBru/74
 +wZD09O3dkpAGu8xtDEfkd6PopHzuOTJMejp5RCW9nntShYrzVBR7V4Mi2oWWj6AKT3vk682Toq5G
 WUDogbAeB2sChbIZd++4jA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sTjM1-00D0sH-2v;
 Tue, 16 Jul 2024 16:41:14 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 0/3] Fix data corruption within preallocation
Date: Tue, 16 Jul 2024 17:41:20 +0300
Message-Id: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
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

v2 -> v3:

  * Patch 2: modify test case.  Increase number of requests from 1024 to
    2048; make odd requests write actual data, while even requests cause
    write_zeroes operation;

  * Add patch 3: add scripts/filev2p.py for mapping of virtual file
    offsets to physical block device offsets.  The script was used to
    initially track down the data corruption problem, so it's included
    here.

v2: https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00413.html

Andrey Drobyshev (2):
  iotests/298: add testcase for async writes with preallocation filter
  scripts: add filev2p.py script for mapping virtual file offsets
    mapping

Denis V. Lunev (1):
  block: zero data data corruption using prealloc-filter

 block/preallocate.c        |   8 +-
 scripts/filev2p.py         | 311 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298     |  49 ++++++
 tests/qemu-iotests/298.out |   4 +-
 4 files changed, 369 insertions(+), 3 deletions(-)
 create mode 100755 scripts/filev2p.py

-- 
2.39.3


