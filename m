Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0FBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Em-0008CH-Kj; Tue, 07 Jul 2026 13:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh9Ec-0008A2-Ld; Tue, 07 Jul 2026 13:05:27 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh9EW-0000N0-Ru; Tue, 07 Jul 2026 13:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c4
 mqx0QhATtM5N08wsRqibxinXO8WJSabOiqcni0jaw=; b=qAJpsyLTounfQ9YP5K
 l17dnJBqKIb2f/NRjRjsRxf84gIk0zJO3nARgUSGYzkt4D/ymjDQ/ObA2ptMETlT
 SceeYw1+IV7f8BnPMk9OvTZSOKu5+SW3AGUIdFXQy3WGIETdR6A2dTWSjB0KLZt+
 2jQ8dhWgmw/uHVzubVq8Yv5z0=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wCHJnO9MU1qKkBHHw--.27147S2; 
 Wed, 08 Jul 2026 01:05:02 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Subject: [PATCH v5 0/2] sdhci: fix SDMA boundary bug
Date: Wed,  8 Jul 2026 01:04:55 +0800
Message-ID: <20260707170457.11659-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHJnO9MU1qKkBHHw--.27147S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF47ZF4DXrWkWF43AFWfAFb_yoW3AFg_Cw
 17K3s5Xr4UXF4DAa4IkF1jyrWFkayYqw1UWF98tr47ua45uFnxtFn2yrZ5X3WrXF4rKrZa
 yr1qyryfJry7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRijg45UUUUU==
X-Originating-IP: [175.152.42.218]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4R9pp2pNMb9+uQAA3e
Received-SPF: pass client-ip=220.197.31.4; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

old series was posted here:
https://lore.kernel.org/qemu-devel/20260701155759.43328-1-dingtao0430@163.com

Thanks

Changes in v4->v5:
* increase sdhci version_id for migration.
* patch 2/2 is unchanged. keep Reviewed-by Bin Meng.

Tao Ding (2):
  hw/sd: sdhci: Fix SDMA boundary bug
  qtest: add xilinx-zynq SDHCI sdma test

 hw/sd/sdhci.c                        |  14 ++-
 include/hw/sd/sdhci.h                |   2 +
 tests/qtest/meson.build              |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c


base-commit: 608ad9307d5b4797d2254ee3a4bad2bc8c8bcbae
-- 
2.43.0


