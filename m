Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534DDEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKT-0001pJ-GA; Mon, 23 Feb 2026 12:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKS-0001lH-Ev
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKP-00009R-Bg
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so43126615e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866155; x=1772470955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C2axc4EgJtazpkiTdEYOe//e5XiNyQzRdx8f1Gu4DKY=;
 b=t480HLajqsYcvpMf/HAJ2zL/LtOzFXaDyyL0qWokwnAzK30zTv8tZO96k5JQWIihl7
 42Y7mp6KyNnqw4PJNE2Bb9se/cDv1VHXb98OVtwf2CRSDl5qK2T6sX08ZL+fflU33g5S
 uZaYYJqFRM105+OxFeT4PdWoIS58Xs3pDb+BvE2FCZMLySxLuvlhdkd8E3NGq8a9sGHY
 CMv8us0fvq/5PKtvQkYuiFb1eV+C6si3K+OA80qv+QGlw4ErR/Emrv8ylQ/QHUjKMwR+
 gN0TyNivExZfE9BJ3zXaivVaNiPzpUHTUxgthN3JtJ6y8fDHhqAO2HVVtzzAGzw5fC8Q
 Kpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866155; x=1772470955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C2axc4EgJtazpkiTdEYOe//e5XiNyQzRdx8f1Gu4DKY=;
 b=qAFGXj+Sy6JAdA91e73UojnUyH0WAPm0IYPeKxC6NHAJV6FPrQqYY+wR4t3ZJGKdeN
 k9W6SIG/LFoHGvloJfSWFWf9qMrrtRJzDwqgg7Rofv0LM/oJQcvWRVKtKkApjdPC0kA0
 cVYD8mzpdbkiIE+FwtPGE3uukCwt7FPNdg19P5VCzTZ5lT7lPF4MJ/G2jOFPmh9AhRIo
 TK2NoMFHR1vK23kLFuKTobHXCP+k44w7Xb1MMRVPGPmm7kK0fMgLaeCi024m6s1xG3wB
 umq7BlPwlQLmH9nXcqKbDWq60/YXqyE903ehy8YofUzcSC8JzL1SKAtEKqV2vdwjDKC3
 nYwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4hl3MoCFelqBMMgM6cShtqZ2NGahbYpl9G4jVGySKkqT4uasQGrvzlaSHZqNUqMYRI53rb7dgPP8x@nongnu.org
X-Gm-Message-State: AOJu0YzQjJLGy18Bj4/EBtjA0Ng8ih3k297vj2Mn7NZHR0sv62qG/2w/
 CohegFfD7LPKXb9vd36hAnHxnHfeE9QbejNQHLFKtMSFNkpuEPqHrb4+DUNGnL6gWniTthkBSdf
 8+Ava
X-Gm-Gg: AZuq6aJkS1NzFT56PUJRx5uePRvWjlzcJhrMU/cARa8ct9w3avQ0te9MeYN/e+7J6mc
 q1Dla84bfN/QLePmm5dQXJ7MGb2Z2L6mVDKQ6Q/9CUnI1Jhl20AWcKaEyOm7zFDXrE3g5QArrXF
 pyBxuOEsgQHVLDymYL59LkF2qMTnVbopo0iA3g00I7BV0Se/U/V/e+xHBNSinuis1t8XHt0Ld0t
 ynEODf7uA+KSpNi7eAaOlTMt4Wo6wV43tFOnBver91mGnKrWAHwUG7Hr/tWzu9yKPC7ar6gXoeA
 1h3tssRYxf2uSftPPO7ikUpjZ372ydkJOp/HETQgEIoL6lLWoMHPvzODQ96ohKSvVt3gO2XU7/d
 Mq8PjVxR2cl8+i7iZGlaONfSjvcwbHD3pekctZ1UAQyGFTr7AEGxrSsy0jvrPEGZXLXgTEyQ9De
 Bvi+1DoyA3hV/oRpJLZUXcaRdxV7UQMi8BvrRq0FamwyKUKGbOZMFjC/5DQEUQmEXSJJv/9fZlZ
 hesIzVAbShtk4447CZRaN4PxvvyHTk=
X-Received: by 2002:a05:600c:6291:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483a95b5a7dmr154171825e9.1.1771866155260; 
 Mon, 23 Feb 2026 09:02:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/65] hw/intc/arm_gicv5: Implement gicv5_set_priority()
Date: Mon, 23 Feb 2026 17:01:24 +0000
Message-ID: <20260223170212.441276-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
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

Implement the gicv5_set_priority() function, which is our equivalent
of the Stream Protocol SetPriority command.  This acts by looking the
interrupt ID up in the Interrupt State Table and storing the new
priority value into the table entry.

