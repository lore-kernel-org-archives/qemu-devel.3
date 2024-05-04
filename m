Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CC0C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 14:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3GD2-0000SQ-Sw; Sat, 04 May 2024 10:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s3GCz-0000S4-TJ
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:17:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s3GCx-0000zo-FY
 for qemu-devel@nongnu.org; Sat, 04 May 2024 10:17:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ed0abbf706so4289525ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714832265; x=1715437065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p0tO9QlHbu2aBdDBPtVn1D8vAHNS4Ss1rjoZ+3y9CD8=;
 b=LMxw6vPWiGVj+dGjpHaA+oIJ+buhw8eWFMzQvmBP3MuPcg4Et3fW/ZDsCdaPDgVidP
 HD+gwy0RFUHFpx5xtl6Qa7tIvdqUSQwthrXrWAME7EaE71FhfiprBk4zonGaerJnxyri
 /xZNmT81NaSsK5HZ35ssqeOtryh2N5s3W/n+9FlpfDkxdSOGA9NSVVDG9f9gHWuIbjKD
 mp24ZN+xizr05KQJSZI/SIVE/H0xvy/z/zrODCSPU35N/7j8Mak746eH4W1y/AHOjG0p
 mejEXV1JZzsvrapE66t1gdeyg/8CTXnlJyzP/20NV+cdab/5cBmI3TQr9lZ0f9FjbOdI
 O4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714832265; x=1715437065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0tO9QlHbu2aBdDBPtVn1D8vAHNS4Ss1rjoZ+3y9CD8=;
 b=vXnuXTTOA1LHyokLxqW2o11Zi90mCDas57a0gVN2rBWksqYZ9YFoFfu+NCYJk+4YXb
 RUdFpEAa16i2Vhrb6xmfN3sb/6qrtka1C1draM2XJgeUCWJnKFxo5M3yWMP8jTuVxfOh
 CI1xZvT37/90d2trDG/971TJR7qE0Mg7Dlqf9HT5v1pMcHnqTq0p2iCW07lIc/Zbxg57
 rPFyCwTUkgQA+meLk/HC8PaolueVrQ/6MptPsHKGsEjO2b82g319Uq6GNI5lGJ3eXNIZ
 bzejiQycTnNLfrNDN8Xl1SPW7SAN9ZPEs/KgYRavfD/34U5SVQmnsb0rracRW3bvDS0v
 wAKA==
X-Gm-Message-State: AOJu0Ywi3eiZMLAG8oBbxdUrt0sBD0wFmRZqtZ++Eu2sOM6tmUP8K+no
 wgRcehCL9JwwqJk9JXy1cbbhwLzbnxghvQkw79BgETE0t5MFOCU+ov1Dag==
X-Google-Smtp-Source: AGHT+IGpK+i9rHoS9L2NMYEHdft7PNITI6QQtFDU/fFLIZS/nSgAGbfz60KelOb844/HXXLPer47Gg==
X-Received: by 2002:a17:903:1c2:b0:1e5:caba:7fbd with SMTP id
 e2-20020a17090301c200b001e5caba7fbdmr7551619plh.44.1714832264858; 
 Sat, 04 May 2024 07:17:44 -0700 (PDT)
Received: from localhost.localdomain ([103.197.153.228])
 by smtp.gmail.com with ESMTPSA id
 jc18-20020a17090325d200b001e85d0b6a7dsm5079765plb.293.2024.05.04.07.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 07:17:43 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	kfting@nuvoton.com,
	wuhaotsh@google.com
Subject: [PATCH] hw/arm/npcm7xx: remove setting of mp-affinity
Date: Sat,  4 May 2024 20:17:33 +0600
Message-Id: <20240504141733.14813-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The value of the mp-affinity property being set in npcm7xx_realize is
always the same as the default value it would have when arm_cpu_realizefn
is called if the property is not set here. So there is no need to set
the property value in npcm7xx_realize function.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 hw/arm/npcm7xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 9f2d96c733..cb7791301b 100644
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
2.39.2


