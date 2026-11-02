Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4589606B0DD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtQZlsJs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvg-0006ZR-Mc; Mon, 02 Nov 2026 11:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvd-0006Wl-QA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvc-0002K4-3N
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+2Dzj8pPX/X+QY+bjUeI29pGDbl/KzC+FVA2Mrmksc=;
 b=dtQZlsJsT4XObZrfHGGOVAbcEWczphfjFEOcGosw5zzSyya5NxO7T0SOd16El+gnrzOIwj
 A+xJeDLJBNzm2mAB4Wt18xzUz2wllihzrfgOZf2aJkJgiPa7RbLjiBHc3pOeV3SjHDI7fI
 4MtKnTXrD8il+jFTbwKJTAWge9bYnJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-3enCiEJPNeuvrsFqjoyLWA-1; Mon,
 02 Nov 2026 11:30:31 -0500
X-MC-Unique: 3enCiEJPNeuvrsFqjoyLWA-1
X-Mimecast-MFC-AGG-ID: 3enCiEJPNeuvrsFqjoyLWA_1793637030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C13F419560AD; Mon,  2 Nov 2026 16:30:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D9161956087; Mon,  2 Nov 2026 16:30:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/17] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Date: Mon,  2 Nov 2026 17:29:52 +0100
Message-ID: <20261102162955.268763-15-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Hajnoczi <stefanha@redhat.com>

Kevin Wolf pointed out that the multipath_process_cmd() documentation
only defines the value of reply on success. Don't touch it when the
function returns -1.

The libmpathcmd implementation as of c78cf64a9e8e does not set *reply to
NULL when its internal mpath_send_cmd() call fails, so I think Kevin's
interpretation is correct.

As it stands, there is no observable bug in the QEMU code though because
reply is initialized to NULL before calling multipath_process_cmd().
This patch is just a cleanup.

Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: kwolf@redhat.com
Cc: eblake@redhat.com
Cc: berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20261027200757.961830-1-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scsi/qemu-pr-helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 54d196a503f..1f97a5c4bfe 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -559,7 +559,7 @@ static char *get_dm_name(int fd, Error **errp)
 static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
 {
     const unsigned int timeout_ms = 60000;
-    char *reply = NULL;
+    g_autofree char *reply = NULL;
     int last_errno;
     int ret;
 
@@ -568,11 +568,16 @@ static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
     if (reply && strcmp(reply, "ok\n") != 0) {
         error_setg(errp, "mpath_process_cmd(%d, \"%s\") replied \"%s\"",
                    fd, cmd, reply);
-        free(reply);
         return false;
     }
-    free(reply);
     if (ret == -1) {
+        /*
+         * It should already be NULL but the mpath_process_cmd() documentation
+         * only defines it when the function returns success, so don't depend
+         * on its value when ret == -1.
+         */
+        reply = NULL;
+
         error_setg_errno(errp, last_errno,
                          "mpath_process_cmd(%d, \"%s\") failed",
                          fd, cmd);
-- 
2.56.0


