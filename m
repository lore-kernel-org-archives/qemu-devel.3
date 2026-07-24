Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C7C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCVu-0003IS-89; Fri, 24 Jul 2026 05:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVs-0003GY-0N; Fri, 24 Jul 2026 05:48:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVq-00059Q-98; Fri, 24 Jul 2026 05:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784886463; bh=cPvw3ePXs8shmBDqHUndvFZx2VzYLNP0c8YSpdRzICk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HZA6ViqaROs/CSX77FMG5vPDZOTrpZmq9bn08U6rTl3xBLXUHbnrPnOnIptzsWR7r
 INjzEy+i1kUmbO5gkOXbO4UVq1BGezBkrdniTImIOOAO49Rm9O+TA3yczY1d5yd+3p
 KsgvacGMLS1T5MmIRBfZAeKuDQ576zuvPqUlnzFRXcKS+UqnGmr3Sf/bxfY7ooklQl
 xxl041L/E+KQ/2wMT8YFv6Zu2Zmnmlb2pD4mIPDvd0dQMX+7BJK/xdK/WPAKdcVho0
 sUVqZsq8niqNn6+MFNeOcbYHXsgqhBRb4W6XxoKlB+zJlQXL0Q3psStf7/vM7rjl1d
 L/80/MfvxKxlQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E79B1C4575;
 Fri, 24 Jul 2026 12:47:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 59E8A3F46B4;
 Fri, 24 Jul 2026 12:48:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 49B8418548; Fri, 24 Jul 2026 12:47:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 4/7] hw/display/vmware_vga: Don't allow guest to trigger long
 running loop in host
Date: Fri, 24 Jul 2026 12:47:46 +0300
Message-ID: <20260724094754.1053970-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724094754.1053970-1-mjt@tls.msk.ru>
References: <20260724094754.1053970-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The code in the SVGA_CMD_DEFINE_ALPHA_CURSOR handler in vmsvga_fifo_run()
basically does:

            x = vmsvga_fifo_read(s);
            y = vmsvga_fifo_read(s);
            args = x * y;
            goto badcmd;
            ...
badcmd:
            len -= args;
            if (len < 0) {
                goto rewind;
            }
            while (args--) {
                vmsvga_fifo_read(s);
            }

Thus by supplying huge values for x and y that overflow the result of
the multiplication, the guest can trigger a long-running loop here
that burns the host's CPU cycles.

Add some sanity checks so that this cannot happen anymore.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3782
Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4026
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4076
Reported-by: Sunday Jiang
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/vmware_vga.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f6f9edfd1d9..567806f0e47 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -737,6 +737,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             vmsvga_fifo_read(s);
             x = vmsvga_fifo_read(s);
             y = vmsvga_fifo_read(s);
+            if (x < 0 || x >= SVGA_MAX_WIDTH ||
+                y < 0 || y >= SVGA_MAX_HEIGHT) {
+                goto rewind;
+            }
             args = x * y;
             goto badcmd;
         case SVGA_CMD_RECT_ROP_FILL:
@@ -776,7 +780,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             if (len < 0) {
                 goto rewind;
             }
-            while (args--) {
+            while (args-- > 0) {
                 vmsvga_fifo_read(s);
             }
             printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",
-- 
2.47.3


