Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04423C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MMS-000071-Rd; Thu, 03 Apr 2025 11:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MML-0008Lx-1I
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:20:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MMI-0000fK-7Q
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:20:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so15709605e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693596; x=1744298396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1ud80T7n6XBN/Vt1w60MmBJZWVmW7lhw8QbR2LN0sI=;
 b=j6J1iSPm9KKICtXvH7yVnFrA5mgiuB798ZaeqwTvnSivNOb6S5ieYXtHVwnBISl2Ht
 Ly89g7rf165n7xJJuAsFpNODyBOQOqLqoR6watgq2QYSgwhTUlZIv7QK1BusgM5mjx97
 MJPCkLVYvRo7R1x+wb2dwweH9I/hdLFgutGaBJuewtQf5nTVSW0JX7ivyQ97EXGOn+t9
 pgEeIzLykbgB4pLPGX4cDZymQAW04zzYJe9B43iGrn60dXssrad9zvhLW/CY1/V4Eqm6
 e+xhlYluixLTGDnbGEge6MtPy/DPWH4kdLSGoDD58Qn0tIr9uOqvdvmHo15lams0BGGp
 L9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693596; x=1744298396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1ud80T7n6XBN/Vt1w60MmBJZWVmW7lhw8QbR2LN0sI=;
 b=r2onfB3akIKk54w5EFnmck/UlXtmAYj3RyBKQ0HEnGlP6s0jp+2JOiPW3aaE+hRA3D
 mpzmxQxzU/h4JRTDqLHvqDluB7TvjEkz33xbzWc9k7wjhKOuQec1kN7metXC1GkR4MZi
 tO/ZsgX6fx43wrNe6J4rWw/IYQ/4AHU4yGrnMiEQNbNbEa9nIH9zl35T2wgO5FVNpkmB
 3fPf0Sl7MKC2Mr4KoZNfhHO+0dL4TTboR+PFzpbO32XAfVPTfa3gJllzy8Vgan3SMC8A
 xmWiMFAoHxlHXO05fYTHLVk7K4h8EFw2YfBphsQMLpESW6qAscseqDxOmrTe8g94SUZC
 K2gw==
X-Gm-Message-State: AOJu0YxsUekkLgiFBuzMgKTWg5BY6w0pw9XEcauLSPZz7dQCmamvc2Wr
 B5Syvi3GrTNRQWWxn0SQCMZANnVjzvWG12I8mmLIuNOP22Y4ABtUX10HZe7STgMQyL/QaPI1Fi3
 P
X-Gm-Gg: ASbGncvLl/epOWb7YRIdvI9AlUSe5925W/m4Gml31qYopSBJGfajNWaWmj5UgFrvuJ5
 ZOQy4CUDHwpwHMAMF43Qd0MyJNh9rkqvVMJ9XIb143XHBjtw4DGTzgm/lIobZ4UM8T03kvnmB7S
 cYBCpYBCmQmvESYWAH41DV6uXxaoD/AyYEetfGIq4B6KPxcvazolSLkgMdbWAeAnLWHAHxUtHZg
 C3lYUCWrbNCQJXViayNId4ygghSi29s66NBlrHuJgA6qnvi+nl4eWfd1PMsZj+ektgnpGjvbDWJ
 Y8HYrTLNHf2hTUIKTq52kNB7ZNPnx0DLIHUmVpSgiP3cfkvzLE6vRmf+8Tr3Y39jxXCEJv627VP
 /+nvIAhr850noytVFy3Y=
X-Google-Smtp-Source: AGHT+IGXXex+wNz9GVT0o7s7euMamWBpkIPOdC/hQzfNo4B70NtwGiAEHtEtjjPxs//mFKo8VlJjUg==
X-Received: by 2002:a05:600c:3587:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-43ebee8dc60mr32622285e9.4.1743693596062; 
 Thu, 03 Apr 2025 08:19:56 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16602bbsm24505315e9.9.2025.04.03.08.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 13/14] hw/arm/virt-acpi: Do not advertise
 disabled GIC ITS
Date: Thu,  3 Apr 2025 17:18:28 +0200
Message-ID: <20250403151829.44858-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
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

GIC ITS can be disabled at runtime using '-M its=off',
which sets VirtMachineState::its = false. Check this
field to avoid advertising the ITS in the MADT table.

Reported-by: Udo Steinberg <udo@hypervisor.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e7e27951cb9..38a9e6fe0c5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
-    return !vmc->no_its;
+    return !vmc->no_its && vms->its;
 }
 
 /*
-- 
2.47.1


