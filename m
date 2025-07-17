Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FCDC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSdo-0005pw-4S; Thu, 17 Jul 2025 13:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDh-0006p4-Lj
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDb-00027d-C9
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752764894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBQX4oHEyEVSgUlx/4xDvO7ZYEg0OgUmDIvJpF3hZz8=;
 b=UHjRVohOD0RBAgl7IiM05Y8S05yQXdZwWWGiYERO745LUcP5KgQ7Binj4j+f3qUNhN7192
 fuCn6jEh+hZTd/F7EONGwHMPwzFJ8Jvg9QzJV9Vym6htFzQ84T04hG+9rzW7vTuPd4B7B7
 8lk774NN9wjeqWpCo93ebhkb4JkMSrs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-3ttw-xoLMLaU-MQ083qRKQ-1; Thu,
 17 Jul 2025 11:08:12 -0400
X-MC-Unique: 3ttw-xoLMLaU-MQ083qRKQ-1
X-Mimecast-MFC-AGG-ID: 3ttw-xoLMLaU-MQ083qRKQ_1752764891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66FCA195608B
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 15:08:11 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B92D318003FC; Thu, 17 Jul 2025 15:08:09 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/6] net/passt: Remove unused "err" from
 passt_vhost_user_event() (CID 1612375)
Date: Thu, 17 Jul 2025 17:08:00 +0200
Message-ID: <20250717150805.1344034-2-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-1-lvivier@redhat.com>
References: <20250717150805.1344034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "err" variable was declared but never used within the
passt_vhost_user_event() function. This resulted in a dead code
warning (CID 1612375) from Coverity.

Remove the unused variable and the associated error block
to resolve the issue.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/passt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 6f616ba3c258..9cd5b3e6f2af 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -397,7 +397,6 @@ err:
 static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
 {
     NetPasstState *s = opaque;
-    Error *err = NULL;
 
     switch (event) {
     case CHR_EVENT_OPENED:
@@ -428,10 +427,6 @@ static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
         /* Ignore */
         break;
     }
-
-    if (err) {
-        error_report_err(err);
-    }
 }
 
 static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
-- 
2.49.0


