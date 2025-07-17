Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C68DC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSjy-0001We-VE; Thu, 17 Jul 2025 13:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDg-0006nR-2J
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDb-00027x-56
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752764898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdmYQyp1if23DWfbBGI3waNotU+eaTtpUKnbCvSdG7U=;
 b=AxVc3lEK++hUopWYuKR/rTfwHe1fner0WiVWmj4URe0BSyamLHJpODjsFmxhLB9gJzEGQj
 rlVJuJ9MWMdv8kP6DB3zWSIhYqM3br3aCCwg7/HowOX4d5ZzQZ+izh0vmY2NjiejixXMOn
 YALZPRqStOLcAeJq7jcFPMKSBZ9EAiI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-meiAwj9GPeWJfLskkZfyCQ-1; Thu,
 17 Jul 2025 11:08:16 -0400
X-MC-Unique: meiAwj9GPeWJfLskkZfyCQ-1
X-Mimecast-MFC-AGG-ID: meiAwj9GPeWJfLskkZfyCQ_1752764895
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CADA619560A5
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 15:08:15 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A53118003FC; Thu, 17 Jul 2025 15:08:13 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 3/6] net/passt: Remove dead code in passt_vhost_user_start
 error path (CID 1612371)
Date: Thu, 17 Jul 2025 17:08:02 +0200
Message-ID: <20250717150805.1344034-4-lvivier@redhat.com>
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

In passt_vhost_user_start(), if vhost_net_init() fails, the "net"
variable is NULL and execution jumps to the "err:" label.

The cleanup code within this label is conditioned on "if (net)",
which can never be true in this error case. This makes the cleanup
block dead code, as reported by Coverity (CID 1612371).

Refactor the error handling to occur inline, removing the goto and
the unreachable cleanup block.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/passt.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 9cd5b3e6f2af..ef59d0682be1 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -375,7 +375,8 @@ static int passt_vhost_user_start(NetPasstState *s, VhostUserState *be)
     net = vhost_net_init(&options);
     if (!net) {
         error_report("failed to init passt vhost_net");
-        goto err;
+        passt_vhost_user_stop(s);
+        return -1;
     }
 
     if (s->vhost_net) {
@@ -385,13 +386,6 @@ static int passt_vhost_user_start(NetPasstState *s, VhostUserState *be)
     s->vhost_net = net;
 
     return 0;
-err:
-    if (net) {
-        vhost_net_cleanup(net);
-        g_free(net);
-    }
-    passt_vhost_user_stop(s);
-    return -1;
 }
 
 static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
-- 
2.49.0


