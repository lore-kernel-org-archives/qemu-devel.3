Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E5EC35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutKH-0008Qo-Gz; Wed, 19 Mar 2025 09:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKA-0008QF-DO
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutK8-0007bO-MC
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742390347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73QJOaVMEeXkzzjEzDUheWqYDMqAQiwM38cP8w16Fyg=;
 b=GyfCF1ZjJqBr/8hQUxqUK8uLgQ9AG8O05Xnzrq/InSLWYvbeziPqFwTiqI3wKQDJoY2s9/
 6G9fweYpFaFp4DMelXSip8RJUO8HaknfQqL780V8fDFaUyAjRCRJ+AYBVNPg5fkDvvGLgR
 EbP2X7EJjHkk/r9aCCTvJMqRbQQOuvA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-qmUs4lEmPaGcmmNlt-QTcQ-1; Wed,
 19 Mar 2025 09:19:04 -0400
X-MC-Unique: qmUs4lEmPaGcmmNlt-QTcQ-1
X-Mimecast-MFC-AGG-ID: qmUs4lEmPaGcmmNlt-QTcQ_1742390343
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 915FE19560B6; Wed, 19 Mar 2025 13:19:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.212])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEC8F3001D0E; Wed, 19 Mar 2025 13:18:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/8] hw/virtio: Also include md stubs in case CONFIG_VIRTIO_PCI
 is not set
Date: Wed, 19 Mar 2025 14:18:44 +0100
Message-ID: <20250319131851.148817-2-thuth@redhat.com>
In-Reply-To: <20250319131851.148817-1-thuth@redhat.com>
References: <20250319131851.148817-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

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
Message-ID: <20250313063522.1348288-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/virtio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 19b04c4d9cc..164f6fd995a 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -90,7 +90,8 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
-system_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-md-stubs.c'))
+system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
+              if_false: files('virtio-md-stubs.c'))
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-- 
2.48.1


