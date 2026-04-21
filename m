Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78128F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbD-0000yk-Nt; Tue, 21 Apr 2026 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb9-0000xr-Kd
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb7-0008R9-PR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxOej4+K9+12DVShlen6zBubWxbQhJb/dp07j+yzJwU=;
 b=cYBTGFVd/JA7IdrN4APu8XKu3V4b5UTwzTFpT7SzVSV09vgiAJPk7Yp2Kd61sZtu0jMriG
 B3QrHGTrwCcJEIAR5JjcMPzxLD9/VswL/6zCYIbzkaSMGl2NI9iFR359GWWBlsi8nFyL4L
 ZQODVC6cmdHxlJ+0qers3wez8S8I7Xw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-_SuEQvpmOZemoCx2UR7ZLQ-1; Tue, 21 Apr 2026 16:21:27 -0400
X-MC-Unique: _SuEQvpmOZemoCx2UR7ZLQ-1
X-Mimecast-MFC-AGG-ID: _SuEQvpmOZemoCx2UR7ZLQ_1776802887
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a275472d89so69877266d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802887; x=1777407687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxOej4+K9+12DVShlen6zBubWxbQhJb/dp07j+yzJwU=;
 b=CDgyMvHGmbr49Za/wCmF9F201qEfau+WHSFueiRFF0K/8t53VQmSa4Vi7SxsGpIl2X
 KnsaNHaEnKuJX/2iKsBNSrm8Pr0WrK9Y5HBbTTpsI8FVtcroe1OIezY6rsDyP2ORNvif
 6e5bfBcu0FYfXt4Q0UraMK30SMUya/4k+0H/Qr/fwlNGbOcSqDs+UdtJ8D/MpgBy0HvA
 aCAUe6ty8dM9PvT2e6vBYqJrzHeHVDtx9vetQ70vhqLA8N+PBfsxI6AHHloQLRmYJuuA
 0a/y1rfsOuwCB1Lt07vtFRx0Amf9LRC1np42akgFQ59XSGAwft9+o4pCWnkT9k8mUpfD
 GWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802887; x=1777407687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxOej4+K9+12DVShlen6zBubWxbQhJb/dp07j+yzJwU=;
 b=gu2orQ4LuAyk5ykNkfiV9/UBL0EcLGLbcl4rh91ZF37cgF+CnrEeHuA+IJX0NtA/74
 JUYmCj4xFINneHThYuMppvM6isVipJ+BT0gg43zATIZubhE4tV5PdDR8prG/OB0KNb47
 mKu+hyFLPcaLRxEqtcv7ckZMRZGvjleni8FJgd4MTITa+mW8JtavV4dsRPNcV9G79bCH
 aMSfsg4f3rdR/QUlduGLaFVYNqRzGFIkhpX4IORyxePZ3NoGEbwBNrLw8F+zsXTFyf8c
 IuKMTEgNwqnxEiQpVs8IKiTW7Giw5PEymBdG2Wgrv2Q4VNjiCFixIA8Bhq3OqAJY0hcq
 vQbw==
X-Gm-Message-State: AOJu0YwT/zouZI0hCGfwu+jw+V5J5nwoW4UaiWLx2xgoAs60yQkrM3Xh
 aVgXoGHVOgbUD9Fg/U5LTp+dFJ5r86qkrxEhdmbMGtiIrdYXYxZ8Zmu+qwC3ZLRL5sW+ikPfLPE
 ziMbh0+501727xQNCx7i/D2EVTSDoRE9kBCGgmQCCayQ10b18YYB0LYiBfbt+NzxAYGa7B7bgdM
 KDWakel6PbNywPHEKF7co1EAgZv/tUN+TNUmNoJQ==
X-Gm-Gg: AeBDievtd3DMdhfE00939w5W2otk05jSwp/t9f/q0BTbbtQZpN0oUwybMFeABvVQHsb
 Pwy1wToe/cYUV9i70YhvsWTErJZGmKMiMHLbUvDGSOUUV+Pt2QTlcnC5fGhmR++FZai6cnhrh8F
 vXxsvHMVL0MepROlsPpzdT07JPhXsltwD1oSi4xR96daKz27jzb4YSZp+ipy9saF0ZBzv0JKqGp
 SEKVzbcj8Tc/O4RBMuLm1vaD7X+UEo7AEsAjmxEvGD8mKBWK+2gG40oM2F19jUIlARVSX+wHIIF
 Gih62G+tnOU6N7FGWan+TAcZ8KWRmO7dvwz8ySRN577g3aZnn2lM6FN1z52H4zY6JS7LWPQZBdj
 fhDXUS+fLV4Yy9qis/zHVNToFcWq/yqUK3ikBvDyPt0Xg9/hGnRhMupN6DQ==
X-Received: by 2002:a05:6214:2521:b0:8ac:b6d7:e60b with SMTP id
 6a1803df08f44-8b028013c49mr316275196d6.1.1776802886735; 
 Tue, 21 Apr 2026 13:21:26 -0700 (PDT)
X-Received: by 2002:a05:6214:2521:b0:8ac:b6d7:e60b with SMTP id
 6a1803df08f44-8b028013c49mr316274406d6.1.1776802886015; 
 Tue, 21 Apr 2026 13:21:26 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 08/16] vfio/migration: Fix incorrect reporting for VFIO
 pending data
Date: Tue, 21 Apr 2026 16:21:02 -0400
Message-ID: <20260421202110.306051-9-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


