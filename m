Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C164BCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjK-00061J-En; Fri, 17 Oct 2025 16:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjH-0005zq-Ij
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:11 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjE-0005OA-St
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 77C9B6485A;
 Fri, 17 Oct 2025 20:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD33C4CEFB;
 Fri, 17 Oct 2025 20:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731627;
 bh=Hp/0HTI5oxrXmMDMo/nJimqv818j/piwR0Qr3qUdLoQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oz2DrSgM5JXcAxpmg74XytAFJ6lmekztcqIJI3F2Gzk5ZFlPvbOcBrYlPbyftfNl6
 3wJf5IPE8zKnceuusDUzq2GBzTxIUs2rw/sewkXwBwl3zXDMB4y40heC6ie/f2iS44
 5dHgG/FRX8BUm5GQbU2EiXwobp4IXIzXnUUe9j2cKf+FDjLKcYiQbsW3J9b4w+SkVh
 PK1a36x9vMQnlRMmGEnkfEmOL3r2binDrh+iU5HbsY2afwLLKv7YPao6XPlIumpKwa
 VTodXrVwWVpQI8Vv8xGD6RDBh8mZw5hGEQh3DfjbA0Dv3lzTCB9gUV7D90G07zbXei
 PgufUYVZjRSFg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 06/10] hw/hppa: Fix interrupt of LASI parallel port
Date: Fri, 17 Oct 2025 22:06:49 +0200
Message-ID: <20251017200653.23337-7-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Fix wrong assignment where the LASI parallel port was using the IRQ line of the
LASI LAN card.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cddca69b93..bec5a86f24 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -584,7 +584,7 @@ static void machine_HP_B160L_init(MachineState *machine)
 
     /* Parallel port */
     parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
-                     qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
+                     qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
 
     /* PS/2 Keyboard/Mouse */
-- 
2.51.0


