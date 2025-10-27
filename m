Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C285CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 21:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUaV-0002Yu-Qb; Mon, 27 Oct 2025 17:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZs-0002Ud-1d
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:42 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vDUZn-00050X-TP
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 17:16:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CC48F48C43;
 Mon, 27 Oct 2025 21:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F082BC4CEF1;
 Mon, 27 Oct 2025 21:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761599783;
 bh=8wDaX0jKB4u1eOBf4NCKMedHFU8zVDmGIoXbem7rhpE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=trhOsd1iPCMUE0KJPzEX6E/Lb+Ex2euRZ1PdqlpSrVliJD0pzGr/+ivKUTQzMxtg6
 2vJ5hVGA466IwDwh9ZqPAiaQA/hpi6eg3mGyrsucBzVzI8StraQLxca8X0YMrnbVLr
 mfExofkO+NAWgo+e5UsWvH3ncGflSx7GWtEBAhD9f5NTJFykdGXMtyhrZ6vwBC7jFK
 lxYu3+Mcd4PGecdRfGmOgxIOGlc4xny7igi0xKrOUfWGMv+jGtbSywRujMmQWiHZA5
 Tl+WK/yGXfDjkzfR+MvU4i2njwQgMfH4OAGQKS9JNDSOZL6Yn+RXMtVtZdD4MCBNQ3
 zrHW68RChmGXg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de
Subject: [PULL 07/11] hw/hppa: Fix interrupt of LASI parallel port
Date: Mon, 27 Oct 2025 22:15:59 +0100
Message-ID: <20251027211603.7141-8-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027211603.7141-1-deller@kernel.org>
References: <20251027211603.7141-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


