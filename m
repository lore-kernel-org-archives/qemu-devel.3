Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8C0CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssNpW-0006Jr-4z; Sun, 22 Sep 2024 10:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1ssMab-000348-NF
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 09:25:25 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1ssMaZ-0003CI-Pa
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 09:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Ow6oX
 iwAhwtp4OL/Y/PpCARKFX1IzK1xBuRtLH5Lp6A=; b=J/XLXG00ChM8cOlDbar6H
 N5xW1TIRf6JRP/dLBt57ISkAW/yGYMocD8J46YtB4GrHac/xu7ieflVEl5LoSjjZ
 VpM8pJC0pH27i5vPfX+VzS3SQG+bcIw9J3QTMbsH5ljEYrrjnDu8V5G3PJdpUG9P
 bl8UdMEo2ZTpDaChjGUkLc=
Received: from localhost.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgAH56yXGvBmHbLdAA--.24843S2;
 Sun, 22 Sep 2024 21:24:39 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v1 0/2] Drop ignore_memory_transaction_failures for xilink_zynq
Date: Sun, 22 Sep 2024 21:24:31 +0800
Message-ID: <cover.1727008203.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgAH56yXGvBmHbLdAA--.24843S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4xwsDUUUU
X-Originating-IP: [117.173.244.102]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEhRiKGbv-WsyvAAAsd
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 22 Sep 2024 10:44:51 -0400
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

The ignore_memory_transaction_failures is used for compatibility
with legacy board models. 

I attempted to remove this property from the
xilink_zynq board and replace it with unimplemented devices to 
handle devices that are not implemented on the board.

Chao Liu (2):
  xilink_zynq: Add various missing unimplemented devices
  xilink-zynq-devcfg: Fix up for memory address range size not set
    correctly

 hw/arm/xilinx_zynq.c      | 44 ++++++++++++++++++++++++++++++++++++++-
 hw/dma/xlnx-zynq-devcfg.c |  2 +-
 2 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.46.1


