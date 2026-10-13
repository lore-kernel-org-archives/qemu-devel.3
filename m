Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AE2CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY6G-0003yp-6F; Tue, 13 Oct 2026 04:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY42-00007M-KV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3z-000834-Lx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so22382585e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880846; x=1792485646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RpxSc5E6JZ85OCnxoQbmovvqMsjQZ6XLtXXpnhtsTUk=;
 b=XDOLGvT1ait4uHOStt0udr0pzwZGGkH5QCs4eIqjvm7Y+XUYNG5Pkhb8AnvoVAKak4
 EjkWRFf9qLiPbcXVXC4GaTql+39aKVfhnDaKHRV0I6726YNEaGVDrviqk2bbwl0g1/AF
 gPgaiVhOUZRLGbyQTOEMdkdj0ZApam8CAxBh8LQeyvrKZzKaKGsvwrAF8piXzy1hPhXa
 n37BggokmgyGNTRgWy8ZONR9vY3M2dit4QQamkMrSp4zzSGxHC1UZK7ifV9OrkFZoSev
 XhlMi3CjTttOb/fYYzTikJVQmXZK7nk5h2pY7u/wlw/NHv1tOxNw+pAW01VNeO4IBgu3
 jgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880846; x=1792485646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RpxSc5E6JZ85OCnxoQbmovvqMsjQZ6XLtXXpnhtsTUk=;
 b=xa/j5udoDJdF7OR6L1rO/MpgqFV+Eq1AfPyK/x8gmhbB49xDAp/jlFfP2ZtAS3i3g9
 aJOv3qrjMJbBwxQaUIDZyq2jVMV3dj/XSMMbBk9t2MdXezDx5iURL3maOTLQZQe006En
 Ctx+b+wtFZT5Iy5t5hd1wCqFFzYto3b02SkILNLA3xk006BvvR0gf1JD+pD+bxPQTBsk
 KENGOurF1SygdhlQCch9ckGEfj6WxaZfzrUg5LMqLSPQlkVeXtXmIrJ8eOILVsx15j/p
 PZIQpOc2Cw1g6wqALuBKFBPZhIlEj4/3Hqp0o0KR5wiuDoEsFE8pmA6Dfotfe1JfF/S0
 pm3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBaMnWS642sgysXxZbSlzJQ4h7f3QWqKsuu+SvCKWgvsTjVIldIDr1kyM6ZiIQE0qU3lfikLHOB5bd@nongnu.org
X-Gm-Message-State: AFq9FYJ+A//5XSXA83/7tCSL/KtNHRx4ORoq1eVPyH5hIhlug1BV6XPA
 KYoidHbVV1CoKnalQbKIFBgaXGCvRGqTb9od4qLa4O+sxNDfrMrMW156drW98Ym7rwQ=
X-Gm-Gg: AYBFou1ugQu7CqcIrX0xvDMlyFHpnKXJOF1M8+B4NyZ8xFE7W+QfV25jjY+ROG+s+7h
 hkbwi1uAw2vtkN6gZmWleTJ4wWjKDWaTEJwdCFfY/m7hPJ9/Lqu37el6144Rwh/ahk114cVbLWK
 raOIS4hRs867w1Q+DDJqdmxZtsVWlmwQgm8nfKIo5BVPl+Ijo0tmrUX726mo/CgpMTdGl7GhBZG
 YA/m+6wxfO12SbwARaKonoW/0u12O35PhUTxOZi6bPMStWDEYFtSPtJbwiCiSYHsvSOsk6qBuNq
 q1n/HzoW1SWptcRaLblx+y1nyiD6WvZVUsp4Qmxh3NZqxpcP1TKgADJnylPWRIaLZJXA/reCej3
 kNDQJHqRmqiiup06Y9i+qSJSU9isRxIKshB0v9Ft1Ic7ptd6pH8NOChM/P7jEMxxEVoM5IPmtRM
 V43EGBqIqxMsgxfPX2LOwdUx+Fp+//+ByBoWZnNJZtn0Q4oFkjgEE/2NBxOWZJIY1CjZmZUnyWm
 D8xCPSMEExV5TYzfgIIP9yTWhir3Lt/ZWLXbLCFry5XwIXOE8OaQKBU+nt2rx3iHSDESFXEYvub
 Wx4=
X-Received: by 2002:a05:600c:3e8d:b0:4a1:7701:f863 with SMTP id
 5b1f17b1804b1-4a18e4aeae4mr216049495e9.15.1791880846024; 
 Tue, 13 Oct 2026 01:40:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 53/86] hw/intc/arm_gicv5: Implement IRS_VMT_BASER and
 IRS_VMT_STATUSR
