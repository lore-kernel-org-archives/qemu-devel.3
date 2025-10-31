Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85745CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 03:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEflf-00038v-EH; Thu, 30 Oct 2025 23:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vEflZ-00038f-Gw
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:25:29 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan_salmon@163.com>)
 id 1vEflL-00086x-P2
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ly
 sOIEQi8DpLtkbRp8CT62jEH2FjNnPIyLAkR4Ibkik=; b=bkCziMrsyywnEcOLkx
 pbJ0C/AvTQ4v2EiVWa+Nh/YKEuSp+uZgtwon0WqfMqovBbTipBUrO8yDaG2PmQQp
 u5vk1e9hYm3Dit6CMnS6eLEWhHKEyEkUEX18fpcgtjlB+gXeRyNplJ7M+V0edh2w
 flN/ljXPF+KWF5IxWdMDSMmnE=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wDX__73KwRpGmRnAg--.40636S2; 
 Fri, 31 Oct 2025 11:24:40 +0800 (CST)
From: zhaoguohan_salmon@163.com
To: richard.henderson@linaro.org,
	deller@gmx.de
Cc: pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org (open list:All patches CC here),
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] hw/scsi/ncr710: Fix null pointer dereference in
 `ncr710_transfer_data`
Date: Fri, 31 Oct 2025 11:24:37 +0800
Message-ID: <20251031032437.107674-1-zhaoguohan_salmon@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX__73KwRpGmRnAg--.40636S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtw43AF4xJFy8Cr13Gr17Wrg_yoW8Jry7pF
 ZakFn5Kr13WFn0y39rJFWUWF1Fka98t3yY9a4Fgas3XFZrWF17J3yft3y0vFyUCrZ3Ja47
 Zr1Dta17tF1xX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3ID7UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52kd0wpxrkt0xbvdzzlrq6il2tof0z/xtbBgBj3EGkEI079kAAAsS
Received-SPF: pass client-ip=220.197.31.5;
 envelope-from=zhaoguohan_salmon@163.com; helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Fix a null pointer dereference issue.

The code dereferences s->current before checking if it is NULL. Move the
null check before the dereference to prevent potential crashes.

This issue could occur if s->current is NULL when the function reaches
the "Host adapter (re)connected" path, though this should not normally
happen during correct operation.

Fixes: 9ce93b74cdc0 ("ncr710: Add driver for the NCR 53c710 SCSI chip")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/scsi/ncr53c710.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ade951b1d107..e479a212bc54 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -831,14 +831,14 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
         }
     }
 
-    /* Host adapter (re)connected */
-    s->current->dma_len = len;
-    s->command_complete = NCR710_CMD_DATA_READY;
-
     if (!s->current) {
         return;
     }
 
+    /* Host adapter (re)connected */
+    s->current->dma_len = len;
+    s->command_complete = NCR710_CMD_DATA_READY;
+
     if (s->waiting) {
         s->scntl1 |= NCR710_SCNTL1_CON;
         s->istat |= NCR710_ISTAT_CON;
-- 
2.43.0


