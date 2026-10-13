Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C1ECA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4T-0001I5-LR; Tue, 13 Oct 2026 04:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3s-0008Eq-EA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3q-0007za-Db
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so22421395e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880837; x=1792485637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xP0RYGEb3pcQLvMwonSHUuJ7p4HuwBLMvh/lW59w/gs=;
 b=AgKXZRvnP1r/fA36jcYCm3Zn7F0aqIA2L6bXQqhM7nwyPns0jbGp4RZ6xeC3ROv2R1
 2kJQYlyrq403GKKymZ1KdESqtWLLTcI01F7UhXIdNr9XolrGY5djULOZdq40d7XhnNW2
 Q4bOVQglIJ45/oNj/v7/e4TUkq1MAPS1mPfTVszKNRE1GyekPoEHk98GN5CI1+FF01RO
 lSNiyldCCRWOSrFqzYvgGxCLtojnTBh4Ew22PGvPhzxZYn//8iq5dCptTLO4cTixBxml
 QYIwlVuw+J0HxSrjWs19pBkTk9rMDfwsqxEt50ZLWNdA/bLrH1pD44zC2/s77TrcqRql
 7RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880837; x=1792485637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xP0RYGEb3pcQLvMwonSHUuJ7p4HuwBLMvh/lW59w/gs=;
 b=J8kGXZxd861z9p1vBCSi60h/yDT3nYGSAxIBtOTTtBkaie/ovvJ/qQzYHtKlIFYnjK
 gYdMBm5MePKKYnyzQxDRokhKUOaXXH21gg5/jywM94ktlS848nNrMihKhMpaQovE7HUs
 LEpQfqXoLa7G6MVCSgAjMTLXFoDg9G6koVt30s3rznaWKBinlWXtdw3IRab1KUE26Wna
 vPgcaq5UFxzQURkM8spt0xrdUPC3pjc0n3q7QsyODiwkmXRVcIpgj5zJKaESpfyPkdqB
 OODw+u50Us7/4clRUMBm74FXfma3eWGdTrEVPiMvJ5AFp5BQ/S+xiZJ1mGZM1I8rgQ2f
 rnzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVkG/zYNEmtLGBaUK30SPpOP2SZwwzY5wxQ88HlbwHygLXWYisaYBxnkOoKJ7hpa7sQkS+QgdcLmoO@nongnu.org
X-Gm-Message-State: AFq9FYLMHj7/8UCCkrfnbquWjBjmZWDd+nkOsdw83+dA/TkSGAaaAyah
 AjNsVdBqZ9GBhdtCj1uv1Rn188FRe7WwbUrVyNSxT3kgNRchiXXBxBgUunLo+LQSRCo=
X-Gm-Gg: AYBFou1WuUzy6WHtQTxj3OEnhvSvMsvXVD5d4ihUlFePbONUeX5euDKJKgWSPMOt/Wg
 i3ESczjaexjzfj8NmXCYXlqGMzG8qN1gnU0J2dzNzOUTKNQTMS6TNYGq7UYe7kVF+G3R+LpJF2i
 Cl0buKhOPiRI5Y4J4lLbVV9ldEP+oaDm3bVKtnOwYGc/DTZRsjmBSnsTMXxnLe6lsLywuCVgYBa
 YzHODVGUE2PMPfDVhAEHrUqPpVXo92ZK6eHMGoBhaw62Q5YseIjVSnW5ISq6dev88a+wQF87w08
 x/WTZp1DUmvozyWBdffqbP1cnI6+mAHCSgCZElGzzKiR0rkL4P+THPzU4bz8JTMVvJZn3wIadKH
 bR28/UMNAWdhIBs0P5weqCE7kH8dQJ1vgVnP0TqcYb3JCtvR6zzKxYU1M4aPdqT5F6OS8d3ASF9
 a1HckIQjjEcIRg2gkNt0x5wWdsugGjCLnybhjYGKr8JvOUMs6qmWVH0UPhON/0YWZrHh7xtRIGi
 c8xnsV+wvECCBBXUHrgfpziArzVz24dOoK6c7bfHCd5TxMCF6k61N8JYkXSU6tlBS4Wl2epcgpH
 SSk=
X-Received: by 2002:a05:600c:8218:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-4a18e49d9f5mr224274865e9.9.1791880836850; 
 Tue, 13 Oct 2026 01:40:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 44/86] target/arm: GICv5 cpuif: Handle PPI injection in vPPI
 pending reads
Date: Tue, 13 Oct 2026 09:38:51 +0100
Message-ID: <20261013083933.1024405-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The GICv5 cpuif allows the hypervisor to configure PPIs to be
directly injected into a VM.  Setting the appropriate bit in
ICH_PPI_DVIR<n>_EL2 causes that physical PPI to appear as a virtual
PPI in the virtual interupt domain.

Directly injected PPIs mostly behave like true virtual PPIs; the
exception is that their pending state tracks the pending state of the
underlying physical PPI, and guest operations that read or update the
pending state work on the physical PPI's pending state.  (Hypervisor
operations via ICH_PPI_PENDR<n>_EL2 are not changed, and don't work
with the physical PPI pending state.)

The complication here is that when nested virtualization is active
the EL1 timer PPIs must be redirected so that they appear with
different virtual PPI IDs from their physical PPI IDs.  All other
injection is a simple 1:1 mapping with a physical PPI always
injecting to the virtual PPI with the same ID.

