Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AA0C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ih4-0003a2-BH; Wed, 22 May 2024 05:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igv-0003Tg-3J
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igr-0001eE-PV
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBxnSmYQ7sV1y/gKpXlFsOBwVTzLl/e3739ed4f2Da4=;
 b=YEeIFcBHU0CxNGxT9eqWoO1SpWEZWegXZBe1jfoqxJntZVE3lDAowrpw71g149iYSOPL5V
 8cqOn4WC8k6zssnrKeteHspShihhl7c2yqkWnTAOEhk7dX+aH+duyFzNKutkepJkSdamLU
 cB27EwMzvM1kRHv5qGgsPbq5w2brUl0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-NNT2iThIPxOlFgsKgZMQqg-1; Wed, 22 May 2024 05:55:17 -0400
X-MC-Unique: NNT2iThIPxOlFgsKgZMQqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 845188058D5;
 Wed, 22 May 2024 09:55:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 605207412;
 Wed, 22 May 2024 09:55:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/47] vfio/pci: Use g_autofree in vfio_realize
Date: Wed, 22 May 2024 11:54:14 +0200
Message-ID: <20240522095442.195243-20-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Local pointer name is allocated before vfio_attach_device() call
and freed after the call.

Same for tmp when calling realpath().

Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b5d1d398b120076c85cdd92d61793393f65e8554..84f7bff664fd7595b75cce1f6974068144f0d42d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2972,12 +2972,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    char *tmp, *subsys;
+    char *subsys;
     Error *err = NULL;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
-    char *name;
+    g_autofree char *name = NULL;
+    g_autofree char *tmp = NULL;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3008,7 +3009,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
      */
     tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
     subsys = realpath(tmp, NULL);
-    g_free(tmp);
     is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
     free(subsys);
 
@@ -3029,7 +3029,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     ret = vfio_attach_device(name, vbasedev,
                              pci_device_iommu_address_space(pdev), errp);
-    g_free(name);
     if (ret) {
         goto error;
     }
-- 
2.45.1


