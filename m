Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD10C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxo-00029l-Iq; Tue, 28 Jan 2025 15:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxn-000290-1H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxl-0001bF-Fk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso69475355e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095211; x=1738700011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ljPR8fewNaDsyHhFFp905Clb4/IhjAXODJJ5AEEdnEo=;
 b=cA1fZmRU1Yt55wpGBowkp61Na8kZWlmLIX3/Qe7eFR7fX3awx3VI4H+QPcKwImTPuf
 ENmXAMOeB9ZJEN0GV2vhg2XAmZymji8rcnYtalhlJSawDpl5qxh1nwtXpFKssEFG1tXZ
 9Pcx+Bh2IaEjkE/y5wsu5KYRZqpO62XPwIJqhSFMXuEqGczUKS5lm3+v92Wx9MhkeAAs
 ZZ0+Y5SoJ89oXds6OtLW+RTSm0Q9G7BAsT5QLFw4w2/DVTqcVFAewfqzTdjtwri9ZxVz
 apfOjAdbqnpY8bvygK3S4HSbZQibsMkCiDM0xnc3vu+ztq0aH6ZESrDKOQMzy3zGjyd4
 7YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095211; x=1738700011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljPR8fewNaDsyHhFFp905Clb4/IhjAXODJJ5AEEdnEo=;
 b=S9vFzjzxGX+1W7dbbp7n9rf6aTnJjosSEgpH1gRagvnnhTjFlFYSJxY7I0CxLZQddm
 0cTQqR0ke+dYG8+AHbB9IRjBxmZghaNIb0CuaTFiEGiqeMnTw3j8kotLY6IwI6dXcYVJ
 e6S3/VS2Sgho/hvoVeDd5oyfYpibGOwWD5TI7XNsl/iNFWmb5fJZfk/4QIFLNkYhuYNC
 lyTrVgnV0BgG1Se9QmUeeTPx3oofO4cbY7TECsRwuDxKUvN3ZbNi8Fh6OcpVhIrhLvXx
 J9yseYRPDhG+Z29JQEp3Y4m7FAV3u8meS+uT6OMDIj2cT0kDP/SFUYNNlxHc6nb1byfB
 kSjA==
X-Gm-Message-State: AOJu0YzXoTSPM9j9V+KUZEP7PQiTuTTm2oUAOO52mlKQPAZ9QKyxPBnJ
 sv5KQQ4+2ZU8nLaxPMIq0SRczJDZfbcxVIZiLwe7Y6PGhztHe5u31evoIdIN2fLmkCS3KKOw1Dk
 6
X-Gm-Gg: ASbGncspi0zYD2fGbZ2m/fBS4iXZcxhV/GFKMXHepRejqmPZMw5lhuA86nWa94DehKO
 iKUlX5SV3JrfdkFrMN0DTIZPOEFJCE8gzVWv52geaoIHBTS7vW/7KoncqiJTdKFrXlR6TCEcxml
 mvz6eaf2NKjfYSnEBNgAYR/HAJKXpvexy5W1wcSSy9Cy/9wHeHRKc498lOABIOwjauTDxnUjdAD
 sP6lvrXFlcbcYGprB6+49YzFu4hHkJ6Lvc9Dudw0sX251x0/om0enN7jeXcVhBIyIxK6C9T8+OH
 79jYsMc5RR4F43OoL5au6w==
X-Google-Smtp-Source: AGHT+IHlvfXH3LdETpVGmebPNrkVUltxdm/WDz6DiCW5uzc7U3NPbWUWt4IgstpxWnlE392Vp5/azQ==
X-Received: by 2002:a05:600c:1d83:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-438dc43540bmr2646405e9.30.1738095211487; 
 Tue, 28 Jan 2025 12:13:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] target/arm: arm_reset_sve_state() should set FPSR,
 not FPCR
Date: Tue, 28 Jan 2025 20:12:52 +0000
Message-Id: <20250128201314.44038-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The pseudocode ResetSVEState() does:
    FPSR = ZeroExtend(0x0800009f<31:0>, 64);
but QEMU's arm_reset_sve_state() called vfp_set_fpcr() by accident.

Before the advent of FEAT_AFP, this was only setting a collection of
RES0 bits, which vfp_set_fpsr() would then ignore, so the only effect
was that we didn't actually set the FPSR the way we are supposed to
do.  Once FEAT_AFP is implemented, setting the bottom bits of FPSR
will change the floating point behaviour.

Call vfp_set_fpsr(), as we ought to.

(Note for stable backports: commit 7f2a01e7368f9 moved this function
from sme_helper.c to helper.c, but it had the same bug before the
move too.)

Cc: qemu-stable@nongnu.org
Fixes: f84734b87461 ("target/arm: Implement SMSTART, SMSTOP")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 63997678513..40bdfc851a5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6413,7 +6413,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
-    vfp_set_fpcr(env, 0x0800009f);
+    vfp_set_fpsr(env, 0x0800009f);
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.34.1


