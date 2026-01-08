Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC336D148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6T-0006pL-W6; Thu, 08 Jan 2026 02:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6P-0006jp-TL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6M-0006b4-Tf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eQIJicwswPhegRn6v45nU97TjUCKBDRACnnAImYw58=;
 b=GE3khjzVyUoDHzN0qbwXvWMm6ie89e0zGsGBEpcAIRHMFWzi886VzdtTLAKkIG3HDuV8Vq
 ek/+PnsXveTtHZRoLYhd4dhz9hNzIwQmwNsVoqoi6u9NRaltUGxd+WEYW4YsYGP4ag05Y8
 9GjG5pWW6mB12p8WpKY4H5Y6yJkGw4k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-1WxZxIwaMTSYFETUYQUPmw-1; Thu,
 08 Jan 2026 02:06:30 -0500
X-MC-Unique: 1WxZxIwaMTSYFETUYQUPmw-1
X-Mimecast-MFC-AGG-ID: 1WxZxIwaMTSYFETUYQUPmw_1767855989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F0311954204; Thu,  8 Jan 2026 07:06:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74C951800980; Thu,  8 Jan 2026 07:06:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F160A21E61A9; Thu, 08 Jan 2026 08:06:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL v2 03/17] nbd/client-connection: Replace error_propagate() by
 assignment
Date: Thu,  8 Jan 2026 08:06:11 +0100
Message-ID: <20260108070625.1586474-4-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

connect_thread_func() sets a variable to null, then error_propagate()s
an Error * to it.  This is a roundabout way to assign the Error * to
it, so replace it by just that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251119130855.105479-4-armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 nbd/client-connection.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 79ea97e4cc..6a4f080717 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -207,8 +207,7 @@ static void *connect_thread_func(void *opaque)
         qemu_mutex_lock(&conn->mutex);
 
         error_free(conn->err);
-        conn->err = NULL;
-        error_propagate(&conn->err, local_err);
+        conn->err = local_err;
 
         if (ret < 0) {
             object_unref(OBJECT(conn->sioc));
-- 
2.52.0


