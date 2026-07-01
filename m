Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B870FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG7-0005tV-GA; Tue, 30 Jun 2026 23:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFz-0005k6-2J
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFu-0002qk-Pt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:58 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38060005f1cso693833a91.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875093; x=1783479893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrBKBJVchBCsnuGqTnML8QX4SdgBpucyvwuWE2i/qQ0=;
 b=cyaJ/+Iv2N/zzmGwL5ThDoNg97mEktKcrnG80lU+hMuMbMo+5rP4eOG707s1kAIpUx
 TpXVYfnZINCok9kiNJ6C+QPPg70qFz81+bWseR9GkckqFWYqD1Aqi8cMiKUO0oeAB7Qw
 juES6IVDi7kdbKB0/X/NyMl4u/ngK742VZOkfylZGiNm5IwiYV8jRHHtr0Wc32kwOINf
 JVPa/AA4gZxo6bl/i08v1qiugixT9RFJRlpLekMZjPwaj20V+GroAIbNoiUb/WAXMDUf
 ths8JYYGvTy5hCjcJmd6D4Qil+9+bE0DOcPDHEI6F0MMFDlaLX/bWGZKJRrJu56WWtmd
 lK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875093; x=1783479893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yrBKBJVchBCsnuGqTnML8QX4SdgBpucyvwuWE2i/qQ0=;
 b=lCTG1ULf/787j97cS2kxu638Y5+FKZCe2vX7ejAoyp9f8cXfZvKIes8SyNe15ODS2E
 RN07B3CR6IxOa1cTfBhqQZCyWqL2azKvB/ib6hpU3oWv3DCjw7arAxIPrYRVBA15fjnQ
 OMxjof/dbB0aGveAM4y/SrqSXdbQHRP8UOGdr7JwmYfoQoW5vmSh8GjeJEkzQmTi5Xz+
 KStbm8+lzHyMojTJpBLVFy8n3tSn9UtovmD7hPgpY6XaWJ7ObmEzkH/GAmwgLx524Y8u
 YhNMsmeVQBsKTDMUP7LL2x7Pjf7D9+27p9lT7IpTg7qhou22XiD2D5TIDBlLFycIl6wL
 8W3A==
X-Gm-Message-State: AOJu0YxxYfDmeir1b6gy+WherszEkaNcm/N7x366Zjc6hA2EbKG6KKto
 38Y17v5aTtyqaqfKa7bEUHezglNoZMbwraFAA7uAmp8Bq99sIFiB1DzNXIJ/3VcBElTiejiWWRe
 Bqjj7
X-Gm-Gg: AfdE7cnmY3wamsEID7pHE0h8izaq0Xy8+wtEg0Fp5XOs9AJtus8pFMLvjrumaCE0ee3
 iLxkCCn+F6bRHx+v0C574ZzNMNuDxIGB+OVcqW804Nk4WRLz/ogBYvtNaZ9Oik4CPWWEcozCMiV
 ickcYp5SaAyFxz5tSEwyYboqz5vAlwc8wwlbASDH2xRHOg2XoW7oSTz18p7wHUgVYv64daq7Ace
 s8jN7MQmjF1kQiHankEneAwnIpFeggtVmEtGZqo1npY6zdxWFuA1f2FSBEXlGgSVEpT01bBmxk3
 M6g896jUT35k+0Mha2fXX3SyP95+xi/Kr42Z+kr3p7ebXvIE5cVDGPt6zJyEL0tuX1OEufUD6/f
 nur+2tgJrEWHlSUUm4abu796R9q0yFsn3G9TcOeCpBXNagWEuReT8UOZX0GPDgxPJoh/MdZ/6bz
 8NaLDg/HL1rfnCLjRw5Rxd7xRJlZSRbDvJ2XmnnsFceYH8WegJUcualSQGToBH
X-Received: by 2002:a17:902:d2c9:b0:2c9:b017:8bf5 with SMTP id
 d9443c01a7336-2ca44a05333mr34401565ad.21.1782875093157; 
 Tue, 30 Jun 2026 20:04:53 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 10/17] target/arm: Set ID for watchpoints and breakpoints
Date: Tue, 30 Jun 2026 20:04:36 -0700
Message-ID: <20260701030443.1382447-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 51d6748427..8bcce4a1b0 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -538,7 +538,7 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
     vaddr wvr = env->cp15.dbgwvr[n];
     uint64_t wcr = env->cp15.dbgwcr[n];
     int mask;
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS | (n << BP_CPU_ID_SHIFT);
 
     if (env->cpu_watchpoint[n]) {
         cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[n]);
@@ -644,7 +644,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     uint64_t bcr = env->cp15.dbgbcr[n];
     vaddr addr;
     int bt;
-    int flags = BP_CPU;
+    int flags = BP_CPU | (n << BP_CPU_ID_SHIFT);
 
     if (env->cpu_breakpoint[n]) {
         cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[n]);
-- 
2.43.0


