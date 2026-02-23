Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A522FEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKj-0002SI-AK; Mon, 23 Feb 2026 12:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKh-0002QX-TE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKf-0000Gq-8B
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so28245135e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866172; x=1772470972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GFX2oLIEOhrVQeH0JfIITp46cEANNmny594ZuEVDUzo=;
 b=EAW2xRRn/8MDYs1d+BmeePlqhzPA5jJm13tm4AKK3Uu/yY1LwQELJYOmrs8fZ0ic3c
 lZXYzVC1d+xPthhBySoUu+szKdKZuVFgwDz+Pb5Qp2Ybu0t1hJ7XEslqJbTmox8rC3Jv
 VC5M6BoFqm9WfWnpHF649Q2BwHVy9ZVM1i92mdl0vhaNJ498azyoqV4f/+vZUJ0S1Aks
 r/kl7S/ToUpBdrHkWw8Eu3OwZIfH7raMTZatAFOTaPpiBGgLqNvFYdpmzwfwanjUcOrQ
 itvlEtaxn5dsNlmrGSzGuHvtVEMDMYR6EbIFMZQ38y5YvR0wmeV6wkFUxStrrYWTRIQo
 Bs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866172; x=1772470972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GFX2oLIEOhrVQeH0JfIITp46cEANNmny594ZuEVDUzo=;
 b=bcN8+98yTnKFn96MYqD8o0Y2/EWzoqX/TKok6qqYofC14DderKdBLTlQqOZvz6tZJY
 SWewHA+v5Q9GMneNH6WcfZ0/WaFD3u2CLZRo0Tngm4+pkVsziqyGxBIoUZbxFtuCZUDI
 UU+8fE+ClrUVra9fYc4NzIS54faAw2jhrXoBXbhmuNur5L4HXhHlL5Ah1heXLhOmVszt
 nS2fVuDzjCbwNlJ1Y530+ZyWqd1BBk4ToH1klkxzTh36nYOqvyNfEqX0wprJeVamezCd
 8GAsWXPjTp29WIr90GLE1Io7TAJZ88TuNTCQYA4y4ng8yUuWACPNFa+svNgdru/CKkTd
 LYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/ZxbUoqYfjACq04dPzxgkxBvD4zi4Cg6yi2GshwpsE+ssPlcBIN/GsSQIvGDw17RLPdkGBL+3AsgM@nongnu.org
X-Gm-Message-State: AOJu0YyY9CGP+NrqeNtbHmF++siOoMEbTsHqWXEm0JuEIvXiT76jySlt
 k7oCN5v9b+qwdya3M85Slqg2AMb/LmsxDT/BgoQh70++E7kHyeW1J8lxYEKkHt42L5mP2Hn2Lni
 9x707
X-Gm-Gg: AZuq6aLbPowmQFXlnp+zOtD2aHCdxK0cmwjg/FKJYl9EKrQskPlk6ROd8s51n+GRQRb
 oLL9RvzOPdzjz6nIGnCT9gwJNWNXqQXyGeMTKfbrYBEe3i7yCQ89ShI1xR4/gji9+cgosk1zLGc
 ZztTnRj3Gl8VyNeTxef3+lTKLggJ+vrOgSha9I0igdB1yBKpPyvUNNQ9LuG20VrvPAJgKM6x2Kb
 ExVWHFX1J6Dh8tdXPm6MW308qSE/fXmQWxn0Va+PR9puL6uFYglwFnk52N5E8XdEV0Qy/eof0Wp
 FZIGByBvqlK3nwwT1Xgsb7r2GjM+epjE61JkVdl8xfAB6mpzWJCxdqerwIupBg9nECWotru1bpG
 2sHrMTKLgiz0vVKYJSEnzwQysA6MhxnqCKby7b2wv9dDQr7hGFn1Hi+HdTboVK/vGDiCfxmKEOK
 p2gzbRBZTtj9NqXy0LKUHCI3j11SHevDpOBqTbSR4Rrdj5AsY8cvTb5nnFbU0UK43vcx2yPk+O3
 sjRgWbRa+d8cgb12bVecvCI9JUjb0obppvxxBD6dg==
