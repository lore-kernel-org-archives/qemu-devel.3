Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8698CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGe-000373-6f; Thu, 19 Dec 2024 11:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tOG2y-0005ed-FG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:54:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tOG2v-0007za-WD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:54:32 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxeeCAF2RnDI9YAA--.42321S3;
 Thu, 19 Dec 2024 20:54:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXceAF2Rn72gCAA--.14917S2;
 Thu, 19 Dec 2024 20:54:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target/loongarch: Use auto method for LSX/LASX feature
Date: Thu, 19 Dec 2024 20:54:22 +0800
Message-Id: <20241219125424.3220321-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXceAF2Rn72gCAA--.14917S2
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Like LBT feature, add type OnOffAuto for LSX and LASX feature setting.
Also add feature detection with new VM ioctl command, fallback to old
method if it is not supported.

It is tested on the following conditions:
  lsx=on/off
  lasx=on/off
  lsx=on,lasx=on/off
  lsx=off,lasx=off
  lsx=off,lasx=on  (illegal combination)

---
  v1 ... v2:
  1. Fix option lsx=off in TCG mode, add all possible combination test.

---
Bibo Mao (2):
  target/loongarch: Use auto method with LSX feature
  target/loongarch: Use auto method with LASX feature

 target/loongarch/cpu.c     |  86 ++++++++++++++++++-----------
 target/loongarch/cpu.h     |   4 ++
 target/loongarch/kvm/kvm.c | 107 +++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 32 deletions(-)


base-commit: 8032c78e556cd0baec111740a6c636863f9bd7c8
-- 
2.39.3


