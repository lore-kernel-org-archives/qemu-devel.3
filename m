Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7386C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoom-0008Ug-FT; Thu, 11 Jul 2024 04:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRooe-000828-0x
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:06:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRooQ-0001uP-TU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:06:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxPOtiko9muS4DAA--.9368S3;
 Thu, 11 Jul 2024 16:05:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxNMVfko9mXttDAA--.13828S3; 
 Thu, 11 Jul 2024 16:05:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Dmitry Frolov <frolov@swemel.ru>
Subject: [PULL 1/9] hw/loongarch/boot.c: fix out-of-bound reading
Date: Thu, 11 Jul 2024 15:48:21 +0800
Message-Id: <20240711074829.3338879-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240711074829.3338879-1-gaosong@loongson.cn>
References: <20240711074829.3338879-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxNMVfko9mXttDAA--.13828S3
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

From: Dmitry Frolov <frolov@swemel.ru>

memcpy() is trying to READ 512 bytes from memory,
pointed by info->kernel_cmdline,
which was (presumable) allocated by g_strdup("");
Found with ASAN, making check with enabled sanitizers.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240628123910.577740-1-frolov@swemel.ru>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index b8e1aa18d5..cb668703bd 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -163,7 +163,7 @@ static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
     info->a0 = 1;
     info->a1 = cmdline_addr;
 
-    memcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
+    g_strlcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
 }
 
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
-- 
2.34.1


