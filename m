Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FDFCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbe-00006X-7r; Wed, 07 Oct 2026 05:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ac8c13c38e569b04c613f287c3a83234dea161b4@kylie.crudebyte.com>)
 id 1xELM0-0002nF-9Y; Wed, 07 Oct 2026 02:42:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ac8c13c38e569b04c613f287c3a83234dea161b4@kylie.crudebyte.com>)
 id 1xELLO-0004C2-WE; Wed, 07 Oct 2026 02:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=uiwmNdn0AG3dm6JoSOxIencvSbhtz8X/AqTLUpX1E7I=; b=T98mr
 zXVxK0m8aS21ICnAmuxDOUR09pN01L4mraVBvx9Yb47o1tpoV0zCDLXWbBkpFmh/CGyQuU2svPfHI
 APgOSWzxVp6Jje9l0FlBCj9oLKS5TO3V68er1x3acVKDcoywaj+r3pRUIghYBLKiROdFyxwCjCBbm
 8DbQiEvHZI/X2A5iA5kH6NghQWMf/WqfK6n3Ul7LUFLD/Uf1R5D3SpwZQTRQCjtn2nJLO6/8h6p2L
 ZQ+92PpkRwPO1tp+doOho1pmUGxpI7M62ByijSJHBq561IEjpU1Ln8kVAy/NQamXbcpeb8Q9eXDpq
 WylbyqppF1wH51kHfoRQzhJ6O3ZigYwRzMUbtpdKUUHhfzNKuXtbyalJBBf6HL3/92QA8Ltt3LqRk
 gue9Jg08ljICnwTtzP9k7o8R+d+MDEXUTma7CcregTo/BHSyidkT8k7ZYkFnc5++dwTi+4cRz+Vej
 q+S5ZAPt5mCjjKIy0en+mxN0VAHF0wYLZKlAXKRQuPhyudOK0iigQ3vk2m4C3kEYjMA3wKCsbqHCg
 7PMzIHPs/Brc07dod9I9QMZJIaL68DvXgtF9K/oSft6vbWK5BBkqChTEWe31zsY+Nv9nawJc3vchJ
 XCC2Doe4sPqzpth4IoIbn+6jWdZfg8oi1VklTiewE04hysGIPmMjRyu2xZeZI8=;
Message-ID: <cover.1791291812.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 6 Oct 2026 15:03:32 +0200
Subject: [PATCH 0/9] 9pfs: add race test suite + fix 9p2000.u dir stream race
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=ac8c13c38e569b04c613f287c3a83234dea161b4@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds a race test suite for 9p and fixes a race on legacy
9p2000(.u)'s Tread request on directories, which was uncovered by this
new test suite.

This new race test suite challenges races by sending crafted concurrent 9p
requests on certain aspects of the 9p protocol. This series covers 3 race
tests:

  1. Patch 2 adds "race/fid-path": this race test guards CVE-2026-93834
     (fixed by commit fe9e30899f "hw/9pfs: Use read-write lock for protecting
     fid path.").

     Please refer to the commit log message of this patch for how to run
     these new 9p race tests in general.

  2. Patch 5 adds "race/readdir": this test guards directory stream races
     on 9p2000.L's Treaddir request.

  3. Patch 9 adds "race/tread-dir": this tests legacy 9p2000(.u)'s equivalent
     of Treaddir for directory stream races, and this test got triggered during
     the work on this series.

Therefore:

  - Fix: Patch 6 fixes the directory stream race vulnerability uncovered by
    race test #3.

All the other patches are basically just 9p test client additions required
for these new tests.

Christian Schoenebeck (9):
  tests/9p-client: add Txattrwalk / Rxattrwalk test client functions
  tests/9p-race: add 9p race test suite (race FID-path mutations)
  tests/9p-client: add Rerror function (legacy 9p2000.u)
  tests/9p-client: add Tstat / Rstat test client functions
  tests/9p-race: add Treaddir race test
  hw/9pfs: fix dirent stream protection for legacy (9p2000.u) Tread
  tests/9p-client: add Tcreate / Rcreate test client functions
  tests/9p-client: track the negotiated 9p version for session
  tests/9p-race: add Tread-on-dir race test

 MAINTAINERS                           |    1 +
 hw/9pfs/9p.c                          |   23 +-
 tests/qtest/libqos/virtio-9p-client.c |  213 +++++-
 tests/qtest/libqos/virtio-9p-client.h |  124 +++
 tests/qtest/libqos/virtio-9p.h        |    6 +
 tests/qtest/meson.build               |    1 +
 tests/qtest/virtio-9p-race-test.c     | 1016 +++++++++++++++++++++++++
 7 files changed, 1374 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/virtio-9p-race-test.c

-- 
2.47.3


