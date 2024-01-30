Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222EBC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUm2T-0006eD-6Q; Tue, 30 Jan 2024 06:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rUm2H-0006YQ-AO; Tue, 30 Jan 2024 06:12:13 -0500
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rUm2E-0001QM-1q; Tue, 30 Jan 2024 06:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1706613123; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=d8+5sNJqYPN7LKv02sla3zRJkCuiKwmFCcy/RgnKEQU=;
 b=Mcq6aVq+fhjpS+wq5MHb24BirnwYgcyxtFuwC63wkX1KzC9yzfwvh4SmgKUm5CTFuR2MmH92F+R6mKQ8/xVSQK7AVLevWyVzalkPiKW69R183DvtrlujJNUdpesHMHsG2lz9Z61TI9sBo2x60v1c1LTJhB+ytPN9BLDnl3BAKrk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W.g.cfL_1706613120; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W.g.cfL_1706613120) by smtp.aliyun-inc.com;
 Tue, 30 Jan 2024 19:12:01 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 christoph.muellner@vrull.eu, bjorn@kernel.org,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 0/2] target/riscv: Support mxstatus CSR for thead-c906 
Date: Tue, 30 Jan 2024 19:11:57 +0800
Message-Id: <20240130111159.532-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

We first add a framework for vendor CSRs in patch 1. After that we add
one thead-c906 CSR mxstatus, which is used for mmu extension xtheadmaee.

This patch set fix the regression on kernel pointed by Björn Töpel in
https://www.mail-archive.com/qemu-devel@nongnu.org/msg1018232.html.

LIU Zhiwei (2):
  target/riscv: Register vendors CSR
  target/riscv: Support xtheadmaee for thead-c906

 target/riscv/cpu.c         |  9 ++++++
 target/riscv/cpu.h         |  9 ++++++
 target/riscv/cpu_bits.h    |  6 ++++
 target/riscv/cpu_cfg.h     |  4 ++-
 target/riscv/cpu_helper.c  | 25 ++++++++-------
 target/riscv/meson.build   |  1 +
 target/riscv/tcg/tcg-cpu.c | 25 ++++++++++++++-
 target/riscv/tcg/tcg-cpu.h |  1 +
 target/riscv/xthead_csr.c  | 63 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 130 insertions(+), 13 deletions(-)
 create mode 100644 target/riscv/xthead_csr.c

-- 
2.25.1


