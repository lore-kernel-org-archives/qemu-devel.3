Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD9ACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs56-0003kJ-Lf; Wed, 17 Jun 2026 11:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.bommarito@gmail.com>)
 id 1wZs1S-0002ej-SX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:17:48 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.bommarito@gmail.com>)
 id 1wZs1R-0001YH-3H
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:17:46 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69e43b02308so2667088eaf.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781709463; x=1782314263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bLpBN9Ac0qKOiQl8lQw4/tujaGLrqnJffKktG9Ai6gs=;
 b=SwvYuRKwuRIKULv5WZNj23pI2k3I9Mst3HRqdGulY27Hz5sK9jKnrJexM0/tbKtDhP
 Sv1Xn81Ik7SzlgAFhUJko6Jy0VwjFYUtc1hGJhDwUxqTx0FS5m+9qLL2kQuvjTgNSUR1
 xxFhjQZcnQARltyRtyBzl/5Tc+bj/+oJi4cOqVgm365UWB5i2x6R3cbVfA/JhpWci+4w
 +5iWhx5Vrub5powuy+z6V1NY9bRGjcRlpdK6ylsrazUqnV4hJ1Yd50Ha5k7MaZd1LBsh
 f7Cca8K4k+cKZqgKAUQEvndq7eXWc4GDG9t2roDaTZ5IOrdKMhLakBNkPq/F9VpWOI+M
 qvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709463; x=1782314263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLpBN9Ac0qKOiQl8lQw4/tujaGLrqnJffKktG9Ai6gs=;
 b=g18ZFIQH1ilVebAwz+PwtMNA5UVqAq2JaIIseZa2inKFZKjihyRWN/q54lEXukzL2o
 XBPFee2J3BI5qDy/h60exdNWFPriho4nJk0zDzH/WpusEP98B/b2UBmdti+E/mxKZjyU
 KwpWfFL+UZld2vtQT6LeiwuTssPXy5Xl5fQETRFYbyjRebrizffQXrYFFsTwR7cBIXv/
 7wPX6EcTsn94LomSHZ8PRmyLTvq6m7azeCziBW7Qux8NYnjLsy1cExR35iPRd1LCfQT9
 U0vFhO69xnXYeI9UCNUt9DNmOFMYe9SBw1q8YD648nLc5CHurX/p4gedldPiStzEMwOu
 8WAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MqeU04SHzeOG+w0O/833Z1UFXAwRcBwYFVOvpdSLO81OqilAbysDqDCusPJzbmv1ZhmdbVOnPX85W@nongnu.org
X-Gm-Message-State: AOJu0YzMtGOQnqd6zsvbhD+4hEgRg+zlFl4vfV7rahCRv94ysQ8yQetB
 +momJmTuWk0YfNgbIv7CiXFAOF1e/XAZp5+Ma4Ehh2dMefz6I/DgO8jP
X-Gm-Gg: Acq92OEHZpAnu7H6GAGs9yrdbuay/DniGchiAXpSjtJmNSX+tP+yQS3s2wTp/wkp7Eq
 dHxPHbiGeCj6tRwWBzt+T/XT8jOffn0mH4wb5J9z6Hq0mg0FZ2WLlG79xwNtxr53zSDN09Oga18
 XuKqr5QvkI0eCOAq7JJ16hF5EdqAdnpamUquUmSNQPYLKeO9dFTEH5rVEWUOjfjjl/d/tpiLTLW
 CcFlpVb57gBDtzoe3QNAuykB5AsnAT7Pao4peWwIG4VS+zmcK2luSm6Z3vK1ql6etsxkmU6aUON
 4HvU7qfd/UXtjcaHslOrrugjtO9teh2EoUqqzbW9JcE1LIZ//rglnko/J85GY+R0hG1sq8cGxJf
 tGmX2Bc0ywcZB4kgI3s8HVpBKiO0261m917imfsnO/PuxQy4l1XS6VgF+cuiR25CVwbGw7Dks4/
 eoblQNLIzAP8IUDdtUcXtK+lGCuS/4Cg+4aAOnwOA6Xcaev3qRV7evR/ZBhFA5dhY+Pg2S4Ubax
 vBBr0sQicEtS774g/XLbS/FJSEVDY0V
X-Received: by 2002:a05:6820:220c:b0:69e:3c9e:5e82 with SMTP id
 006d021491bc7-6a0b6369947mr2747303eaf.42.1781709463382; 
 Wed, 17 Jun 2026 08:17:43 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f21a20b6sm65683676d6.21.2026.06.17.08.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:17:42 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] virtio-blk: store the zone-append sector as little-endian
Date: Wed, 17 Jun 2026 11:17:39 -0400
Message-ID: <20260617151739.4072252-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=michael.bommarito@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 11:21:30 -0400
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

The zone-append completion path writes the append sector back to the
guest with virtio_stq_p(), the VIRTIO_F_VERSION_1-aware accessor,
while the rest of the zoned reply path (the zone report descriptors
and the report header) stores its fields with cpu_to_le64(). The
zoned feature is only defined for VIRTIO 1.x devices and the virtio
specification defines all of its fields as little-endian, so store the
append sector with stq_le_p() too, for a single spec-matching
convention across the zoned path.

This is not a functional change for a VIRTIO 1.x device, where
virtio_stq_p() already stores little-endian; it only removes the mixed
convention within the zoned reply path.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Testing: builds (qemu-system-x86_64) and the qos-test virtio-blk cases
(basic, indirect, config, resize, msix, idx, nxvirtq, hotplug) pass
against the patched binary. No functional change on a
VIRTIO_F_VERSION_1 device, where virtio_stq_p() already stores
little-endian.

 hw/block/virtio-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2..e2a35fae2 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -762,8 +762,8 @@ static void virtio_blk_zone_append_complete(void *opaque, int ret)
         goto out;
     }
 
-    virtio_stq_p(vdev, &append_sector,
-                 data->zone_append_data.offset >> BDRV_SECTOR_BITS);
+    stq_le_p(&append_sector,
+             data->zone_append_data.offset >> BDRV_SECTOR_BITS);
     n = iov_from_buf(data->in_iov, data->in_num, 0, &append_sector,
                      sizeof(append_sector));
     if (n != sizeof(append_sector)) {
-- 
2.53.0


