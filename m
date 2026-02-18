Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922CEE9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnvA-0001gx-0W; Wed, 18 Feb 2026 15:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vsnua-0001e1-Eb
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:12:45 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vsnuX-0002Zw-Bb
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:12:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BC6E61857;
 Wed, 18 Feb 2026 20:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16956C19423;
 Wed, 18 Feb 2026 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771445554;
 bh=fdMSHdHw/VxM+V0zW5wuIrMTv4tUBIJWNrApGmRCuSs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IR4V4K96B+PheIN5wxXa91WOGHOuxwly9lHgJc8Ar2ExWpHchgthK+Dx6wPVOnCq8
 ycQ8+nV62PLhh1pp7c1zmO8mkzcDr4IcGLXONaW7sZ5PoUSzeqUCe4wM6/Txuve3jm
 MlWbzMnYXedG7X2V78pTi8jeT3NbPJmrCZr6v89QkBzUHllX8jhrJpbYq9+m5JBcvI
 35cMVjkh939mlWIcyww1BhJeFlgQ3C2sGTrl7Z2T/Fx2Ibax1fnckSgtkKKLfV7cWV
 yV31IdWqScT3LvxfTrwnr1k4dFD+7XR/7InoTdzZtxG7S1h5a2SYN2KpzZ6H+4HWqe
 J9Qliu+nFYuXg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 3/4] hw/hppa: Require SeaBIOS version 22 for A400 machine
Date: Wed, 18 Feb 2026 21:12:20 +0100
Message-ID: <20260218201221.20958-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218201221.20958-1-deller@kernel.org>
References: <20260218201221.20958-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Require at least SeaBIOS version 22 before adding the A400 machine.
This is required, because version 22 adds the A400 machine definition
and provides the necessary 64-bit PAT firmware. All other machines up to
now used only the 32- or 64-bit PDC firmware without the PAT extensions.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d6aeb793c0..5ce4a17915 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -45,7 +45,7 @@ struct HppaMachineState {
     MachineState parent_obj;
 };
 
-#define MIN_SEABIOS_HPPA_VERSION 19 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 22 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
-- 
2.53.0


