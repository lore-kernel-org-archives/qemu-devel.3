Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BC8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJLZ-0001jg-7r; Mon, 13 Jul 2026 12:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wjJLW-0001jT-0F; Mon, 13 Jul 2026 12:17:30 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wjJLP-0008N9-8K; Mon, 13 Jul 2026 12:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=u6
 rbSEcSI9kk2W9fuHR8M04+CEA2V0YauzveIRvl0r4=; b=NVLr4MszRYl6/Lufip
 Y4QCPVgPfge4BiSHU9J8z7WzP1E7zjI5bvuEZHjMAB6rCF9oZ5ntfeG4qS9+Kc1O
 6Gh8BN64dpAcn04m8Sg9hQ6PzHFHIMyaZ8fnnqZZTlTFety+fC4vet/8FwvihOB0
 q9dEdiJYSlGch1YR8o6HOGweU=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgDHn6V0D1Vqlt9mGA--.65356S2;
 Tue, 14 Jul 2026 00:16:53 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Subject: [PATCH v6 0/2] sdhci: fix SDMA boundary bug
Date: Tue, 14 Jul 2026 00:16:45 +0800
Message-ID: <20260713161647.20211-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgDHn6V0D1Vqlt9mGA--.65356S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8JFWkZr1DurWxCw1UGFg_yoWfWFX_Cw
 1xKryvqFWUZanFka4IkFn0yrWIka1aqw18WFyDJr47ua4UCFnxJ3Z2939aqw1rWayrKrZa
 yr1qyryfAr9rtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRibyC5UUUUU==
X-Originating-IP: [119.4.20.225]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-hbQD2pVD3ZpPgAA3m
Received-SPF: pass client-ip=117.135.210.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The previous series was posted here:
https://lore.kernel.org/qemu-devel/20260707170457.11659-1-dingtao0430@163.com/

Thanks

Changes in v5->v6:
* patch 1/2. The conditions for setting the status have been modified.
  Use subsection for migration, rather than increasing the version_id.
* patch 2/2 is unchanged. keep Reviewed-by Bin Meng.

Tao Ding (2):
  hw/sd: sdhci: Fix SDMA boundary bug
  qtest: add xilinx-zynq SDHCI sdma test

 hw/sd/sdhci.c                        |  25 +++-
 include/hw/sd/sdhci.h                |   2 +
 tests/qtest/meson.build              |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
 4 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c


base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
-- 
2.43.0


