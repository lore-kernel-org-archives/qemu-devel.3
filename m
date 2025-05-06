Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CC5C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXP-0003Ax-0U; Tue, 06 May 2025 10:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVV-0002CY-8L
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVT-0002Bm-FU
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso25817165e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542570; x=1747147370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2RTfICwtk/Jm8AeQp+Va+JmkenzgE6wYnGRvodGXX6U=;
 b=QtdyPxeaG+XVrDKPhIz0Kj49imkMiH/LUMUDcctIQGER780YBwxSoe980MxMc3v7oj
 wcxGqb7hiUyIXSx/6aQ4SmPSzn6zgZ0LP9ty3557ZWOlbOhAOpoGBNe5DUEVTvqJpN8y
 bMtZsaINsiP+wpMh2gY70nMTQGl1BGeuki0uBrRqOjPy5FWzWtYB0RxoPrPZDvr/uFGx
 bJZcub7c2yVY7kQfSeBfASZoHbCIWnTmQgNBPy6yzztBC29QvxAc9h8HMk8ZFGUjpPpG
 fDfYkAXE7I4YjU3aGCRLcc2qbzG75dfMytbiz3wLnt3lfAaR/FcuiMd2maWYW01ee7hu
 7Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542570; x=1747147370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2RTfICwtk/Jm8AeQp+Va+JmkenzgE6wYnGRvodGXX6U=;
 b=uRFk4FV1WUYnFS8DaF11mplJS0db1o6QKtF/LsD39l/+SIVCPC7kG4GaOa+x2v8n8Q
 3Q/kjAWcVnQ/g9MzUFJHJwyHsNlppz0KlTafM07jU5Fl9KzfUSgkocvvpUfuEt1tAQsi
 oRa4imWmqq8n+pcZv5gNTjBOFnMgisI7w/paA+ZCScqFgZ+0DB5LOGra57aVvGmvT/TL
 SelmLu8CZKph1pDSvi+UYkZ2ce1+7QciylnBg953axTq+0yEnrqEKV1exoendOe4n1Cs
 C+CMd6YjvLuH394uFNJi7dQIbnF5lZ9SoIoQls8YYgwtKn7dKw5n5RRmmgryhQsVxRzV
 CqLA==
X-Gm-Message-State: AOJu0YxuIOZx1120IZHMjVU5zOlKYMI9EksMbIrNA1ix16JoHNdJh8af
 qJKQpVGRvkcG3YHf3bvQ6wimzYjLfgTWgUmMtiTgluI9e3KN5wZAMeMigftyXpz3EsIfdYsuRn7
 /
X-Gm-Gg: ASbGncuvRVPxdasir0mda4pBlT4fStWhKaOMa2AvnYhN0RGlammqz+e8zATAUNkePEH
 Hhqqkr5MXjSfsiwJEn/5AJSKiXe2Vpc3P0ILuNSjEMG3UA3FlZBfoKGyLzOB1cXUMOtN83D4Xhx
 Zosw1YlJQythJhMjTpwtuN6Ri84ylcsVkETYLHl8APjllplVKe29tqe/YVhl/gTwSVHlDzGJOoG
 WpnuVqfNQJaIgnv3GjqbzJz0HypccXyQfaB1Lx5eVswo9Oe524rRchkOb9uodT4dHYdxcCtxrzW
 xl8f/e3F7OI5eV1UuY88JQaHCE3dXgjKSGevwJGnfZi2FM8=
X-Google-Smtp-Source: AGHT+IFsHV+UzDktsnBeVK9enPIPNob7Own+QLfi481qukOSYYO6r2P6q0l3wr7rdyEXynbfF1a6Sg==
X-Received: by 2002:a05:600c:1e01:b0:43c:f050:fee8 with SMTP id
 5b1f17b1804b1-441bbf33f4emr135808365e9.20.1746542570100; 
 Tue, 06 May 2025 07:42:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] hw/arm/virt: Remove deprecated virt-3.0 machine
Date: Tue,  6 May 2025 15:42:12 +0100
Message-ID: <20250506144214.1221450-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429153907.31866-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 03fef07c9da..1e4841f036c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3576,10 +3576,3 @@ static void virt_machine_3_1_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
 }
 DEFINE_VIRT_MACHINE(3, 1)
-
-static void virt_machine_3_0_options(MachineClass *mc)
-{
-    virt_machine_3_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-}
-DEFINE_VIRT_MACHINE(3, 0)
-- 
2.43.0


