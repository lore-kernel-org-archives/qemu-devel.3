Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E569CEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKV-0001ue-IS; Mon, 23 Feb 2026 12:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKT-0001r3-V4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKQ-00009s-5r
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:41 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483a2338616so28946745e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866156; x=1772470956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CF4qyxmU9fhPcJpbwrYJ7dJ4Eedw5NYEVJqhMcT19uk=;
 b=TiQkNjWbZhFjVcJrH5+NBa+EInZ2SoS+Lja6Ex9AAA9i+DwTJZZzS8mm4LaibaV3Qk
 kUFIljSG1jfTzHkG5RIVX3qWbphj6ybyE3rVj5Dq14WqhtCCykLYGVtAacBItVqPZ7br
 kRtQJFamtX1i21PHB5S3eczYxEaZ0flSvvMt1lyiFnST4iAsmRHq/ZWxVZyjKELImlGr
 zowm7G5vquuU6tBvLIiG/kqz/zmK5tHfV7lYm65pClPX8+6iyw8IjIQ5mRB4dvSkzHbg
 H5GXlxodoYAX6idOhjuJApPyzNmPqJuP3OI0Sz+KBXFDc4nXQuO8gBCNYZ+RH/pOiMk3
 ecjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866156; x=1772470956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CF4qyxmU9fhPcJpbwrYJ7dJ4Eedw5NYEVJqhMcT19uk=;
 b=MmUkRLLe+y3xTK7IvPoPBoyioh8lKmnj7sg+n/odrhf6TJ5cw2I+3azvwxafqTDeVR
 SIyi9bgU+B0WEFpct6GyvVO4qkijDPRZfEvESleAcCzHxDkeYBhapshgGmxxLGUHOBal
 NukYzRe8Y9qdI+aeV/nvbO4XBT5L2gsUuVOlLvZ/br5RA3uUap8GOTkIy4vH7ak4PynQ
 ofRU/JpP0vzvpretySNN4D2grc40L/J5DyY9oI+lZf8qXtJdBTTeGOGhiIZyLNQPB4sI
 4RlGaFzRIZ8uzMVkK+yP/apgUlDDHpHyhpMPRDi5FCbygJamX3/0Ahr1drR4RzBEcvZe
 Jtpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsESdamd086L/U4ZG372pZMAuEjhQhjPR3Gc1ODY22ObZ3o74FXqeFgdoHT+lGI8QP0zFYsD8dUUTE@nongnu.org
X-Gm-Message-State: AOJu0YyuqT9gV4bsNtBz+7ypZXBtGjBVllv/R46TuExrhCbiVwARaoZE
 PtkinngWPRm+hQ0RK6DQvmd65pC1jgK492jaDKIoYZCoXXxeccZ0MRBTxd2NxF94TrI=
X-Gm-Gg: AZuq6aLo6IKFIaxs1Yq/i2u7TG8DI0bsT+0NnibJIpkXnmP2E3HtNSGOAgDlGwnTHuG
 RS1SlJnB92AJjKU+9H73StiLWwOgoW16t3Bvxm+yApWWvUVMvIky3QVfwnRj065V7Z0S1qBUaEU
 u36LuOL6/G/VFNoD6V91/yBiqfxIh3/AXCqBU5q2wX6lt5i1i4GoPQTAsvIWm0sygrHZFrqIT7f
 esmyvskm5KIOngEuMxG6TPEVZGeDdVrGDJM0d0LuYa6noxh+8m8mbGRSrZTeEXwIRzZ1s4VqvCm
 4qXUhX/iusWIFNYh1BB3bm2GAefMVULPrb9v/xy6ZHzh2th1R4T1Rxu2d9Xc9V+9btenLQpXF1M
 VOtb2FPfvMNZMugXf5TzL3hSM5R028e9y6w8zINyen6V7gdGhLKGpX9K3Xsl5RXOzJrtOLPKhoV
 m2TQ/ivvZyGUdKZJX9qnyspTtyP1En7lWNJY9phw9GRIhk6MTpmQ2YHTlvSo5f+da5B/SQ06Sc+
 SnT6CjP1pRnDzRsUtXG9Bw4o5fP27o=
X-Received: by 2002:a05:600c:468d:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-483a95c8f2dmr164281835e9.13.1771866156489; 
 Mon, 23 Feb 2026 09:02:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 18/65] target/arm: GICv5 cpuif: Implement the GIC CDPRI
 instruction
Date: Mon, 23 Feb 2026 17:01:25 +0000
Message-ID: <20260223170212.441276-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 target/arm/tcg/gicv5-cpuif.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 76c2577c09..072b38e785 100644
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


