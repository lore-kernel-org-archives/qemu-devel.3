Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7928DE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 23:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnJS-00073s-0Z; Mon, 09 Dec 2024 18:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnJO-00073Z-7A
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:37:10 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnJL-0007Dp-CD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:37:09 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id E5F2240DB3;
 Tue, 10 Dec 2024 00:37:05 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id P4f4DbR1t9OV; Tue, 10 Dec 2024 00:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1733787201;
 bh=HXmEvPU14pfSGjwyhhCALxMwZ5c9ie08Iy0GxtbH3i8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=llcF8z2684+Kr0IGujBID+OBxLq5JzBKXat41mBFMdIUk7ZvuucJRmv2TUXo56Vgm
 1EVk3uA4pHcFsPrdXneKZK0Uv43xF6jd5sY7hitHilBpfLV9Hi1pXuhClrt1xTdqiQ
 u5LUB0X/ro4LfxUwnfgECiUP04ntsqd8CJICO3W/G9eFasgVnnrqsxQ39cFoSuQa3Y
 Ooi87Yp3OagKFix8QN+USvfhqCb1cXHHEIDr1qDbcqlnDd+zAGH98XOeUxis121aMc
 vQN4u8BBCKnyzUj2nCPannsPQxapRYZos/GRxH1jvXClS8KZuoNj3s9LZEfnXicDvg
 5lpIXLmxZZdyw==
Received: from fel.cvut.cz (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 1352340D1E;
 Tue, 10 Dec 2024 00:33:21 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [RFC 2/3] hw/net/can: WIP CTU CAN FD mapping of IRQ for platform
 device solved.
Date: Tue, 10 Dec 2024 00:32:52 +0100
Message-Id: <9911c9d3b8fbb1e947262b6ecf05c9f3cd0ad620.1733783500.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
References: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/net/can/ctucan_mm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/can/ctucan_mm.c b/hw/net/can/ctucan_mm.c
index 43e6823b73..6d6b8aecb8 100644
--- a/hw/net/can/ctucan_mm.c
+++ b/hw/net/can/ctucan_mm.c
@@ -160,6 +160,9 @@ static void ctucan_mm_realize(DeviceState *dev, Error **errp)
         }
         sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(gicdev, d->cfg.irq));
     }
+    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
+        ctucan_init(&d->ctucan_state[i], d->irq);
+    }
 }
 
 /*
-- 
2.39.5


