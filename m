Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32495D65530
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7e-00077j-Pm; Tue, 26 Nov 2024 12:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7X-00075x-O8; Tue, 26 Nov 2024 12:13:04 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7V-0004GW-Rd; Tue, 26 Nov 2024 12:13:03 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21288d3b387so44431295ad.1; 
 Tue, 26 Nov 2024 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641179; x=1733245979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZNPYSPlNBAIgFECBRph2WnB34JU07BYLZNqVQrL8CI=;
 b=J+51+qZ6YkFk5Wh8hLAQ3CuO5ad0ksA+ykLFriBV6fWpYxGc9Yfp1PlberSRJ2X/5j
 ToOlw4B71eiwUvYhgz7IwvmVsD5pGYXKAla4Kirj0T/FVIxHb+qOCC/1qnIPS7tKCYJu
 AZpWuo1NM9f2UW3/BbyzJTBI2XPOjrTUL/jqRinMfRVyvXcqtbDNeS4/EyLzL3K+sgIy
 tsnd64wodAz+u9HhbiVNsZral85dEyJlAnqCGH3BKK1K7f81LvK98ztAgvPQlsWpwVHU
 PlFtfarezwBCxRcHKSKX6+8TyHiy0lSYBOw2zzAhydz740YcNtgZ/pnOJ4Y1rnuyMzQZ
 06UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641179; x=1733245979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZNPYSPlNBAIgFECBRph2WnB34JU07BYLZNqVQrL8CI=;
 b=QX/YtGlmURVHUzGWpNDSN3oRQ2dNuK8qZyVGIbS4PjM91/DQIbBN3GUljPm9gTlvQD
 GPD1WACxalHfy2hpteqWflKQyYr1JJNtO3Bb2HzOtbnKW9eF2Ej8sfXA6XNEJGjtOGQ1
 nmQhwweQOwpY376k/B9Y1B2X9apdo1qnM/SwaZda7AdnoTI1VxcNeuFJ1RlOe3He4pou
 2FGB7EF0GJz8s0cZoYGAUaNigI2//5R6riImDwPT37uyGE6XEXmBojHRMyZDdkQszr8K
 qbmvFVYp2HuGYqvnYRObXZlHpxtnrBvtGrHR6c6D5Rj+Q9uQ1RT4DQ1dir3j+HDI0W6L
 AV/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX+HNqyKZqeSd9v5x89rj6sKLQaH1B5MzPRdWCW5wNHA3rulOlhpQ2oTlaAXe5lUsLv0ac8jcBpQ==@nongnu.org
X-Gm-Message-State: AOJu0YxiEr736MJh8v42v6VCrLXjE+5jiJGNPGyvMnhvNHcmmtdFmLFR
 xmeo8BrDpcTEPUYqQytPx8rXlSD/l7cjLqzPmZcn5ImjkAD4W8Fu/BiMIg==
X-Gm-Gg: ASbGncs59/u+TCWAlwiMmJGonyvQnz/Au3/zIxprPmFXKqLAkckK6VnmwmBtWaLB8Qw
 qxLSnv7pOxKa6Sl99TN0ZSBzyu/C67LRo+0KHZpfDHDjN+tKz63WnegC8r+SAyPBw4Ibfc4Gctj
 ApX4SuVWmQwkr3ieaXmn7tKNJe1IfTZjtLKsGMVWLhFWT6fqtL8tjt/nXzyt4vxp6A/VXxuBGBp
 M7FdMgUnYc7yG9heUkiIeFELYQ7uZ8H0EW3h3B/D88V7yz8YEC//KW+OqcE3oQ7FOslC+gZ9HzV
 DbiwZg==
X-Google-Smtp-Source: AGHT+IHoYQQnXm2PES9Hc054dxAUMVzvfXyo3fLyUP1OW4mFn40WyVw0IAn1BkJaRigBOji6G29mpA==
X-Received: by 2002:a17:902:e5d2:b0:211:6b21:5a87 with SMTP id
 d9443c01a7336-2129f6b909dmr230132035ad.56.1732641179386; 
 Tue, 26 Nov 2024 09:12:59 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:12:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 2/6] ppc/pnv: Fix direct controls quiesce
Date: Wed, 27 Nov 2024 03:12:31 +1000
Message-ID: <20241126171235.362916-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
References: <20241126171235.362916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

powernv CPUs have a set of control registers that can stop, start, and
do other things to control a thread's execution.

Using this interface to stop a thread puts it into a particular state
that can be queried, and is distinguishable from other things that might
stop the CPU (e.g., going idle, or being debugged via gdb, or stopped by
the monitor).

Add a new flag that can speficially distinguish this state where it is
stopped with control registers. This solves some hangs when rebooting
powernv machines when skiboot is modified to allow QEMU to use the CPU
control facility (that uses controls to bring all secondaries to a known
state).

Fixes: c8891955086 ("ppc/pnv: Implement POWER10 PC xscom registers for direct controls")
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c | 9 +++++++--
 target/ppc/cpu.h  | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a30693990b..cbfac49862 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -217,8 +217,8 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
     case PNV10_XSCOM_EC_CORE_RAS_STATUS:
         for (i = 0; i < nr_threads; i++) {
             PowerPCCPU *cpu = pc->threads[i];
-            CPUState *cs = CPU(cpu);
-            if (cs->stopped) {
+            CPUPPCState *env = &cpu->env;
+            if (env->quiesced) {
                 val |= PPC_BIT(0 + 8 * i) | PPC_BIT(1 + 8 * i);
             }
         }
@@ -244,20 +244,25 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
         for (i = 0; i < nr_threads; i++) {
             PowerPCCPU *cpu = pc->threads[i];
             CPUState *cs = CPU(cpu);
+            CPUPPCState *env = &cpu->env;
 
             if (val & PPC_BIT(7 + 8 * i)) { /* stop */
                 val &= ~PPC_BIT(7 + 8 * i);
                 cpu_pause(cs);
+                env->quiesced = true;
             }
             if (val & PPC_BIT(6 + 8 * i)) { /* start */
                 val &= ~PPC_BIT(6 + 8 * i);
+                env->quiesced = false;
                 cpu_resume(cs);
             }
             if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
                 val &= ~PPC_BIT(4 + 8 * i);
+                env->quiesced = false;
                 pnv_cpu_do_nmi_resume(cs);
             }
             if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
+                env->quiesced = false;
                 /*
                  * Hardware has very particular cases for where clear maint
                  * must be used and where start must be used to resume a
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 945af07a64..0b4f1013b8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1355,6 +1355,7 @@ struct CPUArchState {
      * special way (such as routing some resume causes to 0x100, i.e. sreset).
      */
     bool resume_as_sreset;
+    bool quiesced;
 #endif
 
     /* These resources are used only in TCG */
-- 
2.45.2


