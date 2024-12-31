Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C8CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimg-0006Fw-0i; Tue, 31 Dec 2024 15:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimd-0005zG-DS
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimb-0000we-8Z
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f796586so106898765e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676643; x=1736281443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eBUfaZOV4VpWuEPg0imAAbPSgeX3YWDxsrL3NZUv+w=;
 b=Z3eYRnO16r6Vi72Y64DmN6UPldK4TDxt4NbFYqN4Re2kzULpKYV3ePmmdpaBx8qC+r
 8U1530m5ZhHq7thiFFaKZjcfjzZBd0bnhZXJy5T0NADbQlFR++8kNQc70g+8mDypVEvK
 p+sEJGZQS4qZ2Vd7bZlb3IAKT5UJYW4APTCt2MlfxQomWrs2tnjXkgB6Rpcvweyz6zfT
 shxABJ8D7YCT65w0XSpQA0muxg/kC0GBESTSjoKhwvohJSqq8Ypgm4t+w6J69vDovwKE
 keHwviMRfuguvSIQ0YfRU6gAnvmhkyAsv2qUFZ1swbrkDBGd0LBl92QQlraSIHophVuq
 hYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676643; x=1736281443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eBUfaZOV4VpWuEPg0imAAbPSgeX3YWDxsrL3NZUv+w=;
 b=JsLnq3cYIYwHN/UElCTjidtmiLDzWjk4vQfdEiIrqjUn+T+yU1bGVF5GG2nEokTPUn
 w8LhF9umtINsZxzzUcOQorTJOpE26jZ4Z8fKgYRhOSOqdHHvrjiWe5Uun62d9alAbLM3
 gFF+GY5Ubl2Yv7SeU7k0/1RQ1jKFgNwop/Tx2be67IONOfy0kPYY+ZL3GxpV6XO/baO1
 WiFXBYrB91O6pkV4DE5aJYTZQRmAgwNuy7hUSeEwggyQDF8/gjCCGbAZ3MYRnYyR83KC
 9ABCJP46QMcrxy1mLPVkEXobE8hmjNfX2fO9rrIcWFRU4eqTXwtG7uUlN8Naq5ecfwe2
 zRWg==
X-Gm-Message-State: AOJu0YzeCvbL4EGAynjRLJB8l32qtVS/wfMYu+Et02rZZ28p0+R0MiIr
 GfMkV7tfheYhpH2JAdMMKY15doe2JTcGjSfPlxspS8krPmVRZ1KqC/hBwmaa4w7xfgdng/aMSWS
 1HoE=
X-Gm-Gg: ASbGncs5swjNXiKTJlignfsK9VVbLM+6uNlXs2gZxhiu7bABlYoHr/LkW728RRr+P9D
 sljexUGNjYOseZ0bOR3x+W9zJGj1yTYNVm648QutQbDQ2NFwHUyM2j6erBPSULODk2uKiVfoJaN
 BNxDqUEW6Plnh+nmBKoWE4eyHhM/P3OkOx5Qt7moPLEMyVFuHsHaUYizNvvdLTnrLfXI35OdvnE
 6xf18BPHGdHgEv529XWZVa65oJ5R88Nf5fxJaEi0roD7v8A9N4MK/skD2tsiA/FBP9d9PZSVEOd
 RyBigqJNJ5cpRV8/W2phQuUEmHok1Qs=
X-Google-Smtp-Source: AGHT+IEpyx91W6J9ctlJNmrL70Ly6CMvYQzDhnhsC0VD/GEUKNvmPTDkQuOP4vzfEGxTaxw5kbEySw==
X-Received: by 2002:a05:6000:713:b0:386:3903:86eb with SMTP id
 ffacd0b85a97d-38a221f1fd1mr32023610f8f.23.1735676643483; 
 Tue, 31 Dec 2024 12:24:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e150sm33553091f8f.66.2024.12.31.12.24.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vasant Hegde <vasant.hegde@amd.com>
Subject: [PULL 19/29] hw/i386/amd_iommu: Simplify non-KVM checks on XTSup
 feature
Date: Tue, 31 Dec 2024 21:22:18 +0100
Message-ID: <20241231202228.28819-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
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

Generic code wanting to access KVM specific methods should
do so being protected by the 'kvm_enabled()' helper.

Doing so avoid link failures when optimization is disabled
(using --enable-debug), see for example commits c04cfb4596a
("hw/i386: fix short-circuit logic with non-optimizing builds")
and 0266aef8cd6 ("amd_iommu: Fix kvm_enable_x2apic link error
with clang in non-KVM builds").

XTSup feature depends on KVM, so protect the whole block
checking the XTSup feature with a check on whether KVM is
enabled.

Since x86_cpus_init() already checks APIC ID > 255 imply
kernel support for irqchip and X2APIC, remove the confuse
and unlikely reachable "AMD IOMMU xtsup=on requires support
on the KVM side" message.

Fix a type in "configuration" in error message.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20241129155802.35534-1-philmd@linaro.org>
---
 hw/i386/amd_iommu.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index be522b5d7dc..6b13ce894b1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1652,17 +1652,10 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
-    /* AMD IOMMU with x2APIC mode requires xtsup=on */
-    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
-        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
+    if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
         exit(EXIT_FAILURE);
     }
-    if (s->xtsup) {
-        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-            error_report("AMD IOMMU xtsup=on requires support on the KVM side");
-            exit(EXIT_FAILURE);
-        }
-    }
 
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
-- 
2.47.1


