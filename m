Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7135CCF9E9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCgzF-0004pB-Pb; Sat, 25 Oct 2025 12:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzE-0004oL-4J
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:24 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vCgzC-0004CM-Ce
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:19:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 239B0450CA;
 Sat, 25 Oct 2025 16:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D927C113D0;
 Sat, 25 Oct 2025 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761409161;
 bh=jkmnz3uQaQ6em89bXFw7yR/sSWAY4uYg2Y0sresNpgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GO3tFqvs0U8z+IkrkIKghFLVwDpO1fbjxXnIi5yEa5nzl8q+Z0QDJUKnEKW0O4zxZ
 Or3d8cuGe4NW9TldoFwdkLoXuFrzt4WXoOX0hwylDEmQtQh1ONELmMlbdp/be6lU2G
 cQorRhESQDcZtgdEmEBd8qi6JhMbfJJ6gXapQUdlWjeFfyu4dUffApWg33OV0evmoM
 cnLFSQ2hMHoezrmemjW1Hp3uG1l+7ZF9R0SRcUk8oefQiED0DNfjuxBC34bLwf2D3c
 XC+Dwryabu4JhXdN6ceE5NTWVfZdNrxYNvFfzbm1Ntnc9AertwYyp33Ilxe+k1cVD0
 YNd70UUoJiX9w==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/11] hw/hppa: Fix interrupt of LASI parallel port
Date: Sat, 25 Oct 2025 18:18:57 +0200
Message-ID: <20251025161901.32710-8-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025161901.32710-1-deller@kernel.org>
References: <20251025161901.32710-1-deller@kernel.org>
MIME-Version: 1.0
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


