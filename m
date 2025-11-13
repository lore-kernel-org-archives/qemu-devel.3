Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799AACD4F2C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLyB-0003iS-4s; Wed, 12 Nov 2025 20:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLxC-0002eL-Cn
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLx9-0005ot-U2
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762996607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HM5oaVsmC5AOl56uV2/EDSNC6XKx/WmefwcpkerDYs=;
 b=VziTXrVs0Hsb7awpST5gp9aJl6LkS61i5J053ZVIKyMJCcaq67d0AjbWMQb44af5RhZXjL
 8LSeMRTj3850u591UvhQJrHnQnPoklUAbbyJtkPZiVuYKdVoboPUIXItK2CwESTUxhr5I5
 QP3Wz0fbVpRRVZ9RHAH+c2ygPvRJang=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-r_uFR_pbNsCvDBaWRmQOhA-1; Wed,
 12 Nov 2025 20:16:44 -0500
X-MC-Unique: r_uFR_pbNsCvDBaWRmQOhA-1
X-Mimecast-MFC-AGG-ID: r_uFR_pbNsCvDBaWRmQOhA_1762996603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9A071956089; Thu, 13 Nov 2025 01:16:42 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.87])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D951A180094B; Thu, 13 Nov 2025 01:16:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 06/13] qio: Minor optimization when callback function is
 unchanged
Date: Wed, 12 Nov 2025 19:11:31 -0600
Message-ID: <20251113011625.878876-21-eblake@redhat.com>
In-Reply-To: <20251113011625.878876-15-eblake@redhat.com>
References: <20251113011625.878876-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

In practice, all existing callers currently pass NULL for notify, and
no caller ever changes context across calls (for async uses, either
the caller consistently uses qio_net_listener_set_client_func_full
with the same context, or the caller consistently uses only
qio_net_listener_set_client_func which always uses the global
context); but the time spent checking these two fields in addition to
the more important func and data is still less than the savings of not
churning through extra GSource manipulations when the result will be
unchanged.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v2: move later in series, also ensure notify and context are the same
v3: rebase to mutex, R-b kept
---
 io/net-listener.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index f70acdfc5ce..93100a2d253 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -169,6 +169,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
     size_t i;

     QEMU_LOCK_GUARD(&listener->lock);
+    if (listener->io_func == func && listener->io_data == data &&
+        listener->io_notify == notify && listener->context == context) {
+        return;
+    }
+
     trace_qio_net_listener_unwatch(listener, listener->io_func,
                                    listener->context, "set_client_func");

-- 
2.51.1


