Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A85EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbPg-00062d-Pd; Tue, 03 Mar 2026 20:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPe-00061z-4a
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:34 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPc-0004Tw-JT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:33 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5673804da95so2771139e0c.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772589151; x=1773193951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0UYcKwpR4k449Oah1OUraSH63dKX72hrhhrlbQ1drM=;
 b=VPjsJDk1UW7zJ9QgZ1qw2CCFNeRqSEUOGbczL2C2CRK7Sbq8whu5A0lG+MZxOQWpKW
 EMH/mDfbnGUX4sUiqnT0Lq9hgMqEDBSMPjjQaNzOSBm0eo0ASJsZJO6eF2ZQ4bjnwr+L
 z1QFKzP4uKJto6ohOgfIgdmJ23rYNLNqLwuCbBu4Iiyj5EseILHxoTty9wBvEoFfJcu2
 413FEoSfXSLg6/7+goRbYVl0+hHSIPCzCPldZ5nFUC67udeoyNGaIswv/pORWFcE93Th
 dWQgJ6ra2O98CXzZeTlyvSfs/61oJ109tRSuI/+41mqq4pFnTFkFI0MS9fZsdsonZG/5
 w3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589151; x=1773193951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0UYcKwpR4k449Oah1OUraSH63dKX72hrhhrlbQ1drM=;
 b=tmMQ2774sh5PAoFaxkSC2r+KzwWmxwH2V/vr3FhGjM84wovdUSzy2JK2qyBchOMm5l
 J+c9u4XWeeumTP/MgCjGXllFeOLA3WGN8+hbNTFH3eAEMxot/MqF3PKzZqLNc30unpe4
 5vsOdHT4+YVKc1wiS1hNn3cTRNG3Vk5z28+3jR0KosAVHt9Zz9DfG/9iBCMy2rnk5RnT
 UR0PrWl43cCL64GL9+ulRFwDsCL0oIx/DLNEv/gUB1jkAtKjFItM66mn1ExHIe6e5x+x
 oAQEofuOuM12gcbUjI1Qf13xIyjoqWmez7+WU25npBDvRv4NQy/XemE4gq7T/K6o9aKl
 oX2w==
X-Gm-Message-State: AOJu0YxxNmX+AhwdCbV+emYIbKszTwaBrr/bQZcllXlH4WzHLDGW34EO
 mdGAU8n5/nLmRFniHtM4CsYj9oZtJJuC/oWTEvhAraWHxO52VKaw+6BkUFjorWhx
X-Gm-Gg: ATEYQzwAJarDzGN+zmT14/7O8uh7cI1Qygh0YDzPv/UBRaAEZepRm7Dq34ReCQGSjbX
 L+ato09WSUPGkqGfL03jJPmygDEFaUlApAoemty5INlFgvo7j2aFX+P/EMNJzUcTZDlqlIT6ZJU
 BAMIVJqRglHdBJMOVfuQV/4ghtBO7LR+GTV74CF5eQt/sx5fdtlSUSsgCatYB/sek4nEgN2LY9P
 rVxr0X0wXpgR9Z8YwFxOMFF/nxzvefNIZtGVQL77qMp+s+q0h+363dF809NIt+ylsRyTtEbJWv8
 drLsFge5agQa0+hddPMQY2ny948Fq48qflrSzdW9/0/2+hLJ3/xEVYnc79kHBEX1mMPTF8qyJ5U
 iDFqjV/C3ZGQ/N/ucJi5qBpCY9jLgiLao2dXcdcdKLpNNfTw62YZ28lf5dZKw8N1ZdKQ2VBAjAQ
 UvP4MMzQQVKcWGjnjlCWqOJxdjNHLa0+IG1+IgqXuPcVXB/0LmqkECUcL80w==
X-Received: by 2002:a05:6122:4b83:b0:566:453e:37ae with SMTP id
 71dfb90a1353d-56ae778ca3emr237936e0c.13.1772589150849; 
 Tue, 03 Mar 2026 17:52:30 -0800 (PST)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56adfad07f5sm2726919e0c.10.2026.03.03.17.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 17:52:29 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PATCH v1 2/5] xen: mapcache: Add function to check if the mapcache
 is enabled
Date: Wed,  4 Mar 2026 02:52:18 +0100
Message-ID: <20260304015222.979224-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304015222.979224-1-edgar.iglesias@gmail.com>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa33.google.com
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


