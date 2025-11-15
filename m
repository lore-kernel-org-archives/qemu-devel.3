Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE880CEB2CB
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 09:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKCKm-0004x2-DY; Sat, 15 Nov 2025 04:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKCKi-0004q2-EU
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 04:12:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKCKg-0005VG-16
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 04:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763197952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiw/kGPKk50Ls9x/BwiYwhBbooldPae4YAWxQaCWcjw=;
 b=RDzxD2iIDGXREYwjG9bKqC910xhogep1yT1wpBoYfUg0ZSA1PHhFg91QfaPYn7R5IMc7FI
 6LL0oVsZJ/K+JpWjGpuIUlyXNCAkolTxWkfdUH3aBMRNQcrAQ2se9vtalDP6MkgoAxidI8
 ICtPCPqXfRnbJjcvSJxp4mnTGHKiWZ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-76rEkok2MhG-UqD8p7pvmg-1; Sat,
 15 Nov 2025 04:12:30 -0500
X-MC-Unique: 76rEkok2MhG-UqD8p7pvmg-1
X-Mimecast-MFC-AGG-ID: 76rEkok2MhG-UqD8p7pvmg_1763197949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1A891800652; Sat, 15 Nov 2025 08:35:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F2491956048; Sat, 15 Nov 2025 08:35:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1800D21E676A; Sat, 15 Nov 2025 09:35:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 2/3] migration: Use warn_reportf_err() where appropriate
Date: Sat, 15 Nov 2025 09:34:59 +0100
Message-ID: <20251115083500.2753895-3-armbru@redhat.com>
In-Reply-To: <20251115083500.2753895-1-armbru@redhat.com>
References: <20251115083500.2753895-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Replace

    warn_report("...: %s", ..., error_get_pretty(err));

by

    warn_reportf_err(err, "...: ", ...);

Prior art: commit 5217f1887a8 (error: Use error_reportf_err() where
appropriate).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/multifd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a529c399e4..6210454838 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -464,8 +464,8 @@ static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
          */
         migration_tls_channel_end(ioc, &local_err);
         if (local_err) {
-            warn_report("Failed to gracefully terminate TLS connection: %s",
-                        error_get_pretty(local_err));
+            warn_reportf_err(local_err,
+                        "Failed to gracefully terminate TLS connection: ");
         }
     }
 
-- 
2.49.0


