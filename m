Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB03FC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLi2-0001YT-LQ; Wed, 29 May 2024 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLi1-0001Wy-Iw
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:59:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLi0-0001ad-0g
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:59:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5788eaf5320so2647958a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998361; x=1717603161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l2RowXhHBbxrob+0bISMh+r0iXs06Afi5Oflt9v9bTM=;
 b=Byt6XeU3+sXdnt4xqp9RBMenGNNGA6BS2wQFeVrZRDVUGTRwTaH9msto6xD9CwPFxO
 DE9iFSemWV5SNHySLiHDCZGJz0VktJ+mm7VfTKEwkwNB9kDfEWSBTWXm/SnALab0xSXj
 Ex3hr+wNz7knKjBRs87tefrANLOVTH22FO39FG4rGrsLS8AN2PPLBOYgwT+BCqYYTP4U
 vrVTbExq+jA20WbGODmyMK3YW6Y+2slCALLySqvQIBv2h9/CrQ+5TRrvN+FFPCe8Hwnz
 t+Ox5NydrMIRTQFJe+9FIBI5zm+m2cp0HxeeC3PSYibfdzCoS4wycFyTxd8HnhiRkErF
 vQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998361; x=1717603161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2RowXhHBbxrob+0bISMh+r0iXs06Afi5Oflt9v9bTM=;
 b=fQ1927byyGBsrAnNHCOe0UoQRWQxdOptuqdrhqUQ7oGXfRQXrQ3qyQSKNUvmh4SabV
 8WVjVjTKOhGWlCYdxYdslbMCNBQeoj5zUJWBJt1UIYAEFt718UIZpxm7gVx3MWXRrgfc
 mf8l375Ee0Sifu8duQZ8fRpb1CuaiXrcna2DJ5nRJs/L7iMQkoKL6wSOZBQWdCV2iZSk
 s5z2fcqL53LegZtNcr34iZPJuyasaI0DQXZ05x+k845zZ3Q5Eo97UJ1EE4FTjVIzeqaa
 ybQudWOO5s/9gq7Gev9OpK2BogJz0BODWFha0LxuVsxAD2vIOFq+haijE0d2OweemX3Q
 VQNQ==
X-Gm-Message-State: AOJu0Yw0N2AMtJKAvyGg3jW1sYHjQ95LlGayo7K+VvaWUV14/1SiafLC
 ewbku979MiKvBVufod2mBpxKWL38foxEWhnLW96KVZeOOiTP/MbssQ5LqqWuCU9HTEKh1Mvf+sb
 I
X-Google-Smtp-Source: AGHT+IFcuNO1RSdGuGzraSWcMfaRtInk53BI9nXYPpEA9l2ujhM6/vcBG/3wjP8uDmADKc3KCuMcMw==
X-Received: by 2002:a17:906:280a:b0:a59:dd90:baeb with SMTP id
 a640c23a62f3a-a6264f0ef79mr1168884866b.48.1716998361018; 
 Wed, 29 May 2024 08:59:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc519cesm728607366b.113.2024.05.29.08.59.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 May 2024 08:59:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel: Restrict probe_access*() functions to TCG
Date: Wed, 29 May 2024 17:59:18 +0200
Message-ID: <20240529155918.6221-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

This API is specific to TCG (already handled by hardware
accelerators), so restrict it with #ifdef'ry. Remove
unnecessary stubs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240529155548.5878-1-philmd@linaro.org>
---
 include/exec/exec-all.h |  7 ++++++-
 accel/stubs/tcg-stub.c  | 14 --------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b6b46ad13c..72240ef426 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -301,6 +301,9 @@ static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
+
+#if defined(CONFIG_TCG)
+
 /**
  * probe_access:
  * @env: CPUArchState
@@ -357,6 +360,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        bool nonfault, void **phost, uintptr_t retaddr);
 
 #ifndef CONFIG_USER_ONLY
+
 /**
  * probe_access_full:
  * Like probe_access_flags, except also return into @pfull.
@@ -392,7 +396,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
                           void **phost, CPUTLBEntryFull **pfull);
 
-#endif
+#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG */
 
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
 {
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index dd890d6cf6..7f4208fddf 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,20 +18,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-int probe_access_flags(CPUArchState *env, vaddr addr, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool nonfault, void **phost, uintptr_t retaddr)
-{
-     g_assert_not_reached();
-}
-
-void *probe_access(CPUArchState *env, vaddr addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-     /* Handled by hardware accelerator. */
-     g_assert_not_reached();
-}
-
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
     g_assert_not_reached();
-- 
2.41.0


