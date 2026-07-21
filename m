Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B28C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDBO-0007NI-9a; Tue, 21 Jul 2026 12:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmDBM-0007N5-NV; Tue, 21 Jul 2026 12:19:00 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmDBG-0007UX-Sl; Tue, 21 Jul 2026 12:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TP
 lGDzBul1pz7Y1IlYa2vAV9l7EMo/3dIospC+MlRlk=; b=dP7VU8pn/tVUVKhHna
 vqAG8DZcx7mf/ohqrKi9aMGEZ85GyWIDoXdf6Ga40LlvZEwPQzJLpJrtU5iRsimi
 54M9tea0OPuJM1uo75oI1dbk0KydkT1NRMhtQwOFXjTki4gEnPuMqZ7Rq5tVGxHI
 kysxYogBSozohPH0rgp3JYIm0=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3F6+wml9qkr5qKg--.58375S2; 
 Wed, 22 Jul 2026 00:13:37 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 0/7] K230: add gsdma and decomp_gzip
Date: Wed, 22 Jul 2026 00:13:28 +0800
Message-ID: <20260721161335.73872-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3F6+wml9qkr5qKg--.58375S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3KryDZw1ftr4rAF45trb_yoW8CF13pw
 nxCwnYkr4S9r1fGr13Jr47KFyrta95Grn8Gr17W345ZrWftF47tFs7ta4YqrWfJw4vq348
 CF10kr1rCw17X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-Originating-IP: [101.204.18.42]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4hFFg2pfmrFo2QAA3a
Received-SPF: pass client-ip=117.135.210.3; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Thanks

Tao Ding (7):
  hw/dma: add K230 gsdma
  hw/riscv: k230: add gsdma in K230 board
  tests/qtest: add test for K230 gsdma
  hw/misc: add K230 decomp gzip
  hw/riscv: k230: add decomp gzip in K230 board
  tests/qtest: add test for K230 decomp gzip
  hw/riscv: k230: add a noc stub region in K230 board

 hw/dma/Kconfig                      |   3 +
 hw/dma/k230_gsdma.c                 | 532 ++++++++++++++++++++++++++++
 hw/dma/meson.build                  |   1 +
 hw/dma/trace-events                 |   6 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/k230_decomp_gzip.c          | 498 ++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 hw/misc/trace-events                |   4 +
 hw/riscv/Kconfig                    |   2 +
 hw/riscv/k230.c                     |  38 +-
 include/hw/dma/k230_gsdma.h         | 128 +++++++
 include/hw/misc/k230_decomp_gzip.h  |  92 +++++
 include/hw/riscv/k230.h             |   5 +
 tests/qtest/k230-decomp-gzip-test.c | 181 ++++++++++
 tests/qtest/k230-gsdma-test.c       | 201 +++++++++++
 tests/qtest/meson.build             |   2 +-
 16 files changed, 1689 insertions(+), 8 deletions(-)
 create mode 100644 hw/dma/k230_gsdma.c
 create mode 100644 hw/misc/k230_decomp_gzip.c
 create mode 100644 include/hw/dma/k230_gsdma.h
 create mode 100644 include/hw/misc/k230_decomp_gzip.h
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c
 create mode 100644 tests/qtest/k230-gsdma-test.c


base-commit: bd6079a7a1d14de0918a7715ef6db85dc32de3bb
-- 
2.43.0


