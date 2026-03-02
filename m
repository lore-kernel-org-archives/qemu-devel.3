Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA43DE9B371
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2Tm-0004nX-MS; Mon, 02 Mar 2026 07:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Tk-0004mJ-IZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Tj-0005yM-2W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772454866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tziAZ1N/0eyP13+sACHlLrdutEwgbzNrSyw4EPjfTo4=;
 b=ZeC2chbvUwWXJa6+ERSKLqlC71bf6TnhhfTSkjNxLR9xQFbHjAsSq34d6fkis8AtOXzdGT
 qf+fDrLw8nuW7nT7TTQsOK3qZ9APJ/otv+0etUIjOg7VxRHRWYmeqLteMm1BtWW9zVgqyE
 6ek55lWW5hq3Iuw7zgW/Hb2/vHfAFkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-BgNMhUOIMWKJyyZGfolBxw-1; Mon,
 02 Mar 2026 07:34:23 -0500
X-MC-Unique: BgNMhUOIMWKJyyZGfolBxw-1
X-Mimecast-MFC-AGG-ID: BgNMhUOIMWKJyyZGfolBxw_1772454861
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F3B91800352; Mon,  2 Mar 2026 12:34:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BD741956053; Mon,  2 Mar 2026 12:34:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Aby Sam Ross <abysamross@ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: [PULL 01/10] s390x/pci: prevent null pointer dereference during zpci
 hot unplug
Date: Mon,  2 Mar 2026 13:34:04 +0100
Message-ID: <20260302123413.274700-2-thuth@redhat.com>
In-Reply-To: <20260302123413.274700-1-thuth@redhat.com>
References: <20260302123413.274700-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Aby Sam Ross <abysamross@ibm.com>

vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize()`)
if the vfio group file in `/dev/vfio/` lacks appropriate permissions and the
hostdev[/properties] addition doesn't reach the point where it could be
associated with previously added zpci device (in `s390_pcihost_plug()`).
As a result, zpci iommu pointer remains null. The zpci hot unplug following the
failed hostdev addition assumes zpci iommu pointer was assigned and tries to
make use of it to end the dma count resulting in a null pointer dereference.
In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not called
after hostdev addition failure and this issue is not encountered.

All other uses of zpci iommu without null check happens after both the zpci and
hostdev(pci) devices are plugged and are safe from null dereference.

Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")

Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <b45cefc3147c2c8446772dab0f53d030fb92406a.1770963150.git.abysamross@ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b438d63c444..3166b91c461 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1248,7 +1248,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
-        if (pbdev->iommu->dma_limit) {
+        if (pbdev->iommu && pbdev->iommu->dma_limit) {
             s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
         }
         qdev_unrealize(dev);
-- 
2.53.0


