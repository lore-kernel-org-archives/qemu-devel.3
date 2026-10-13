Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC14CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4U-0001O4-Rt; Tue, 13 Oct 2026 04:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3u-0008LQ-SI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3s-00080G-OO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so15780985e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880839; x=1792485639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oIQa2uLYcdnzWkI38CuG/P8pp77y4VLZYUd1uI22D4g=;
 b=CAkd9DslOShn5Nl2X2Sq7YUCXcbFEluLc7D7MsW6zD1Fmu/rED7cIkHn5bUVSKaPuk
 9us+mHhT+IwpCqae7X+bSgaSdYeceC7dFrUTY1nZ+YYo/I2Oy1JpIV52OS+DL6IXPBaG
 av/FbeDOIUh2XvxKWg77WUPwtypxBEYAwXL72l+UlVZnI1mJOwNewlfngQKtyOgFCGPB
 B45rpj3sE2Kdphrk+mq+/bJ4wtIg0bLibKUux307RBlFOerqu5AgrMjsNcn3EyUwgRDE
 sHUqcJWMu2CMGGLkmaN1EnEMNSuhoMD6ZOiYS+P+H4ob1PpCJTygZbA3vwCo4Xv1zQ3p
 iivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880839; x=1792485639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oIQa2uLYcdnzWkI38CuG/P8pp77y4VLZYUd1uI22D4g=;
 b=K+9HmC1QLH+2nNvIHpejdVCmdesOCOu7DLCOEaeiS7MW1JdWAxV1K+PXsb9hRxhZcJ
 rdCpTfHriF9JOD1kEY8qkZFCarF+eNnaSZt3OTYoSrfs4NUMkihgGx3fdnkWKNCf1KiR
 65X7/J+e9tvubAP6wEf5p2zOp5GV1lTKgFYD3b5fPZ+8xnABlRYS6V1pw0Rc6oWxN61G
 ZpObiZAgqo8ElM65eHco7+EVNTWAZKxs0AYjaBnWtvW+GceuHXzI949jI/PmQsUbaEhC
 i+f30NMRSJQ/XzWcJEHJnrnbe/RgVsamyHUJ3CCApwIJQeXPOPVXujWvEbvRSSb67v+d
 pRPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJg5IfYOf+I1v7Nce3Mg0ApKKoiFXxJrZQyYpm2dMEMw84ckS8ODbMnNqwA+zkdZrqgdYYoEal/nCI@nongnu.org
X-Gm-Message-State: AFq9FYIijR9Px0Klq4AuQd91TEXfDBKdg3L//Iz+b4UYrMDIvJ3Lp6RO
 oAWg7rbQPZLRgQIolLpPhBqVyITfUprOGg5XMsc506ZfUxyRpcmTmoAaFzjCthvTGyw=
X-Gm-Gg: AYBFou1wleg8bNT82qSzRdmQQcalC0IXoreoH1zcH3AjHnQHlkyBJHLTlK2K9+3Vrrb
 1TAYCJMODNHotgejMQhkSkB1TCsF7isKN+Lg/jm1201GfvZSIfMZ0VHCMVn8HkFzxhcU6dJJqMW
 V3gAx+LcC0lO/7ReftetR+l4Hws+FC977MSCZnvqumWkwy/GqmpRhj5BAe/viG8+ulDHDiT4YlG
 WnjfbNiV0AtE41zyRtupxbC3tnfNHVnK4Q+LX8WkWhl0r4WG1myQbEQyMpe6MUqfUOgWLBo+52p
 ugvujiC7VqImyDxGtIMCQnQSM4VRi0De3Gl8qWyFajjRNgPWaLNY0xo4KUQARFkixZMdI6fmSZz
 I/9Cr558T8YiFaK/GB9T65Q8jBWu9o1kjlSXSl+AYrCkRDzbKE6MIn/Y2U2c24h68ctW9cxGfri
 cXunsAf9re9k7V1OvuHDOKuPdKEfM9Uznca8I+gSDc8vQRlaXJvjSAzAOa+B2v1HEa3n287qKac
 zgmzpAqTqGIF5leIE0YuEEwnNNPaE8gAaNBZg6Tos71wjJ2n1j/26QPlEQFwae8mypW+oRheMJh
 TkRxXX1WTbvVuw==
X-Received: by 2002:a05:600c:3b87:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a18e4a977fmr291496295e9.16.1791880839142; 
 Tue, 13 Oct 2026 01:40:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 46/86] target/arm: GICv5 cpuif: Handle injected PPIs in GICR
 CDIA
Date: Tue, 13 Oct 2026 09:38:53 +0100
Message-ID: <20261013083933.1024405-47-peter.maydell@linaro.org>
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

When GICR CDIA for the virtual interrupt domain acknowledges an edge
handling-mode interrupt, it causes it to no longer be pending.  If
this is a PPI which is being direct-injected, we need to update the
physical PPI pending state, not the virtual state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 5a2927faf75..1f032e39bf6 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -1317,6 +1317,27 @@ static bool gic_hppi_is_nmi(CPUARMState *env, GICv5PendingIrq hppi,
     return hppi.prio == 0 && arm_sctlr(env, arm_current_el(env)) & SCTLR_NMI;
 }
 
+static void gic_clear_vppi_pending(CPUARMState *env, uint32_t ppireg,
+                                   uint64_t ppibit)
+{
+    /*
+     * Mark the specified virtual PPI as no longer pending.  ppireg is
+     * the PPI register index (0 or 1) and ppibit is a mask with
+     * exactly 1 bit set in it.
+     */
+    uint64_t dvi_mask = gic_virt_dvi_mask(env, ppireg);
+
+    if (!(dvi_mask & ppibit)) {
+        /* Easy case: vPPI not direct injected */
+        env->gicv5_cpuif.ich_ppi_pend[ppireg] &= ~ppibit;
+        return;
+    }
+    /* vPPI is direct-injected: unpend the physical PPI */
+    ppibit = gic_ppi_vpend_to_ppend(env, ppibit, ppireg);
+    env->gicv5_cpuif.ppi_pend[ppireg] &= ~ppibit;
+    gic_recalc_ppi_hppi(env);
+}
+
 static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Acknowledge HPPI in the current interrupt domain */
@@ -1381,7 +1402,7 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
             env->gicv5_cpuif.ich_ppi_active[ppireg] |= ppibit;
             if (hm_edge) {
                 /* handling mode is Edge: clear pending */
-                env->gicv5_cpuif.ich_ppi_pend[ppireg] &= ~ppibit;
+                gic_clear_vppi_pending(env, ppireg, ppibit);
             }
             gic_recalc_virt_ppi_hppi(env);
         } else {
-- 
2.43.0


