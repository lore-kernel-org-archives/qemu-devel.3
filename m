Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD8DEEE270
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotd4-0004lZ-TS; Thu, 12 Sep 2024 19:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd0-0004Rn-4U
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotcy-00088L-H9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so1175204b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185211; x=1726790011;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKczBHanLSZvcjjGDp0D2cgwbOL2pYUmrFfrlbX195U=;
 b=kYAScM9+2kP7igid2xZO60ej8ViD/1YK6cvgIqKfHJolAW4j9WcDDCpFBSXDv94L8M
 TptRgZyHAYmZ9F16J7vM77O9DMPK2iAEoKWMGbHXTZSZYFvvlzxmkyPHY7/2w8bWBpEe
 wjM4xr4cdFw/EQ7X0yeNOVyFMfDCd+X2+LXXlS3z5bMZC0YmvP6hWe8uBvI0mDyib/1U
 kD0vU6c1AiCkLplCnvFpL8csp4L4KCK3PhYAHER7i88Au2OhhaRbvdeQbnR66Oogq2ti
 Mbuw1MEaDcODgknnQ4rK4HCI6NjeXkP191j4E01L/Ghk3cn6U49VoOdhYLYZUsl7J/Rx
 fMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185211; x=1726790011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKczBHanLSZvcjjGDp0D2cgwbOL2pYUmrFfrlbX195U=;
 b=MTcMVYJDj8rU5yvvggv6n5wb9TEQzGeAKx2KcAQ6wxqyo65AV0FvfK6Coht9Q+J4Be
 W9f625B71P8zFrkkmhZuwuR6/2Ti615vlUbm34z/QKhBG9cOH23ywrtIsTdjMaX4iUOL
 RFktyVxNzF8eUsDMjmGirIZifWag0hLEcUzGfquCGTHyWNuB7eNDrB/Y28aTFWIo/mJR
 XF/06MnR0T1e3VDniaXYQDQA0LbDcQTmmwIZd4NCuaD4sPu8J3ufHKinZcRQMBEOSA+J
 +Kzc87NO9hZON7ESN4yqF38S6kVH2Lhi6Tzl9RSDFicoPHvIrUo+UQBiklxx+7XygpcY
 OIpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjT3Mys+onY7oWi7bTOUCnao+H3f4mFp0BGoiS4BndoTbeiK/2Ti9/c+vYsxEtjRIfid3JBcCo4lyF@nongnu.org
X-Gm-Message-State: AOJu0YxNuRXXpuhoTfFADSD8mogNc8s7izzU+gGNBMROuK2IxE6N3Ko+
 EclMhlfX66/uu7Dm2BbHZgNEWSUnNb7n9Ym1JvAKZ2lrPSxJZd717dOgkOAvtUQ=
X-Google-Smtp-Source: AGHT+IGim91aSRG5N+S7DnK/re7jlC/4e141Sy+7wqe3HedhlLeGJW649lVOXL7Rbkf57ojzZcvmLg==
X-Received: by 2002:a05:6a00:1953:b0:70e:a524:6490 with SMTP id
 d2e1a72fcca58-71926063f80mr6369964b3a.1.1726185211124; 
 Thu, 12 Sep 2024 16:53:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:30 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 05/20] target/riscv: additional code information for sw
 check
Date: Thu, 12 Sep 2024 16:53:05 -0700
Message-ID: <20240912235320.3768582-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

sw check exception support was recently added. This patch further augments
sw check exception by providing support for additional code which is
provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
sw check exception is raised *tval gets the value deposited in
`sw_check_code`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/csr.c        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6c5e199e72..dc33604b13 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,6 +232,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* sw check code for sw check exception */
+    target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d7b776c556..8ad24ed2a6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1766,6 +1766,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 cs->watchpoint_hit = NULL;
             }
             break;
+        case RISCV_EXCP_SW_CHECK:
+            tval = env->sw_check_code;
+            break;
         default:
             break;
         }
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 57cef9e682..919de7970c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1377,6 +1377,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
+                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
                          (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | \
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
-- 
2.45.0


