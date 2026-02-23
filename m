Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5662EC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKU-0001rb-6J; Mon, 23 Feb 2026 12:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKP-0001Xv-HT
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKN-000091-K0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483a233819aso44117555e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866154; x=1772470954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uYeQtsFSRqumgTT/VZl4v9vn04UeGUZO9JJK+qvvYwg=;
 b=m2gKnqxYO5HZYEI4ji+/gu2pMQSaQyp1/lzHl+P0DWmNhCn5SHlqMNJpwDXxjkst1c
 +0WilnH/ubZmJjusSDSN7XayYVLczZPjTHu6488BGlAZQo+9TrU4fEGgV9yljjajwLjE
 3yAAZ+qBZyS1j3fKE1F0X43KxmcB1vLOCHLN/+R6jE1npY5Z76xvO3E24bNjel0n3LqL
 JGi/bXWTTnQftIPuQMNais64CVq2CYOZcjAcPowPXjEMmNb8nGD1LSwFxXYQZvmgeFhY
 xfPtFw2nTnR1aM/IOLPQZM0mEbGTzULNizHcr0Mttky0y/K93HqE2WjLOgsG4BQe6jr2
 7Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866154; x=1772470954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uYeQtsFSRqumgTT/VZl4v9vn04UeGUZO9JJK+qvvYwg=;
 b=mQPh4YMlo8boZnL8Z+AVqMlmjzfjSnFcX9giI7TzQlzBhasMob5e5VJPEpZt82t1uT
 2SAzWS6xRB9p8unnLLGZj5BaMH7gB4d1LAqBt061BskdD8zLPHvU0M/bDzkumluvsSC6
 DmfOwKu1aoLhWmcxLIOiZ0qZ0PH9rZ2X1EZxn5zO/khCU6UfEGU0TdlO3LacS2xWued7
 NaRlpxSJfMd7Y6XNcRU/5/ftrnoxPPOPWEWvs10cxZFhXOhsdV10kGZbKOgAOwFoXRmk
 2m/YWbxFoX+PAopS/FPh/c2gKruGX8XCnOMzQuOXzgoXc9D2xw9epEz1v0FZglaW8fgm
 VdKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh8cK5AISwsjKlyWaJ+hEdI6mzpCfRo9qV836rIQgMZr4C0WboFO4qwqiGl7I2vZlSFucTxUekHeUU@nongnu.org
X-Gm-Message-State: AOJu0Yy1wY3/qZgeiwwrbjjgXEM2UVwrwg4EDR9KRemOjjFZoMBFxtnq
 lUIsZOaMbGe2cfVt2cyQh90X+nAzuJr3KsF/SWpyBA1jG/FN8d9WxJf+3oh74MqnhD4/TOdnnR3
 KXg4v
X-Gm-Gg: AZuq6aLU7Yfs8m9dLZKuhyREUxyIaPLKHZFt8LdzaF7JZcX5LWB88xdYGDtoO6rnXgG
 wulG+vkf5rV1wUUyPLCIay/Q9vkMv+75l7kxPUNSsAN0qHbD5+PDuvuoK0X6iUd1CFyTlra0o9w
 NOv7OgxEk/tw2atz9vsIXFY70+P9TBOw45Hh+AccFhjskc7MssloNyqKN8yEiXumejmaJXuW/M6
 slOWMvyYRyOLcB0mywmYsQe7R64JhPGNAZfUy5lqgK2CxlRo8R4N7wWVaUr0XE0yZs/g3E4jWh7
 +F3QSoFXGtu4nRWhtwhLIvNbAL2KmH+GZ9khtX/GkpoqEqpEMdznT75NnCtsY3NsG7ZR7Cu4d4c
 +1yWOsUPH1DxxA/TBwpyree6a9ve7713TgDI5STTEPVIB0nuGWqzjVGdf2hXcrHZZ6s+HIM4f+G
 cPptN0eOINNM1eBhKt3joboPUJK2Z0zSFRHi5M9w79QbU3Ooqpa4bgGnsccVfjohvKxoRLB2Km/
 Db3dHnhmch1C6jpD4rBe1BOGZkTTFw=
X-Received: by 2002:a05:600c:8011:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-483a95eb3eemr140245815e9.6.1771866153957; 
 Mon, 23 Feb 2026 09:02:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 16/65] hw/intc/arm_gicv5: Cache LPI IST config in a struct
Date: Mon, 23 Feb 2026 17:01:23 +0000
Message-ID: <20260223170212.441276-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The IRS has multiple ISTs, for different contexts:
 * physical LPIs (separately for each interrupt domain)
 * virtual LPIs
 * virtual SPIs

The config information for physical LPIs is in the IRS_IST_BASER and
IRS_IST_CFGR registers; for virtual LPIs and virtual SPIs it will be
in the L2_VMTE VM table entry.  We would like to be able to write
generic code that can manipulate any of these ISTs.  Define a struct
which captures the config information for an IST, and cache the
IRS_IST_CFGR/IRS_IST_BASER data into this format when the guest sets
the VALID bit.

