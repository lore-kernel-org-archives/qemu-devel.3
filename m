Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA767C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5IE-0005gy-7h; Tue, 07 Jul 2026 08:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wh5Hx-0005WW-34
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wh5Ht-0002O8-81
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxiuuL9kxqDu4AAA--.4103S3;
 Tue, 07 Jul 2026 20:52:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxX8eF9kxqpekDAA--.23644S7;
 Tue, 07 Jul 2026 20:52:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn,
 Miao Wang <shankerwangmiao@gmail.com>
Subject: [PULL 5/8] target/loongarch: Enable TARGET_PAGE_BITS_VARY for
 loongarch64 user-only
Date: Tue,  7 Jul 2026 20:32:23 +0800
Message-Id: <20260707123226.25918-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260707123226.25918-1-gaosong@loongson.cn>
References: <20260707123226.25918-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX8eF9kxqpekDAA--.23644S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Miao Wang <shankerwangmiao@gmail.com>

Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
working on hosts with 16K page size.

Fixes: 1d832c19db1e ("target/loongarch: Support 4K page size")
Fixes: qemu-project/qemu#3651

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-param.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 3bcf77b375..6abe72ff5c 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -10,6 +10,11 @@
 
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
-#define TARGET_PAGE_BITS 12
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.55.0


