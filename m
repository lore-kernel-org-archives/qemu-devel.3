Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF553C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVUd-000817-81; Wed, 22 Jan 2025 02:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1taVUJ-0007u8-DI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1taVUF-0002ba-W1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:23 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxieD6opBnKRxnAA--.4496S3;
 Wed, 22 Jan 2025 15:49:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxYMb5opBneEIqAA--.26608S2;
 Wed, 22 Jan 2025 15:49:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] Dump all generic CSR registers
Date: Wed, 22 Jan 2025 15:49:06 +0800
Message-Id: <20250122074913.534050-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMb5opBneEIqAA--.26608S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CSR registers is import system control registers, it had better to dump
all CSR registers when VM is running in system mode, rather than dump
part of those, since guest OS uses these CSR registers. And it is very
useful to debug guest OS.

---
  v2 .. v3:
    1. Split patch into smaller in order to review.
    2. Adjust CSR register output format, align CSR register name with
       six bytes at most.

  v1 .. v2:
    1. Fix compiling issue on user mode only emulation
    2. Add flag to present unused CSR register for LA464 CPU
    3. Add human friendly output format, CSR register output is aligned.
---

Bibo Mao (7):
  target/loongarch: Add dynamic function access with CSR register
  target/loongarch: Remove static CSR function setting
  target/loongarch: Add generic csr function type
  target/loongarch: Add common header file for CSR registers
  target/loongarch: Add common source file for CSR register
  target/loongarch: Set unused flag with CSR registers
  target/loongarch: Dump all generic CSR registers

 target/loongarch/cpu.c                        |  95 +++++++++--
 target/loongarch/csr.c                        | 129 ++++++++++++++
 target/loongarch/csr.h                        |  29 ++++
 target/loongarch/meson.build                  |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 161 +++++-------------
 target/loongarch/tcg/tcg_loongarch.h          |  12 ++
 target/loongarch/tcg/translate.c              |   5 +
 7 files changed, 293 insertions(+), 139 deletions(-)
 create mode 100644 target/loongarch/csr.c
 create mode 100644 target/loongarch/csr.h
 create mode 100644 target/loongarch/tcg/tcg_loongarch.h


base-commit: d6430c17d7113d3c38480dc34e59d00b0504e2f7
-- 
2.39.3


