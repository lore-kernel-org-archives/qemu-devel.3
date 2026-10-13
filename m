Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117CACC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY7u-00062N-Sf; Tue, 13 Oct 2026 04:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4L-0000nW-TI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4J-0008DJ-My
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so24336335e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880866; x=1792485666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3fH1g5tdo8tCigjV124Cc0dlO1K5fRGTqJqA4DWBEjE=;
 b=QOEMMYGrww4cYMthgYTwYZAs2GlFGLCq1g8+WcdhAVsCNqSDLgdnbZKFFTC4a5SfEi
 3ZrH7bUGPQsP4a8AVkyVJ81LpQFODQcUosW9ggMdxAkPaQBzomu9QLZ8TjxGdDw00A/e
 dTInQ3U7EZqV0mPu6S/V3REsN/6DFniHksY97RzccItGqBsV+/scDYs7Y7m51y1SYejr
 u9u/htwZtfhHTCVUMnjzkpUbrmOO0qlTiIXVSD1U2lccX3OHQx/GzlxDtgOFnwvc2VWv
 j3Sl5i25Zehx01CfvZQehOD7tQzquk1+UDAFwQOmz2ChWFOgZYe2UnsfjUWDXmFEFGVC
 OMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880866; x=1792485666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3fH1g5tdo8tCigjV124Cc0dlO1K5fRGTqJqA4DWBEjE=;
 b=Acc+hXQZBV4Ls2DFstxH2l+czfc1WmAeMVzrvGwNfOaDzGdubkuTh1JKdj8ZKglxFO
 5BI3OeRm4IS6qS8d9rf9FoSh8WxSyc0j4A8epexS+J05WKBcwIbjCesZ1vUOSLBwn/im
 Y477RSo9wRFM/gubKj7oq3Hoyah1HF+YIYuHaTNhpd5wrbdQCEQvFgB/rleXnfX9phqq
 1a6eGw5tHvv3zQ7JsaNfCzdMKeGQLvW3tKAYjj1hQ9dI6Mj9Ge+G16+KkIXdmyxGU00G
 EtQG1rlHJBPWCIJdJgoAUZr7owzrtJEWXGr+8mmxxGw8qjHHNRhuRGlLi5tptL5/s3oA
 f+sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9C7esWyE/GQpTpoqTsJAtoeO/t7rgW3gMNHZomYIDu1pYONqgHqrFRJLnrGizmlCm/mxLyLzlGE3H@nongnu.org
X-Gm-Message-State: AFq9FYKDVvC/JQbdmxENmdHMU69THz1Mg56sqUdcN+Yl2MrLq9R7t0+k
 A2rqLHdhzfBxz+yFZJkUGurUS6KqErxrtMr8sBd58g18B1vYQ/0I+9Sy6Kik56XOuxixiA5zncW
 UITRbalA=
X-Gm-Gg: AYBFou332EVoS+8XZR8r5QH7I862TYvEjRdybfvAyGzCF/sLxLJSzm+WPf3W1rpP7iZ
 823CrQdjySahRtHixV9w8cyRkxyP27cXtt0pmMzli5fS5gN0miSzTUIE50mvuZa3vQul8oRq5Xk
 +nD8z/6NWQiIXogfgfKV80p9odDVavYaznGEd67nnRsksmkMyuMJ8puDpnZodiPkrz2zUjRoPwV
 ojv2Dzvz7rWYGjIbrue7pbNFzEjO3D+qkMKpKgRjNUMYNLn9nN4X7DbeYNHGtrhb/MaA5OFZ1gH
 0Mx/tjitAjIxS/4EU6nQAkUXqpY/oRcoueBW71dmI9nIt8vVgcbMDj+jGm74hVF7u0oEplkF6ao
 zBlA3aSGIrWRETN+tK1TUFzfHi9KDZ1hqEGJkBzH0JRwpS70VfE8n/FrG9h1Da06Gv/tnT5dg+r
 iDGl+X3wAUUrwXa+MWIK65UbFau6un2PT+fSYet7JAy7lD0ttKPDGSp95504BA0PxnaM74OCJzW
 IfARn+Kq/Ks8FqNZ5kjOvUOx+XqkQhblM6utgioriVeqI1AH2XC5L0X6LTbGtRDRWZmXM4UG/M4
 ttc=
X-Received: by 2002:a05:600d:644f:10b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4a196611aa3mr120014655e9.29.1791880866104; 
 Tue, 13 Oct 2026 01:41:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 70/86] hw/intc/arm_gicv5: Handle virtual=true in
 gicv5_set_priority()
Date: Tue, 13 Oct 2026 09:39:17 +0100
Message-ID: <20261013083933.1024405-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
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

