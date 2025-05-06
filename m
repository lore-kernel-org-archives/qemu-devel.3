Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8ADC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 18:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCN30-00020O-Kg; Tue, 06 May 2025 14:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uCN0W-0006hQ-IU; Tue, 06 May 2025 14:27:10 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uCN0T-0007gQ-TF; Tue, 06 May 2025 14:27:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30bfb6ab47cso53911231fa.3; 
 Tue, 06 May 2025 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746556021; x=1747160821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpP4TBaydimBJ+yCxRqJxX0SmD5odScGLmy0sP+rMAs=;
 b=A7XR1Hw7/3XlMgzQveZkInZLDn8nL5FVDdlJkgQyp4W9GVQD4cr/4w196lXPunL7eW
 GW/MO/h0H3js+/o+qdBjVNGispa6G9M9s5Szm0eERM5RVx8EgV4xX1OqdpVFLCSIW2Pc
 8J9bJjUKAfaTQxly8wKyqWZ91EzZyIWP4YPs7ZpQHh4FSC4tWkvkmi9yXUyAhxE7C7fI
 3VLclMp/KmceY7Htl39AEBKY3u3ib6NQ4bDA+I2unhmFedi8CIMPq2980p1kDfMl43Ed
 WAHrwR2r2Gi4KmD5EMoiXTzAXZNDQj3r/ihb4MrUni+HbvnZJXTKmDLwU42qcwyj8SoX
 Es+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746556021; x=1747160821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpP4TBaydimBJ+yCxRqJxX0SmD5odScGLmy0sP+rMAs=;
 b=JdlcCwSFnYrSPnwN8V6GWq9ctUHW5S6SFHNlI81jHEABjtXOMIbprgS8wsIb8Fh17v
 TPnVyhiiDP2YGDeN39i1ktjh/UW1JhdkyJf1Ig65CDQEIL+3Xvxdx/SSKvQQliqsWciD
 q4N/9bn/UpyObqyX1xI5D3rwcN869BWRk8CfcddCOy0Zvi0s5aBICo1KvstpKhRyZVdD
 VvgmTC60CrMkiizyP3dxOwbqF8DOD+30KnWSTbiq1qt/ULD9Wbgyt/dC2pZ6vYEi35+V
 bDBANGjrS8orThisksWiWczeQPLltJCW5tSTNV594EHxWH0+7rafFWcNIREVjPrN/A8g
 qLmg==
X-Gm-Message-State: AOJu0YzstaP6gmc6lnwgdrSsbT9IXduzKbdordm9NT3wnrarT22D2e3I
 hwuZFgZEuIwlzb9MAMtR10ANgeg8zg6Fi/hdjDRzYsWiknJ/azEXRkES38quZwE=
X-Gm-Gg: ASbGncss9TmdH6Bxn9IDrVAp6Q6e7o0AGOUWuhe3e7/Y0jEdwFcttaqrRjF0aGhc/VQ
 91Ep/mhUC30v1s9yAWepY5Y/1NXc69z1cZWWgcbtm6TxNKbvTstoNEH3BStR2CzLf6UH3i0GF25
 g0PaXjQ5RpSwbLpE6DHSpeom9GPYxqIg47UnrOw0wtmFzpdh2v/udUuBVAeEVhI7m0g6yrP7FBC
 zfo9OTgFnmMQtL6ob1TaMtv57kFyH3ObpQaNhidnoKcPbW35BVD0GwEvb8kx95M9RruDymBSbHX
 mhuFfE63HLOYYM3cLev2XFysPHe/lZl3OFHfPHovUF1DlicumIZjOMxaLYgxtjPdTH3mVoSHtjo
 Wvdb4rZTUFesJO9Mez8Iv1T0=
X-Google-Smtp-Source: AGHT+IHBa9ho1ThyDkNxpwI0/3LxpQeg41uCA79/UXOH2n/099VZv3LAbpb5LyXBZ2fI612cdcWfAw==
X-Received: by 2002:a2e:be1a:0:b0:30b:ed5a:6f3c with SMTP id
 38308e7fff4ca-326ad19a978mr314741fa.10.1746556021307; 
 Tue, 06 May 2025 11:27:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3202a89ef11sm20952331fa.81.2025.05.06.11.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 11:26:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, alex.pentagrid@gmail.com, peter.maydell@linaro.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v1 2/2] xen: mapcache: Split mapcache_grants by ro and rw
Date: Tue,  6 May 2025 20:26:47 +0200
Message-ID: <20250506182647.302961-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506182647.302961-1-edgar.iglesias@gmail.com>
References: <20250506182647.302961-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x236.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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


