Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC1AC02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZEF-000059-Kc; Thu, 30 Jan 2025 13:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZDz-0008AW-7B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:25:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZDw-0000zp-7e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:25:10 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385df53e559so853941f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261506; x=1738866306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oi0sMINEkrTrI+neDqhvq+8GpT7JWwbuY3ZQaXgcPtU=;
 b=tEaqRL0JZqK8zrLkCxG0B2jbfDWx7+sXP713utjdTUKGifNifMlNbH4rHkFq1ZHDSg
 xI3QVIX+IgDz+PwHFyMUmi/193Y9AacLG3MYeDSkkRC/eCUYO7JZEA10kG7lbhVKcFPM
 XlYX5Wa87NCsafAYmsRM2OWaxwzp1+EPPUl5QnAqUeE/IGk+PsfwRqBj+H491rqXw1c8
 /p+bqQtrWIohE6DZu2mmTMgdn3LRAK64n1ok58KWH4ivEtYXRKFZp2onWRJPQ0Nf/g2R
 HLbJUZIsY3auDNObdA9G3H7VUGT+EGF1ed3hrO0O+lk0ttz/yLTfr/RjRi7nwWqBPL9x
 Bp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261506; x=1738866306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oi0sMINEkrTrI+neDqhvq+8GpT7JWwbuY3ZQaXgcPtU=;
 b=hpZncSGBjUP2LKeiYfLHIjKi18emkHMEVREBfPvOuWjIae4WzLd2MAsMSZlEeG37Z8
 +Zjs6b++mHSpsaIDbuJ809nYKyAw+O9jHVRhiZcqaa2LLg9fee94KIQvq8UlmlSO6tz8
 ldkMIZ4O30QgLOcvsBtKu247mACEmLxrZAk9HWym37HkZDiMvfRLU5BBiC7r9GXMwg6R
 qFEQAbJjh3x3jQVesHfdJjTYyxoQvy9gZXp59DcsiTPaP78sssnVy+sUUKvlVDSiNVNA
 MTZvM/SsqfwiNXo3TCxXAMR9X6FHIBJirhgLwmuEB8QpPM1Rs9mF2khdrOYSNkWcPZ7q
 Ok7A==
X-Gm-Message-State: AOJu0YxwnE2cPaSY6II3OXSiEaj9Vss3PP155UbWIsXR535P1kKqG4bu
 9fCU/ACupM4OJ/BXokxPH5W2CK8p4LvvxxiR0DNQw3iJglZfDiGx/vOOElb6vAaavG7K7SwVprn
 8QYM=
X-Gm-Gg: ASbGncsEOC+69Go+pzJ9ImMpIQTbjtAJn8SwpMAF6VpchBQqt97uHLsYV/spodWEUQv
 RpepO7KyQ1jXGTKcxHZW123K9GKaeBRDyrxX4rJ8c3VYWksJAh6XknbyPyukemUAYa/whCkpqZa
 bwlZk9MuNL+6sQJ209EtZ5PiLgTcImOo8U0kUGKrJB+xDQ3qPJ+H1crumSd3yD31lWPZ+7UUfQO
 yC8UunjGTuogb0kbgNfOY642wEKhMx4GTLFBD9jWMjGuHg3fN1nfcjEfI89vcjFYxKD6/JoRhA7
 1sEXwDQSHzpam2/+8DO+a3TfjEsBHu5Tt5f6Zhf/dKgkfhRN0VuNzPLMh1LnmzQv1g==
X-Google-Smtp-Source: AGHT+IFYhpJErdSA7vSpBly1rCQK3Hd6yCZIS7blzazEfV6FDnD6Mh71epc7eIfIkaGKpV5mXLemvg==
X-Received: by 2002:a05:6000:1864:b0:385:fa33:29ed with SMTP id
 ffacd0b85a97d-38c520af333mr6573516f8f.47.1738261504514; 
 Thu, 30 Jan 2025 10:25:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c10191asm2676171f8f.22.2025.01.30.10.25.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:25:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] hw/arm: Explicit number of GIC external IRQs for Cortex
 A9/A15 MPCore
Date: Thu, 30 Jan 2025 19:24:33 +0100
Message-ID: <20250130182441.40480-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Some boards based on Cortex-A9MP / Cortex-A15MP do not explicit
the number of external GIC IRQs, using some (implicit) default value,
not always trivial to figure out. Change that by removing the default
value, requiring MPCore objects to be created with the "num-irq" set.

Philippe Mathieu-Daudé (8):
  hw/arm/exynos4210: Replace magic 32 by proper 'GIC_INTERNAL'
    definition
  hw/arm/exynos4210: Explicit number of GIC external IRQs
  hw/arm/realview: Explicit number of GIC external IRQs
  hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
  hw/arm/xilinx_zynq: Explicit number of GIC external IRQs
  hw/arm/vexpress: Explicit number of GIC external IRQs
  hw/arm/highbank: Explicit number of GIC external IRQs
  hw/cpu/arm_mpcore: Remove default values for GIC external IRQs

 hw/arm/exynos4210.c  | 16 +++++++++++++--
 hw/arm/highbank.c    | 15 ++++++++++----
 hw/arm/realview.c    | 17 ++++++++++++++--
 hw/arm/vexpress.c    | 13 ++++++++++--
 hw/arm/xilinx_zynq.c | 47 +++++++++++++++++++++++++-------------------
 hw/cpu/a15mpcore.c   | 13 ++++++------
 hw/cpu/a9mpcore.c    | 14 ++++++-------
 7 files changed, 91 insertions(+), 44 deletions(-)

-- 
2.47.1


