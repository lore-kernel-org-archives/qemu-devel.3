Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25620606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kd2oqvgU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cK-0006N8-Nw; Mon, 02 Nov 2026 22:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cI-0006M8-7Z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cG-0000Zt-LD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ws45s9ALQiZnFe7ikPfCPiZoWwRG0FJMRtCKQwmrToQ=;
 b=Kd2oqvgU5jIKue/shy/yRMzf856wqmK4vLKTLKyYEs1S2ICWLItmSH3mKfbCAyX2nx5fLQ
 3rjjvwVyDO2ZOfYGNC09U1Uasjczam2dDv6GRLN98pRnxHPSTula/FqORsfb2QLtwt7qqR
 sGWM/a3Chm9vX0rkvfcVu9Z2IqNG3jQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5---gLq6IcMG-ZKHvs4z9I_w-1; Mon,
 02 Nov 2026 22:55:16 -0500
X-MC-Unique: --gLq6IcMG-ZKHvs4z9I_w-1
X-Mimecast-MFC-AGG-ID: --gLq6IcMG-ZKHvs4z9I_w_1793678115
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C4571800471; Tue,  3 Nov 2026 03:55:15 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A5157E8; Tue,  3 Nov 2026 03:55:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL 02/16] scsi-disk: refresh the cached capacity from the resize
 callback
Date: Mon,  2 Nov 2026 21:54:13 -0600
Message-ID: <20261103035506.2688772-20-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

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
Message-ID: <20260812121500.1034178-3-den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/scsi/scsi-disk.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6341089ddf2..de2b6d85da8 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2398,13 +2398,10 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
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
@@ -2412,6 +2409,15 @@ static void scsi_disk_reset(DeviceState *dev)
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
@@ -2437,6 +2443,8 @@ static void scsi_disk_resize_cb(void *opaque)
 {
     SCSIDiskState *s = opaque;

+    scsi_disk_refresh_max_lba(s);
+
     /* SPC lists this sense code as available only for
      * direct-access devices.
      */
-- 
2.56.0


