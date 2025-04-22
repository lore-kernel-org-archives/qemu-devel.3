Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AE6C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR8-0001Oq-LK; Tue, 22 Apr 2025 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOw-0005AI-BJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00073J-Fl
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2241053582dso78326205ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350523; x=1745955323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWIZdxiQwNCWQMc8BJaWdVB87by5vfdybCIjbCIrMGM=;
 b=cQkOeeQsEXsFOAUHX5zrScD+bxUEiH3NGj0UaTMRjjerxUv8/zs3NCTzcim54hRqfF
 69DJn5FZVNm13H2nhiSv1UOgGoFBiqObgORe8UHd3T2+clFb51Nm3FTFY7og49ZnEaJQ
 hZbw9uECRtTZMbc3HKJySWD4ph7+RhWYh1/uapMsMjVqULBksTOIvAFB93orOagwSM2a
 BdCFhZyA354XBqs3T0/a80maulUJ60kBamKvDhSV7DVDBtW/LWymCYiTzxc93nJsgEA5
 BWgjwqUGJQN25NjVaTMX5xGIkU591WcyKE+pxQrQD1PMRu74aslOxjZ4BbCX5n2eQpgY
 +aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350523; x=1745955323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWIZdxiQwNCWQMc8BJaWdVB87by5vfdybCIjbCIrMGM=;
 b=sKxpdGonk5jtj2gIuYLiWBWtvXcZHJKce6aT2w6ksmSYNwwx1vgjUQRd0UdSPhFgdc
 jbfL/9MoM203wP0O0yH0dMGw5XWhHCHEUv+988Gap8tquUrhI2fD40tYafNh9vFSmUEq
 nH7CzLLDZ1cSD0eZ3EnGr6G+iF6D1vy8KsBVzVYFcVAlfYLVsUKDJYB0gcYx6UedtMsx
 E6EVQkUVMS4eU50Dn8IHQcwIjYiPoTdke9SGm8zdjwEzcw+KGQx10veoDTPSRzwvtSMl
 gLH/0Ogf8zf/0PpUbD84jnn/5tpyFzW74qA6hyLF6lJ7zqLyMpDEYG/c+k+AZdEkrvK6
 Biyg==
X-Gm-Message-State: AOJu0Yy3Mrqx/cRpZJiUn4+0mP66VXHuJbVsLYT/wf9EQDqzSkySi8sm
 r/zDWuFNuxpx9E1HT1P7NzeU2kTVbCepiIg8NDYasjdTVJ0neeCEbM3oC69GtiKPrsN9NkAESJc
 V
X-Gm-Gg: ASbGncv2mPiGooiExhbe5GpE3ze+E6w90c44JIE+IpE2XCzLvy4ruzpUBwOG2InF1hG
 ofJpI8oU2IP+YFaKqVA0Gz845B+jv1xDIKEQqIoXSZGEfPv/fGT3Sfx8iSFwbALPgaaa3yimj1F
 gjcIb7bkMiF5ldIV3VUj/rwKNj+m7/mEsJmMwZTNcMdLBMHx//GZeG55nvSh9s4X4HENoRYl25X
 EFeImIfP52qH5kcU29wa6HaKXPUqeVgoUTXENIhq9PNLiIIsYxGBnWP0/VTAlbkZdxJ4Ny4N/Mo
 4d94hqWMN5AavKYsxiH9LI37ejjti6i5oWlM4ioh+tYIwKUypuBKluMJo6CbCL5ISJ+Nw8IXaqV
 wSO/vGkaSug==
X-Google-Smtp-Source: AGHT+IFLPkvx9sskevhoXWNKW6yyX9vGAKFF7JzcML61kLRmefZJd9lNl6cz1XJ+aAHHM6vKMRdJow==
X-Received: by 2002:a17:902:f14c:b0:220:e1e6:4472 with SMTP id
 d9443c01a7336-22c5357f2f4mr185531355ad.13.1745350522932; 
 Tue, 22 Apr 2025 12:35:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 095/147] hw/core/cpu: Remove CPUClass::mmu_index()
Date: Tue, 22 Apr 2025 12:27:24 -0700
Message-ID: <20250422192819.302784-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All targets have been converted to TCGCPUOps::mmu_index(),
remove the now unused CPUClass::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-24-philmd@linaro.org>
---
 include/accel/tcg/cpu-mmu-index.h | 4 +---
 include/hw/core/cpu.h             | 2 --
 accel/tcg/cpu-exec.c              | 1 +
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index f1ca385d3c..e681a90844 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -34,9 +34,7 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
-    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
-                                 : cs->cc->mmu_index(cs, ifetch);
+    int ret = cs->cc->tcg_ops->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 29f6419050..28bd27b8ed 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,7 +104,6 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -151,7 +150,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 034c2ded6b..9e15105533 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1075,6 +1075,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
+        assert(tcg_ops->mmu_index);
         tcg_ops->initialize();
         tcg_target_initialized = true;
     }
-- 
2.43.0


