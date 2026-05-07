Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7334CCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11v-0005Hb-Fh; Thu, 07 May 2026 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11s-00056B-NR
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11q-00040J-T3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso7557595e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169165; x=1778773965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P0gAQQxsh9I1aOtpvt/kztG4Nh8b9O7yCDf8P41bgao=;
 b=Owl3j5ANe2PtHJrstRMsQGumt/zpF3d/rh8+rp0DBIDIfLTya8i4d/nRKRKci6o0xU
 KDLqZ/NH7j+zFeOq9dOTMUDGUULJ5sBIIu1WhJYNxdDIVhibhB9O03Rd3sIX9lyQ3zQb
 I24PieULjX5fYsZUYwjfn1R/2ScvvlZC5Y3y7DMyWToasHNxYtLYdkqmq9BAjAEWwLq5
 BsHTiexv0mhB1w/lrzqXvVOPoRMPz+wSL/tTvTr1IRIRQ1Ugu0gW+xW91bl0VZ2Xz0OB
 vgHFED9h/ffFDkKqCkit9QNnEyGyd2f1LHnCl8ESfed7SdftPpVtbtvA+MMBI1VOOefK
 6KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169165; x=1778773965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P0gAQQxsh9I1aOtpvt/kztG4Nh8b9O7yCDf8P41bgao=;
 b=c2d2/xBrAySExwhqTvdiY0Mrgx8jS075UKC84G7S7w5+Fy7xH8pI9qGXsc0168/lI6
 o2OQdYUvN+wNCq0fXrJcP8dP6Pikg/cIaswm6y24etT5HCO724ljrpS6aytL8KjCOWw/
 wBY/8lE2MUHwKJODpLWKE2xw5bvlDM9HhqSCr0weF/kOg6fWrl+dz2dVbBBSJ764Izr7
 vtyASdhcY7V1Mr/IxDrQJq/FSHUFjTJUZBCStqhyveuKMQ1iBZsYIemZxfzch8uKfPBP
 A3NsulukA503x8lxAV5X+MlDcl1F23knFQyB6d2sL8Llpw8M0zdTTVoaQuTyKOedmWjY
 iXKQ==
X-Gm-Message-State: AOJu0YwfGbaIhk8NeUJ841YSh42G7Tb4TsUWUaQEnXch/WiXMwC6ZQ/B
 unvcsCo9Dbzm6zVxXsNkvE4XNLSNB8IwbpWsGfr9f6C6s/RP2OPg05q7bMt+He/rOlU+DAZtKwp
 5DSBJ
X-Gm-Gg: AeBDievl8uxLF2F+/SLQsQEMFtMm3aTyJHqoKPIUtTG4YMkAHAZvNYZUJpNmDdA7XRN
 oIl/bO+xi+1tJghqSYWBPZxOQF/nh69TIJPyKNQSFYWNuqH+LjLxNpZICT12m+Ze1eyLdNk8ZyY
 DQNZbHzCcZeY9B64SMYJMs6iE5bUKGfp6YPEw9RPHcHSL9PUA2C5yWAMjtV3USDXvMnfvmtySsD
 KcGBLQSDRxULzvEciwv0RBs8B+kxW8VSAu3dz+pNuUUjGcA+H/Yx0PnKlV8tlFTekJnmuJazz9K
 Swfj1slkZzJ51tqi94JnPsh98ukPWktsUUtuono2+9XMfu6bHZEVZ3alhjfLXW2K1YWbPiOV9KR
 dWr/OIzVMyOpIKfac3V9BD4VrEiQAs//nTzzKo1ElEKEc3Wan8dXAPeLYy41yVjH2hqIKP4HGcm
 VreuZ+i9f4oyycjsYbtfSAQDW634gcM60u8QFcAOBwRSjMVZps125w5h3AxYwMu9HQ3FdLcEzUd
 iPCk7FVlTHbsefkw5rUxTi6xnmteLI=
X-Received: by 2002:a05:600c:3b0f:b0:48a:7965:b943 with SMTP id
 5b1f17b1804b1-48e51f4e9admr141468305e9.29.1778169165304; 
 Thu, 07 May 2026 08:52:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/67] hw/intc/arm_gicv5: Implement Deactivate command
Date: Thu,  7 May 2026 16:51:37 +0100
Message-ID: <20260507155154.1886557-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Implement the equivalent of the GICv5 stream protocol's Deactivate
command, which lets the cpuif tell the IRS to deactivate the
specified interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-51-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c                | 52 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_stream.h | 14 ++++++++
 3 files changed, 67 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 942f3eba2e..493d664625 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1153,6 +1153,58 @@ void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     irs_recalc_hppi(s, domain, iaffid);
 }
 
+void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                      GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t iaffid;
+
+    trace_gicv5_deactivate(domain_name[domain], inttype_name(type), virtual, id);
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
+                      "deactivate a virtual interrupt\n");
+        return;
+    }
+
+    switch (type) {
+    case GICV5_LPI:
+    {
+        const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+        L2_ISTE_Handle h;
+        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+
+        if (!l2_iste_p) {
+            return;
+        }
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ACTIVE, false);
+        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
+                          "deactivate unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->active = false;
+        iaffid = spi->iaffid;
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_deactivate: tried to "
+                      "deactivate bad interrupt type %d\n", type);
+        return;
+    }
+
+    irs_recalc_hppi(s, domain, iaffid);
+}
+
 static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 636c598970..c6696f0e0a 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -242,6 +242,7 @@ gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
 gicv5_activate(const char *domain, const char *type, bool virtual, uint32_t id) "GICv5 IRS Activate %s %s virtual:%d ID %u"
+gicv5_deactivate(const char *domain, const char *type, bool virtual, uint32_t id) "GICv5 IRS Deactivate %s %s virtual:%d ID %u"
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 7ac24f0f09..3cc9f61155 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -211,4 +211,18 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
                                uint32_t iaffid);
 
+/**
+ * gicv5_deactivate
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Deactivate the specified interrupt. There is no report back of
+ * success/failure to the CPUIF in the protocol.
+ */
+void gicv5_deactivate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                      GICv5IntType type, bool virtual);
+
 #endif
-- 
2.43.0


