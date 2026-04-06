Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B143F46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oep-0007Ys-K6; Mon, 06 Apr 2026 14:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeo-0007Xq-OX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oek-0002RN-NW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c76c60c7502so1553940a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499997; x=1776104797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvWpC/BP3AzO1KG7rPNsIt99iLJ3ccph4lX0NivZpaI=;
 b=okCwm8bpbDRRUecAllR07QkHFqE8E6i6KXcuWqC7gxQyrCjzoCCAuwU4VsmIU95Lbh
 cZB7BRBRmlX6s9csn25PTIbYDJXJgk/HQ1uD6c+ERZMuMxsX3pvbuZavJQ50PVJZ1yEy
 /PTdVdP+1qez70t/UN9xCxbvU1uxuh+OpbqZ0Bng/MOV3xdG6fquzLPCSDFbzCZr87N9
 fXHT16J8M/RGo8iyTEfJENhm2QCeK5tZgGzO8giglk6pAUZXE7qzeGx6YKwPoDIb6UfN
 fcLp4qeOK9Hx7P7lYrHm+L59+7pnw42NLSoUeB3iDh0LoKEJP3K3109yCJwWv4MPH6/2
 zeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499997; x=1776104797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cvWpC/BP3AzO1KG7rPNsIt99iLJ3ccph4lX0NivZpaI=;
 b=Zibt37rUxMarL28Y7UFiyJx1xvgAMGaRB3SViDa39RE8LondO4GpMuKgMg4Uy9dP9R
 FnwiuhEu22Y4EdVHiy6Q0EZTSLJadXZD92RZVSYpssz9/AmValj63ZDUpylcezINOHxi
 xnDeJWKPJVLUDhghv9Gb2eDO51Hfi4abq96lPQII2K2rOxItrQeCDNm5Jey4BUiEYPKB
 atQ0sl51saYR0hyX+cBwGtCFhoYgZIvsuhRlrjYWPG+iVnDOotkqihXyno/vUoXOyLwj
 KhFdiRqQeeBhfjBB13us+Q+5fhSVC0PLS4CHo0fa9HXuteG62VyZFn7HNPZkCMzh98GJ
 Q/vg==
X-Gm-Message-State: AOJu0Yx5r2ShPGqexnUx40f3GiAOiPI/UXKEV2QcfBRWMsWJBpTM6SKv
 GysTvdLBu/sAIMCP7Sr7Z92xCbkn0M2ybVl2jF7aOozVjsn1KS2m2oiBtBXh+qpnqlf+4lnpiQv
 8mUQLk25lWQ==
X-Gm-Gg: AeBDieuKgWf0pGTjaiYeKQRjDKdXvCUZTq1h2b5GRGGC0Wwjq3mOlEXEtbFAcC/1PzW
 JwkUzHUAnyrhvoRW1IU6s4mWLVH3SpqQquKhcF6F8FrcEWZwL08vaWPitNDLD6X7w7vzyBHeOgd
 PZsOC590GAApk6rio+M6CJAGwIExRH3JqZqRDbf60LbhfUKkSxVzZh98JIxZ6/plEUfmxzhIFY/
 cSI0WpQT8/4OlGi6QpJ8J719d4xg/WkbIncb7duPPfn2yQUVewXGveNGScgGsKiX4NXg/CQLaI3
 YhZY504CnNKBhPj+u6X/CRm9y7HGvqn+BIcN1492WPEXfW3mKYyjBU8PnarjpC3d0UZQsMyPqZ5
 dTaa53f7xe8/NSmFtb8GDei85wq+EmCfj9/feOlsmMX+0kH1sBb3eEbKKmvY9ofm2YUAEzux8ln
 fd5UnIPBn8e8OGpduk8KdkEOvlnWapg6iDsPkblXLjUM8UrXLAVweYqCuqts+9SLDGRQr3CUzUi
 CNu
X-Received: by 2002:a05:6a21:3383:b0:39c:4e62:b856 with SMTP id
 adf61e73a8af0-39f2d879210mr13080873637.8.1775499997279; 
 Mon, 06 Apr 2026 11:26:37 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 18/20] target/arm/tcg/translate.c: remove target_ulong
Date: Mon,  6 Apr 2026 11:26:07 -0700
Message-ID: <20260406182609.193886-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We can replace it with uint32_t, because we know it's limited to 32-bit
target.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 68f050746d4..aea38507ef4 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6288,7 +6288,7 @@ static MemOp arm_memop_endian_swap(bool sctlr_b)
 
 /* Ditto, for a halfword (Thumb) instruction */
 static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                                     target_ulong addr, bool sctlr_b)
+                                     uint32_t addr, bool sctlr_b)
 {
 #ifndef CONFIG_USER_ONLY
     /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
@@ -6536,7 +6536,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 
 /* Load an instruction and return it in the standard little-endian order */
 static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                                    target_ulong addr, bool sctlr_b)
+                                    uint32_t addr, bool sctlr_b)
 {
     return translator_ldl_end(env, s, addr, arm_memop_endian_swap(sctlr_b));
 }
-- 
2.47.3


