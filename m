Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14695C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0U-0002Jm-WA; Thu, 15 Feb 2024 12:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0R-0002Dc-JT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:44 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0L-0001ZG-MW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:43 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411de7c6b3dso9091535e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019914; x=1708624714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5xwpltx5l7qD+BagWyDh/IKXIed1E1E2CgPvP162Y0=;
 b=OmHmB1Pk3FatWh83WmWD2/UXfGP1uXw52nNZBzOOT8HmWx3biWJcx5vgzMUaKezvAy
 guTrvaDwkBSCq4Yln8IJLSy+AXjoK3K1qS2gkNG6UH8iSLSYO/B0jwVapbtO7CuUH9fH
 o5nXBEb4PxrRuM93ElDWDKMUP9p9YW2y5lBdHcmKNkoR3zsaBCYFCNmkBSqSmf2cTqXB
 KMnoklHB1zLwJ7B+loEijEYFzrNHFRE26bF4SwVpraNRiG/CyWgnYSdOmv7PC4B0336/
 n4MgIZFeK0v5LiHIaZQGDj31Xaz03OA0vXtleLEahhNcUXgKftACx4QIngFvHEAoKkF9
 k6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019914; x=1708624714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5xwpltx5l7qD+BagWyDh/IKXIed1E1E2CgPvP162Y0=;
 b=invfnKFGrOLDpQLOQT6tMw7C8/+hIqiwovRO1HrKMSC0SE6aLLzgwBWSbujVbuoRmo
 BgCKgFx55cpgJHlb1hma5T/zSX2Gismqx8/bz/YA+dirueNLKcAN2XvQSBmrHgYTwFqh
 chZvAZeOFBSVTK08eOOYGW1eLnqWHpydNDwj4aAQZ4PPLs2JeS3R8WPiG6BheOiNZpY9
 ZZr9RbIqI9VL541fgBsO00VpA+VZ7zuN48Qc5fuA2l1NYPt0gYa+dSdYNSFIKfcHqNV6
 0864YoG+H/bZsSpG79B3fuJlguv63Iad4lv7TWuwTdqELw8xBZ44wqB0LURJQo2GXYbt
 zWtw==
X-Gm-Message-State: AOJu0YxAl+3JAAnyBnuqPVTFlaAu1da23277qa29hp/gjoXsmWvvajJn
 EstJ0jIivlwL1973ryoDYg219K4MEYeC1s9Ky8O6VY2KsBwIdzWGTOiBbBS6TgGQn1CLTYuMZYY
 gbbY=
X-Google-Smtp-Source: AGHT+IHkyVHwpZXIvzvyuVFe6aodfto5yrGn0YoADHjZYcPwTEoyDB2vlAMqXkFypGQ946BRLc5txw==
X-Received: by 2002:a05:600c:3ca6:b0:40f:c404:e2d1 with SMTP id
 bg38-20020a05600c3ca600b0040fc404e2d1mr2735850wmb.19.1708019914626; 
 Thu, 15 Feb 2024 09:58:34 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c224100b00412260889d9sm1614375wmm.1.2024.02.15.09.58.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 06/56] target/mips: Remove MIPSITUState::itu field
Date: Thu, 15 Feb 2024 18:57:00 +0100
Message-ID: <20240215175752.82828-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Previous commits removed the MT*C0(SAAR) helpers which
were using CPUMIPSState::itu, we can now remove it too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-4-philmd@linaro.org>
---
 target/mips/cpu.h | 1 -
 hw/mips/cps.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b4788e1af2..d54e9a4a1c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1184,7 +1184,6 @@ typedef struct CPUArchState {
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
     qemu_irq irq[8];
-    struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
 
     /* Loongson IOCSR memory */
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 4f12e23ab5..988ceaa0b9 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -96,7 +96,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
             itu_present = true;
             /* Attach ITC Tag to the VP */
             env->itc_tag = mips_itu_get_tag_region(&s->itu);
-            env->itu = &s->itu;
         }
         qemu_register_reset(main_cpu_reset, cpu);
     }
-- 
2.41.0


