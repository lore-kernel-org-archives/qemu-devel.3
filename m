Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FD606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UReBqFkF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMD1A-0001Wq-If; Wed, 28 Oct 2026 19:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMD0W-0001Oo-To
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMD0R-0003dL-RZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793229871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7wcCyMnE0ybIqXxztZ2I401lo+Dxwjs4srTlRXQncw=;
 b=UReBqFkF2gg/C2Vok6K5Z4e8/phTKZlPIot5AbnjALryXzHshraw1MWN6s4yOrZW/Jn42O
 4E+o1f8h6ewtm5iIzNqG9eLcgCqNnYRXGylTDCC7AobkGe9kzYUgrHzrWdJC9YFPjpC1LP
 zrVp82qJyvf9QDZyS1nETujm09OaB1c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-_A76uZUBM0uYUymabMa8BQ-1; Wed,
 28 Oct 2026 19:24:24 -0400
X-MC-Unique: _A76uZUBM0uYUymabMa8BQ-1
X-Mimecast-MFC-AGG-ID: _A76uZUBM0uYUymabMa8BQ_1793229862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5D951955F61; Wed, 28 Oct 2026 23:24:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDF9B180057F; Wed, 28 Oct 2026 23:24:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: [PATCH 4/5] virtio-blk: Represent truncated serial in qdev property
Date: Thu, 29 Oct 2026 00:23:59 +0100
Message-ID: <20261028232400.222535-5-kwolf@redhat.com>
In-Reply-To: <20261028232400.222535-1-kwolf@redhat.com>
References: <20261028232400.222535-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

If the guest can only see the first 20 characters of the serial, we
shouldn't pretend to have a longer string in the 'serial' qdev property
(which is visible through things like QOM or 'info qtree').

Truncate the serial already in the internal state of the device to make
sure we don't mix both versions anywhere.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index eeeb405127c..cecd08a2f2e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1850,9 +1850,15 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (conf->serial && strlen(conf->serial) > VIRTIO_BLK_ID_BYTES) {
+        char *truncated;
+
         warn_report("serial is longer than %d characters and will be truncated "
                     "for the guest. This configuration is deprecated.",
                     VIRTIO_BLK_ID_BYTES);
+
+        truncated = g_strndup(conf->serial, VIRTIO_BLK_ID_BYTES);
+        g_free(conf->serial);
+        conf->serial = truncated;
     }
 
     if (!blkconf_apply_backend_options(&conf->conf,
-- 
2.56.0


