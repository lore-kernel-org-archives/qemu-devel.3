Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB9E10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C0-0006jq-UD; Fri, 27 Mar 2026 07:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bu-0006ZR-Ar
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Br-0007wO-U9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso17685745e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610242; x=1775215042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfAcFOEb2yOHFn+/VWKLIA0rIGdDdOhNemvo/o7rjjg=;
 b=gwBiU4nW3LajCJSSixzPZ1UUhbPbt8X0J227js9ZhVWCDTjw5DIBwVgDweiDe4S8gd
 CS1aBTJ0ehAaDGvoy/4Mvu7HMMFhShmDCQvp7qGXe+9iQYb7+CzTfD8ilbdik1K3f/aQ
 MrbFcf3QZ1qKT9EKP6ApgeUJFELjsoowI/nnLDabHzexJ9BrXBcw5A065DGnefbakOPt
 CrZfsi56cEOxd7L2Xdx5aqvb3rQoDbYqMT3CHgIeYSkG9U0n501cAXsqAk2MyC0BPFgZ
 C+F6bijahSPXZtXMRuMrAtiWAtX5XBXPUd2e8/tUbM3wNbMYK5sbaCW1SNWkZaVaQglI
 f2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610242; x=1775215042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MfAcFOEb2yOHFn+/VWKLIA0rIGdDdOhNemvo/o7rjjg=;
 b=NdMfcgdQTJXWI8T3k0TuesI2oLsSBTRioW8slwCm7TxLVhh4Q5+rgENpFTimFdMXjn
 YXevsF0TEEyVtyVS7YwjkCnCb6PdEUGYqM7c1vJbgNTUPn4B94GwaQX/GkDqTfbgsbxH
 kCz1fricda0io5Z9h3NHH9IXNy5Vzx106l8E9+dKnsJdVkCuOk/FFmNUpuEdRYwem9Fo
 hpFsWT2t+Ty3LhWMFu6Y5V+GxtvmkL/K15ZlX141ifrpZLATIIo/qbmh2soiKTQbdHhI
 3iU0q2WxPxyCgfioXft+xcI5HREDfP5yUQpMvFgGkLwOHtrrxWW22IrOPOEA9J/z7MdB
 vwKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSU+S63NvObFQBuIcLLSI09b7+08N2426+rR5AoTLNvcT7x3J64MzfPAJJTPwOQw+hbEC0WghFDcz2@nongnu.org
X-Gm-Message-State: AOJu0YzCydHW2TZgPzpZQwWU+CdSY29S7gdJIDGDbCLmsdAtfnqjaWnC
 gz3G8Dvmm2DRhUj6s1gtphlyCUHrAMrND3jJ+QfFldaFUxZcjILKbIgnujLqF5KttTQ=
X-Gm-Gg: ATEYQzw9vmbg5Q5ZBASa+pwwDZcETj1rAfEi9egHU+eiust7vNwFp/JsYRiAAv8l4Ph
 WYiDyYArwBT3DsE2LuxokJVW+cHEz1dV65IKl/gjOuYzaaqEVgnEeWm6xD31YzbPEBK1RlgnBoP
 FlKf4SdlsMulUr+gncLoGtcXYGfx/ikvfYOS8aWaSnN/eRrB15QgXk7xSxENm63h6z5OAD+suiX
 g8yP0jBwmG5p3DHmeWYLP9Uf64HWVrcAQEi6KdZmgbIJ09QMXrSrmNlrxnW/XT9wDmIa/71ugN0
 zjZyUSqM3PBgoV0gUlRxR6h2EPiNh8b6/J4UQt2lRqqY/xkXLWSHOgZ7Ll/mr/yFcs6kIA+0UnB
 6P7AVqKk2UHwS+hC5DZFc94z+cVLsuiedAW2HWLQpn4E0sH1xuZMVbblNS9aRfTxAmj/ZKsuj/w
 XcIjRXAtkPCmG/tTgL/aWrtPLdjtVj77CJfg8dpxzT2UV917WqXD3Zl9adnVFtRYZK5ea8nrfit
 TCMVNepiSa64FLWMuIEVZt42ZnKT18=
X-Received: by 2002:a05:600c:a44:b0:486:fbf6:abd4 with SMTP id
 5b1f17b1804b1-48727efc11dmr29574035e9.9.1774610241653; 
 Fri, 27 Mar 2026 04:17:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 21/65] hw/intc/arm_gicv5: Implement remaining set-config
 functions
Date: Fri, 27 Mar 2026 11:16:16 +0000
Message-ID: <20260327111700.795099-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Implement the GICv5 functions corresponding to the stream protocol
SetEnabled, SetPending, SetHandling, and SetTarget commands.  These
work exactly like SetPriority: the IRS looks up the L2TE and updates
the corresponding field in it with the new value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c                | 152 +++++++++++++++++++++++++++++
 hw/intc/trace-events               |   4 +
 include/hw/intc/arm_gicv5_stream.h |  68 +++++++++++++
 include/hw/intc/arm_gicv5_types.h  |  15 +++
 4 files changed, 239 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7d654a91e6..d1eb96fce0 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -497,6 +497,158 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
     }
 }
 
