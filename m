Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C382C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSeV-0006Yt-EY; Thu, 17 Jul 2025 13:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDi-0006pE-Ix
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ucQDd-00028F-EL
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752764900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2Bf86os9SSI0e5+gs1+aDE+pC3O9YFtF/ov/MW6nrA=;
 b=Z6ds5+J0hTqOhJ6qyZSniw400WpZ3tXqedg6qWeTDteQPruceUfCzntjnvLS0q/JX3zqeO
 7kbDtyVGufpULNk+tZPg51t9vNFJw7JZ/tUk1IszMs52mPy17+xtN47oFP5KYQ3waiGPgj
 95AEqScTkysmgWdq2a8M7tGTqf/6icA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-w47qddlQOE-cDo5LHL4_Fw-1; Thu,
 17 Jul 2025 11:08:18 -0400
X-MC-Unique: w47qddlQOE-cDo5LHL4_Fw-1
X-Mimecast-MFC-AGG-ID: w47qddlQOE-cDo5LHL4_Fw_1752764898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9225195FE11
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 15:08:17 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 503F818003FC; Thu, 17 Jul 2025 15:08:16 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 4/6] net/passt: Check return value of g_remove() in
 net_passt_cleanup() (CID 1612369)
Date: Thu, 17 Jul 2025 17:08:03 +0200
Message-ID: <20250717150805.1344034-5-lvivier@redhat.com>
In-Reply-To: <20250717150805.1344034-1-lvivier@redhat.com>
References: <20250717150805.1344034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
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

If g_remove() fails, use warn_report() to log an error.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 net/passt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/passt.c b/net/passt.c
index ef59d0682be1..43c336e5968c 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -103,7 +103,10 @@ static void net_passt_cleanup(NetClientState *nc)
 #endif
 
     kill(s->pid, SIGTERM);
-    g_remove(s->pidfile);
+    if (g_remove(s->pidfile) != 0) {
+        warn_report("Failed to remove passt pidfile %s: %s",
+                    s->pidfile, strerror(errno));
+    }
     g_free(s->pidfile);
     g_ptr_array_free(s->args, TRUE);
 }
-- 
2.49.0


