Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD578D148B3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6U-0006tf-IX; Thu, 08 Jan 2026 02:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6Q-0006k6-0i
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6N-0006bU-Mp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmvPlwKEeCyvXjYhqrp6IAqZIl+goYekY4R4ZTuUKtY=;
 b=I02CCsnO0NSY+9lD6JeC5V1bNVOx1sWiDxS9XV4PQbacCPhMxShxe2f6otdmpX2qBcLroA
 CPOa2j2+3sqi3IWHi4M6+GT3ujET/ap+cQKYedSOdYMswBr40olj0Kt/jgIy5hTRo8T8Ha
 u/i1QOvdckKon/4nrDo7Rti35R41H3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-OuwCuNx4P7qGiSzdzYRVYA-1; Thu,
 08 Jan 2026 02:06:32 -0500
X-MC-Unique: OuwCuNx4P7qGiSzdzYRVYA-1
X-Mimecast-MFC-AGG-ID: OuwCuNx4P7qGiSzdzYRVYA_1767855992
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 039131956061; Thu,  8 Jan 2026 07:06:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CABB1801ACA; Thu,  8 Jan 2026 07:06:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D1E021E61B2; Thu, 08 Jan 2026 08:06:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 07/17] ui: Convert to qemu_create() for simplicity and
 consistency
Date: Thu,  8 Jan 2026 08:06:15 +0100
Message-ID: <20260108070625.1586474-8-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The error message changes from

    failed to open file 'FILENAME': REASON

to

    Could not create 'FILENAME': REASON

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251121121438.1249498-4-armbru@redhat.com>
---
 ui/ui-qmp-cmds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 74fa6c6ec5..b49b636152 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -369,10 +369,8 @@ qmp_screendump(const char *filename, const char *device,
     }
     image = pixman_image_ref(surface->image);
 
-    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
+    fd = qemu_create(filename, O_WRONLY | O_TRUNC | O_BINARY, 0666, errp);
     if (fd == -1) {
-        error_setg(errp, "failed to open file '%s': %s", filename,
-                   strerror(errno));
         return;
     }
 
-- 
2.52.0


