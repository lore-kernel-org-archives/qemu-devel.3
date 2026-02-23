Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4F1EC1114
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKb-0002HR-Uo; Mon, 23 Feb 2026 12:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKV-0001wL-Vc
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKS-0000AO-3w
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso50770095e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866159; x=1772470959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jYvTvJG/7tvhpdlK87g5RK3IBoj9LMlQcWK3SacPSog=;
 b=s8feSO4dY64TAIcE/+s6igbqIlnkRV7QiAP4qg4zdv0zqgAZyPMw3XTZV7pzeLOidv
 2Yg/oVnVE5HovGwSi7M3DSFl/IIcJiQqBxcVJHVXI70b67Yj9X4geSxHGkcZyEf7fs5G
 rEKb8S5abD5pdYfkGZfqjvYUtG1FDevP5/VZ+tfcCyyOBpRVnZYkdsPh720yqbhH5z/z
 v36WoVD2mWBEXYM6bhNNMBxdcBzpJMNYPwB3vFk6cFB8eQyrnoc1x6vDyM6AiFtb9UTm
 ONKWQQIZshDUjemeXkw7ZJqvFpYHohvgd+pVVrFAMWLL+FrEnE3QkvMZ9hFHrTL2orSw
 uo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866159; x=1772470959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jYvTvJG/7tvhpdlK87g5RK3IBoj9LMlQcWK3SacPSog=;
 b=helvmbOeKaO13SIwjJL74lTD0ZpSfLmavCvpH5sUXIu95kafsBelHomStYE3AXTEbD
 y2p+Vm4T2NgiS2OsGKiGEHb2KJ6rwA4gwWRm8RbE/uL9pMlcYeTBcfh8XxBI1lgyX+1h
 9Cmtrs+DvgvaqHUaBZPgSeL3ONFJZUnWk6N3fnZnxRsoRANpwbwkgzI34IDa/lTelwpZ
 C2o8Du39ZjLFnEQ43BhCBimmDnJ8mrNlWWTYOmPND+pmRqezu+KX1nK/3AP45PRaTUJC
 QQSqJrftKgQvuySUje5W5W34oQp79BWeHIPZDQkj27vdKnx2J4diRTvbzbWp/7WHUi4o
 8HWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1cy8Z/tUY9hpHagIjDm9GT2LqMn8y1QsfmmHyArpDduJ/2ygyj0R+3ZcgJVmPlFvLSNuY0U9H0Htv@nongnu.org
X-Gm-Message-State: AOJu0YzlChFIAHRDC2R0TH1vQxVeNnJOtAPxVViIqIEBM+DchaoqX7+D
 OXOAAEGjOQ7BPYa1Nvt3nxBBSLc/MrMNMYXf3bUClaNYXsIB4Icp16kGFx5kvzSidFNbtbwUkpu
 ZGnHB
X-Gm-Gg: AZuq6aJB5jQ7uTG3Xt0/GNpXnBImy0GdUVFCB2LuNjprgO6Doh9Ex1xHmyqJ71qT/2t
 EAjO+/gFobXX+SZ9GOmTZn8HRX3y9gsruVlw8BmvpWmQk6Oit/1Xp6Moy6s/v9NHGHqB28pxAfj
 IrFmL/gM5wAZHUhEfrkCFlk9dAha7EKH9PKNBIEzOcZuFO61R5V30IJyv60YM5bkFIVqEn4FAlz
 Nq2sNatJFouHjahfAO0jGvAVMs79Pb4pAwT24TIOIH0riKfArt+nofHW0/6zKFakzJZOkoPHbNj
 WS8q/+UCu7pRZwbDJ7XJEvGUNEbev7GiiFTg8Ed76raCncHsTDtGHBsg9aMa8e0Q4PYHTSSdyXb
 eLXhfslmRvAYahvUTnT3A9qdsa0ZTwSaUx+1GU4/Psimwheqs4J5GPiA3wd+YeJhfCUfjEgfIk1
 h9mOTawhDQ14nI+pbe89Cu/9DBeBg+gWrsljmDTRhPnMVbE/OLYzNNc7zWBMrXXfrCKbhN9Xd1K
 S03bKDaZIyyZA2wZJT/KfGYPIZfDoA=
X-Received: by 2002:a05:600c:1d1c:b0:480:4a90:1afd with SMTP id
 5b1f17b1804b1-483a94a99e4mr143926575e9.0.1771866158504; 
 Mon, 23 Feb 2026 09:02:38 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 20/65] hw/intc/arm_gicv5: Implement remaining set-config
 functions
