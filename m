Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB45C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtv4-0005a6-4I; Thu, 11 Jul 2024 09:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sRtuu-000505-5I; Thu, 11 Jul 2024 09:33:00 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sRtul-00034K-9k; Thu, 11 Jul 2024 09:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=Y1iCBc8InS44xl3e+gImmhdYSB8M8/ICMSo3YpZuTzI=; b=cfT/zz/ZpxGR
 sShWI8TjtdTO121ZEwjqs0MWUC0WUlAIxWlO4NzcNMCdFYhrypNJL96dbo7Eb/ayigjRmsrTm55JD
 Dg8FZOFGHJaaa0OHOxEj5ywUWyK8/wqw2tD+HvJo5ISG74u2xdeSKfVFqqpTdqfannfw4Gh8qTun7
 gVlLqSzQieSIKiXGw7Q181egbmb+vPJXmQHXdYPROXaLkithhJ41qbJVcY0Cg8CmWSKHHdB0/wGl+
 xXsG1SlPgQFYqnad2xgEIIP2sGKrmkf3iENX2HtAPbCNg6jBbGLZvJwEeWXMUPSBVYX/iE0Ii63Q2
 zG+XxGpW722e7uRKnMnhTw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sRtty-00CZ6M-0j;
 Thu, 11 Jul 2024 15:32:42 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/2] Fix data corruption within preallocation
Date: Thu, 11 Jul 2024 16:32:40 +0300
Message-Id: <20240711133242.251061-1-andrey.drobyshev@virtuozzo.com>
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

When there's an image with preallocation filter on top of it, there
might be a race where 2 async write requests try to simultaneously do
preallocation at the end of the file.  And this results into data being
zeroed after the actual write operation is performed.

Here we introduce a coroutine context lock within the preallocation
filter to protect file_end field, and the test which does fail without
the locking.

Note: the lock is only added to the operations which run in the
coroutine context and it seems to make the problem with async write
requests go away.  However there're other operations which are run
outside of the coroutine context and which also modify the file_end
field, e.g. preallocate_set_perm() and preallocate_child_perm().
Comments on how to protect the field properly regardless of the context
are welcome.

Andrey Drobyshev (1):
  iotests/298: add testcase for async writes with preallocation filter

Denis V. Lunev (1):
  block: zero data data corruption using prealloc-filter

 block/preallocate.c        | 11 +++++++++++
 tests/qemu-iotests/298     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  4 ++--
 3 files changed, 47 insertions(+), 2 deletions(-)

--
2.39.3


