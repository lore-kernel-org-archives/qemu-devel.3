Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF7C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7rX-0001gx-PH; Wed, 12 Aug 2026 08:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rS-0001ZZ-T1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rP-00087t-Sa
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so5454995e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786536906; x=1787141706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cvb0dwDlcVJ96m5UrlDdQTM64pRTfq3T//iR/689M74=;
 b=V/Fu2YV5qbrNn1mOAwU5le+ElGtVQ89fjyRXiGB8IUaUQAelEujYRmqQgGF+J8wcGR
 11E7jz94LNnnR2FXyMRutKg6Wb2RxHq92pejA0ISvOwLo8vQZeH67eknyhnLh+UwN4s4
 YuMyzdAFxK1IBOlkAibWBtJAlNeyrmHwGZp4GLW3hSR/1DQhl1uSyPNMww76tIyvIxH/
 Eg7h0EZ0EyIntzNm0UDfaMtNORhRNJWwvTJqJ/E8NeWv2MRApfZBEQHzZWAPrF7JN2PS
 g15widbF8yjun8qmX1VZHTFp9jQzii1xzCtFuAb2+uHp5/AYnZtU9HrM4olLvGXe7Plk
 hmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536906; x=1787141706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cvb0dwDlcVJ96m5UrlDdQTM64pRTfq3T//iR/689M74=;
 b=eO3aaXXh3kDfwcS3eqnK44Yyxe9Kxf9/1R44k/x0UOxti4NUv3xR7I2mB7UDyYropH
 E3LVy0k07Jq/ggvg+0QVvN6jMFWF/jtQOQwn5RnCKoL6FGGkZ0UsDmCCRbG+CppVVHJQ
 qT1mLWOq2j8uBAfz3bWV75ZziR87oLObTkdnHWkqIjCbU/gvJX2QskTTnrVrhhdddPPE
 mbL0T6ARrQgdJBGI3wSM+Rv9FHMUqFu/gMYhgQNwXj+ZbdHwT8wb3x+LvCiAOc//qe1U
 GSnJh/c6gk+2pjhErSfM8QMxulaq5gJCucfM/8bLoXg9DtCiZBZFhoAKI1ZMxCnQv+JC
 fwrQ==
X-Gm-Message-State: AOJu0YzFwP7vj+F+wcx+5oVMLAixdpojcrT0XA8Yb2iYzrVXHqfrOxLL
 a5QCxCW/ODUZxMBILBWnDCCnFF8573lFouzIR9PzHTDjYw3zeZu7lw1BdZOgFOIqZ+13q5dsNsd
 ivSC/
X-Gm-Gg: AR+sD12kgChn8cI0d82cQHQGMlwCqxYN6VORmoaWTA67ozPYRx1sEtFD7clbOKjtA2w
 FnhVT9U0PBk9BrffMjti9I7nUahM/UPx3DJJ0gevI0NdFKTXZsf/yRYf8LGR7FD875rIRmSR9oB
 7q/QBCSIY4HBw0LyvIS1Ej35K7ooXshv8rIzc4mLbA1spUJ2XDHGRs+Q8fAlb0KV6zpt+ypSF3n
 DOB1J9k1cFxU3yNJ9ao+WpeiZS9ARbUX8iH/M2Nu4RenWUgk/HipMnyJhbbXLvOEP4lAHWHwkZ2
 /X9kk3C3ObPgf4UCvf8hqG96DXzunSUuhSLw5qVXYMwBQNy0/1pHeF7wGssFLpOwvMVja0bbVi8
 PRr/eAN4/gRtDfhER5CI4ClH6AHVITEjw2kVlSSdHxk6jLFv4+5EOIhXYXxVOgBmg/iY8o4Ccba
 Sj4BDxOoMEfcKvBZQk4Q4UgtqipquaEuJYQLmibdfjFwWWgMw6myQrYoBXxg==
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-4997c13420bmr66646785e9.10.1786536905863; 
 Wed, 12 Aug 2026 05:15:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad267c2sm49069945e9.0.2026.08.12.05.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:15:05 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/4] scsi-disk: refresh the cached capacity from the resize
 callback
Date: Wed, 12 Aug 2026 14:14:58 +0200
Message-ID: <20260812121500.1034178-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
References: <20260812121500.1034178-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
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

scsi_disk_resize_cb() reports CAPACITY DATA HAS CHANGED but leaves
SCSIDevice.max_lba alone, and max_lba is what check_lba_range() compares
every request against. Until the guest reacts to the unit attention and
issues READ CAPACITY, requests beyond the old size keep being refused with
LOGICAL BLOCK ADDRESS OUT OF RANGE, and a guest which never re-reads the
capacity never recovers at all. A guest migrated onto a device whose size
changed underneath it is exactly such a guest.

ide_resize_cb() refreshes its cached size along with the IDENTIFY data it
reports to the guest. Do the same here, so that the notification is what
tells the guest about the new capacity rather than what unblocks the
device.

Factor the computation out of scsi_disk_reset(), which already had it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/scsi/scsi-disk.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c..3d404a8651 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2386,13 +2386,10 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
     }
 }
 
-static void scsi_disk_reset(DeviceState *dev)
+static void scsi_disk_refresh_max_lba(SCSIDiskState *s)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev.qdev, dev);
     uint64_t nb_sectors;
 
-    scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
-
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
 
     nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
@@ -2400,6 +2397,15 @@ static void scsi_disk_reset(DeviceState *dev)
         nb_sectors--;
     }
     s->qdev.max_lba = nb_sectors;
+}
+
+static void scsi_disk_reset(DeviceState *dev)
+{
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev.qdev, dev);
+
+    scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
+
+    scsi_disk_refresh_max_lba(s);
     /* reset tray statuses */
     s->tray_locked = 0;
     s->tray_open = 0;
@@ -2425,6 +2431,8 @@ static void scsi_disk_resize_cb(void *opaque)
 {
     SCSIDiskState *s = opaque;
 
+    scsi_disk_refresh_max_lba(s);
+
     /* SPC lists this sense code as available only for
      * direct-access devices.
      */
-- 
2.53.0


