Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BDAC02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6v3-0007i1-V3; Wed, 15 Jan 2025 12:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6v1-0007g1-IT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uz-0006cC-AU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436249df846so48733355e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961059; x=1737565859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVAJtatL/ZPpb9lJWM6F+L2p6a5jhKW94ak9z8z1WWM=;
 b=a5/FHipK8O54Bj6AOVKjPw3K82sa2M7k1XFu8KzD29RzpWnFMXHmTf8eA3/7Jkp1xu
 xMPlJBN01V2GTr8tp6BayAMZvKJtSW58hZUR6fbKkZnpyMSN5Z+2Xo8QBAW2jiQQgOdp
 bPIylf5LYOA/2p7NqDwdhfupxTf2/XeklfT0wiYZx782FDByZasOyXaaHrcizVmdUAjr
 lZSJJfu+wk8cGGT/QAS72l+1sIiAZuwChrcPB5kvvsRGlKIIfUGxdVlBCATsdXmCkrfO
 Uqu6Ka/KEPengw5uDxS5+dOZzNDkxfIOJDq/d0KIbPtxrPW1O6bELof7NlkDKAfag7pK
 Wp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961059; x=1737565859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVAJtatL/ZPpb9lJWM6F+L2p6a5jhKW94ak9z8z1WWM=;
 b=bdzcNBL2ZKHnQy1bAEEEm9/rzMSsyaFV4cCB+hyVNpb73zKNR3o/eb8XZorIiIfpJ3
 pAwqXJc/nmWg9MaFOzrXKy7BGCS3P2ZJUu3aDS5rXEwXW5FvdBu3kZlAHSiBQFOYyb5t
 lNqYXnlSp1d7FM7IH97F8z/LpJ0GeDJpMHPWf0E6OmymjQZCsDwCBwdmdYFj3WPzfwP0
 8w/abdCvpFBOBVdwh4zFuIoqIuOdu4isYjufsJovS7hiI5XgYvDqnwbjTWIepzZYUqPg
 7trX4JFZJygwR7UfBu3jPT1h5UmuXGzimTLp1SiSiTQliLsRVRfhAgR8uZ2fxWB4SPP6
 uNdw==
X-Gm-Message-State: AOJu0YyBc5cqHBkJH7myTME9G0qfa+RnaqiW0R9SzC0fGJrMOG1hUjHn
 dUKYF3Qo8BZnX26twmEtfO82v3SZ5L6ltqcuOLOFaKKr+3dASRchYifutrlCjkGrbxlzR1YQdNV
 kQ1o=
X-Gm-Gg: ASbGncuNqEoAGBZw4zXZHW+6fA8UGIyQYrI14olJ/FVwQx9FkDKvBi2vA1g8khlDYJR
 UTcow/i5miyKjTQPkYB39bj3KhlhcCd7LTkP1welLhlf+HWS+THu4an+s5eGhaRsTR08OoL/TqX
 JF6yGoZOMGiVWjHgWf9/gnQ062mwXBQPIBM+942sNqFmPEo1mQf+4Rkm2Tt1wIMkWIoRTDEjLXo
 h9h92gRUds2oxOhqHtpIrHmo6jQD0ktScdCQsYl9xERmoLJtC32jC4fSCZH7A6eT/WWOSquFeeB
 Vs70mj3YWOG7szYcuLANlPuWFT60bwnul2D7
X-Google-Smtp-Source: AGHT+IHJrWnvKPdYAfwwnHpmgsmZmbkxttCkVE/mIaNFSHzt0Z9vLxCr93Y7K2oDzGKeMXEg7aLFCw==
X-Received: by 2002:a05:6000:1f85:b0:386:4a0c:fe17 with SMTP id
 ffacd0b85a97d-38a872e9105mr26380872f8f.27.1736961059142; 
 Wed, 15 Jan 2025 09:10:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38378csm18013507f8f.25.2025.01.15.09.10.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/13] hw/arm/virt: Remove deprecated virt-2.11 machine
Date: Wed, 15 Jan 2025 18:10:06 +0100
Message-ID: <20250115171009.19302-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  2 +-
 hw/arm/virt.c                   | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 7c8b98fcdf9..0594bbd4363 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,7 +1065,7 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
-Arm ``virt-2.6`` up to ``virt-2.10`` (removed in 10.0)
+Arm ``virt-2.6`` up to ``virt-2.11`` (removed in 10.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 These versioned machines have been supported for a period of more than 6 years.
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dd44fb30773..ae331df9349 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3525,13 +3525,3 @@ static void virt_machine_2_12_options(MachineClass *mc)
     mc->max_cpus = 255;
 }
 DEFINE_VIRT_MACHINE(2, 12)
-
-static void virt_machine_2_11_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_12_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    vmc->smbios_old_sys_ver = true;
-}
-DEFINE_VIRT_MACHINE(2, 11)
-- 
2.47.1


