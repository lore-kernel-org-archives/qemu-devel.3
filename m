Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E60C3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyR-0005zM-Io; Wed, 07 May 2025 20:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyQ-0005yb-9r
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyO-0006vC-NP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736a72220edso467494b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663527; x=1747268327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhgvxGbjckjA2uvUuUKgLB6cM0wWCDZ0qCaH290UVI8=;
 b=PI/UTwRkzu2vYEOv6YOPAxIXZG1cFrgD2XxM4FyPh5kGZ+5Uwt5RAAe7FiIHlWY1M+
 4/ZnUiNBBVbAidx33HYYe0RPB2sywtjb0XFNuhhc0l99HLa5vzdJ5lWWlNh4LQEI/icT
 IwrdvGBxkN+vWRLis+1GU4/A9gLKW/aVWwb4x4tDV0+x1yglwXr7Fmfqq9mzN4ktlzgq
 tv6fR6HCjZN0dFHGU4tDg00I5BTx8KAHojf9eKHAl/q7+9MqckXUjnY0tmLFtnfUbVBn
 3XxYVgAE6M0hM3dAomvxAMAh6OVhOEugbS7MFAK7HIhtyB/QL57hOoOj0Xg3/wW1+HFt
 WE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663527; x=1747268327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhgvxGbjckjA2uvUuUKgLB6cM0wWCDZ0qCaH290UVI8=;
 b=dMxbK/TC4MHu19MZv2U124ZFeDwKCRAVaRct3L9hrjEJP5ajxfQWR6jYYmc35PMf9D
 EnuHNJYiJFtQMLQOfjUW//DRw6C8u9FgJduTChoFIAc3dAO3abKXtOrr+7hvwErL+PZ/
 d46nyvFNFuVpDP+a0VUV139/DGEoruuBjNCxwfQc6QcJ/fXdy0q3jzgf3m06nufWS2KL
 NzQPuoXk+70vq7gAdAD6zrgftTCwtXDx9Bws4LYjNc00D+8wZwv1XPRA+PjIp31fEoQw
 gsltfXHFiyzDfWpD6I7w/7D6vqS0kwpLJNv4POShvtddptH5Yo6cofKmy+RdMSSNpCpZ
 Tcrg==
X-Gm-Message-State: AOJu0Yz+I3pA4G/1EuE9sAL1F2+C5O1CkKMUr500sVRXiYmISJjqcoVf
 SYKFade3ztBWuldaEpx05h4yw8+c3exvcRCK1onscyDZBdHRusnjucDm+Q==
X-Gm-Gg: ASbGncuZ0VBKRsMJDL8cmZ8Tyrr6+2zYW24lW7KUnIQkAalGXVhpPZ7IAFXwS0Vleb/
 NpZaBAbWSlssTzKMYHzv+f8WuSBU7p1bfR8ZsUalVv3SHn7I4VV1RAa84VkBzKmJ6PEbwOCJ5LF
 j267KN05NvOJWmia3TlQAt26B+bOWzVa3imjXygzivREft+NjcEaAZtSHubuKpCkDuchJYW5ksv
 i2GccvjFS0q0Bd0236f79fSZqqvoSxGcfVQF5452WRKbDR1tlMOIMqlM32QaW8941aEMSqr67Yf
 xJgy+vnTwfcdg86EhgS2K8yYaWWL7R+Ea3RTmrMOLW/cOcmBJ+oLGMLCh+3dGw==
X-Google-Smtp-Source: AGHT+IEvKsYyiIeKhSCEqxAOZsTuLrWmoiPq+q7QjDiIKJsyTc7wpK5BxhX2/hHParmAJT0q9QxjIw==
X-Received: by 2002:a05:6a00:35c9:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-7409cfd5addmr7438760b3a.20.1746663526867; 
 Wed, 07 May 2025 17:18:46 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:46 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 06/10] hw/cxl_type3: Add DC Region bitmap lock
Date: Thu,  8 May 2025 00:01:02 +0000
Message-ID: <20250508001754.122180-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 4 ++++
 include/hw/cxl/cxl_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6ad48f55ce..b5b3df5edf 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -824,6 +824,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        qemu_mutex_init(&region->bitmap_lock);
     }
     QTAILQ_INIT(&ct3d->dc.extents);
     QTAILQ_INIT(&ct3d->dc.extents_pending);
@@ -1176,6 +1177,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
         return;
     }
 
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
                len / region->block_size);
 }
@@ -1202,6 +1204,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
      * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
      * backed with DC extents, return true; else return false.
      */
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
 }
 
@@ -1223,6 +1226,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 
     nr = (dpa - region->base) / region->block_size;
     nbits = len / region->block_size;
+    QEMU_LOCK_GUARD(&region->bitmap_lock);
     bitmap_clear(region->blk_bitmap, nr, nbits);
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cbcc1bc9f5..9cfd9c5a9f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -618,6 +618,7 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    QemuMutex bitmap_lock;
     /* Following bools make up dsmas flags, as defined in the CDAT */
     bool nonvolatile;
     bool sharable;
-- 
2.47.2


