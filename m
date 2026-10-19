Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C101607D34D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxkUjXAq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpNF-0003Vx-Pe; Mon, 19 Oct 2026 11:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xIpNC-0003VS-LB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xIpNB-0004PE-8E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792424040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+BfOhARq2sQeUQ+IgajBow6wnMjSEMVdygKtoybuMCc=;
 b=FxkUjXAq4ptNX6HxjqsKnTmjJKsljOtCk8lu3+/jHvtWPr0GaV/h2uOUaHdHEIKrmXnxNA
 LlzmnihiD4CL0c7An7v/tvQMAZw1LEerHIOorhb9gupRO+SF/RO6Zc3pCa8PYqsaho7Klh
 EsfCH9pozAgdtPodlSD/Ms6bDBvJ9q4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-gYsmCsV1NiqSaQxIO2FKeQ-1; Mon,
 19 Oct 2026 15:33:56 +0000
X-MC-Unique: gYsmCsV1NiqSaQxIO2FKeQ-1
X-Mimecast-MFC-AGG-ID: gYsmCsV1NiqSaQxIO2FKeQ_1792424035
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B81C180065F; Mon, 19 Oct 2026 15:33:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BBD9195608C; Mon, 19 Oct 2026 15:33:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, kwolf@redhat.com,
 eblake@redhat.com
Subject: [PATCH] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Date: Mon, 19 Oct 2026 11:33:53 -0400
Message-ID: <20261019153353.105505-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
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
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Eric pointed out that g_autofree could eliminate the manual free(3)
calls. In this case we cannot use it since g_autofree calls glib's
g_free() rather than the standard library's free(3).
---
 scsi/qemu-pr-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 54d196a503f..d52109cab25 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -571,13 +571,17 @@ static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
         free(reply);
         return false;
     }
-    free(reply);
     if (ret == -1) {
+        /*
+         * reply is not freed because the documentation only defines it when
+         * the function returns success.
+         */
         error_setg_errno(errp, last_errno,
                          "mpath_process_cmd(%d, \"%s\") failed",
                          fd, cmd);
         return false;
     }
+    free(reply);
     return true;
 }
 
-- 
2.56.0


