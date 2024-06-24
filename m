Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B17C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfRj-0001k4-Kl; Mon, 24 Jun 2024 04:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sLfRi-0001jO-EK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sLfRg-0008Jy-U9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719219184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnMkczkg0st/7s2vXcXy0ZbukC7y2g2dQra52PJdzn8=;
 b=ilJsHhT6KUzUpCxORHxwzgA41qZSdybw6YCPawG95lkOXQjwUs7410YdEWiwYQ4Orac51q
 93Ta+UiPUZRMUYqc7t9NNo44fz6WCgiQ0Esg3cCL3x25S36rvu8L5TSarVESCRyV5xsSRd
 76Wn2/+iytHSkwvS8MfhqG6jRnQpNGM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-MUeuOACYPf2FP8OQP6lOAg-1; Mon,
 24 Jun 2024 04:53:02 -0400
X-MC-Unique: MUeuOACYPf2FP8OQP6lOAg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 717791956095; Mon, 24 Jun 2024 08:53:01 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E24EA1956048; Mon, 24 Jun 2024 08:52:59 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	mtosatti@redhat.com,
	michael.roth@amd.com
Subject: [PATCH 2/2] i386/sev: Fallback to the default SEV device if none
 provided in sev_get_capabilities()
Date: Mon, 24 Jun 2024 10:52:49 +0200
Message-ID: <157f93712c23818be193ce785f648f0060b33dee.1719218926.git.mprivozn@redhat.com>
In-Reply-To: <cover.1719218926.git.mprivozn@redhat.com>
References: <cover.1719218926.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When management tools (e.g. libvirt) query QEMU capabilities,
they start QEMU with a minimalistic configuration and issue
various commands on monitor. One of the command issued is/might
be "query-sev-capabilities" to learn values like cbitpos or
reduced-phys-bits. But as of v9.0.0-1145-g16dcf200dc the monitor
command returns an error instead.

This creates a chicken-egg problem because in order to query
those aforementioned values QEMU needs to be started with a
'sev-guest' object. But to start QEMU with the values must be
known.

I think it's safe to assume that the default path ("/dev/sev")
provides the same data as user provided one. So fall back to it.

Fixes: 16dcf200dc951c1cde3e5b442457db5f690b8cf0
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 target/i386/sev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 8c350d42b0..5bb1ceb3ad 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -585,13 +585,13 @@ static SevCapability *sev_get_capabilities(Error **errp)
     }
 
     sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    if (!sev_common) {
-        error_setg(errp, "SEV is not configured");
-        return NULL;
+    if (sev_common) {
+        sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
+                                             &error_abort);
+    } else {
+        sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     }
 
-    sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
-                                         &error_abort);
     fd = open(sev_device, O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "SEV: Failed to open %s",
-- 
2.44.2


