Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96844C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8K6J-00024Z-MV; Fri, 25 Apr 2025 10:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8K6D-0001zf-CK; Fri, 25 Apr 2025 10:32:21 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8K6A-0003ov-Vh; Fri, 25 Apr 2025 10:32:16 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30bf3f3539dso24566861fa.1; 
 Fri, 25 Apr 2025 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745591530; x=1746196330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NG4zYuYYpcJqlLYEG5C5mY3Kfpvlarp9AnNvsczkLIA=;
 b=IT4Ax2huzMtlLODQoXGCmrKWsiOQfGjLQcbxefnxTb+8tNNVWJo+Ded8B+9AOivX7/
 eVeWcF+KudP1v17B3sVeooctEfISz9smxlnVoQKNoX/zvNoNGEviusi48R7Z4Lz9JJ1O
 8gudje7b6UuLAilG6V3OAy3dtK9RJAcLAR+lZ63OPigyCj5c2k7kIdun2/7DXFHw47k3
 YzlcUP1Inzv40EEJzuV4ZcCMh5nLS4lQB2f6qK5HoEYzm4r7jYwnDSTfTe3VCtmzMFvx
 tVR9RP3CGhKqdv6GMuqzPKWVFU98wRwAYboBq6cbKXeSj5LGmqtz8ObKoaXX3Lxp1RWl
 tEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591530; x=1746196330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NG4zYuYYpcJqlLYEG5C5mY3Kfpvlarp9AnNvsczkLIA=;
 b=QpSNtVO5AKYHpOMTjnplvpVRNZ9hT3e5ZtjzmHlPfNQ3cwOMh/3+0Dy4N7BdWg4E5A
 NKY2o107QKfmWIP2hm9ET52+Rqlo+ahZKVjgIO4hT1IN7glBetVeaR5iJxftuPy8T1ZX
 b7N+yp2HCXHlm74JKOKAYujJUugIzzTsf0tdNwFvAqyYxezDjh8Fg+g7TxJ82iycEOkl
 hADTct5k/yoNVh2gtxFuuQUD+h0sgBaoqW2PJaUo7ffrFliSCAL3IkVYaPhZiGIBlTB1
 OYxTtpruQ1J2Su7b1JbrJgtuZGqPv7qoelbm8GCXINRDOM0MYYTiH90YWxIUKvZJqtt1
 58Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3PQha95bmi2oCax+ZLjC5pB/hLpzc+xgKFweHYP+8GW5zWE78fw+5ah6QPPVC1WSMPh88/t7pZDeGmA==@nongnu.org
X-Gm-Message-State: AOJu0Yz52jEtlRlMHejrry6G97vB+6S21TdZN8iCWC0C37zT6nF+9+8V
 FwoSUeZiWE0HDHvRtqU7yNGqu1j1lTIQMMCIOcQCJt4KLXu84Fq3pKOmjV9DLxY=
X-Gm-Gg: ASbGncu4YpRjkIR0JWTbQ0B3Vuh2KEpnEpIpAsLHMPfYgb5vejfzEUYmgKA2q+VOuWE
 pgwiOCZsbIuQQmX5qBsc8bRug2WoiPrRSsz/FkXX13EKuIF9VI7WvFlff6H9vNZ1l7Ml65iArf3
 A37yN1nSsGn8xybEMc58uz8q79oMg7aNX5OK06WalbWet2aaoJzbuJ7I3cFctkIo6/1fh8CU0mV
 6cA5wp+T5Kq49UROi7jk1OMaRrjcYSTQ2Q8VIj6APNbESX1iIHQ24U+2eWNXV5P0YIM86r4BT2n
 jes8YJAAhGbD2YQnjBViy0etA2JNeEd7LEI+ht/mdzWNZro7SKyZwGcQGwBuFMz9bPj5Og6So5M
 0+MKJAr1QDUUXU/FIr2QxSHs=
