Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE86CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4U-0001No-Im; Tue, 13 Oct 2026 04:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3k-0007pp-4w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3i-0007xH-FA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso34528885e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880828; x=1792485628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RJzfMhjKu4TNbAp9oHPUvWIkRSlmWLw3udGjNBH4jJg=;
 b=S8LcU0/gBM0S6n+1I96LlQe9V5VzypPCosZIaLhK+ecFWP3GUEczP44w/g7dvpdSqK
 mDd3U8x8cy9SIhFA3o8bIPRvUMWg0l46moohU1PkHG9iz77fCx78GtTVh8LL3v6vS7hU
 0AO1f9yzxMbMCkEMN9a8aPG/kul/wlhzWgjGMdDMZLmNBx2iltqEtIw2eCboVX4dJd5u
 oVFOF+T6EpPMc1H+LvaJBgvXrKcF3E4sVlYN7jYy4q6iNTLGVMMXy8OWfLOpbyPyKXIT
 OgIiAKPcrk6K5bu1MKXLTDnvVVNuaXaEh9r8O+Mzs2CLZ1ohFLTA7Py76BDPzo/CDLlm
 Bj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880828; x=1792485628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RJzfMhjKu4TNbAp9oHPUvWIkRSlmWLw3udGjNBH4jJg=;
 b=RirmXFmNoL3I/R4ahUvmK8rgRcq573zMNNhAMA5SCFg4id44vLMHyi9vj9OXXSOcr7
 8s32jNRdmT2hEcSydi75liOJObNQIulAg4z6rdLuRI9+NxI7+AFIBkW6/2Q7Hx+ZuhR6
 xlpquwd0pBUOw7l4VNPEm1dzd8ArsXZWpgQyAjIj/Yd51OdWx799I4Ggr7HhQVCS6uzY
 Qjg0oliFTZIHHrbvTCMzRIRRuA3ifPRqaOTdeaV8g/ysVGDiWMgXmh+AV0UV1FpWIxmA
 a+5eSmLtm/5XNU5GTg5cVA2VI9tllB4frhctADF7ncqbQLrLXn10uT+8CGkie+3CdK1F
 1B0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUUh8ASeZMF0k8CMLBZlh1mj+IHTX+9ALjdXVHmfvDreY2NrA0T6zuPoc4oS28SrMRG21sHqM3KGdo@nongnu.org
X-Gm-Message-State: AFq9FYLxS5KscLL8EJnPzyOv3tJxV9v4Ko9gePloxYIZ/cs8iV8PlWeG
 7V6se8mmJ6zTjeJvJkTg8wmrzvEq5gtL3I6iNiVN3qSXNaUBpk5DvYZc5se87/5CzzM=
X-Gm-Gg: AYBFou2JebANK0orP809iWEAvLORKVlYXPl9uBmBe5wIrG+Ra+ZWRiNETjmkd1Q9oX8
 vSSUMU5AdpA2tczESDV8SwkOmnh+h0YxU0xiNEIbNGwYs1l2L0b6V37j+XdWuSRz5tNjCOhBziu
 G7fRtsBFabldMhXp+D7FerjdEkiE0TNiew0PwUMUhZt/cEzoJdvewqRFTmtfTF/bz9iaRjwWg0c
 Kre9xcpP7AVTyZpS4DL5Nx8iC7809k+jSq5XbDMNtKpDT8BjeElUHRbM3We5BEd3YC4svnF5eOa
 h+rb3ewegNL9PY8EIB4QC7STVtL/pc8RbpCCHaO4deTyOvwPsbsVm2/DbG38FOzaY8m3u1vDXVb
 fBtaaLeOzszFLMgjduL4joMN2Ag5HLdT2bxFyMCo8ROGcpJdyV8/vDORR8SMhfmBUfUzA7LyU/Z
 mIuyo/LQU9SH89Wf8v88zfJyXx7Lsyw2Vh1VwiaIJF5gCwnX1ZXPrW1CbpT3xIY4soVdSsEFSJv
 sqsvWenaK19+tROew7MQxEiEPvBKJw78DI7tbGI2RI6J5GPFS3V/CPz17zwSZbJuxSCIBY9n7lR
 3QE=
X-Received: by 2002:a05:600c:154e:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a18e49ad83mr230799995e9.11.1791880828182; 
 Tue, 13 Oct 2026 01:40:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 38/86] target/arm: GICv5 cpuif: Handle virtual interrupts for
 GIC CDEOI
Date: Tue, 13 Oct 2026 09:38:45 +0100
Message-ID: <20261013083933.1024405-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

GIC CDEOI does a priority-drop for the current interrupt domain; when
this is the virtual interrupt domain we must update the virtual APR
register rather than a physical one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 21 ++++++++++++++++-----
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index f8d58b5a537..aeacc812fe0 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -1221,13 +1221,24 @@ static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     bool virtual;
     GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
-    uint64_t *apr = &env->gicv5_cpuif.icc_apr[domain];
 
-    trace_gicv5_cdeoi(domain);
+    if (virtual) {
+        uint64_t *apr = &env->gicv5_cpuif.ich_apr_el2;
 
-    /* clear lowest bit, doing nothing if already zero */
-    *apr &= *apr - 1;
-    gicv5_update_irq_fiq(env);
+        trace_gicv5_vcdeoi();
+
+        /* clear lowest bit, doing nothing if already zero */
+        *apr &= *apr - 1;
+        gicv5_update_virq_vfiq(env);
+    } else {
+        uint64_t *apr = &env->gicv5_cpuif.icc_apr[domain];
+
+        trace_gicv5_cdeoi(domain);
+
+        /* clear lowest bit, doing nothing if already zero */
+        *apr &= *apr - 1;
+        gicv5_update_irq_fiq(env);
+    }
 }
 
 static void gic_cddi_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 75f40c44f26..8e7e4c119db 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -7,6 +7,7 @@ gicv5_recalc_virt_ppi_hppi(uint32_t id, uint8_t prio) "virtual domain new PPI HP
 gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
+gicv5_vcdeoi(void) "virtual interrupt domain CDEOI performing priority drop"
 gicv5_cddi(int domain, uint32_t id) "domain %d CDDI deactivating interrupt ID 0x%x"
 gicv5_update_irq_fiq(bool irq, bool fiq, bool nmi) "now IRQ %d FIQ %d NMI %d"
 gicv5_update_virq_vfiq(bool virq, bool vinmi) "now VIRQ %d VINMI %d"
-- 
2.43.0


