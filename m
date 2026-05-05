Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB22CCD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMJ-0004Vb-9D; Tue, 05 May 2026 16:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMB-0004SZ-Li
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM7-0002cf-Gq
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGmcZTJdrvJChcgQdhUlKR40+p3UPXTZRXwTZoQgmPs=;
 b=cja1Ifg3KvzSIJwQHOyCLzNKTxvSdJjdnLrJsTqlLlGqbKgVeLc8+uUKBgJKKptsAZ2gYL
 nU9IErTzoJDOGfbu1w7t0dL5yHVLR24gTiDuD5m84T0u2WE/O1DVLVqPmpUNHsTlPRnIWQ
 OX+QVqsdLEAEAxTMI6pMcv36Cy+QEh4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-kf9f9osJONuADIKTkVENSQ-1; Tue, 05 May 2026 16:26:57 -0400
X-MC-Unique: kf9f9osJONuADIKTkVENSQ-1
X-Mimecast-MFC-AGG-ID: kf9f9osJONuADIKTkVENSQ_1778012817
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-902e1e4f8ccso340965185a.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012817; x=1778617617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGmcZTJdrvJChcgQdhUlKR40+p3UPXTZRXwTZoQgmPs=;
 b=QWcQMGlGm9tTLfnVrlIQ8gUMgWOEgoF9k2RDTVoLzbyRVYyfiA2nuUp3TK6LJ5P5y7
 T9NUcZEi51Ybi/KWvU7j6yJ+e/UHNu8Su/Mj7dYjCVdupH+KERBQs6BPTmINs4x5GdK2
 iIOCNE8AGNJa7xsB0VsKk8gJ5SP/hWZrUZaAq/M/RLCReF8sZCIsG9aJJkWK/12ztesv
 NiUGaulHgPLhrwP2DhWoUuoPJxN+ezps8hpTDqmaCLkg3IqX4U0RTLuOjNNFPemTidZs
 0dw3jJrzxXFaNX+cmPgZoaMgvA3ns6ghqkbarWXJyUBDgms6KJBNK05iZj/izq2qfnlt
 meWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012817; x=1778617617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OGmcZTJdrvJChcgQdhUlKR40+p3UPXTZRXwTZoQgmPs=;
 b=CHG9PheVBHN2DZccpP6xKWuXqCg4NyxChachDozhbPpY0Dfo0dLxM5DHojsQJ1aBza
 82B3c0uyNgKzcn/dZ8SVSmmQCjeIEGPiI25dhUZkSo/tmD0Bdh9GvVWFr32oSzstafSR
 nemGWpbGB+6XrOOnZykoRpdi4qGDpBZivLWvMV4M47+OCFFJzR9JW8WFoA1ZeRbajiIg
 tREq31IZbOLXdu703G8mZ/k6nwEcrS/83y9n9+oPQLmphwqF3TEpw4BSU1wsq3KVpuoq
 fOL54aCnolagQGZNxEFB7ZbxHuWc+oLmSF8vWs3CRsguXOQcBdrEshI60qqmBvuBiibw
 xv+g==
X-Gm-Message-State: AOJu0Ywy010U7Yvvmew4i07fZ2PL07YUAztqK0+eCG/aExTf5sFu9TcD
 vmGsmxwiXjfY13c5xldsMFZu6qkkKPQMwJ+o62akW+GYchXqhxBy58JgC0W6V1Dn80TAZqROPRo
 xDxTZzGHedA0iWTuZhkuS+hHP1aOeKdFT8G4W7uJgF/YKZdU1sSLWrWkPPobdoFnDvicsa7p8yQ
 R3dy01XieGgpLuSlqFhIDznHU3Dvrh/AlR19UWSQ==
X-Gm-Gg: AeBDiesgzJKRsRYo8hizcr4Mlit9b6CMVRKCKJ7/DUy8mDXiNn7MZM22HBP0i8TdIVO
 nqzdRX5vh7OkHpSaP8Qm+DaTivdpLB+bC6iZXd6ZX9Gb9NDVV2zxX0O8nUIXHDlMzrqt5IgQhL6
 gJzqB6y+3XV/xRktxpccKq/v+i60+7oqMQZWHSyRSrseXCNu3mOYh2cYvdYTtg3n62YDuHzCx4R
 E9GAujudcXQshjEnMUyPudsGoW9qp69tkltI2tZmaE0FGB359Q4pfpqan+Q37zhhCcnRJl6LVIn
 jshcGQQwTFB0EQRpS5Wsf1XpkMuXkZZJ3McJyQtgefTwvjDoL4IRLEyL6VzAZMs0BSfLssJy6vq
 /8D9UGjXwcZYP1MACfnwMWCBj+Mdj2ApNs4zhydfmrgrCyw/CKdB7zBU=
X-Received: by 2002:a05:620a:2544:b0:8e5:b6a5:8d0a with SMTP id
 af79cd13be357-904d74b318cmr90979685a.62.1778012816541; 
 Tue, 05 May 2026 13:26:56 -0700 (PDT)
X-Received: by 2002:a05:620a:2544:b0:8e5:b6a5:8d0a with SMTP id
 af79cd13be357-904d74b318cmr90973285a.62.1778012815837; 
 Tue, 05 May 2026 13:26:55 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 10/23] vfio/migration: Fix incorrect reporting for VFIO pending
 data
Date: Tue,  5 May 2026 16:26:27 -0400
Message-ID: <20260505202640.1011006-11-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VFIO reports different things in its fast/slow version of query pending
results.  It was because it wants to make sure precopy data can reach 0,
which is needed to make sure sync queries will happen periodically over
time.

Now with stopcopy size reporting facility it doesn't need this hack
anymore.  Fix this by reporting the same values in fast/slow versions of
query pending request, except that the slow version will do a slow sync
with the hardwares.

When at it, removing the special casing for vfio_device_state_is_precopy()
which may reporting nothing in a fast query.  Then ther reporting will be
consistent to VFIO devices that do not support precopy phase.

Copy stable might be too much; just skip it and skip the Fixes.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Tested-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/r/20260421202110.306051-9-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e965ba51fb..e6e6a0d53d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -587,19 +587,23 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t remain;
+    uint64_t precopy_size, stopcopy_size;
 
     if (exact) {
         vfio_state_pending_sync(vbasedev);
-        remain = migration->stopcopy_size;
+    }
+
+    precopy_size =
+        migration->precopy_init_size + migration->precopy_dirty_size;
+
+    if (migration->stopcopy_size > precopy_size) {
+        stopcopy_size = migration->stopcopy_size - precopy_size;
     } else {
-        if (!vfio_device_state_is_precopy(vbasedev)) {
-            return;
-        }
-        remain = migration->precopy_init_size + migration->precopy_dirty_size;
+        stopcopy_size = 0;
     }
 
-    pending->precopy_bytes += remain;
+    pending->precopy_bytes += precopy_size;
+    pending->stopcopy_bytes += stopcopy_size;
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-- 
2.53.0


