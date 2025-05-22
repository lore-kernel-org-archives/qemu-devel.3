Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EFCC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAhj-0005nL-7I; Thu, 22 May 2025 14:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhZ-0005lO-6W
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhW-0000Nx-T1
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747938690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjuYirBkwph/WiIGkgU7D8925XkGSUPnaUZ8PN66ITk=;
 b=evTZ9C2M5HchUrSw4PCFoFvbw/ZfMaOVeLUT7GCeTlmsxjKQiNrC94An5sqtlRIX5z1zE6
 C6DJ+L8q8a2+wt1N64v2+lwnKCHlFL687Mz3CDCyhYn0nbluCYb7HaZ6ttAqv4x0QLveOU
 Q1lYr5LqrhTgQdOFwITBjdhAz4d2gMk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-bWT-2s-COa-NtK3JM93YfQ-1; Thu,
 22 May 2025 14:31:26 -0400
X-MC-Unique: bWT-2s-COa-NtK3JM93YfQ-1
X-Mimecast-MFC-AGG-ID: bWT-2s-COa-NtK3JM93YfQ_1747938685
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16BA9195609F; Thu, 22 May 2025 18:31:25 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C76A51944DFF; Thu, 22 May 2025 18:31:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/5] qemu-img: fix offset calculation in bench
Date: Thu, 22 May 2025 20:31:13 +0200
Message-ID: <20250522183115.246746-4-kwolf@redhat.com>
In-Reply-To: <20250522183115.246746-1-kwolf@redhat.com>
References: <20250522183115.246746-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

The current offset calculation leads to an EIO error
in block/block-backend.c: blk_check_byte_request():

 if (offset > len || len - offset < bytes) {
     return -EIO;
 }

This triggers the error message:
"qemu-img: Failed request: Input/output error".

Example of the issue:
 offset: 260076
 len: 260096
 bytes: 4096

This fix ensures that offset remains within a valid range.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Message-ID: <20250506141410.100119-1-gerben@altlinux.org>
[kwolf: Fixed up integer overflow]
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 76ac5d3028..139eeb5039 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4488,10 +4488,10 @@ static void bench_cb(void *opaque, int ret)
          */
         b->in_flight++;
         b->offset += b->step;
-        if (b->image_size == 0) {
+        if (b->image_size <= b->bufsize) {
             b->offset = 0;
         } else {
-            b->offset %= b->image_size;
+            b->offset %= b->image_size - b->bufsize;
         }
         if (b->write) {
             acb = blk_aio_pwritev(b->blk, offset, b->qiov, 0, bench_cb, b);
-- 
2.49.0


