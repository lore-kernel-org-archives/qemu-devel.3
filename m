Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF0DC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fUT-0002Eb-Sm; Wed, 22 May 2024 02:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s9fUO-0002B8-BL; Wed, 22 May 2024 02:30:16 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s9fUJ-0006uD-U3; Wed, 22 May 2024 02:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716359404; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=Grw3syHdHwI6aiEkZHx+zTjb9YtWEVK1Xq5i+3pa9ec=;
 b=VqWcgh91CvpgxbP5M8xSGLrZRx/eBqZnRdg3trsNyOrec1vP04lEd7Dmw/b/2WM7tQqYaHKE3BwqQX+BxUD08UnWzhv+A8/UHOA2/MK6IK93Iofdi364Dd/KsJVHS7MDWyKu0FGNmedpNy2X4ylzViwOnpSqFqQoSKLtJuqYOYY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067113;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W7-6sHZ_1716359401; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W7-6sHZ_1716359401) by smtp.aliyun-inc.com;
 Wed, 22 May 2024 14:30:03 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, iwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH 0/4] target/riscv: Implement May-Be-Operations(zimop)
 extension 
Date: Wed, 22 May 2024 14:29:01 +0800
Message-Id: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

The may be operation means that it has an initial behavior which can be redefined
by later extensions to perform some other action.

The May-Be-Operations includes two extension: zimop and zcmop. Zimop has 40
instructions, whose initial behavior is writing zero to the destination register.
Zcmop, which requires the Zca extension, has 8 instructions whose initial
behavior is reading the source register.

The more details on this specifcation is here:
https://github.com/riscv/riscv-isa-manual/blob/main/src/zimop.adoc

LIU Zhiwei (4):
  target/riscv: Add zimop extension
  disas/riscv: Support zimop disassemble
  target/riscv: Add zcmop extension
  disas/riscv: Support zcmop disassemble

 disas/riscv.c                               | 123 ++++++++++++++++++++
 target/riscv/cpu.c                          |   4 +
 target/riscv/cpu_cfg.h                      |   2 +
 target/riscv/insn16.decode                  |   1 +
 target/riscv/insn32.decode                  |  11 ++
 target/riscv/insn_trans/trans_rvzcmop.c.inc |  29 +++++
 target/riscv/insn_trans/trans_rvzimop.c.inc |  37 ++++++
 target/riscv/tcg/tcg-cpu.c                  |   5 +
 target/riscv/translate.c                    |   2 +
 9 files changed, 214 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc

-- 
2.25.1


