Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0736ED4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagQ-0005BV-2G; Thu, 15 Jan 2026 22:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagM-00058W-I8
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:30 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagJ-0008QX-Hs
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:30 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29f2676bb21so15494725ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534765; x=1769139565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rU1RTCNNq4TKsOcqp8cLlT2o5D/A3g+nlZpIvpHSpXU=;
 b=T4oGY/unEW2fcS2yoDuRKctAjo2SvIXwAHWQ2Rx9veDSX/B+uADJIJJ0xiY2I9scPG
 vG53HU/zZEMkfcrRnIDQ0Lci67rv/3suO15BWkrSISdaPvaEJjUVAMlUHQ6rpaE+q5ty
 QY5QqA9uo8wYndc8sMh2UBSR+lJqx8HGsjeWrRLaPVzSe9vJ5LZJwv2fIIkxW2T9o0up
 cehYauW5OrHqZ+Wu5l0RRtugYa4nGm+Z1ZW3vd10WrH1SPRSaiswswzePpgUQWvJ+G9H
 rZxjYHY0tJYOrLw+uAt1tlQ8oobTjCmxmRvUL3Gb9Mea1YaiIkQsJPnhgpu9RtO4Rzln
 bCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534765; x=1769139565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rU1RTCNNq4TKsOcqp8cLlT2o5D/A3g+nlZpIvpHSpXU=;
 b=Qv33H2Ei0tnF6A5rY0XooNvP6NeSjpXNzBYlC2xUjY66L4wrixi2fh7SMDcKBRDzO1
 jMnQxq7RsZccuv8gaDVEJZGFMNcqSAb+DPhMdZu2a4RmLr4iVeQw1qthAVtSmCWLrZVh
 GFp3/nAWc7MbrFHj/OgdyGh0rTFOoNyLPdDw3b+nIF3utdblF6ewQ6c4hlqyobRYqmmG
 zylJIDs/V/oB0NjOCs5nV9g+UpYQ27tlQTBvz9AUAUNorW75lU1D0eAlcuFPjUufcOiS
 E0ciHwiPB2YIt0xZ3719hbJwG9r1VkpjDX22L8Er/q8PnZfI8uCOhv+v5qylyVchBkT2
 djEA==
X-Gm-Message-State: AOJu0Yz5fR+NDTMyJBSut1Jbe80j3gSA1RyjESdvND6rkcvSgmXpJQ6B
 xpNwJctw6gWhXqGsU10iVhcCl95WbHYpmgiKq4K2vHTcuDI3EivszetII7bBNHVW7zUTc81Oqzq
 crmprzr4nEw==
X-Gm-Gg: AY/fxX4CJB/TiFcLNjl6W6dkTrjnOKIKwQf1FEOvzV+jSqdyzOvWsyGOqLv2ALw+69R
 OybtqyOgWUiUIJFfMPqbTPMo7NLtPIG73ce9bwB6NfGrz3AsQGA6y4qHODlcS8gLlqddPYZlZes
 8zkKzkgp4DNpLun231cGd8kfnZJp+LiS4Sq52wjTv1wwVBmFQTcDxtseti6NuYPRx0fhvNeJY4j
 f5S+FmXP5ra80XGVQCh7XA8z1c9hspbhaQzzcyDM658Bm//Tzq0QnisndlTY39xh257MyVZpQiF
 KyKcAug1YWfwA3+ALVfi3l/4G0CwOZ6DI0qwkEGlmujXx3U48bBeEvv18SUtawamPvOmn/ofIjp
 aqqocN29YZMj9IcItI3OjqA0SLACq/OWSRGu2GlcK7LQYo/8s7kPqDtLRYz8tqfI6G8iTGFPbZt
 hiwdw1Df9fqiQ7a+G5JA==
X-Received: by 2002:a17:903:1104:b0:29e:9c82:a920 with SMTP id
 d9443c01a7336-2a7188589bcmr13575545ad.6.1768534764667; 
 Thu, 15 Jan 2026 19:39:24 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 49/58] target/hppa: Drop CONFIG_ATOMIC64 test
Date: Fri, 16 Jan 2026 14:32:55 +1100
Message-ID: <20260116033305.51162-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 65faf03cd0..f961046e4c 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -74,7 +74,6 @@ static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
                                 uint64_t val, uint64_t mask,
                                 int size, uintptr_t ra)
 {
-#ifdef CONFIG_ATOMIC64
     int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     uint64_t old, new, cmp, *haddr;
     void *vaddr;
@@ -88,15 +87,12 @@ static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
     old = *haddr;
     while (1) {
         new = be32_to_cpu((cpu_to_be32(old) & ~mask) | (val & mask));
-        cmp = qatomic_cmpxchg__nocheck(haddr, old, new);
+        cmp = qatomic_cmpxchg(haddr, old, new);
         if (cmp == old) {
             return;
         }
         old = cmp;
     }
-#else
-    cpu_loop_exit_atomic(env_cpu(env), ra);
-#endif
 }
 
 static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
-- 
2.43.0


