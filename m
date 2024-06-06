Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C42AC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9oO-0000AP-3p; Thu, 06 Jun 2024 05:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oN-00009z-5D
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:35 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oK-0002GS-Uj
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=V/ohVCg/O3eFdXiCWfSvOJH0uNqMmaBrn20gYrGtWr8=; b=SumT0Qo0I98rUj0S1ToZSCIeo7
 fcYKyWO2Jb0caay6PbKb8DnFqKZ8/xYJjB/dRcmfnPIpRAJvMjSsPq3EtCWUpMfw7qdgqQxAWNzam
 q8IRjCtXMObpinQMqINSCk8p4Lmum0UYV1P7dvU1UbWGxIPScxxtXLrqHcceV27RcqVWbRDMpOGEc
 Bm1vdw6AdpRX3XZua2Qh2peakDdCmyfKic9SBPzULPQUM6hGeYdUGY2e+tt1ZJDFN8i92cG4O1ozp
 FBE6qDfldmiIr5oCQzuytnPiAauUp2TJVDjmtga6FoC998TRHvJDKDTmLJ+/arRVlTSWdR2PkRZ76
 rO6JoBkVy5JDPrTkUw0Cah9x0jAiSYjjr8FC2waS9VXDEvKyA+bX1hZnA5ueWeQsQ8a6jN7yPX34q
 AfdV0uUQc8Il2Gq+6AUawxL3/PeeGD/F4Yow80HfJpT/XNyuaB7H14i+zWCdsg9HWQtNQ2sl6HpwM
 00WS86iPAWIKLRCQGXpwvbb2Z2/X/FuGxCQEOFL0/XVc4pIWZx8lollBdKoDgUwLXCBUNtNfxn0cB
 IxZZBJ0LRYQMouNc4e+Oi3IzptCd81X791mlC05XLLm4i5oQfh2pRcmDgDie/06d77WWKA3pshbI7
 oWdjJF0RM5deMwjOjlvTkON2YHJ0z8YlhlhCTauAY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9mz-0004cT-1V; Thu, 06 Jun 2024 10:52:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2024 10:53:15 +0100
Message-Id: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/4] target/i386: fixes for OS/2 Warp
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series contains two fixes which allow booting OS/2 Warp in QEMU with TCG
(currently it only boots with KVM).

Patches 1 and 2 are tidy-ups which prepare for the POP SP fix in patch 3, whilst
patch 4 is the final fix for ENTER that allows my test image to boot
successfully.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (4):
  target/i386: use local X86DecodedOp in gen_POP()
  target/i386: use gen_writeback() within gen_POP()
  target/i386: fix SP when taking a memory fault during POP
  target/i386: fix size of EBP writeback in gen_enter()

 target/i386/tcg/emit.c.inc  | 8 +++++---
 target/i386/tcg/translate.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.2


