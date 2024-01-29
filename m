Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766ACC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUahL-0000iy-Ax; Mon, 29 Jan 2024 18:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeK-00071p-2a
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:03:00 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeI-00006Y-4E
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:43 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6de2f8d6fb9so897969b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569359; x=1707174159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tMFQE97q4aUbL8LMPU5R9Llk18uVwdymUNm4iTykmc=;
 b=sooDS/uM4hC35MJivQ+xbLeHExTRUUbNzAy+KZnJ7DtLon+X5/urcmSyWQFg91YeYP
 ZYCTHEkVwzcNDTZw0MbMzgAn2iOy1SmMW1E6WstppT3N6siseAml50b1a2IxS9M7ajXz
 C+khQ9otXwmdL+ZqBdYCmP7qvVp0r36/XqMQx7YmZwx0IGpHE8MSIPAvqoCdrzzT1J/g
 Hyq0VVz0q22EkhMyW6D/SF6ERHC/lgQG79iDRpCJEVCzdUKV30X5yxuxPkTzMx2XuWMP
 aUNGeQtNFuUXWAapx2wPK8lwPd9xiSeCB9WuBOsCwCEPuumxZGtv7nGL9PvrcckMx2pJ
 eqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569359; x=1707174159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tMFQE97q4aUbL8LMPU5R9Llk18uVwdymUNm4iTykmc=;
 b=UI44gmW1ihA39Fkc4M55G44eWi4zt1sUewU+O7RAD0lCRraRE6J3k8T43825/3w4M7
 mlquyPCe7o6/VDv3AWnANkc95BfPC4hf+lLEQrL2OCOptiWNKKH8Wc3Kjc8Z9XI4H/fk
 p0AtLObsIXWEJ0hYQMA09Q0OSl/lzWuuB/bB/3uC0o2Nu3eQmU660lvh048qRYK0RGCE
 UMmTYUvdHeP3D1n+g/QsCR9QOTMco9AD+V7kuKfP0RoYqQZC72LTpKbl2V0zsmhbAC/h
 UiLPcroMAzu9AIqZ8a4iphGoVzm+iqkqkC2yCvAEVEK0polqesjPh+rDdO/TEyPJ1oLV
 VgmQ==
X-Gm-Message-State: AOJu0Yx8IJAAoyLY8TkwRb6qm67sEJe+WlZc+ZETOiTu9/E8Z94AEs9y
 AGEkNNX+ParrQBk2Vh3nL0oX4Qm+u1u3kBKEKm4eRKY7NBFHoqx/Z5HpVIxzcI96ekYoEp3A+FC
 fcLs=
X-Google-Smtp-Source: AGHT+IFfutpfShcyJ0cuGZWntYac7/5yuWGYaPYWZfxlzCJoQhEODJG98KYt1qys665/99btQvbf5w==
X-Received: by 2002:a62:ce08:0:b0:6dd:c135:54e9 with SMTP id
 y8-20020a62ce08000000b006ddc13554e9mr4690929pfg.9.1706569358976; 
 Mon, 29 Jan 2024 15:02:38 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PULL 28/31] target/i386: Extract x86_need_replay_interrupt() from
 accel/tcg/
Date: Tue, 30 Jan 2024 09:01:18 +1000
Message-Id: <20240129230121.8091-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move this x86-specific code out of the generic accel/tcg/.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124101639.30056-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 accel/tcg/cpu-exec.c                |  4 ----
 target/i386/tcg/sysemu/seg_helper.c | 10 ++++++++++
 target/i386/tcg/tcg-cpu.c           |  1 +
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index ce34b737bb..253b1f561e 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 34d10eb173..2eacd694ea 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -773,13 +773,9 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
  */
 static inline bool need_replay_interrupt(CPUState *cpu, int interrupt_request)
 {
-#if defined(TARGET_I386)
-    return !(interrupt_request & CPU_INTERRUPT_POLL);
-#else
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     return !tcg_ops->need_replay_interrupt
            || tcg_ops->need_replay_interrupt(interrupt_request);
-#endif
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 1cb5a0db45..e6f42282bb 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -127,6 +127,16 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
+bool x86_need_replay_interrupt(int interrupt_request)
+{
+    /*
+     * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
+     * "real" interrupt event later. It does not need to be recorded for
+     * replay purposes.
+     */
+    return !(interrupt_request & CPU_INTERRUPT_POLL);
+}
+
 bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 8e148e9bc4..5bdcf45199 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -123,6 +123,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
     .debug_check_breakpoint = x86_debug_check_breakpoint,
+    .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
-- 
2.34.1