+void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
+                       GICv5Domain domain, GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+
+    trace_gicv5_set_enabled(domain_name[domain], inttype_name(type), virtual,
+                            id, enabled);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                      "enable state of a virtual interrupt\n");
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
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ENABLE, enabled);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                      "enable state of bad interrupt type %d\n", type);
+        return;
+    }
+}
+
+void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
+                       GICv5Domain domain, GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+
+    trace_gicv5_set_pending(domain_name[domain], inttype_name(type), virtual,
+                            id, pending);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                      "pending state of a virtual interrupt\n");
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
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, pending);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                      "pending state of bad interrupt type %d\n", type);
+        return;
+    }
+}
+
+void gicv5_set_handling(GICv5Common *cs, uint32_t id,
+                        GICv5HandlingMode handling, GICv5Domain domain,
+                        GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+
+    trace_gicv5_set_handling(domain_name[domain], inttype_name(type), virtual,
+                            id, handling);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                      "handling mode of a virtual interrupt\n");
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
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, HM, handling);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                      "handling mode of bad interrupt type %d\n", type);
+        return;
+    }
+}
+
+void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
+                      GICv5RoutingMode irm, GICv5Domain domain,
+                      GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+
+    trace_gicv5_set_target(domain_name[domain], inttype_name(type), virtual,
+                           id, iaffid, irm);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                      "target of a virtual interrupt\n");
+        return;
+    }
+    if (irm != GICV5_TARGETED) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                      "1-of-N routing\n");
+        /*
+         * In the cpuif insn "GIC CDAFF", IRM is RES0 for a GIC which
+         * does not support 1-of-N routing. So warn, and fall through
+         * to treat IRM=1 the same as IRM=0.
+         */
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
+        /*
+         * For QEMU we do not implement 1-of-N routing, and so
+         * L2_ISTE.IRM is RES0.  We never read it, and we can skip
+         * explicitly writing it to zero here.
+         */
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, IAFFID, iaffid);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                      "target of bad interrupt type %d\n", type);
+        return;
+    }
+}
+
 static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 42f5e73d54..37ca6e8e12 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -236,6 +236,10 @@ gicv5_spi(uint32_t id, int level) "GICv5 SPI ID %u asserted at level %d"
 gicv5_ist_valid(const char *domain, uint64_t base, uint8_t id_bits, uint8_t l2_idx_bits, uint8_t istsz, bool structure) "GICv5 IRS %s IST now valid: base 0x%" PRIx64 " id_bits %u l2_idx_bits %u IST entry size %u 2-level %d"
 gicv5_ist_invalid(const char *domain) "GICv5 IRS %s IST no longer valid"
 gicv5_set_priority(const char *domain, const char *type, bool virtual, uint32_t id, uint8_t priority) "GICv5 IRS SetPriority %s %s virtual:%d ID %u prio %u"
+gicv5_set_enabled(const char *domain, const char *type, bool virtual, uint32_t id, bool enabled) "GICv5 IRS SetEnabled %s %s virtual:%d ID %u enabled %d"
+gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t id, bool pending) "GICv5 IRS SetPending %s %s virtual:%d ID %u pending %d"
+gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
+gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index e1649cbb40..af2e1851c2 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -58,4 +58,72 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
                         uint8_t priority, GICv5Domain domain,
                         GICv5IntType type, bool virtual);
 
+/**
+ * gicv5_set_enabled
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @enabled: new enabled state
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Set enabled state of an interrupt; matches stream interface
+ * SetEnabled command from CPUIF to IRS. There is no report back of
+ * success/failure to the CPUIF in the protocol.
+ */
+void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
+                       bool enabled, GICv5Domain domain,
+                       GICv5IntType type, bool virtual);
+
+/**
+ * gicv5_set_pending
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @pending: new pending state
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Set pending state of an interrupt; matches stream interface
+ * SetPending command from CPUIF to IRS. There is no report back of
+ * success/failure to the CPUIF in the protocol.
+ */
+void gicv5_set_pending(GICv5Common *cs, uint32_t id,
+                       bool pending, GICv5Domain domain,
+                       GICv5IntType type, bool virtual);
+
+/**
+ * gicv5_set_handling
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @handling: new handling mode
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Set handling mode of an interrupt (edge/level); matches stream
+ * interface SetHandling command from CPUIF to IRS. There is no report
+ * back of success/failure to the CPUIF in the protocol.
+ */
+void gicv5_set_handling(GICv5Common *cs, uint32_t id,
+                        GICv5HandlingMode handling, GICv5Domain domain,
+                        GICv5IntType type, bool virtual);
+
+/**
+ * gicv5_set_target
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @iaffid: new target PE's interrupt affinity
+ * @irm: interrupt routing mode (targeted vs 1-of-N)
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Set handling mode of an interrupt (edge/level); matches stream
+ * interface SetHandling command from CPUIF to IRS. There is no report
+ * back of success/failure to the CPUIF in the protocol.
+ */
+void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
+                      GICv5RoutingMode irm, GICv5Domain domain,
+                      GICv5IntType type, bool virtual);
 #endif
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index e2b937fe62..20de5b3f46 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -55,4 +55,19 @@ typedef enum GICv5IntType {
     GICV5_SPI = 3,
 } GICv5IntType;
 
+/* Interrupt handling mode (same encoding as L2_ISTE.HM) */
+typedef enum GICv5HandlingMode {
+    GICV5_EDGE = 0,
+    GICV5_LEVEL = 1,
+} GICv5HandlingMode;
+
+/*
+ * Interrupt routing mode (same encoding as L2_ISTE.IRM).
+ * Note that 1-of-N support is option and QEMU does not implement it.
+ */
+typedef enum GICv5RoutingMode {
+    GICV5_TARGETED = 0,
+    GICV5_1OFN = 1,
+} GICv5RoutingMode;
+
 #endif
-- 
2.43.0


