Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB9BC5B549
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBvq-0007wm-Bs; Wed, 28 May 2025 04:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvh-0007vk-Vj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvg-0005FD-EW
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so4681065e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420067; x=1749024867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFcQXvhrY8QQZwNg9G2ZE2INjIMXFDjOrUvxWYd5pvw=;
 b=ObgE5/SHQWwL+O+IkZsUUAQYtlBT6Az5y+DyfzpVUj2aQU/6xoIeygPbGwT+NvQ3iV
 eqtSOgDuYC94A++AkZuW+xmr9OvZuRvbvXeXw93+rT3yGFughKNfuD1kQiMNNJha0vbL
 7ziIcJVRXv0u+Qu0edYsJVVvkV4lOjYoz0yc5H5vDaV94nr+glHMNK02QHVBdW/ZdocG
 kZ3cYvzar2IHmoTSEe7jVDt1ie5FDrRsc5/PHY4V88nd/xezAsLidgArHBnepcIVbFzb
 UOfSQcLXmgD6Jpj6U5PkRgUo8cCCuE79pH09scTFKiAnRsz+OuBr1w5ZMZ8DcBH/xRJ0
 CYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420067; x=1749024867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFcQXvhrY8QQZwNg9G2ZE2INjIMXFDjOrUvxWYd5pvw=;
 b=ntit8tOoFIYh6lXuMk1PkFZVTv71WsmS7YMbrTjHT1z0qdxAbf8rBxigSvhzYG5T0X
 KEiKpAS/bKjXSuDVQQaKrR5iRd2J8PH51Q65UPxARyk4rRcjMI/PYX71Mh1T/llDJfLB
 WXZ9Pv0ScZW6ALUhPMVPTLDnnYcu6lLnrB0iuFCHSY4QydIta3qevO3+m/ZVxeQDjzUZ
 D3pZpyplj4SFr79FGtTHY+JF40LyOJpgIC3C/hihklWeuGp4xWaVEZ9h2gMBtCA2QzLa
 s1nkCUc7/3XCo10xesU1TeMo/7iEpad5GJ3TlaIg1SLGeM39Gkokhsu7KwH0IE+LEEgf
 HRJA==
X-Gm-Message-State: AOJu0YxHp2CbN54MWI5jyy1CDCx/de4H7b4hH6L4byMyrxmDeVSqzkw6
 XLfuen9LtaSKv+zqwTKE+WZrf7WoTpqi2FVcKt1f6X/3aJ1r/Z2m/nLWO5ajGlMcpgLSfypNlCH
 C+TRAq3bkog==
X-Gm-Gg: ASbGncsao3cQxcuI4X3plLG/fGYIUUW5foGh0BO5itZH+fn9xv72kBN6yr2JCSIxLCJ
 0Tm0iQECmJpPF7lqyQCDys/Jd7E3+yGgfKTu1jWypGYVujbYIH2H7AgA0YPu0NltsxfBcH2Be1d
 L93ih6WwF67dd9WPizIgGkjC+nW/84WTSrkc/2BbnhPjjhtPolOTqFzL3374/pu68EZpaRgffVp
 wTBzMqi8RRGsYScW5tMfAgSByYQ7i63LWFYAb6xl4Fyb7M3jNZsxHxB8GbwgfxzD3Zo98/Y4RoC
 twebvID+QMCCPgOr1YbLtyt2qWvSWN+wAU+0yGtpePLo/6H4UpXQlsmj
X-Google-Smtp-Source: AGHT+IGSV2prD7w2M51QG0UEvGz33AwPW5PzmfcmF4234TR4lWje/1GBYt876l8Fo3ZpSBj6jmpPTQ==
X-Received: by 2002:a05:600c:4455:b0:448:d54a:ca23 with SMTP id
 5b1f17b1804b1-44fd1a2db25mr33182935e9.8.1748420066988; 
 Wed, 28 May 2025 01:14:26 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 10/28] target/microblaze: Fix printf format in mmu_translate
Date: Wed, 28 May 2025 09:13:52 +0100
Message-ID: <20250528081410.157251-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use TARGET_FMT_lx to match the target_ulong type of vaddr.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 95a12e16f8..8703ff5c65 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -172,7 +172,8 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
+                  "MMU vaddr=0x" TARGET_FMT_lx
+                  " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
 }
-- 
2.43.0