X-Google-Smtp-Source: AGHT+IHWARaFw57BZ01THUTSc2KFZuId+pV+qu+u3iEKnTFsjDPBoBcWZkR34cYxgsb/mk2/7B64+Q==
X-Received: by 2002:a05:651c:881:b0:30d:e10c:cae0 with SMTP id
 38308e7fff4ca-317ce4c347amr22810961fa.20.1745591529939; 
 Fri, 25 Apr 2025 07:32:09 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d16a8312sm7745871fa.86.2025.04.25.07.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 07:32:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v1 1/1] xen: mapcache: Split mapcache_grants by ro and rw
Date: Fri, 25 Apr 2025 16:31:56 +0200
Message-ID: <20250425143156.204452-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425143156.204452-1-edgar.iglesias@gmail.com>
References: <20250425143156.204452-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Today, we don't track write-abiliy in the cache, if a user
requests a readable mapping followed by a writeable mapping
on the same page, the second lookup will incorrectly hit
the readable entry.

Split mapcache_grants by ro and rw access. Grants will now
have separate ways in the cache depending on writeability.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 2c8f861fdb..e31d379702 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -75,7 +75,8 @@ typedef struct MapCache {
 } MapCache;
 
 static MapCache *mapcache;
-static MapCache *mapcache_grants;
+static MapCache *mapcache_grants_ro;
+static MapCache *mapcache_grants_rw;
 static xengnttab_handle *xen_region_gnttabdev;
 
 static inline void mapcache_lock(MapCache *mc)
@@ -176,9 +177,12 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
      * Grant mappings must use XC_PAGE_SIZE granularity since we can't
      * map anything beyond the number of pages granted to us.
      */
-    mapcache_grants = xen_map_cache_init_single(f, opaque,
-                                                XC_PAGE_SHIFT,
-                                                max_mcache_size);
+    mapcache_grants_ro = xen_map_cache_init_single(f, opaque,
+                                                   XC_PAGE_SHIFT,
+                                                   max_mcache_size);
+    mapcache_grants_rw = xen_map_cache_init_single(f, opaque,
+                                                   XC_PAGE_SHIFT,
+                                                   max_mcache_size);
 
     setrlimit(RLIMIT_AS, &rlimit_as);
 }
@@ -456,9 +460,13 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
                        bool is_write)
 {
     bool grant = xen_mr_is_grants(mr);
-    MapCache *mc = grant ? mapcache_grants : mapcache;
+    MapCache *mc = mapcache;
     uint8_t *p;
 
+    if (grant) {
+        mc = is_write ? mapcache_grants_rw : mapcache_grants_ro;
+    }
+
     if (grant && !lock) {
         /*
          * Grants are only supported via address_space_map(). Anything
@@ -523,7 +531,10 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
 
     addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
     if (addr == RAM_ADDR_INVALID) {
-        addr = xen_ram_addr_from_mapcache_single(mapcache_grants, ptr);
+        addr = xen_ram_addr_from_mapcache_single(mapcache_grants_ro, ptr);
+    }
+    if (addr == RAM_ADDR_INVALID) {
+        addr = xen_ram_addr_from_mapcache_single(mapcache_grants_rw, ptr);
     }
 
     return addr;
@@ -626,7 +637,8 @@ static void xen_invalidate_map_cache_entry_single(MapCache *mc, uint8_t *buffer)
 static void xen_invalidate_map_cache_entry_all(uint8_t *buffer)
 {
     xen_invalidate_map_cache_entry_single(mapcache, buffer);
-    xen_invalidate_map_cache_entry_single(mapcache_grants, buffer);
+    xen_invalidate_map_cache_entry_single(mapcache_grants_ro, buffer);
+    xen_invalidate_map_cache_entry_single(mapcache_grants_rw, buffer);
 }
 
 static void xen_invalidate_map_cache_entry_bh(void *opaque)
-- 
2.43.0


