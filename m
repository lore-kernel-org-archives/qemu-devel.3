Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF0C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP2-0008SJ-49; Sun, 04 May 2025 16:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOv-0008P7-VA
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOs-0006xh-Tc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso33443015ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392245; x=1746997045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEuwy7Yf4FVl52jtCV243O0AMcyw9q5dI/6CqAcLAgQ=;
 b=PF36/yNusP7IHlK0QWwX7eal12L7+qrcOyI9EpbKugCb9SeAXVeBdjfqjOamZ30q0M
 fSF/lBQeCqYm7wtQNR2pTApZVDKFHfnyGcqFoUj1LQk3wsQxMxybYWy/5+xmaJLNvTsV
 /67iSmLZClEk8c+Bjk+Bnm2vL/RrVPyzZwCNKrVmf/20bo7HUm4jmUZ4QWTFoNRhXh2K
 MrQEP97WyAq0Hz9meWhMT5VJ0C7HMfnw6kPxAVr3EIyDW3WL3IGlO+llr+h5TmI+4O6B
 vDK2FcaN0WIAqeYVhTg6tE/GafScgwMKlBsWFxmrXW/rzFA7gK+VkruSD4kHy+C3MtD/
 2Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392245; x=1746997045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEuwy7Yf4FVl52jtCV243O0AMcyw9q5dI/6CqAcLAgQ=;
 b=Eav6Q3efuG1fna0ilOGVBJGYP3LW6OChdrH4yn0mRv7UzaF45NscaHChzDflDZ0GkI
 f64hIe5LQmATz9LlvfkI3B7SzfXpnZ/bjwPqgzMPvKk1z1OkrX6zzPVsO+YrnLm40YY2
 GlOdEEQCKcTeyzq6t29mr6cmEeveBbtxUxypQ13thfYJ42UzGYXpOqH0fijqFdUx4mRj
 cHaCAcAwdayzWVvB3KysMSgIorMdaiWJn2FMtHEd4EmHokwFEYoqwfvKKw6RyfwyiRMg
 BAibJCdMQrys7CPmNKj51C+OI39sz38unfy09rkQndvqBBdo5EiotL14a8B43tyD36yc
 DgWQ==
X-Gm-Message-State: AOJu0YyPu7qzpK5ssEFphNHcJBv46C5qhvfPgT0rdwtMJRWA393E31dX
 nJQRdBMvjLX1mKtu0qQUJSvU4U+rbs3Uc5s8Wzs+W6lXPfMz8YkLdMfzeCuZmctdMCKRIDfrunb
 Y
X-Gm-Gg: ASbGncs7gi5N0Lt/7LlZPNf5o7tIaFhi7YuUVren13Iqi5jSFht73BgEmBKT5CqyF3i
 FPEAUkahmqD2HxXVCGKjUjj9Cx1Gm4qWfXPhDfznfP72HDR0dF0U+2JQs6KJu6dcB8Ta/17+RHP
 r35xCtpoprPyUsxfmgNRbn3jcB9pst6NpfBB4WJ4t7jv8gf/a0PQZaxA3gQw7quHiinpt0eXEvT
 BRPRncLik8aUApn8A2ClhFe2OLZIWSooYtsb3SpN1ZotaYU6ZomW1xw08um2koU1xYSbuk9nBNJ
 /ZTnCspQTOFzA4az1ATXtSDpUjyJ1KKq/F8NvKzhfY8FODJQjaoo+yGCrBkiER/8JqdeI5/qGm0
 KBZZ7APtCrQ==
X-Google-Smtp-Source: AGHT+IHUIyr4lSUPySIohNCwAC7GF6ZRNtku/KuVJ1ow0eCb3u+swEOvTD64T/cPY8AOEflT+HQpoQ==
X-Received: by 2002:a17:902:c40a:b0:223:4d5e:7592 with SMTP id
 d9443c01a7336-22e0864839amr228974265ad.21.1746392244989; 
 Sun, 04 May 2025 13:57:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com
Subject: [PATCH 12/12] accel/tcg: Assert TCGCPUOps.pointer_wrap is set
Date: Sun,  4 May 2025 13:57:13 -0700
Message-ID: <20250504205714.3432096-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

All targets now provide the function, so we can
make the call unconditional.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 1 +
 accel/tcg/cputlb.c   | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index cc5f362305..713bdb2056 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1039,6 +1039,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
+        assert(tcg_ops->pointer_wrap);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
         assert(tcg_ops->get_tb_cpu_state);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 022d555f48..b49f0dcc29 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1773,11 +1773,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
 
-        if (cpu->cc->tcg_ops->pointer_wrap) {
-            l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
-                                                             l->page[1].addr,
-                                                             addr);
-        }
+        l->page[1].addr = cpu->cc->tcg_ops->pointer_wrap(cpu, l->mmu_idx,
+                                                         l->page[1].addr, addr);
 
         /*
          * Lookup both pages, recognizing exceptions from either.  If the
-- 
2.43.0


