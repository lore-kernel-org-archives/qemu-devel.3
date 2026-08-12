Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABE9C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8d5-00059S-2N; Wed, 12 Aug 2026 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8co-000469-Fb; Wed, 12 Aug 2026 09:04:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cm-0004Q5-PW; Wed, 12 Aug 2026 09:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=rAMeN9DidrHrnYAjK/RGpE/Y0dVSiuhrBSh4MT0hBDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FxqXCYTHleT4BmJulUICDbPUlWw4ZPFdBUJTHzYC3orT3ryZ6WF1bauHxCbEo6Blw
 dm5dxipoNT5kFR9CkfsGp01y9Z+fdApH5LDCzJP94T4+yNpbE+RnkZk37XOFh1U9EC
 ZOtqrdOWxffvXMxZ0zufwi4F0/mo29aJwYAly+5hRJvuuW8z308g25+dvjsVi2AmTF
 ZmNj68UPb8/ZdbJGAL1/jh3RFJp9ukNPMNeSKlNfNmLqalgkmFjoJ8OqqPQM4tUEgV
 pVyJ2TZOgB2vFsJ+rXmKzIgPQIUjgIGcRTb8xNZTUemBqyV9p+Ul3QazEQi87S5XMn
 GNNVD5zA0BfdA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C56F1CA48E;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F41E409B71;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E7A362F8B2; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 Tristan Madani <tristan@talencesecurity.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 015/102] hw/display/vmware_vga: Don't allow guest to
 trigger long running loop in host
Date: Wed, 12 Aug 2026 16:00:50 +0300
Message-ID: <20260812130233.621965-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
(cherry picked from commit f604b807a55acd3f81725bb7dbd98450c96adf00)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 2dd661e3c13..fda3965ca3c 100644
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


