Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11DBD3CCB6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 06:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgHAA-00079m-9A; Thu, 15 Jan 2026 01:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vgHA8-00078q-Ta
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:48:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vgHA4-0006G6-Hz
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 01:48:56 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxjsPOjWhp+BMJAA--.30143S3;
 Thu, 15 Jan 2026 14:48:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxHMLJjWhpReoeAA--.61288S7;
 Thu, 15 Jan 2026 14:48:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 5/6] target/loongarch: Fix exception ADEF/ADEM missing to
 update CSR_BADV
Date: Thu, 15 Jan 2026 14:48:39 +0800
Message-Id: <20260115064840.219920-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260115064840.219920-1-maobibo@loongson.cn>
References: <20260115064840.219920-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxHMLJjWhpReoeAA--.61288S7
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

From: Song Gao <gaosong@loongson.cn>

Exception ADEM/ADEF need update CSR_BADV, the value from the virtual
address.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tcg_cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b4bf39d09..af92277669 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -227,6 +227,7 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 {
     CPULoongArchState *env = cpu_env(cs);
 
+    env->CSR_BADV = addr;
     if (access_type == MMU_INST_FETCH) {
         do_raise_exception(env, EXCCODE_ADEF, retaddr);
     } else {
-- 
2.52.0


