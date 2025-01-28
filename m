Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CEAC02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoEv-0005IK-Un; Tue, 28 Jan 2025 11:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEt-0005Hh-Dl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:14:59 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEr-0002bo-Ii
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:14:59 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B2DC2A407ED;
 Tue, 28 Jan 2025 16:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DD7C4CED3;
 Tue, 28 Jan 2025 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738080893;
 bh=qzf2PinvfH0FiyMFKejJrjGcQMve/xCBPTpF17YIjYI=;
 h=From:To:Cc:Subject:Date:From;
 b=PpMsX/sJYMIE3mMyA0nDSIjd2DhU632EgBk9izs27MwX2qGisM802psvjC/2WgtBA
 JbDOX7Ldq1p5fvJeMcVYOYNRYh5yJbrMGfNQOg1D+v9AfSH5xZr1xIXQZ/4aXfLZ9q
 jsXKDJEMYm+tnSG8mcg3t+putQWxrzUEp1I+6ERuhHjUtT0LJmHy1sgMBMomZMBaAz
 09RWA3o7U7YfqODgAyaqUBlv9wtITwieUbJqu+55E1Q0705ygod61cHEJefmG6XN1t
 gVk9/tpaCQFdVTwxe1xOCEJ5SQFHZbuYGODWjQAyHPSjXEGVPHVfOCvVQow+Ir3EJm
 mvBJfdMld2Gqw==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/5] hppa 64-bit improvements
Date: Tue, 28 Jan 2025 17:14:45 +0100
Message-ID: <20250128161450.12975-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The 64-bit hppa qemu emulation still fails to boot 64-bit HP-UX.
This patch series improves the emulation a lot, since it enables us to boot
64-bit HP-UX installer silently up until an endless loop where the machine
reports that it's up an running (it crashed before). This still needs further
analysis, but it's a big step forward.

Main changes to archieve this includes:
- Implementing diagnose registers (especially %dr2 for space-register hashing)
- Add Diva GSP card, as the currently used serial port emulation crashes on HP-UX 64-bit
- Fixes and improvements in SeaBIOS-hppa, including:
  - parisc: Fix IRT table entries to use slot number
  - parisc: Increase PCI alignment for memory bars to 64k
  - parisc: Fix PDC_CACHE/PDC_CACHE_RET_SPID return value
  - parisc: Allow up to 256 GB RAM on 64-bit machines

The SeaBIOS-hppa binary blob is not sent with this patch series, but
will be included in the final pull request. In case you want to test
the series, please use devel branch of SeaBIOS-hppa from
https://github.com/hdeller/seabios-hppa/tree/devel

Please review.

Helge Deller (5):
  hppa: Sync contents of hppa_hardware.h header file with SeaBIOS-hppa
  disas/hppa: implement mfdiag/mtdiag disassembly
  target/hppa: Implement CPU diagnose registers for 64-bit HP-UX
  hw/char: Add emulation of Diva GSP PCI management boards
  hw/hppa: Wire up Diva GSP card

 MAINTAINERS              |   1 +
 disas/hppa.c             |  23 +++-
 hw/char/Kconfig          |   5 +
 hw/char/diva-gsp.c       | 291 +++++++++++++++++++++++++++++++++++++++
 hw/char/meson.build      |   1 +
 hw/hppa/Kconfig          |   1 +
 hw/hppa/hppa_hardware.h  |  36 ++++-
 hw/hppa/machine.c        |  29 ++--
 target/hppa/cpu.c        |   3 +-
 target/hppa/cpu.h        |  24 ++--
 target/hppa/helper.c     |   4 +-
 target/hppa/insns.decode |   6 +-
 target/hppa/int_helper.c |   6 +-
 target/hppa/machine.c    |   5 +-
 target/hppa/sys_helper.c |   2 +-
 target/hppa/translate.c  |  24 +++-
 16 files changed, 411 insertions(+), 50 deletions(-)
 create mode 100644 hw/char/diva-gsp.c

-- 
2.47.0


