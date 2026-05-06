Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28D1FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclF-0006vl-UU; Wed, 06 May 2026 09:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclB-0006cr-CV
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcl7-0008GJ-1j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so61534865e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075869; x=1778680669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I+845LPtOii5DZwrPWQNjQI35Zsa4q0wb4JUAuCn6FM=;
 b=jWqgVFU6O3q+8h/+muxORI7EH84SRucGWaZoVmkAaJIuaPWoIRLLCkMDF/AN37+nhI
 833RroaDYJkVtahJ/KW0kkMaXHIPaKjBU1+TiYbzIvnZy8Su+CKaxZJeiplwTpGMnNqG
 FO09VUVH+CsqMy27B2cLm5cgMhh2LZ/TwunzpXo3/C3/LFe3dkzRstENeUQ4C8KIRFFi
 d6nV3u8bF+wwDG7Ay5He6oDXXHtP/CB6X18yQplBF7XPqrMgBGLA/6zs9KbWzpKkygh8
 unbarVPR2Xh9L8/AVYAwVvXu+SuvbHHau5sKpLz7P9fWplSw2aYdVL3Day/6zbUPSbDK
 dhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075869; x=1778680669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I+845LPtOii5DZwrPWQNjQI35Zsa4q0wb4JUAuCn6FM=;
 b=RTFKHRSnhHnK4nfR09sQlfX2H+zlMlb/0q/crVk13VSPa30Ea2guPZrdr563DHztKK
 PpF27bOyt7idx4jdHXUqlLk9d9jzmqjDGkqRMG1mIisSm/D4ZJWbUblGdHA8qJ8YEMBH
 YxAu52wYgEAiPL5Ay5ypz6WWBFGMZo8+UHncUKsQRHb42ZlsBWT53ra6QzKP9HivY/jN
 /F0QOnxJwXGrCwJuKy3xC731OxEBDWiNH68JF/TuCUpwlfGdyjoBcKksrMZrPekCn9I8
 31hVCy8Alznp+eP1ItSeqFCo/pkWfMqAJcxR6wpVXoQzBfnvWty+9Xd6i6fTeb+4Ld7j
 Bx9Q==
X-Gm-Message-State: AOJu0YwoteAsdO6i0e4NSFlep2ZTL5TblibHHr65o/QNlaOc3e8mk+bG
 Khe5CGwticyJFrx/5ynLQMIp1okEZm/GlFsRzGVlexp5vqP/7dgFzM1ZDEFPZO1xMsjhXWV8Z/e
 03bRG1ic=
X-Gm-Gg: AeBDieuVkUzExUME/a/sIpClacF+hfqLcZjHYJuxxIOQJQkCoMIR/w3mNhROaycTMSZ
 Y4nJYeQvobAx0ISLJz0eAptXGJQKjpjDcpKKe1TG3pa05b1y3I86IGcIaxembcZD7gVwSzyiKNp
 iO12TY3IhJcz6h3Pj/Ri/s22RjNPig7F6k3t4E9hWsiYXvDhJx3QnnDvt9ci/j6hVaUal9gEdMP
 tvyocdcFDTse7ZrTJchvnR5/VwTlcNLTjz5LZACXkQwzQcxbbdoZko6aPjJ0K9y7+7QeCWEtC21
 t5Wok20Mxjkj7neZX8FmfT+EG3XTtJWb1C9/lwVmI5QfyAxxt52Iu3mqO52cKzRBsnqCqJyTOnT
 AFYC66AYHVQMPdmBSablBEvXYZ7wkDrmhaiV4ntvwVyygVH54DKSMx182s9ktmueVyQcfNIqvgj
 EXYOSNBaQitRHn5x7yFH1kifUbMYJNpSiT/svQD8YypPOm7NflX+pwiCce2g1X2ba4ovxmHWh5L
 ULvLEu0Hq2FYTn1MyPOqg==
X-Received: by 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48e51e19668mr60581155e9.8.1778075869108; 
 Wed, 06 May 2026 06:57:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505285e765sm12290509f8f.10.2026.05.06.06.57.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 019/110] target/ppc/mmu: Remove unused hash32_store_hpte()
 helpers
Date: Wed,  6 May 2026 15:53:51 +0200
Message-ID: <20260506135524.20617-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The hash32_store_hpte() helpers are unused since commit
6e8a65abbbd ("ppc/hash32: Rework R and C bit updates"),
7 years ago. Remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20260319111936.68041-4-philmd@linaro.org>
---
 target/ppc/mmu-hash32.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 04c23ea75ed..5705f57935b 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -87,22 +87,6 @@ static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
     return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
 }
 
-static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte0)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
-}
-
-static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte1)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
-}
-
 static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
 {
     return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
-- 
2.53.0


