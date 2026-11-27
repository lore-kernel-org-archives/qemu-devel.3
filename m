Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415E606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=IthcEDpC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpCv-0000wW-Qg; Fri, 27 Nov 2026 01:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAZ-0006pp-Vn; Fri, 27 Nov 2026 01:10:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAY-0000LA-7A; Fri, 27 Nov 2026 01:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=sQ1tUrKgUWWb5pxXoTw3HQN10JO6fJYEVkRWixzqThc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IthcEDpCU+7BL0ou3RLoIDh0DwbwG3sdGMPyrEX7Os7HSlWSIhQXJyHwLkXk6I7Hc
 xPAUM0E/DDUhpmCONqqCddXo1fGmapI1oUoML4lOcXAu4OcYwrYLvEse1+Y7HeRal7
 qs3SiOOgsqbeyQXLPsqIuK4W+kZfz9WWNWb32+f7vttMtfjry18wmxk4s6+PAK57mu
 eS/QyY0h14PrjUdD4DwxDute98Hs9Jh5Bxib9Aucp9B006QLKcS28JZ+jEIjmTa4Qi
 8ZxYwG58rslpuyZjhrFk9oNDObraScX8yz5Qch45KcVlqJkRkGDD37r+vilks7dPWe
 FwkPSnovrChAg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B13231EA383;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AEBB84699AE;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 89E83CF354; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 145/152] hw/display/vmware_vga: Check for bogus
 FIFO_STOP and FIFO_NEXT values
Date: Fri, 27 Nov 2026 08:54:43 +0300
Message-ID: <20261127055709.39630-82-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The guest should never program the FIFO head and tail offsets (in the
FIFO_NEXT and FIFO_STOP registers) to something outside the bounds of
the memory area it has defined as for the FIFO via the FIFO_MIN and
FIFO_MAX registers. If it does that, return a zero fifo length as
we do for various other bad values.

Bad values here won't cause any serious problems as we were rejecting
offsets that would cause us to index outside the s->fifo[] array; but
they're better rejected. For safety's sake we add an assertion on
the fifo cursor before we read it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-3-peter.maydell@linaro.org>
[PMD: Cover whole range in assert()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 0b3a66649912c1c8e0394d0ef8778c0ad314820c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f7289687319..353cef408d2 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -581,8 +581,10 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
     }
     if (s->fifo_max > SVGA_FIFO_SIZE ||
         s->fifo_min >= SVGA_FIFO_SIZE ||
-        s->fifo_stop >= SVGA_FIFO_SIZE ||
-        s->fifo_next >= SVGA_FIFO_SIZE) {
+        s->fifo_stop < s->fifo_min ||
+        s->fifo_stop >= s->fifo_max ||
+        s->fifo_next < s->fifo_min ||
+        s->fifo_next >= s->fifo_max) {
         return 0;
     }
     if (s->fifo_max < s->fifo_min + 10 * KiB) {
@@ -598,7 +600,10 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
 
 static inline uint32_t vmsvga_fifo_read_raw(struct vmsvga_state_s *s)
 {
-    uint32_t cmd = s->fifo[s->fifo_stop >> 2];
+    uint32_t cmd;
+
+    assert(s->fifo_stop < SVGA_FIFO_SIZE);
+    cmd = s->fifo[s->fifo_stop >> 2];
 
     s->fifo_stop += 4;
     if (s->fifo_stop >= s->fifo_max) {
-- 
2.47.3


