Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F92CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtFZ-0005KI-L0; Fri, 15 May 2026 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFX-0005Jb-K9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:10:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFU-0003aO-RA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:10:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45ae6a0e523so2918452f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854243; x=1779459043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItINZxJcyXmGmwOm0WYPhb5KBATTrt6cbx40ypDwqrk=;
 b=r/zDXUwF/XJ3o3l/KYQn4FxddpGjzJETwSvVFIfx3uKfKNSvZTiF0mAX/I/XiaAi/F
 JA5fpQU4Oq9MR0dDihAlYEDwmHFgoEbocAhR8no0weAOcer1QECaT9zUo140xiKY4Dj0
 TcFW6yuHSBj5cK2RSv+0fl9oZDkB0AP9KTL4acv8GHxn92caxDLz7zIwHJnAN6cvNQc6
 sxLKbFkO+HRCwr8iSNy8NiOvxyHqXfl/Cuep5skqSlTkw1aRoWpL4RoBfnOWV/QlTlZ3
 YrKvMiA8yChftLIT2EjMMLRhpwzYon9Yz7qTmTWYPuBG8KrgDsOCL4kVLZQTWemXFoAQ
 YDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854243; x=1779459043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ItINZxJcyXmGmwOm0WYPhb5KBATTrt6cbx40ypDwqrk=;
 b=fjlpK2vM/jmjQuN+VRo6zqUZOz7mv9/BQxXZkvv9VjfhMyIIrjEsEBFHnUHLj+UtWl
 PUTwVVnl1Z2QhoRO3cR1EKkfue/gqrWf4tMky1MljU8qawqxIp1p6XW01xo4NPuGoiz8
 glTdoZa5DQwpTxff7d6yp4zdkgxLMqbGVatjn9IzkbsKcbQ4X19lmi0mIIbKzYDyXYwO
 oU7+zFBRgqcVmyq6R0QDj56Su2OXkkyIGHv9rSJEZVHzONsnq+XL4GKp1wn6mpZfw3pU
 nnSc9byW6j8UaS8vMy02e8IV8JympNfEoMZ3QQXFVNXjW1SCbb8sg4wXhW0YQzg5M9Mp
 gVKQ==
X-Gm-Message-State: AOJu0Yxa4NZ2GHzzvVm7s9VtUULN1qKvI9boIwEb7Yv/r/QtUs3E4uuX
 WtZjvBYml/OA2crgH4Aiy8cTZjoz4EgOycyRiLyhtVe8cSiKxpaqVeCSs4uOZJv7ACLGuCVZIxA
 l65FYSBQ=
X-Gm-Gg: Acq92OHnPjjPJ8zDJpNj4FPq9JeXsTN1rlKp6bIXPMTj+qxLeL7mIuUzHa5gNG+Tfjy
 UIE06C0Z1krnShGWp1Q1czm/VLvJlN39vu+NXUjCbtctjrpurhk13FvgEOF706pRB15Wz/RZQBf
 JXOIUhz8szkAL9ciHpqVWWdR4H6TJ1LM3grC0xM7kugmyTEV/7pS/hxxXsvJKnp9rQ9g0bqq9Qv
 C2DH8LqDcG9jAcANUHfjvETjI0/0Y2KR7nYWk7flAkLqqmzpkT2VdtPXeGvpbNfcKAYrNEE/te8
 ijOmDLk98LI3cCRLnwc9Sqhu9ijEdqcWIhyjPx3TF5Yk2gFVClQrWanCu4reNRNbj+dxk7nqmNc
 +lZVrIu191JuCz/P8/7awr5K0epU9vYprSWyx/XlRDco+74Xgsn7pzURvTWdgC5+sjRQIZQz70d
 kFfkEVqvFxer2G8CuGlnPGGYmsNBIy4j15linoz/3mCNPxuDSABMK08itWruyvAM/R5vPeJGDcn
 AKEabzJxXY=
X-Received: by 2002:a05:6000:230d:b0:43c:ef4f:79dc with SMTP id
 ffacd0b85a97d-45e5c35e3b4mr5522658f8f.8.1778854242627; 
 Fri, 15 May 2026 07:10:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a562dsm15393181f8f.33.2026.05.15.07.10.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:10:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 01/20] hw/arm: Build ARM/HVF GICv3 stub once
Date: Fri, 15 May 2026 16:10:12 +0200
Message-ID: <20260515141032.3271-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Move arm_gicv3_hvf_stub.c, introduced in commit 48396ad6ce9
("hw/intc: arm_gicv3_hvf: save/restore Apple GIC state"), to
the global stub_ss[] source set which holds stub files being
built once for all binaries, instead of one time per system
binary. This prevents symbol clash when trying to build a
single QEMU system binary:

  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  duplicate symbol '_vmstate_gicv3_hvf' in:
      libqemu-aarch64-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
      libqemu-arm-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
  ld: 1 duplicate symbols

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index d7db99ce354..fac2d228f9b 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -47,7 +47,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
-specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: files('arm_gicv3_hvf_stub.c'))
+stub_ss.add(files('arm_gicv3_hvf_stub.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
-- 
2.53.0


