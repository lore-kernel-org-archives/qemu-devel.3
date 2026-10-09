Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053EFCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF8UB-0006Kq-UB; Fri, 09 Oct 2026 07:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8U8-0006K0-0K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8U6-0004Ky-Gg
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791544193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP3jzlyEfhQ2lSBO4QpbitBdHt12HNDEPoatt7VqxiI=;
 b=eyCVGVd0ICYbX9F9HAthbF1oC1RbFx5sILmMUDLAzfysWmL6lOu8D1T6xOXuOSbB2izJe/
 8fbQIw6APZWCZ/ftUoYFP+tmkZneXLYHaIyajMECoJGlV6vhXFj48jKwfgW8MDW1deIHB3
 5396hEDCTj84z5geMNQeJdBKugXmWX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-JUwBsMJRODK9jpWowQiiQg-1; Fri, 9 Oct 2026 11:09:46 +0000
X-MC-Unique: JUwBsMJRODK9jpWowQiiQg-1
X-Mimecast-MFC-AGG-ID: JUwBsMJRODK9jpWowQiiQg_1791544185
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b02d63407so4148518f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791544185; x=1792148985; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SP3jzlyEfhQ2lSBO4QpbitBdHt12HNDEPoatt7VqxiI=;
 b=FpW8+Zpo3gJ5jE0B9o5jWfWBpNjd/c7YfSYMNgAtOfdG7TYqy09uKe5Uo9EpIMPyrb
 EM7brCLZ5Z0ztl7hIhao1SyEHQHxt/Iz6kvItSchwtFBiTz3PcITz8Aj6PDtSHyAxQKs
 g+DV7pSPZw9Lc0760bWZMFwLooAJccqFvYMg/JN2zxeq00BsUBTpfDMpxMMOcYhng/v4
 YB7F4MDASLuVpQvU1GTuMhMa8AQpW9GP3C+RgvstuS1xAvOnhZrg06vWcgLTNCAgAL0/
 sXHU447hKj93fStRjXysrUMhljH0EJvpWio9Wzfes0ugdeUaygzbNtWaErjZ9gKKNy9D
 641w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791544185; x=1792148985;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SP3jzlyEfhQ2lSBO4QpbitBdHt12HNDEPoatt7VqxiI=;
 b=FaZDloFY37cgbFjnoKRfQMnEswOCk4/M/4DecgHLiGjqLYGDqAxUtrBZtZ3/5W6JFT
 ukFNVSCtcgXiO8Z8V11xPEh33vYBUffVO5kVezbj2SKta4g1WbzoOqW4NzaqCwf210Nf
 MrJayBGDgeywhdi8BTS3aOUtyhKXC4XSI3y1pQExyajEY6rFH1DmVSSZEHBMJQJDFOXX
 YW+g8+oWWQgxbL+ehGAlW04nzjFcSXh1iEn5CS5Ae9+XApbf3tNAmPC/xXj6gH43/cME
 0BHRczjrrhLCkocdJv3SAsrzFtXBhLAZ8Nu1/KXlNpTlOnB7Rodzmh9taQzym2/ofhoc
 QOMQ==
X-Gm-Message-State: AFq9FYK0Vn8VEcMtXje4zxaiJIjTWW4ZUhuF87MzjvkZpHFgEJ4CRWqO
 5PpdlfWn0qwKFEDsdviiL0AyNHBgCO4+CUykWdxlOgHpCkYqspI2ImbpB0hHFTuYxLnjlx6J4qP
 GPA2lQ5egpzlqo593ltBootF7UQEgSWDqVpAijDR2F09Sc5DiECjfqGiMEpWEJWLESBJ4Uvui+Q
 7f1DgaFtyZ90bJumU7G7z2XKb0yqhm5PXfiP5NOddi
