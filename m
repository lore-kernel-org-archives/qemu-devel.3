Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F23CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aV-0007D1-Sv; Mon, 17 Aug 2026 15:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z6-000672-7D
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z0-0006QA-3C
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so1276365e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993200; x=1787598000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vF+6ndrGLXKQZTWxC6EFwxN5nkIplvn1xYCLbrS7Iiw=;
 b=aeJ7Y7mzG60YVPCSCtCcrbxEeaRIGrb5mrOKxSIx5fkui8sPNMrAygLN4TVD2tTfMz
 cxO027SNdEzg3h6tyVR6hmeA7SCdJhnuEMya3KslTB5NCPXRJuvCPEN419ss7yndveaW
 nqURRzZVZiMpuEh71DmbZc4mumLOa0IaDG8PUQtl63b+rzr5cyz63KwiusbxanbMYePp
 j6VQBV+aB2eBlacwWPLgv9FLEAfr59OIpnP3un9TF5iLSgFME5fmGVHV43zj5wIMp5IK
 UulRb/F47Tao3Nd1IJFE2rStt9htHbkhBT164TZ5uOoccQs4GYPDriQUAwW+WOTdGoPe
 vH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993200; x=1787598000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vF+6ndrGLXKQZTWxC6EFwxN5nkIplvn1xYCLbrS7Iiw=;
 b=O95YYf3gVlX+8UPhXB0VsQ6BmqShDzhGs0meR5xr6rdTK+W3RkynI89bZSyEaiMlMb
 lENhM3yiCz42xPvuI39O2HSuiZTSB7YmnZttYhJ2Y1hd6NZXUr0CzmleUIa9jPbTc5gJ
 bMzeRsSoMVPjlTiLXjW9FBlYq1GEWFiWbFqN/6RYCuP5k4sHTQxcJND3GGrLuVH3Jciw
 IecrZPU+4i3F3lgPYngP8T9lUhprDgOFOjjDdJXvKKO7srOwndOIOMeCLJbWfOeqibFu
 HjMZSbwjfPyJmMsFyMtlelgLl0iDRE6ynoXSjhar9LKdCy/2g4SBOWYRF0ji9pbq4/AF
 VrNg==
X-Gm-Message-State: AOJu0YxyO0n543Wa+ib9boJgXX7qb2lXzNaHlYzNFFjW+eOP/2Tia50l
 wzH+O1UEFU10QS4dihWduRdb5BB+qe/HwhhmSDkpAxUY2B8G7MT9dohTJbFbs9bqNVCd3QdEgii
 slW6v
X-Gm-Gg: AR+sD13lHIkVqvXR+gwNU5aAK0qtyVNuNw2DrOk0dab9P1bDhxugShyFmlVwoRsVDHM
 ZdVpH7SYGFXEbSN+IXmnwreQ7nS7L/AUidxbhMx7mFLAr9ZUHaXF38MDhEmlcTGzNIxtiXoIg7+
 fuh8jOmP85+vb070XXRftvY1GW8l8CX7d7Q3Kfsyqmfa/+7oHjM3BYbG2WiIHAwKC5wFrzBE3WN
 ldlxtSQCh2OpX9//MLVV3PPE0oS3TxzMZpyj3U8L6gPyz6q0dSQKyLPseHWbh2L6fC3uJb2W5gP
 BctB3grIfS46wuwLySMFPR0tYZfRdBoqQcP+VgW+BDovHBl9QQTaJuic/LM5VU2NUkJsB/c3RoH
 LxtNg7dxM0gZGE/znG/SjnjH4tc9L7ffwQLNM81rLZsTHqnf1vEsqaA3dOqKgKhHC7lDPCJFAmR
 +U6MWuydGPvc32RQnNULZvrq4XCFqXCJrY0V5MJfLAUWH7KDVZF8g=
X-Received: by 2002:a05:600c:4703:b0:495:69eb:27d3 with SMTP id
 5b1f17b1804b1-499a1f6549cmr342205e9.8.1786993200296; 
 Mon, 17 Aug 2026 12:00:00 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:59 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 13/25] parallels: Handle L1 entries equal to one
Date: Mon, 17 Aug 2026 20:59:30 +0200
Message-ID: <20260817185942.1065143-14-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
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

From: Denis V. Lunev <den@openvz.org>

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Ask bdrv_dirty_bitmap_next_zero() for a clean bit in the range the entry
covers, and store the marker when there is none. Two things have to
match the region rather than the cluster which serializes it: the search
is bounded by the end of the region, as a count and not as an offset, and
a missing clean bit is the answer we are looking for rather than a reason
to give up. A dirty run is not a substitute for either. Its length says
nothing about the region it lies in, so comparing it to the cluster size
marks a chunk as all ones when only a cluster worth of it is dirty, and
treating "no clean bit at all" as a failure leaves the entry at zero,
which says the whole chunk is clean.

Both directions are silent: a full disk overwrite comes back as a
completely clean bitmap, and a single dirty cluster comes back as
everything the entry covers being dirty. An incremental backup driven by
the first one copies nothing.

The marker goes through cpu_to_le64() like the cluster offsets below it,
as the loading side reads the table with ldq_le_p(). The serialization
moved behind the check, as there is nothing to write when the marker is
stored.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index e89c489730..6a889d86fa 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -439,12 +439,20 @@ static int GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset,
                                                   bm_size)) >= 0) {
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         idx = offset / limit;
 
         offset = QEMU_ALIGN_DOWN(offset, limit);
         end = MIN(bm_size, offset + limit);
+
+        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, end - offset);
+        if (first_zero < 0) {
+            l1_table[idx] = cpu_to_le64(1);
+            offset = end;
+            continue;
+        }
+
         write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
                                                           end - offset);
         assert(write_size <= s->cluster_size);
-- 
2.53.0


