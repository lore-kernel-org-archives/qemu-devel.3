Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44663CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXlV-0008S6-Do; Fri, 22 May 2026 17:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkt-0007ZK-Ji; Fri, 22 May 2026 17:50:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkr-0002eE-N8; Fri, 22 May 2026 17:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486559; bh=Q9IaUrQ8GBoIzQb0JDHPhBgvBuj9NSR3QyVLqxaJLok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Cw/7CGKDJNh8ayFUUIeUZWicazq+jIAFZVswHAMVujgA1XQJFyCuHRpfqnXZFXaZa
 tAmrnvDfTxKKuQVOYv9RlXM2vUxdgKeJbZDB0lTjWIOTiII2HXIunPq1M/6ZY/iBf3
 MOu2hIH33BMFROmUYUx3ZR4z5W1JQyP4vo5T/nKLRrmn5Oiuau7rXNE3n1Wq/7dryu
 oZoOpfdg2hCT3+dNBm1xBCE1nMgydEWqEgJt7q3ytgkbytGoiIQ9VH1PMeyay/6/aN
 jyr7PgMpymSK2mxJ8HK1h/oekHlG7spwpFFDbwBpvyVhr9iR3syM+vezkah3cVGUn6
 a86pOSPMCecBw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2D761AFB64;
 Sat, 23 May 2026 00:49:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8ED63B71B3;
 Sat, 23 May 2026 00:49:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 110/149] target/arm: Report IL=0 for Thumb 16-bit BKPT
 insn
Date: Sat, 23 May 2026 00:48:42 +0300
Message-ID: <20260522214923.807017-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The Thumb BKPT insn is 16-bit, and the ESR_ELx syndrome register
definition requires that we set the IL bit to 0 for this, and 1 for
the 32-bit A32 and A64 BKPT/BRK.

We used to do this correctly, but accidentally lost it in the
conversion to decodetree, because we converted the A32 BKPT first,
and then when we converted the T16 BKPT we forgot that trans_BKPT()
was unconditionally setting IL=1.

Pass the right value for syn_aa32_bkpt()'s is_16bit argument.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3474
Fixes: 43f7e42c7d515f ("target/arm: Convert T16, Miscellaneous 16-bit instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260505103726.419195-1-peter.maydell@linaro.org
(cherry picked from commit f443b687636205b7f70029692b244f1f90532cf2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 0a92300f9b..bca278daf0 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3562,7 +3562,7 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
         (a->imm == 0xab)) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
     } else {
-        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, curr_insn_len(s) == 2));
     }
     return true;
 }
-- 
2.47.3


