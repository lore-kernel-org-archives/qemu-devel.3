Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01748C3ABDA
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 12:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGGEW-0000ej-2x; Sat, 17 May 2025 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uGGE4-000057-Ac
 for qemu-devel@nongnu.org; Sat, 17 May 2025 08:01:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uGGDz-0002iA-31
 for qemu-devel@nongnu.org; Sat, 17 May 2025 08:01:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C2F6B6116F;
 Sat, 17 May 2025 12:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF25C4CEE9;
 Sat, 17 May 2025 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747483257;
 bh=3xq4wlfIvy9OM7kxdwoakK4Cms1/XS4ZMH0xxD790tQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pp1/+rB+7vHYVClSufoSG5C8YJVJZBiWkaQYFOzAh8tciR+vYewYjsJOVA32dwjQj
 sGD6/cCMD6osUCfYJ5PHjKgIBiCsqf9l+O46ihclS3WhJXGZPrzI0G8H2jrLG/NokL
 A0ikJW6nlrUkGKFrBCZfo9slo0K36eZkXrskay6a+k4omFJJ84mQpmhjxH7okrk747
 qMh6pI0LtmvvNqaJ+VKED7OcjFQ9O+00GofFDId8wbFKk1KrDRuyFTZCqeA62a3zrv
 wSXEvMibbJtrBhl1DWPiw41GqMKHZBsiPjsmyZJw0CKWRouD+CvCDFUwXYnogZbR87
 fGe70CckcjNTw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 1/3] target/hppa: Copy instruction code into fr1 on FPU assist
 fault
Date: Sat, 17 May 2025 14:00:51 +0200
Message-ID: <20250517120053.18231-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250517120053.18231-1-deller@kernel.org>
References: <20250517120053.18231-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The hardware stores the instruction code in the lower bits of the FP
exception register #1 on FP assist traps.
This fixes the FP exception handler on Linux, as the Linux kernel uses
the value to decide on the correct signal which should be pushed into
userspace (see decode_fpu() in Linux kernel).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/int_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 7d48643bb6..191ae19404 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -177,6 +177,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                     }
                 }
                 env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
+                if (i == EXCP_ASSIST) {
+                    /* stuff insn code into bits of FP exception register #1 */
+                    env->fr[0] |= (env->cr[CR_IIR] & 0x03ffffff);
+                }
             }
             break;
 
-- 
2.47.0


