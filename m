Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C01CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11O-0003Yt-Jx; Thu, 07 May 2026 11:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11M-0003Vj-Qr
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11K-0003qi-UJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso8103235e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169133; x=1778773933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UphOHpAU41SGo+BRs+5Ac7zYOlOWgurjrB9SfekNuz4=;
 b=bjSGuJ1sJYipsL1asOYJn8sR8muOTv8mil4WzVmz8OLOZSTkh0Febg4lRfedOMKQFI
 0hFAz1mXzsedbv7w81saP2VIgX+TiV+fWzzp1mXoPzTQrlpW/0Zlo9I31hAwTPobhSqA
 +IN2u2fQUcsx0jCJDREY2hRWiCHgputAL7NZGd1D7Cu9mJpQi9Bqq/eoh5bKmoqoZaj0
 G9A7btaiZVn+v5tSGLtNFbySABcGCqtZKeBGPacHKWhWiC5IdWu17MQgWFQSztwd+V+8
 asKy4P/XILSLCR4qeLcuCA7PPsnespIoFgNaVBXDFX0mkCBuA0P4qIaxTTQjSIgpSut7
 Ijeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169133; x=1778773933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UphOHpAU41SGo+BRs+5Ac7zYOlOWgurjrB9SfekNuz4=;
 b=cm+MdlBIlHzztq1DeWKrgryVcy4ug5fV4qZKdPhMsmUyyxyNt9z1kpnBqR87RGFuds
 sEXSbi87wSVMLFFxe1S9NrgvHio4J1NabFjsnQuZ88k+wHA2Nlk6oKp2xX6uJDPPB3R9
 p8ojzmHkQXh2RXx2qP1LqWnW2JjUNiuXzHofjlBE/b4sRvlytaI3Ra7ltodEOx+RxKHk
 re+BDkLDaBBIpKNPoZJDqoLwse8plVMzF0Upy1Oi3nbNbLNPG87yruu/2oCa7yTmclXk
 THGHsih+1gUcbxOUVgu5vqTf0Uy+TifbvKng1Tzo8eYaw7/d1PWDTFXm1zm6VCQ63RIA
 kpBQ==
X-Gm-Message-State: AOJu0YwelrwlbAvKz9kr42Xi0b+Cr1pXDwBO34X9v31+C/wLLjnw59Jn
 6CCFlM7a48s2eEx/StTL3xSQY6yw/r+kAddGfqiGq/S58iLU6qHRT+6+DyYMeWNxG2E0dkbu7DU
 Muq1E
X-Gm-Gg: AeBDiesUTsieSXSAlkM5FB19PEV7Iqi48Kumuwn8NuiAfOwisztnKX40ZVaFVOcScVq
 YdVgQQQ5TqaFTLfHFAwUM2+Iru/04gSAbHKjYnTVtf/Iitkm8yg4F7kFMJ91f5670fMsOQ3UWpo
 A/FOp1SHEQvH8z2NHt3AGK5xY9nkGb+EWBDrZ2y4n2qXJ63HISlSzwN1EqYXt3fn5Axy1nNDAfM
 HIBfpD9nLXUyMu9LxAxqKB3uhNeBLoWomn4AH4uAEbiNP3oVfgLRcJo4cnYH/yslfmt4f/WVhNA
 FkFbSmC9PREtSnKtC0SVSoYnu2ULh6WZz5J5elKiTQR/UI2SKuamRMlEnjbmcGNjjE7GsMty99O
 pCUtOx/N8dg4pmMLhbrl01LFJ5hZfRpDn8ZyJSj3nZ8N7VVuz0FYS6Zx519T+7j0aRt1v42pAEe
 bOlBmEMEk0qoY4BLBl3PeRewOSAk9brikZAUYoGDUWi7FxMUgu8vH+6TjRgPM2w92HhMKoYNcDq
 VYBW3hA0bD+mREFEB61YrYrier8TwQOKUuOBfWhww==
X-Received: by 2002:a05:600c:1d11:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-48e51f2c7eemr137191935e9.10.1778169133304; 
 Thu, 07 May 2026 08:52:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/67] hw/intc/arm_gicv5: Cache LPI IST config in a struct
Date: Thu,  7 May 2026 16:51:04 +0100
Message-ID: <20260507155154.1886557-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-18-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c         | 64 +++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events        |  2 ++
 include/hw/intc/arm_gicv5.h | 12 +++++++
 3 files changed, 78 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index cbb35c0270..172c5be0d4 100644
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
@@ -553,6 +612,11 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
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


