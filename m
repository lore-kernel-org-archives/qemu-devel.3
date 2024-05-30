Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3A4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZbo-0007RC-6b; Thu, 30 May 2024 02:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sCZbk-0007QI-Ry
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:49:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sCZbh-0000i7-GT
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:49:52 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxe+qHIVhmd4gBAA--.6473S3;
 Thu, 30 May 2024 14:49:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx28aFIVhm5+8NAA--.36650S2; 
 Thu, 30 May 2024 14:49:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [RFC v3 0/2] target/loongarch: Add loongson binary translation feature
Date: Thu, 30 May 2024 14:49:39 +0800
Message-Id: <20240530064941.1289573-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx28aFIVhm5+8NAA--.36650S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Loongson Binary Translation (LBT) is used to accelerate binary
translation. LBT feature is added in kvm mode, not supported in TCG
mode since it is not emulated.

Here lbt=on/off property is added to parse command line to
enable/disable lbt feature. Also fix registers relative lbt are saved
and restored during migration.

It depends LBT support on kvm side, and it is listed at
https://lore.kernel.org/kvm/20240527074644.836699-1-maobibo@loongson.cn/

---
v2 ... v3:
  1. Property lbt is added only if kvm is enabled
  2. Use feature variable lbt with OnOffAuto type, rather than feature
bitmap flags default_features and forced_features

v1 ... v2:
  1. Add LBT register saving and restoring in vmstate
  2. Add two pseudo feature flags: default_features and forced_features
---
Bibo Mao (2):
  target/loongarch: Add loongson binary translation feature
  target/loongarch: Implement lbt registers save/restore function

 target/loongarch/cpu.c                | 53 ++++++++++++++++++
 target/loongarch/cpu.h                | 18 +++++++
 target/loongarch/kvm/kvm.c            | 78 +++++++++++++++++++++++++++
 target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 target/loongarch/machine.c            | 24 +++++++++
 6 files changed, 190 insertions(+), 1 deletion(-)


base-commit: 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80
-- 
2.39.3


