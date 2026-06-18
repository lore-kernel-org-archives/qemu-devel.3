Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE3BCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAH3-00022x-0v; Thu, 18 Jun 2026 06:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waAH0-00022W-Lx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:47:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waAGz-0003bx-4b
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:47:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso576777f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781779619; x=1782384419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bZ7SsVycbgZTnv8WK7JZ8rNkpuaFgDuXf7rpEI1F1Qc=;
 b=oWhdRgfVk89mgt3QElpWZ5hFw+2bD/I+wWjtMgqYNTpo1TfGVuV96FK+sI3XoTaDng
 fBkpEW+8fD+DuEBqII2TE5raY0a9l06DuCnZAVEXz6gWwZANNxehoADm+LG6mValY5Bo
 RfIRY8Q9DOdGhiGBG+bHBFucAoYOcr21MOUM/zopju4j015viKqtC8YJPBYaCS6rHLDI
 2vvxKEUD2t/jTEyCkz79LGNMd5DH8ZzDaTRcncGk03XxqgLrrpZyKOqEWGOuP0ydgYef
 N4W+UFVWZ+lppjf+AYHXBj/YHIG/YimKSUuO3cIqGWjcLlghQtcaPBN9VhgdYFUiuQI9
 AeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779619; x=1782384419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZ7SsVycbgZTnv8WK7JZ8rNkpuaFgDuXf7rpEI1F1Qc=;
 b=DJK/MrSMfCoK6fhLfdL+xj+6PYA3XC1vFJOfKEIuKGtUeF98VusN6tNg4pL0XcwjtM
 7f0Cwe2spZgFfZlE0bPa1R/V5Y2SvAD+f7ywcg49tivzHTX2FfogLT0Bc5s0Wv4Z4LeN
 fw94n+kqM3mDSPlK+Z7pTKrAcmQgsxY0aqUXsdeMHRSQDH7GbnL2H/PD69VvQSBgBz8Z
 2OhMuVq8RPHcKQ42FoyeZW9FxuwN6gtDJao90ZuzkWU6oNgPEiWAhfuCZ19k+8nhexUi
 cUVGqVDT6sIZXnSLNRJHlQziye/KlenOpw4pwk2Onr4JdCdVQLZ2BzzBRm1OdZmlB0BJ
 dHhQ==
X-Gm-Message-State: AOJu0YyYis8LZNNcjCjB/sLw7Xd3Zv+hu3S6/skLqTtUnc7WK1Y1zUVG
 xZ/np5ID756LzUwK8cy3r81aTEE8RSET33S6BgWbOeQjVyUiykTWz2FG3GIWKC0VmNc=
X-Gm-Gg: AfdE7cko2qsvjgCT1XhC9KqKEBCCfJ1cLWXks+MadZ0iGXqtwLFGP30s8NVuRTISxPC
 PW89/2MlPyp4RXv/E8/Mi4LQvulfJo9x9xT2V80mDmdyH5wCgjibxgfay4xYTFbMUstdXvZMtk2
 +4zd1SmfEyFHIOegcAXu/4oR9QkB8hp3uDxzIj6LNWxvA/ex+dRnCM0sE7PCCf5do4Hd/UTVLVm
 BHk72fxoMgePjoMhZL6SbULIaTS4IJ/vMuLYO1k/TNN/ieZ+PchL/iNgoxVGLCuIMMmRaHKuzF1
 Ufs4Tqu8foIk72LxI9FeEVG0SQBSaJJoQMMtvW5HbHcVYKkJaTwn4puBGoiCeI21Xa3xsYKM/Gj
 D3if2v84YBLeJBdOAscQeqivKcoyO3P9EBq0RtRNdx8ursmgRocJGt/ZdPuivtNcGtlDgPd0Iie
 Sgsb0l5AHDkFqf
X-Received: by 2002:a05:6000:4285:b0:462:38d:c433 with SMTP id
 ffacd0b85a97d-462362764e9mr12666998f8f.12.1781779619194; 
 Thu, 18 Jun 2026 03:46:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c5266sm67885608f8f.29.2026.06.18.03.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 03:46:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 410295F905;
 Thu, 18 Jun 2026 11:46:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Nuvoton NPCM7xx)
Subject: [PATCH v2] hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx
 machines
Date: Thu, 18 Jun 2026 11:46:54 +0100
Message-ID: <20260618104654.3840263-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

CBAR is an IMPDEF register and according to the A9 TRM [1]:

  In Cortex-A9 MPCore implementations, the base address is reset to
  PERIPHBASE[31:13] so that software can determine the location of the
  private memory region [2].

If it doesn't we will confuse the Linux kernel as it probes the system
SCU registers [3] and erroneously assumes the system is a buggy Aegis SOC
and nerf the emission of SEV instructions, deadlocking any WFE's in
the kernel (or QEMU smpboot code).

[1] https://developer.arm.com/documentation/ddi0388/i/system-control/register-descriptions/configuration-base-address-register
[2] https://developer.arm.com/documentation/ddi0407/g/Introduction/Private-Memory-Region
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/head.S?h=v7.1#n550

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>

---
v2
  - rewrote commit message for clarity, added links
  - used arnd's arndb.de address
---
 hw/arm/npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c2bbcd89dbc..c27f149c04a 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -492,7 +492,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
-                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
+                                NPCM7XX_CPUP_BA, &error_abort);
         object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
                                  &error_abort);
 
-- 
2.47.3