The memory transaction has to have the right transaction attributes
for the domain it is for; we precalculate these and keep them in the
GICv5ISTConfig.

The GIC has an optional software-error reporting mechanism via the
IRS_SWERR_* registers; this does not report all failure cases, only
those that would be annoying to detect and debug in some other way.
We choose not to implement this, but include some comments for
reportable error cases for future reference.  Our LOG_GUEST_ERROR
logging is a superset of this.

At this point we implement only handling of SetPriority for LPIs; we
will add SPI handling in a later commit.  Virtual interrupts aren't
supported by this initial EL1-only GICv5 implementation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 228 +++++++++++++++++++++++++++++
 hw/intc/trace-events               |   1 +
 include/hw/intc/arm_gicv5.h        |   1 +
 include/hw/intc/arm_gicv5_stream.h |  29 ++++
 include/hw/intc/arm_gicv5_types.h  |  10 ++
 5 files changed, 269 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3f74069e01..8572823edc 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/registerfields.h"
 #include "hw/intc/arm_gicv5.h"
+#include "hw/intc/arm_gicv5_stream.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -23,6 +24,25 @@ static const char *domain_name[] = {
     [GICV5_ID_REALM] = "Realm",
 };
 
+static const char *inttype_name(GICv5IntType t)
+{
+    /*
+     * We have to be more cautious with getting human readable names
+     * for a GICv5IntType for trace strings than we do with the
+     * domain enum, because here the value can come from a guest
+     * register field.
+     */
+    static const char *names[] = {
+        [GICV5_PPI] = "PPI",
+        [GICV5_LPI] = "LPI",
+        [GICV5_SPI] = "SPI",
+    };
+    if (t >= ARRAY_SIZE(names) || !names[t]) {
+        return "RESERVED";
+    }
+    return names[t];
+}
+
 REG32(IRS_IDR0, 0x0)
     FIELD(IRS_IDR0, INT_DOM, 0, 2)
     FIELD(IRS_IDR0, PA_RANGE, 2, 5)
@@ -265,6 +285,213 @@ REG64(IRS_SWERR_SYNDROMER0, 0x3c8)
 REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
     FIELD(IRS_SWERR_SYNDROMER2, ADDR, 3, 53)
 
