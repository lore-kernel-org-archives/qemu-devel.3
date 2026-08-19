Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9D2C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkDa-000590-B8; Wed, 19 Aug 2026 13:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDX-00058g-Rs
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:36:48 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDW-0001UM-8I
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:36:47 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDR-000000005lM-1mWt; Wed, 19 Aug 2026 17:36:41 +0000
Date: Wed, 19 Aug 2026 18:36:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Matthew Jackson <matthew@pq.io>, Alexander Graf <agraf@csgraf.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/misc/applesmc: SMC shutdown watchdog and trace events
Message-ID: <cover.1787150842.git.daniel@makrotopia.org>
References: <20260720164930.68383-1-matthew@pq.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720164930.68383-1-matthew@pq.io>
Received-SPF: pass client-ip=2a07:2ec0:3002::65;
 envelope-from=daniel@makrotopia.org; helo=pidgin.makrotopia.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These two patches are the part of my earlier AppleSMC series [1] that is not
already covered by Matthew Jackson's Apple SMC v4 series [2], rebased on top
of it.

Matthew's series is the more complete of the two -- besides the write and
get-key-type commands (which we implemented independently) it also handles
get-key-by-index and populates a full key table -- so I have dropped the
overlapping patches from mine and kept only the two bits it does not cover:

  1/2  trace events for the command dispatch and each handler, so the
       SMC command/key conversation can be watched with -trace 'applesmc*'.
       This is how the exact set of commands and keys a macOS guest relies
       on was found in the first place.

  2/2  the SMC shutdown watchdog: the "NATi"/"NATJ"/"OSWD" keys that patch
       1/2 of Matthew's series accepts and discards are the watchdog macOS
       arms to force the machine down. Model them as a QEMUTimer that a
       write arms, refreshes or disarms.

Both apply on top of Matthew's v4 [2]; they touch only hw/misc/applesmc.c
and hw/misc/trace-events and do not conflict with it.

Tested by booting a macOS 26 (Tahoe) guest on Matthew's v4 plus these two
patches. It boots and shuts down cleanly; every SMC command the guest issues
is accepted (0 rejected out of 77 in one boot+shutdown), the boot-time key
writes (NTOK, MSDW, QENA, HE0N) succeed, get-key-type is answered for the 60+
keys the guest probes, and on shutdown the guest's "OSWD" write is handled as
a watchdog disarm (trace_applesmc_wdt_disarm). The guest arms the watchdog
only to disarm it on the way down; the arm-and-expiry path is the documented
behaviour for a guest that does arm it.

[1] https://patchew.org/QEMU/cover.1787114994.git.daniel@makrotopia.org/
[2] https://patchew.org/QEMU/20260720164930.68383-1-matthew@pq.io/

Daniel Golle (2):
  hw/misc/applesmc: Add trace events
  hw/misc/applesmc: Emulate the SMC shutdown watchdog

 hw/misc/applesmc.c   | 80 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events | 13 +++++++
 2 files changed, 93 insertions(+)

-- 
2.55.0

