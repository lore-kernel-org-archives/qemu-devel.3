Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BFEC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weF8R-0001dW-CJ; Mon, 29 Jun 2026 12:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1weF7x-0001SY-5W; Mon, 29 Jun 2026 12:46:35 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1weF7u-0006zJ-BB; Mon, 29 Jun 2026 12:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vJ
 rV/Ckza0Bh0YVW0GqMeKM5p4AeioWxVjuT6cgZIHk=; b=a1mgeUpjA0OaPylLLY
 edjK83Toe67acIU1WsQa2VuphGOF08kFTNerHestrz4FKBKWr6VZjJTf0EQZRjB1
 zv5SLO7GspIKWHrtFtlanNZO/aJT3OR+H0JBibq/7me2/Bj6+pwL53f9Oed0cDll
 TEkRTH9Pgf1q40M9c3rcNI6EQ=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD311NLoUJq1eP1Gg--.32114S2; 
 Tue, 30 Jun 2026 00:46:03 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 0/2] sdhci: fix SDMA boundary bug
Date: Tue, 30 Jun 2026 00:45:31 +0800
Message-ID: <20260629164533.42956-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD311NLoUJq1eP1Gg--.32114S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW3XF4Utr1DZry8JFy3XFb_yoW3twc_Cr
 nFka4kJa9xXFsrAa4IyF4qv34Ska1Yqw1UXFyDGr17G34IkF13X3Wv93y8Ww1rXw4rKrWS
 yr4qyryxAFnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRijg45UUUUU==
X-Originating-IP: [101.204.16.250]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4Qym5GpCoUzxVAAA3P
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

v1 of this series was posted here:
https://lore.kernel.org/qemu-devel/20260617155857.7451-1-dingtao0430@163.com/

Thanks

Changes in v1->v2:
* Reword the commit message of patch 1/2.
* Add a new qtest patch to cover the SDHCI SDMA case.
  Based on the xilinx-zynq-a9 board, which is more compatible with generic sdhci, 
  rather than the npcm7xx board.

Tao Ding (2):
  fixed sdma boundary bug
  qtest: add xilinx-zynq SDHCI sdma test

 hw/sd/sdhci.c                        |   2 +
 tests/qtest/meson.build              |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c


base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
-- 
2.43.0


