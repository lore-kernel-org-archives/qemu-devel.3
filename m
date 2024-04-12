Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFC2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvI6j-0001sw-04; Fri, 12 Apr 2024 10:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rvI6g-0001rc-Qp
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rvI6f-0005qI-AV
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712932940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tNy/cqs5Bdu6zbwcxe69AiuJInaF+xbVwMbFnsln5Wk=;
 b=Xmcmai3Lw1icvczOFkHSf+v/jJoHbmiA3GGjQWpOfQL1Ky+Z4wFMXDneZBANu23vgqB70o
 5K7sHFThBPoquy1Fp8e31q7/HGw569ww5rVUOp8CZw0J85y3lTUzXD65lsCGN4oJRlTrse
 ZDLfSEG/JvEVY5DY9UiIsn2NPFgPwbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-1Lk8svP6PnGxt0mHUOf__w-1; Fri, 12 Apr 2024 10:42:18 -0400
X-MC-Unique: 1Lk8svP6PnGxt0mHUOf__w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64F6F881E63;
 Fri, 12 Apr 2024 14:42:18 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 282AA1121306;
 Fri, 12 Apr 2024 14:42:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.0?] usb-storage: Fix BlockConf defaults
Date: Fri, 12 Apr 2024 16:42:02 +0200
Message-ID: <20240412144202.13786-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 30896374 started to pass the full BlockConf from usb-storage to
scsi-disk, while previously only a few select properties would be
forwarded. This enables the user to set more properties, e.g. the block
size, that are actually taking effect.

However, now the calls to blkconf_apply_backend_options() and
blkconf_blocksizes() in usb_msd_storage_realize() that modify some of
these properties take effect, too, instead of being silently ignored.
This means at least that the block sizes get an unconditional default of
512 bytes before the configuration is passed to scsi-disk.

Before commit 30896374, the property wouldn't be set for scsi-disk and
therefore the device dependent defaults would apply - 512 for scsi-hd,
but 2048 for scsi-cd. The latter default has now become 512, too, which
makes at least Windows 11 installation fail when installing from
usb-storage.

Fix this by simply not calling these functions any more in usb-storage
and passing BlockConf on unmodified (except for the BlockBackend). The
same functions are called by the SCSI code anyway and it sets the right
defaults for the actual media type.

Fixes: 308963746169 ('scsi: Don't ignore most usb-storage properties')
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2260
Reported-by: Jonas Svensson
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
Considering this a candidate for 9.0 given that we're already having an
rc4, it's a regression from 8.2 and breaks installing Windows from USB

 hw/usb/dev-storage-classic.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 50a3ad6285..6147387dc6 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -38,15 +38,6 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
         return;
     }
 
-    if (!blkconf_blocksizes(&s->conf, errp)) {
-        return;
-    }
-
-    if (!blkconf_apply_backend_options(&s->conf, !blk_supports_write_perm(blk),
-                                       true, errp)) {
-        return;
-    }
-
     /*
      * Hack alert: this pretends to be a block device, but it's really
      * a SCSI bus that can serve only a single device, which it
-- 
2.44.0