+FIELD(L1_ISTE, VALID, 0, 1)
+FIELD(L1_ISTE, L2_ADDR, 12, 44)
+
+FIELD(L2_ISTE, PENDING, 0, 1)
+FIELD(L2_ISTE, ACTIVE, 1, 1)
+FIELD(L2_ISTE, HM, 2, 1)
+FIELD(L2_ISTE, ENABLE, 3, 1)
+FIELD(L2_ISTE, IRM, 4, 1)
+FIELD(L2_ISTE, HWU, 9, 2)
+FIELD(L2_ISTE, PRIORITY, 11, 5)
+FIELD(L2_ISTE, IAFFID, 16, 16)
+
+static MemTxAttrs irs_txattrs(GICv5Common *cs, GICv5Domain domain)
+{
+    /*
+     * Return a MemTxAttrs to use for IRS memory accesses.
+     * IRS_CR1 has the usual Arm cacheability/shareability attributes,
+     * but QEMU doesn't care about those. All we need to specify here
+     * is the correct security attributes, which depend on the
+     * interrupt domain. Conveniently, our GICv5Domain encoding matches
+     * the ARMSecuritySpace one (because both follow an architecturally
+     * specified field). The exception is that the EL3 domain must
+     * be Secure instead of Root if we don't implement Realm.
+     */
+    if (domain == GICV5_ID_EL3 &&
+        !gicv5_domain_implemented(cs, GICV5_ID_REALM)) {
+        domain = GICV5_ID_S;
+    }
+    return (MemTxAttrs) {
+        .space = domain,
+        .secure = domain == GICV5_ID_S || domain == GICV5_ID_EL3,
+    };
+}
+
+static hwaddr l1_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                           uint32_t id)
+{
+    /*
+     * In a 2-level IST configuration, return the address of the L1
+     * IST entry for this interrupt ID.  The bottom l2_idx_bits of the
+     * ID value are the index into the L2 table, and the higher bits
+     * of the ID index the L1 table.
+     */
+    uint32_t l1_index = id >> cfg->l2_idx_bits;
+    return cfg->base + (l1_index * 8);
+}
+
+static bool get_l2_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                             uint32_t id, hwaddr *l2_iste_addr)
+{
+    /*
+     * Get the address of the L2 interrupt state table entry for
+     * this interrupt. On success, fill in l2_iste_addr and return true.
+     * On failure, return false.
+     */
+    hwaddr l2_base;
+
+    if (!cfg->valid) {
+        return false;
+    }
+
+    if (id >= (1 << cfg->id_bits)) {
+        return false;
+    }
+
+    if (cfg->structure) {
+        /*
+         * 2-level table: read the L1 IST. The bottom l2_idx_bits
+         * of the ID value are the index into the L2 table, and
+         * the higher bits of the ID index the L1 table. There is
+         * always at least one L1 table entry.
+         */
+        hwaddr l1_addr = l1_iste_addr(cs, cfg, id);
+        uint64_t l1_iste;
+        MemTxResult res;
+
+        l1_iste = address_space_ldq_le(&cs->dma_as, l1_addr,
+                                       cfg->txattrs, &res);
+        if (res != MEMTX_OK) {
+            /* Reportable with EC=0x01 if sw error reporting implemented */
+            qemu_log_mask(LOG_GUEST_ERROR, "L1 ISTE lookup failed for ID 0x%x"
+                          " at physical address 0x" HWADDR_FMT_plx "\n",
+                          id, l1_addr);
+            return false;
+        }
+        if (!FIELD_EX64(l1_iste, L1_ISTE, VALID)) {
+            return false;
+        }
+        l2_base = l1_iste & R_L1_ISTE_L2_ADDR_MASK;
+        id = extract32(id, 0, cfg->l2_idx_bits);
+    } else {
+        /* 1-level table */
+        l2_base = cfg->base;
+    }
+
+    *l2_iste_addr = l2_base + (id * cfg->istsz);
+    return true;
+}
+
+static bool read_l2_iste_mem(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                             hwaddr addr, uint32_t *l2_iste)
+{
+    MemTxResult res;
+    *l2_iste = address_space_ldl_le(&cs->dma_as, addr, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        /* Reportable with EC=0x02 if sw error reporting implemented */
+        qemu_log_mask(LOG_GUEST_ERROR, "L2 ISTE read failed at physical "
+                      "address 0x" HWADDR_FMT_plx "\n", addr);
+    }
+    return res == MEMTX_OK;
+}
+
+static bool write_l2_iste_mem(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                              hwaddr addr, uint32_t l2_iste)
+{
+    MemTxResult res;
+    address_space_stl_le(&cs->dma_as, addr, l2_iste, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        /* Reportable with EC=0x02 if sw error reporting implemented */
+        qemu_log_mask(LOG_GUEST_ERROR, "L2 ISTE write failed at physical "
+                      "address 0x" HWADDR_FMT_plx "\n", addr);
+    }
+    return res == MEMTX_OK;
+}
+
+/*
+ * This is returned by get_l2_iste() and has everything we
+ * need to do the writeback of the L2 ISTE word in put_l2_iste().
+ * Currently the get/put functions always directly do guest memory
+ * reads and writes to update the L2 ISTE. In a future commit we
+ * will add support for a cache of some of the ISTE data in a
+ * local hashtable; the APIs are designed with that in mind.
+ */
+typedef struct L2_ISTE_Handle {
+    hwaddr l2_iste_addr;
+    uint32_t l2_iste;
+} L2_ISTE_Handle;
+
+static uint32_t *get_l2_iste(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                             uint32_t id, L2_ISTE_Handle *h)
+{
+    /*
+     * Find the L2 ISTE for the interrupt @id.
+     *
+     * We return a pointer to the ISTE: the caller can freely
+     * read and modify the uint64_t pointed to to update the ISTE.
+     * If the caller modifies the L2 ISTE word, it must call
+     * put_l2_iste(), passing it @h, to write back the ISTE.
+     * If the caller is only reading the L2 ISTE, it does not need
+     * to call put_l2_iste().
+     *
+     * We fill in @h with information needed for put_l2_iste().
+     *
+     * If the ISTE could not be read (typically because of a
+     * memory error), return NULL.
+     */
+    if (!get_l2_iste_addr(cs, cfg, id, &h->l2_iste_addr) ||
+        !read_l2_iste_mem(cs, cfg, h->l2_iste_addr, &h->l2_iste)) {
+        return NULL;
+    }
+    return &h->l2_iste;
+}
+
+static void put_l2_iste(GICv5Common *cs, const GICv5ISTConfig *cfg,
+                        L2_ISTE_Handle *h)
+{
+    /*
+     * Write back the modified L2_ISTE word found with get_l2_iste().
+     * Once this has been called the L2_ISTE_Handle @h and the
+     * pointer to the L2 ISTE word are no longer valid.
+     */
+    write_l2_iste_mem(cs, cfg, h->l2_iste_addr, h->l2_iste);
+}
+
+void gicv5_set_priority(GICv5Common *cs, uint32_t id,
+                        uint8_t priority, GICv5Domain domain,
+                        GICv5IntType type, bool virtual)
+{
+    const GICv5ISTConfig *cfg;
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t *l2_iste_p;
+    L2_ISTE_Handle h;
+
+    trace_gicv5_set_priority(domain_name[domain], inttype_name(type), virtual,
+                             id, priority);
+    /* We must ignore unimplemented low-order priority bits */
+    priority &= MAKE_64BIT_MASK(5 - QEMU_GICV5_PRI_BITS, QEMU_GICV5_PRI_BITS);
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
+                      "priority of a virtual interrupt\n");
+        return;
+    }
+    if (type != GICV5_LPI) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
+                      "priority of bad interrupt type %d\n", type);
+        return;
+    }
+    cfg = &s->phys_lpi_config[domain];
+    l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+    if (!l2_iste_p) {
+        return;
+    }
+    *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PRIORITY, priority);
+    put_l2_iste(cs, cfg, &h);
+}
+
 static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -331,6 +558,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
          */
         l2_idx_bits = l2bits - istbits;
         cfg->base = cs->irs_ist_baser[domain] & R_IRS_IST_BASER_ADDR_MASK;
