Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74B7C98309
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9LX9-0005ce-N7; Wed, 23 Sep 2026 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1x9Ho5-0000Oh-VB
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:54:22 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1x9Ho3-0001Z7-IL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:54:21 -0400
DKIM-Signature: a=rsa-sha256; bh=td1wyQTGWPmJNGy5yxEP23OcZe5RL2NEaHyYik6KcOs=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1790150054; v=1;
 b=AjidBCqqhxn+7WIiHPuTgqBlg8HqfW2qfGL+H4SRxDV0nusR24IELjJjKx4oFCPHkCGCDQYu
 nZRE1p4aA3UO3oMRHH5zh1KDgMbWyofSNByrttktLT8idX/L0fIQLWZANbEg+MspRDFsz0KdNf8
 xqHtus6YJrvGVmwJ5ApD8ucWZmrhaNDFbFznK7IP1GriQb+hpjQdeckTQVDV8dpt4BunNvb+L39
 Kkm4xwS/+gnujZ78g3AXPTb5btpbtHlSyQL05oaLpUdtmJFNKtlXOT4vgkY4Nz5snTgyMlmqldq
 yyd8ln5aoTQr+8Fb1HPGGtR8qikfyGD0u3CkYvoMasJJQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id BF760224F6;
 Wed, 23 Sep 2026 07:54:14 +0000 (UTC)
From: ~oyasan2-ba2 <oyasan2-ba2@git.sr.ht>
Date: Wed, 23 Sep 2026 07:54:14 +0000
Subject: [PATCH qemu 0/1] hw/net/e1000e: make PHY power-management match a
 real 82574L
MIME-Version: 1.0
Message-ID: <179015005471.1471.12638559665582988999-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: dmitry.fleytman@gmail.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 jasowangio@gmail.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:04 -0400
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
Reply-To: ~oyasan2-ba2 <oyasan.ba2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series brings e1000e's PHY power-management handling (BMCR.PDOWN,
CTRL.RST vs CTRL.PHY_RST, and the PCI D3hot -> D0 transition) in line
with the 82574 datasheet (Order 317694-016, Rev 2.5) and with what I
measured on a real 82574L NIC (8086:10d3, via direct MDIC register
access, bypassing the guest driver so the link-down and power-down
states could actually be observed).

Currently the model:
- ignores BMCR.PDOWN entirely for the link (patch 1);
- resets the PHY on every CTRL.RST (a software/MAC reset) but not on
  CTRL.PHY_RST (backwards from the datasheet and from what I measured
  on real hardware) (patch 2);
- does nothing on a D3hot -> D0 PCI power-state transition, although
  the datasheet says the device performs an internal reset that
  includes the PHY (patch 3).

Patch 2 depends on patch 1 (e1000e_phy_powered_down()), and patch 3
depends on patch 2 (e1000e_phy_reset()). Each patch adds its own qtest
(phy_power_down, phy_reset_semantics, phy_d3hot_reset); I verified each
new test fails without its patch and passes with it, and that the
existing e1000e qtests (init, tx, rx, multiple_transfers, hotplug)
still pass throughout. The series applies to and builds cleanly against
current master.

I found this while implementing a fault-injection test harness for the
e1000e driver (suspend/resume and RX-buffer fault scenarios) - the
model's link/PHY state didn't behave like the real 82574L it emulates,
which made some of those scenarios impossible to exercise faithfully.

oyasan2-ba2 (1):
  hw/net/e1000e: reset the PHY on a D3hot to D0 transition

 hw/net/e1000e.c           | 14 ++++++++++++++
 hw/net/e1000e_core.c      | 15 +++++++++++++++
 hw/net/e1000e_core.h      |  3 +++
 tests/qtest/e1000e-test.c | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

-- 
2.49.1

