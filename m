Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0747C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRd-0003pu-J2; Sat, 27 Apr 2024 11:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRb-0003jD-HS
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRZ-0005b8-Se
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34b3374ae22so3404731f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233508; x=1714838308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL6dJhw+HNdXHaNBh4cOmuPi/pd0h9a+XY1hEoCa0Ns=;
 b=T+8GVxZp4+a9BIRCEOu/kqE08xA+dgwfDqVtaBMy3S5P66mL3S2wX2IFN2fMleM0gX
 HG0xY5TeOXq45j5eZYig2JfxDtn0Wg+wTOZIGhzxTY2gHiZhGb2tKOoLhaeCsYVuJvOQ
 bm1NXtwFwMYaGJcKdTCRnteF0OMZehT1h1DIm8P7tAxDUrlnDKw+Nb9HKFX8M61vpqmV
 Rn/pOKReAqjBC08gIcCPjNf4A4pEJtwcp7PcQnQxxydXXhio6q4PhYbLceeXYmoZu91l
 +HuY3mOok/oNYv73mtys1Uaq7aKCTmFMAe81L4XuYrxQkRaWme219DNVpdyt0fsJKEW+
 xHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233508; x=1714838308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sL6dJhw+HNdXHaNBh4cOmuPi/pd0h9a+XY1hEoCa0Ns=;
 b=NwFUECMoZ3c9qkyxIUeqcCLDK62M8m4rkWFh9LeQ+A/WtiJS0LlHhMudXZSxYDl+U5
 ipcmv+ZttzhqHINzdh6sUVj0FreCrJf1Ve/jzO/nFkkbOVQTpZi6X4BFUnRlzEaIv0iH
 xSJIk+NuNDfem/lEhxGo4gsBdNQ0YqZhhhJ9KWZ4UGQqVh8ZNw0d4dFu0T0CXN2k1pRA
 +wNLvmS1dRv7r8kQTYwYdEOd9OOFVycxNqyMF2Bs8GU54B+TaeZOwE753Lj3UKp3x9mV
 XGjkB8PBSapJ2e0/WpsRXm0yIwaG5BfRvm9AOSElODdugzSydqsc+OP/umPWeePYm3aX
 JNxA==
X-Gm-Message-State: AOJu0YyJjwRBcqQ8QXFgdOg765zUMOpxFaUi4gALDoLTymtArq+fwAOs
 OaszFCAMLgEoPkiKmZJvcDMTkDdzbQXFgwbTqv69oVpHCe+KTW1yiGJWqEwoL1mbadK8H/nthqc
 tVy0=
X-Google-Smtp-Source: AGHT+IGKbGbijsRGMA9OKsVwk+ZzDrJZSI0NQxaD/Y7lfxp25yDRxGkQ+ct59IG0UBDvW7xZr6utdA==
X-Received: by 2002:a5d:46c4:0:b0:347:f26d:c183 with SMTP id
 g4-20020a5d46c4000000b00347f26dc183mr5207045wrs.45.1714233507990; 
 Sat, 27 Apr 2024 08:58:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 z7-20020a5d6547000000b0034c9fa2c964sm1902228wrv.23.2024.04.27.08.58.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:58:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/14] accel/tcg: Reset TCG specific fields in
 tcg_cpu_reset_hold()
Date: Sat, 27 Apr 2024 17:57:13 +0200
Message-ID: <20240427155714.53669-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Rather than resetting TCG specific fields in the common
cpu_common_reset_hold(), do it in tcg_cpu_reset_hold().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 3 +++
 hw/core/cpu-common.c      | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 2c7b0cc09e..be99105ac5 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -85,6 +85,9 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
     tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
+
+    qatomic_set(&cpu->neg.icount_decr.u32, 0);
+    cpu->neg.can_do_io = true;
 }
 
 /* mask must never be zero, except for A20 change call */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index c4175cc4b9..9b3efba82f 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -127,8 +127,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
-    qatomic_set(&cpu->neg.icount_decr.u32, 0);
-    cpu->neg.can_do_io = true;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
     cpu->cflags_next_tb = -1;
-- 
2.41.0


