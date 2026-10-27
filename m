Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A81606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WzDr7P1h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnT0-0000zA-BT; Tue, 27 Oct 2026 16:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnSr-0000vj-BI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnSo-0006Zu-N0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793131685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RBhrAOIwwhZP6si81PC45/jIxEzm0IsS9r2ETomJoHs=;
 b=WzDr7P1hN1vW//ifZCeG+HsVzug/dU2TnW2/NefZqUPUEr22pmct+54vbUVRXi3/ryKbiW
 7GBDpww2hx5fjRBsPdhkSM0LxRLpl0lFNwAedRVPEYiJ1hY6mMq9XKSoKdZHu//0ULsfqO
 Tovm6pui5m3o1nYzqKw2bCwT8/B97NA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-Inssf5DsPT-CjQ-ioGktKA-1; Tue,
 27 Oct 2026 16:08:01 -0400
X-MC-Unique: Inssf5DsPT-CjQ-ioGktKA-1
X-Mimecast-MFC-AGG-ID: Inssf5DsPT-CjQ-ioGktKA_1793131681
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7626E1800C32; Tue, 27 Oct 2026 20:08:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80EBA1955F01; Tue, 27 Oct 2026 20:07:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, kwolf@redhat.com,
 eblake@redhat.com, berrange@redhat.com
Subject: [PATCH v2] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Date: Tue, 27 Oct 2026 16:07:57 -0400
Message-ID: <20261027200757.961830-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
v2:
- Use g_autofree instead of manual free(3) calls [Eric]
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


