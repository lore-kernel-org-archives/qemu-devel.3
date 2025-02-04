Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9098FC02199
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 22:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfREh-0005VF-P1; Tue, 04 Feb 2025 17:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tfREd-0005TV-M2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 17:17:35 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tfREb-0005QE-Pr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 17:17:35 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AB0635C2BAA;
 Tue,  4 Feb 2025 22:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B4BC4CEDF;
 Tue,  4 Feb 2025 22:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738707449;
 bh=KsM/p8kUN9naQv3H9Re9bbZoixDd3rHGuJLMLMRMXlw=;
 h=From:To:Cc:Subject:Date:From;
 b=Qpf0/Tsh8bvP+yFwS+1EOw5loqsr+3dunV/Sv2tJsJ4sR9snmxVU5ALN+tqZU85nK
 rbqsz9kLUHBphiSrFR0sgc0iDzu9Ec1Y1VTEf1S88e59ZGmc1qN2r/BhMTRJr7KAUm
 RAkV8HKjLt5ekyf9GbKbfm/efd0NoKBnrI1geg8v6qpGMwzXmj0TGtATsBtG4nqfx4
 2UCneckkBBjxFIuCPjVqwNUpN/r3P+EwJ0vsv1+ZAhwS2RxN1JmqJj+zqcbDTryb6L
 d28+9bqccYT/W5WIVrcUHlEXP3I2FGMwVi+5LT3BKezCUVSDog96gDlcyR4K6eWqF9
 G8vtYIQ6sLhbQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/6] HPPA graphics and serial console enhancements
Date: Tue,  4 Feb 2025 23:17:20 +0100
Message-ID: <20250204221726.151287-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

From: Helge Deller <deller@gmx.de>

A small series of patches which enhances the graphics output on 64-bit hppa
machines. Allows to disable the artist graphic card and introduces drivers for
the Diva GSP (remote management) cards which are used in later 64-bit machines
and which we now use for serial console output.

The LMMIO regions of the Astro chip are now supported too, which e.g. allows to
plug in a virtual ATI PCI card with a 64-bit Linux kernel.

Please review.

Helge Deller (6):
  hw/char: Add emulation of Diva GSP PCI management boards
  hw/hppa: Wire up Diva GSP card
  artist: Allow disabling artist on command line
  hw/hppa: Avoid creation of artist if disabled on command line
  hw/pci-host/astro: Add LMMIO range support
  target/hppa: Update SeaBIOS-hppa

 MAINTAINERS                 |   1 +
 hw/char/Kconfig             |   3 +
 hw/char/diva-gsp.c          | 297 ++++++++++++++++++++++++++++++++++++
 hw/char/meson.build         |   1 +
 hw/display/artist.c         |   9 +-
 hw/hppa/Kconfig             |   1 +
 hw/hppa/machine.c           |  42 +++--
 hw/pci-host/astro.c         |  52 +++++++
 include/hw/pci-host/astro.h |   6 +-
 roms/seabios-hppa           |   2 +-
 10 files changed, 383 insertions(+), 31 deletions(-)
 create mode 100644 hw/char/diva-gsp.c

-- 
2.47.0