X-Received: by 2002:a05:600c:3516:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-483a963df3cmr193925005e9.35.1771866171550; 
 Mon, 23 Feb 2026 09:02:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 33/65] target/arm: GICv5 cpuif: Implement ICC_IAFFIDR_EL1
Date: Mon, 23 Feb 2026 17:01:40 +0000
Message-ID: <20260223170212.441276-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The CPU system register ICC_IAFFIDR_EL1 is a read-only register that
tells the guest what the affinity ID of that CPU is.

Implement this register.  In real hardware using the stream protocol,
the IRS tells the CPU its IAFFID using a DownstreamControl command as
part of the handshake process when the IRS-CPU link is brought
online.  Our analogue of this is to pass the IAFFID as an extra
argument to gicv5_set_gicv5state().  (We could have the CPU call into
the GIC every time to ask for the value, but this would mean we had
to search the cpus[] array for the right CPU to return its IAFFID.)

Note that we don't put the IAFFID into the gicv5_cpuif sub-struct,
because that part of the CPU struct is zeroed on reset, and we must
keep the IAFFID across reset (we only set it up when the GIC device
is created).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5_common.c         |  5 +++--
 include/hw/intc/arm_gicv5_stream.h |  3 ++-
 target/arm/cpu.c                   |  5 +++--
 target/arm/cpu.h                   |  2 ++
 target/arm/tcg/gicv5-cpuif.c       | 11 +++++++++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index bcbe88cde7..8feb492a43 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -175,9 +175,10 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs)) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i])) {
             error_setg(errp,
-                       "CPU %d does not implement GICv5 CPU interface", i);
+                       "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
+                       i, cs->cpu_iaffids[i]);
             return;
         }
     }
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 1f00e8ffff..7b5477c7f1 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -20,6 +20,7 @@ typedef struct GICv5Common GICv5Common;
  * gicv5_set_gicv5state
  * @cpu: CPU object to tell about its IRS
  * @cs: the GIC IRS it is connected to
+ * @iaffid: the IAFFID of this CPU
  *
  * Set the CPU object's GICv5 pointer to point to this GIC IRS.
  * The IRS must call this when it is realized, for each CPU it is
@@ -28,7 +29,7 @@ typedef struct GICv5Common GICv5Common;
  * Returns true on success, false if the CPU doesn't implement
  * the GICv5 CPU interface.
  */
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs);
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid);
 
 /*
  * The architected Stream Protocol is asynchronous; commands can be
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ef2afca6b9..551be14e22 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1087,16 +1087,17 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifndef CONFIG_USER_ONLY
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs)
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid)
 {
     /*
      * Set this CPU's gicv5state pointer to point to the GIC that we are
-     * connected to.
+     * connected to, and record our IAFFID.
      */
     if (!cpu_isar_feature(aa64_gcie, cpu)) {
         return false;
     }
     cpu->env.gicv5state = cs;
+    cpu->env.gicv5_iaffid = iaffid;
     return true;
 }
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1fdfd91ba4..a32c5f3ab1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -819,6 +819,8 @@ typedef struct CPUArchState {
     void *gicv3state;
     /* Similarly, for a GICv5Common */
     void *gicv5state;
+    /* For GICv5, this CPU's IAFFID */
+    uint64_t gicv5_iaffid;
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 4420a44c71..c591e249b1 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -226,6 +226,17 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.icc_icsr_el1),
         .resetvalue = 0,
     },
+    {   .name = "ICC_IAFFIDR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 5,
+        .access = PL1_R, .type = ARM_CP_NO_RAW,
+        /* ICC_IAFFIDR_EL1 holds the IAFFID only, in its low bits */
+        .fieldoffset = offsetof(CPUARMState, gicv5_iaffid),
+        /*
+         * The field is a constant value set in gicv5_set_gicv5state(),
+         * so don't allow it to be overwritten by reset.
+         */
+        .resetfn = arm_cp_reset_ignore,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


