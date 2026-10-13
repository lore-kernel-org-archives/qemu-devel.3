Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE26CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3i-0007mb-Gv; Tue, 13 Oct 2026 04:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3U-0007Ct-An
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3P-0007qQ-M4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so22013365e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880810; x=1792485610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FFC15qOUGo6FRd9B9ir9SIKtB3uGsFYdGz30HW4TUIA=;
 b=XUNuV036M96mWPGF1NzPF0kUO2AI05+bNbKx5rf97nfyXxHXM8Hi2Usuk68H96RKQZ
 D4CBQjR+wRNhHiXfvg6hOTScpaH+bEv2h5RZwuU4kFeV/hFmW3uPX6ERn4MUuDkfZu11
 e+XghbbdZLwE71SmRLgR29NYIbD2AF6Rvo4XRgcbdM2eVefrDHm7uNnWZsBsgpgKrybY
 B3nkxw1DskrbtzVDiKP5JAh5jEl82n3vvyuGPj+MMqSTzyKD8l1MP+Q5spnISNTLowOL
 W0ZD6wcv0q/17cTAmOseJrpUsQk5w1fs5FTs7TKFJ1Yow8qOPxUykTPkkOgex7alDFYC
 I5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880810; x=1792485610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FFC15qOUGo6FRd9B9ir9SIKtB3uGsFYdGz30HW4TUIA=;
 b=IpNFSg5vLgCPOBJQOPtLCh2VE3Ylf4l2rRtEz9AHvAu0DumZ20/hKtKcTX//dEEuc2
 e3HYZjnlFKatxuwRzO5tWB1WUVuL9FunxAjBdPD+PUpuCOXWk5+EElGNiziXMWp/cguc
 PJIkCc4lkwk80gL8JVqmDDXikYimdQ5FDo+L/t6iD65v/nNnOD8Y+XuBvzdddGbDhBqS
 FYU51eT3h1wuobXtwj0Cc+e7bvEIkWDXV0RRJsAnlgXNUTN7w6h18LWI6tjmn7Zi9K7V
 SXW6qd1Ml7EqZ1I/S1+wNMKHHmpDdytX7Z4X7Jyqk5GGcoQJrinZzBXdelomXAPNhPMq
 6wiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSttYNnftvm3KflW8RhzmbCrgj39DYXhTkOwiHMe6OzJj6eUX2V7RTkZAxKbLDBA4Gt/BbGz2KTKfL@nongnu.org
X-Gm-Message-State: AFq9FYKBq6S56zyybsC+ee9Gq5YAyFlB5o0WKoVEEVpLvaCEjz3eNv+R
 KLwtPNeq541NHOBq88HDbdSk10gAdZ3oArYCu43KyCMM4lFBm1CxOLr9uAY2+mdYdTq6SJWlZVJ
 9HZTZRY4=
X-Gm-Gg: AYBFou0zRcq2jQqiaGjTsAdo7FhCDpFQH+33++dFUIzlF0eQ3b2+htMFHNvTdTRhzBk
 7ZKrSEs9cAHIgyhrxzkYUWKLIwdJRVPzzZGWtlxTMJfxMTwNj0WnOq87/OQ+jL9oRghpf2YCzH2
 +Gqv4yBLcl1Rl0oREBzP8hoSIJXvqmomS+sHRx65sKqv0bCg2sFpPKWmviOuICvNZYF2b1MjwSp
 r1fMF+lSbZWzxxFFUdLCtoTNdXbqZEQetHvFDrF8FSTUpXdUzVF/GZ3XrPnc+FFKam2GXjrO2pt
 bxhetIdzHZRGS86E8nqmu5ECWjXdiKJoXNhl8jXJM42Ej12Q3r1lkvLRNkGwAPiPXciEHu4AITA
 OfV11OgTDqELC3qrvGtw2477uG87Sz07+PvLZCwvDZKy01HCyB3Kdjbyuog0GNny/SGFKXvUjNJ
 ZdqOHbz3xqJ/scd0QbjDzgIw6cX58WkOv+lU8Sh8vHgS38LP7HL9bHbgotJfz6RGcCVn9w7fK6x
 awSsnixe4EzTAdXe112PNxT5HGqQW94D04r9qnSrJPxs6Ae6qi9gFD5md5/F4Kf7nz8Kn4zcVVQ
 i9g=
