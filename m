Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AF8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwL-0004FG-R0; Fri, 31 Oct 2025 14:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwK-0004Cr-7M
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtw9-0006BQ-R8
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so1334326f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935598; x=1762540398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+m+D8DJcKrrz35Vp3pPzkIZBB0yV5mheHpZZV4UZZi0=;
 b=RYc5h/fYjASw+Qhw1ZAiZ2J8YQf4BZtAm8lsPUiYkdnwD8wmZuCdgP87qutE6HRPtC
 n0D9OoHJ5/lDG0NrW3zanl+8v1LgxHgoG6/8DfN0sXpzVuOmTTB6bGkh5RwZ9s54UN3J
 GOhF8XR9GeEgRmu/YQe3Yz9KLygo7BGMGho1f9PYsb5313FLGcYYEERuAjrOtreu8PhF
 nU8NhoWNU/G0cnDozrJWLwygcqeTLabYWCUVvYuMD4yrLVrm+aKlWj+7gO88G8u/+9sX
 RKxUA4wEqHoFAn3Use0o7jNHq22elGGdRWKB/wUFcSYshk52gyRgyI30183mtrB/JQ+j
 ahIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935598; x=1762540398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m+D8DJcKrrz35Vp3pPzkIZBB0yV5mheHpZZV4UZZi0=;
 b=WSWSRcs9y2sXzR42bWst39nJoXKP/y4r3ewTuo7gTLbgut1PLGVAJFFGCkC15Exae4
 BafCuAPNFwNVEMr50nDJEyB9on0/pPZhraV/DRiPmtJhjHrEjbO9iUaEHQXb3/YN1aBF
 zt16d/kpuCTI03PPE8uX8KjCL1i2WzSF2r1zRXlujqhxGbi3ClRpjfnHo9HnzVlDQyNp
 /rpf8Pqwlnz6bWwmulnKON/xICeOx6J5ZiHjYfxVN94EsRO4aLSujCN6mOdSRrvnp85d
 B9KT+3JrtA67KrHSwzgSTyipHvRutwHgNhropmh65IKn+fuYMupE1X/JBteXnUCLnF7h
 ok3A==
X-Gm-Message-State: AOJu0YzGJoNEuHo+2ceLHO8CsVp/U64mPqsl756fM+GKUIzZ0F3QdY+a
 B4iE81gO5eqWiB5J0z0dH8J8gZ5J6Cm3OIOluf1SDfHWspZkh1GHNQBjX7AZooRssfmP0MTL0k0
 4x+Us
X-Gm-Gg: ASbGncvbxQRmu+z8aNvLpkjZgrysIycmit0ymRgeJ/57aj+uWfnkfLv1lXaIKeRS7SM
 jOc6/EvTQbbJGIkRF/+ONXJvodocIvWzUVS2PsAwE5uMqCGDowZQMcrJ6GBqPjgNIoF/R/Ghgt9
 2fNk5RjcyRHMwRgmUKWTVa/+fngFg2aQYxlXBlmDvp+C5os2jaJlhhX289TZeMOO6rHje4v23OS
 ksXq0KjZxnebFO+6JiW5tusejSmyiu3fDxd3vVCclQ9m4iNp/EB69vcOa11IPuwebbEcczKUbHL
 JLUAiiZDzFTQV9d5wUPRN35+3EUIB4MBr8TNxsmuZmXXM1U1UlvSoLDkVrfskPfmRjG7JDXrvDS
 rdSZnW2LVmPdpgXFcPHi5v8YmCk21G+0Ea0a65TnZyhAlKQk0wiYwPaJlLIfVw+IKCYv+p5lkWh
 KMkzbyUebQYERXJVvJ
X-Google-Smtp-Source: AGHT+IEfTNCxnJcNeJW6kgWIPH6E1lhcn0760HsRkiGMwVTv5uVdSqJuKaz9bhcI/5XbaKQx4K2Icg==
X-Received: by 2002:a5d:5f55:0:b0:3e9:2fea:6795 with SMTP id
 ffacd0b85a97d-429bd6b0e8emr4154734f8f.53.1761935598070; 
 Fri, 31 Oct 2025 11:33:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/38] hw/arm/virt: Remove VirtMachineClass::no_ged field
Date: Fri, 31 Oct 2025 18:32:38 +0000
Message-ID: <20251031183310.3778349-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtMachineClass::no_ged field was only used by virt-4.1
machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251020094022.68768-3-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 04a09af3540..993872bb680 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -123,7 +123,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
     bool acpi_expose_flash;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6cf8ed58d56..4d03317b599 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2213,7 +2213,6 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     bool firmware_loaded;
     bool aarch64 = true;
-    bool has_ged = !vmc->no_ged;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
@@ -2515,7 +2514,7 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
 
-    if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
+    if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
         vms->generic_error_notifier.notify = virt_generic_error_req;
         notifier_list_add(&acpi_generic_error_notifiers,
-- 
2.43.0