X-Gm-Gg: AYBFou1DaFEFgge6PAXSedWlpgMWauuzHzXkEQtM6J9mxEVKVZjfbw4M3l6BJMaXVWe
 MahaMT5e5P5gNxDyo9tUdCs9zA5oepU5pbb/B2RqDYx7VerMXDnMzXkSsN+zFZ9fVy5U1KVcSj+
 LMuJSus7rzJW0g5UAI+YsMGDhKarrl/ofJjKaGO3odNUGbznWcMVyey2RyQLg+1LrRiuJ/oyVCh
 1hBWeaoU42keTV7ZdHSrSxvcZosFWeraHvm3U9bVgS6gZxWbHHn6NqjlzH01vfAUNvlrLFoqmOS
 sbAgkdKzPVmy7j+qN7F+BtIxUmzWUyAalTxvSnex98bClt1yPh0OMZWVDWUnCeqnNjZEzvnjwa/
 /Al9nUrf/6DeYC4hHN07Xsj1se7Wk/XC/JQeP/MYQEee7JW13JJ5CxnrtqWxuwaBdFJ+Nf5ftrJ
 4dyIfxJqBRU0ulmR5Z4PZoFPt4j5i2gjVP
X-Received: by 2002:adf:e009:0:10b0:48c:7dac:8957 with SMTP id
 ffacd0b85a97d-48dbacda6b7mr2006160f8f.32.1791544185274; 
 Fri, 09 Oct 2026 04:09:45 -0700 (PDT)
X-Received: by 2002:adf:e009:0:10b0:48c:7dac:8957 with SMTP id
 ffacd0b85a97d-48dbacda6b7mr2006113f8f.32.1791544184804; 
 Fri, 09 Oct 2026 04:09:44 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm3295680f8f.13.2026.10.09.04.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:09:44 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v2 1/3] block/vmdk: align stream optimized data grains on 512
 byte chunks
Date: Fri,  9 Oct 2026 13:09:03 +0200
Message-ID: <20261009110905.905070-2-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009110905.905070-1-sraymaek@redhat.com>
References: <20261009110905.905070-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

According to the spec: "Each marker and its associated block begin on a
sector or 512‐byte boundary... There are five types of markers:
compressed grain markers,..." [^1]

This means that instead of aligning grains on their typical size (64K),
in stream optimized disks, grains should be aligned on 512 byte chunks.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index cd8b4ec7c8..c70c73515c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1730,16 +1730,22 @@ get_cluster_offset(BlockDriverState *bs, VmdkExtent *extent,
         cluster_sector = extent->next_cluster_sector;
         extent->next_cluster_sector += extent->cluster_sectors;
 
-        /* First of all we write grain itself, to avoid race condition
-         * that may to corrupt the image.
-         * This problem may occur because of insufficient space on host disk
-         * or inappropriate VM shutdown.
+        /* Stream optimized (compressed) extents do not have to be
+         * pre-allocated, as compressed writes always cover the whole
+         * cluster, and will align on 512 byte chunks.
          */
-        ret = get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
-                                offset, skip_start_bytes, skip_end_bytes,
-                                zeroed);
-        if (ret) {
-            return ret;
+        if (!extent->compressed) {
+            /* First of all we write grain itself, to avoid race condition
+             * that may to corrupt the image.
+             * This problem may occur because of insufficient space on host disk
+             * or inappropriate VM shutdown.
+             */
+            ret = get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
+                                    offset, skip_start_bytes, skip_end_bytes,
+                                    zeroed);
+            if (ret) {
+                return ret;
+            }
         }
         if (m_data) {
             m_data->new_allocation = true;
@@ -1891,6 +1897,7 @@ vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
 
     write_end_sector = DIV_ROUND_UP(write_offset + n_bytes, BDRV_SECTOR_SIZE);
 
+    /* Stream optimized (compressed) clusters should be aligned on 512 byte chunks. */
     if (extent->compressed) {
         extent->next_cluster_sector = write_end_sector;
     } else {
-- 
2.55.0


