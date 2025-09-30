Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C96CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VDs-0001Of-AI; Tue, 30 Sep 2025 03:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDp-0001O5-Lk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDl-0008Ry-Pq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjkB89PWVX1IC7C3fDUEfInLrfYkRQWd2iLqemEojOs=;
 b=WdRv+Z/yNfNZm/QebvXMMXmqaIGImxZoSrBIOAkGbnfdhM/t9JuFiXnAh9w03DlwFzB4lr
 vRRiUnB6qVpIgZh0yXehaD3+20UZzSk8l4/jXD6UT87RS57GxMVFcux8WVzErOEUoZpYfW
 qmzZPAugf1KaDh3fPukxu3ifnQnfXRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-zkwWLMMeOXKEFYazmJSH5w-1; Tue,
 30 Sep 2025 03:56:17 -0400
X-MC-Unique: zkwWLMMeOXKEFYazmJSH5w-1
X-Mimecast-MFC-AGG-ID: zkwWLMMeOXKEFYazmJSH5w_1759218976
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 236F3180057C; Tue, 30 Sep 2025 07:56:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFC95195608E; Tue, 30 Sep 2025 07:56:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 richard.henderson@linaro.org, Mohamed Akram <mohd.akram@outlook.com>
Subject: [PULL 2/5] ui/spice: Fix abort on macOS
Date: Tue, 30 Sep 2025 11:55:56 +0400
Message-ID: <20250930075559.133650-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250930075559.133650-1-marcandre.lureau@redhat.com>
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Akram <mohd.akram@outlook.com>

The check is faulty because the thread variable was assigned in the main
thread while the main loop runs in a different thread on macOS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3070
Signed-off-by: Mohamed Akram <mohd.akram@outlook.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <C87205B9-DD8F-4E53-AB5B-C8BF82EF1D16@outlook.com>
---
 ui/spice-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5992f9daec..2645e96ef6 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -50,8 +50,6 @@ static int spice_migration_completed;
 static int spice_display_is_running;
 static int spice_have_target_host;
 
-static QemuThread me;
-
 struct SpiceTimer {
     QEMUTimer *timer;
 };
@@ -222,7 +220,7 @@ static void channel_event(int event, SpiceChannelEventInfo *info)
      * thread and grab the BQL if so before calling qemu
      * functions.
      */
-    bool need_lock = !qemu_thread_is_self(&me);
+    bool need_lock = !bql_locked();
     if (need_lock) {
         bql_lock();
     }
@@ -675,8 +673,6 @@ static void qemu_spice_init(void)
     spice_wan_compression_t wan_compr;
     bool seamless_migration;
 
-    qemu_thread_get_self(&me);
-
     if (!opts) {
         return;
     }
-- 
2.51.0