This also allows us to enforce the correct handling of reserved and
out-of-range values, and expand the encodings of sizes into a more
convenient format for later use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c         | 64 +++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events        |  2 ++
 include/hw/intc/arm_gicv5.h | 12 +++++++
 3 files changed, 78 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index f5933197ea..3f74069e01 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -278,9 +278,68 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         }
         cs->irs_ist_baser[domain] = FIELD_DP64(cs->irs_ist_baser[domain],
                                                IRS_IST_BASER, VALID, valid);
+        s->phys_lpi_config[domain].valid = false;
+        trace_gicv5_ist_invalid(domain_name[domain]);
         return;
     }
     cs->irs_ist_baser[domain] = value;
+
+    if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+        /*
+         * If the guest just set VALID then capture data into config struct,
+         * sanitize the reserved values, and expand fields out into byte counts.
+         */
+        GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+        uint8_t istbits, l2bits, l2_idx_bits;
+        uint8_t id_bits = FIELD_EX64(cs->irs_ist_cfgr[domain],
+                                     IRS_IST_CFGR, LPI_ID_BITS);
+        id_bits = MIN(MAX(id_bits, QEMU_GICV5_MIN_LPI_ID_BITS), QEMU_GICV5_ID_BITS);
+
+        switch (FIELD_EX64(cs->irs_ist_cfgr[domain], IRS_IST_CFGR, ISTSZ)) {
+        case 0:
+        case 3: /* reserved: acts like the minimum required size */
+            istbits = 2;
+            break;
+        case 1:
+            istbits = 3;
+            break;
+        case 2:
+            istbits = 4;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        switch (FIELD_EX64(cs->irs_ist_cfgr[domain], IRS_IST_CFGR, L2SZ)) {
+        case 0:
+        case 3: /* reserved; CONSTRAINED UNPREDICTABLE */
+            l2bits = 12; /* 4K: 12 bits */
+            break;
+        case 1:
+            l2bits = 14; /* 16K: 14 bits */
+            break;
+        case 2:
+            l2bits = 16; /* 64K: 16 bits */
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        /*
+         * Calculate how many bits of an ID index the L2 table
+         * (e.g. if we need 14 bits to index each byte in a 16K L2 table,
+         * but each entry is 4 bytes wide then we need 14 - 2 = 12 bits
+         * to index an entry in the table).
+         */
+        l2_idx_bits = l2bits - istbits;
+        cfg->base = cs->irs_ist_baser[domain] & R_IRS_IST_BASER_ADDR_MASK;
+        cfg->id_bits = id_bits;
+        cfg->istsz = 1 << istbits;
+        cfg->l2_idx_bits = l2_idx_bits;
+        cfg->structure = FIELD_EX64(cs->irs_ist_cfgr[domain],
+                                    IRS_IST_CFGR, STRUCTURE);
+        cfg->valid = true;
+        trace_gicv5_ist_valid(domain_name[domain], cfg->base, cfg->id_bits,
+                              cfg->l2_idx_bits, cfg->istsz, cfg->structure);
+    }
 }
 
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
@@ -568,6 +627,11 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
     if (c->parent_phases.hold) {
         c->parent_phases.hold(obj, type);
     }
+
+    /* IRS_IST_BASER and IRS_IST_CFGR reset to 0, clear cached info */
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        s->phys_lpi_config[i].valid = false;
+    }
 }
 
 static void gicv5_set_idregs(GICv5Common *cs)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 0797a23c1a..80fc47794b 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -233,6 +233,8 @@ gicv5_badread(const char *domain, uint64_t offset, unsigned size) "GICv5 IRS %s
 gicv5_write(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 gicv5_badwrite(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u: error"
 gicv5_spi(uint32_t id, int level) "GICv5 SPI ID %u asserted at level %d"
+gicv5_ist_valid(const char *domain, uint64_t base, uint8_t id_bits, uint8_t l2_idx_bits, uint8_t istsz, bool structure) "GICv5 IRS %s IST now valid: base 0x%" PRIx64 " id_bits %u l2_idx_bits %u IST entry size %u 2-level %d"
+gicv5_ist_invalid(const char *domain) "GICv5 IRS %s IST no longer valid"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index 42ccef8474..f6ecd9c323 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -17,11 +17,23 @@
 
 OBJECT_DECLARE_TYPE(GICv5, GICv5Class, ARM_GICV5)
 
+typedef struct GICv5ISTConfig {
+    hwaddr base; /* Base address */
+    uint8_t id_bits; /* number of bits in an ID for this table */
+    uint8_t l2_idx_bits; /* number of ID bits that index into L2 table */
+    uint8_t istsz; /* L2 ISTE size in bytes */
+    bool structure; /* true if using 2-level table */
+    bool valid; /* true if this table is valid and usable */
+} GICv5ISTConfig;
+
 /*
  * This class is for TCG-specific state for the GICv5.
  */
 struct GICv5 {
     GICv5Common parent_obj;
+
+    /* This is the info from IRS_IST_BASER and IRS_IST_CFGR */
+    GICv5ISTConfig phys_lpi_config[NUM_GICV5_DOMAINS];
 };
 
 struct GICv5Class {
-- 
2.43.0


