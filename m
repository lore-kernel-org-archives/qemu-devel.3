Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F100C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP1-0008Rg-2c; Sun, 04 May 2025 16:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOt-0008Ng-FR
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:27 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOq-0006wv-Fk
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:26 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af52a624283so3180004a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392242; x=1746997042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8PKPlYK09WrFi4XlR/wFHCWNHO85sXDuZWr9mCY9fo=;
 b=oioSdV3WtJdeONp3rNX0vTHJ5Vp5MvGG0IvEpDM8hjbc2qSM97K//XycXeU6LAgQLq
 8aK3yhQULz/FmwldRrNlMLEYM6U5VvPR/2xShw0223f4x+Sxu/lofjvZQB4o+yct7h70
 hiyz+qRQSHf08+A0qvMTFmtFn1yJTAIW83FSQD5GJTiXsPRAehbdmTDgihA43pePIslm
 VPp5wOZ3fvrlyeskAsRm19foUOkK5ym5jN/HVsZOwqG9fIrcJtqASwTdsgIuWwE86tgt
 jJlLEyKoOTldqsfaCCxauVahjKN0safbDOnUbWRsYxm6h7z8GJMd6BeSxpttcq2sv1dN
 O8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392242; x=1746997042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8PKPlYK09WrFi4XlR/wFHCWNHO85sXDuZWr9mCY9fo=;
 b=NB5pUHly7X2SODFGvsqTOoH6/Ccb7S22sARHqAyEMQOvXoG960Hc/SNM1W4Rkk4PLX
 MGeWL46mXyiPWeGGwzAQmH/b8cS8TNhbz24dGG1EEjbKBhcqMrURrd7XTsI0kOGsisvf
 Wkp6KZxu3Q9jXAU3rN0GPSsOiVoQ2f+wTBteSPrg5o1rqXx7V4e8JiKVKIazmIjRmEK6
 DeBEw2lRfb3Zh4216qVJXyv/1bQqvurpQ7pJJIobGkwhF4/e0KwRVPaGtA9eEX2qaUQx
 y1GfuflPwsvBX3qYM5icO0/hVmMMAtxdTatF3rfYE6/9ge6nRPdjxuO2WhlOgyvB+Alx
 JhJA==
X-Gm-Message-State: AOJu0Ywh8qViqptw2qiy6VedqlEzguw0QPxyQPjxfOld22x86MNhprgc
 1BNKXPc+jWahpouUuxat75iTY1Bg158k6mReLTMaa1ts3lNyfSYsyYldZleuY6OmGIVXQJd8UuF
 k
X-Gm-Gg: ASbGncsiOGYP5/bIo94WZYeuvazHvIHb8OtQ/4ej5tmW+yEpXJ9LyevNpvUllUg1AG2
 AaJe7qVVvLVDtTBALVmbIUr2gX+j8AXviADWXc+prWVXG+7Y6wMkECQBTlcHePGq0+qwYmDb+DJ
 kATt+fO+mXwdFlXGDjh/pmPDNpdIXOkuBazfvVl/fvYHiyfGVzGUyWhEiUuULOGZwKhCv1Ev1ax
 c40dh3wecx1T+ugSNwOA01IuKaWLg24QopF//yZci+FkF1BGyvmqkXrNk63B54S+DfCVhogqZzo
 UbnorM0QjCmYT+fJQB3fw+CcXx7C3AN0b4c0P6yvw0OgGqbi7CvvQZ+jd35kBFwItAgpOORVQ5Y
 =
X-Google-Smtp-Source: AGHT+IEUxDUEoQT8w3vetFSvMvmzAd6lb2O0tHd0sTbyh28SINPAAcwY5QsonUZD1Z2KB3y1caELaw==
X-Received: by 2002:a17:902:c40a:b0:223:4d5e:7592 with SMTP id
 d9443c01a7336-22e0864839amr228972965ad.21.1746392242083; 
 Sun, 04 May 2025 13:57:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com,
	qemu-ppc@nongnu.org
Subject: [PATCH 08/12] target/ppc: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:09 -0700
Message-ID: <20250504205714.3432096-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Check 32 vs 64-bit state.

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index cf88a18244..1f18967b62 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7386,6 +7386,12 @@ static void ppc_cpu_exec_exit(CPUState *cs)
         cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
     }
 }
+
+static vaddr ppc_pointer_wrap(CPUState *cs, int mmu_idx,
+                              vaddr result, vaddr base)
+{
+    return (cpu_env(cs)->hflags >> HFLAGS_64) & 1 ? result : (uint32_t)result;
+}
 #endif /* CONFIG_TCG */
 
 #endif /* !CONFIG_USER_ONLY */
@@ -7490,6 +7496,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
   .tlb_fill = ppc_cpu_tlb_fill,
+  .pointer_wrap = ppc_pointer_wrap,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
-- 
2.43.0


