Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B091C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TgN-0008Be-5h; Wed, 23 Sep 2026 16:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg1-00089D-Fx
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:50 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tfy-0004z4-JM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:48 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469f20513so815960b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195685; x=1790800485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Uzkz0z5JY8Ir0rwhVI5vUhBCQXwPjRF+rHrxo54Kew=;
 b=YxvHo4uPHtCizgQWXE+iXvcyzO7ReBDhrCZWrZ6ZECY9eknt7555UwCqh9lunMjUdH
 iNn0kSNLEVhLD730U7FNNECfk8ngsOmNm5k8Wl1MloDUJ98MzL8V08s39cl1GJMz7c8Y
 baEzQEQSfa2GDNVunkz71TkBVgogwd3PzcGJuupoXQPZKFJ2hfGxAzytHgJudnwG5bX9
 oMfkk29bP9znYyfhkb2XN4vnesimJjKwKqa84uvNhz0BpV2koh2EnNSlaBP4fb74sbTu
 /Ocq2SxQ4vL/hHJ6G8ysDSAgwBhNd0qxmLJ8U9BK179RSS6M+4CLCOlNcbgF0fmiYFmq
 9M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195685; x=1790800485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Uzkz0z5JY8Ir0rwhVI5vUhBCQXwPjRF+rHrxo54Kew=;
 b=cMB/N8ShND4Zh1LRIF1mHq94Ve/SV8V7h9sWfI8vC7dyEfeGmjYwa7fDuSw7RgB6n6
 vsKdYkk+KKNB6IxmevikcY876njeNsAOL0EwwqvXGUMc5N2XICSP/v1au1LEFOS566hM
 ZWOl2YSMlkdqe40MRJBI3xSEXNOjqW1TWjJGBgRcF2fKAkrdcTAy0uG0+d5qdI8o9Osu
 3nnfEaPQ03aloIkLjjmHooKxEG47oZ0oKdOifGxID9toEsqePfUlBB4QvrFCqOsVr20l
 F7UhXxUkWYOXrpx5eivZvvKhqMh7TvgTkZnK/pAfpiK4Y3w3h9/9sKCSQL9iV7FX06A6
 kV9g==
X-Gm-Message-State: AFuF++k9yw70HbVVnxEW3xXEwmKEkutrS7VDLX/aEmjqBhel51DCpdqC
 K3xLR0uz5UJSjJqswD7eyeRma/lUZE/Pst+2DZpgnFuXL9/f5CynsG/neEe1C923Mo//Gx5aL7A
 aczMU
X-Gm-Gg: AYBFou20h5aptqLnJ/EFEQvMZtSLctGsB+OA1xjSJ89W4NB28u/l4zTjefr0oW5Jfm/
 meXaIkMewDqUvcKHt7Qowb0f3doohpYgzl5rMXoeyWwGJ/MHGHuKMFhZDoUP4D9T5Fd5DCqQxKP
 LlDWap5u5c+xrX631h8f3QU1o7s7QSv48NGcqc6S/w/f6M6GGlDUqWnT078duybik6WVrNXBGTI
 ohV5TE4z1LLHvMa7CQXVmMRcHCjKszAnyPMpOODbzacs3NlGuxhkg6jqIj2Fv1P0j1bNciExx9y
 A1kJk/d3jC+BpapE7sO4VYXrAUqkO7NXwMjehTB52IMttcnw05Gj+/hTd2mM9WhmkS7hMIwFj9M
 jUl1W73vjSS6tds0Mh+PBNXVU2HpEboVUIigXPMs106VYD0DhTkUfpoUjsOD24DM9gCXIh5ld09
 kNWsmA1FMrUajk5LuguSr6fWDzCYrQ1C4VZJshlNI/N3cU+ko1PC25EsvNqyWWXrruMzKNVy9hi
 6RMDFOlXmO5+UuD/3RI/ftJbVGa+A==
X-Received: by 2002:a05:6a00:4f88:b0:868:7a65:d92d with SMTP id
 d2e1a72fcca58-87e9966adbfmr269886b3a.26.1790195684870; 
 Wed, 23 Sep 2026 13:34:44 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
	qemu-stable@nongnu.org
Subject: [PULL 02/16] accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
Date: Wed, 23 Sep 2026 13:34:27 -0700
Message-ID: <20260923203441.31276-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Anton Blanchard <antonb@tenstorrent.com>

Update tlb_plugin_lookup() to check TLB_MMIO in slow_flags.

Cc: qemu-stable@nongnu.org
Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Message-ID: <20260916123958.1884903-1-antonb@tenstorrent.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ae5af014960..dc83f3bad8c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1589,7 +1589,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
-    if (tlb_addr & TLB_MMIO) {
+    if (full->slow_flags[access_type] & TLB_MMIO) {
         MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
-- 
2.53.0


