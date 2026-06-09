Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25CDCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzTO-0002k6-Do; Tue, 09 Jun 2026 12:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWzTE-0002gX-Sm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:38:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWzTB-0005Gb-Vy
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:38:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D9026020B;
 Tue,  9 Jun 2026 16:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D0B1F00893;
 Tue,  9 Jun 2026 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781023109;
 bh=jX18zqXFA+LNSDjlxcNAVPph0zpvwfV3CNTKM9znobo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UBM0fauHCI0JkuyUe3dq2lQXhX32RZgydFVRq2c7EDn0pVPZcOau46M7JFPLQi8DM
 C0BUk8Emh0s0e0q6pQo0GXcPzsouQI4jfXJ4thiZNCPbwcYVgQyIx0ZTJZqNMuRK5x
 vV1qQCzsD/S7YfJ/AobKwwl7ZlZqV+hXmHxhSI+pVYOR1FN0hI7Odbkt6McbkMlIDk
 7kkCTwhRXFrhQ+wy0ZVjHuM0M92ULvJJCDnm0LMM4r1S3c5fXZ1bXR5x2H+JNnYSbc
 yOmWRYZU0wr46fpufvmKm8Y4lKSMfxU5ORtsg7Yi7Vzhxl7m8MzNTDoFCdV0c4130L
 /F/0uXdXgFP0A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Matt Turner <mattst88@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 8/8] target/sh4: decode_gusa: recognize add#imm with prior
 mov Rm, Rn
Date: Tue,  9 Jun 2026 18:38:07 +0200
Message-ID: <20260609163807.6083-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609163807.6083-1-deller@kernel.org>
References: <20260609163807.6083-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Matt Turner <mattst88@gmail.com>

The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
`mov Rm, Rn` appeared (mv_src >= 0), forcing a fallback to
cpu_exec_step_atomic for sequences like:

  mov.l  @r2, r3      ; load
  mov    r3, r7       ; save old value (mv_src == ld_dst)
  add    #1, r7       ; increment copy
  mov.l  r7, @r2      ; store

When mv_src == ld_dst the move merely copies the loaded value to
preserve it -- exactly the situation already accepted for the
`add Rm, Rn` form. The immediate form can be handled identically with
tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
instead of taking the slower single-step atomic fallback.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5adf650744..d38a6bd352 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         break;
 
     case 0x7000 ... 0x700f: /* add #imm,Rn */
-        if (op_dst != B11_8 || mv_src >= 0) {
+        if (op_dst != B11_8 || (mv_src >= 0 && mv_src != ld_dst)) {
             goto fail;
         }
         op_opc = INDEX_op_add;
-- 
2.54.0


