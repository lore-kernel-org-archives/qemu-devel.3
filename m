Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648F6C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JNh-0002VE-IX; Tue, 22 Apr 2025 15:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLb-0000Pv-4K
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLY-0006cC-W8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224019ad9edso79383765ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350315; x=1745955115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irulUe5yhLpB5KcHQZP5AkpEiKTl4QGB2IoJogi1FPE=;
 b=DYqiqaHP77MEVbtYBvLvlLf8iZZTVlcKLN2xVauf+5g5Fj0tYqA760SMXk5L0F2bu7
 Jh96z9T2twOJPUmm/5n73OyugDONMuk3jiMnckRLddWWTWRXjkKT2zw00YxnLJ7xgHGK
 wiIQCc9B7FxvmfBNzUlUVXs9b+lM3NVP04/KWijmQtLaiPvdiYv7RTxSmAexTbUxTTJn
 8xowAWhVvHVcJ0eU1LqKxJMjq38V7KC5yyS1T45tjhdKtA8EZ6ktAH7jNV6Gp3t30Q6W
 C+nSkRpZEqZ+sHPykSIUPDS7+Ux7rYl+f/pr+/POplPR15O3TKRSPn85cgK7w150NsZ3
 2KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350315; x=1745955115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irulUe5yhLpB5KcHQZP5AkpEiKTl4QGB2IoJogi1FPE=;
 b=SkRjGnsjFhSqyz15zYkKT37sWseVyXw1+BpUUQtwyqkFI3yYjheCS8hyAcu5j61lum
 +NF3+iT3di2RYowrlyjYOPIkkqoEu8glg/UYGleod06iDIDkmiOUcILPRM9hZ5h4AQHX
 UAkA/CN26JXKhCjGiDLE1yh3ni5zMJnIY40pVDJX0J2cxOec0Z1OpW8eH/nGGqAv98hg
 5NL0eddmYNhjuCZR1/K3oMLW6ygEfC7FRM1wYiUuD5BIDs1YeFu+eOIOaH4jkQI2ZK8l
 2cYs2IlsaHj2jREfyJf1nJuZjepXW62ArRooxVegGrka9s0pMJevFa4tbEZDN+Qc5EaA
 xL9g==
X-Gm-Message-State: AOJu0Yya3bgfbF4Vu7th45vQpYlLjLemeGu/P8DsY1heF2uZYIeBtwf/
 ugh6VEHxe6BUemrY3v7t994o8c3olymCF4fyaIM0lBN+rob3RiPPpJPAEJuAR+alr324zwmhZYI
 R
X-Gm-Gg: ASbGnctMa3RRTAxq9JVu76IQwfmIRKYzXLIn0U8nsgRdZYbt/Lt37oKi/Yv4eyW1JJt
 RWLgEJ7E0fn6QCC3drnmyjv1/97uCnrmf9NpgIU18xS2JLm4l1GForZuCK76dxCl6oVPzWyAWwW
 DH99f1iAL+hnI+K9SeuY31s6GYLUzIZCjmSHNZVf7Azqnt3t5COBDVnKx2kP/TGWB6BC8VbpNK/
 0K3jHNAeD9Ukuik6f1gKLVHtOYntLbAZqMSrVX7Ixh6h81pDPkRl4IcXO82nLf8qyD3vgn9hBgC
 TM/NDtmm84qQkdTlMDdc7j06w1UJLtZ4ysiytqul8co7Vm7L5TcHIZCvwZoRPjhr4JlVeqvPdMc
 =
X-Google-Smtp-Source: AGHT+IHtPj4R7EyOUmnoWoyNWIZO6ISVSVgE8tdqCadX6K9U7y+PugR+syluxoHOZdiSqzLoVLGPBA==
X-Received: by 2002:a17:903:19cf:b0:224:5a8:ba2c with SMTP id
 d9443c01a7336-22c5364ed5cmr227665905ad.52.1745350315268; 
 Tue, 22 Apr 2025 12:31:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 052/147] include/exec: Drop ifndef CONFIG_USER_ONLY from
 cpu-common.h
Date: Tue, 22 Apr 2025 12:26:41 -0700
Message-ID: <20250422192819.302784-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


