Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B63606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RlbyEcwG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLp5f-0002wQ-N0; Tue, 27 Oct 2026 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5e-0002vl-2H
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:18 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5c-000072-GX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0CD560136;
 Tue, 27 Oct 2026 21:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CF71F01828;
 Tue, 27 Oct 2026 21:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137935;
 bh=nifQMAWhUHxIgumuVEN0zZOLJDIsThVO7vDNUEJNWF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RlbyEcwG8w7YHMFFUrzOB3QF0z0/lBt1kl6360j01gk/7itPa/ndLvh0VHQgXwEnV
 KfefFtl7+RZd2mWQ4DYX8T07kyTvzUHzyrmikCghLnXdFnhs5y/GnJuznMbYdaWa4/
 7Dgq52pE53xtE6pungGglyl1eH6m7T2Div7aB47Oz+3ZW2GyNOVwghSGypLmcaiZEj
 y8Gh++KjeOJdIhFBWzwxqN2qtk0c0Lj9htcg/4EBejl2ql4N29c6Fh9emXUVCAmwWO
 TFJbHMMWjgMyKVcDRoCFHqIyGR37+PyVLdaCnLHtf8EYgNTs/yYH0hOLVoGqKVHShn
 pxKSnJUsrGVbg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 "Kirill A . Korinsky" <kirill@korins.ky>, Helge Deller <deller@gmx.de>
Subject: [PATCH 2/8] target/hppa: Use 15 bit protection IDs on PA1.1 CPUs
Date: Tue, 27 Oct 2026 22:52:03 +0100
Message-ID: <20261027215209.21150-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027215209.21150-1-deller@kernel.org>
References: <20261027215209.21150-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

HP-UX 9.05 only supports 15-bit protection IDs and gets a protection
fault on its own interrupt stack when allowing 18-bits.

Since the architecture manual states that if smaller than 18-bit access IDs
are physically implemented in the CPU, only the appropriate number of
rightmost bits of GR[r]{13..30} are stored in the TLB.
PA7100 and PA7100LC only support 15 bit protection IDs, so use this
amount of bits here.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/mem_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a5da0bc851..7a316f59ea 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -538,7 +538,15 @@ void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
 static void set_access_bits_pa11(CPUHPPAState *env, HPPATLBEntry *ent,
                                  target_ulong reg)
 {
-    ent->access_id = extract32(reg, 1, 18);
+    /*
+     * The architecture manual states that if smaller than 18-bit access IDs
+     * are physically implemented in the CPU, only the appropriate number of
+     * rightmost bits of GR[r]{13..30} are stored in the TLB.  Older parisc
+     * chips (PCXS, PCXT, PCXL, PCXL2) only support 15 bit protection IDs.
+     * PCXT' (pa7200) has 18 bit protection IDs, but only 16 bit spaceids.
+     * We currently emulate PA7100 and PA7100LC CPUs, so use 15 bits here.
+     */
+    ent->access_id = extract32(reg, 1, 15);     /* 15-bit PA1.1 PIDs */
     ent->u = extract32(reg, 19, 1);
     ent->ar_pl2 = extract32(reg, 20, 2);
     ent->ar_pl1 = extract32(reg, 22, 2);
-- 
2.54.0