The gicv5_set_priority() function has a 'bool virtual' argument so the
CPU interface can tell us whether it is setting a virtual or physical
interrupt's priority. Implement the handling for this.

What we need to do is identical to what we do for physical LPIs,
except that we need to do it on the IST for vLPIs or vSPIs for the
resident vCPU.  So we can factor out the "update the appropriate
field in the L2 ISTE".  We do this via a macro, because we're going
to want identical behaviour for the other fields in an L2_ISTE that
gicv5_set_enabled(), gicv5_set_pending(), etc update.

Actually recalculating the vHPPI for the affected vCPU will be
implemented in a later commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 90 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index fc1f09f51e8..e460d7957fb 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -567,6 +567,81 @@ static hwaddr l1_vmte_addr(GICv5Common *cs, const GICv5VMTConfig *cfg,
     return cfg->base + (l1_index * 8);
 }
 
+static void irs_recalc_vhppi(GICv5 *s, VMTE *vmte, uint32_t iaffid)
+{
+    /*
+     * Recalculate the highest priority pending virtual interrupt for
+     * the specified VM and vCPU.
+     *
+     * TODO: we will implement this in a future commit.
+     */
+}
+
+static const GICv5ISTConfig *ist_for_vint(GICv5 *s,
+                                          GICv5Common *cs,
+                                          GICv5Domain domain,
+                                          GICv5IntType type,
+                                          uint32_t cpuidx)
+{
+    /*
+     * Return the GICv5ISTConfig to use to look up the virtual interrupt.
+     * Return NULL for any case where the operation should be a NOP.
+     */
+    VMTE *vmte;
+    VPE *vpe;
+
+    if (!gicv5_domain_has_virt(cs, domain)) {
+        return NULL;
+    }
+
+    vpe = s->res_vpe[cpuidx];
+    if (!vpe) {
+        return NULL;
+    }
+    vmte = vpe->vmte;
+    if (vmte->domain != domain) {
+        /* Ignore commands for the wrong domain (see R_PYWKM) */
+        return NULL;
+    }
+
+    return type == GICV5_LPI ? &vmte->lpi_ist : &vmte->spi_ist;
+}
+
+/*
+ * Define a function that, given a GICv5ISTConfig and an interrupt ID,
+ * will update the L2_ISTE entry for that interrupt in that IST to
+ * set the given field to a new value. The function returns true on
+ * success and if iaffid is non-NULL updates *iaffid with the IAFFID from
+ * the L2_ISTE (which is the IAFFID whose current HPPI will need to be
+ * recalculated).
+ */
+#define DEF_SET_FIELD_FOR_IST(NAME, TYPE, FIELDNAME)                    \
+    static bool set_##NAME##_for_ist(GICv5Common *cs,                   \
+                                     const GICv5ISTConfig *cfg,         \
+                                     uint32_t id,                       \
+                                     TYPE NAME,                         \
+                                     uint32_t *iaffid)                  \
+    {                                                                   \
+        L2_ISTE_Handle h;                                               \
+        uint32_t *l2_iste_p;                                            \
+        if (!cfg) {                                                     \
+            return false;                                               \
+        }                                                               \
+        l2_iste_p = get_l2_iste(cs, cfg, id, &h);                       \
+        if (!l2_iste_p) {                                               \
+            return false;                                               \
+        }                                                               \
+        /* read IAFFID first in case we are about to write to it */     \
+        if (iaffid) {                                                   \
+            *iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);          \
+        }                                                               \
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, FIELDNAME, NAME);  \
+        put_l2_iste(cs, cfg, &h);                                       \
+        return true;                                                    \
+    }
+
+DEF_SET_FIELD_FOR_IST(priority, uint8_t, PRIORITY)
+
 void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual,
                         uint32_t cpuidx)
@@ -580,8 +655,12 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
     priority &= MAKE_64BIT_MASK(5 - QEMU_GICV5_PRI_BITS, QEMU_GICV5_PRI_BITS);
 
     if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
-                      "priority of a virtual interrupt\n");
+        const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+
+        if (!set_priority_for_ist(cs, cfg, id, priority, &iaffid)) {
+            return;
+        }
+        irs_recalc_vhppi(s, s->res_vpe[cpuidx]->vmte, iaffid);
         return;
     }
 
@@ -589,15 +668,10 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
     case GICV5_LPI:
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-        L2_ISTE_Handle h;
-        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
 
-        if (!l2_iste_p) {
+        if (!set_priority_for_ist(cs, cfg, id, priority, &iaffid)) {
             return;
         }
-        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PRIORITY, priority);
-        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
-        put_l2_iste(cs, cfg, &h);
         break;
     }
     case GICV5_SPI:
-- 
2.43.0


