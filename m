Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A064D68BFD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFG5b-0003n0-15; Sun, 24 Nov 2024 12:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7017658155c517b9665b75333a97c79aa2d4f3df@kylie.crudebyte.com>)
 id 1tFG5Y-0003ma-18; Sun, 24 Nov 2024 12:08:01 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7017658155c517b9665b75333a97c79aa2d4f3df@kylie.crudebyte.com>)
 id 1tFG5W-0005Hx-Jt; Sun, 24 Nov 2024 12:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=lUbUKfQW53TCB/yq+zCZJaJW3auIpeQcJyWCrP451N4=; b=VlH5I
 YTsBk39DfSjQDGB6pnOyFSchr+mEJDmBRhtdtYj9MyLmbQFq3WGgNAa8BtS+bjBMIw9HyNieAczTM
 45TgGvZQnL4uscwecXWdbfHdklfd0tM1VwaO/uajK3NYmkl178sXNFaQ415QFw/qJXkbb0ZcxcgML
 2VHmEW76K76ycDqB9xPpiuRHml1KXR6u2Bv7KMtfF9RSw9tR2/zFZGaODz2w20WIcEx1Iey+L5NiJ
 ZKmUJjD1do96qxWawnwLh6oUBXiznUCcjH3EjPwbaMsMgRwqGuwkraCZgEppOOIqCxBGE8zJsKj/q
 JDCWyFuZXyPTEjzZRRRjsARQKMvFZTKTWUSo0yRU2YDi285Gv6fctBrMppv6QVXw67bV756jYsVUQ
 +72q7VKSwTUSgTIaSaLXj22XAbN9hHR/DZYb1WwAV7W4iMqG5HuPTs9X1YqLxs5+y7LpMrtl0RqQ5
 SQIPA8oE7SkqBTp3UBgvgpcF07TZVSmOwz4aJ7TadtxAzEAd1jlru1SW96Q/K8MNBj9QoRFYXEvb1
 q4A6yY0wfLEtQYl+5Jtm2Cpxa4Fkh17pTQvYkaYfI5Zk0woQ0xvviXVhLYUuLq7Q+tMVtnF1S22hS
 i3Ebw/9cick8jZpJ2Rf5jH8wdmcHqg0dxGqORxMgmOZCo8LspaDSCJKAuIR1Eo=;
Message-Id: <cover.1732465720.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 24 Nov 2024 17:28:40 +0100
Subject: [PATCH 0/6] 9pfs: fix fstat() after unlink() (with a Linux guest)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7017658155c517b9665b75333a97c79aa2d4f3df@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This fixes an infamous, long standing bug:
https://gitlab.com/qemu-project/qemu/-/issues/103

* Actual fix of this bug is patch 5.

* Patches 1 and 6 add a test case to verify the expected behaviour.

* The other patches (2, 3, 4) are basically just minor cleanup patches more
  or less (un)related that I simply did not bother to send separately.

Probably there are still other 9p request types that should be fixed for this
use-after-unlink idiom, but this series fixes the mentioned bug report as
described by reporter, so fair enough to round this up here for now.

Simple test app to verify this behaviour on a Linux guest:

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
  struct stat st;
  int fd = open("doa-file", O_RDWR | O_CREAT | O_EXCL, 0600);
  unlink("doa-file");
  int res = fstat(fd, &st);
  printf("fstat() = %d\n", res);
  return res;
}

Christian Schoenebeck (6):
  tests/9p: add 'use-after-unlink' test
  tests/9p: fix Rreaddir response name
  tests/9p: add missing Rgetattr response name
  9pfs: remove obsolete comment in v9fs_getattr()
  9pfs: fix 'Tgetattr' after unlink
  tests/9p: also check 'Tgetattr' in 'use-after-unlink' test

 hw/9pfs/9p.c                          | 12 ++++---
 tests/qtest/libqos/virtio-9p-client.c |  3 +-
 tests/qtest/virtio-9p-test.c          | 46 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.39.5


