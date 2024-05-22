Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22965C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLN-0000UD-Ff; Wed, 22 May 2024 13:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLL-0000Sq-5X
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLC-0006HV-6w
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbSsdzriH3JaD7MJWAnTg9+wWX6VXaSHyl3vXa1NFWA=;
 b=Oc5qgTfjXSgUwFJ7IHkgQQX1tMppVSPekxLytvZbsj6tEOCabd/d1swpHNuYW3wXALMWub
 bKmPIXNVKpAqiSDuAeuNU5Bc3iljwpvHf9ntGCLFfdEr41V4YRbBXo/Qd0pWlpSWn8+QQB
 rQWomdzaLnWwnHDmVjcWthjDk4nyY+s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-cNKsTyMuP6yXEaZr7Y8Zqw-1; Wed,
 22 May 2024 13:01:20 -0400
X-MC-Unique: cNKsTyMuP6yXEaZr7Y8Zqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F11A1C0513B;
 Wed, 22 May 2024 17:01:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 452E15618;
 Wed, 22 May 2024 17:01:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 6/7] vfio/ccw: Fix the missed unrealize() call in error path
Date: Wed, 22 May 2024 19:01:06 +0200
Message-ID: <20240522170107.289532-7-clg@redhat.com>
In-Reply-To: <20240522170107.289532-1-clg@redhat.com>
References: <20240522170107.289532-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When get name failed, we should call unrealize() so that
vfio_ccw_realize() is self contained.

Fixes: 909a6254eda ("vfio/ccw: Make vfio cdev pre-openable by passing a file handle")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index a468fa2342b97e0ee36bd5fb8443025cc90a0453..36f2677a448c5e31523dcc3de7d973ec70e4a13c 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -588,7 +588,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vfio_device_get_name(vbasedev, errp)) {
-        return;
+        goto out_unrealize;
     }
 
     if (!vfio_attach_device(cdev->mdevid, vbasedev,
@@ -631,6 +631,7 @@ out_region_err:
     vfio_detach_device(vbasedev);
 out_attach_dev_err:
     g_free(vbasedev->name);
+out_unrealize:
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
     }
-- 
2.45.1


