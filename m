Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDE5EF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUMG-0007vI-8P; Mon, 09 Mar 2026 02:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUMC-0007uk-RG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:50 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUMB-00026z-CQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:48 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-94b07fddecbso7379508241.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773038686; x=1773643486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgO9zG7fMna9CoPh8ghnxcTLAQlMFEOZkqL0utLfYyE=;
 b=L3SeXvQPSYzYdzb+p1OXEOxFilPMnHCNVvbywwoRZKKVgwiZrqKdAWN3WbDAa/CEFH
 sqdVDud3zxW0yD9/fof22THDyV/GfCIwGJTJOZStFszAF9Fkm3Z73ZQaMusLj6kYWnbs
 J8S7Px4TTd/ttowCgMOSaeWKtZ3YnIjeM0hjQEaytj3/PlD8VYrKJN9dXUttdo8IvnYJ
 yr26ntK821RAUE96n9pCW6CGA7BwJ7i647wFrxrCmdPTdugnqbdZqq8fFem5psENvzgN
 CTWYI3GdpvXb+tp5Y6qhtwNi9M4jVi3hbXM8UU4r54W1fltXUsj5oV49iwqUxualZUHC
 rTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773038686; x=1773643486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xgO9zG7fMna9CoPh8ghnxcTLAQlMFEOZkqL0utLfYyE=;
 b=jbLh80UVCw1kF+gE6Y32jRTrNmIz1Renf/6LO88D8xk3GrXCYGrpWAVou5Ucnur1Kw
 nk3KaOs8K40U8ou5Ww81WukKpgEtaLwdS3fuM/fJWvicwRYth4R3glU7c9aowX83CYOW
 aSskqRCqzx0UMyfZlj5oDqVVUiLUBiOeLQSNwgeo45URM4iSI9HPtspMlLFGog8TdB4D
 W/SGEszeVuV2nbep9AWCVx6bgYIJv1odO6tMItq6t5KcK6wKURrAesJfjU8hgPTGzHyi
 OFDetaibvWqBIflZz83qXyIj2kuYFG/H7lcllAFPVNeYtC65IwFaySGisgN3orD6dewM
 F8hw==
X-Gm-Message-State: AOJu0YzV5d+5ZrfFoc3r320/pTL+SrmnGglAbaeJ9zPBN2l82z8InFAp
 rBlsET5ker8hMg35kitf+QrQjuZA6GsLNIynU1cN5R6Rts+jW/wknjfHH8RUOmg9
X-Gm-Gg: ATEYQzxaP+LD4wbfBxhCIT/W9/kvH/ERHc/ZCGmkGnmuiCEfmivYYuHk+0oVoiXNDm8
 1vhJUdCGNJ/jtAlfs0NSzDbueeUt2JsCXIuJhFXSCnD2Ci7EGFFW22Y6LCER/CPO2jEAHCiLbr+
 WaGey6Yqc8dYWUD1SJttcFqWee3cE8Wa1rgnXYiSw5InI+JiqZKP3BfECLe+JN9lB9G2m7q+QTj
 7vZ93REwfq8CU8cEBvBZ4X1A1Z+IwZ0jI9Y5FyfCjrXCTtR0e5heVEH/789o7S5QXZfd3n9E2Xd
 JFDVjhEzOOk+ejcTVkd7bQIJLy6FAuUzccEre8yd0SPZj/Io5O67jN348n5l3xragaEDEdySN2K
 QRy/Driwk2lW9ndIGBkd1fDBlj1uEPUZj+3MMnVcYyzm07HqCSLhHu+xAMTpTgt6i0m2KqEjVHn
 HyPCbYdpKdIIEvrZd1ihFTIAnFVJjKVgGXU748P48SY7jvGcSTcVW3AI4xY7yAEGNyA21v
X-Received: by 2002:a05:6102:c86:b0:5ff:a606:3cfc with SMTP id
 ada2fe7eead31-5ffe61248dfmr4759508137.21.1773038685979; 
 Sun, 08 Mar 2026 23:44:45 -0700 (PDT)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ffe8922cdfsm8333849137.5.2026.03.08.23.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 23:44:44 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PULL v1 2/5] xen: mapcache: Add function to check if the mapcache is
 enabled
Date: Mon,  9 Mar 2026 07:44:32 +0100
Message-ID: <20260309064436.51860-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309064436.51860-1-edgar.iglesias@gmail.com>
References: <20260309064436.51860-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ua1-x933.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add function to check if the mapcache is enabled.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c         | 6 ++++++
 hw/xen/xen_stubs.c            | 5 +++++
 include/system/xen-mapcache.h | 1 +
 3 files changed, 12 insertions(+)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 517e5171b7..a3c162cd4c 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -80,6 +80,12 @@ static MapCache *mapcache_grants_ro;
 static MapCache *mapcache_grants_rw;
 static xengnttab_handle *xen_region_gnttabdev;
 
+bool xen_map_cache_enabled(void)
+{
+    /* Map cache enabled implies xen_enabled().  */
+    return xen_enabled() && mapcache;
+}
+
 static inline void mapcache_lock(MapCache *mc)
 {
     qemu_mutex_lock(&mc->lock);
diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
index 5e565df392..a39efb5062 100644
--- a/hw/xen/xen_stubs.c
+++ b/hw/xen/xen_stubs.c
@@ -29,6 +29,11 @@ bool xen_mr_is_memory(MemoryRegion *mr)
     g_assert_not_reached();
 }
 
+bool xen_map_cache_enabled(void)
+{
+    return false;
+}
+
 void xen_invalidate_map_cache_entry(uint8_t *buffer)
 {
     g_assert_not_reached();
diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index fa2cff38d1..c46190dd0c 100644
--- a/include/system/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -13,6 +13,7 @@
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
+bool xen_map_cache_enabled(void);
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
-- 
2.43.0