In this commit we update the places which read the pending state
of virtual PPIs to honour the DVI bits and report the pending
state of the underlying direct-injected PPI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 95 +++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 69e51359f22..cdde759bf41 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -192,6 +192,97 @@ static GICv5Domain gicv5_domain_for_insn(CPUARMState *env,
     return gicv5_current_phys_domain(env);
 }
 
+static uint64_t gic_virt_dvi_mask(CPUARMState *env, int reg)
+{
+    /*
+     * Return the mask of bits of virtual PPIs which are being direct
+     * injected. 'reg' is which of the two ICH_PPI_DVIR<n>_EL2 regs we
+     * are dealing with.
+     *
+     * The complexity here comes from the requirement when doing
+     * nested virtualization to redirect injected EL1 timer PPIs so
+     * that they appear with the PPI numbers that the inner hypervisor
+     * expects (see R_GYGNW).
+     *
+     * Note that the ICH_PPI_DVIRn bits correspond to physical PPIs;
+     * the ICH_PPI_HVIRn bits correspond to virtual PPIs.
+     */
+    uint64_t dvi_mask = env->gicv5_cpuif.ich_ppi_dvi[reg];
+
+    if (reg == 0 &&
+        (arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV) {
+        if (arm_is_secure_below_el3(env)) {
+            /*
+             * If we are injecting phys PPI 30, it appears as virtual
+             * PPI 20; phys PPI 27 appears as virtual PPI 19.  Note
+             * that if we are not injecting the phys PPI 30/27 then
+             * the guest is allowed to configure phys PPI 20 to
+             * direct-inject to virt PPI 20 if it likes.
+             */
+            if (extract64(dvi_mask, 30, 1)) {
+                dvi_mask |= 1 << 20;
+            }
+            if (extract64(dvi_mask, 27, 1)) {
+                dvi_mask |= 1 << 19;
+            }
+        } else {
+            /* phys PPI 30 -> vPPI 26; phys PPI 27 -> vPPI 28 */
+            if (extract64(dvi_mask, 30, 1)) {
+                dvi_mask |= 1 << 26;
+            }
+            if (extract64(dvi_mask, 27, 1)) {
+                dvi_mask |= 1 << 28;
+            }
+        }
+        /* We aren't direct injecting to virtual PPIs 30 or 27 */
+        dvi_mask &= ~((1 << 30) | (1 << 27));
+    }
+
+    /*
+     * Now we've converted dvi_mask to virtual PPIs, fold in
+     * ICH_PPI_HVIR<n>_EL2: if the vPPI is hidden it can't be
+     * direct-injected to.
+     */
+    dvi_mask &= ~env->gicv5_cpuif.ich_ppi_hvi[reg];
+    return dvi_mask;
+}
+
+static uint64_t gic_virt_ppi_pending(CPUARMState *env, int reg)
+{
+    /*
+     * Return the pending state of the virtual PPIs; this is the
+     * combination of the ICH_PPI_PENDR<n>_EL2 state and the pending
+     * state of the physical PPIs which are being direct-injected.
+     */
+    uint64_t dvi_pend = env->gicv5_cpuif.ppi_pend[reg];
+    uint64_t ppi_dvi = env->gicv5_cpuif.ich_ppi_dvi[reg];
+    uint64_t dvi_mask = gic_virt_dvi_mask(env, reg);
+
+    if (reg == 0 &&
+        (arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV) {
+        if (arm_is_secure_below_el3(env)) {
+            /* 30 -> 20 and 27 -> 19 */
+            if (extract64(ppi_dvi, 30, 1)) {
+                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 30, 1), 20, 1);
+            }
+            if (extract64(ppi_dvi, 27, 1)) {
+                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 27, 1), 19, 1);
+            }
+        } else {
+            /* 30 -> 26 and 27 -> 28 */
+            if (extract64(ppi_dvi, 30, 1)) {
+                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 30, 1), 26, 1);
+            }
+            if (extract64(ppi_dvi, 27, 1)) {
+                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 27, 1), 28, 1);
+            }
+        }
+        dvi_pend &= ~((1 << 30) | (1 << 27));
+    }
+    dvi_pend &= dvi_mask;
+    return (env->gicv5_cpuif.ich_ppi_pend[reg] & ~dvi_mask) | dvi_pend;
+}
+
 static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
 {
     /*
@@ -461,7 +552,7 @@ static void gic_recalc_virt_ppi_hppi(CPUARMState *env)
 
     for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.ich_ppi_active); i++) {
         uint64_t en_pend_nact = env->gicv5_cpuif.ich_ppi_enable[i] &
-            env->gicv5_cpuif.ich_ppi_pend[i] &
+            gic_virt_ppi_pending(env, i) &
             ~env->gicv5_cpuif.ich_ppi_active[i];
 
         while (en_pend_nact) {
@@ -716,7 +807,7 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gic_ppi_pend_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     if (gicv5_icv_access(env)) {
-        uint64_t value = env->gicv5_cpuif.ich_ppi_pend[ri->opc2 & 1];
+        uint64_t value = gic_virt_ppi_pending(env, ri->opc2 & 1);
 
         value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
         return value;
-- 
2.43.0


