Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF1FC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMzz-0005yP-Gm; Fri, 21 Aug 2026 07:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMzw-0005xn-MW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMzv-0007Cc-0w
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4998590d392so7239265e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310077; x=1787914877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=08MDgCUWYWGU9uq5tt94Th4yLxiaUJzZ7xRA/bIweYI=;
 b=gMOdRJ4/cWTDZ3z+J21lH9xQ5dexYfGnBJfxDBmFT50CiHnGHuq7VW3GGXFF+UQTvr
 vCIir874c2KEcmhR8lMflDKUm6BYgevIA9I40MKz5D8Ljdqk4bnvYFlEXVIIv4EJjoKN
 PDN7D+kGGwPSAVj6qhnvwsiWTAkEEvhzlbsh0k5TbAN1von+DIKidE+Dx3DataHjYmff
 vZg9jZjDPC4nh83NysnQ2k2cUVpOQdJhoV8HLyLAJ4XdwlhamzWaEav7YKZ0IL3XQrHP
 CHPknCu1eTAwGhcM09sas0XnWXfErrVXgsonZeGrc+hQQirInxHkuB71AXk+3aQ+DkGb
 0mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310077; x=1787914877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=08MDgCUWYWGU9uq5tt94Th4yLxiaUJzZ7xRA/bIweYI=;
 b=i6AqRjYzebf0G0eKDsBdzSXdtwaVCUIjg/JGC1Y3Qpf7CgmEnlsTRfDj3lbS+favda
 +CZY6jrUE0RBlxiv5CNe7dOo/AIN+rpYAUJ9b1nnsa/H1mwVl2QmQnlM7F91/o4mdKc3
 l19poyVLJ6vYnDFt2rI3+tNfobgTuCz3/lZyUcmtCGyWP7S0fkV9WDxaf8EKAhGstCXm
 NeHdwrsMUIanedq9JJrjNQNYBxnCwGbvm19ygeDaqGV3/5pJGnH28cNLTlFI9Is3iiAX
 zW+6iUUxkE3JfzLzhqVT6T6oock/LM+sZnZM0A1/+zsCT3eZ21898ntCWrofHBLfr+Vd
 OB5g==
X-Gm-Message-State: AOJu0YxteIx8NJnmrE/loviw9CpC95Y/Unh1Tp0yCg+OdCTWNg2XrKf1
 DRsOnSY5UVCUGUt8FymUYFWcAswzeS9xM+tooVe/1OZs7187AsWm8yv+vGtA7bSLXvPOddNWOui
 5EisP
X-Gm-Gg: AR+sD13zPE5Xhzgjsr24swjEcfJ0U2i7hCqN41soGQZAgTZwhOx5zYnp4IJhWFfJ4tJ
 5f/Pxd3Ozf/5FO7w9g7abmsa+tyPHR8rcs8l0Zov9lNIBCCgm2pYOXg09Gr5mFu8hKpno0wtLxT
 Xub6Tm58brosgXvTZNoDkMZMjtLAScb1nzhsxPo5YyDrYefkowdgi2JJDAeVgLAJ1mbwSws4h38
 nUVEcN2KGkftoXEJWC50PlePbydI2ZWWYabJ8OG/Ab5I47WMPWk9JmF1AkvtykbLN6vvnNFMNZM
 MO4vYeeQIfUBbuyvcrveJlpF/PAnx3YM210YzNBZlPB7vifi2rnXHa8bswpJ2m7ai4oWufQCxfl
 /14nDb1/kevjRkTXUz5SldYgvzVk7CszlTP/AxcyNCgey+Wuts069eyYAiVX3Sw9bMCk0N3Fdjj
 QCefmomNvSmqHYpYtkivw70U+OUhfXddAnhw64O8FAaQ6GJ2jfUCpuBvCx2mBFXR12ROMyF3pPV
 A1CYqIzycwiQRr7KCKQrXsih4OgqZRn1qJFV9sZ6WqiVL1+ofUBSYFueg997UJsjtEBsQ==
X-Received: by 2002:a05:600c:3e1b:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499b82e5427mr86639265e9.4.1787310077595; 
 Fri, 21 Aug 2026 04:01:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/43] hw/intc: Fix arm kvm gicv3 selection
Date: Fri, 21 Aug 2026 12:00:20 +0100
Message-ID: <20260821110101.3971391-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

While 39a8c3941e may have fixed WHPX, it certainly didn't help KVM:

  $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-cpu-features
  ...
  qemu-system-aarch64: unknown type 'kvm-arm-gicv3'

That patch did remove a test for TARGET_AARCH64, which is fine because
it has been a long time since we supported KVM for AArch32.

Cc: qemu-stable@nongnu.org
Fixes: 39a8c3941e ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260812200308.289238-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 4373f16d0b3..0620b0792a1 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -48,7 +48,7 @@ specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
 stub_ss.add(files('arm_gicv3_hvf_stub.c'))
-specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
-- 
2.43.0


