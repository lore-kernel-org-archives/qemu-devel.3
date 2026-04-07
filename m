Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BD7FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXb-0000HJ-7q; Tue, 07 Apr 2026 14:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1wABUI-0002o3-FB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w9yfz-0003Gr-1R
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 01:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775538514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoeNQxtF/zIAgTe2QQTqxNL1Ip1IeoMjvPuvUUHlKns=;
 b=QdB7nJlh3TaZPHzx9xfFy6TxMd70GJuIcdVBkiq4xgBHbedJjfCspp1MdCjpx41JW8oslv
 X3klOUD0LVT8VqK3n/+pbradVb9faN/OxenpE6Cy7CWSWJ79adHpCw24FOh4/q71/uL7iI
 tpinF/7CDOsnoBUK5W6T9/7+ID5SEZ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-gQulgg4ZPfmeiXVBxHMQJA-1; Tue,
 07 Apr 2026 01:08:30 -0400
X-MC-Unique: gQulgg4ZPfmeiXVBxHMQJA-1
X-Mimecast-MFC-AGG-ID: gQulgg4ZPfmeiXVBxHMQJA_1775538510
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E42111800365; Tue,  7 Apr 2026 05:08:29 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BCA01800361; Tue,  7 Apr 2026 05:08:26 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v4 1/5] net/filter: allow filters on vhost netdevs
Date: Tue,  7 Apr 2026 13:05:48 +0800
Message-ID: <20260407050818.2249570-2-lulu@redhat.com>
In-Reply-To: <20260407050818.2249570-1-lulu@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

netfilter_complete() currently rejects netdev backends backed by
vhost_net and returns "Vhost is not supported". The AF_PACKET
capture/inject chardev work still needs filter objects to sit on top
of the existing netdev when the tap queue is owned by vhost, so
remove this

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/filter.c b/net/filter.c
index 76345c1a9d..bb59785911 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -13,7 +13,6 @@
 
 #include "net/filter.h"
 #include "net/net.h"
-#include "net/vhost_net.h"
 #include "qom/object_interfaces.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
@@ -254,11 +253,6 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    if (get_vhost_net(ncs[0])) {
-        error_setg(errp, "Vhost is not supported");
-        return;
-    }
-
     if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
         Object *container;
         Object *obj;
-- 
2.52.0