+        cfg->txattrs = irs_txattrs(cs, domain),
         cfg->id_bits = id_bits;
         cfg->istsz = 1 << istbits;
         cfg->l2_idx_bits = l2_idx_bits;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 80fc47794b..42f5e73d54 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -235,6 +235,7 @@ gicv5_badwrite(const char *domain, uint64_t offset, uint64_t data, unsigned size
 gicv5_spi(uint32_t id, int level) "GICv5 SPI ID %u asserted at level %d"
 gicv5_ist_valid(const char *domain, uint64_t base, uint8_t id_bits, uint8_t l2_idx_bits, uint8_t istsz, bool structure) "GICv5 IRS %s IST now valid: base 0x%" PRIx64 " id_bits %u l2_idx_bits %u IST entry size %u 2-level %d"
 gicv5_ist_invalid(const char *domain) "GICv5 IRS %s IST no longer valid"
+gicv5_set_priority(const char *domain, const char *type, bool virtual, uint32_t id, uint8_t priority) "GICv5 IRS SetPriority %s %s virtual:%d ID %u prio %u"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index f6ecd9c323..c631ecc3e8 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -19,6 +19,7 @@ OBJECT_DECLARE_TYPE(GICv5, GICv5Class, ARM_GICV5)
 
 typedef struct GICv5ISTConfig {
     hwaddr base; /* Base address */
+    MemTxAttrs txattrs; /* TX attrs to use for this table */
     uint8_t id_bits; /* number of bits in an ID for this table */
     uint8_t l2_idx_bits; /* number of ID bits that index into L2 table */
     uint8_t istsz; /* L2 ISTE size in bytes */
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index 9b9c2e4b60..3239a86f1a 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -12,6 +12,7 @@
 #define HW_INTC_ARM_GICV5_STREAM_H
 
 #include "target/arm/cpu-qom.h"
+#include "hw/intc/arm_gicv5_types.h"
 
 typedef struct GICv5Common GICv5Common;
 
@@ -29,4 +30,32 @@ typedef struct GICv5Common GICv5Common;
  */
 bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs);
 
+/*
+ * The architected Stream Protocol is asynchronous; commands can be
+ * initiated both from the IRS and from the CPU interface, and some
+ * require acknowledgement. For QEMU, we simplify this because we know
+ * that in the CPU interface code we hold the BQL and so our IRS model
+ * is not going to be busy; when we send commands from the CPUIF
+ * ("upstream commands") we can model this as a synchronous function
+ * call whose return corresponds to the acknowledgement of a completed
+ * command.
+ */
+
+/**
+ * gicv5_set_priority
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @priority: priority to set
+ * @domain: interrupt Domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Set priority of an interrupt; matches stream interface
+ * SetPriority command from CPUIF to IRS. There is no report back
+ * of success/failure to the CPUIF in the protocol.
+ */
+void gicv5_set_priority(GICv5Common *cs, uint32_t id,
+                        uint8_t priority, GICv5Domain domain,
+                        GICv5IntType type, bool virtual);
+
 #endif
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 9c7788b1e6..b4452a7b7d 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -45,4 +45,14 @@ typedef enum GICv5Domain {
 #define GICV5_PPI_CNTP 30
 #define GICV5_PPI_TRBIRQ 31
 
+/*
+ * Type of the interrupt; these values match the 3-bit format
+ * specified in the GICv5 spec R_GYVWB.
+ */
+typedef enum GICv5IntType {
+    GICV5_PPI = 1,
+    GICV5_LPI = 2,
+    GICV5_SPI = 3,
+} GICv5IntType;
+
 #endif
-- 
2.43.0


