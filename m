Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A5606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFXIUJ7a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPSGR-0001hO-MP; Fri, 06 Nov 2026 17:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xPSGP-0001h6-Qa
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:18:25 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xPSGN-0001D6-VT
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:18:25 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 085FC601BF;
 Fri,  6 Nov 2026 22:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D91F0089F;
 Fri,  6 Nov 2026 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794003501;
 bh=ZjRaQ/E5Y35905+swYwxqX+3doWsGShl/i8THnLWDAs=;
 h=From:To:Cc:Subject:Date;
 b=JFXIUJ7aKyPf07HGoBtYz+g9L6EwugOIBL8Ts/ct35/vsomWI29r5WjfsxnFcXDWJ
 f8QXOzz/nZy9QLCutWrHgy9z6o+dtxWHySAcknqZ4UYp5XZt7GEigUmmsofPSRHCoo
 2Km6LHJCJ3lwDMsGr9wB3UIe7Iy4b5WvkYZrPQ4hRPgGhrNhHSwDgp24RA+1TF4kWu
 4FmspmngfFbD3RsA1luwX27ek4GBWc8dNswUfbmY76F4omxqfQ+PHVBELFSRZGbW2w
 XE71Cm9vaUhCpz0KIvGepKxbE+pXGNFpCFe9Y57SXDd+DhNAAJCXzk2MKPW8RH2z+b
 eN4159Xc+s0WA==
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Keith Monahan <keith@techtravels.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/4] [RFC] scsi: New ncr53c710_v2 driver
Date: Fri,  6 Nov 2026 23:18:14 +0100
Message-ID: <20261106221818.139086-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

This patch series contains a replacement driver for the current ncr53c710
driver.  The existing driver was written from scratch during the Google Summer
of Code 2025 program.  It works okay with Linux, but fails badly when trying to
run any version of HP-UX or BSD.

Keith Monahan tried to fix the existing driver. But after some hacking it
became clear that starting fresh and using the lsi53c895a driver as base seems
more promising to get a correctly functional driver.

His patches to replace the existing driver [1] in-place were rejected because
the patches were too big (and changed too many not-related things inside one
patch) and thus a potential review seemed impossible (which I agree on).

Since the new driver is not fixing the old driver, but is actually a completely
new driver, trying to put together patches which replace the old driver step by
step is impossible. I gave it a shot, but failed badly.

As the maintainer of the PA-RISC emulation (which is actually the only user of
the ncr53c710 driver), I'm of course very much interested in having the new
functional driver instead of the old broken driver.  The new driver works
reliable with Linux, HP-UX 9.05, HP-UX 10.20 and NetBSD, which is a big step
forward.

My proposed solution to this issue in this patch series is:
- in patch #2: add the new driver (v2) in a new source file: ncr53c710_v2.c
- in patch #3: wire up the new driver instead of the old driver
- in patch #4: remove the code of the old driver (ncr53c710.c)

Usually I'd prefer an evolutionary way to the new driver as well, but if you
check the code yourself you will see this will not be possible.

That said, I would be happy if my proposal here would be accepted.

Thanks!
Helge

[1] https://lists.nongnu.org/archive/html/qemu-devel/2026-07/msg00263.html

Helge Deller (4):
  target/hppa: drop dependency on ncr53c710.h
  ncr53c710_v2: add new NCR53C710 chipset driver
  lasi_ncr710: Wire up the new ncr53c710_v2 driver in LASI
  hw/scsi: Drop old ncr53c710 v1 driver

 hw/hppa/machine.c      |    1 -
 hw/scsi/lasi_ncr710.c  |  119 +-
 hw/scsi/lasi_ncr710.h  |   30 +-
 hw/scsi/meson.build    |    2 +-
 hw/scsi/ncr53c710.c    | 2473 ----------------------------------------
 hw/scsi/ncr53c710.h    |  246 ----
 hw/scsi/ncr53c710_v2.c | 1969 ++++++++++++++++++++++++++++++++
 hw/scsi/ncr53c710_v2.h |  183 +++
 hw/scsi/trace-events   |   36 +
 9 files changed, 2240 insertions(+), 2819 deletions(-)
 delete mode 100644 hw/scsi/ncr53c710.c
 delete mode 100644 hw/scsi/ncr53c710.h
 create mode 100644 hw/scsi/ncr53c710_v2.c
 create mode 100644 hw/scsi/ncr53c710_v2.h

-- 
2.54.0


