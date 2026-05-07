Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DD0CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11e-000417-Oq; Thu, 07 May 2026 11:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11c-0003yk-9n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11a-0003vZ-7l
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso12269425e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169149; x=1778773949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RODeQt9i+bgayBzEiwJIi4pCrFbJ9M8QFpaPNbna8o4=;
 b=Cs9/DKr4XkFKCZU7aYkr2NA/iYn/duDRrgXhQt0QSD00GZLs+OPh0ONNlMjR9KwSOV
 d9pqzZFrOhNMwGpVXldZp89LihPwdYKhJH5YHwwiH16N+1AfSnNeEY0+HMtZkGRBNY8i
 6W2kg3SuuEpCr44OjSyoimzcZKGTjiz9M+ca2ZZWFHCCaSSP6zZgN0el2n6vk7seTKaU
 YNewD1S7Dd6bF42xnEj6O2pQ+AuCeAxUr4G/BUfg3tyLv0EI2e17vBvmqmcfs9GY8q6z
 zq2c0dbqjCGW0R3AP7+qrMLIX1hd4jqnOvAES6VG7aak7oBV/H3YJbxztpQF/w6oNPNs
 v4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169149; x=1778773949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RODeQt9i+bgayBzEiwJIi4pCrFbJ9M8QFpaPNbna8o4=;
 b=s3w3CLRs+2jQetKZwngM7QdO8AkYgUpH5sTCKNQxGNXKxVva2QKRnk6VUsuQE88o0J
 xbuV+F4XF3P6OJ9P0HNIO5f0epgYzBGhM6i008ZTNWkF+B/ljr4cbtWBz1fKXbQIbZon
 cCkp451xezvby4WNLgMcFC88E/i0OHkn4btDOyXUzBidPJqy8yqwMiRfHoOx/ydeX+n/
 OT2gwjovd5SHos8hAaWhmhzWtGyQF42I9pvt5toDZt9EM2XFJlAfB+jI7fC4RoR3C+oZ
 iXpA2Gwp27Dp8IhHrrZg7lncmNxWiYA0p2gRFIImcZ86UJH6Z9WgpU63DsxHmPrxYyVz
 h15A==
X-Gm-Message-State: AOJu0YyUhgfS1fdnNI48f/M/kR7i1pMqyq44qrcM8i69OJN/+fA2z2ZX
 BKwCLCzJ3rdSy0Z58xnywDLuDB+1guC2sy5kTymyaje3FjC59T3S8NI8ijLBLlpeocdyJQAmPu/
 rnNAK
X-Gm-Gg: AeBDiet6TSjFmXleIbYnBs0hroRdV/4hwlr102kSjetdOBklQqrmm2yeJEhET4O4q+E
 ROpFjisAKKUWim1xpb6jezmNIfS395HF3JoLgxfvjYX9XBvjwv8Vxc4KFDDsBxJmlgcAWYufF12
 Ir8HK0RtKCqRUmDSiW6y6iVHWDSikSzKORxiBwWXugykTJzhOnpWYStqYwC6ir2qBbqIHlNcbc9
 hve9RB6m2NvPC67OzoVfAmisOycsupH6a0dBnzc3ZxxJNYcUAsqwu2iZ+9AFEBXP27gwaBqvI3A
 DBb2yUF9IzqALcwmlTvCgXgOpwdiygQmk2zE5+ZfX7SayschByVUBK/3HAi6mp+9zWQLhMJPjVx
 kJWb7nGyP1eSAU32ljiCi5SDP24b3sp9+GmiAa/6As9tvrevq0Lu081jEa16LLruM1+yz+wqyXQ
 ejLUxbUJaEQRrxspk3En72bGQEdZo8SGMIveobYmENPFt267q4OTYe8kYganPU0vyiG7z5U5+gj
 HziO2gwcLWLFrAmpwyfwEZzTSt0VepF55zcve99uw==
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr139244685e9.11.1778169148567; 
 Thu, 07 May 2026 08:52:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/67] hw/intc/arm_gicv5: Cache pending LPIs in a hash table
Date: Thu,  7 May 2026 16:51:20 +0100
Message-ID: <20260507155154.1886557-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Message-id: 20260327111700.795099-34-peter.maydell@linaro.org
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


