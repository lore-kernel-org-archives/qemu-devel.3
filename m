Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759B5C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuz-0004si-Sl; Tue, 21 Jul 2026 13:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuf-0004pe-NI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDue-00075y-8N
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ir9B4jQffkIFCiCSvXqtyzQcTJDUup9v+RuKijd/L7k=;
 b=OT5FmwUZazeG7J6bWHYcDnpu5/wMGkvjtRwSfc3t2wi27aODNV/HFYjudpD4itAO4woVMx
 cCKvQJATZZyIwLLvboJ3P24NwDwTIE2H19EpMBn0rd7Q2416o+eUEuuaqoDtk6jn9Zo9+B
 0Y4b1YiKqdk5JXlI7JsciWcIUfTJnTA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-ajA9hPucNk6pPquoh1tg1A-1; Tue,
 21 Jul 2026 13:05:43 -0400
X-MC-Unique: ajA9hPucNk6pPquoh1tg1A-1
X-Mimecast-MFC-AGG-ID: ajA9hPucNk6pPquoh1tg1A_1784653543
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17E9B1800631; Tue, 21 Jul 2026 17:05:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D007C1598; Tue, 21 Jul 2026 17:05:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/13] vfio-user: vfio_user_device_io_device_feature: prevent
 excessive malloc
Date: Tue, 21 Jul 2026 19:05:16 +0200
Message-ID: <20260721170518.4160785-12-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Thanos Makatos <thanos.makatos@nutanix.com>

This isn't in practise a problem since feature->argsz is not externally
provided, it's a good hardening step nonetheless.

Fixes: e2358af5838d ("vfio-user: support VFIO_USER_DEVICE_FEATURE")
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-8-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 353fa5ee21e34a88bcd0eff9de40d9757387a616..8feaa568750ed1978dbc273da2054c89ad3bcc96 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -87,6 +87,10 @@ vfio_user_device_io_device_feature(VFIODevice *vbasedev,
         error_printf("vfio_user_device_io_device_feature argsz too large\n");
         return -E2BIG;
     }
+    if (size > proxy->max_xfer_size) {
+        error_printf("vfio_user_device_io_device_feature argsz too large\n");
+        return -E2BIG;
+    }
 
     msgp = g_malloc0(size);
 
-- 
2.55.0


