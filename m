Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD88DCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY6K-000445-0o; Tue, 13 Oct 2026 04:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3x-0008RV-1l
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3u-000818-Vz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so2927155e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880841; x=1792485641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/Sig7FVvdhb0+exNtEt5dl5MsuYM+MG8UgxMJ4WaGc0=;
 b=WZakO9FSXbZ7GJhLZFFphQyksUyduQemaTIU2ABp1QInl0ka/Nv50vbbufTK8d0WLU
 3yFD2wig1fMtyKC5HIDGNP8Jf2agR+U20/St7bD+6BFHjHapSTX0MKyf3pGTe/rh9MjI
 YkO24KI7f+qmzkJ/EIm/ukv664w2f9Kf+AeLPdYMscuueMdd+4ouCtfPt9mOONtVKX2I
 SPWV8XAKC64SPdl9x48HjKIlB/84F56mvUCnHu9c/RSV8opmqOwDuLLaU+SLB75bKBhw
 2+6+9KJLXEtGiC/9RxeRKuzOS/06jUF6KGF8zuPpKOJbVHitUBBz1KA7iJv5OfeOf/16
 icoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880841; x=1792485641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/Sig7FVvdhb0+exNtEt5dl5MsuYM+MG8UgxMJ4WaGc0=;
 b=w0h/R4T7vVjhVIroQ66Hk5Vj+oVq0NgX9QYp5o1dnXEw3GUy6V98IIzpsUyO8aRokM
 Rv00xbmjGvmRA+5bqFDwX46t4mwazZec1/KFrVjJcob1U8kAVurc7MqIeZxDe4wQHwu/
 VJetYCJoMkGMa1gPbUq06HNjX4wQBfV7utGplv4Ztd+R+0vO8kwXAkOTjLSRT00F+8dq
 pfcjcCE4Kp0oVU7VIC55wxfZNccbFz6QbW/p4mIx/hC/ayT4maSAiPRksSG84q5KcZ/D
 AzHn1de/1RxzkRgvkNpJon5mepnTnVYZMOm1psxV62M0SAxEIW6F9NmgvjQj3YRx/Tun
 LMEA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhqtDxuBP3iQ6Lny4CXZIvHH048+fbc6ZvnlZiJsEg/sroLmGghB0kKAfxVyp0VMxk8s++CuGuGRIl@nongnu.org
X-Gm-Message-State: AFq9FYKKpNK1ejKAUZ2UboBRc/59mmOCTywe8Qk+Gs91RxMVfh2UmF7o
 OQCRJOCGSuRMFBetyZ8uDa12QnVl/UsakQNQCyK3enTuMNbBXibWq84naCSr0NCXceQuvuFDyYU
 z5TKoL50=
X-Gm-Gg: AYBFou2rS/AWtn2trH7gKeKGwFp2fFhqx2A27mZRddEasjWIvc6UlcgXq76qxLZOT+B
 M9pLw//r6d9xR86TJsAcrUhP159XjfpnrmrbF26zwqtZwqsD7i2oE/bf7gnQtMbL1x4Fk7Wo6JN
 YUSgIWLfqCOKmyYw5GuHavz+gXG6ghjy4wk8mhovWuOsD1oCRSTTnmjmbfrCyK6N4v198oaolSX
 E80hNWWG5EJJS4f2/kTfcgazUrwaCld5J6Gk3pmc/pZkgOaP5q1KWO0/wdTKQV75XncYQn3ooJq
 dd1UfsP+KsUPpo7zWEgCGTG9CF8+OK9S8DztZ/cae6L/O6pwdLRJu0IkXGdm2L3ocnY669EXCdy
 G/QMzyA62kSO0ByaA6Qykg6FhD1mESwTmuCov9sx3KeL31lYdUEQXbzrA4xE5Wmd2drbpq4/VuW
 /ibH2Ye8IUS91MsErF0ckVVBMR0KOu4TSMqljiZmjO975CvV1IhqScLHDNmUGSlTfPkAF+tW8x9
 /7V29MMCYA6bCSxOwyDtSJUQ2LlcHNN9Wp7P9br/kVR5JaHqkaTfwf11fIKwULPsLcckW1JnthQ
 M5E=
X-Received: by 2002:a05:600c:350b:b0:4a1:ad01:f8dc with SMTP id
 5b1f17b1804b1-4a1ad01f924mr23664985e9.21.1791880841177; 
 Tue, 13 Oct 2026 01:40:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 48/86] target/arm: GICv5 cpuif: Update VFIQ/VIRQ when
 direct-injected PPIs change
Date: Tue, 13 Oct 2026 09:38:55 +0100
Message-ID: <20261013083933.1024405-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

When a physical PPI changes its pending state we usually don't need
to update the virtual PPI state.  However, if the PPI is
direct-injected to the VM then we do need to do that update.  Make
this check and call gic_recalc_virt_ppi_hppi() where we update
physical PPI pending state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index e7e3dc214d6..406c980af5e 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -602,6 +602,28 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain, bool virtual)
     }
 }
 
+static void gic_recalc_virt_ppi_hppi_for_dvi(CPUARMState *env, int reg,
+                                             uint64_t mask)
+{
+    /*
+     * Called after the physical PPI pending state has changed for the
+     * PPIs indicated by the mask and reg arguments.  If any of these
+     * PPIs are direct-injected, we need to recalculate the virtual
+     * HPPI.
+     *
+     * It is possible that even if the DVI bit is set we might not
+     * actually be direct-injecting the PPI (e.g. if HVI is set, or if
+     * timer-PPI redirection means we're ignoring this DVI bit), but
+     * if so the recalculation will just do nothing. These cases are
+     * "the guest did something valid but odd" in that it set a DVI
+     * bit it knew wasn't going to have any effect, so not worth
+     * trying to catch early.
+     */
+    if (env->gicv5_cpuif.ich_ppi_dvi[reg] & mask) {
+        gic_recalc_virt_ppi_hppi(env);
+    }
+}
+
 void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
 {
     /*
@@ -627,6 +649,7 @@ void gicv5_update_ppi_state(CPUARMState *env, int ppi, bool level)
         env->gicv5_cpuif.ppi_pend[0] =
             deposit64(env->gicv5_cpuif.ppi_pend[0], ppi, 1, level);
         gic_recalc_ppi_hppi(env);
+        gic_recalc_virt_ppi_hppi_for_dvi(env, 0, 1ULL << ppi);
     }
 }
 
@@ -894,6 +917,7 @@ static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
         uint64_t old = raw_read(env, ri);
         raw_write(env, ri, old & ~value);
         gic_recalc_ppi_hppi(env);
+        gic_recalc_virt_ppi_hppi_for_dvi(env, reg, value);
     }
 }
 
@@ -924,6 +948,7 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
         uint64_t old = raw_read(env, ri);
         raw_write(env, ri, old | value);
         gic_recalc_ppi_hppi(env);
+        gic_recalc_virt_ppi_hppi_for_dvi(env, reg, value);
     }
 }
 
@@ -1428,6 +1453,7 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
             if (hm_edge) {
                 /* handling mode is Edge: clear pending */
                 env->gicv5_cpuif.ppi_pend[ppireg] &= ~ppibit;
+                gic_recalc_virt_ppi_hppi_for_dvi(env, ppireg, ppibit);
             }
             gic_recalc_ppi_hppi(env);
         }
-- 
2.43.0


