Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ADBCEDD98
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syXFM-0006U0-DY; Wed, 09 Oct 2024 10:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syXFJ-0006TY-K0; Wed, 09 Oct 2024 10:00:57 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1syXFH-0006YG-3k; Wed, 09 Oct 2024 10:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=TfYLdrvKYAXnUX53NJ0IkTTTspmHx1drZrKFGujD1So=; b=xmPzVx3oqD+D
 XgmaaMdnsumGrMlRhoSZndcLEi4rOh4/d2Lv1c2sMKR5WbQZNaDsLQDHBFoFA7tSRymHDAib3BnVq
 vap3eK8w4jsLBoDQ/w6Tkx0TGtXNrdT/L6twGLnDbdwxCuPlUYWoudOx/weIPd/vehxPOZEFpu1lg
 kENIRKrygYO4zfsBc7ue/+s5c1lp+mTOg5pmOABdCx5Sv1lJUFfRpFCsV5tYY0uIYhdY6opD++M5x
 wBEX7j3gGXi+NWmfZLbIQeHYAWo3DewaD385wCcZT8nhXY8JpzBLjtrRHwWobE3RBjaY1EuvVrg7O
 jB93Qp17Uonwrhpy3W9fTA==;
Received: from [130.117.225.1] (helo=dev007.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1syXBf-00AR1a-2M;
 Wed, 09 Oct 2024 16:00:38 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V . Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/2] block/preallocate: fix image truncation logic
Date: Wed,  9 Oct 2024 16:58:49 +0300
Message-ID: <20241009140051.771660-1-den@openvz.org>
X-Mailer: git-send-email 2.43.5
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

All permissions operations or block driver graph changes are performed
inside the quiscent state in terms of the block layer. This means that
there are no in-flight packets which is guaranteed by the passing
through bdrv_drain() section.

The idea is that we should effectively disable preallocate filter inside
bdrv_drain() and unblock permission changes. This section is definitely
not on the hot path and additional single truncate operation will not
hurt.

Unfortunately bdrv_drain_begin() callback according to the documentation
also disallow waiting inside. Thus original approach with the bottom
half is not changed. bdrv_drain_begin() schedules the operation and in
order to ensure that it has been really executed before completion of
the section increments the amount of in-flight requests.

In addition to this we should disable lifting WRITE permission when
truncate() operation is not fully completed yet.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Kevin Wolf <kwolf@redhat.com>

