Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2890AD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdife-0004Vk-H2; Thu, 08 Jan 2026 00:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifb-0004PD-In
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:51 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifZ-0005x5-LV
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:51 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso22176795ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850488; x=1768455288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j4z0oCAPZUFyYtst2gbg7Turc0axxuEQJrBWN3rdQkE=;
 b=oHD13aKSic8jlCyFCHYKq71ElRMCNIuAV5pkgUvcwALOIbFgxwe1Coq37o99u6efrj
 nJkujLp+eMXuCHMRdWNxs9/oFyWPAlqzyaLgKuC8SnbG5KXNyn1JI+IQUnUOURgj7468
 LnfPVyp7uKVAcJAEjvbj46zNZ5Rwl4Aeg8v9/uteo+v2kYGuOLlf0PPkZyBk9lQHqYDO
 crNZOnQeU0xtzeZZsEofgbyLBAnrdFAHMs7f94uvVKqpJTND59edMkVuevt1cWEZY1xt
 yzO5AskM2+umx7P1FE/sEYCVXuydu4Rfpx6FXs/jBEehQCeuGsoiH3k9FUK0zh4Zeabc
 ds3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850488; x=1768455288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j4z0oCAPZUFyYtst2gbg7Turc0axxuEQJrBWN3rdQkE=;
 b=wQjV9iGRaAbpUFFHA1X/vMe6FuAq78eM+Hog9CGcIAaeJyRJHJEyITL9WuDdGaCAQ/
 LeFBuNxc+xDg5/24fEfgIuiwR+72dKm7+HW3fMYO8nxT0jRtAqZpEsuKL2AQRb/wHpW/
 /R0QaMB/dkyiI/0lMCXztMYyTSSqT0BdBMnyJmpow3D+CvSxIeK8B5nY4MlVDRF0pwm2
 AfCSyUROPT1w7llSqE03fsSjUWc4IuZIw6Da9ij+b1XcxO4OLuaf9LVBv2g81D2AHIeq
 b7PNfulPYhatEUegWF1NbQZEtOqWhwS8eMAOHVgciuG1gc3vSWl+8xNeqH0XZpPE295R
 9c/Q==
X-Gm-Message-State: AOJu0YyZhv7hxE0QfAF9eELrqo8kb3XFy8V/LW3nP42FKcvQvUANnjx9
 UDJjhqVswUIZL/sdnz9p95vetc1fG+o97wq8P/65HrSsfJlHkRl83zUb/B84xzITBYrtNxNXFUZ
 GaBAgZF4=
X-Gm-Gg: AY/fxX6fp8tvAVi2hGAgFQ8cxee8GEf0W7tRoyHq99iHoEuGTL29d21XY9RQymwlDPH
 xvxkO9V0r1cP1enf/q1mZ1MNSQQ360psM3b2B7jn1tPCFei+nb6XKcENcAh5rLp4LhuEZ2PxgN5
 dbNHlwBAM/LTSURqeecY64pe8+SUb0u2Xf4O7bVkw0xAHGcfLF8Myh+cicbRTGoIgbWhKtQVcjQ
 9BM1HCPxzkVAHAwlQ9wQo4MSqElTQYxiQ07+3iqHE6HTkkVb+jOKwB6jED0iSD8fi1AOlyCcnET
 GoTAckZ7WMw37wUAio0ea75v799RwZl6XJAAoRcoBbDaXgZ/vXUuCoAJlBGTrJ/par7nfksRfZR
 40N7MchoR7wa2nY/NRg9jQaeb74Tdy3e73zs5gWfDJNJhJ9RC1oIAyEwVHBahSQWQiEwyrqyS8w
 UKRUry5tRF9d1ayjNbug==
X-Google-Smtp-Source: AGHT+IH8XIf2EA4aCTWoj8u1Pft6zHH94Qwd2u023Je9imASwmv3oHLW130a6N/BRhxB4tO16iADew==
X-Received: by 2002:a17:902:ce07:b0:2a0:a92c:2cb6 with SMTP id
 d9443c01a7336-2a3ee4aadb3mr47496445ad.36.1767850488003; 
 Wed, 07 Jan 2026 21:34:48 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/50] target/hppa: Drop CONFIG_ATOMIC64 test
Date: Thu,  8 Jan 2026 16:30:10 +1100
Message-ID: <20260108053018.626690-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 0458378abb..a0d733020f 100644
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


