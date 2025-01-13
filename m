Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C50C02184
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXc-000632-1n; Mon, 13 Jan 2025 14:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXa-00062p-FC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:02 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXY-0007Sd-Q1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:02 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3863494591bso2543427f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798158; x=1737402958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raovzkxW4bgEPUiYxpxT8OAVJQxeHZnj+ixMLAGuiZ0=;
 b=cf4XBmsubKUQ3UYlbzf63VP9zfjIGboB5r/ugA/nHA/r17RKBwsPBaVNc/iqLJLL34
 9QOZNyMoxEa1rSRmSHfLcXT8yRPBbR6mQEftS7r7DpToJZ7j8fVe37kOPtdAjBswZO6H
 vbNM5+EBZroVnE1+LTqKt++g0fTdvgxBEjfGCJyrTnzbZzHpOJJO+cRT9pV3muDfodUx
 iBunZCB+4jjkaAWYVJydmwW4MryM47JocIxyWUiSgRZmbJUSZRbWCNiZSXVcWQPObql5
 o1WMdPz51oTwUYAXWbBiJ1CWog3sw5nIhGh1ggVzeCOzgJ/7JD3W4ZdZ/1PfnTuiuL9g
 tDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798158; x=1737402958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=raovzkxW4bgEPUiYxpxT8OAVJQxeHZnj+ixMLAGuiZ0=;
 b=eMjW8vc8+JdMkNll2Kh4jrYYwOtpycuq4kQOCpwGd1sC9eEqNypz4t6YyetCD5BvSq
 esW2N1DWBpT7jPLJmgje0ibA93Fce7WyQdTSIFxj9h34K8S2vgvv2giaBIG7raAlDLPM
 uWnSno5zJD9oQO+t+1P7yDg/nsT+cBuxlMzI5EsFhL4HEo+tsocDV1CQUUbrej+3MVc+
 y0NTcMDxAN5SvMHzknZYKjWmUjnE2/wXVvRZaavWm6b+5f1anmjNp+QKUwd8Q6eAF2Wl
 LmnFo/k/JpJQJ5aM0h4ZI7rLpPN7AJuhYRdJjp8oTs1+cBAARae1zyysyd0FTPtr2Hul
 xYNw==
X-Gm-Message-State: AOJu0YxytRm8nVslU4PFPjm/WsSGIeEr/9DSoR4cvoHu/qAK5rTHQcox
 Ye35MB0m3nFRI1u4sbQ39WIiPEql9rJPLgwDQq/tKtyoLUuma9k2zM4UESot5OkHeRe4/HyrAdm
 cLl4=
X-Gm-Gg: ASbGncvW8zoYpP6tv9P5RpW9/V60PrYaP2bLrcbVqYHYYkfY5Vwgu3hRac/mz1elx6X
 9AVNWqzqLVM9qZDa7ISVdnUnl3/YSw6h5D2ozecWUqpKMmm+P/+Fxz5jjSbs6+CNkKQ671C9QBh
 fLSGKD4DWl1OhiaQLwYhY4LN9rPV28STADHBdovlEMtGOUA6kQU7FN5vmzhKnIiQCtsx2W6ygg1
 c2CtT/WHZekG4poOU2iPuXHfW8gDZwiuxXratdCCtzD8Gfzn2J83RMv/yyvfcGy7XkUvoV/FW3W
 dPWoqFT6kxgtnMrLSLY1S/MyL5zmHZA=
X-Google-Smtp-Source: AGHT+IHSH3WGMmfb8k1PMZXxAarGZvmS1mN5wotqv7gobBoAijBCMBj/I1l27IPXkDzC3j0QWDlEMQ==
X-Received: by 2002:a05:6000:1542:b0:38b:da6a:8a02 with SMTP id
 ffacd0b85a97d-38bda6a8e9amr6088466f8f.47.1736798158534; 
 Mon, 13 Jan 2025 11:55:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8a326sm188258975e9.35.2025.01.13.11.55.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 06/19] hw/mips/boston: Replace bl_gen_write_ulong() ->
 bl_gen_write_u64()
Date: Mon, 13 Jan 2025 20:55:12 +0100
Message-ID: <20250113195525.57150-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

"exec/hwaddr.h" defines:

  typedef uint64_t hwaddr;

  typedef struct MemMapEntry {
      hwaddr base;
      hwaddr size;
  } MemMapEntry;

Since MemMapEntry::base is always of type uint64_t,
we can directly use bl_gen_write_u64().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/boston.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 67044af962a..63dc654192a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -329,20 +329,20 @@ static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
 
     /* Move CM GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, GCR_BASE_ADDR + GCR_BASE_OFS),
-    bl_gen_write_ulong(&p, regaddr,
-                       boston_memmap[BOSTON_CM].base);
+    bl_gen_write_u64(&p, regaddr,
+                     boston_memmap[BOSTON_CM].base);
 
     /* Move & enable GIC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_GIC_BASE_OFS),
-    bl_gen_write_ulong(&p, regaddr,
-                       boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
+    bl_gen_write_u64(&p, regaddr,
+                     boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
 
     /* Move & enable CPC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_CPC_BASE_OFS),
-    bl_gen_write_ulong(&p, regaddr,
-                       boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
+    bl_gen_write_u64(&p, regaddr,
+                     boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
 
     /*
      * Setup argument registers to follow the UHI boot protocol:
-- 
2.47.1


