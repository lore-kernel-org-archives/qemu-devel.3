Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5961DC55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsaWA-0007Hx-Ey; Sat, 08 Aug 2026 02:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaW5-0007H1-K4; Sat, 08 Aug 2026 02:26:46 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaVz-0003T1-Re; Sat, 08 Aug 2026 02:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lz
 HUiB/p9JjF3cS96Gi8N4rvR7puvYEP53JwCJ4+DO8=; b=Vuf9/HjHE1B36+qqMx
 CsSYKD8tWMOYXik7QUbsWrb11ppk66dD91OacRQH0E7jX73da2CdgjUxEKjKtMsG
 5VGZqovmqQdE5/8jGR2wix0nyQEkEf9n9ydlE8eHmdFXli/PNa7QkbQMXAsGSyWa
 3B02pNQ764cSGSZwIU0F4N0vM=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgC3_wsky3Zq2MzjLw--.10202S2;
 Sat, 08 Aug 2026 14:22:30 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v3 0/7] K230: add gsdma and decomp_gzip
Date: Sat,  8 Aug 2026 14:22:20 +0800
Message-ID: <20260808062227.66961-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgC3_wsky3Zq2MzjLw--.10202S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3KryDZF4xurW3uF45ZFb_yoW8tF4xp3
 ZxCwnYkr4I9r1fGry3JF47KFyFqa95Grn8Gr17W34avrW3tF4Utrs7ta4YqrWfJw4qg348
 CFy0kr1fuw17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ3ktUUUUU=
X-Originating-IP: [101.204.17.203]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-gg1c2p2yyh0VgAA3t
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi all,

This patch series adds GSDMA and Decomp_gzip to the K230 board.
Enable k230 to use k230_unzip to decompress files during the u-boot phase.

This series includes the following features:

*patch1: add K230 gsdma which supports sdma, gdma is temporarily not supported
*patch2: add gsdma to K230 board
*patch3: add K230 gsdma qtest
*patch4: add K230 decomp_gzip which decompress data work with sdma
*patch5: add decomp_gzip to K230 board
*patch6: add K230 decomp_gzip qtest
*patch7: add a noc-stub region in K230 board

Patch-v2 is posted in:
https://lore.kernel.org/qemu-devel/20260727155702.36484-1-dingtao0430@163.com/

Changes in v3:
*patch1: 
  Removed temporarily unimplemented GDMA register read and write.
  Print with qemu_log_mask for access register errors.
*patch4:
  Print with qemu_log_mask for handle error ack signal.

Tao Ding (7):
  hw/dma: add K230 gsdma
  hw/riscv: k230: add gsdma in K230 board
  tests/qtest: add test for K230 gsdma
  hw/misc: add K230 decomp gzip
  hw/riscv: k230: add decomp gzip in K230 board
  tests/qtest: add test for K230 decomp gzip
  hw/riscv: k230: add a noc stub region in K230 board

 MAINTAINERS                         |   6 +
 docs/system/riscv/k230.rst          |   2 +
 hw/dma/Kconfig                      |   3 +
 hw/dma/k230_gsdma.c                 | 551 ++++++++++++++++++++++++++++
 hw/dma/meson.build                  |   1 +
 hw/dma/trace-events                 |   6 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/k230_decomp_gzip.c          | 511 ++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 hw/misc/trace-events                |   4 +
 hw/riscv/Kconfig                    |   2 +
 hw/riscv/k230.c                     |  38 +-
 include/hw/dma/k230_gsdma.h         | 130 +++++++
 include/hw/misc/k230_decomp_gzip.h  |  92 +++++
 include/hw/riscv/k230.h             |   5 +
 tests/qtest/k230-decomp-gzip-test.c | 200 ++++++++++
 tests/qtest/k230-gsdma-test.c       | 201 ++++++++++
 tests/qtest/meson.build             |   2 +-
 18 files changed, 1750 insertions(+), 8 deletions(-)
 create mode 100644 hw/dma/k230_gsdma.c
 create mode 100644 hw/misc/k230_decomp_gzip.c
 create mode 100644 include/hw/dma/k230_gsdma.h
 create mode 100644 include/hw/misc/k230_decomp_gzip.h
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c
 create mode 100644 tests/qtest/k230-gsdma-test.c


base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
-- 
2.43.0


