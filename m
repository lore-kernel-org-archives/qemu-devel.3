Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FD1D132A3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tn0-0002Vl-SF; Mon, 04 Nov 2024 04:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tmz-0002VC-3l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1t7tmx-0002k2-DR
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZCdMFWAW+p9eCpAkQpTmJsY+P5AFLG61GLV7l5sZKw=;
 b=XcW5V4137CTT0pXioAq/YPbyaKoGGZzWD5CCRKotVfoiCh7pSp3ilHZuhq2fpwXJ9xtjii
 0kTHUDbhhavcnx5xl+6gzABbjjSPLjRzRfRoSC7Ds7elKAydl7xrek6LAK3uN6kvor/Lqu
 h2ttOMSciisWXfp1K9QKOhhL3ocd7TE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-P6wjTqE-PeuIaTtTNHKOXQ-1; Mon,
 04 Nov 2024 04:54:18 -0500
X-MC-Unique: P6wjTqE-PeuIaTtTNHKOXQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2068A19560AE; Mon,  4 Nov 2024 09:54:17 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.3.236])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1FAF3000198; Mon,  4 Nov 2024 09:54:15 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 1/4] qga: Don't access global variable in run_agent_once()
Date: Mon,  4 Nov 2024 10:54:07 +0100
Message-ID: <780bf01dec69fa68b8fe5a9c09187b124e0a56ec.1730713917.git.mprivozn@redhat.com>
In-Reply-To: <cover.1730713917.git.mprivozn@redhat.com>
References: <cover.1730713917.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The run_agent_once() function is already given GAState via an
argument. There's no need to access the global ga_state variable
which points to the argument anyways (thanks to
initialize_agent()). Worse, some parts of the function use the
argument and the other use the global variable.  Stick with the
function argument.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qga/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 50186760bf..4a695235f0 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1519,7 +1519,7 @@ static int run_agent_once(GAState *s)
         return EXIT_FAILURE;
     }
 
-    g_main_loop_run(ga_state->main_loop);
+    g_main_loop_run(s->main_loop);
 
     if (s->channel) {
         ga_channel_free(s->channel);
-- 
2.45.2


