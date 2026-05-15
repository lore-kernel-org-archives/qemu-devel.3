Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21A7CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7K-0000eB-Ob; Fri, 15 May 2026 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq77-0000bj-HG
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq75-00018W-Kc
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso6555185e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842190; x=1779446990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oGa+BD4k4a/PK6xX/1PHxIPiXBIrIWftYTqw+3gjPGs=;
 b=cFrIez8GcEGREwfMGarXH1NvbXGNcGtZLC/fXlaMJkhJFHArQZUOmpHnU9/br177J2
 Dz0wf7ZDpXYDPdwJ6zY4CmybHBrIsZ3bdKUY0mRcyDmJO/3AKYixt1YO6rN9VljJsXLC
 ljzSzrNrgvtmc5GGVa1havDnVOQkfPF/2RqE0/bsHAPy7MgcDAddsR+WNPSuGN9IhpX1
 w06R5w5729IMmaL/jXqcG0JmjmpoRWyWU4cJuVSbsCQjD+hvh57SeKc1YhnEtur+5X8/
 gTMhOsQ2uj/phntvLRiD5UG1H1VbrCR0Aik/K3eRQyeC+aPA/0WzBykdQKcZ9m/HdWdR
 p8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842190; x=1779446990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oGa+BD4k4a/PK6xX/1PHxIPiXBIrIWftYTqw+3gjPGs=;
 b=c7ngx+xdg9K8vWT/zjRIzhcQ74FCs3gqTIOWpd6/uP3I9TEl4i7J84+taNI3nQdGr2
 1NIhQEhqOT0FHrBmYV4xIaQTSZnL+R3O9v+8bCPpLHhGq4irGMxln43i0WJgG/C3nENA
 Z94X2TkIyaGVHsxYPygh+/sIF8i9OFg1IeBBlWRCa0HwbdAMDHwuYF7tHAerD6JpjWRz
 oEOUE8h3ZJSLOqeKAbbmSXBPm/HOPS5ItBwHndkrPsQg5I67vUde3lg2BpCvn6l0euko
 FErM3poWYjW35yf0+uC/CCHDj4bNESveHlHFvuqu24/7ZLWvQuyQxpmaYW0L8FXNt9Tr
 aaVw==
X-Gm-Message-State: AOJu0YygQwLuZ64qEzZx/IyEpuJEtBtlV4SK8SQSTNYJoEJDW/s4qrWl
 kxP+FtMtcq/dYE05AnxLAYbjNpql9xiYYUwTjXnrV3W54GiJcBTbXWiZYkmfv/PDRDQSRrCS2jR
 wfgXg
X-Gm-Gg: Acq92OFXAieMkStuWVFufp2grsq0I4TTbicA35ol1fz4YyHeEcC9HIjD723hgrXpwKR
 XNmSQKS9/zuvddSWlsPW4LyBRziPVQYU4MKOWuwlX6B5alPgdcaXNnJRTwq4o7PmLlmg0k7yBHh
 45kd1Y650S6WOyhOg9XcgF8hz1UH8d+29Lpy92z6oRus+s7DL+eDrrVv9/crU+4meIkbbbQ0AmU
 ZbwRi0QN5i24+6iHvK7DQ07sbn6BQRX7iQf/dTfQr16YqCnenpaJQSZTl+LcbyjllwOA5k6EFr2
 APm9bdt3fm+prqne8eUz8Gxvo4TttLZtuWOXPnbjEmjXW02SHXGxowqon+0r1LOvDsoKHQuUNC3
 /V7FVskVG/OWfPdNvu+GM6XX/N3lYilFXz6oPm65NksUPybRp8TOxJMutyBsLJKXpBb8qVHvwVQ
 cLxq2EziJ+Z4TXZyZ0Uh+xAFQvjNoqmi4wg4oY59wV9/VEiZ1du2rHG3ao8RwVUcfJ0M0p5Jdq3
 ey5ghaiNxXdYZ10zPwFQhVRsRYNow4=
X-Received: by 2002:a05:600c:1914:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-48fe4dac5efmr45044075e9.4.1778842190130; 
 Fri, 15 May 2026 03:49:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] hw/arm: Build ARM/HVF GICv3 stub once
Date: Fri, 15 May 2026 11:49:24 +0100
Message-ID: <20260515104945.4145203-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-id: 20260507135816.71171-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index d7db99ce35..fac2d228f9 100644
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
2.43.0