Date: Mon, 23 Feb 2026 17:01:27 +0000
Message-ID: <20260223170212.441276-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Implement the GICv5 functions corresponding to the stream protocol
SetEnabled, SetPending, SetHandling, and SetTarget commands.  These
work exactly like SetPriority: the IRS looks up the L2TE and updates
the corresponding field in it with the new value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 133 +++++++++++++++++++++++++++++
 hw/intc/trace-events               |   4 +
 include/hw/intc/arm_gicv5_stream.h |  68 +++++++++++++++
 include/hw/intc/arm_gicv5_types.h  |  15 ++++
 4 files changed, 220 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index af27fb7e63..3c6ef17573 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -492,6 +492,139 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
     put_l2_iste(cs, cfg, &h);
 }
 
+void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
+                        bool enabled, GICv5Domain domain,
+                        GICv5IntType type, bool virtual)
+{
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
+
+    trace_gicv5_set_enabled(domain_name[domain], inttype_name(type), virtual,
+                            id, enabled);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                      "enable state of a virtual interrupt\n");
+        return;
+    }
+    if (type != GICV5_LPI) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                      "enable state of bad interrupt type %d\n", type);
+        return;
+    }
+    cfg = &s->phys_lpi_config[domain];
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return;
+    }
+    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ENABLE, enabled);
+    put_l2_iste(cs, cfg, &h);
+}
+
+void gicv5_set_pending(GICv5Common *cs, uint32_t id,
+                       bool pending, GICv5Domain domain,
+                       GICv5IntType type, bool virtual)
+{
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
+
+    trace_gicv5_set_pending(domain_name[domain], inttype_name(type), virtual,
+                            id, pending);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                      "pending state of a virtual interrupt\n");
+        return;
+    }
+    if (type != GICV5_LPI) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                      "pending state of bad interrupt type %d\n", type);
+        return;
+    }
+    cfg = &s->phys_lpi_config[domain];
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return;
+    }
+    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, pending);
+    put_l2_iste(cs, cfg, &h);
+}
+
+void gicv5_set_handling(GICv5Common *cs, uint32_t id,
+                        GICv5HandlingMode handling, GICv5Domain domain,
+                        GICv5IntType type, bool virtual)
+{
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
+
+    trace_gicv5_set_handling(domain_name[domain], inttype_name(type), virtual,
+                            id, handling);
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                      "handling mode of a virtual interrupt\n");
+        return;
+    }
+    if (type != GICV5_LPI) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                      "handling mode of bad interrupt type %d\n", type);
+        return;
+    }
+    cfg = &s->phys_lpi_config[domain];
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return;
+    }
+    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, HM, handling);
+    put_l2_iste(cs, cfg, &h);
+}
+
+void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
+                      GICv5RoutingMode irm, GICv5Domain domain,
+                      GICv5IntType type, bool virtual)
+{
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
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
+         * In the cpuif insn "GIC CDAFF", IRM is RES0 for a GIC which does not
+         * support 1-of-N routing. So warn, and fall through to treat
+         * IRM=1 the same as IRM=0.
+         */
+    }
+    if (type != GICV5_LPI) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                      "target of bad interrupt type %d\n", type);
+        return;
+    }
+    cfg = &s->phys_lpi_config[domain];
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return;
+    }
+    /*
+     * For QEMU we do not implement 1-of-N routing, and so L2_ISTE.IRM is RES0.
+     * We never read it, and we can skip explicitly writing it to zero here.
+     */
+    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, IAFFID, iaffid);
+    put_l2_iste(cs, cfg, &h);
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
index 3239a86f1a..db0e3e01c6 100644
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
+ * SetEnabled command from CPUIF to IRS. There is no report back
+ * of success/failure to the CPUIF in the protocol.
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
+ * SetPending command from CPUIF to IRS. There is no report back
+ * of success/failure to the CPUIF in the protocol.
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
+ * Set handling mode of an interrupt (edge/level); matches stream interface
+ * SetHandling command from CPUIF to IRS. There is no report back
+ * of success/failure to the CPUIF in the protocol.
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
+ * Set handling mode of an interrupt (edge/level); matches stream interface
+ * SetHandling command from CPUIF to IRS. There is no report back
+ * of success/failure to the CPUIF in the protocol.
+ */
+void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
+                      GICv5RoutingMode irm, GICv5Domain domain,
+                      GICv5IntType type, bool virtual);
 #endif
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index b4452a7b7d..15d4d5c3f4 100644
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


