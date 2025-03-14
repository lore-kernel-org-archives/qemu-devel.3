Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDECC35FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt68y-0004uu-2A; Fri, 14 Mar 2025 10:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt68c-0004pd-0S
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt687-0007vP-27
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741962912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSnAFyHbXjYvoKbSaLlW0KNyvNRMW+n7e7ObBx98y04=;
 b=IW8Y5yUcoBBje1W5k6O01sflr6g85dancm36ydvL64nEN7tTgcwS2wVzcFi5AAc+/4r5WE
 Fq5GhWAe0IiM0EWIdUUv9IQci0SDM9eVWf2485+zvVnv987fYuvMNjQ06VleK3TE+h/qZ+
 kfXfk8Me9L4QmOeBuVH99z8ZS+A3Xp8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-8BdvRzc8NNqYnKGyFlUU7Q-1; Fri,
 14 Mar 2025 10:35:06 -0400
X-MC-Unique: 8BdvRzc8NNqYnKGyFlUU7Q-1
X-Mimecast-MFC-AGG-ID: 8BdvRzc8NNqYnKGyFlUU7Q_1741962905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75B7219560BD; Fri, 14 Mar 2025 14:35:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D88BF1955D88; Fri, 14 Mar 2025 14:35:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2285121E669B; Fri, 14 Mar 2025 15:35:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org
Subject: [PATCH 1/2] hw/xen: Fix xen_bus_realize() error handling
Date: Fri, 14 Mar 2025 15:34:59 +0100
Message-ID: <20250314143500.2449658-2-armbru@redhat.com>
In-Reply-To: <20250314143500.2449658-1-armbru@redhat.com>
References: <20250314143500.2449658-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

xen_bus_realize() is wrong that way: it passes &local_err to
xs_node_watch() in a loop.  If this fails in more than one iteration,
it can trip error_setv()'s assertion.

Fix by clearing @local_err.

Fixes: c4583c8c394e (xen-bus: reduce scope of backend watch)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/xen/xen-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 8260f1e1bb..2aacc1436f 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -357,6 +357,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
             error_reportf_err(local_err,
                               "failed to set up '%s' enumeration watch: ",
                               type[i]);
+            local_err = NULL;
         }
 
         g_free(node);
-- 
2.48.1


