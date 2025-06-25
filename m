Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF31C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 08:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uULUl-00054y-I6; Wed, 25 Jun 2025 04:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uULUT-00053u-Kf
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uULUQ-00060n-C3
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 04:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750840096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5AUAYcGfRWYprJv275nmuF6gbXK19rGN9VLixUtbHGc=;
 b=YCLXDmN/5NR/gMz67GwlOoF4PF/Dazy9r/+vxcYgooAHkLZk0I6hJEUKmEOYWd5ajyjIP+
 zLtCKlbAZZrM04zwoYj8XxYUZWk3d+0MlWmMNx5lToM34tL/3vqt1XgOh8r+Y4OvPv2gM9
 hfD0BAU3T2awhjfoU0ID7Aw56QOAmcQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-dYGy9erBOK6W4Gz6e69bxQ-1; Wed,
 25 Jun 2025 04:28:11 -0400
X-MC-Unique: dYGy9erBOK6W4Gz6e69bxQ-1
X-Mimecast-MFC-AGG-ID: dYGy9erBOK6W4Gz6e69bxQ_1750840089
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F8EC180121D; Wed, 25 Jun 2025 08:28:09 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.230])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3F95180045B; Wed, 25 Jun 2025 08:28:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, qemu-s390x@nongnu.org,
 qemu-trivial@nongnu.org
Subject: [PATCH] hw/s390x/ccw-device: Fix memory leak in loadparm setter
Date: Wed, 25 Jun 2025 10:27:51 +0200
Message-ID: <20250625082751.24896-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit bdf12f2a fixed the setter for the "loadparm" machine property,
which gets a string from a visitor, passes it to s390_ipl_fmt_loadparm()
and then forgot to free it. It left another instance of the same problem
unfixed in the "loadparm" device property. Fix it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/s390x/ccw-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 19c2238f76..8be1813b9e 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -57,7 +57,7 @@ static void ccw_device_set_loadparm(Object *obj, Visitor *v,
                                  Error **errp)
 {
     CcwDevice *dev = CCW_DEVICE(obj);
-    char *val;
+    g_autofree char *val = NULL;
     int index;
 
     index = object_property_get_int(obj, "bootindex", NULL);
-- 
2.49.0


