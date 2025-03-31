Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9126BC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNNV-0000eQ-BV; Mon, 31 Mar 2025 18:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNT-0000dI-Hs
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:13:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNNR-00077b-TQ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:13:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso31880845e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459184; x=1744063984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esZKfQmSZ/gsBmw6ndgWUyspYCTEzTvWG+1YHzWaO8Y=;
 b=EVoCxzsK3NiAhYBDTsf4sRxx5mqWAoYgXIaLFCkq5/o5AXMCFBQAhCLcyKN5ayLqEj
 33V/Xdta48kkYAdNVBMaWpcyCqZC3H9gYQIP4ZhzwEdfhYR/t/kcWfqtF2kWVlmjguYE
 wkxw0/hZcbdzCeK4C419hnvkO9kqTYoWOgVTwwfqw6OrqNN6CH9nylINX1h/rqbYpDxK
 oK4kyMB6DN9RN4FU/dXI9yp7KJrOGRpIy3vH6YZGFPRLtxEJH5oicjmOH9hvftVO+JAc
 b8GszzqbYWNHCDL2tL9TksfTG4kgGXSCX4OcClQMR/7+0ftUeuuiH+bFfmFbUod46bns
 M4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459184; x=1744063984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esZKfQmSZ/gsBmw6ndgWUyspYCTEzTvWG+1YHzWaO8Y=;
 b=sjPR0zSIovoHlqib+BV5l248r6QvdzQr1sGrmbHeVxmg+Nxpf+mrnw6OkB+53pn2W9
 iEicmhMB+7yfuqZreXSv2nPU7Q8kMKNLZgNx/Q86RvQ7WFl8YwMBd8Ds+EalbctOo2D7
 vHVCmcRkowi/fdX0cWxs2bIg9mPLglWKl4uWrzTB3KXHT6jMFqZzVMb6IKzbDGamR5zd
 6UXJvLFJI2Enx0utwAPDqOHrwy+Krm/8H/YYxm+w7S7TfF+LoXaitK1TjtkCcnzEGQBI
 AfPbjHzpBjiBGGUhHBj1hbPOMFol3mPEXhE9CR8gkXpjWqvpwGpWyC98pqpVnR/10L+N
 D4nQ==
X-Gm-Message-State: AOJu0YyZF6NH32RO6TjxkOz7A0iAHvl+x0egZDj+ysAiHyOTmlstLoQ8
 1Te6D3BlF2+m8S3FAFtzaLiFuGXTQI3Nk8M2iKaYwaftpx9qXl7qatWi4rE1aGIj057bRuSexOQ
 b
X-Gm-Gg: ASbGncsGuxpvTuzVj//wtXd7N/3UBlBBNH4vQXXruwkBnam/QUfMiG4gDnIC8rLFZUX
 VcS79veggZzEiX6mRWpmm3UQBIFitgye0A8DuZFNCEELeicsynmKwdOFaV1ryhOxKFUv8jckw9h
 8lOBS0ciEMayPXyUuXL60QJexejrK8XjNUA1kgMleotrQhCtcj5vMXXaBHcb7E//hPnl7b/GSpF
 AazW0A04hK7PqAzBxWxvJwntjSHW22Lm4LT1V3Kg4Ap4oSTsTJRUHPInn3KTq/n/8cy5pi6kjZn
 xXiUY3gMn1DZcwyCbzEMzF0AhXPw6e8DObjCqoz5SW36eWwvijMRoh1GcFOMR6p7Na/ZDeQLeJN
 vx+DslQuFBlunx05JtdI=
X-Google-Smtp-Source: AGHT+IFOV1IHoVr2WN2UII1ff7fxUA+GtFhZ5tD+lEQdWSGqKdsoN+n2KtMhtyb2E5FVZFgZSq/B8A==
X-Received: by 2002:a05:600c:1d9d:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-43db61d894amr103198525e9.1.1743459183777; 
 Mon, 31 Mar 2025 15:13:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e834a5sm181906515e9.13.2025.03.31.15.13.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 15:13:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 4/5] hw/arm/virt-acpi: Do not advertise disabled GIC
 ITS
Date: Tue,  1 Apr 2025 00:12:38 +0200
Message-ID: <20250331221239.87150-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331221239.87150-1-philmd@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
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
---
 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index fdc08b40883..b26f0ac8585 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
-    return its_class_name() && !vmc->no_its;
+    return its_class_name() && !vmc->no_its && vms->its;
 }
 
 /*
-- 
2.47.1


