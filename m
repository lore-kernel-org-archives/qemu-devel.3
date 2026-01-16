Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7815D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagS-0005CW-Ad; Thu, 15 Jan 2026 22:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagQ-0005Bx-Ru
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:34 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagP-0008Ug-Di
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:34 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso11980245ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534772; x=1769139572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqPM6MHn7AUegnXKkA5IATnkWJcY3AmpmfrRokR9q1Q=;
 b=g6NuW71/rzbCVQM5g3bsjoXo1Z1epTj0bnVZXn3CJOVtsoNK1DzW2XE4uHr0/bNaR4
 IasBgitmgENEp5fGh7MVwLbHgOi8NKtHFnaRPVtP0Wh8+L7wEzypWhfmC3EtGctXBrGv
 kwQnf/eiasHNVm+NRId4YbokQy85KgZqwvwF81GfvGGNr88udBSGABBWK4Jn5r0rHa5F
 KUj1VhRYonO2G1m5mpD7u31eb1vf/Dfdz5xevMDG7Iu0sboBaxGqmZFD5Eiuq6R1vpoO
 qfbQNvKgVBcokgdooQieOcmrJCJNlGgQiklSgqGOhBna+7UdDHQfxyTTr2ptxSfrS8/8
 /p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534772; x=1769139572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqPM6MHn7AUegnXKkA5IATnkWJcY3AmpmfrRokR9q1Q=;
 b=wtArrBrh8qPiFMU/JjnZO5pOOU7K9UC2e+uZjDk18vVIQefGGEniJvcVGO1NqxaChG
 TY9ju8SlXu7+X5lcrAVz7VXo6AYehbJ3IGyT8T53BBFlexhCa1fXhwkQOm3nadrl5xBb
 bE/LwwdK/H8Z5RTSTHE2rNpFwbzUScWJDaiGMmb5xmgTaXiRNdOtD+tg136Ia9BEHpZW
 5t1UlskMUsmoqxHSnGAcSRHuzzFkSdX+x0PL+E2L/C2y/VsdFj78jE/tuw3nsY59qVyE
 qZM1wAFKr2BQUQM8c3LLNT7Tk6H2fM0Au60ARBrW0uw5DWppcJmC2AD9SEhVtudxO3CU
 Xinw==
X-Gm-Message-State: AOJu0YzbfR5rUwNisWvyWB3/Ejz62n+t/wvNmJnWamkBZkZA8/VHOVn+
 4Uj4j9d27+E1zSGfukrdsjw/4MZiXpL7srZ79274bi/F37uPtUpIzGqnakMLeShyQ5jSHhci8H9
 Puuw65FQ3HA==
X-Gm-Gg: AY/fxX4kEnSOaL+vYwf6/hjn62pMkIKeNaCUq+XiS1/Q8IDJhvTFwES64TBHqa4pHOm
 aXxzhmnjV3BavxQdJw9YcFa7zjm6CAGXhhZT7KyaoVeVj5t2zppndO7N910pGM13xBfmekOvstd
 Bes8Q5n42LBH8pGQyraRJdCtSABYra1Wm9+BCavCl1pUETQUPWjplGWioIptqOMPCybSwRJKNcU
 +38VBf3QgP7u8ld0Rl3fVCskvPX2sFN+iDdAZNL59UqP38RFR4TSwIK4hQKU2QWL1U+ylvmtNss
 ml3tGGwLL6B4LHNJSu22Q9A+FKhljDcfHkyD5zklNh6z74KPmxfvmKw4ITTr+qwibS12d/l1PVR
 v4jbjlMAz784NpXaPoShKy0TKzIGBdpqjCH7j2tR4M/jPtpVOkeQ23VZ66cTVKtmiQ8cw3n+7M0
 HyJOlXtBBWEGrzmPG5tw==
X-Received: by 2002:a17:902:db0f:b0:2a1:4293:beb9 with SMTP id
 d9443c01a7336-2a7189739c2mr13655545ad.58.1768534771948; 
 Thu, 15 Jan 2026 19:39:31 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 51/58] target/s390x: Drop CONFIG_ATOMIC64 tests
Date: Fri, 16 Jan 2026 14:32:57 +1100
Message-ID: <20260116033305.51162-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 2972b7ddb9..0b8b6d3bbb 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1815,9 +1815,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
      */
     if (parallel) {
         uint32_t max = 2;
-#ifdef CONFIG_ATOMIC64
         max = 3;
-#endif
         if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
             (HAVE_ATOMIC128_RW ? 0 : sc > max)) {
             cpu_loop_exit_atomic(env_cpu(env), ra);
@@ -1856,12 +1854,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             uint64_t ov;
 
             if (parallel) {
-#ifdef CONFIG_ATOMIC64
                 ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);
-#else
-                /* Note that we asserted !parallel above.  */
-                g_assert_not_reached();
-#endif
             } else {
                 ov = cpu_ldq_mmu(env, a1, oi8, ra);
                 cpu_stq_mmu(env, a1, (ov == cv ? nv : ov), oi8, ra);
-- 
2.43.0


