Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3ADC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXh-0004ln-5S; Tue, 06 May 2025 10:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVX-0002HE-7c
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVV-0002C6-FC
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso25468245e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542572; x=1747147372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SO9Xgfyk1pTDBVZ7OMnTtvlGhHiuLgFtLd7XyJg4VAo=;
 b=LfG9PCFqmbG1S/g0urq5u4ZxnLk2Mo7s7IpnPGhUyRIZK4O8A2b28DOaeI2thdXKKY
 eRaxLvpOnWh+h2+3LZ+5MM6m65Pdc3/QVoux7ftYE75URe9jYBsPFiNr7LCkwtK6vVSi
 tu/Pwdfz4+yPa6VqB7V58vx2olyXRFit8wp34WJ/lQGol6YUpizgM91jxodJfNUoP/d6
 e2vEk+VIs9oDxbfWb/1ny+K3e/ZE90m/mKQk3joHkpfxOYRmYsROQHFf/mWBpU6IOjtX
 zBkq2EYD4t/+xoYcD+TnIueS4t7R63iSOyKaSGm4/ZJCLe1Fwbe+Ju3fRhDrGtALBMvY
 ktjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542572; x=1747147372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SO9Xgfyk1pTDBVZ7OMnTtvlGhHiuLgFtLd7XyJg4VAo=;
 b=gC5hGLKVhetDnUNCTdFAbLrErTMu3rN+Ec4lEt81rfzW7ZtMeOhyI+tyOK0coQL/3i
 oYE6Kw7QovYHCU2BMGrNz5TFqjferX6l8ccKUc3lq+sNUCi17u+4mlApIvqL/eBwvNEJ
 Mm9KwMSeRBAmPW92qIkWaruTnXpPieDI9eLo99Z/l/PQ1YzK7tzXPYxoEDyxc75HeWod
 3VQafpmsI6XofkUsl9Xnu6fLlwGf67hKOxRa3XML4I5eKJYjXRGRzD+fsWyqfVosFADT
 PnqTEmZG1XoklQqHTppjdvz3UZF8u4NmTDbawS/GtYS2EVtP1EmKiJghW2LsXxdUL3Yf
 8Oqw==
X-Gm-Message-State: AOJu0YzU8258NW6lgxpvwj/80+geAbSUDHO5grKpUEAciDqvLrzw1/FV
 CDcMLcUrC2AeW5EfVq0liBMBrcpKk66uLH1IWm9xLYk2mmyfnnLiUUPLRjp5b6sT2MJS2Q8XWGq
 0
X-Gm-Gg: ASbGncswg7ByIcZv1yfAIUxeO9Sk2lQQB7ZCijwv9cfuaVKPvunQseFE0dC/PPQNnsJ
 Wzk/GXk6r4Qtk0UwOiXMetas/8v05g1/z5p+n/100N+GHmO7xMMPzL51eFV5Oh7+orji5QmZuUE
 FlXjFvEOFZEKZxWZ+mVXQjjndDmsmkdCVpG+p/gwKqMmr9gsjrOVk2CCayjvwu8AsS/0pKBKyv1
 OuVh7CGxRL8qBvmbZ2SYdB0xX3/oneHdahs9H4C359V4XJYu3EDrzB4AUDOAYJSkIskiFaFCWr+
 LYTLikuTJOZHo1mRTJ4GGpyyoDC5EKQ1oViy/JAwDHWl+6w=
X-Google-Smtp-Source: AGHT+IFBMzUNYz0r5XyFKF8EweUui3K2417hFuzcJ+x4ulHphILN8uLrUvE9oRr7Vwyq6eq3tUWmVQ==
X-Received: by 2002:a05:600c:ccc:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-441c48dbf02mr109325575e9.17.1746542571763; 
 Tue, 06 May 2025 07:42:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] hw/arm/virt: Remove deprecated virt-4.0 machine
Date: Tue,  6 May 2025 15:42:14 +0100
Message-ID: <20250506144214.1221450-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-id: 20250429153907.31866-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61fd8557683..9a6cd085a37 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3562,10 +3562,3 @@ static void virt_machine_4_1_options(MachineClass *mc)
     mc->auto_enable_numa_with_memhp = false;
 }
 DEFINE_VIRT_MACHINE(4, 1)
-
-static void virt_machine_4_0_options(MachineClass *mc)
-{
-    virt_machine_4_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-}
-DEFINE_VIRT_MACHINE(4, 0)
-- 
2.43.0


