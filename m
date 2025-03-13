Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1345C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscAR-0006t1-Si; Thu, 13 Mar 2025 02:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tscAK-0006rC-Ue
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tscAH-00031Z-10
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741847729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=s99+ouuPN7r+2c8Q9iMIbp6v8P1XGwnB/Z/pWYYCAkU=;
 b=FciLiDgEPFF1QWdmU2mVztnmG2TX+5o7m3kUp5xb05F05XIiRkCwqAJ5ynGvf5KLFKXBXs
 iqSYdqbza1tFk7kv4e9y/temPEV5VS0G7dYetCtuMCq5xWkCxCR0STlJsu4GtylTQdmk+6
 oJqRt60352ulNG7rPljuEg/3ZDb7vZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-56CLEeVoNpiA6s7XlZq2og-1; Thu,
 13 Mar 2025 02:35:28 -0400
X-MC-Unique: 56CLEeVoNpiA6s7XlZq2og-1
X-Mimecast-MFC-AGG-ID: 56CLEeVoNpiA6s7XlZq2og_1741847727
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BFB61800361
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 06:35:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D52D1955BCB; Thu, 13 Mar 2025 06:35:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/virtio: Also include md stubs in case CONFIG_VIRTIO_PCI is
 not set
Date: Thu, 13 Mar 2025 07:35:22 +0100
Message-ID: <20250313063522.1348288-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

For the s390x target, it's possible to build the QEMU binary without
CONFIG_VIRTIO_PCI and only have the virtio-mem device via the ccw
transport. In that case, QEMU currently fails to link correctly:

 /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_pre_plug':
 ../hw/s390x/s390-virtio-ccw.c:579:(.text+0x1e96): undefined reference to `virtio_md_pci_pre_plug'
 /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_plug':
 ../hw/s390x/s390-virtio-ccw.c:608:(.text+0x21a4): undefined reference to `virtio_md_pci_plug'
 /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_unplug_request':
 ../hw/s390x/s390-virtio-ccw.c:622:(.text+0x2334): undefined reference to `virtio_md_pci_unplug_request'
 /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_unplug':
 ../hw/s390x/s390-virtio-ccw.c:633:(.text+0x2436): undefined reference to `virtio_md_pci_unplug'
 clang: error: linker command failed with exit code 1 (use -v to see invocation)

We also need to include the stubs when CONFIG_VIRTIO_PCI is missing.

Fixes: aa910c20ec5 ("s390x: virtio-mem support")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index a5f9f7999dd..cdb1836580d 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -89,7 +89,8 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
-system_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-md-stubs.c'))
+system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
+              if_false: files('virtio-md-stubs.c'))
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-- 
2.48.1


