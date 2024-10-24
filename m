Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0856CE8E73
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 13:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3xVl-000695-6e; Thu, 24 Oct 2024 09:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3xVi-000685-0Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 09:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3xVf-0004IE-OT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 09:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729775054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ueq/gBGxSMoZ7D6unLbmY3sy7nVg75uDlXSCadUqSg0=;
 b=SXBXeNAw0hFhz+2QXS2hE/gZYm2whnQmp01kZVuLS0mIXx8vHPHred+gDdFiv1EwiUS77V
 Ur38FMauyvZeQ9oo96W1QM5cEjudNImwryebaou4tgHNGzptTv2VkRNWEu5UV4z9+GQ/Ig
 BTG3C1EAzwXllc5xuhySvrZ514gD4XU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-vu_rRhHqOQK5784BtAanMw-1; Thu,
 24 Oct 2024 09:04:11 -0400
X-MC-Unique: vu_rRhHqOQK5784BtAanMw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 796B91955F3F; Thu, 24 Oct 2024 13:04:09 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E17D11956088; Thu, 24 Oct 2024 13:04:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/s390x: Re-enable the pci-bridge device on s390x
Date: Thu, 24 Oct 2024 15:04:05 +0200
Message-ID: <20241024130405.62134-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit e779e5c05a ("hw/pci-bridge: Add a Kconfig switch for the
normal PCI bridge") added a config switch for the pci-bridge, so
that the device is not included in the s390x target anymore (since
the pci-bridge is not really useful on s390x).

However, it seems like libvirt is still adding pci-bridge devices
automatically to the guests' XML definitions (when adding a PCI
device to a non-zero PCI bus), so these guests are now broken due
to the missing pci-bridge in the QEMU binary.

To avoid disruption of the users, let's re-enable the pci-bridge
device on s390x for the time being. We could maybe disable it later
again if libvirt does not add the pci-bridge device automatically
to the guests anymore in the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 3bbf4ae56e..82afdaa9dc 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -7,6 +7,7 @@ config S390_CCW_VIRTIO
     imply VFIO_AP
     imply VFIO_CCW
     imply WDT_DIAG288
+    imply PCI_BRIDGE
     imply PCIE_DEVICES
     imply IOMMUFD
     select PCI_EXPRESS
-- 
2.47.0


