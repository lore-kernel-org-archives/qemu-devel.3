Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D1C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 21:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgLF-0004zO-SG; Tue, 18 Jun 2024 17:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJgLE-0004xh-8T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJgLC-0004He-Nj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718745969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ASyZePn7ofny9BWWY8HxngcryuGbNrgyOzD7cagwNQ8=;
 b=BV2+D4o1WrGy1RYKgXwO0caf0YaSYBCUYdTMJbfqnU1hXNjMiy/082OQ0mZWQQp/8vQeD/
 WPO1tzANz38yUukaBOLvXr4+tFvnwVKaDTiTF4U8OBxBQIKM7zFzr45XGfeEr10Wpn3Eai
 3BnPQkFJ6iftV/8zfUSVbY3i/HorAc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-kJzfIhy9ONW7zbc8GZpA2Q-1; Tue,
 18 Jun 2024 17:25:02 -0400
X-MC-Unique: kJzfIhy9ONW7zbc8GZpA2Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08FAB1955E8F; Tue, 18 Jun 2024 21:25:01 +0000 (UTC)
Received: from sparse.local (unknown [10.47.238.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 183FE3000225; Tue, 18 Jun 2024 21:24:58 +0000 (UTC)
From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Subject: [PATCH] block/file-posix: Consider discard flag when opening
Date: Wed, 19 Jun 2024 00:24:57 +0300
Message-ID: <20240618212457.714456-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Set has_discard only when BDRV_O_UNMAP is not set. With this users that
want to keep their images fully allocated can disable hole punching
when writing zeros or discarding using:

   -drive file=thick.img,discard=off

This change is not entirely correct since it changes the default discard
behavior.  Previously we always allowed punching holes, but now you have
must use discard=unmap|on to enable it. We probably need to add the
BDDR_O_UNMAP flag by default.

make check still works, so maybe we don't have tests for sparsifying
images, or maybe you need to run special tests that do not run by
default. We needs tests for keeping images non-sparse.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index be25e35ff6..acac2abadc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -738,11 +738,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         ret = -EINVAL;
         goto fail;
     }
 #endif /* !defined(CONFIG_LINUX_IO_URING) */
 
-    s->has_discard = true;
+    s->has_discard = !!(bdrv_flags & BDRV_O_UNMAP);
     s->has_write_zeroes = true;
 
     if (fstat(s->fd, &st) < 0) {
         ret = -errno;
         error_setg_errno(errp, errno, "Could not stat file");
-- 
2.45.1


