Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAAEC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt68y-0004uj-2D; Fri, 14 Mar 2025 10:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt68c-0004pc-0C
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt687-0007v1-5K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741962909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOP2k/YvGRFFx3UKMWPK+4XpP/sMhbf4xDwkal25Q3k=;
 b=bafW6J3lT55egvCU7Na6zefMibKtJKpCgz8tOJ+ox1ceTxbUPeOdiU9Cld9mA4723lUq9z
 fxuGHgvtE/H1sZssVRRXGhzbdt4s9gQSwYhY29VookCK2H9+vaTZAovNL+bMPyAAIncaXu
 y1N6ZaUaSnUVjCe6aAAWXTrDCSEP2mE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-g1pY-nTuMVmbWQzThjJd7Q-1; Fri,
 14 Mar 2025 10:35:06 -0400
X-MC-Unique: g1pY-nTuMVmbWQzThjJd7Q-1
X-Mimecast-MFC-AGG-ID: g1pY-nTuMVmbWQzThjJd7Q_1741962905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C24C218001E3; Fri, 14 Mar 2025 14:35:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D7AC1955F2D; Fri, 14 Mar 2025 14:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26E6621E669D; Fri, 14 Mar 2025 15:35:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org
Subject: [PATCH 2/2] hw/xen: Downgrade a xen_bus_realize() non-error to warning
Date: Fri, 14 Mar 2025 15:35:00 +0100
Message-ID: <20250314143500.2449658-3-armbru@redhat.com>
In-Reply-To: <20250314143500.2449658-1-armbru@redhat.com>
References: <20250314143500.2449658-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

xen_bus_realize() reports a failure to set up a watch as error, but it
doesn't treat it as one: it simply continues.  Report a warning
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/xen/xen-bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 2aacc1436f..f808a01813 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -353,10 +353,9 @@ static void xen_bus_realize(BusState *bus, Error **errp)
             xs_node_watch(xenbus->xsh, node, key, xen_bus_backend_changed,
                           xenbus, &local_err);
         if (local_err) {
-            /* This need not be treated as a hard error so don't propagate */
-            error_reportf_err(local_err,
-                              "failed to set up '%s' enumeration watch: ",
-                              type[i]);
+            warn_reportf_err(local_err,
+                             "failed to set up '%s' enumeration watch: ",
+                             type[i]);
             local_err = NULL;
         }
 
-- 
2.48.1


