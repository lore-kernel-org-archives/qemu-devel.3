Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94942CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyF5-0004xr-S9; Mon, 20 Oct 2025 18:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyF5-0004xY-4r
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyF2-0007VM-C6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso29500045e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998834; x=1761603634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxZHsO1L/VrZlP2B/qXka5RVk62bKTEPJ3UyLZsjPT8=;
 b=PcxZuS9cwCxCAAsqyiX8jc967NHhNk0cL5TNoLaXBq7iBy5xM+qGr13eIVpDEdxow4
 ENciI+BVnYMoTmOicHOVyKPOFF3rH98uDvkb2L0CIkb0PzFdDPH3LJ/c3amWqzFwZ8Vh
 SBVuNs93lcuP+RSjBe9BJj8v+SWlmxzxX7b2wIh2/8g5vYo5uWG+zIduv8fEzBz3iBVO
 IjNcIsizbBrPWkwmjAydt+YGdvYZqrD+9QT9TkUi7mSTuNRaaG662yp0E2zgpBsHzA0s
 +INHXk4KZMyx8lca4vkw3prEMtxULuLe3kyzHIZatvcC37OQ1fiXk2BHVk4oCynbp1Tb
 n0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998834; x=1761603634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxZHsO1L/VrZlP2B/qXka5RVk62bKTEPJ3UyLZsjPT8=;
 b=YE9JXc7nE7KcsvGqSWosRVDh93ZQT8atvac99KNdbA7Us0xNKtZx17d/uMOUN1cEIB
 1gYRxAmpGADvxjOBkHCx54NfX0e+NXOzk0W/KH09Tku/WR/+xH6LoFdut8R4T2AhK3RC
 lKA7S+J9dhA0uJjLF0VcITs/hdN9LABmi/ZqumPQSI4KyC9kjAGgaYnI8OPash21tcJ2
 79g90Ei5wa6BXTC3+56MkzPRjmXRkrbUyGGbH94B0vMFDs5uq5H/3g3tCXkcxHVZ/ci/
 9WLcanmF2qHATF05I2VJTvot/TdSCHY0gqCKXRyUdt4WkVDPj6ymd30YsNWUhUZg9pDd
 kK0A==
X-Gm-Message-State: AOJu0YxiRnGowlN5EB5aKSreExkszCRBcVVxLkx2aHbpsN021rr3ZaeP
 fN/EP8ZJAftcCrS+Mz94LKJ4w9Z+sGNp7YxZyNPW+R/hjN4tnbAg2OpparHmidfS20YvapIhz7S
 PsC/6RAo=
X-Gm-Gg: ASbGnct5AMgUuVdFDPba5OaPh3bJuZWoAC6ENhKEmHUYXAIBkIOUuawL0Z1vffJSt5j
 UW0CUU9v9OYsJGMKU4ezhxkABOvj3xnFPGxNkpSVQiWwWqm6jMPfThX72aV0frN18hTuLN6qKyq
 q75CGFnLu9vf9tpFBY2xbdm5aYTTCTpA8+G6OATxMeu+T2vJVJTDJoG8XgsNSotoQRA4R6T53Nz
 tmfpI9ESY3lMsbQ29Xha2OhaiM9wClqMfGAxrahUieWr8MfRE6vRKhVi0+QbxSQaF2b7WfckKaX
 MmYm8qzRQ3XPEpTVJ/yjsxDCLAE63sCb2rbSEhxe3qNovD6vBBDrk/dHszOiARzBic+SjY59pz+
 8YX34GuuUjY1sNp5xwbPxSpmfGyyXaJqfTJ4Fvae3vN7nM/Hrpr4uPPHzxvrt+jT6IfQFMhEAla
 aUN5LWO77ANwxGUZW3Hb6UL4sDSLpG3cs6eUzj02NKgY4v3Re9vvvgWjm+Gcsa
X-Google-Smtp-Source: AGHT+IEwMxOuCWyV/6qxEwKsYmeDiLastoEk5BExLJA71Ro2jioPCr2gC8ivxh/TIEJpoCW3OFO0Vw==
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id
 5b1f17b1804b1-471178a6f9emr97207625e9.11.1760998834464; 
 Mon, 20 Oct 2025 15:20:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d23237sm2523945e9.10.2025.10.20.15.20.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:20:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 29/30] hw/arm/meson: Move Xen files to arm_common_ss[]
Date: Tue, 21 Oct 2025 00:20:09 +0200
Message-ID: <20251020222010.68708-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f9d615e360b..28106de94b0 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -68,7 +68,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-arm_ss.add(when: 'CONFIG_XEN', if_true: files(
+arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
   'xen-pvh.c',
 ))
-- 
2.51.0


