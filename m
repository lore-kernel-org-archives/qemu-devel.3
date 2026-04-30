Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA46CFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrS-0007mA-Ir; Thu, 30 Apr 2026 12:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITr9-0007U5-GO; Thu, 30 Apr 2026 12:03:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITr6-00077g-Bm; Thu, 30 Apr 2026 12:03:15 -0400
DKIM-Signature: a=rsa-sha256; bh=FTOONq+xVZSYimkNcwm7tLoBSTwv7vH0/MrNqv4xniw=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1777564988; v=1;
 b=a/0y79VIQt6yNtNObfvnnquIuuCcNXDJonYUWWUNuH7bUsYmglzOqtjmbcGZfIX8GQJzPWko
 /aV25jkO6gqa44NG8dMdwL/kjxXsEllTNInhmZjP6q1yoMKnsm/eTxF53H/1llZMnTE0PuCgxjb
 krRjnu8sF/x+XV+c6Mv4z/gkCibh3rrxd1zleBh3NFsUuz50FtodNP3CkFVv+HIfAn4SOIxvbfM
 qBQypG3VQDeCE8BSFw/Y031TzYRJtTAYu9NXCJbUCE3T6HUM/ZTOEntE0HY0pDv/cXZd9s1RLkT
 ASlPMpiuwpEbzwnD0Cv6irULemCr2ShmJvBjFMD6v+BKQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 3C48420C10;
 Thu, 30 Apr 2026 16:03:08 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Thu, 30 Apr 2026 16:03:07 +0000
Subject: [PATCH qemu v4 0/9] Update opentitan uart (part of supporting
 opentitan version 1)
MIME-Version: 1.0
Message-ID: <177756498815.8917.12449488721849651971-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is the fourth revision of the patch set that updates the
OpenTitan uart to align with Earlgrey version 1.0.0.

For a specific git commit from OpenTitan that we are aiming to
support:
https://github.com/lowRISC/opentitan/tree/Earlgrey-PROD-M6
(git tag Earlgrey-PROD-M6, which is commit a78922f)

Once again, for completeness, the details of the version 1 of the UART
are found here:
https://opentitan.org/book/hw/ip/uart/index.html
(and this URL is still added to the file header in one of these commits,
as before)

Fixes in this revision:
- removed accidental add/delete of unused #define.
- added documentation about break condition in commit message
   and also in a documentation file (is it in a suitable place?)
   this is copied from the documentation on our (lowRISC's) fork.
- removed the commit that removes the regular clock pulse to
   transmit data. Following the discussion, I think it's better to merge
   this without that change for now, and if we decide we need it in
   the future we will test it with tock and propose the change again.
- one review comment I couldn't fix: the one that suggested adding
   a return statement to avoid an else block. There is logic after the
   else block that runs in both cases, so I can't remove that.

Thanks!

Lex.

Lex Bailey (9):
  Rename ibex_uart to ot_uart
  ot_uart: move to new reset API
  ot_uart: update register defs, switch to Fifo8 for tx/rx buffers
  ot_uart: replace individual IRQ fields with array, add missing IRQs
  ot_uart: gather similar behaviours togeter in register read and write
  ot_uart: implement RX fifo and loopback
  ot_uart: handle break condition
  ot_uart: update file headers with new authorship and documentation URL
  ot_uart: add tracing

 MAINTAINERS                          |   1 +
 docs/system/riscv/opentitan-uart.rst |  43 ++
 hw/char/Kconfig                      |   3 +
 hw/char/ibex_uart.c                  | 569 --------------------
 hw/char/meson.build                  |   2 +-
 hw/char/ot_uart.c                    | 778 +++++++++++++++++++++++++++
 hw/char/trace-events                 |   8 +
 hw/riscv/Kconfig                     |   1 +
 hw/riscv/opentitan.c                 |   3 +-
 include/hw/char/ibex_uart.h          |  73 ---
 include/hw/char/ot_uart.h            |  70 +++
 include/hw/riscv/opentitan.h         |   4 +-
 12 files changed, 909 insertions(+), 646 deletions(-)
 create mode 100644 docs/system/riscv/opentitan-uart.rst
 delete mode 100644 hw/char/ibex_uart.c
 create mode 100644 hw/char/ot_uart.c
 delete mode 100644 include/hw/char/ibex_uart.h
 create mode 100644 include/hw/char/ot_uart.h

-- 
2.49.1

