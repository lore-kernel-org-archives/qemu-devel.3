Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D28C4452D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrBa-0007s0-DL; Mon, 20 Jul 2026 12:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrBY-0007no-Mw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:49:44 -0400
Received: from mail-43171.protonmail.ch ([185.70.43.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrBX-0004Qg-3U
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784566174; x=1784825374;
 bh=yrkWP1pU6GaNLvSexglusKT0/s8MV28FxZSAenGt8cs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nVyr+Uc3YPz6G1CZT0S6NW3nsiFKGHt/6ffwlgACjKVptR3KbGpd2ZNJ39GPuAd37
 EiKlFJkX3RLi5s3DVKPeS3/Mi7CaWTEi4Kep57KOihd7xmPt/VdWGy6zUwau13jMW4
 7zz6VZPfOC4WvHTZO3dpyNVELjdMbehM3ESiXWDihl1VpRkMO5vTPwo7Q6WIaLdfaW
 NS0a6iRKov0i8kITEIQhfaoNrpDmyO22UVLiHDRDaH4Rq053HqSJZa5Ue7qSX8W9ma
 uSa/JJhNK+Z5jXNAEJFqxRFSDzZ5zpknsAewGwrqcaqrCgtai+H1gGho0RLu8ewc8b
 HLDBU0KPDSzQw==
X-Pm-Submission-Id: 4h3mhD4qCGz2Scsg
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH v4 0/2] hw/misc/applesmc: fix GET_KEY_BY_INDEX iteration and
 populate Apple SMC key set
Date: Mon, 20 Jul 2026 09:49:28 -0700
Message-ID: <20260720164930.68383-1-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260719152343.69536-1-matthew@pq.io>
References: <20260719152343.69536-1-matthew@pq.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.70.43.171; envelope-from=matthew@pq.io;
 helo=mail-43171.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The applesmc device only answers APPLESMC_READ_CMD at its command
port. Modern macOS guests (x86 10.14+, all 15.x) also issue WRITE,
TYPE and GET_KEY_BY_INDEX, and enumerate the SMC key space at boot.
The unanswered commands and the near-empty key table drive the
AppleSMC kext into a kSMCSpuriousData retry storm (~1800 errors/sec,
kernel_task ~70% CPU, WindowServer ~509% CPU on macOS 15).

Patch 1 implements the missing commands. Patch 2 populates the key
table with a realistic iMac20,1 profile and the canonical #KEY count,
so the guest's boot-time enumeration terminates.

v4:
  - Regenerated against current master. Drop a stray hunk in patch 2/2
    that reverted the qdev-properties.h include move (commit 78d45220b4);
    the include is now left untouched. Reported-by Philippe
    Mathieu-Daudé. No functional change.
  - No other changes from v3.

v3: https://lore.kernel.org/qemu-devel/20260719152343.69536-1-matthew@pq.io/
v2: addressed Peter Maydell's style review (loop braces, stl_be_p()).
v1: https://lore.kernel.org/qemu-devel/20260507040153.14565-1-matthew@pq.io/

Matthew Jackson (2):
  hw/misc/applesmc: implement GET_KEY_BY_INDEX, WRITE and TYPE commands
  hw/misc/applesmc: populate Apple SMC key table

 hw/misc/applesmc.c | 344 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 7 deletions(-)

-- 
2.50.1 (Apple Git-155)


