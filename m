Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9551EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCs3-0004Os-R3; Tue, 07 Jul 2026 16:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCs0-0004N8-NP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:20 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCry-0003UA-U1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:20 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so121305ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457897; x=1784062697; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6NVpDPyyHA3ywWGQbRAIp5lwe7VyQhAC42/S8ZUUiho=;
 b=ui/Uue4Y9nA5LRK2zHnnzNyShMR9Yz0PnX3o30FPHc6J+E58Ze6plWRIPUYwe+IfD5
 pZh0ARAs0V+6uT3vXVXfupueLLCedDqDC5PsB8sQzRNGXBAuQ+Y2AI537dHLCrPSKWMJ
 ry+GNJd/4WZ7hZJum2CfCUO12yWLIAk2/fLkb6l2t/tty2ezPlBoePSaWcU2lYc+FhWO
 Do2NSCXIb6iUDEkKQp5kgXmuvsI4M670oNcjIjizJnQ3xygVyo3o1jEVFvoWlRC0/6ky
 tV1XqqaXHLsnFF34PZvNlFPs4FY3jDR6BrSAWN3WDKr2ll5Zv3W6ShliV/ZO0XbHJNmv
 +T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457897; x=1784062697;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6NVpDPyyHA3ywWGQbRAIp5lwe7VyQhAC42/S8ZUUiho=;
 b=EWxM0ZILC+yUmQs3T5Lm8O2dK/35tlWoRrkChtimNj3kBE3cmq1bORnyOXzHEWHVW+
 Yj8mlm4yNhb6J5iWRgvblNx7cmPqv4Fu1kqgf5EThzkoNDCVCwa3fi5QcJ/5pqAwz4SG
 uQtlT9SjKcX2rqa9qYJqmIgTRerdpogbEh2ayL5zCJKzXAnzByg3ntASC2BNizau9jjA
 MAfWUfrZv68ZI04xdtEUb1CuVcWVHlpEFFyXVb3yV5ogJGF7rnQQs1Dq1rXsyuw+LRT+
 zClJc4PQwX4avT9ED9XOyym+u49/C9A3AK7gqNdigxspisq11C47SaGwCa1UGAS7Tg8K
 cCwA==
X-Gm-Message-State: AOJu0YxclfIgHxL8V9MrU7yaGrnc/S9qzrCLVfY6Aj/ugw9joGVhXEfz
 RRabab2uftVc7YO1dxPLkaz5dMvFaCrbmVAKSrpahyrMNGSbvWYH2xMHSwf02abH0TMaGSD2+le
 jQBKq
X-Gm-Gg: AfdE7cl9njfb7zhvbY+9MyYfpNFnw4fzl9Ge1NnjQBzwCQYT7wP6dtKLsP5UpMm+Xf2
 EaiXBb7cEuHGE38uAUhhuI1EwFOycikDs9i7iEzbOrwWpWsosaZFnMm04nWOf6V8rzkh8DHu8jO
 vxpzP4CRf9oPOoBeAi0hA46b3JrKg2qkKsEEmxV0bCXaUhweWElBGPpdoH2PeM8g078PvHwdDTo
 43e+jbWGLH+K/M5njPWx2kvUExjy5jp3/uNtFN4yP9qjPelsl05o+IZaU1CtFmcRl7c+C+NTxMt
 CNl5m+GGe4eUvUjvQEYLNPvc7AZC7KCCGKZ6wS3hn3WJCVATGNfAseg4SP4POrl2jIyxEwS7F3p
 vQhBIxPcg6LGllS5Op4sxyH2NqQ/sRs4SEXCd+BDM0MfUjAHN8ZbONVYWk5JHE79v9zhnOq7m+r
 Iz/HJwmz9V+utN1yuwQz5hT08ni3S0dqEFao63I4V6CGdUHr0=
X-Received: by 2002:a17:903:40c9:b0:2cc:d69a:354a with SMTP id
 d9443c01a7336-2ccd69a39c6mr25467975ad.22.1783457897368; 
 Tue, 07 Jul 2026 13:58:17 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 5/6] tcg/x86_64: declare MO_ATOM_WITHIN16 host atomicity support
Date: Tue,  7 Jul 2026 13:58:09 -0700
Message-ID: <20260707205810.303376-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Just like aarch64's prepare_host_addr(), x86_64 should use
MO_ATOM_WITHIN16 for the memop when it's capable. Unlike aarch64,
which needs to check a CPU feature, x86 has been capable since P6
family processors and newer (see Intel SDM Vol. 3 §11.1.1).

Since a 16-byte aligned region always fits within a 16-byte multiple
sized cache line (x86_64 implementations always have cache lines of
at least 64 bytes), then this enables riscv cpu models with Zama16b
to use the fast path, just as cpu models without Zama16b do.

Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Update both atom_and_align_for_opc calls]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260707122819.114105-1-andrew.jones@oss.qualcomm.com>
---
 tcg/x86_64/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 92251f8327..1fc45e4ec6 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -1783,7 +1783,7 @@ bool tcg_target_has_memory_bswap(MemOp memop)
      * Reject 16-byte memop with 16-byte atomicity, i.e. VMOVDQA,
      * but do allow a pair of 64-bit operations, i.e. MOVBEQ.
      */
-    aa = atom_and_align_for_opc(tcg_ctx, memop, MO_ATOM_IFALIGN, true);
+    aa = atom_and_align_for_opc(tcg_ctx, memop, MO_ATOM_WITHIN16, true);
     return aa.atom < MO_128;
 }
 
@@ -1934,7 +1934,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         *h = x86_guest_base;
     }
     h->base = addr;
-    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
     if (tcg_use_softmmu) {
-- 
2.43.0


