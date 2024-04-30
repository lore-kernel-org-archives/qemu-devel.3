Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB0C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qhA-0000BA-Uq; Tue, 30 Apr 2024 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgX-0006K2-V6
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:37 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s1qgQ-00061u-5W
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:50:28 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5196fe87775so6617984e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714495819; x=1715100619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHpYiWdb1lRh1fu1PHA0f9wMvB4Yb/LL+pZsTJlPtLc=;
 b=MOTLlKnPP2IEzdDDJu82cv7i1LDljQn2lzoqggOqoMupkMK5YyY3LdFJP/B+AsN2eC
 4HqjxdcDYRSpldegV0l8Dt/8xY4d7awG7luGgmqKP+P+bn8VHY1CIdScVNiEdze3+Tt0
 nk8UgYPdKI5o1KEq3gCwtqx3rxmdGwv5OS6yZOuUShr2undRu+W358Wb4N6ua3/oxex1
 0JnhlbP2H6hRSFHxt3H3bWiMAP9NhMIs9OIn/WhX56IPJFryg/FyjS9cos3SkoF9M3d7
 C4zuIroUS0xssSvP5K7h2aYuRoq1gDI52HyDa83Sn/6WXxKm8HMb9UEFnt760oDuMz+J
 FZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495819; x=1715100619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHpYiWdb1lRh1fu1PHA0f9wMvB4Yb/LL+pZsTJlPtLc=;
 b=H5u6I3Y/VLICawpIKhkZbxrvDnmfVbOXFK1Ib7dLnV823he2XLHSf9DyrVUM63cQ7+
 L2oU/Auej0IRz3We/73rlzYxsQMh2iwxWLipAq+m+VDdb/J9lrnft8IV2/hn+WAqQ1o5
 YXPRrLQL1uXETNachy0Yk/euscsKzYJgf2NadCEt3Ttb2bB/sRG+E67Rq+aN15rhW5ux
 c/eo77Fs0ejbHYWemeimSjUMRVBwiZGFxYZOv6FutRu0j75h8bCK6j4SAd9h7OM+1t9w
 4Pl6fTqbjOKTKKkMshe+op+GsZ0KcHI1gFHgLWLB6etLoc1Ywt42EdXOWfcU/BRrzvAY
 MyGQ==
X-Gm-Message-State: AOJu0Yw0EbvmSsup9zuKrptZ2wvOdPNtOx3v1hulBYXZW47skKTmQP/y
 dmNAlun98FYrR20J0OpuXClq73blQG1nibDE2WYliKTIND2s0wX2YyRLrmwP
X-Google-Smtp-Source: AGHT+IEpEAlJbJJD0/i+Lg344tcB9Tgltle5Mn6nu5CvyosHwr7HnsfYB92Ti4D7O/r40axqDFX0Iw==
X-Received: by 2002:a05:6512:3981:b0:51b:f224:7025 with SMTP id
 j1-20020a056512398100b0051bf2247025mr20846lfu.59.1714495819141; 
 Tue, 30 Apr 2024 09:50:19 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 y26-20020ac2421a000000b0051aada24366sm4312545lfh.66.2024.04.30.09.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:50:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 05/17] xen: mapcache: Refactor xen_remap_bucket for
 multi-instance
Date: Tue, 30 Apr 2024 18:49:27 +0200
Message-Id: <20240430164939.925307-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430164939.925307-1-edgar.iglesias@gmail.com>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add MapCache argument to xen_remap_bucket in preparation
to support multiple map caches.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 896021d86f..326a9b61ca 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -139,7 +139,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
     mapcache->entry = g_malloc0(size);
 }
 
-static void xen_remap_bucket(MapCacheEntry *entry,
+static void xen_remap_bucket(MapCache *mc,
+                             MapCacheEntry *entry,
                              void *vaddr,
                              hwaddr size,
                              hwaddr address_index,
@@ -313,14 +314,14 @@ tryagain:
     if (!entry) {
         entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
-        xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
+        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(entry, NULL, cache_size, address_index, dummy);
+            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
         }
     }
 
@@ -587,7 +588,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
 
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
-    xen_remap_bucket(entry, entry->vaddr_base,
+    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
                      cache_size, address_index, false);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
-- 
2.40.1


