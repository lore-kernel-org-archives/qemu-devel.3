Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A025FE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsmv-0001au-SF; Wed, 18 Dec 2024 07:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsmK-0001VN-BJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:04:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsmC-0006Co-Aq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734523416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilFdzvbpQnm3tGGae5Nxf4b6CLtBsAfD1O+YYofqgPo=;
 b=OJCpOyKu+QSYFLxgWx4GDpbNl0eBw391xesF3AwJKpBHuZRpl2jLMbbhl7/mYxJfhbWJLO
 AagpDKKIIf6OOmR6j2PxOqWn0+vrFllftqU587wjzLOIUgyT/9i6QgG4NcjJIlLLox/Ap7
 UERJfywgpdbtVLuSET302jgRsi7l7qI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-JBGwTA7cNaSxNmlPggI96g-1; Wed,
 18 Dec 2024 07:03:33 -0500
X-MC-Unique: JBGwTA7cNaSxNmlPggI96g-1
X-Mimecast-MFC-AGG-ID: JBGwTA7cNaSxNmlPggI96g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6107819560AE; Wed, 18 Dec 2024 12:03:32 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE4DE30044C1; Wed, 18 Dec 2024 12:03:30 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/3] qga: Don't access global variable in run_agent_once()
Date: Wed, 18 Dec 2024 14:03:21 +0200
Message-ID: <20241218120321.34998-4-kkostiuk@redhat.com>
In-Reply-To: <20241218120321.34998-1-kkostiuk@redhat.com>
References: <20241218120321.34998-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michal Privoznik <mprivozn@redhat.com>

The run_agent_once() function is already given GAState via an
argument. There's no need to access the global ga_state variable
which points to the argument anyways (thanks to
initialize_agent()). Worse, some parts of the function use the
argument and the other use the global variable.  Stick with the
function argument.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/8ae7f5d5032b14a5b956fe8aaf47bae5ca401699.1733414906.git.mprivozn@redhat.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.47.1


