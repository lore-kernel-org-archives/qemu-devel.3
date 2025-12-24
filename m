Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AA8E74908
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 03:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYFnM-00068y-Oz; Tue, 23 Dec 2025 22:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vYFnL-00068L-0o
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 22:44:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vYFnH-0006gW-CF
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 22:44:14 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx+8KCYUtpRaYCAA--.8027S3;
 Wed, 24 Dec 2025 11:44:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxquCBYUtpgR4EAA--.12420S3;
 Wed, 24 Dec 2025 11:44:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 1/3] target/loongach: Fix some exception need't upadate
 CSR_BADV
Date: Wed, 24 Dec 2025 11:19:27 +0800
Message-Id: <20251224031929.2371837-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251224031929.2371837-1-gaosong@loongson.cn>
References: <20251224031929.2371837-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxquCBYUtpgR4EAA--.12420S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

According to Volume 1 Manual 7.4.8 ,exception,SYS,BRK,INE,IPE,PPD
FPE,SXD,ASXD are need't update CSR_BADV, this patch correct it.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tcg_cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9..ab247e82ec 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -121,8 +121,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_FPE:
     case EXCCODE_SXD:
     case EXCCODE_ASXD:
-        env->CSR_BADV = env->pc;
-        QEMU_FALLTHROUGH;
     case EXCCODE_BCE:
     case EXCCODE_ADEM:
     case EXCCODE_PIL:
-- 
2.41.0


