Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4923BD70DEC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQU-00072a-3A; Thu, 28 Nov 2024 13:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQN-0006zX-NA; Thu, 28 Nov 2024 13:39:35 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060L-Ge; Thu, 28 Nov 2024 13:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=la37xOII2HRiH1HmDA02HBweU8rL8bIazJB8BwYjRMA=; b=j5ErPhIf62re
 WhNB/jmkMukb1J86WCmCxg2yuTwncSBVAA1wp6u0n+WCVqmPrA0PZ0nbOS+/yTZwTiXY21XPPCF84
 MbYs57VNAdF45cad/Hy2GyhsRMZQGtl5FMqYsXadsbe+CsK248NwzHXa7o9X2KI473sUQJ6TTWDCh
 MMK8laTCTOripF6JCbMG5NQ+b4SDC7mE7edEJ45UHAhQnCZFK1NCtMFn0+0JSvvvzCAQi1f8AcE+q
 X4bS//RVXGJFpDG9u9PJIGuJQhGbsN4YRqWPprK7yYS++dtg3THPc2KXwnJNuoq7a2i7MwpHU1T4Z
 vfYnRJ1IZC7n0OjIERzf1A==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPn-00E2DN-24;
 Thu, 28 Nov 2024 19:39:09 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 0/6] block/preallocate: fix image truncation logic
Date: Thu, 28 Nov 2024 19:25:47 +0100
Message-ID: <20241128183911.837699-1-den@openvz.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Recent QEMU changes around preallocate_set_perm mandates that it is not
possible to poll on aio_context inside this function anymore. Thus
truncate operation has been moved inside bottom half. This bottom half
is scheduled from preallocate_set_perm() and that is all.

This approach proven to be problematic in a lot of places once
additional operations are executed over preallocate filter in
production. The code validates that permissions have been really changed
just after the call to the set operation.

A lot of time has been spent since the previous series in order to
stabilize changes with a whole product regression. This is reflected
with some unit tests added. Without this series 2 out of 3 are broken.

In general, the approach has been changed. We should not have image
truncate inside permission handling routines. That would be quite
incorrect and wrong, f.e. we potentially have truncate() executed
once we returned from bdrv_inactivate() and the ownership of the image
does not belong to us anymore.

It should be noted that the life cycle of the image length is quite
similar to one of the CBT and thus places where CBT is handled should
provide a good hint. This is just a guideline note.

Thus the most noticeable change is an addition of preallocate_inactivate()
callback and cleanup of all asynchronous stuff.

Changes from v2:
- the series has been completely rethinked

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>

