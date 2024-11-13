Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9FCD41C3E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 12:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBCuK-0006BJ-9T; Wed, 13 Nov 2024 07:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1tBCuG-0006BB-ED
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 07:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1tBCuE-000645-IZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 07:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731502532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ep8pWqFmpmfsKbUQSXa/buf9WcOM3yVH9VVC1Qi6QNM=;
 b=OoQQGeNyArJweorlgnd+DnLgF5/VwSUP3dF3G211fkecen+YyQOFX7kC9iQIAYc+A4lUc3
 Z9IoVoAPDTAzvNN42hRp/uasNkHmuvSn0+91S/Ew3+VXQOAh7gf+zvwBCpwCNMiZ+XoZsq
 Sanf0Nwyg2bMdbY4oMHSJkMf6Q1qzmo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-6c5U0ccyN2a1_vTEquTzDw-1; Wed,
 13 Nov 2024 07:55:31 -0500
X-MC-Unique: 6c5U0ccyN2a1_vTEquTzDw-1
X-Mimecast-MFC-AGG-ID: 6c5U0ccyN2a1_vTEquTzDw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D5BE1954234; Wed, 13 Nov 2024 12:55:30 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.42.28.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F86030000DF; Wed, 13 Nov 2024 12:55:28 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jjelen@redhat.com, mpitt@redhat.com
Subject: [PATCH ssh v2] ssh: Do not switch session to non-blocking mode
Date: Wed, 13 Nov 2024 12:55:23 +0000
Message-ID: <20241113125526.2495731-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jakub Jelen <jjelen@redhat.com>

The libssh does not handle non-blocking mode in SFTP correctly. The
driver code already changes the mode to blocking for the SFTP
initialization, but for some reason changes to non-blocking mode.
This used to work accidentally until libssh in 0.11 branch merged
the patch to avoid infinite looping in case of network errors:

https://gitlab.com/libssh/libssh-mirror/-/merge_requests/498

Since then, the ssh driver in qemu fails to read files over SFTP
as the first SFTP messages exchanged after switching the session
to non-blocking mode return SSH_AGAIN, but that message is lost
int the SFTP internals and interpretted as SSH_ERROR, which is
returned to the caller:

https://gitlab.com/libssh/libssh-mirror/-/issues/280

This is indeed an issue in libssh that we should address in the
long term, but it will require more work on the internals. For
now, the SFTP is not supported in non-blocking mode.

Fixes: https://gitlab.com/libssh/libssh-mirror/-/issues/280
Signed-off-by: Jakub Jelen <jjelen@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/ssh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 9f8140bcb6..b9f33ec739 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -866,9 +866,6 @@ static int ssh_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
         goto err;
     }
 
-    /* Go non-blocking. */
-    ssh_set_blocking(s->session, 0);
-
     if (s->attrs->type == SSH_FILEXFER_TYPE_REGULAR) {
         bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
     }
-- 
2.46.0


