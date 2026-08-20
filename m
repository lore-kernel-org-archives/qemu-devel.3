Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E97C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwsq9-0001uq-De; Wed, 19 Aug 2026 22:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspp-0001q3-1B
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:53 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspn-0000N1-89
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:52 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66c70f05859so2997924d50.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194130; x=1787798930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eTvDxTUytdELgFkhMw1eLbOOivxcRj8qqSrmYJFQkO0=;
 b=mx9UkjK+gwEw7hB5sO4Ha/hKr9O3GGzjYWIXk8q/L25Hv6xuH8jgrWjK50emshd2oQ
 /AN01gzNHaHHJwB0w/S3UcpBnsx8GFmuv+yNuDR3MhtPtqNQ3NMUP2Lon1LUZXmrOpDD
 B4beKsO2uq4tAyDjFLv7zwefDeVi+HOxzeGSSGvO+9soRPUsZnjQ/4CQrh4DQVgmvSGA
 /gAYum6MxJxM5SX5PlnVLmL4JGnEh0TfKT/vLDoVr4IjaE/SC9OxVnHfLf0oqLKizyCc
 kii4sq/VZMXf1hZKh++Z36BK2cXj9EEyd2fCemN7lY3Zb6/nKcIca279EvgOsHXetsEL
 pg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194130; x=1787798930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eTvDxTUytdELgFkhMw1eLbOOivxcRj8qqSrmYJFQkO0=;
 b=ITHCYVo08rzy3Q2Vg2DkLEqSdIT/dZoaD7pf73qqNou0UdCGxWwkdZ71/1DNkiCMzZ
 U6YWcxyRokQEdKi3SGVKwBCYkcba4wQlY5ezHG2V9SOR/FAVYHGY/gn7VqDoEawFKE8h
 xJ5WgCepzpbHocxaJbwgYsy+6rprqXGc3oYeHpdwhS4CzmdnJiHVpA3b/9yvOSgpvuVi
 39hnt8/nJvxSLanLCCJpjEootgOLeMT/T8Sd5ym1NZi/rowvmEChgCpQDSbo/mhew2X8
 T3k0eNb/leqKkiKYYyVcckoB/leGVvamUalPvhaHyo70SQmd7j8ay4TsRRbd6TaBG6ko
 FLXg==
X-Gm-Message-State: AFuF++neomZbvnseQ37ov0teNjCna8nj0+xihooOjzcZRk7qwAXa2gIz
 IdF93cCFG/xPGhsQxjTf7Ih4nRTFVZ7yVHz3dJWPlH0Hw/VA1hTSD7QrWJeMDA==
X-Gm-Gg: AR+sD13qS2+yFO/ea4T9Dl3z9SvM5+FpsHwRRd7Q8Wn1o854kR5jC2LXTvrNNv6TeaG
 fULY22kGwXprf5bFV+ls8qB+ej4qrMbrKTfZJv8MH4K02YIqqgMw0I0FkanAMA/1Tlvv0/1Fgza
 KHbGbdC1N4aak3CVtqTBZP2B1+WCsS1cP0tWEO0pe9nFL56AbnqQr+pIVw048Ms6r79jHJ9Eypp
 dy8hUEXFSO/3xKPJb0PpWbi4jv0y7knywNl7nriQjbLNeTXv6Q0hlt8eF9z0EqnDcmeDiyoaXy+
 qtFtkVGiBXMPnJEqAQP0YHe/T8Xx7AdlFbsVEuc39A7QT5QMaFa/xbnR/2ALKKm7ryKN5REPA2N
 Gg1Io+rDasacjzOY9XdP/7aNgQTG1Wjg1K9pwUPYcVYXbg6p27qGMvSnGJXdyLKZBM4JArKLp+Z
 wtI/owPwj8yOAiHJHU3A7S2p4oe8aB8ZT5dkzoYzcqgEpvXaYUJ/SH/EN1fiPpUF2MA5IloK907
 1S0mtdYazYlAO0fcQeFAReCgSaUj/lpEgDtpm14/bee8zfXk5nkwQ==
X-Received: by 2002:a05:690e:c4e:b0:667:a025:89a4 with SMTP id
 956f58d0204a3-66ccb618589mr3103247d50.18.1787194129879; 
 Wed, 19 Aug 2026 19:48:49 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:49 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 03/16] target/arm: opt-in align-down for a misaligned PMSAv7
 MPU RBAR
