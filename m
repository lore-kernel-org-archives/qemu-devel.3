Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C46C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Gp-0000GK-4V; Tue, 07 Jul 2026 10:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh7Gm-0000Fe-DO; Tue, 07 Jul 2026 10:59:32 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh7Gf-0004Zh-In; Tue, 07 Jul 2026 10:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VY
 AQl0BG8jPEb7ZZqRu/I5LJivTi0dK/X2DbNl62NnY=; b=ZOxdDDsOiM2OmsgWF6
 PiqSEnOYczIj5320QF1j8/ga1T4mDR6BLnQIfXqY4OURsz5Nh4bC2+5+hm8U2mSA
 syHQCMbjwx57eY0ZHuPLgX1RgTB6uvpxvSlZhgO64U2C2iSR3Gn3Gw1eenXZqWGy
 pD128FMoViCh53eoIp7u1/wr0=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3w8c0FE1qkL+WIQ--.617S2;
 Tue, 07 Jul 2026 22:59:02 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Subject: [PATCH v4 0/2] sdhci: fix SDMA boundary bug
Date: Tue,  7 Jul 2026 22:58:57 +0800
Message-ID: <20260707145859.12670-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3w8c0FE1qkL+WIQ--.617S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr43Xw43AF18ZFWxJw15XFb_yoWfCrb_uw
 17KrWkWF4UJFsrJa40yF1qvrWIkrW2qw1UWF98t3y7Ca4j9Fy7tFnak3ykJ3WrXa1rKrZa
 yr1DtryfJrnrtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi7PE5UUUUU==
X-Originating-IP: [175.152.42.218]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4RcAPmpNFDdF-QAA30
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

This series fixes an SDMA multi-block transfer bug in the generic SDHCI
controller.

v3 of this series was posted here:
https://lore.kernel.org/qemu-devel/20260701155759.43328-1-dingtao0430@163.com

Thanks

Changes in v3->v4:
* patch 1/2 fixed a bug when blkcnt decreases to 1 not clear sdma_boundary_paused.
  In sdhci_sdma_transfer_single_block, sdma_boundary_paused will be cleared.
* patch 2/2 is unchanged. keep Reviewed-by Bin Meng.

Tao Ding (2):
  hw/sd: sdhci: Fix SDMA boundary bug
  qtest: add xilinx-zynq SDHCI sdma test

 hw/sd/sdhci.c                        |  10 +-
 include/hw/sd/sdhci.h                |   2 +
 tests/qtest/meson.build              |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c


base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
-- 
2.43.0


