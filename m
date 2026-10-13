Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D66CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY5C-0002QE-6C; Tue, 13 Oct 2026 04:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3r-0008Dp-Jw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3o-0007yw-Rt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so2926155e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880835; x=1792485635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HAJqqQ3Uo3xCW2Bb5E3vPPfl8N3rhsh3k10EI5/4JrQ=;
 b=wn3btXGiH9Lk2P98J5DPXkOiSEvw5OJ51U+FWUvbINUQ2jsDso4DBfSYty9eDGS4qA
 AfT/QhqwQ/Uo+AwcF5dDXxEQx5GykvpMnxTAqi5LYT0WZtxaTzprcVJGcX9Hj0t8cLQy
 9ZlPmR1SSGeOPPIBq+20g8YhBEjNPrhsaok0z5Cj+8cfl74hJoybs5wOycAEJOIW4cSK
 KCD3y4CMbauutW5xKQ68spuDi9DPGxpTcGLXYWiA31ku1mO3uODtHgyRZmX25CVMyOUQ
 j06n5knUagr6lSr19C6nbblwtV++rZ2duxBpGcUaiRvWpZlL7MQEUFWCUzoh2ajOv8+I
 exkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880835; x=1792485635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HAJqqQ3Uo3xCW2Bb5E3vPPfl8N3rhsh3k10EI5/4JrQ=;
 b=ywmejztLn369Inazu5kna3RzfJXM8u6PycQyMRjro6S75nFuL12HRkpov5CHXqvjoa
 bory9qA6SjXvVKAQ1UIZ9T7gAQWcUvIuxSJVk20pDfROzh8hQHaRYDA+RfjJPrH9JllX
 zAkugWl342dahdOQ0YTHfvXjfgOuBTmg3P35O+ZAk3Kp1BFvZYkrLL4fr9NbjX3/GfIp
 MJTt9a0UX9R8jQYJecuOmLm6ua1N6ISM8M03NCPtmRmIFVFHzjGkhoBXMlSRkS60+aPW
 5jwvO3924QKp4buTaI+zy4xH3W899lk3ybWKzUv2XrqM9fcxAgtT4q+CU9nm1dZ055jE
 2CEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4BamfRk4vOmbuqcbBQnGSfes6SptDCnzpEoY4L9a2ZDPtUzBePEsi7Re1jFY4X89oisSS4LnEa2qq@nongnu.org
X-Gm-Message-State: AFq9FYJ4srv+CCjym0+b0qse8ioQsBjDINRmgwMu52XF4Nd3OUeBAEQ0
 HC2UamEOCEJak8YVh0S2xU4OhdKzbfZJ8aLEnA/OYcRL9zpgy7bD7qXJyynJeCb4Ito7UtmG5+l
 paZxgZtk=
X-Gm-Gg: AYBFou3BoMkWjVj4GMhLyAmEM63bGZCb/Mq6hHVqq+pMkej+r+xHqhhIXC//+Vg0ww8
 AN/IYz7HmszeTnvRM9OgZcjmUBVc6pmzsdgm673JDVoUqtRAIhAclf5cE2HlSMaNbsowVAuOkQY
 /G3ZV/3/NVX4mXt23+NlLZVxW3j/NrKXRgQYqLkaDTAqqXpODqm+1YpQALOqMvwzfa0/Yydp07W
 zUlfhBDJ3xLD2+yG8GINmF+H7f11hiPF7OB7UBLvphgV/7F41CrOTgOK99IIGFlDcPn3vzof/mW
 gPHoT3NQxe6VEyIetlaAosKh5AMrq83TrZIyZH/JX+zJwTyO/nv+YbR3N9bVzOX1S88yOzTCw+5
 7Gvc4hydNX9/Mm1uf3f+fOh7YP22V6YU7jYKSI2q37qniCsv2gyF5QaVHyHjiCiyoCZm+4XHO5B
 nA8TLBprtkYGT2g+ki+qUEfyZ5GYCEJe7RYBMxOczfhGb8tCgiVyhevIGInHmPHOroyczHWM9t/
 8SjtUbSv8LeAZ50r67dCz4t1GFH2GV7A1c7Lzq4yV0acFya0AMDUwm48zzB0TobxPXge+zjatCs
 OnE=
X-Received: by 2002:a05:600c:350b:b0:4a1:ad01:f8dc with SMTP id
 5b1f17b1804b1-4a1ad01f924mr23660115e9.21.1791880834828; 
 Tue, 13 Oct 2026 01:40:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 42/86] target/arm: GICv5 cpuif: Implement GIC VDnnn insns
Date: Tue, 13 Oct 2026 09:38:49 +0100
Message-ID: <20261013083933.1024405-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The GIC cpu interface has a set of GIC VDnnn insns which behave
exactly like the GIC CDnnn ones except that they always operate
on the virtual interrupt domain. (EL2 can use these to examine
and update the state of the interrupts of its guest.)

Now we've updated the writefns to handle the virtual interrupt
domain by looking at the opc1 field, we can implement these
using the existing writefns.

Note that there is no VD insn for CDIA, CDNMIA or CDEOI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 7f0109e9b12..64e59589cc7 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -1453,6 +1453,54 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fgt = FGT_GICRCDNMIA,
         .readfn = gicr_cdia_read,
     },
+    {   .name = "GIC_VDDIS", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 0,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cddis_write,
+    },
+    {   .name = "GIC_VDEN", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 1,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cden_write,
+    },
+    {   .name = "GIC_VDPRI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 2,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cdpri_write,
+    },
+    {   .name = "GIC_VDAFF", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 3,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cdaff_write,
+    },
+    {   .name = "GIC_VDPEND", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 4,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cdpend_write,
+    },
+    {   .name = "GIC_VDRCFG", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 1, .opc2 = 5,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cdrcfg_write,
+    },
+    {   .name = "GIC_VDDI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 2, .opc2 = 0,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cddi_write,
+    },
+    {   .name = "GIC_VDHM", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 4, .crn = 12, .crm = 2, .opc2 = 1,
+        .access = PL2_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .accessfn = access_gicv5_ich_reg,
+        .writefn = gic_cdhm_write,
+    },
     {   .name = "ICC_IDR0_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 2,
         .access = PL1_R, .type = ARM_CP_CONST | ARM_CP_NO_RAW,
-- 
2.43.0


