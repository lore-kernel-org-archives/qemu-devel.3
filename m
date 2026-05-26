Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A93CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmB-0008Du-PV; Tue, 26 May 2026 10:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmA-0008Db-Qc
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm9-0001Cp-B2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso21302605e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805736; x=1780410536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WmSJAPow+YW2bigyZhXGopkY/S/FugrDTMkszzNRmr4=;
 b=lL3vVHiOOxTPLPpa4nDsmb5AJ60wT3CO8tu+VmOR16JK+BBPPkYoONaokcdk+1wUmB
 0jDpsMZGfmyGsHBf228JUc1y8v70prKTvlR7QHbrwmn/TyB9KsVfFpd2vytUFpNSViYi
 OfiJQlsXBJ8Dmy4t4tFkkCcdgFGgtDpVuoPvkbYTUIPHJcWWzB5lX3FjiOvqe0l1KDUJ
 Ji0wjPHm6Le86S9GmK5XWwGqMTmi1jYcWSKWPu0SKttV/BzQI1uOI8EMido3WWSicmzr
 ElgQExrcHfRAHz1wsyc4LrZmzWyasn1u46dirScj3U38qS/g8k0TaVN/bNMircGXzJ3F
 cAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805736; x=1780410536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WmSJAPow+YW2bigyZhXGopkY/S/FugrDTMkszzNRmr4=;
 b=BVMTltmK7k8dqqub3iHJJ/YYW7mkCiOCbnYm5NaTm9/xt2dWQsols3T/7YvnInj9g1
 r+Z+P+4eyt1I4ADxQohBoC6hO0Uf3S017BLn/74cRF1RVhJPfSyWEi/F2q41bVmfIiDI
 PP33lqoF51OMNCEpbTc+GQ6vb0j/TH6HOdlNyMVzLCoK3Eeo9VnLHtwPsQsDmJ50zv5T
 VHsUjrFJygyB+8nEScAMjRNjQZy0kQ6vLJIN4E0cUZiqGHoXInSBFMwM6C897BPfDRyL
 3Erkp7ldg86eo7yMgINwUG8AN1fnyaviYow6Qe+c9PrO25g83ZdwJbjV6EcXqohOZj14
 rNJA==
X-Gm-Message-State: AOJu0YyEQXPKfsdRQDceVuvqWph12OL/wpkjVk/2nx+IX39ZYqYj/cdN
 6e/IkbydohQY/99Axk18h3ZvrcKnqNkEqKBT0+iSv8OxvgvC1rJkwlQW0B8E2OfxNKynOUc+irM
 fzL5f
X-Gm-Gg: Acq92OHTFhED5njESGzft1jDkZnHxZDfPL92nJ9ug8gAa3j5oW0rJHmQ8cGgs7HEUE7
 DV8co3YSymxhk4NHoRh+ACfWy1irlCIt12AXPXzif+kdHQvILk2MXLk7eGFUjlLyTP5TR/rfFfa
 wpmGOpIqQdM4fdOSnMtbUjG7T3otfRR0irHKaoclEUAGSWEyLzFT2bZE40Nv0BtIc4U7NxHf/3V
 QgBri5uuF/nBHGU5joMT1SGKzwIsdXYWy5FH9qlxFvToOmOJ8HdAM1pY7kF8SMhIJ2MgV+jeRAj
 gR0/27fIvgl/Ay7EcTcl7vIU0ke/K6hLaewIPk8pLIIT1YmftW/KGpGTXkpd+SdAfkEDJUYFYBX
 cB1kH/jKy4YUf8SoqLZmyhe3hGByL/Pxvqc4Sk2eD4ZyKTxUlwZF/tZU7JalaogLAw69DF6JI3z
 gzq2Mk1FdQ0lQoJ7kINW1hgJc0L8WBFeBGbKeWrRFIjfF/LAI7F/NJM+s/DLIuwfIy5xDyML4KE
 K1aS3sP3cNEmd4AuEbFOQC8USSwk5wr+KcRk45F3w==
X-Received: by 2002:a05:600c:46cb:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-49042482762mr323974865e9.4.1779805735966; 
 Tue, 26 May 2026 07:28:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/54] hw/arm/omap: Remove stray unused prototype
Date: Tue, 26 May 2026 15:28:00 +0100
Message-ID: <20260526142850.2326589-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

When we removed the support for most of the OMAP SoCs, we missed
deleting a function prototype that was for a function defined in
removed code.  Delete it now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-4-peter.maydell@linaro.org
---
 include/hw/arm/omap.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index dc63323210..96a52d280c 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -338,10 +338,6 @@ struct soc_dma_s *omap_dma_init(hwaddr base, qemu_irq *irqs,
                 MemoryRegion *sysmem,
                 qemu_irq lcd_irq, struct omap_mpu_state_s *mpu, omap_clk clk,
                 enum omap_dma_model model);
-struct soc_dma_s *omap_dma4_init(hwaddr base, qemu_irq *irqs,
-                MemoryRegion *sysmem,
-                struct omap_mpu_state_s *mpu, int fifo,
-                int chans, omap_clk iclk, omap_clk fclk);
 void omap_dma_reset(struct soc_dma_s *s);
 
 struct dma_irq_map {
-- 
2.43.0


