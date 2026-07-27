Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C2EC531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNhs-0003Hw-CN; Mon, 27 Jul 2026 11:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1woNhq-0003Gb-CV; Mon, 27 Jul 2026 11:57:30 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1woNhm-0006LR-T0; Mon, 27 Jul 2026 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zY
 7E7E19l8gZKfs7dEt/TTZQ7d9Ks5NskwbKsi7QjsI=; b=kCO8xQGlLVF9s6FVzD
 2nATocM1+zkVOSeZ2xVSIg7Lr+8t04c8fRK3o7Dlvj6LoS2Wjk3KTSlSaHm/IT5v
 a6aOq9FC+xHMdssHBTe8MmKEMS+MVt6AvCbJTMpjpO0Y2qImldBqMg01pksyDzNe
 8hEL/tpbTK9dl2qqfTzK+LSfQ=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wC3HpHQf2dqJpF_Kw--.27173S2; 
 Mon, 27 Jul 2026 23:57:04 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 0/7] K230: add gsdma and decomp_gzip
Date: Mon, 27 Jul 2026 23:56:55 +0800
Message-ID: <20260727155702.36484-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3HpHQf2dqJpF_Kw--.27173S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr15Jw1DJF4rJF48tFWxtFb_yoW5GFyxp3
 sxCrnYkr4I9r1fJrW3Gr47tryFvayrGr15GrnrW345ZrW3tF45tFs2qa4FyrW3Jw4qg34x
 uF1vkr1fur17ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimsjUUUUUU=
X-Originating-IP: [119.4.23.14]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-hCIxmpnf9APhgAA3L
Received-SPF: pass client-ip=117.135.210.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

patchv1 is posted in:
https://lore.kernel.org/qemu-devel/20260721161335.73872-1-dingtao0430@163.com/

Changes in v2:
*patch1: 
  add endian conversion
  replace reset method
  update MAINTAINERS
  fixed the bug not clear enable register after dma finish
  fixed the bug in 2d-mode and src_fixed scr_addr should not increment
*patchv2:
  update K230 rst
*patch3:
  update MAINTAINERS
*patch4:
  replace reset method
  check dynamic huffman format in compressed data
  fixed the bug of read a write only bit in DECOMP_START register
  update MAINTAINERS
  update K230 rst
*patch6:
  compressed data is re generated using dynamic Huffman method,
  with added annotations and explanations
  update MAINTAINERS

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
 hw/dma/k230_gsdma.c                 | 562 ++++++++++++++++++++++++++++
 hw/dma/meson.build                  |   1 +
 hw/dma/trace-events                 |   6 +
 hw/misc/Kconfig                     |   3 +
 hw/misc/k230_decomp_gzip.c          | 508 +++++++++++++++++++++++++
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
 18 files changed, 1758 insertions(+), 8 deletions(-)
 create mode 100644 hw/dma/k230_gsdma.c
 create mode 100644 hw/misc/k230_decomp_gzip.c
 create mode 100644 include/hw/dma/k230_gsdma.h
 create mode 100644 include/hw/misc/k230_decomp_gzip.h
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c
 create mode 100644 tests/qtest/k230-gsdma-test.c


base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
-- 
2.43.0


