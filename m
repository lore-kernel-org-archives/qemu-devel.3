Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A66C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKER-0000Oc-LQ; Thu, 05 Jun 2025 19:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEO-0000NX-Rd
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEM-0004h9-W9
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-745fe311741so1919576b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166961; x=1749771761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hytI++/+HSDgI++r4n2jaUjYPS9mkzDh6jOOmYEmI78=;
 b=f2yEr/EvJMrKC4JJzh/VIf+br31kDihqoHVveJynRh/0aQ2hdX2z1bb+M+HbrBGHLh
 ZQcrccpEfZtipvAoyXzQJimy1s5sSkruIu7ksIREbH7s3nl6QaQJE17uFMdJlmEiYKnI
 rM+KVEZGPU7LqN3fukMvdl94gUw5z5ygmO7vZKpdzmtSdL7m/iSM8MVaPYSPvNKNI7TQ
 xzIzHLB1pGyfUEL5p/jlp81rdyJcNwJkZrt56pKOd11mWiEqc5Dc12A+9Iks4ezynalL
 E6vkn1IWLe7TvfzICvzBKBjqHewqAOLTQq7UM5Hblu/4gestDOz4U89xmDTXy6SuNMGY
 oOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166961; x=1749771761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hytI++/+HSDgI++r4n2jaUjYPS9mkzDh6jOOmYEmI78=;
 b=brxS7kMGn9ZV2+2tFbRTo3VpzxMDCi35cc/JV2P1I7t8YuH07DtmrFjazvoHcqvcS/
 pxJn3kHhmOQORLyXR57AeqN74Yevw5547+DYjw3+y+Uvg7hQyBM/jhpInXS1EoCqelIc
 yf9AR1iiRPtrPHe7SP6VQWLXTwtwtoj9b/ctPvsxJC9cEFkDM1Pq80OyzV00rVkN+FIr
 OKuIlvkoFssknTo88nGdspF5Ca0d8hu0YMH/nEHw/9wO6uyPWpqAKqzpz6h1uPvntmak
 HW2j1UkNsrwepCgzXwUvVQjia2mP8pYWVyhg6McnJhHgwZZBYL2QxpTIygTIal5XyLuR
 Ci0Q==
X-Gm-Message-State: AOJu0YyliKVYrmFE9YQcS0XA629eAgqQLi7LF7Ct5h9kOtwlvX0pt2Sw
 j2xw/0IawsLhXvzNZku/GvWrU0VVlY7LI3kYpaROPL0DvNZPJ4dty0mYpqR6OA==
X-Gm-Gg: ASbGncubcAZ63u8vP+eS8CeltmN0nQkjIGPeMaA4XG+eRrkQySskomPNHCrDEfjbn/a
 XumUw5weDXqZXSVJemkOusRWG7ktL1emmTaKD+08odMxtyK8JWoqRsaH1G0IJkTXLuO9Lb9doIh
 +9nJl+A1I5qk9ybTU86W3N15+NznFp6s/hDAirSAPpbDgCFx8pgLzuwFwyyqHrixJ6QQxBwN0ie
 MbHdgqOPhSKOJpjQTYJmimMGd4SDTvDmE17xhKp1wEKOzVs7tpAvSRcpa+BAjorkuQ6uNRyx6hB
 Kx4QFz259q7QGwAJaiCIymKbRIx8Y3Sv0230HIk6Pw0ZNQ4DHjlYWHlOFXWsv0Dzxf+6Zewz
X-Google-Smtp-Source: AGHT+IHNuAyFweuLK9aaXJLo6BNCBOfhLTEWK7H8Z091sLd+658pFI0O4X5K7RxgYf3/1M7Ogu0ITg==
X-Received: by 2002:a05:6a20:6a28:b0:1f5:8b9b:ab54 with SMTP id
 adf61e73a8af0-21ee2555757mr1282408637.23.1749166961344; 
 Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:41 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 5/9] hw/cxl_type3: Add DC Region bitmap lock
Date: Thu,  5 Jun 2025 23:42:19 +0000
Message-ID: <20250605234227.970187-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Add a lock on the bitmap of each CXLDCRegion in preparation for the next
patch which implements FMAPI Set DC Region Configuration. This command
can modify the block size, which means the region's bitmap must be updated
accordingly.

The lock becomes necessary when commands that add/release extents
(meaning they update the bitmap too) are enabled on a different CCI than
the CCI on which the FMAPI commands are enabled.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 4 ++++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cdd60079c4..b872a26173 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -692,6 +692,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1020,6 +1021,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1046,6 +1048,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1067,6 +1070,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 469e5d872a..96ef9be444 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -540,6 +540,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
-- 
2.47.2


