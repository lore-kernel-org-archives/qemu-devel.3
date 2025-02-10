Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A963C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacv-0007qF-9l; Mon, 10 Feb 2025 15:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacr-0007eY-6P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:29 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaco-0003hD-S1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:28 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dd011ff8bso2651776f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220204; x=1739825004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZC1HEaPoraYEpey1ubDRQ5Kf2104vV3xZFjDQTDihc=;
 b=faj4W1oqgzBP2ZKpi+yrlBS5oo0aaiIXeOW9t0fwh718naNnYnZEILv1JxtuvUS+jl
 PZjUJfWd0RJWfu+Wfpi36Zox6QbZjTAvze4vv+60XPQ85FmxblkCnmlNXHHZxTVR3CBC
 kIANNGfcljHMynPlnugWiJ6YOVCA/pcsJjTdWaB+IqxP3s0FSgn6j3Nt3n2HH93oAksX
 enWgGe2TcswGrC+UgSHabVfeLHsxi/XcxXudBzm6RdapaqexLTVQXEV0+pADjjTbinRy
 d6w4WagHSePX5RMGd5erlLNpAfkvOJXp9wh8EpTz+kVHrI50QZ7K/QTdEC1xiDnxMJFa
 lXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220204; x=1739825004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZC1HEaPoraYEpey1ubDRQ5Kf2104vV3xZFjDQTDihc=;
 b=aWg1mfwlPPMF5kZJ8MdDKGFAsSCPAMPIuf/LOZLL3I31FfNG4e35BjozZ82jEiIjvp
 oJpCzTAUfhLtkzgSF8+g3GzEaNlwzmDNrunkVDhivErttbG6toGDJsTxzB1UGdncrIvi
 Arz6tthgWwmYzpJUM26X5QdVUqYn+9GSqGL4CNBZn+SsiQzH/a2FTZpXsOLPtiiJnKeg
 II+Vrt6jN3hhBj+lgA8DW1h1dnVxzUJm7ydMpmInlr+kvLt5fCDwsNN4i6iDw7ZboWZg
 cFDFXHxCU2yGw6/yxy9CT12MPIYon6DFLsZTvNcE2x8yuxvCLTna9O6OUG4GxbET7Pqg
 mdYw==
X-Gm-Message-State: AOJu0YzHljqDDSSIGMiKmRXQvf0gN3Pjke1NWKzg3vZM32IZNUwrAbcK
 Kz6D1UyWkh59XblyYgqIsYDiG28WZ1Z5CVuSu7z3+5kx2HHGOxPKxUEiQXLOrcy70LFykEdrqq2
 sKiE=
X-Gm-Gg: ASbGncs5lp9VhUBv5NcJ1oyRfD8Dq7OOC6UZkDRuQtHKquPyTcHphzQYAmRUHqFTTZ3
 2lwsxvcgPVz1dfuk0Dz77s7vf+lY119pkfjH1rtLVD0K3NqhkOsXfPHOzkvDQ8pFOvHr7d76ueV
 hqR5HuZQsfSngznT5NDYsZqdbtvvEYJaAgtLFnuG2lfpkBrYFUMRfWGgIkmyC8JYy8n2/U+QjyP
 z+//YrihO6/5DG/tG8hdfKshGEa5G6GHFONy6fr9zLE/+9YrGpPdSTN/qsNiATFzeSjjFKtoxKr
 6DtUQIfyfzcpavxiWGXVgHd6yEQipBVxCVnh4ZQSO3qKLjoAZQ/esDMdyWJqI4RpSg==
X-Google-Smtp-Source: AGHT+IFERB7loWxLzcxYY6BMjWGcXa6YdFb/dx6OKiE3TFEzh0qR6VtbMevcU3k/DF8z8v21rjL9DA==
X-Received: by 2002:a05:6000:400f:b0:38d:c9f2:c57e with SMTP id
 ffacd0b85a97d-38dc9f2ccf2mr10364671f8f.32.1739220204046; 
 Mon, 10 Feb 2025 12:43:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2ef7efesm8173837f8f.52.2025.02.10.12.43.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Subject: [PULL 15/32] hw/i386: Have X86_IOMMU devices inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:47 +0100
Message-ID: <20250210204204.54407-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Do not explain why _X86_IOMMU devices are user_creatable,
have them inherit TYPE_DYNAMIC_SYS_BUS_DEVICE, to explicit
they can optionally be plugged on TYPE_PLATFORM_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250125181343.59151-7-philmd@linaro.org>
---
 hw/i386/amd_iommu.c   | 2 --
 hw/i386/intel_iommu.c | 2 --
 hw/i386/x86-iommu.c   | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6b13ce894b1..e8e084c7cf8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1687,8 +1687,6 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     dc_class->realize = amdvi_sysbus_realize;
     dc_class->int_remap = amdvi_int_remap;
-    /* Supported by the pc-q35-* machine types */
-    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
     device_class_set_props(dc, amdvi_properties);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f366c223d0e..7fde0603bfe 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4871,8 +4871,6 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
-    /* Supported by the pc-q35-* machine types */
-    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
 }
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index fed34b2fcfa..5cdd165af0d 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -146,7 +146,7 @@ bool x86_iommu_ir_supported(X86IOMMUState *s)
 
 static const TypeInfo x86_iommu_info = {
     .name          = TYPE_X86_IOMMU_DEVICE,
-    .parent        = TYPE_SYS_BUS_DEVICE,
+    .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(X86IOMMUState),
     .class_init    = x86_iommu_class_init,
     .class_size    = sizeof(X86IOMMUClass),
-- 
2.47.1


