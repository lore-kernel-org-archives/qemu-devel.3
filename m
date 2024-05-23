Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1CAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATY-0007u2-Tr; Thu, 23 May 2024 11:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0007js-Dr
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATG-0002S2-5p
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-351d309bbcfso1458892f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478508; x=1717083308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EAAlRYMlBTnMK71N/Zu05HtnM34HblCxoLd1v+E1rkk=;
 b=Lym/sY6fU+htODwWF/IHYLuOjZFhkzCle+VAjC7O2txt140VESktQ9fJ4EPVM8tOpa
 OFez1U7IrqYJ0R9r1OAILn8r27iK7G4Ls/27nj24cLwFT1mfjWU+AwTnDqOk8AjZSLQS
 bXxylHUG+eJNtnQjQ1x5eiuTf3qNqJ5nORLPm2koyTBnsYiWPOM63yDg/MXfM7gz5TQr
 Sm0YOrOQeVEv126Csbw/rEJRxGxr8p3DMU396oRUZ0h2Oh0DNZoAmAcFJOrtSiiahM7H
 1gM0V2Q4h4gTS+lpNbXXb9nvGYgAp/IAAcN2kLouDMoIfR+Dz6bcbi6kkJ1xh9e2USEN
 VJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478508; x=1717083308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAAlRYMlBTnMK71N/Zu05HtnM34HblCxoLd1v+E1rkk=;
 b=ACvsDNM6Rax+Gqo5evL6hr0Q7wTGrWRwHi972/w7Qf2nCRZxamWbmMgaeD83A3ViHf
 QefZJhUBSIZGhC9eo0604y9PlGXGDFNOac0yXlr+RTFirglvlKoESga91mTBMJRdpApH
 N8HFu5XUlPIsWXtKWx+no3jSLmOPxB8iWnnh1O8rxw2tWU/q0FjMMmrnf+phTsFhBrim
 dEWxJIrFYgU7e0BoExxXoBP4jLha1ZNnk81GwpFDYQKn4+X3tWAm/oN6qDFhaLilAKmN
 mDb+A+FaukU8I9jI6MAVkG+lMclV5pbgAeeIUfJopBi0FbUoc7PCFN/bJIuB0klWuiFX
 9S5A==
X-Gm-Message-State: AOJu0YwpjrRc+pihQ2c/fPcb0ImZDBOXY6KNbVakNT89cGm3IeFh04jb
 Q0TmJiCq4ISWv/C03Suzd2RS+sOjU8o/rir3Pqmem4XKsZKgTRtl65GVFfqy+7VUnO9OKd2Tbyz
 F
X-Google-Smtp-Source: AGHT+IFOWp+NOTyErO+VBqBNdPwU9y6AfwH0ZVxVG8LWy5s7lbbXP4FOg172RlBfWRj1eIvkOVbIdg==
X-Received: by 2002:a5d:4650:0:b0:354:f2b0:ebdb with SMTP id
 ffacd0b85a97d-354f2b0ec33mr2876330f8f.12.1716478508646; 
 Thu, 23 May 2024 08:35:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/37] hw/arm/npcm7xx: remove setting of mp-affinity
Date: Thu, 23 May 2024 16:34:31 +0100
Message-Id: <20240523153505.2900433-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

The value of the mp-affinity property being set in npcm7xx_realize is
always the same as the default value it would have when arm_cpu_realizefn
is called if the property is not set here. So there is no need to set
the property value in npcm7xx_realize function.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240504141733.14813-1-dorjoychy111@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 9f2d96c733a..cb7791301b4 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -487,9 +487,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
 
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
-        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
-                                arm_build_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
-                                &error_abort);
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                 NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
         object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
-- 
2.34.1


