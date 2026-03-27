Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF9110ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CA-0006y3-6v; Fri, 27 Mar 2026 07:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C5-0006qK-Dt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C3-000860-Ar
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso1440834f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610254; x=1775215054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEEJDQIfKatLAIWwp1VQVpGT8YNJGDnSyCNt4dE6jFI=;
 b=jkEcsttFw5z4iFEEkEwQR+a7kDtPyAUTz1jLDfy8J2gac34zxpeZwQEg4hd7zUAEpt
 i03kRsdFzV3b9+ZPmEftTWZry6uk43dhs/+QGEVMKL1i9F/eJH+or7hahbeBUTy0UKp4
 rh0WYu34lby4DJgWpwUD8AqQoV3Fj+AmTcPWrLpHZt2YKN9tiXwyyHRqlqndR3vnl7Ny
 ItF1wAhu6CIzScO2lbkmnZcZ4Xn4vuKJkGOuWEPgk6x2S2s9PA1kR+tilZW5T9hmsXj3
 37hoZriDxGjet+P9Mjh7w1rrmOdKtKN5XkVRKf5BQyl7MlM4WkF1X1KAewl+YufHjpeP
 Ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610254; x=1775215054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vEEJDQIfKatLAIWwp1VQVpGT8YNJGDnSyCNt4dE6jFI=;
 b=fWFm1VSwgmPP0BYoWlpW+oaFQ94RTjvRICq1o97CFpM2zQLpowVoY3AUPrtLpXp3BM
 xj3QFgAPTEwGxUa1alrxKjDvcKyL2f4TSk6E7ckMXMcj9G89/HfyanL6Gx/IiHFLienl
 tdnzSA3WeKO+FU2g5mQbPVwuRvqy+vlvWExVlA727iOu697TBBlX7Uat3AIu3Bz0pfke
 uxTTl/oJV+u+znyxqcoDDexbBmHt8so8LqUpg0RacetDQ4z7gItuJtfxzJhNvNEuKa6A
 aDtuNsyVFFmwlgTDRn6/22xOIuHJP8bDi8VvPY89oLaqjvxFNrmTjDGuB/6sAwXCb0Ew
 YxDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDiPvEiyi9IF38EJWsKCmoKxN60so1g/tUyVankyvaRlek27dpj9FVtLazuMGn9rNwQTMH5TE2Id+7@nongnu.org
X-Gm-Message-State: AOJu0Yx2Zj666WL9KZi/NYjBwG6cs1Mx/qp8WvKCp79iuMMPj/YHY7cp
 GZdcuM7MiIp3f2MVZhPFrL2stOah9dgT2NsEs7KG8N6HJPOg1eRH1aR584KZZsZAdvYvXUmEvyQ
 trmCDkvM=
X-Gm-Gg: ATEYQzyHj2sy2qYdeZNh7A3zLcfpQpk+0HtrAxUT2/CvOyEKrcc95won0EsW49rMbuE
 wogEo8Mc0kfzoHf/2rVK7EvoybWSNODCxIklKSL1mYGm7unIrHJGOr4dbZJvet11puL31XqpX3s
 MbsSWSB6W4Li0ZW1k2dH0Hvp2pDbWbo7xyWlpulNHdv1ueZ9l4io3WFgoanc+sz7CR/10Lrj+D9
 VimiwEHAUgZmOG1v2h+8E3TJUQ4wFoTpxjLH4Ddwf61HcfoHfUse0u3ewEbH5f2SD4PKcytbJ+l
 cTtmeXFA4Sq+UeXU0hb4nOwOeotbHljae1SoL6URKjrTvHwaBu9PhY+cArXelOa1AJZtGllY3EB
 4hmNDmOmni+s92ld/g0j1jLHS1RvYrAqeDLX0SbZhI9A6Lfg8dJh9B/FiRVLgKFLlJ2eJYig6jC
 hOq4AV0iVvkoIGAtJdz9hsqon0z3MQ9C0rqYI0jPSVUoHV5FhrJDV1yczMdIB8QbIrtLklHbNPr
 ZBoVwWCBwdvAa2sIFpmNmrR7183u/U=
X-Received: by 2002:a5d:584b:0:b0:43b:5097:6f60 with SMTP id
 ffacd0b85a97d-43b9ea46b9fmr3077811f8f.32.1774610253735; 
 Fri, 27 Mar 2026 04:17:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 33/65] hw/intc/arm_gicv5: Cache pending LPIs in a hash table
