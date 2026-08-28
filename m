Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F6DC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztGn-0002mj-9P; Fri, 28 Aug 2026 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wztGl-0002mD-Mq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:53:07 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wztGj-00044b-FL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:53:07 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 5A5BA240027
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1787910781;
 bh=SokU8K37ffQFmkbPET/IvZCsRNFHZGPFJ5DsgVsXduY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=nXe3sl8wOLeLPNI6rDcTpI0jhMiVxuk+IGfyY10SfHs8DFKgF56qAjk2CNnN7jOcU
 ZXm+a9KPsk+MjS1usl8aRHeVUPX6rmBuxbw5WmM7tBwr0FK0Hn5E6Hon2IgbDID2w9
 euxlEZZfHXUipEWYbeI9xT/efScvwELgwq96Y7n8OXCc5VqGqD05towdcqdTyb400Q
 ghQMkjuDqW2Cq/AWDfjrlplzkoRah7IGySwSIbm2GCVbHp3QPh7RBPGgQkz1yueG0D
 NfCYZ4ZwVYfCWb1yWtvGm4tl61mnR/zP6ZAPvhp4+rAiizGRUScAXN4uTkZ1ZiBWEr
 35v1eNnSVh0Xw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hWYbc48hlz6twH;
 Fri, 28 Aug 2026 11:53:00 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 0/3] Fix bugs in the next-cube code and deprecate it
Date: Fri, 28 Aug 2026 09:53:01 +0000
Message-ID: <20260828095241.118458-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix some guest-triggerable assert() and abort() statements in the
next-cube machine. Since this machine is incomplete and not really
usable, mark it as deprecated and orphan, so we can remove it in
a couple of releases if nobody chimes in to get it into a proper
state.

Thomas Huth (3):
  hw/m68k/next-cube: Replace assert()s and abort()s with logging
    functions
  docs/about: Deprecate the 'next-cube' m68k machine
  MAINTAINERS: Mark the next-cube machine as "Orphan"

 MAINTAINERS               |  3 +--
 docs/about/deprecated.rst |  8 ++++++++
 hw/m68k/next-cube.c       | 10 ++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.55.0


