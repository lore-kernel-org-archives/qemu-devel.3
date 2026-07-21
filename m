Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AEEC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuy-0004sO-M0; Tue, 21 Jul 2026 13:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDud-0004pF-GK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDub-00075G-9F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72LDf8tRSV+qu76UEUgi0OAWOeK8FqkegTE9xqDiYgM=;
 b=JwRazvoZGXhqRwOoOj6O0hoG5S6zMO3/EKqDLiEwXuHfl8vtjw3eF1ESAltttnd7VrSzZG
 uV6RcmBdELdu0nViQFl2bVY6VIFevoVy/VBfCGJA+fXNE0jeVMXZY4AvWiOVVU/sDG7Reh
 dEMwzi7c0t3Iv+8kv1XpQ8OS/csf2R8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-NHl82gxxMlmst1EFAIGg5Q-1; Tue,
 21 Jul 2026 13:05:40 -0400
X-MC-Unique: NHl82gxxMlmst1EFAIGg5Q-1
X-Mimecast-MFC-AGG-ID: NHl82gxxMlmst1EFAIGg5Q_1784653539
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFBB4180ABD8; Tue, 21 Jul 2026 17:05:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78EEE1599; Tue, 21 Jul 2026 17:05:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/13] vfio-user: vfio_user_device_io_get_region_info: fix
 capability check
Date: Tue, 21 Jul 2026 19:05:14 +0200
Message-ID: <20260721170518.4160785-10-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The existing check for PCI capabilities misses the case where
info->cap_offset == info->argsz, which results in accessing unallocated
memory. Fix the comparison.

Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3865
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-6-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 008e5cf6877c84c3d0cf33f25a6ac9a4cf231e06..3d0dbe840649b7b678b79afd3dbc7f9caaeb947b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -214,7 +214,8 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
 
     /* cap_offset in valid area */
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
-        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        (info->cap_offset < sizeof(*info)
+         || info->cap_offset + sizeof(struct vfio_info_cap_header) > info->argsz)) {
         return -EINVAL;
     }
 
-- 
2.55.0


