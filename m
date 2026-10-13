Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72580CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY5q-0002yU-R4; Tue, 13 Oct 2026 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3n-00081m-Dn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3k-0007xp-If
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1658175f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880831; x=1792485631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w1oglA4FavRm3WES/I25RSgG1C/w7HeWJ7z5SibC1Xk=;
 b=ckrUDqj2Fujj7WsSKiNg5ErtgctIfwQtZ8b2fiByIQ88naZ7PvsC7B2uELsdol20mQ
 Ym/swyHXS1Rp+ypkTZA/8EOLC+c6xLBygZnlhfoaDYP2oTl9IW8UCKhD1pZ/hhE5u1lX
 7Yaduvg11xafvOSgvvn6lJMQ7TN23J4NANsSjrcXFTSbBpegKi8x0ZWrqVAuaCRd6Typ
 xTyowTA4hkNHty9XbReHbzufad5tVOEGOgBX9wVFbeKtN18SutjSnyelbsFQ+gREK1rt
 K1SMe6WkYrwzyITIoMNNA5rDaNnrTCXSYzXl2rFBLl/kAFe64Z3i5cQw6hjo28lKCvOe
 NENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880831; x=1792485631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w1oglA4FavRm3WES/I25RSgG1C/w7HeWJ7z5SibC1Xk=;
 b=IUX+nbgpwLRFGByc779k7FuhRZNRa1/iZsCANmdkO1EgqlM7YxkjNXr2UAxKFtxP/4
 41QEKkXJzS3Ilsj4e7eAdnQxZS+1KtMEpKPw1zp3CFfnzW0D+78z6UHbhfTmlvE3XuIC
 p3zvMHtZbOYNEhoA4V6lqfyaRfFVN57iQkePgiku81LCyK0dXd+QkHCJ2Jg4Sqfvf3KP
 kQKfRx5S0vBlK76fUS0D+VFFBsmChX19q5QJ5FVBv1AZTz91xAf1IaTWOvVDaOPEdkRr
 Bqpe0EE7k+ckhA+AVQacK1zR9XOo8hPd4RPpmjN6cstqmGPYZPxNlOmaossjl/5sTJGb
 nD6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhPCpmocMGj/io8jnIwTap/DI85ZE/5fS2XvSJrdmwsxef5+nh3yCrZmLxBR7Ynvefs7n0bP6Hgouq@nongnu.org
X-Gm-Message-State: AFq9FYK9JHlLaSV/EpJbl3dMyQWre3X41rBwb1gkDpMUUjz/navreqMr
 doqXBA9wqwcPT85Urn8pT6XE13sYz7a6C3DH1Q2R2dKSa7/L6cBmmrA03wR4DmNV5EgcbI4HlO7
 0gYSn8pg=
X-Gm-Gg: AYBFou0JHZ9z1NAHiNgr+qNAkgS3a3Te9LOXagfTVDpnwWIzRv6tH6qvnujKsTzh3w/
 8uXfejlRaPIcvQ9fzdT4f3GRPrnr4xaaCl5pzwKNthpsFCx658l0a4FNElkjcu6hBfOh4jamHXV
 ZQxRKgvvg5E8OacGnnVFfcSqRTcdLkGXzMek7TkZBekuHumpg19uiggCFzZicX5I21tkUeiYhs4
 pM0FIM22Xnn6WGIjxvX/xjo3VNf0NCHauzDxRa31YQzkhSTk4R7i6ORj+VXz8WF61vMiHKfeKVj
 Ll0lInb8ePmaTule7nGAB/KhLjst7vY7WKCi9OhdkrFYpc6uH6GHAdH0Glc4aabvr0Q5aMrmDZ0
 fnzx+88ghHEhNPz/A3na8L6i5SetvZlxtA4mZfTW5ILf+I1EUIIhtmpwi09743nyb4Ei0sfer5o
 i74dBk+FBy2liexjNpDVvRiztZ0zx8N25hFdBcWHF0iEmR7FJVtUv/s2eHEWRgEmVh6AUgbEm17
 Mg+dnNUGF2A+9mgJFxDhwofwdTLQwrjqojvBRfo1HtpNuDjAgO5lhJx9I6eOPId25c+ZYPGSS18
 UNc=
X-Received: by 2002:a05:600c:c176:b0:4a0:c2a:485e with SMTP id
 5b1f17b1804b1-4a18e4dce0cmr225633745e9.33.1791880831049; 
 Tue, 13 Oct 2026 01:40:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 40/86] target/arm: GICv5 cpuif: Handle virtual interrupts for
 GICR CDIA, CDNMIA
Date: Tue, 13 Oct 2026 09:38:47 +0100
Message-ID: <20261013083933.1024405-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Handle the virtual interrupt domain in our GICR CDIA and
GICR CDNMIA implementation. LPIs and SPIs are handled by
passing through the 'virtual' parameter; PPIs look at the
virtual PPI state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 40 ++++++++++++++++++++++++++----------
 target/arm/tcg/trace-events  |  4 ++--
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index c85d72b05d0..4ee548a768b 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -1143,7 +1143,7 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
     GICv5Common *gic = gicv5_get_gic(env);
     bool virtual;
     GICv5Domain domain = gicv5_domain_for_insn(env, ri, &virtual);
