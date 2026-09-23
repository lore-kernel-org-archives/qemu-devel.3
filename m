Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD294C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9UyP-0004ng-0h; Wed, 23 Sep 2026 17:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <manueleconti@Manueles-MacBook-Pro.local>)
 id 1x9Ulz-0001ZK-HI; Wed, 23 Sep 2026 17:45:06 -0400
Received: from [82.84.137.98] (helo=Manueles-MacBook-Pro.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <manueleconti@Manueles-MacBook-Pro.local>)
 id 1x9Ulx-0003bC-Hl; Wed, 23 Sep 2026 17:45:03 -0400
Received: by Manueles-MacBook-Pro.local (Postfix, from userid 501)
 id A8BA79983791; Wed, 23 Sep 2026 22:27:38 +0200 (CEST)
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manuele Conti <manuele.conti@archimede-energia.com>
Subject: [PATCH 0/2] stm32f405: timer periodic/CEN fixes + RCC ready mirroring
Date: Wed, 23 Sep 2026 22:27:31 +0200
Message-ID: <20260923202733.24933-1-manuele.conti@archimede-energia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 82.84.137.98 (failed)
Received-SPF: none client-ip=82.84.137.98;
 envelope-from=manueleconti@Manueles-MacBook-Pro.local;
 helo=Manueles-MacBook-Pro.local
X-Spam_score_int: 25
X-Spam_score: 2.5
X-Spam_bar: ++
X-Spam_report: (2.5 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:56:32 -0400
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

Two independent STM32F405 fixes with qtests on netduinoplus2.

Patch 1 fixes the stm32f2xx timer periodic mode: period ARR + 1
including ARR == 0, CNT wrap, CNT freeze/preset across CEN via a new
stopped_cnt (VMState v2), and reset cancelling a pending timer event.

Patch 2 mirrors RCC oscillator-ready and system-clock status
(HSERDY=HSEON, PLLRDY=PLLON, SWS=SW) as an instantaneous simplified
model.

USART IDLE line detection is intentionally excluded here and will
follow as a separate series once baud-derived timing, VMState and a
dynamic qtest are in place.

Manuele Conti (2):
  hw/timer/stm32f2xx_timer: fix periodic mode, CNT wrap and CEN handling
  hw/misc/stm32_rcc: mirror oscillator ready and system clock status

 MAINTAINERS                        |   1 +
 hw/misc/stm32_rcc.c                |  18 ++++
 hw/timer/stm32f2xx_timer.c         | 101 ++++++++++++++++----
 include/hw/timer/stm32f2xx_timer.h |   7 ++
 tests/qtest/meson.build            |   5 +
 tests/qtest/stm32f405-rcc-test.c   |  57 ++++++++++++
 tests/qtest/stm32f405-timer-test.c | 142 +++++++++++++++++++++++++++++
 7 files changed, 312 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/stm32f405-rcc-test.c
 create mode 100644 tests/qtest/stm32f405-timer-test.c

-- 
2.41.0


