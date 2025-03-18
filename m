Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZU-00037l-Ut; Tue, 18 Mar 2025 17:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY8-0001M9-RF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY7-0000qU-8M
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-226185948ffso53430975ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333554; x=1742938354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irulUe5yhLpB5KcHQZP5AkpEiKTl4QGB2IoJogi1FPE=;
 b=O9C5MhjKpM08IMIyI5ap8kbMyvxG/1FVDnVF68zhznqTtGomdf9eMAQPRqMOciFk1y
 m2Jqfy6TgniM2WfElnI5rCkn9A0536X56RSGDCj9f2nsLbli+vfnhwpnt7KKN//Go8NZ
 SEhMZfBXMisZNh7kwH1P37rv/qewuC+iIEWk7BkH4hhpigtM1nbYtezuL9JnPYa3RbDl
 93G+oqWxT00Z29W1/eFnEkC8a6wVGvZaEbU9UekqeN5+z4HS5tjL+AqS1nGmGJ10QsR3
 XI/fUCnPRAnbnMK9tSTq4+FryxyMndcdGYluAWywh4wPIeup3DLKW0tzeOXnnbiRUnh4
 gQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333554; x=1742938354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irulUe5yhLpB5KcHQZP5AkpEiKTl4QGB2IoJogi1FPE=;
 b=Z5ozO9cuw3oN0jZydASpA+6me1fkdE0BjzRhdsa7UjtHYnIMHPyFiOrX0PmLGo5/3i
 oN2AgYu0HfujoTU07FlzZRj1VXCIZMWEnu1hWxoWJPIxKVI6Nh2cb9wleIXR4t8FB0JE
 CyRsb80v/j2oU/zC1R/uwqTexeRtb5v3bgBU/fid932Mytbi9ecBgD6NITGgi7cf3axz
 /oZejm7IZq+xep7JtaC4DQFbDXqVgWTUnyUtgYTj1WHSA8ng230WXlsVaeMcOF1erHHp
 7rU4+Usb7zyPryxNo5QpC+lzRh9iMSyIH4WAjmMjSQgcCx4Ayfl7woF814Lw+JVN8xa1
 DM4A==
X-Gm-Message-State: AOJu0YzEuDeFgkTL+QiJaPcgNE5pYjiOQsfQAqjM2KHALqYmpKtoCL1S
 B5n0omQcrHC93bYnIR3QtjUuUaPUTxGLMzHRuiItcEEVCSsFCZffI271bmtpir3ImBBWsWYNMIr
 i
X-Gm-Gg: ASbGncuglFkp3lUHEs0n3/SiKcKUoHoXxlOmUkitII9uqD8AZj/wX4/Dfnera0n/E5/
 lmoQBfVPcwfDznaJvHNRVnl71TNe9JxscmZzWt6BjcI3sYMJ44wvLqO95VvE/dB/Iovi9J5X9Sk
 BMsXxB8FDJlhCgRkUM5O+ydNCqU5H0sE6L2LuZVZjTNMP874lYQliVoLKaS7E/VZqrNdrM2jhwj
 PzrK5DvcrcLTAHbRUO8oz+rhDxOZJ4cA/BFmPiSiILZDlk3i41H8fGj6KxfikoMB/8QYv3VRkBk
 u59dke7Qqjy+DM47TeLVbq1fJqyYNPZqfFaomgXplmOiVOdq0eMDHTftV6NXKn8qhDTkN7j5Q2Y
 A
X-Google-Smtp-Source: AGHT+IEo3Ne8H+mbeeMlRZtU8rNcfim5XGehZ0n+olMowPBVZ9HL5mEOn1QeNyJ2nbUDgPzL8KAv8A==
X-Received: by 2002:a05:6a21:7888:b0:1f3:418c:6281 with SMTP id
 adf61e73a8af0-1fbeae91352mr303047637.4.1742333553743; 
 Tue, 18 Mar 2025 14:32:33 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 33/42] include/exec: Drop ifndef CONFIG_USER_ONLY from
 cpu-common.h
Date: Tue, 18 Mar 2025 14:31:58 -0700
Message-ID: <20250318213209.2579218-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index be032e1a49..9b83fd7ac8 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -9,9 +9,7 @@
 #define CPU_COMMON_H
 
 #include "exec/vaddr.h"
-#ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-#endif
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
@@ -40,8 +38,6 @@ int cpu_get_free_index(void);
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-
 enum device_endian {
     DEVICE_NATIVE_ENDIAN,
     DEVICE_BIG_ENDIAN,
@@ -176,8 +172,6 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
                                         size_t length);
 
-#endif
-
 /* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write);
-- 
2.43.0


