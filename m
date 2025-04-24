Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A45C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krA-0002Q9-Mq; Wed, 23 Apr 2025 20:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015T-S4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqC-0004jH-T2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so302142b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456003; x=1746060803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QynRPoXJau8Yr/yoj90YDXHGDidiVD7zboFZXeEbo0c=;
 b=WYBO7YrDiI3GhId9p0hdUT7a6+uwjYnoSJ3X2qxuYigxsOKJE5N8M8+FtOhGcUdoDL
 qz/meNqiRMLixAzme3Z1ilTffVUYEe6xiLjmvvs6qJV7wSPLJBO1BKeTOeqw/bJzM4xn
 g9t9kj8t6oo1Y+Gy0EJ5tIehNuJKlkN1wTsRyTI9ji5aE3JQqx4fxMUCTaqE7sY/AC9M
 pExNL68tZYMfWV11Po0hs1ZcDAJF9rAspq6CE49sRRgNYqY5Rjh+nkp7Wv941Lluvut8
 nTtOhFRLOBhJUcYMTpLAVHnjObOfkbA/9RS465oEzZE5gY3INdfO5rIB01B4OmsdK7pR
 bxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456003; x=1746060803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QynRPoXJau8Yr/yoj90YDXHGDidiVD7zboFZXeEbo0c=;
 b=vccbxO9krC40d8JSjtqxJU+SjLpA6rAJ84/0+4VNh9g1W767V6tb0UbZxPExh7LiBi
 y2aAnDhm1qC1HihYg+aQECxs36nsgMUzVv4P9rINRwTSlLX/+NEZ421803CFngpLdzPP
 9cShXeUbpjnZTquLWb+xcxK47LtQ6CLzJARmSyimmvxslmNzUlvJBmSq4fHPKKIhEQ70
 1NVVo45k0MBBM1JE/E3sVBrM1FjIZJb52TV8q4FtHrNRvARcSSP4JUh9S7WCZWCS9S77
 H+LtWtqybA7XNPhYN6mtim3KWO+UZNlmqWWkhYtSYtbrKPXkX3Uxixi9Bn1MiGi61/+E
 67KA==
X-Gm-Message-State: AOJu0YxvcuqMq3VcEN1hJSNjXVL2QWb7I5SK3GkYTgI2cS6rr8rrytZO
 MvLVq+4GhFIKTlNl8AHNGl/kTNg4hDhjY1t/S1bHIlnkBEQc2SFqEVJizfG/p7xxjiYlGAiBcOy
 T
X-Gm-Gg: ASbGncvAWBuHgSkZdoaHmjaEw3AA4xx17srDZzubvc5hQAJMsvyejEwz0dwB5KtD93w
 IBYdwfJWlBj6A+n+Zp3i/jzt1WlkQwJV0MhSAWrE1mudnXdNQstcAhV4V5mWetRLxMOrW9Pj0kz
 Q2yjQj2T5+4OuEI1js+UbX8+bdYRDrg+48OitpP+/AWd9kn/iB52xg2+d0kBgWfJzmnaj69qwiG
 LId6984Qg4FaHoFI/SLlXYkeO7iI1+A6UgqWoov162mOvCD20FUUKDz4RUOHxksyU+hz7NgsNOs
 pOB5pfo+k5B0kJR/+tPJ35UI3n0p0EtWooy+al6eY81du9p7QHTpS7fTS87gJ1CfoBmbUny2jM4
 =
X-Google-Smtp-Source: AGHT+IGvjR3UCrqEW6oePT0H+QFxtCdrh9U3lHa9DTbZpXt2/rSrwu+5BdovVjYK/Za7oMwdhXASwg==
X-Received: by 2002:a05:6a00:3a26:b0:736:34a2:8a20 with SMTP id
 d2e1a72fcca58-73e24af550emr1028670b3a.21.1745456003243; 
 Wed, 23 Apr 2025 17:53:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 063/148] accel/tcg: Fix argument types of tlb_reset_dirty
Date: Wed, 23 Apr 2025 17:48:08 -0700
Message-ID: <20250424004934.598783-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The arguments to tlb_reset_dirty are host pointers.
The conversion from ram_addr_t was done in the sole
caller, tlb_reset_dirty_range_all.

Fixes: e554861766d ("exec: prepare for splitting")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h | 2 +-
 accel/tcg/cputlb.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 8125f6809c..03ed7e2165 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -31,7 +31,7 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
 #endif
 
 #ifndef CONFIG_USER_ONLY
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
+void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b2db49e305..10090067f7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -912,7 +912,7 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  * We must take tlb_c.lock to avoid racing with another vCPU update. The only
  * thing actually updated is the target TLB entry ->addr_write flags.
  */
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
+void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 {
     int mmu_idx;
 
@@ -923,12 +923,12 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
         for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
-                                         start1, length);
+                                         start, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
             tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
-                                         start1, length);
+                                         start, length);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-- 
2.43.0


