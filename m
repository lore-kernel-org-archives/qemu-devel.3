Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9E6C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTwb-0002YH-Jn; Mon, 10 Feb 2025 08:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtL-0008L4-Nm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtG-00068b-G4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso7145555e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194316; x=1739799116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZ1fgmbr6UR57aQyXOIyNIPPA+qrJvYb0dDxQG0PMFQ=;
 b=EMVr36D3uR/gZOncTnt0i9zIPCR9YgrYsHedhcxkmKR+yrsmIfjVGeunhhk+gfqwrW
 d307qHBuyk5xMickJHqxz2ohrC2xdn2hTaQMdcLKjHHOQWW56DDIsTfncoyZchA1/E9b
 Bl/2knsoBUoHqMNR5d8uY8OeHx92sb6bOZfRuBf4RlAz8hofbQ5a50NWCPKtAmUAOROX
 SBd37jrC4sgmAIRCKAlWvPH5ju6cAYfa0s2v+6gifVtgWyJHTBqifgF4f2jtpD81Hm4m
 8mEU7UqLZDdSQPa2vRKpE5qoM2KaS2FmEom5s4eoPZC7Y8tYW6F8zOdukNKdZ1KOcydS
 U8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194316; x=1739799116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZ1fgmbr6UR57aQyXOIyNIPPA+qrJvYb0dDxQG0PMFQ=;
 b=COtPK2w/YNQronOXbgthhhQJDMNU8iSAprQ7xyWdxPiUz7cjt0qJOOtOd4r/AM2JAx
 YL6khfMFEMz4NM76dJSE54MaBe+AtjCqNdivbtNJooJ42Fz4oNo/HczSRJSubiTkSV4u
 AAx3DoOZrIvxByolZ4U6rWjxrMn5+0esvmfFu7CkXRYCc43wrrRbHiqfLMOnuS7uNf0d
 Q0iWuLFGDG+oc7qKqicWEsptUgxvgF+61XWGA77zU/69hqRhNkGzqPGa/ZphSw6P4ORJ
 1OwcUsLIzOu/ZWUUV3L09AFr8e58lLm8Bh0qv/LJ2eeDd4n30/R9ucoPTBfgcLDdgjQ/
 hhLQ==
X-Gm-Message-State: AOJu0YwE79iNanbCd2ONg8YXrKPmLBnRDJEm0KxGC1W8jcYhDv8FbaIO
 oFQQjccxRFbHQIg0dhaVIu9TAo5PF6yFCrDYW/dd54SK0neG3AdXtiC2PMEg6rLbrlA/Jy09aKc
 1Zrs=
X-Gm-Gg: ASbGncsySfNPYJMS2ISvHR4HjOEeNUuHDEq3vaWWttF58cGFav7QmImCuYk2/dpqQF2
 E6s+pviemxBMEQdPMtFF6XOraJKSI5ntU1F3U1LerCHM4LRHvN9REVBAcwK4tULlO6zw6cxW2F7
 2mDAsiBOVEEIho+6hIuPSdFej5LzsunhVexsvB7OMkaQTH8GrOm9JkPWQViGjhBEqPPHGjNDckj
 mpKRihccXFrbjZxyh7fsfH5QJ95YsloXmh+0Yuhi1pfJH6nucTB5sdPEY+SXM/x31jKruBl1eKY
 1aVSBe8AG1Xohd4FPUDxWMCq2zlBY1t2tVsuVMbLnieJOFYq/rhYEiYDcDpvFLk2+GpWOO8=
X-Google-Smtp-Source: AGHT+IEweqWJGL+JaO7TrOk1f3wx8k+hCAUgrY1Yr1bWjMkztgiJPPp3HCmks3rMw26vxQfSd25enw==
X-Received: by 2002:a05:600c:1c9f:b0:436:1c0c:bfb6 with SMTP id
 5b1f17b1804b1-439249c0324mr101976465e9.27.1739194316059; 
 Mon, 10 Feb 2025 05:31:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43907f19247sm132652225e9.1.2025.02.10.05.31.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:31:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 04/11] target/riscv: Declare RISCVCPUClass::misa_mxl_max as
 RISCVMXL
Date: Mon, 10 Feb 2025 14:31:27 +0100
Message-ID: <20250210133134.90879-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: qemu-riscv@nongnu.org
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cbe..fbe5548cf5a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -529,7 +529,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    uint32_t misa_mxl_max;  /* max mxl for this cpu */
+    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..f3ad7f88f0e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
-- 
2.47.1