-    GICv5PendingIrq hppi = gic_hppi(env, domain);
+    GICv5PendingIrq hppi = virtual ? gic_virt_hppi(env) : gic_hppi(env, domain);
     GICv5IntType type = FIELD_EX64(hppi.intid, INTID, TYPE);
     uint32_t id = FIELD_EX64(hppi.intid, INTID, ID);
 
@@ -1151,20 +1151,20 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
     if (hppi.prio == PRIO_IDLE) {
         /* No interrupt available to acknowledge */
-        trace_gicv5_gicr_cdia_fail(domain,
+        trace_gicv5_gicr_cdia_fail(domain, virtual,
                                    "no available interrupt to acknowledge");
         return 0;
     }
 
     if (gic_hppi_is_nmi(env, hppi, domain) != cdnmia) {
         /* GICR CDIA only acknowledges non-NMI; GICR CDNMIA only NMI */
-        trace_gicv5_gicr_cdia_fail(domain,
+        trace_gicv5_gicr_cdia_fail(domain, virtual,
                                    cdnmia ? "CDNMIA but HPPI is not NMI" :
                                    "CDIA but HPPI is NMI");
         return 0;
     }
 
-    trace_gicv5_gicr_cdia(domain, hppi.intid);
+    trace_gicv5_gicr_cdia(domain, virtual, hppi.intid);
 
     /*
      * The interrupt becomes Active. If the handling mode of the
@@ -1177,23 +1177,41 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
      * gicv5_activate() cause a re-evaluation of HPPIs they use the
      * right (new) running priority.
      */
-    env->gicv5_cpuif.icc_apr[domain] |= (1ULL << hppi.prio);
+    if (virtual) {
+        env->gicv5_cpuif.ich_apr_el2 |= (1ULL << hppi.prio);
+    } else {
+        env->gicv5_cpuif.icc_apr[domain] |= (1ULL << hppi.prio);
+    }
+
     switch (type) {
     case GICV5_PPI:
     {
         uint32_t ppireg;
         uint64_t ppibit;
+        bool hm_edge;
 
         assert(id < GICV5_NUM_PPIS);
         ppireg = id / 64;
         ppibit = 1ULL << (id % 64);
 
-        env->gicv5_cpuif.ppi_active[ppireg] |= ppibit;
-        if (!(env->gicv5_cpuif.ppi_hm[ppireg] & ppibit)) {
-            /* handling mode is Edge: clear pending */
-            env->gicv5_cpuif.ppi_pend[ppireg] &= ~ppibit;
+        /* handling mode is constant and doesn't differ for virt vs phys */
+        hm_edge = !(env->gicv5_cpuif.ppi_hm[ppireg] & ppibit);
+
+        if (virtual) {
+            env->gicv5_cpuif.ich_ppi_active[ppireg] |= ppibit;
+            if (hm_edge) {
+                /* handling mode is Edge: clear pending */
+                env->gicv5_cpuif.ich_ppi_pend[ppireg] &= ~ppibit;
+            }
+            gic_recalc_virt_ppi_hppi(env);
+        } else {
+            env->gicv5_cpuif.ppi_active[ppireg] |= ppibit;
+            if (hm_edge) {
+                /* handling mode is Edge: clear pending */
+                env->gicv5_cpuif.ppi_pend[ppireg] &= ~ppibit;
+            }
+            gic_recalc_ppi_hppi(env);
         }
-        gic_recalc_ppi_hppi(env);
         break;
     }
     case GICV5_LPI:
@@ -1203,7 +1221,7 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
          * name of the stream command, does both "set Active" and
          * "maybe set not Pending" as a single atomic action.
          */
-        gicv5_activate(gic, id, domain, type, false);
+        gicv5_activate(gic, id, domain, type, virtual);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 31c6eafd8ed..856a11b7d1b 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -4,8 +4,8 @@
 # gicv5-cpuif.c
 gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
 gicv5_recalc_virt_ppi_hppi(uint32_t id, uint8_t prio) "virtual domain new PPI HPPI id 0x%x prio %u"
-gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
-gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
+gicv5_gicr_cdia_fail(int domain, bool virtual, const char *reason) "domain %d virtual %d CDIA attempt failed: %s"
+gicv5_gicr_cdia(int domain, bool virtual, uint32_t id) "domain %d virtual %d CDIA acknowledge of interrupt 0x%x"
 gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
 gicv5_vcdeoi(void) "virtual interrupt domain CDEOI performing priority drop"
 gicv5_cddi(int domain, bool virtual, uint32_t id) "domain %d virtual %d CDDI deactivating interrupt ID 0x%x"
-- 
2.43.0


