Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D9CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0H-0005bb-CF; Sat, 08 Nov 2025 18:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs07-0005Oy-St
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs06-0001fX-DE
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCGpzqyaIpdEcTcu0H10/jQddJp9T6PwX6q8xDmr93s=;
 b=CfpKqeQv7uJAT2R6zTppRWVYwuT3lUh14I/uinsUZe57cgT81Lzo6vwRaxTRY7gvVM1SaT
 cTn8I3bCuUuQ/LtYteahuckSYGCX2HcLELOPNyp2lF0COs9YQLyLPoKofNhwOf0ICCtEvC
 bzNUDVsWtJ8rq9tMFv9TByns8Xv6vNE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-FBuagGNNPziLgqmGhX4vCg-1; Sat,
 08 Nov 2025 18:05:40 -0500
X-MC-Unique: FBuagGNNPziLgqmGhX4vCg-1
X-Mimecast-MFC-AGG-ID: FBuagGNNPziLgqmGhX4vCg_1762643139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D084195605A; Sat,  8 Nov 2025 23:05:39 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79FD319560A7; Sat,  8 Nov 2025 23:05:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH v2 05/12] qio: Minor optimization when callback function is
 unchanged
Date: Sat,  8 Nov 2025 16:59:26 -0600
Message-ID: <20251108230525.3169174-19-eblake@redhat.com>
In-Reply-To: <20251108230525.3169174-14-eblake@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In qemu-nbd and other NBD server setups where parallel clients are
supported, it is common that the caller will re-register the same
callback function as long as it has not reached its limit on
simultaneous clients.  In that case, there is no need to tear down and
reinstall GSource watches in the GMainContext.

In practice, all callers currently pass NULL for notify, and no caller
ever changes context across calls (for async uses, either the caller
consistently uses qio_net_listener_set_client_func_full with the same
context, or the caller consistently uses only
qio_net_listener_set_client_func which always uses the global
context); but the time spent checking these two fields in addition to
the more important func and data is still less than the savings of not
churning through extra GSource manipulations when the result will be
unchanged.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: move later in series, also ensure notify and context are the same
---
 io/net-listener.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index 0f16b78fbbd..a9da8e4e069 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -148,6 +148,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;

+    if (listener->io_func == func && listener->io_data == data &&
+        listener->io_notify == notify && listener->context == context) {
+        return;
+    }
+
     trace_qio_net_listener_unwatch(listener, listener->io_func,
                                    listener->context, "set_client_func");

-- 
2.51.1