X-Received: by 2002:a05:600c:4504:b0:49c:fc6e:a3da with SMTP id
 5b1f17b1804b1-4a18e4a7839mr250549645e9.25.1791880807540; 
 Tue, 13 Oct 2026 01:40:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 24/86] target/arm: GICv5 cpuif: Implement ICV_CR0_EL1
Date: Tue, 13 Oct 2026 09:38:31 +0100
Message-ID: <20261013083933.1024405-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Implement the redirection of the ICC_CR0_EL1 encoding to the
hypervisor guest's view ICV_CR0_EL1.  This has only one bit in it,
the enable (EN) bit, which is stored in ICH_VMCR_EL2.EN at the
same bit location (0).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 41 +++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index b183c8a6e79..247cefd9e68 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -67,6 +67,9 @@ FIELD(ICC_HPPIR_EL1, ID, 0, 24)
 FIELD(ICC_HPPIR_EL1, TYPE, 29, 3)
 FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
 
+FIELD(ICH_VMCR_EL2, EN, 0, 1)
+FIELD(ICH_VMCR_EL2, VMPR, 27, 5)
+
 /*
  * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
  * and no legacy GICv3.3 vcpu interface (yet)
@@ -564,24 +567,38 @@ static void gic_icc_apr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 /* ICC_CR0_EL1 is also banked */
 static uint64_t gic_icc_cr0_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    GICv5Domain domain = gicv5_logical_domain(env);
-    return env->gicv5_cpuif.icc_cr0[domain];
+    if (gicv5_icv_access(env)) {
+        /* ICV_CR0_EL1 has only an EN bit, stored in ICH_VMCR_EL2.EN */
+        return FIELD_EX64(env->gicv5_cpuif.ich_vmcr_el2, ICH_VMCR_EL2, EN);
+    } else {
+        GICv5Domain domain = gicv5_logical_domain(env);
+        return env->gicv5_cpuif.icc_cr0[domain];
+    }
 }
 
 static void gic_icc_cr0_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    /*
-     * For our implementation the link to the IRI is always connected,
-     * so LINK and LINK_IDLE are always 1. Without EL3, PID and IPPT
-     * are RAZ/WI, so the only writeable bit is the main enable bit EN.
-     */
-    GICv5Domain domain = gicv5_logical_domain(env);
-    value &= R_ICC_CR0_EN_MASK;
-    value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+    if (gicv5_icv_access(env)) {
+        /* Only the EN bit is writeable, and it lives in ICH_VMCR_EL2 */
+        uint64_t vmcr = env->gicv5_cpuif.ich_vmcr_el2;
 
-    env->gicv5_cpuif.icc_cr0[domain] = value;
-    gicv5_update_irq_fiq(env);
+        vmcr = FIELD_DP64(vmcr, ICH_VMCR_EL2, EN,
+                          FIELD_EX64(value, ICC_CR0, EN));
+        env->gicv5_cpuif.ich_vmcr_el2 = vmcr;
+    } else {
+        /*
+         * For our implementation the link to the IRI is always connected,
+         * so LINK and LINK_IDLE are always 1. Without EL3, PID and IPPT
+         * are RAZ/WI, so the only writeable bit is the main enable bit EN.
+         */
+        GICv5Domain domain = gicv5_logical_domain(env);
+        value &= R_ICC_CR0_EN_MASK;
+        value |= R_ICC_CR0_LINK_MASK | R_ICC_CR0_LINK_IDLE_MASK;
+
+        env->gicv5_cpuif.icc_cr0[domain] = value;
+        gicv5_update_irq_fiq(env);
+    }
 }
 
 static void gic_icc_cr0_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.43.0


