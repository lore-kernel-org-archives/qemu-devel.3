Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D2BCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnn-0001i9-PW; Tue, 02 Sep 2025 09:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnb-00014Q-4u
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnX-0004ZB-Ov
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3d17731ac0fso3099155f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818697; x=1757423497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=evqzluOcCtsmXOY5TmZDpJ3IXmsif43fvvVs3oQU2Ns=;
 b=TsGlSqwA0aNDkJA3FUz+45VXBBm+9ICSnKr2Xm9/vjZhY/DoQyo/UQFWpgLI23NGCR
 5RuvPLzSziXSJjBQu3tCniXi/7eIexdk+0sQSUpzRtOwbexgR2mH6SLApDnjf5K055UQ
 EkGlTX+fPjusv5aEXnRUBGqoKF8y9KUgVzOANukqp6RbMSyeP9GPp9J2sGSixyRsBzOe
 iGeKml2C1K5G9RkDMUcG1N+4LtRzeHBEdxLLJjBsIXUcPC7Er5nJru7KP9GUXGwNLbOR
 3iTqRBaB2esPq4e9ktabvnwN3MIowbs7NdOjTaUlKfl0vTblDN8/Q2sepUr7/elfcEfN
 +hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818697; x=1757423497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evqzluOcCtsmXOY5TmZDpJ3IXmsif43fvvVs3oQU2Ns=;
 b=wwA7vgidBtgrPn/PbbU4YWGxvWfD2OHpm+UIo5v0W2rTEPa+KXYlLjWrpdH/XYg1Y0
 t9jkbe3nzt902m2EPF54r6jyefs/Ji5RrXcA1D45poNkVzCzT8h4UJq4PCWzv36IfLh7
 NBWXkN7ym3gcHAFW2fMIhp+z5T6fEUdnT3XzjEecuWYsg/vYywnBg+sv/JxlsKi07sQi
 Y+EMcW0JIIV2vWqyER/emw2ubU/DnbY79FBE7FIjHBGdRJ/BujQvxX+7/uvesAtkoIve
 58Ls83pd2xkt07s011yoSLvTnnkY10cfJEtIlQtXvZxPo6+lgzr/ltkWscz+YxVhrNpX
 Zr3Q==
X-Gm-Message-State: AOJu0YyAFetLn3We2rXtr2DrQce7XoSv3PTCeK6EdMqU1SldOKmVZG5P
 rRzL9DybuPJq6Gw8fJ3Kri+e8eixUoN714Q2ksZ0qdaQ3u9D9c/qQRi8887kvE6LlbPpNr8Qn9O
 NKdNA
X-Gm-Gg: ASbGncsqOESkV+9D+qnMziwOr5F7yuJWzJ8AbJU5eERNHJsymmKs6k10NLJF/b/Uo7V
 NGGNmXcCvaTF0PDyPbSbj6tS5IZ/kJPD9iBt3n4QdhvK5LpjRLZroeL+/6wfmu0GXBAoWV66caB
 CMemaW/b5SeoEclJQ0Rbxd1YQZ+tjtFyfdegrnj7yqkm4gGcdSwjQRlIzQmjdyrI7dvVNAdu9EO
 Vs9b5YfVAwFOzzjR5XXmUsck1ZIQRc7lhVNEbJ5xKSTRCzKajQU+I0gP+B0HO5JwKdWPUjkLLfb
 Fm7LSy9gwIhNwib8lwFtpEcO4+i3WJCrBBNM+ZU8+RSYuMD6j09S0ILMTj0myaGgH0nPZr+VBvZ
 dQQhViZm7Qj+19aDgt4X1BnE+ABc6nqYzR7topBwj9Qd1OrwejOcSsR4zjvO9a2GGSNlTiNhi+y
 BdvfdIEOM=
X-Google-Smtp-Source: AGHT+IGUJo5I3kKjgFKas4KrsIDBmmrQ6GeCkU3KhUtRz+obYaGzQn3yVl8PiiThHB7C+vntMtaJWw==
X-Received: by 2002:a05:6000:2387:b0:3cd:cf31:d77b with SMTP id
 ffacd0b85a97d-3d1dfcfb96fmr7765592f8f.37.1756818696564; 
 Tue, 02 Sep 2025 06:11:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fbb3cdsm3379500f8f.51.2025.09.02.06.11.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/39] linux-user/mips: Select M14Kc CPU to run microMIPS
 binaries
Date: Tue,  2 Sep 2025 15:09:54 +0200
Message-ID: <20250902131016.84968-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The M14Kc is our latest CPU supporting the microMIPS ASE.

Note, currently QEMU doesn't have 64-bit CPU supporting microMIPS ASE.

Cc: qemu-stable@nongnu.org
Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3054
Reported-by: Justin Applegate <justink.applegate@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250814070650.78657-4-philmd@linaro.org>
---
 linux-user/mips/elfload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 6f1880befcf..cc5bbf05ab2 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -37,6 +37,9 @@ const char *get_elf_cpu_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_MICROMIPS) {
+        return "M14Kc";
+    }
     if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_M16) {
         return "74Kf";
     }
-- 
2.51.0


