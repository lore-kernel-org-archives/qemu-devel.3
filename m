Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73657C02193
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdnEe-0008IJ-4x; Fri, 31 Jan 2025 04:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnEc-0008Ht-AE
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tdnEb-0004ET-0m
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:22:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 347AB5C5D60;
 Fri, 31 Jan 2025 09:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B588CC4CED1;
 Fri, 31 Jan 2025 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738315363;
 bh=UThlWjqG888IPofGfuoGum5DaEYXPS/+ciipEBddP2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eQl+7EZC60mCeqYPKIiDY3KrP2yt4h9cyeDdoNLlumepRL8ogx2PQOFxDWWDWL47W
 qM0utC5D8t+uPq1SX2CCQHR3nFzcYM5yW5Sqv1QNuC0VOuk9GizRBd+wP2gQM1G9FE
 RCe6+WjDnLv0F1JWqCpfGBiysssaq8KQFTZuXyJxUSnoEw9qpT4R06JUrFAb2xYd3G
 Wo404HlsmGNvjce7QLHUMHBYUh4sSHLQC7gZ0ef3X1LmknhnCwglY3AgF5wll00tI8
 ZlWy1y/vWNTUvWA8z7uBubnMWntx+a1RGnpHc71pMDihZfLWGDuw9QgPRnxhJkaD0x
 QsNzjxaLWzugg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL v2 7/9] target/hppa: 64-bit CPUs start with space register
 hashing enabled
Date: Fri, 31 Jan 2025 10:22:27 +0100
Message-ID: <20250131092229.38232-8-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250131092229.38232-1-deller@kernel.org>
References: <20250131092229.38232-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Turn on space register hashing for 64-bit CPUs when reset.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b0bc9d35e4..c86f9190d2 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -28,6 +28,7 @@
 #include "exec/translation-block.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
+#include "hw/hppa/hppa_hardware.h"
 
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -217,6 +218,10 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
     cpu_hppa_loaded_fr0(env);
+
+    /* 64-bit machines start with space-register hashing enabled in %dr2 */
+    env->dr[2] = hppa_is_pa20(env) ? HPPA64_DIAG_SPHASH_ENABLE : 0;
+
     cpu_hppa_put_psw(env, PSW_M);
 }
 
-- 
2.47.0


