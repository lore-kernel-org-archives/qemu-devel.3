Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448A8D148B3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6b-0007Ii-KF; Thu, 08 Jan 2026 02:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6R-0006lq-4l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6O-0006bi-Ot
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+24QtW0IOqJ/TCWGYCOGIexrTZX+Dhgygc6Vsp4mfbI=;
 b=VUYs2QHuqasHcI/PA+wZ4NlTJwjqRfdNY7jR82nl1u0Nf6+8ydyvOQaXiD4D4VmdB8E8tt
 hd1aVBYhMCmrKwInOCHfEL09sKtNF64yOJcY+AFgLGE21UOUzXx2DuYvM42geCigsutUMU
 x761A+vdYyOsviuvkY2K14eu0pK045k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-C-2G9KHQNLWrF1bFNojqCw-1; Thu,
 08 Jan 2026 02:06:32 -0500
X-MC-Unique: C-2G9KHQNLWrF1bFNojqCw-1
X-Mimecast-MFC-AGG-ID: C-2G9KHQNLWrF1bFNojqCw_1767855991
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD51C1800473; Thu,  8 Jan 2026 07:06:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E06619560A7; Thu,  8 Jan 2026 07:06:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CBBA21E61B8; Thu, 08 Jan 2026 08:06:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 11/17] blkdebug: Use error_setg_file_open() for a better
 error message
Date: Thu,  8 Jan 2026 08:06:19 +0100
Message-ID: <20260108070625.1586474-12-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
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

The error message changes from

    Could not read blkdebug config file: REASON

to

    Could not open 'FNAME': REASON

I think the exact file name is more useful to know than the file's
purpose.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251121121438.1249498-10-armbru@redhat.com>
---
 block/blkdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index c54aee0c84..8a4a8cb85e 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -288,7 +288,7 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
     if (filename) {
         f = fopen(filename, "r");
         if (f == NULL) {
-            error_setg_errno(errp, errno, "Could not read blkdebug config file");
+            error_setg_file_open(errp, errno, filename);
             return -errno;
         }
 
-- 
2.52.0


