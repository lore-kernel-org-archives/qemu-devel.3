Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B4ECCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJVZ-0005iv-2O; Tue, 21 Oct 2025 17:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVW-0005b9-4d
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:03:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVU-00030N-Bl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:03:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so63611525e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080578; x=1761685378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtB2ocPB+ydPrqCO0K5hO1zGMiPWbUCMmwjdYL4GuVA=;
 b=jbMk/LgK2oPm3w0fu4LaSvl3rfM1wIsT4/0D9RlF7C6Ts+SOB+memnkTe9DQNrGUvb
 ySWK6j65Zqv6VpenFRcYqgOsRRvX1f8dkMuqzIKjcCVCdwTEWmvAMDYZYhNDXYX7eike
 z/kF9R+Cam3MP5e9M0Z5xPVKhxOsJykJdRgmNVgW+eIB6flLocq0TUCgxHQlflDNnRFM
 pZ5yJolVlA90WEiw4jVIgLmY+DeTca4/ANeHJImi5fddfDQs0ux6hPdEjZZuEQwuE2Vi
 J8SJtDtZZFsow1TI0Mdu47ZiwyZaZIxHmzhCE7q1O4+gY95rqE6ZZaUFSppYrPkHnMLT
 +psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080578; x=1761685378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtB2ocPB+ydPrqCO0K5hO1zGMiPWbUCMmwjdYL4GuVA=;
 b=aavesjZZURatqm0OxlrWXha0Sz9DSlRhxZQSNVgPaAnm6h6XLd+j0XP85t0xjhA5Al
 OB+xQqmFMsDbrhC5yOW1Q+GjAm6ylotTRUS4kv5yhhPx/L89zfeX4sMvS2V88AWXVQmN
 +68S5Sp6YZ2P2+KeFzmcNfIMPWORTw+6ySjzJGH8h2ZLsnnpezW0BdOKGyQ8RiR0cHa1
 B2AkL7iDyXTMGh8b5bapEDnwyhWaFNGygXT2+M68FT+zj+b+poeq0/+9w8wiYxQy7mF7
 7cSNfAaYqaoXLVUvKZOZzEMExg0YrT3db/XTYr4kFdIVWxfSvG3iliFez2FnDOkYqIeT
 1Jww==
X-Gm-Message-State: AOJu0YxaFalgkFYFcBTcd+dscuu+Peg+R2DaOMv+YeCaoK0/zjnyJg+6
 mCzndppL2YeE+cYslS0vMEALHKRMp5RROa6OXQbXOTm77OB5foeRUcN8zzxna7f7eyrS3AqZ20H
 gABDmx+w=
X-Gm-Gg: ASbGncsGhwZfNViOxxeFJ7cLNYc6pFwzbY1DaGlnsayoKZ+3UDrAcKNm4EXf2ZNLIXM
 ABWExUE4UMYu++VjJONuWFtBDLKw+kutM49tLuLc36fVRzjVpsOp7fSfnuervaMmRTy5fCnHE7c
 eDmFOoWE5OwgPaDUZ1Q3wOQUpFt/xmVu5NyKZMQL2ZJJltZH6rV88reJOlNfXkFotuKiMNkIgxk
 0eNFHXw8yJFWg34L0OrpxKfKzqwZlT2vp7EhjCsPG2qhVIEow6hVRAUutaYntSBQDuZTW+//rvO
 D7NiBMBghyh487CDitpuO9u3xLiDEVUEG/st/9bXnHkWkGX5Ia4AFg0CUd7Dvdp3+WLQ9tO0PSn
 mxtWBF23zhBuNJcbDXQF97Vy+GQyd9Kean2V4nWc3X9oPz82ZCz3QAQki4ooyg9RD3QX6ePVGLN
 +akjj0qaYT2COHSSbiFhLWFhMRtFgDMfPqEISMVT3oiF5/p/8GfeQ8mM2X42Ib
X-Google-Smtp-Source: AGHT+IFfGsWANV7nTCUNayZ9qyL7IwEb8TOh/i/VrPGVuE8HVwdG+R96ozNxvHySuGJ5G4pQ8jBmJg==
X-Received: by 2002:a05:600c:1d9c:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-471179174dcmr153550595e9.33.1761080578080; 
 Tue, 21 Oct 2025 14:02:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3bfsm12269185e9.3.2025.10.21.14.02.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:02:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 15/19] hw/arm/sbsa-ref: Build only once
Date: Tue, 21 Oct 2025 23:01:39 +0200
Message-ID: <20251021210144.58108-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since previous commit allowed the use of accelerator definitions
in common code, we can now move sbsa-ref.c to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b88b5b06d7e..531a635936a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -14,7 +14,7 @@ arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm8xx.c', 'npcm8xx_boards.c'))
 arm_common_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
-arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
+arm_common_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_common_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_common_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
 arm_common_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
-- 
2.51.0


