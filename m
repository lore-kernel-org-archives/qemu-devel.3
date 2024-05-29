Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CBFC27C50
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJy3-00068d-2o; Wed, 29 May 2024 10:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy0-00067h-A8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:48 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJxy-0005ht-Oa
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:48 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ad8230bb9so898203e87.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991664; x=1717596464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=WP82q6JCBhX9/1uLkU2WHRfmPbpwEDw3R+j74LIMyVptIkEgBpAbk5S9Z79LOpbwal
 4RJRONoY5ZAXWp3R6KRveZ9CIVtUaso+IBvkvQvO36rSyR+GwzHK8T3r4TSWR5HY1NaI
 WaZqG/HxKh709ow7Le+Klv3AtqWgllMoLuR7Ibss0UUEGsMqYQpPYaMXyAExiTWWSOH7
 8lJ/m0c64aoi2HZ8XheHSimQrSj2Qo4rVj1XME2pMiqvkjsis3w0FrYnrvUv8hGJmSec
 AS8Xo4VMy1fCyhTdzN5nMvz9HbqwH/Ir2cbFnfQKnPXmPiT5rrYiT6kxv1UO8kX9HKTW
 lmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991664; x=1717596464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suqLmt7AH8VX+OrzngkGIik/kesngvj14F2vCYL7OFM=;
 b=b/fWD1Zmm9tHgWne0YPud7tZW8ONyasPojNySvSp1xuMxmdHBDuWKTG98l9Hnn8ULv
 IeFiklrVv3udvO4Joqu7eHO8hPzsQiud6HMtP7EHj3Sa6xUEx1QjUWCj2PUCf+T2iwcW
 fHLHsS4ReNWe15jHfwxVtywky3POoCM/XZhFE0tPzcECdttJuVtAtsZ16TCghAzxAuW9
 pNTX8peVJISU6atuigtpDQNWsUq36XlubVFjLi+XSEntjaibH8eI2sn8hK+sxR0Ny8qm
 OjoHAHSVs18rmupWRSdu0yP/HYLJSIsVlX6Bl0dF9ugeUfJrum9VtA3tFYa4uPE3CMY0
 Krbw==
X-Gm-Message-State: AOJu0YwZAy0et/riQKwp8JbC2hJs5PN+NcYKv6KU7+rapWdcVxYeLZDK
 /ngIhvs6DUEh2qRGMSSiauH2v+OOLAYcRLSeg1BVdSIgGqm95bnEY50MFwGl
X-Google-Smtp-Source: AGHT+IGdkBzBgEhHrd1LW9KAGa/cGv5sdiBTlj+GoDqEM5VjT/z9rWbfYzsj/AoEXZVsdTS9qD3Uag==
X-Received: by 2002:a05:6512:3b12:b0:51d:2529:7c4d with SMTP id
 2adb3069b0e04-52961a82092mr14632029e87.0.1716991663724; 
 Wed, 29 May 2024 07:07:43 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5297066b233sm1274418e87.135.2024.05.29.07.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v8 2/8] xen: mapcache: Unmap first entries in buckets
Date: Wed, 29 May 2024 16:07:33 +0200
Message-Id: <20240529140739.1387692-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When invalidating memory ranges, if we happen to hit the first
entry in a bucket we were never unmapping it. This was harmless
for foreign mappings but now that we're looking to reuse the
mapcache for transient grant mappings, we must unmap entries
when invalidated.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index bc860f4373..ec95445696 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -491,18 +491,23 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         return;
     }
     entry->lock--;
-    if (entry->lock > 0 || pentry == NULL) {
+    if (entry->lock > 0) {
         return;
     }
 
-    pentry->next = entry->next;
     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
     if (munmap(entry->vaddr_base, entry->size) != 0) {
         perror("unmap fails");
         exit(-1);
     }
+
     g_free(entry->valid_mapping);
-    g_free(entry);
+    if (pentry) {
+        pentry->next = entry->next;
+        g_free(entry);
+    } else {
+        memset(entry, 0, sizeof *entry);
+    }
 }
 
 typedef struct XenMapCacheData {
-- 
2.40.1


