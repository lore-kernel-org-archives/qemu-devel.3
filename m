Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA576EE2084
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJ3e-0001TF-0m; Fri, 06 Feb 2026 05:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3T-0001SJ-10
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:15 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3R-0007TU-8G
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:14 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c868b197eso1461725a91.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770373632; x=1770978432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiiSvKf90gSVLdk8ZbuglWutyjV/XckwzYPcdDLKSsA=;
 b=et3eyf4TwYT2CqPMcY/0lsSlUDvAZSofU9Usiq1+g1bqbK2Pi5LaM0C2z+BYYLkGLC
 /2PrP+Tt9yJn7O3N2ADJ6E/gyEsDUkw9H47eYSX6mQl7EdZ2kqFrz6mPLcjLhdSQjAnY
 usA6LZ5S6XrgNBsLd7QtQb5ZGtqGjBygALwAQxuzsIfqgjzi2wnS34IIxOO6SRGi+M05
 lQz5ZKtTI0An40sEu2AigoRVfpJHEs20ptPMVjDFR8Gvcs0pF6hTDvTmdf1okFu6A17l
 bgKrn6hpha9KUt+KZB0oPNI5RSliAgxtcRXQMTAb1K38wYqSaDxHrYlmoc1vEBibHXBy
 n4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770373632; x=1770978432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tiiSvKf90gSVLdk8ZbuglWutyjV/XckwzYPcdDLKSsA=;
 b=iPACBjLFQsDEIkrgLbJ6wirjnh3yT5vezeGASvZD6RRRYVQJN3wF1yOMtEmYdjPvfi
 Dik8j8i9l6p6CBF9A5m70j9Jzqq42b4lShy9jpui8Gd3zcphSG/CVoSQczBY8ZoLEesP
 ZX3zFLw3bYnRfZaYmT8+4nxa0fvp0k37cI62mMDu2Q/v5X2uTE0/wGSs5ylQMJdTlzcO
 SJMsV6R6PZ9TxiwyD9IQ+Nb15w4VITFq1QmQefsPLZwW7lxGr9cPswJiXUtzE+29LPts
 zOZH983J+YQnMOaIkyhQG9hMbis9aklcRJNexTAJICnHXWGmjNkih1yutBwMjPwenx3Q
 pwTA==
X-Gm-Message-State: AOJu0YxpjOcUVvgdKGzUPSSd4A4V1vJEwMy4/gbHk++vye48pBOf6EZd
 RconfNXBahGVMmNPefq+FtUTo6mD4VDOhwVhZ+qjHMoE2smsHMdsNHUZaV034OhDFkD5BEq/Efi
 GBnDDZnNOpA==
X-Gm-Gg: AZuq6aKdSRawxE3WKD2jEE+dKFS+ZYrsZkbiXt+b/Gx56VOBKWW7y5ND5+CUpcK7j3D
 F1KHqL9ezXscaTkqfMcIEzWsJVNSEKZB3FPv/Qme2RiAbjyGmW5tznfqhuLI51x34qqd19f5rbX
 VZhmjCHP+xVlInfhx1PecuZS62yI68ts+0G0TZceIbdJCBpbXB2zWIux6YopSiKwNSKcWMCEfdF
 +iQzcBEfADgnFr7y5DdkC8gf3fhrMXiQg0uCNPWYbbu5ZISPBL0uL1lW1ohcoZK8pYCSJbZNoPr
 ZIOI2xoGDOt2DvXDm/lBFXpzKFBYNNvgTq4FQYYyikayeIFcgODTjMhrD1bIFAOV/kgh++VPxAV
 HsUe05gPHd9Mf5oyylHDPIvW6Is4RoxKn1rS32Ax/OCQXcUNX1Ae64D/I65C7Z8RpyWAIUGyLfO
 Ns32HP5bCfnJyxIzT/H88AUXcb4j3xHL63AdOcNAZqrKSDsMBef+Ay5LEY8R92DlU=
X-Received: by 2002:a17:90b:2d8b:b0:340:ff7d:c26 with SMTP id
 98e67ed59e1d1-354b3be0b36mr1976306a91.16.1770373631516; 
 Fri, 06 Feb 2026 02:27:11 -0800 (PST)
Received: from stoup.. (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49191sm2113723a91.7.2026.02.06.02.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:27:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/5] accel/tcg: Remove a redundant argument attrs in
 io_prepare()
Date: Fri,  6 Feb 2026 20:26:52 +1000
Message-ID: <20260206102652.164018-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206102652.164018-1-richard.henderson@linaro.org>
References: <20260206102652.164018-1-richard.henderson@linaro.org>
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

From: Jim Shu <jim.shu@sifive.com>

attrs is already in CPUTLBEntryFull, so this argument is redundant.
Just remove it.

Clean up commit 94c6e9cf04409e38563080348d6136879f91ffee

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260203142737.2164763-1-jim.shu@sifive.com>
---
 accel/tcg/cputlb.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3d75abbe68..d6115bbb0a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1271,7 +1271,7 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 
 static MemoryRegionSection *
 io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
-           MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
+           vaddr addr, uintptr_t retaddr)
 {
     MemoryRegionSection *section;
     hwaddr mr_offset;
@@ -1974,12 +1974,10 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
-    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 0 && size <= 8);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -1994,13 +1992,11 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
-    MemTxAttrs attrs;
     uint64_t a, b;
 
     tcg_debug_assert(size > 8 && size <= 16);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2492,12 +2488,10 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     hwaddr mr_offset;
     MemoryRegion *mr;
-    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 0 && size <= 8);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2512,12 +2506,10 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
-    MemTxAttrs attrs;
 
     tcg_debug_assert(size > 8 && size <= 16);
 
-    attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
-- 
2.43.0


