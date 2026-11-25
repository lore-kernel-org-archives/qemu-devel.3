Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA7606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtRnBttz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3DO-0008QT-2L; Tue, 24 Nov 2026 21:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW3DJ-0008QC-In
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:58:30 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW3DI-0003dL-25
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:58:29 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28B986113A;
 Wed, 25 Nov 2026 02:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525C51F000C6;
 Wed, 25 Nov 2026 02:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575505;
 bh=fIbfZt5RofIRrTaP17v5TZ6F88pMDzb5FDw7BbR4dJI=;
 h=From:To:Cc:Subject:Date;
 b=KtRnBttzPlpZsqsDsyU1cNAIkZHryjD2LG1Ydp3QL45619ousVoCRbaUvsfwkmXcY
 0MrScpVNQ6nbjHlPjG1ckXn/6lCrlz91nP5r1RyUkRqW8oQGAPxfWGcH5xhXa1lNHw
 tVbnHP7ohtf4AvqPCACDnGonMyQdOZJM/pIX4/cbOldPaORi1z474wzxXlk8sXWSR+
 defSbvnoZzSnFD47sGGfF21x7Q+MHl/IT4AWAx+T/IOcABSbOFmeghdzb7J05F2wT6
 B/wRclo4gLE3u82b+91Mu+QLiacdXLsp1WdHvQLZQhR1beXt9zkN36uKB2yENx3/qi
 3Tq/nQtR3Hf3g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PULL for 11.2 0/3] hppa target fixes
Date: Wed, 25 Nov 2026 03:58:19 +0100
Message-ID: <20261125025822.10813-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

The following changes since commit 2bfbe39d0fff8af881cffe2bab9b615e77807c35:

  gitlab-ci: Switch the msys2 job to use ucrt (2026-11-23 09:13:18 -0800)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-pull-request

for you to fetch changes up to b6a03b864508c24226d83b06d5a6f0439fcf3fd4:

  hw/hppa: adjust CPU HPA on 715 to avoid broadcast address (2026-11-24 22:15:23 +0100)

----------------------------------------------------------------
target/hppa patches

Two small patches to adjust the CPU HPA on the 715 and B160L machines
to avoid boot hangs, e.g. with OpenBSD.
Add one new test to check if OpenBSD starts.

----------------------------------------------------------------

Helge Deller (2):
  hw/hppa: fix OpenBSD boot on B160L emulation
  hw/hppa: adjust CPU HPA on 715 to avoid broadcast address

Kirill A. Korinsky (1):
  tests/functional/hppa: add OpenBSD CD-ROM boot test for
    qemu-system-hppa

 hw/hppa/machine.c                     |  5 ++--
 tests/functional/hppa/meson.build     |  1 +
 tests/functional/hppa/test_openbsd.py | 37 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100755 tests/functional/hppa/test_openbsd.py

-- 
2.54.0


