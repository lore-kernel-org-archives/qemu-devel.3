Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30E5C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCV-0003zv-5q; Thu, 30 Jan 2025 13:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCD-0003sC-Q9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:22 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCB-0000Ux-Hc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:21 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so599799f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261398; x=1738866198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/yslxnxwmm+HysZz/dpCshf9VmwSsaLGb2pE27kvDY=;
 b=a8OBTjezU7okXZvHSYcaB4Bkmw+FagzKHkAHWhxfuZEdJvjPJzacePdDe4G746ElNa
 cM0WtwHPU61gmngxWdmmWN7JxRNP879BfmH1K/ZDWhq7q/2fSVyLpDta8ZbEOYIo5izB
 O6orOVU/4FT9+7YFDPu6upufebfehxXl/rC2C9/ExKYNBD4Cg3jFMVl47UPLKd2IgCTh
 nGBqFzNKQLal8XMgMb6Szmtf8mtFLhdRTGH5rDKIQ5NF54H2YdH25v9xFWUySVQaizRL
 Hy0UwAvF3bDW364Y4APij/7xpBOBJYOmMJVn0tyf359GmiBwzWOYQnrXF+3/Bfh0at2Q
 sK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261398; x=1738866198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/yslxnxwmm+HysZz/dpCshf9VmwSsaLGb2pE27kvDY=;
 b=uubVfGdDFu1u51YG5I3lejIi6XqFhckSDEjSIV6fnZ8DMdt+h/2N17Z/JnxE9QfcYr
 JQ1jdqqftxMYheg1+IVh0jqyWeK+USHlNZ3PUD5NMRBabbhhAY5QjBsvGAylymkglvm7
 UaeKhQFNYC/4w+U7PUgkjgQuPkyCLMAueKDaiIe4ST9ZQOr2gEhK3U7WLCigLr+0jp/q
 nKKTJqSwduziDI7OthLeMM/Nh08AQ6uLnweMgRLvAGKaLZxRW17PUgsSjqrS5P3HzYfQ
 gVRAmVM+WkznYiNgHZcJlDS3ijsOAIPuFMpASGPoy8bfVzFVCF2dVSNzuHd3JDAAg21q
 GvgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjCT6XpNun2u4yj/B6MHrhWVl64ae/0aCANMgrnq5yWeJ+ZJRYd745XKeCD0GRZsQGlsFGZ++uiyi3@nongnu.org
X-Gm-Message-State: AOJu0Yyzfj/3296b15HICBP3TbVkPrXZdLrDGzhOr98VGPoHTxrPs0Hi
 jtVnCZQXJxgNGd03r1jWmO+B/v0I9D++HSNHz7DHX+btLuhT6aQ8vfuk3Vaf4YA=
X-Gm-Gg: ASbGnctDVR71DTcXBgVY4rw8MS9uihFNtXU536iZapXnqsx0yHpeRMukI6cwkKLgHkM
 lREnbZviIo+oCeKahVpAgdZBywaSYY1REwjRnu0NVeoJ+ZAYFZOOFm8ZJXRPzxnCUzRKnCO9TuY
 QygaIpLsupkQHATLXk4Apzr+slkznxTjNLJ/0x2ATYnoIbib//tmUX0IR7fK4X3PJo5DL7p/Cu6
 CtWqth9lc/VXj1Vzc68ovlb18JE7TseSWNkSHcLEPUN3hFDWtxegJpWAHmLMeUEkmktktGxSc1i
 1L1dWGNzeSLNoQ/4LZ0JcA==
X-Google-Smtp-Source: AGHT+IH+I7yo4Js2hImL1H05KRHZE/gUC0mEnMK4BeWT4jXxKMiariAVI/m730Pzby6oKJBa9crVaA==
X-Received: by 2002:a5d:5846:0:b0:385:f4db:e33b with SMTP id
 ffacd0b85a97d-38c51966b85mr8153358f8f.21.1738261397654; 
 Thu, 30 Jan 2025 10:23:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 06/14] hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps
 for AArch32 EL3
Date: Thu, 30 Jan 2025 18:23:01 +0000
Message-Id: <20250130182309.717346-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

In the gicv3_{irq,fiq,irqfiq}_access() functions, there is a check
which downgrades a CP_ACCESS_TRAP_EL3 to CP_ACCESS_TRAP if EL3 is not
AArch64.  This has been there since the GIC was first implemented,
but it isn't right: if we are trapping because of SCR.IRQ or SCR.FIQ
then we definitely want to be going to EL3 (doing
AArch32.TakeMonitorTrapException() in pseudocode terms).  We might
want to not take a trap at all, but we don't ever want to go to the
default target EL, because that would mean, for instance, taking a
trap to Hyp mode if the trapped access was made from Hyp mode.

(This might have been an attempt to work around our failure to
properly implement Monitor Traps.)

Remove the bogus check.

Cc: qemu-stable@nongnu.org
Fixes: 359fbe65e01e ("hw/intc/arm_gicv3: Implement GICv3 CPU interface registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 9cad8313a3a..8a715b3510b 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2300,9 +2300,6 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
@@ -2365,9 +2362,6 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
@@ -2404,9 +2398,6 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
-- 
2.34.1


