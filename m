Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F931CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtD-0002sy-H5; Wed, 24 Jun 2026 06:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsi-0002Xm-Pi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsf-0007gX-Ck
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:30:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-46066e640easo577538f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297052; x=1782901852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T72NDyunHLyFV4aqpIGKGdQkRXR7DefmzidasatP8oI=;
 b=suNTlAYM9iLa4ccgIFxx2FSEYBAN3DzguP+5eYR/5OSkr6HSidzuWoOCMZoSkOov93
 IGVa0UzC7v2QleIGzZGn17J41Tbo1pFqtdgRFxz+qb7iRwHhdFExSF7GjzC4NapWv+HX
 hxI1/Y2XswxpmXQ2vrxuoYRWZF7I1WP8zrbQtop2m3wImvk0KGfJuCPkXvs7GChBpMa5
 ZLxIXeSgFdAA/VVdXcj1tSMlkI4TVnWXrL03sCaAHVwML58ENMuHW0kLa8d9As2+7etD
 hg4vHjH7QC450GQPj9ln0LBIelM8uYGccKfShTZVD5jvGT6mfi1H0YvUXnqPH0obkKjr
 ZwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297052; x=1782901852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T72NDyunHLyFV4aqpIGKGdQkRXR7DefmzidasatP8oI=;
 b=H7c71g8M+zdJyQab6MNz8z5DhYCLgmwlLbM9enUV9WGjZeK4UHTUpLwGNLk9kSzb+X
 iKN6mdE8w+4KHqWHEKwmqx0Hwp0FRIkg4QUwhLsd2IG5NiFTmOadNphifP6MwQzieEas
 h/5IZKabrJm8s1nsc5Dgl8gJwIi40u6/ZnGDOnRvFh1crfKbxcukF/CqgeNyTu1Fc5DM
 aLS7fdhW023DdTXcX073Oonf9SKGXn9EXVP2Ljc1IGPJDia7H2mFoSf2C7af6PRqgCRW
 L0Y37HPtzoR5DAHHd5qRA4THTf7WxNMhz7pck20kj2G9jELeVwgSKnHRhpkeFK3lgF02
 +Wiw==
X-Gm-Message-State: AOJu0Yxs981pLmF2di5PgQMuqgSau2cfaP7YEtdRgE7YhjTbZkIyvT4V
 AZSJkYNV7L9DvOrzV4hiAPAET/0ulWYvZGPndc31lQGEd+I6mvFQRQNh9uv1BDCgqv8=
X-Gm-Gg: AfdE7cnq7yvT5pMNSWACDsl4vUoIbI+dvJLHPeds+QnwQ+fL9fbVmwf6csotPB/Scjw
 umVpgEdCvf8xMCKSMJENQze+cTHgDidnzItj8UASN8ba77VFDDiTM8ZQJDacu4U3on0rKaPaV5M
 qoWE3s9QYkvzK0zM6B4maJNM8uaoVSjUTSeFWTQa3jw8HegMnlfDfQbg7Wpo43+rGXBjDTWI+f4
 Xs28rOmhDS57zW7o8s3L6w/ao53fFIuvNtNSBVTIeFFiT+/s4rhqbMbbeT5QJc7rqClHVqqxp27
 7x2Dl7/UBMaAs2wvqTOx+u7HxWmLcNb5X6KWGOC/UatZPFp5XGXbaUyDMINwSh3iegiCta9BXu1
 e1LRErCZAjaW6ySm0qtLIoyL2ogC6M5WTy4t6lYO7k4MmSd++rmfo3wwvIuGe+b1I3jNVRWhwHf
 rmKMhgutDo9Y08
X-Received: by 2002:a05:600d:4453:10b0:490:c2a3:3303 with SMTP id
 5b1f17b1804b1-4926088046dmr26636395e9.34.1782297051526; 
 Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c6csm5921884f8f.14.2026.06.24.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C91325F845;
 Wed, 24 Jun 2026 11:30:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v9 1/7] hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx
 machines
Date: Wed, 24 Jun 2026 11:30:43 +0100
Message-ID: <20260624103049.884930-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fixes: 2d8f048c25ab ("hw/arm: Add NPCM730 and NPCM750 SoC models")
Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

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


