Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444F1C44536
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuf-0004pL-AX; Tue, 21 Jul 2026 13:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuU-0004nI-Ei
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuT-00073l-0q
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blsxiSwTZBU9OljdnlSUcNjUJjFpLVjGvPU4TO4d0KE=;
 b=a4cG84OaVGZHGP87WI7NG01zNVj2cMMaX0yfKcRlSqEChcaCnfQF9NbBgPt0fsSq8vUN5D
 A+aHl6TGOoNNB5HUtsCeuKsYVq6T5ZDGIIxXe56I+gYhI4RLwHcl8hhlBhECzBgsTU45Vx
 NsZbHy05HmqS1og4JTM6MO2eohKZKDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-qvl-g8nAOjC13Gfeg_-Jdw-1; Tue,
 21 Jul 2026 13:05:33 -0400
X-MC-Unique: qvl-g8nAOjC13Gfeg_-Jdw-1
X-Mimecast-MFC-AGG-ID: qvl-g8nAOjC13Gfeg_-Jdw_1784653532
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDFAB19774F7; Tue, 21 Jul 2026 17:05:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AC4F1599; Tue, 21 Jul 2026 17:05:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/13] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Date: Tue, 21 Jul 2026 19:05:10 +0200
Message-ID: <20260721170518.4160785-6-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

If the vfio-user responds with a value large enough such that adding
the header size to it overflows, a smaller buffer would be
inadvertently allocated, leading to buffer overflow.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3867
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-2-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index b8d2b7c1a84bb1914a71fdccbbdff675373cef3b..e58167a81879e94520bda24717280e2347422e77 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -128,12 +128,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
         error_printf("vfio_user_get_region_info argsz too small\n");
         return -E2BIG;
     }
+
+    /*
+     * Ensure that size doesn't overflow, otherwise we'll allocate a much
+     * smaller buffer than we need.
+     */
+    if (__builtin_add_overflow(info->argsz, sizeof(VFIOUserHdr), &size)) {
+        error_printf("vfio_user_get_region_info argsz too large\n");
+        return -E2BIG;
+    }
+
     if (fds != NULL && fds->send_fds != 0) {
         error_printf("vfio_user_get_region_info can't send FDs\n");
         return -EINVAL;
     }
 
-    size = info->argsz + sizeof(VFIOUserHdr);
     msgp = g_malloc0(size);
 
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
-- 
2.55.0


