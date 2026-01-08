Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51B6CF6A85
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlS0-0003E6-HR; Thu, 08 Jan 2026 03:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdlRz-00037h-C8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdlRx-0005VJ-V8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767861175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jCFmIouQRSv/n0JCgVn6ddgFQBzjUwSwcdofpSHKR5Y=;
 b=U0LlCjY0QmzY9JzKsR/n3M5dIAjU+WczfSC6RoeIWycOc99ZBwjus83/DTFb03MYKORf/+
 IzgjIxuQvkvzyggeYXiOaZl0SAleOujHH1frt0IJW+AQ/aIYSNir06BWswCfM9rpc3GS8P
 bY6P6FMlzce+gNuCf4WGLSRyAGsOJhA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694--jgh7d1KPkCsgbEPRDZhjg-1; Thu,
 08 Jan 2026 03:32:53 -0500
X-MC-Unique: -jgh7d1KPkCsgbEPRDZhjg-1
X-Mimecast-MFC-AGG-ID: -jgh7d1KPkCsgbEPRDZhjg_1767861172
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D65B18005AD; Thu,  8 Jan 2026 08:32:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCFB719560A2; Thu,  8 Jan 2026 08:32:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69EA421E6937; Thu, 08 Jan 2026 09:32:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org,
	philmd@linaro.org
Subject: [PATCH] hmp-commands-info.hx: Move definition of "info accel"
Date: Thu,  8 Jan 2026 09:32:49 +0100
Message-ID: <20260108083249.1602654-1-armbru@redhat.com>
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

Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
inserted "info accel" in the middle of "info sync-profile".  Move it
behind "info sync-profile".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 41674dcbe1..74c741f80e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -267,18 +267,6 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
-    {
-        .name       = "accel",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show accelerator statistics",
-    },
-
-SRST
-  ``info accel``
-    Show accelerator statistics.
-ERST
-
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
@@ -294,6 +282,18 @@ SRST
     being coalesced.
 ERST
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator statistics",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator statistics.
+ERST
+
     {
         .name       = "kvm",
         .args_type  = "",
-- 
2.52.0


