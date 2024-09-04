Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED86DCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 06:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sljMI-00031j-Qq; Wed, 04 Sep 2024 02:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sljMG-00030H-A0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 02:19:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sljMD-0008ET-9Z
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 02:19:12 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxeZrU+9dmJQEqAA--.44427S3;
 Wed, 04 Sep 2024 14:19:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxndzT+9dmTOgDAA--.19522S2;
 Wed, 04 Sep 2024 14:18:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] target/loongarch: Add loongson binary translation
 feature
Date: Wed,  4 Sep 2024 14:18:57 +0800
Message-Id: <20240904061859.86615-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxndzT+9dmTOgDAA--.19522S2
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

---
v3 ... v4:
  1. Verify and enable LBT feature in function kvm_arch_init_vcpu()
     rather than loongarch_cpu_post_init(), since LBT feature is only
     effective in kvm mode and function kvm_feature_supported() can be
     defined as static.
  2. Define structure elment ftop in structure LoongArchBT as uint32_t
     to keep consist with kernel and real HW.

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

 target/loongarch/cpu.c                |  24 ++++++
 target/loongarch/cpu.h                |  18 ++++
 target/loongarch/kvm/kvm.c            | 117 +++++++++++++++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c |   2 +-
 target/loongarch/machine.c            |  24 ++++++
 5 files changed, 183 insertions(+), 2 deletions(-)


base-commit: e638d685ec2a0700fb9529cbd1b2823ac4120c53
-- 
2.39.3


