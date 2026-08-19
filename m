Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD51EC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdl-0007zk-7M; Wed, 19 Aug 2026 08:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzU-0005Pk-3y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:36 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzS-0000Jt-JO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:35 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwZz9-000000002QW-0Rnv; Wed, 19 Aug 2026 06:41:15 +0000
Date: Wed, 19 Aug 2026 07:41:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/misc/applesmc: Implement writes, the shutdown
 watchdog and get-key-type
Message-ID: <cover.1787114994.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2a07:2ec0:3002::65;
 envelope-from=daniel@makrotopia.org; helo=pidgin.makrotopia.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

QEMU's AppleSMC device only implements the SMC read command, so every
other command a guest issues fails with kSMCBadCommand. Tracing a macOS
guest shows it relies on two more: the write command (0x11) and
get-key-type (0x13). The missing write command delays boot (macOS retries
failed boot-time key writes) and produces a stream of
SMCWDT::setWatchdogTimer errors at shutdown; the missing get-key-type is
rejected dozens of times during boot.

This series implements what the guest actually uses, one command per
patch for reviewability:

  1/4  add trace events, so the SMC conversation can be observed with
       -trace 'applesmc*' (used to find exactly which commands and keys
       macOS issues).
  2/4  implement the write command (0x11): accept writes and return
       success, removing the boot delay and the shutdown errors.
  3/4  model the "NATi"/"NATJ"/"OSWD" keys as the SMC shutdown watchdog
       they represent, rather than silently accepting the writes: a write
       arms, refreshes or disarms a QEMUTimer whose expiry forces the
       machine down.
  4/4  implement get-key-type (0x13): give each key an SMC type and answer
       the type queries instead of rejecting them.

Traced against a macOS guest before and after: the boot-time key writes
(NTOK, MSDW, QENA, HE0N) now succeed, the shutdown "OSWD" write (a
watchdog disarm) is handled, and the get-key-type rejections become
correct replies (for example REV is reported as {rev, six bytes). The
traced guest only disarms the watchdog; the arm-and-fire path in patch 3
is the documented behaviour for a guest that arms it and was not observed
being triggered. get-key-by-index (0x12) is deliberately not implemented,
as macOS never issues it.

Daniel Golle (4):
  hw/misc/applesmc: Add trace events
  hw/misc/applesmc: Implement the write command
  hw/misc/applesmc: Emulate the SMC shutdown watchdog
  hw/misc/applesmc: Implement the get-key-type command

 hw/misc/applesmc.c   | 174 +++++++++++++++++++++++++++++++++++++++++--
 hw/misc/trace-events |  16 ++++
 2 files changed, 183 insertions(+), 7 deletions(-)


-- 
2.55.0