Date: Wed, 19 Aug 2026 21:48:21 -0500
Message-Id: <20260820024834.3286721-4-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

A PMSAv7 MPU region base that is not aligned to its region size is
UNPREDICTABLE per the architecture, and QEMU disables such a region.
Some PMSAv7 implementations instead ignore the sub-size low bits of
RBAR.ADDR and match against the aligned-down base. The NXP i.MX 95 RT
core (Cortex-M7) SDK firmware relies on this for a peripheral region
(DRBAR 0x4c800000 programmed with a 512MB size, intended as 0x40000000).

Add an opt-in "pmsav7-rbar-align-down" property that aligns such a base
down instead of dropping the region. It defaults to false, so existing
behaviour is unchanged, and is only registered on PMSAv7 CPUs (v7-M and
v7-R, i.e. v7 without v8), where get_phys_addr_pmsav7() runs.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
 target/arm/cpu.c | 19 +++++++++++++++++++
 target/arm/cpu.h |  6 ++++++
 target/arm/ptw.c | 28 +++++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..22e84c1ced2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1349,6 +1349,16 @@ static const Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
+
+/*
+ * Opt-in: treat a PMSAv7 MPU region base that is not aligned to its region
+ * size as aligned-down instead of UNPREDICTABLE (see get_phys_addr_pmsav7()).
+ * Only registered on PMSAv7 (v7-M / v7-R) CPUs, and only enabled by an
+ * integrator whose firmware relies on it (e.g. the i.MX 95 Cortex-M7).
+ */
+static const Property arm_cpu_pmsav7_rbar_align_down_property =
+            DEFINE_PROP_BOOL("pmsav7-rbar-align-down", ARMCPU,
+                             pmsav7_rbar_align_down, false);
 #endif
 
 static bool arm_get_pmu(Object *obj, Error **errp)
@@ -1659,6 +1669,15 @@ static void arm_cpu_post_init(Object *obj)
         if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
             qdev_property_add_static(DEVICE(obj),
                                      &arm_cpu_pmsav7_dregion_property);
+            /*
+             * get_phys_addr_pmsav7() only runs on PMSAv7 CPUs, i.e. v7
+             * without v8 (a v8 M/R core uses the PMSAv8 MPU, which has no
+             * such alignment rule), so only offer the property there.
+             */
+            if (!arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+                qdev_property_add_static(DEVICE(obj),
+                        &arm_cpu_pmsav7_rbar_align_down_property);
+            }
         }
     }
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c0492c8dfbc..03ead3cda15 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1145,6 +1145,12 @@ struct ArchCPU {
      * architecture version.
      */
     bool cfgend;
+    /*
+     * If set, a PMSAv7 MPU region base that is not aligned to its region
+     * size is treated as aligned-down (matching Cortex-M silicon such as the
+     * i.MX 95 M-cores) instead of the architectural UNPREDICTABLE drop.
+     */
+    bool pmsav7_rbar_align_down;
 
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a29de0385f4..51805c05226 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2757,11 +2757,29 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
             rmask = (1ull << rsize) - 1;
 
             if (base & rmask) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "DRBAR[%d]: 0x%" PRIx32 " misaligned "
-                              "to DRSR region size, mask = 0x%" PRIx32 "\n",
-                              n, base, rmask);
-                continue;
+                if (cpu->pmsav7_rbar_align_down) {
+                    /*
+                     * Opt-in behaviour for Cortex-M silicon such as the
+                     * i.MX 95 M-cores: a region base not aligned to its size
+                     * is treated as aligned-down (RBAR.ADDR is only
+                     * [31:log2(size)]), matching that hardware, whose SM/RT
+                     * firmware programs e.g. DRBAR 0x4c800000 with a 512MB
+                     * size intended as 0x40000000. Off by default because the
+                     * architecture calls a misaligned base UNPREDICTABLE.
+                     */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "DRBAR[%d]: 0x%" PRIx32 " not aligned to "
+                                  "DRSR region size (mask 0x%" PRIx32 "); "
+                                  "aligning down to 0x%" PRIx32 "\n",
+                                  n, base, rmask, base & ~rmask);
+                    base &= ~rmask;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "DRBAR[%d]: 0x%" PRIx32 " misaligned "
+                                  "to DRSR region size, mask = 0x%" PRIx32 "\n",
+                                  n, base, rmask);
+                    continue;
+                }
             }
 
             if (address < base || address > base + rmask) {
-- 
2.34.1


