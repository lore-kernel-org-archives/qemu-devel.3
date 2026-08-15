Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C141CC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8T-00084k-L3; Sat, 15 Aug 2026 16:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8S-000839-1l
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:44 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8P-0008AH-1I
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3293658a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826259; x=1787431059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p1tuew/8yZ3WUepEtCLWv5OHi9k/pwAQkc4Skx4oIwo=;
 b=LNzjA/LnIYLGqFRYhQh5V2Qe3RnNvKD1fu/1bp0yoaaGjapKvB3Z+s89K6y58rHEQg
 HVAUdRAfaoHbaSQIyvvKWWyg7AMB7zmBW6+rgUsZvgL9t5zAofrc6nA5z/fOftvL3foU
 NsIBhFIsqdJytK8hb+8A6HXK5liyz2AT08scQNwuC+aTzgcH4gkq1yfyN5QdkwXe3S4V
 UcGZVmDCkhpFXr9NzG8ed12rI+IDZFn4W+IOwmrIXXmvyYKqzdyy+q8Q+WgGDD6q5Ofx
 XnUZyz6smiR9RdelNEVDx3UzFkX0sqxTkF42t+fH2xj5qPjd+WbmkUbF7EISbUfNeNDS
 qWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826259; x=1787431059;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p1tuew/8yZ3WUepEtCLWv5OHi9k/pwAQkc4Skx4oIwo=;
 b=LAndilEacj9Mg1V/xkolbhCRqmm7qBgVmR1MTpgWUSUt96kUPM+7xWas/hH/tevZ7y
 +yUjFG/+5JrV5T+p3ntA3v3rOxGU6DYgNqVJt96YwbOSPwhpZInE/wQrvbyKX5DRoTP4
 ESIGSA8S29oKP8cgYL4AAm6qk1erC9lrm9PzsFXEnsdwwae3oGX95tXNLKlqjebwCEac
 okTaYhpz8xuV7tPLXf6kTySFtrU8RZ862gX8hnC6WjaA6qnrpakHp8mRN6lNyvsYcksX
 H3GCNk49GjgmXMC44VEqsbt33DPWTf5cQf9D44PjzAoEc/0Es8MFzDwd7Jyr32eGBqBT
 uzog==
X-Gm-Message-State: AOJu0YwLHj5IbnnWhL7C52Chhslak1PIkeL6srOf3syqDqYBXjsyhVyO
 rBA99itSAq+F/68lcV5PtKCX/HrgMRyF2NlJ81gEyxwuF2XVAgNU8BPr77bcwqLz+pX1NGolGHs
 /r4QV
X-Gm-Gg: AR+sD10eL69XqSklizi9tSa180oRO+C9w+wdrgd8ckRe+Ks1ylPbAMYltyD8vZJa4kx
 b5jjDXoTALbGaOx0+2e/42QzgMlqLm/X10W0nId8QWm6q9ksSusleuhUWElh36FiANmoyqr4kZx
 f97gEhcpIvxVvg3YA4YkcZRMf8F3z3FzI+5oN25SbaHJaxY4veiRQdGr4urp33ocEgsZokF9bAI
 PvAaRocin+I/0jYOnAaWvsVqW7m4QJTk1xx4YyHT4DA13UgkTMhL+EXnBZ4hrhwbJp9ZI/kQ4h9
 hgbTvlcAmAWviHihiZHx2SddMEqVV82u5bWHFWz6WqtcYG+ovgHuD+dU60YOYQOfjUFHUA8az7F
 aOyumbbLw688UTH4dqMx6XGYNzJd3FoJtbbBv40asdvQNroVnYPh+7tolQ1OpDv7DdIdZvlTNYr
 4IzKckJX/SompVUuHN/JwI0UTNrfb8rNI3mjhkZcG5oOIBBVYY7+LJOgOO77oP3cbGcNESTeg/5
 FhrDW+BO0NyXlOOx3Nc
X-Received: by 2002:a17:90b:2b8e:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-3933b8aa611mr17329444a91.15.1786826259247; 
 Sat, 15 Aug 2026 13:37:39 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH 02/18] target/arm: Simplify invalid page test in
 allocation_tag_mem_internal
Date: Sat, 15 Aug 2026 13:37:14 -0700
Message-ID: <20260815203730.1468365-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a1d8618ddb..e3952fcabf 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -132,10 +132,10 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
      */
     flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
                               ra == 0, &host, &full, ra);
-    if (probe && (flags & TLB_INVALID_MASK)) {
+    if (unlikely(flags & TLB_INVALID_MASK)) {
+        assert(probe);
         return NULL;
     }
-    assert(!(flags & TLB_INVALID_MASK));
 
     switch (full->extra.arm.pte_attrs) {
     case 0xf0: /* Tagged */
-- 
2.43.0


