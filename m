Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23102CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjgE-0006Gr-5e; Wed, 20 May 2026 12:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjg1-0005tg-Ri
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfy-00004s-FQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rh+D13MdvJVkOTBp6eV6osngprsspgL1DvUUlZVCbaw=;
 b=X07psBqqc3EEV+aNd5ML0UCP3zdAm/AFOjmsWKOJWx5HY/6jb/wHxIlEzIJnnOQYBTQ6hU
 uLm3gmn4uoKTjc1bW65ntRK7ZPjbNmHY2bAv3JAtmHPLUrQ6Ju93tUtw6+ToFxWJHmQBJq
 BtJc357H5LVn1uSNqHd5H+PJ786+lDI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-W4Hww0DIP1eAZNbob2fsuw-1; Wed,
 20 May 2026 12:21:37 -0400
X-MC-Unique: W4Hww0DIP1eAZNbob2fsuw-1
X-Mimecast-MFC-AGG-ID: W4Hww0DIP1eAZNbob2fsuw_1779294096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01BD18005B8; Wed, 20 May 2026 16:21:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B45DE19560A2; Wed, 20 May 2026 16:21:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/11] vfio/ap: Return false when IRQ notifier setup fails
Date: Wed, 20 May 2026 18:21:11 +0200
Message-ID: <20260520162115.1613601-8-clg@redhat.com>
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vfio_ap_register_irq_notifier() cleans up the fd handler and EventNotifier
when vfio_device_irq_set_signaling() fails, but still returns true to its
caller.

Return false after cleanup so the caller can handle the failed
registration path instead of treating it as a successful notifier setup.

Fixes: cbd470f0aac5 ("vfio/ap: Make vfio_ap_register_irq_notifier() return a bool")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260510084353.58263-2-zhaoguohan@kylinos.cn
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 276ae8c207bf2a1d7a0d5c0fc7f2ef98cec695d1..6e2a1223ea8d9ea0697d1f29ae746cf39419cde0 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -193,6 +193,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                        errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vapdev);
         event_notifier_cleanup(notifier);
+        return false;
     }
 
     return true;
-- 
2.54.0


