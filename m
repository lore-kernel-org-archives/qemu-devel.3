Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C4B10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bg-0006Ml-Ck; Fri, 27 Mar 2026 07:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bd-0006Li-9q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bb-0007Zk-ED
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso1185899f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610226; x=1775215026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgRWJYLqD7uzJGEY2M5NKnbTbzCDI5DLqfNZPVYqGzg=;
 b=CQWade08Yl5A2Qs+lhYaVnE0Z0OTY8q00geaHqKYHTDfGJDsQ6c2JDt7ljCLHEa4P5
 3QpTDhW7+sh8g2t9dkBnn467NKp6c6VcH0oKkSqyBZeL+mcFdC2Ope62R3iDOuKpU7jD
 KTo9P3ZHsprNqzEn7pH9N2BX/IL7u837TIZFWYocodJmNBhdogXN9QGonqV7qd0cP4Y1
 W3KZggowZqwfFnIEnTRrFqJKlaJdl8U6arpGjo9dt66VQm9vIjhpNKdsd/lW9dojL0Re
 Xdvy2wwwq6chyzLrcC/vhfQ6vT8LrfPeJvqq2ff/SevdhtD0Ed2m9YAQd6By33n/Zruw
 74Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610226; x=1775215026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgRWJYLqD7uzJGEY2M5NKnbTbzCDI5DLqfNZPVYqGzg=;
 b=kqPJ7OJ5RR7hZYVPHmF6ztwC2V5MN6ZwT9bPF1owwwkEXiCU4NvxrX46r9cRBqSx5P
 1Sy15Qj1S75BHa9RC/ItwITiJjh91gNovslcBjsZ3Awy8Im5D6Cg30NjJ4wXa/n6mSFg
 Pr7EX/CIRUrfV+E8y3iWGAMqg4kl9HqakO/DU/6+Smc6IYntzTrMphRAeoAwYiRf13bw
 u+4SSt9m15saSscOwMmkRuHIrRs/X2DYVaMcpEanXPFBkVJQW+Cv8pjP8xoGRGFsTXlx
 36mvPjCmPEsPJbt/ZdSvMlAVDShFrAHaMOiKHyuT26E6ZJX9/r9TiP0vTA4mBjIaIfgB
 R7PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3DOXhfxxZWh7wJDKMIoo5OatW+pyanWbAshIEf5WaA7q/t+Q0JFe0r7fdwJ6lriGsvrqlOTVDDfRu@nongnu.org
X-Gm-Message-State: AOJu0YzWou6bR5xD3AeIJpX2/Yybi/vyXrDZN/dh99UzPW2ufi3B5nd/
 N1ds6whGbwh1BdgFEOs5R96PDbO0OkpMx5A87Ubc87g/g8GwSOf06XYq/5GgRpF+6LFgdgHjXdA
 8uJ6fsbU=
X-Gm-Gg: ATEYQzxiErjcx/MZJRJLoEqyq4fl7wVMdEKRftUZ+JJkRBWkGswSizXRU5kTZ2gp7hT
 PcJi8dzVkJmVmdUw5wdG73a1F9X4DxTvvJ9/PsMWeMLufIW92ofsuK0NJL6T++xRx3qqmSyGWbF
 dd5PsUvuvQQ9aOvt4H3+L7tfTwsYVJcVc8/0L2cbEKQE/bg1Bbs9ILmAdTn0dHgxLplKIc5JmKp
 15DQHJuW5XOS7CYF6drpacFoYQO+Jh02Md0SWHtgcONYXBPMEWG/P4bVT4y7+UpPUNYpMyWSIPG
 5pXZj6AwgrdkHbriyqscX0Ej+K8diy+1nC/0Vj6nBDP3qjsX34XenC4a8s5Q0QmUaTrSnXG5iny
 EhCoMjFlXqtqDbTd/M1p/YHVCxDOx7qj5qf2xxPWboGivmIDTOMk7itQrtbI5y5ypllCYHI3Hv4
 3zfpwYjtTJZBOFAhs3mueq3OIR9A5jYHlzx6Lq5bIqF8wu2IVPDNltqg0CdiVnnKSVXmn1JH2jW
 wv6hFCFyW77q7osa5FMYEKlkrXLbDc=
X-Received: by 2002:a05:6000:40cd:b0:436:3707:2bf0 with SMTP id
 ffacd0b85a97d-43b9ea465e0mr3098628f8f.35.1774610225672; 
 Fri, 27 Mar 2026 04:17:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 04/65] hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT board
Date: Fri, 27 Mar 2026 11:15:59 +0000
Message-ID: <20260327111700.795099-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When building the Arm "virt" board, pull in the GICv5.

We haven't added support for creating or wiring up the GICv5 in that
board yet, but adding it to the Kconfig early means that the GICv5
code will be compiled and so we can have more confidence that the
individual commits building it up are correct (or at least compile).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4e50fb1111..e1a6dba1e9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -10,6 +10,7 @@ config ARM_VIRT
     imply NVDIMM
     imply IOMMUFD
     select ARM_GIC
+    select ARM_GICV5
     select ACPI
     select ARM_SMMUV3
     select GPIO_KEY
-- 
2.43.0


