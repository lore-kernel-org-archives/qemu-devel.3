Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72005C83F27
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjck-0002Fj-2i; Mon, 21 Jul 2025 02:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZJ-0008Lg-Lt
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZG-0006MO-R2
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mh9zgTuIoXCQjyZZkCH0tnuUy6UVCPeMbjt+eCrmLnY=;
 b=CX0+o5jFQRUGLOaROC5zHmJx4Eb6gJYAll8gu2CdNK9cnr4kZff01/r/ESTH2o94h/h2PE
 Mek8moNUwG5l8xq/RCj4cnqMxRjSZAG3T/blmF5WrxhC7w18qktsvMplwRhvqvsZCzpH9A
 tV5DUsfOhijF+QuTzNg4B8UpnEGIVLM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-378weybHM0KAD52fy4sa0g-1; Mon,
 21 Jul 2025 02:00:02 -0400
X-MC-Unique: 378weybHM0KAD52fy4sa0g-1
X-Mimecast-MFC-AGG-ID: 378weybHM0KAD52fy4sa0g_1753077601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87F8B195FCC2; Mon, 21 Jul 2025 06:00:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31CC5195608D; Mon, 21 Jul 2025 05:59:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 09/12] net/passt: Remove dead code in passt_vhost_user_start
 error path (CID 1612371)
Date: Mon, 21 Jul 2025 13:59:24 +0800
Message-ID: <20250721055927.75951-10-jasowang@redhat.com>
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

In passt_vhost_user_start(), if vhost_net_init() fails, the "net"
variable is NULL and execution jumps to the "err:" label.

The cleanup code within this label is conditioned on "if (net)",
which can never be true in this error case. This makes the cleanup
block dead code, as reported by Coverity (CID 1612371).

Refactor the error handling to occur inline, removing the goto and
the unreachable cleanup block.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/passt.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index 9cd5b3e6f2..ef59d0682b 100644
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
2.42.0


