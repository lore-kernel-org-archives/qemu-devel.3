Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1577FC36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVWc-0006b1-KF; Tue, 17 Sep 2024 06:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVw-0006BA-Jd
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVu-0006mu-UC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HE4LPiIytCKu+JhxwChIGIhq1x6MX/XG0Gp6icN+mLY=;
 b=erfBVMXKmHoEJDVt6rWFNdlCaa2I+tHM2TcyZDmfeZGSQI7gd2mkoeCMN0kv2fsp+H96/d
 +NI1/n1/f1GnfkZKaXDpg8h9ryCXG2KFwwJD2r2AKFQ1PXTzGuOX7suG9iOZJAJ8jnIHZc
 cbcTFOjFAGaqHOBT/G1eJyZbvcUCTTA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-YgwbVuPPO1yMbN49vohlEg-1; Tue,
 17 Sep 2024 06:32:49 -0400
X-MC-Unique: YgwbVuPPO1yMbN49vohlEg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C14A1955F41; Tue, 17 Sep 2024 10:32:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA64D19560AA; Tue, 17 Sep 2024 10:32:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PULL 7/8] vfio/igd: don't set stolen memory size to zero
Date: Tue, 17 Sep 2024 12:32:28 +0200
Message-ID: <20240917103229.876515-8-clg@redhat.com>
In-Reply-To: <20240917103229.876515-1-clg@redhat.com>
References: <20240917103229.876515-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Corvin Köhne <corvin.koehne@gmail.com>

The stolen memory is required for the GOP (EFI) driver and the Windows
driver. While the GOP driver seems to work with any stolen memory size,
the Windows driver will crash if the size doesn't match the size
allocated by the host BIOS. For that reason, it doesn't make sense to
overwrite the stolen memory size. It's true that this wastes some VM
memory. In the worst case, the stolen memory can take up more than a GB.
However, that's uncommon. Additionally, it's likely that a bunch of RAM
is assigned to VMs making use of GPU passthrough.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/igd.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 8a41b16421b425688dd2cacd3a113efbad82e91b..0751c43eae04aac5152c627af648319151ee1e39 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -478,6 +478,23 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
 
+static int igd_get_stolen_mb(int gen, uint32_t gmch)
+{
+    int gms;
+
+    if (gen < 8) {
+        gms = (gmch >> 3) & 0x1f;
+    } else {
+        gms = (gmch >> 8) & 0xff;
+    }
+
+    if (gms > 0x10) {
+        error_report("Unsupported IGD GMS value 0x%x", gms);
+        return 0;
+    }
+    return gms * 32;
+}
+
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
@@ -655,23 +672,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         ggms_mb = 1 << ggms_mb;
     }
 
-    /*
-     * Assume we have no GMS memory, but allow it to be overridden by device
-     * option (experimental).  The spec doesn't actually allow zero GMS when
-     * when IVD (IGD VGA Disable) is clear, but the claim is that it's unused,
-     * so let's not waste VM memory for it.
-     */
-    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
-
-    if (vdev->igd_gms) {
-        if (vdev->igd_gms <= 0x10) {
-            gms_mb = vdev->igd_gms * 32;
-            gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
-        } else {
-            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
-            vdev->igd_gms = 0;
-        }
-    }
+    gms_mb = igd_get_stolen_mb(gen, gmch);
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
-- 
2.46.0


