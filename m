Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB88AC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjbD-0000xh-9t; Mon, 21 Jul 2025 02:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZR-0008NF-QI
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZP-0006NC-VO
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7K46m3uw7Qx50uzdFY5CTZU3qbwCCpoVk+4+p3b3aI=;
 b=VsQp6n4GxthR8j8aWm4hO2VOMwKW+TgX18gtRFDWGx1hj+Kp3Po5Lp1hG7i9NHTTsjpUio
 Tgzac2AmNhdxYYhVcJygG2kK8dl1lANOXkO4V33XnKGZcIWeH1z+6J1dQIqea+iwnmI1Ug
 9aplGruD9NBAUs9Yq5e2wObPfWD+hj0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-WqZ-NHGuP4iDEJWP7kjE8Q-1; Mon,
 21 Jul 2025 02:00:11 -0400
X-MC-Unique: WqZ-NHGuP4iDEJWP7kjE8Q-1
X-Mimecast-MFC-AGG-ID: WqZ-NHGuP4iDEJWP7kjE8Q_1753077611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D686119560B6; Mon, 21 Jul 2025 06:00:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79A5C195608D; Mon, 21 Jul 2025 06:00:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/12] net/vhost-user: Remove unused "err" from chr_closed_bh()
 (CID 1612365)
Date: Mon, 21 Jul 2025 13:59:27 +0800
Message-ID: <20250721055927.75951-13-jasowang@redhat.com>
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

The "err" variable was declared but never used within the
chr_closed_bh() function. This resulted in a dead code
warning (CID 1612365) from Coverity.

Remove the unused variable and the associated error block
to resolve the issue.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-user.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index cec83e925f..8b96157145 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -298,7 +298,6 @@ static void chr_closed_bh(void *opaque)
     const char *name = opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
     NetVhostUserState *s;
-    Error *err = NULL;
     int queues, i;
 
     queues = qemu_find_net_clients_except(name, ncs,
@@ -317,9 +316,6 @@ static void chr_closed_bh(void *opaque)
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
                              NULL, opaque, NULL, true);
 
-    if (err) {
-        error_report_err(err);
-    }
     qapi_event_send_netdev_vhost_user_disconnected(name);
 }
 
-- 
2.42.0


