Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334DECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11R-0003aV-0G; Thu, 07 May 2026 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11O-0003ZB-Tx
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11N-0003r3-5V
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso12803165e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169136; x=1778773936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EUSOjlx+hsZVcUD1mobn1E9yNS0kI0/ZgIsz2Vr2uNk=;
 b=MupjXI4giT7GLMkendVd8G95+OwKkOkBTKiZEQHBO6Z89KEo0tr5UAg42i3byiR0S3
 zCIScJBM74iD3ojewY13o0sOmvpT5LTzIkgaE0PcxHx+KpsHGdsXfTKPDF3GE7aXI/WY
 sWO6XiWc3KGHXUynQqj1xOGNeiSQvmKlcoMLZMRmVkYgYjAF6TqZIS2cYVUPC7bFvogf
 Bnk/5ToxpcrQCAQgOyB7ygv5gOZiQEN3aWatV4PPDYM5vzsTkV311R/fbcUKTPcMC3wY
 wFvhU5IMx+g3h4OypsJEDP7nnTEqBbaNXnKChQoEd2QRGZ5I3M1q+Wzff0q8VlKvlNcX
 9BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169136; x=1778773936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EUSOjlx+hsZVcUD1mobn1E9yNS0kI0/ZgIsz2Vr2uNk=;
 b=AO+xpOJHLF7ic9uaUvacTaN1Tqeo4AMAhDUDUa7Jmiyi9BQcswhtxNUiCdQU8nMdLN
 G2aUJGDhUgKxZbp62AnfHwQt5qaFCtjQMYXudqrqsLiLZJsNv87aIrlQIABIc/ydZIV8
 2QcqCTrYpLpRz8q6q4DASP8wkcjYKfCoLydv3WjTpZI4ZyPrp8DwGdBmtPx2GpuFGHR+
 +GOMkmM39iqkzwOXvn2HP8Iq8KODBVuVPpiaE/o8kTG52zS4A3SuafaE85fr4P0aEeDX
 eWsZyt6nG7kZeuH8q3FE6slcr0LAO+yfF5PFpkaHBidZ2N07Jv+WOluR3znOqkoavOdU
 BKVQ==
X-Gm-Message-State: AOJu0YxOB0yccM/hWNR1GDhPlE7KmA7saEQQxZl1BcQA8YzglyrLO5pw
 T+pK+gZeVDm56Rk/zTmX3ICB8IZNb5x7RsrhWnmaEvbKZ7oSRi/6DD74pX3fX80LNJuL0aq/qkt
 3hRxm
X-Gm-Gg: AeBDievb6e7kOQlnZ7I36OZUch2qR4s1OlnhWWG5FRXIEMNFIHOLGr9dp1dJaE9Y3FI
 baqDjzgknXkDpgUIwjPtl1ICoC9Q7wXOFzqwwJK2mx0QrjhuCXHmXute164t8cKMxadBHEJ9Z0W
 lbDJZGlK+D2/ZZG3Ktduih0pTxJw32sMIDZ9EUY+pf3fKC0gVqw5/udIzzXH0ry3jewjtEFQz5i
 ZDPp8PA645Xr2KLaBzk6lpeE6SmlUC49nvZAjUTC29RK5K0orwupEVfUX/kAfLsDHhbEPx3gPUk
 QIb+QFg2JS+CWxKAseH8jNHMPDjzxsISF5kMOqr/vPp6GFZrvRc5+ajXGx+fKigFFfyGYEfrkfB
 V4G8etzuDDwCPWhDNiMU/dgV0OyhUnEtMYa43lv0R4ZZA0+npn6dhKPLRdETxZc4BPjnfC+rbkw
 aaB2rjwW+wP5VZq5q4VWyLipWjv4N+O0jWC7AxGQkvr4LO1tVgL45cB0SHa3ZkXpaHo4LAtr/e/
 ct/ljT7XsJcP1l8ZspdmJtwZgDebK66dhc5GurBkJrCXd9xiMhp
X-Received: by 2002:a05:600c:3b17:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48e51e15718mr126773215e9.10.1778169135556; 
 Thu, 07 May 2026 08:52:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/67] target/arm: GICv5 cpuif: Implement the GIC CDPRI
 instruction
Date: Thu,  7 May 2026 16:51:06 +0100
Message-ID: <20260507155154.1886557-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement the CPU interface GIC CDPRI instruction, which is a wrapper
around the SetPriority operation.

As with the barrier insns, we omit for the moment details which are
needed when the GICv5 supports virtualization:

 * traps when legacy GICv3 emulation is enabled
 * fine-grained-trap handling (which is done via
   registers that are new in GICv5)
 * sending the command for the virtual interrupt domain
   when inside a guest

The CD instructions operate on the Current Physical Interrupt Domain,
which is the one associated with the current security state and
exception level.  The spec also has the concept of a Logical
Interrupt Domain, which is the one associated with the security state
defined by SCR_EL3.{NS,NSE}.  Mostly the logical interrupt domain is
used by the LD instructions, which are EL3-only; but we will also
want the concept later for handling some banked registers, so we
define functions for both.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-20-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 7392a98c49..0c2bba5ce9 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -10,6 +10,59 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpregs.h"
+#include "hw/intc/arm_gicv5_stream.h"
+
+FIELD(GIC_CDPRI, ID, 0, 24)
+FIELD(GIC_CDPRI, TYPE, 29, 3)
+FIELD(GIC_CDPRI, PRIORITY, 35, 5)
+
+static GICv5Common *gicv5_get_gic(CPUARMState *env)
+{
+    return env->gicv5state;
+}
+
+static GICv5Domain gicv5_logical_domain(CPUARMState *env)
+{
+    /*
+     * Return the Logical Interrupt Domain, which is the one associated
+     * with the security state selected by the SCR_EL3.{NS,NSE} bits
+     */
+    switch (arm_security_space_below_el3(env)) {
+    case ARMSS_Secure:
+        return GICV5_ID_S;
+    case ARMSS_NonSecure:
+        return GICV5_ID_NS;
+    case ARMSS_Realm:
+        return GICV5_ID_REALM;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
+{
+    /*
+     * Return the Current Physical Interrupt Domain as
+     * defined by R_ZFCXM.
+     */
+    if (arm_current_el(env) == 3) {
+        return GICV5_ID_EL3;
+    }
+    return gicv5_logical_domain(env);
+}
+
+static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    uint8_t priority = FIELD_EX64(value, GIC_CDPRI, PRIORITY);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDPRI, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDPRI, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_priority(gic, id, priority, domain, type, virtual);
+}
 
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
@@ -33,6 +86,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_NOP,
     },
+    {   .name = "GIC_CDPRI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 2,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdpri_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


