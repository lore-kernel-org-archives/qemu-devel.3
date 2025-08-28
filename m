Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ED5C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRo-0002tb-2C; Thu, 28 Aug 2025 08:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRN-0002M1-Qi
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:21 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRJ-0007C8-CR
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7720b23a49fso940041b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382952; x=1756987752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+BKphQlDE3v0Pvsr0pykd32dlEjN1/E4DcN/dj63Wk=;
 b=wS5pHoN/HXQaGHjx2QGspZczuxfgAEJtCc2C7i4WLVsUaxH9189SPviOXzCttsNFmP
 ZvllqP5zOxNUsBs/JlCDz61mrvlT9jQc9jSplA7o8jTosx7dM4ndzCMvhu6fVVvY78le
 ZPPKPsv75U/FFebgXTUJVxgNRJrqRQ8R1N9rKuzJ8jOsMFw/7P+PsiubBNMLwwt1G4YJ
 RKRJ5q81GfH1rOT8sSarYwo0slLBp1EihtEXR6tzVgPsFM91OV2qK0BJuufKhX4eJ7le
 wEdDMq59cGu/GaKmvK5SbZYmCv0xzYGPP2Yf7C/b5zGrU8AlU/bOFMswaxIfEk0xs83X
 ai1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382952; x=1756987752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+BKphQlDE3v0Pvsr0pykd32dlEjN1/E4DcN/dj63Wk=;
 b=bs/lXixkkDMZOGg7rRWIEn4p4wc+VSbHazQSWhj2Tzt2paHYo82xnYS5+3oqI02Idw
 DxsAM1sSFcgbK1QVWKjZQB4geTTcoazESHoVVFYCDBTfTeak1Xk7KUC6gCoZ+dU+VY+k
 MIGfBh0+vwIBGFXJ1m5AIt7l3swTp9rmOOFI4olZsHjmZq4ugF4aQHtoBbFyCi5AfFGi
 XzRvEAGaBYx2doZ4g26V3g3vbr5GQ5I3iBLov4DNtVWx1++EyNEgiruFWrM1vNr5JFdp
 9z2Ck+wxDvKx0TS0fDAKsRCbTkjGSvWzaw9ESMwBVDB+p9NB+9Y1tsEP50kR+sLQ+aMC
 nHHw==
X-Gm-Message-State: AOJu0Yxgd1Q//6HnpmPGuUtPUUaoJiPrKMcS2peiZ3dY4CnUx6TUnol0
 MDhvJ8G75EyYGlrAZE/B3lCviRRl7XYI7Q316hcRvBoDq33FRwRQTaKigWO8/lZ3X8U4uS3qji/
 dEJlOwRQ=
X-Gm-Gg: ASbGncucWpA5FXpMXagm8IlipGlH+/SWqZDhmtNUsMpBQH+G4cNrxIIzNW+KVBg2imi
 G4qQKENNrRQqEEltaljBqGIGwn21TrJy09hA6lYMGrIq/aVj13N9fB/8gfwTJG4nrNnnvW8wDbg
 QJxBwpcfJqs4W7tnUcMHw9pBLsbGPYE2quBTPY8VZz8Qj1EwhtPnMmC4uGONppO1vtJy7fWldEe
 /LaX8Jl3QQo0gQBEV+CQNZASnM9k8/EThQ2d8DcUMDm1ds2y6GMY1w5rFx3M+RufHQmIpikorPm
 GZi55BcdUCPdKMswTpKUQMXk41JGCM7iogbrh/E0/DwZy/LhLcI24NRDSYwtQrdm3AzdxGlxWSk
 MKXaxr0ACGPKGyiewSUXeOqwaUA==
X-Google-Smtp-Source: AGHT+IHOTZammPfHqjBbCPZ4QLGw2J3HGhFyqoPPcRLbZX0rPb/uMPlH4RNilX92cILVNBu/zfwycg==
X-Received: by 2002:a05:6a20:bf29:b0:243:9c68:a031 with SMTP id
 adf61e73a8af0-2439c68a272mr7397947637.57.1756382951898; 
 Thu, 28 Aug 2025 05:09:11 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 12/87] linux-user/s390x: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:21 +1000
Message-ID: <20250828120836.195358-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 63376fa1d6..98c17d32e6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -770,7 +770,9 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 enum {
     TARGET_REG_PSWM = 0,
@@ -780,22 +782,22 @@ enum {
     TARGET_REG_ORIG_R2 = 26,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
+static void elf_core_copy_regs(target_elf_gregset_t *r,
                                const CPUS390XState *env)
 {
     int i;
     uint32_t *aregs;
 
-    (*regs)[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
-    (*regs)[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
+    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
+    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
     for (i = 0; i < 16; i++) {
-        (*regs)[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
+        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
     }
-    aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
+    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
     for (i = 0; i < 16; i++) {
         aregs[i] = tswap32(env->aregs[i]);
     }
-    (*regs)[TARGET_REG_ORIG_R2] = 0;
+    r->regs[TARGET_REG_ORIG_R2] = 0;
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


