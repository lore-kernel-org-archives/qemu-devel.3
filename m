Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651A6C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAtg-0003xX-Mh; Fri, 28 Jun 2024 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sNAtf-0003x5-AY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:40:11 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sNAta-0005Ct-T0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:40:11 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1719578400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RBKPpqL4X2xpKp8Vmq6/rIAYUG5RSond9CQ6kAwwBbc=;
 b=LKUzAej1gzY8rcebGIRG2VP8Zx2MDSuJJe0Gpb7j2/GulzNrzFzy7MLOqzLKrRzDwRZiUB
 P/aAT+avD03SJ5dALVx6EOW+3hgvnDlRn5/bzvQVlsTlxDIoysWLALD0XJnDJ5z5s9poar
 X/NbsygahbUVCMcXnPmuCkDC6n4ieWY=
To: gaosong@loongson.cn
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] hw/loongarch/boot.c: fix out-of-bound reading
Date: Fri, 28 Jun 2024 15:39:10 +0300
Message-ID: <20240628123910.577740-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

memcpy() is trying to READ 512 bytes from memory,
pointed by info->kernel_cmdline,
which was (presumable) allocated by g_strdup("");
Found with ASAN, making check with enabled sanitizers.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
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
2.43.0


