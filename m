Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24394606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ru0AzpYq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZGY-0005zQ-4L; Thu, 29 Oct 2026 19:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMZGH-0005pP-9y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMZGF-0004vL-81
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793315417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6BP07/9Ge9TgRpSTb8fwLZ1S03ijWtG/KBKK1t/z0s=;
 b=Ru0AzpYqgwmYQ2UQmjY5iJlb5gaMbulRTE2apb/+v/QCS1Iqkt26e4HMHouMN3D6/Cw8Cj
 qNofEuF8PMUZFUJk5iu/impV0GGXcfxtKW1+zuqhp/Km3RsHULMuchZIBhgCDu7f3Wtdk5
 oKJ9bOYZYiGvde+aGPNi1mocQxBT8Rs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-wA-veBt3PQiTh5hnMlQEDw-1; Thu,
 29 Oct 2026 19:10:15 -0400
X-MC-Unique: wA-veBt3PQiTh5hnMlQEDw-1
X-Mimecast-MFC-AGG-ID: wA-veBt3PQiTh5hnMlQEDw_1793315414
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86EE4195BDD0; Thu, 29 Oct 2026 23:10:14 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 847ED30002CB; Thu, 29 Oct 2026 23:10:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] virtio-blk: Deprecate silent truncation of serial
Date: Fri, 30 Oct 2026 00:10:00 +0100
Message-ID: <20261029231001.194240-4-kwolf@redhat.com>
In-Reply-To: <20261029231001.194240-1-kwolf@redhat.com>
References: <20261029231001.194240-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit a8686a9b, which made serial a qdev property instead of relying on
-drive options, accidentally allowed specifying serial strings of
arbitraty length while the virtio-blk protocol can only communicate 20
characters to the guest. This means that a longer serial number on the
command line is silently truncated to 20 characters from the guest
perspective.

This is obviously bad behaviour. People are specifying longer serials in
practice and guests will see something different than what was
configured. Instead of silent truncation, this should be an error.

Deprecate the silent truncation for now as a first step towards making
it an error later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 hw/block/virtio-blk.c     |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dab47b6ca38..0891bbc44de 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -362,6 +362,19 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
+``-device virtio-blk,serial=more_than_20_characters`` (since 11.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``virtio-blk`` device has a limitation of 20 characters for the serial
+string. Accidentally, QEMU started accepting longer strings on the command line
+in version 0.15.0, but it was still silently truncated to 20 characters for
+guests.
+
+Specifying a longer serial than can be exposed to the guest is a configuration
+error and deprecated; it will become a hard error in later versions. If the
+truncation is intentional, explicitly specify the serial already in truncated
+form on the command line instead.
+
 Block device options
 ''''''''''''''''''''
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 3f236f22d57..eeeb405127c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1849,6 +1849,12 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (conf->serial && strlen(conf->serial) > VIRTIO_BLK_ID_BYTES) {
+        warn_report("serial is longer than %d characters and will be truncated "
+                    "for the guest. This configuration is deprecated.",
+                    VIRTIO_BLK_ID_BYTES);
+    }
+
     if (!blkconf_apply_backend_options(&conf->conf,
                                        !blk_supports_write_perm(conf->conf.blk),
                                        true, errp)) {
-- 
2.56.0