Date: Fri, 27 Mar 2026 11:16:28 +0000
Message-ID: <20260327111700.795099-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The GICv5 stores information about LPIs in a guest-memory data
structure.  Iterating through this to identify the highest priority
pending interrupt would be expensive; to avoid this we will use a
hash table which contains an entry for each pending LPI and which
caches the L2 ISTE.  Typically only a few LPIs will be pending at any
one time, so iterating through the hash table should be fast.

We can access an L2 ISTE whenever it is valid, and can freely cache
the data for as long as the IST is valid.  We only need to ensure
that we have written back the data at the point where
IRS_IST_BASER.VALID is written to 0.

We add an LPI to the cache when the pending bit is written to 1, and
remove it when it is written to 0.  Handling of checking the cache,
and of adding and removing entries, is handled within get_l2_iste()
and put_l2_iste(), which all the operations that read and write ISTE
words use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c         | 116 ++++++++++++++++++++++++++++++++++--
 include/hw/intc/arm_gicv5.h |   2 +
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 866c1333c3..989492d4b6 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -471,15 +471,22 @@ static bool write_l2_iste_mem(GICv5Common *cs, const GICv5ISTConfig *cfg,
 
 /*
  * This is returned by get_l2_iste() and has everything we need to do
- * the writeback of the L2 ISTE word in put_l2_iste().  Currently the
- * get/put functions always directly do guest memory reads and writes
- * to update the L2 ISTE. In a future commit we will add support for a
- * cache of some of the ISTE data in a local hashtable; the APIs are
- * designed with that in mind.
+ * the writeback of the L2 ISTE word in put_l2_iste().  Not all these
+ * fields are always valid; they are private to the implementation of
+ * get_l2_iste() and put_l2_iste().
  */
 typedef struct L2_ISTE_Handle {
+    /* Guest memory address of the L2 ISTE; valid only if !hashed */
     hwaddr l2_iste_addr;
-    uint32_t l2_iste;
+    union {
+        /* Actual L2_ISTE word; valid only if !hashed */
+        uint32_t l2_iste;
+        /* Pointer to L2 ISTE word; valid only if hashed */
+        uint32_t *l2_iste_p;
+    };
+    uint32_t id;
+    /* True if this ISTE is currently in the cache */
+    bool hashed;
 } L2_ISTE_Handle;
 
 static uint32_t *get_l2_iste(GICv5Common *cs, const GICv5ISTConfig *cfg,
@@ -499,6 +506,25 @@ static uint32_t *get_l2_iste(GICv5Common *cs, const GICv5ISTConfig *cfg,
      * If the ISTE could not be read (typically because of a memory
      * error), return NULL.
      */
+    uint32_t *hashvalue;
+
+    if (!cfg->valid) {
+        /* Catch invalid config early, it has no lpi_cache */
+        return NULL;
+    }
+
+    hashvalue = g_hash_table_lookup(cfg->lpi_cache,
+                                    GINT_TO_POINTER(id));
+
+    h->id = id;
+
+    if (hashvalue) {
+        h->hashed = true;
+        h->l2_iste_p = hashvalue;
+        return hashvalue;
+    }
+
+    h->hashed = false;
     if (!get_l2_iste_addr(cs, cfg, id, &h->l2_iste_addr) ||
         !read_l2_iste_mem(cs, cfg, h->l2_iste_addr, &h->l2_iste)) {
         return NULL;
@@ -514,6 +540,34 @@ static void put_l2_iste(GICv5Common *cs, const GICv5ISTConfig *cfg,
      * Once this has been called the L2_ISTE_Handle @h and the pointer
      * to the L2 ISTE word are no longer valid.
      */
+    if (h->hashed) {
+        uint32_t l2_iste = *h->l2_iste_p;
+        if (!FIELD_EX32(l2_iste, L2_ISTE, PENDING)) {
+            /*
+             * We just made this not pending: remove from hash table
+             * and write back to memory.
+             */
+            hwaddr l2_iste_addr;
+
+            g_hash_table_remove(cfg->lpi_cache, GINT_TO_POINTER(h->id));
+            if (get_l2_iste_addr(cs, cfg, h->id, &l2_iste_addr)) {
+                write_l2_iste_mem(cs, cfg, l2_iste_addr, l2_iste);
+                /* Writeback errors are ignored. */
+            }
+        }
+        return;
+    }
+
+    if (FIELD_EX32(h->l2_iste, L2_ISTE, PENDING)) {
+        /*
+         * We just made this pending: add it to the hash table, and
+         * don't bother writing it back to memory.
+         */
+        uint32_t *hashvalue = g_new(uint32_t, 1);
+        *hashvalue = h->l2_iste;
+        g_hash_table_insert(cfg->lpi_cache, GINT_TO_POINTER(h->id), hashvalue);
+        return;
+    }
     write_l2_iste_mem(cs, cfg, h->l2_iste_addr, h->l2_iste);
 }
 
@@ -896,6 +950,39 @@ txfail:
                   "physical address 0x" HWADDR_FMT_plx "\n", intid, l1_addr);
 }
 
+/* Data we need to pass through to irs_clean_lpi_cache_entry() */
+typedef struct CleanLPICacheUserData {
+    GICv5Common *cs;
+    GICv5ISTConfig *cfg;
+} CleanLPICacheUserData;
+
+static gboolean irs_clean_lpi_cache_entry(gpointer key, gpointer value,
+                                          gpointer user_data)
+{
+    /* Drop this entry from the LPI cache, writing it back to guest memory. */
+    CleanLPICacheUserData *ud = user_data;
+    hwaddr l2_iste_addr;
+    uint64_t id = GPOINTER_TO_INT(key);
+    uint32_t l2_iste = *(uint32_t *)value;
+
+    if (!get_l2_iste_addr(ud->cs, ud->cfg, id, &l2_iste_addr) ||
+        !write_l2_iste_mem(ud->cs, ud->cfg, l2_iste_addr, l2_iste)) {
+        /* We drop the cached entry regardless of writeback errors */
+        return true;
+    }
+    return true;
+}
+
+static void irs_clean_lpi_cache(GICv5Common *cs, GICv5ISTConfig *cfg)
+{
+    /* Write everything in the LPI cache out to guest memory */
+    CleanLPICacheUserData ud;
+    ud.cs = cs;
+    ud.cfg = cfg;
+
+    g_hash_table_foreach_remove(cfg->lpi_cache, irs_clean_lpi_cache_entry, &ud);
+}
+
 static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -907,6 +994,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
             /* Ignore 1->1 transition */
             return;
         }
+        irs_clean_lpi_cache(cs, &s->phys_lpi_config[domain]);
         cs->irs_ist_baser[domain] = FIELD_DP64(cs->irs_ist_baser[domain],
                                                IRS_IST_BASER, VALID, valid);
         s->phys_lpi_config[domain].valid = false;
@@ -968,6 +1056,15 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         cfg->l2_idx_bits = l2_idx_bits;
         cfg->structure = FIELD_EX64(cs->irs_ist_cfgr[domain],
                                     IRS_IST_CFGR, STRUCTURE);
+        if (!cfg->lpi_cache) {
+            /*
+             * Keys are GINT_TO_POINTER(intid), so we want the g_direct_hash
+             * and g_direct_equal hash and equality functions. We don't
+             * want to free the keys, but we do want to free the values
+             * (which are pointer-to-uint32_t).
+             */
+            cfg->lpi_cache = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+        }
         cfg->valid = true;
         trace_gicv5_ist_valid(domain_name[domain], cfg->base, cfg->id_bits,
                               cfg->l2_idx_bits, cfg->istsz, cfg->structure);
@@ -1428,6 +1525,13 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
     /* IRS_IST_BASER and IRS_IST_CFGR reset to 0, clear cached info */
     for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
         s->phys_lpi_config[i].valid = false;
+        /*
+         * If we got reset (power-cycled) with data in the cache, don't
+         * write it out to guest memory; just return to "empty cache".
+         */
+        if (s->phys_lpi_config[i].lpi_cache) {
+            g_hash_table_remove_all(s->phys_lpi_config[i].lpi_cache);
+        }
     }
 }
 
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index c631ecc3e8..fb13de0d01 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -25,6 +25,8 @@ typedef struct GICv5ISTConfig {
     uint8_t istsz; /* L2 ISTE size in bytes */
     bool structure; /* true if using 2-level table */
     bool valid; /* true if this table is valid and usable */
+    /* This caches IST information about pending LPIs */
+    GHashTable *lpi_cache;
 } GICv5ISTConfig;
 
 /*
-- 
2.43.0


