Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8223EC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO5a-0007fa-6Y; Thu, 16 Jan 2025 06:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYO5D-0007d4-Ny
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:30:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYO59-0005MD-Qk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:30:42 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxPOLZ7Yhny2BkAA--.4515S3;
 Thu, 16 Jan 2025 19:30:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxfcXZ7YhneOQkAA--.11212S2;
 Thu, 16 Jan 2025 19:30:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Dump all generic CSR registers
Date: Thu, 16 Jan 2025 19:30:26 +0800
Message-Id: <20250116113032.599899-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxfcXZ7YhneOQkAA--.11212S2
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
  v1 .. v2:
    1. Fix compiling issue on user mode only emulation
    2. Add flag to present unused CSR register for LA464 CPU
    3. Add human friendly output format, CSR register output is aligned.
---
Bibo Mao (6):
  target/loongarch: Add dynamic function access with CSR register
  target/loongarch: Remove static CSR function setting
  target/loongarch: Add common header file for CSR register
  target/loongarch: Add common source file for CSR register
  target/loongarch: Set unused flag with CSR registers
  target/loongarch: Dump all generic CSR registers

 target/loongarch/cpu.c                        |  92 ++++++++--
 target/loongarch/csr.c                        | 129 ++++++++++++++
 target/loongarch/csr.h                        |  29 ++++
 target/loongarch/meson.build                  |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 161 +++++-------------
 target/loongarch/tcg/tcg_loongarch.h          |  12 ++
 target/loongarch/tcg/translate.c              |   5 +
 7 files changed, 290 insertions(+), 139 deletions(-)
 create mode 100644 target/loongarch/csr.c
 create mode 100644 target/loongarch/csr.h
 create mode 100644 target/loongarch/tcg/tcg_loongarch.h


base-commit: 3214bec13d8d4c40f707d21d8350d04e4123ae97
-- 
2.39.3