Date: Tue, 13 Oct 2026 09:39:00 +0100
Message-ID: <20261013083933.1024405-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Implement the GICv5 IRS_VMT_BASER register, which holds the base
address of the VM table.  This is very similar to the IRS_IST_BASER
register: it is 64 bits wide but can be accessed as two 32 bit
pieces, it has a valid bit which the guest sets to make the table
valid, and there is an associated IRS_VMT_STATUSR register which has
an IDLE bit which the guest can read to find out when the write to
VALID has completed.

Implement IRS_VMT_BASER and IRS_VMT_STATUSR, using the same pattern
we have for IRS_IST_BASER and IRS_IST_STATUSR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 73 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  4 ++
 hw/intc/trace-events               |  2 +
 include/hw/intc/arm_gicv5_common.h |  1 +
 4 files changed, 80 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 63e4a165eea..05c6b9c57fc 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1166,6 +1166,36 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 }
 
+static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    if (!gicv5_domain_has_virt(cs, domain)) {
+        return;
+    }
+
+    if (FIELD_EX64(cs->irs_vmt_baser[domain], IRS_VMT_BASER, VALID)) {
+        /* If VALID is set, ADDR is RO and we can only update VALID */
+        bool valid = FIELD_EX64(value, IRS_VMT_BASER, VALID);
+
+        if (valid) {
+            /* Ignore 1->1 transition */
+            return;
+        }
+        cs->irs_vmt_baser[domain] = FIELD_DP64(cs->irs_vmt_baser[domain],
+                                               IRS_VMT_BASER, VALID, valid);
+        trace_gicv5_vmt_invalid(domain_name[domain]);
+        return;
+    }
+
+    cs->irs_vmt_baser[domain] = value;
+
+    if (FIELD_EX64(cs->irs_vmt_baser[domain], IRS_VMT_BASER, VALID)) {
+        trace_gicv5_vmt_valid(domain_name[domain],
+                              cs->irs_vmt_baser[domain] & R_IRS_VMT_BASER_ADDR_MASK);
+    }
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -1271,6 +1301,31 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_IST_CFGR:
         *data = cs->irs_ist_cfgr[domain];
         return true;
+    case A_IRS_VMT_BASER:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(cs->irs_vmt_baser[domain], 0, 32);
+        } else {
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VMT_BASER + 4:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(cs->irs_vmt_baser[domain], 32, 32);
+        } else {
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VMT_STATUSR:
+        /*
+         * QEMU writes to IRS_VMT_BASER and IRS_VMAP_* take effect
+         * instantaneously, so the guest can never see the IDLE bit as 0.
+         */
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = R_IRS_VMT_STATUSR_IDLE_MASK;
+        } else {
+            *data = 0;
+        }
+        return true;
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1373,6 +1428,14 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_MAP_L2_ISTR:
         irs_map_l2_istr_write(s, domain, data);
         return true;
+    case A_IRS_VMT_BASER:
+        irs_vmt_baser_write(s, domain,
+                            deposit64(cs->irs_vmt_baser[domain], 0, 32, data));
+        return true;
+    case A_IRS_VMT_BASER + 4:
+        irs_vmt_baser_write(s, domain,
+                            deposit64(cs->irs_vmt_baser[domain], 32, 32, data));
+        return true;
     case A_IRS_SPI_SELR:
         cs->irs_spi_selr[domain] = data;
         return true;
@@ -1457,6 +1520,13 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_IST_BASER:
         *data = cs->irs_ist_baser[domain];
         return true;
+    case A_IRS_VMT_BASER:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = cs->irs_vmt_baser[domain];
+        } else {
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
@@ -1469,6 +1539,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_IST_BASER:
         irs_ist_baser_write(s, domain, data);
         return true;
+    case A_IRS_VMT_BASER:
+        irs_vmt_baser_write(s, domain, data);
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 17fd67b5ccd..89669493b83 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -104,6 +104,10 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
          */
         cs->irs_spi_selr[i] = cs->spi_base + cs->spi_irs_range;
     }
+
+    if (cs->has_virt) {
+        memset(cs->irs_vmt_baser, 0, sizeof(cs->irs_vmt_baser));
+    }
 }
 
 static void gicv5_common_init(Object *obj)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 6681e32d1b7..3c7619cf3cd 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -246,6 +246,8 @@ gicv5_deactivate(const char *domain, const char *type, bool virtual, uint32_t id
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
+gicv5_vmt_valid(const char *domain, uint64_t base) "GICv5 IRS %s VM table now valid: base 0x%" PRIx64
+gicv5_vmt_invalid(const char *domain) "GICv5 IRS %s VM table no longer valid"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 7b24cad211b..f134602d66e 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -89,6 +89,7 @@ struct GICv5Common {
     uint32_t irs_cr0[NUM_GICV5_DOMAINS];
     uint32_t irs_cr1[NUM_GICV5_DOMAINS];
     uint32_t irs_pe_selr[NUM_GICV5_DOMAINS];
+    uint64_t irs_vmt_baser[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


