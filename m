Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E82ECD5BC4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC74-0001T4-5M; Thu, 05 Sep 2024 09:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6u-0000yN-9w
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001k5-79
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso5918325e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541270; x=1726146070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5PrsaI8e8/02sXu3878r/Hk09KLGVkhl986RODv/XE=;
 b=sba6Ax62CT2yHQVazfJLg3025KXP3J3ybrvrvSsTaQGtXV6GQu4uDM/U9+ZpI30Jm7
 qIjNa9/iJYjhvOFMNfarx0oukXD32IM8LCpGYchbacBqZN930U+DcrRT6pXrhfmqN5Yp
 bjV33LVx9jC4EdIrVt0FoI75wU6FCwanNiSGj9j6xHZR2B9CWSrpgUOLNfyPkNSUgPFp
 PZ3dRZ9wUCstUP+rFwk2gcoVaT9tDfiPg+3fum5j6Bt7+jNthOO20iQ5jVDMGewlu54N
 bpkzfoq9/ZbGJv5o1Sh0dQgf4oO5bF8YMOrQ57fvGsqi0FyRX2vcB1BZVJOg/p/wL2cQ
 Uf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541270; x=1726146070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5PrsaI8e8/02sXu3878r/Hk09KLGVkhl986RODv/XE=;
 b=Wwy2vNViK7Rr+ypJhvBSVslt5sDbtNYO6MU4aeAKI/dD9fyXy74X2monsIQay7il7H
 RKpmad92DGwiNKxT8jUULBE0pE22Q8yCSbpejtXfAuclHPUg8dB9BugT75sA5j1EOjNf
 enSfZ9S1JzoxRzm7tXPSk9syeNtxIqqmd75yGbS3plf+rRyfgYMbuDRMqcE/c/va9DD7
 t6WPTNjuGq3qjGGG9RmUmC2AbqgKBtuX+opDsRYSe4GHAPZYJn9r5AmiCYChwlJRE8WK
 y1ez9BW644+7ttiar+ML7BQapG0gI0OVxUokSG9z+D0YbKFdvVPbx+hXQjGXq3szFebu
 LbcA==
X-Gm-Message-State: AOJu0YzoBGyg+PyZaFNsO/yYRtQGRdY9JTCXVLzo/gvSJA7cgbeoKPJl
 s5p7XSWvBxeCz+biiHxcX0zA+dDwQpcfN/1mOiZF4cYtXpRN713lJ6o+S3kxgAvzr03FHjaaIzI
 a
X-Google-Smtp-Source: AGHT+IGO6WZaM0UDCcDaWJAApAF6947o6wKQV5HBbxFDH+Sdn8bSiLVmTovx+0v85FayZYodlGgT4w==
X-Received: by 2002:adf:f64d:0:b0:371:7e3f:6cc with SMTP id
 ffacd0b85a97d-376dcc8b871mr5003657f8f.9.1725541269785; 
 Thu, 05 Sep 2024 06:01:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/25] accel/tcg: Remove dead code from rr_cpu_thread_fn()
Date: Thu,  5 Sep 2024 14:00:44 +0100
Message-Id: <20240905130100.298768-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The main loop in rr_cpu_thread_fn() can never terminate, so the
code at the end of the function to clean up the RCU subsystem is
dead code. Replace it with g_assert_not_reached().

(This is different from the other cpu_thread_fn for e.g. MTTCG or
for the KVM accelerator -- those can exit, if the vCPU they
are responsible for is unplugged. But the RR cpu thread fn
handles all CPUs in the system in a round-robin way, so even
if one is unplugged it keeps looping.)

Resolves: Coverity CID 1547782
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240815143634.3413679-1-peter.maydell@linaro.org
---
 accel/tcg/tcg-accel-ops-rr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index c59c77da4b3..8ebadf8e9e1 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,9 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
-    rcu_remove_force_rcu_notifier(&force_rcu);
-    rcu_unregister_thread();
-    return NULL;
+    g_assert_not_reached();
 }
 
 void rr_start_vcpu_thread(CPUState *cpu)
-- 
2.34.1


