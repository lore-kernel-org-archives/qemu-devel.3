Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228D2D2CDFF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4l-0000bt-7C; Tue, 22 Oct 2024 12:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4j-0000a1-CI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4h-00069z-RC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBA4X86K7vUY/KWF2IhMYfGN+XFtUzGOJg9HFppn5eo=;
 b=EOO0GS/8oP6QxN1Y3gQEKIPYNp56HtMGc3x6ouP5CC0a8msYXQx1g0DRVn+xNTV3zNXt5W
 LHliwa9EyoMU4+Ts/0u8oTUo/wkJfmpWTZJxqo3Ldy6wo1WBWeySyzHTVGRZGmPpuVSEoR
 H/mN4HMh7g0tffT5REssI+HKBlySmJ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-f8T9LYDGMqOMSt0i1JB9cw-1; Tue,
 22 Oct 2024 12:49:35 -0400
X-MC-Unique: f8T9LYDGMqOMSt0i1JB9cw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D980C1955EE6; Tue, 22 Oct 2024 16:49:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B851F1956056; Tue, 22 Oct 2024 16:49:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 9/9] raw-format: Fix error message for invalid offset/size
Date: Tue, 22 Oct 2024 18:49:03 +0200
Message-ID: <20241022164903.282174-10-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

s->offset and s->size are only set at the end of the function and still
contain the old values when formatting the error message. Print the
parameters with the new values that we actually checked instead.

Fixes: 500e2434207d ('raw-format: Split raw_read_options()')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240829185527.47152-1-kwolf@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/raw-format.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index ac7e8495f6..e08526e2ec 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -111,7 +111,7 @@ raw_apply_options(BlockDriverState *bs, BDRVRawState *s, uint64_t offset,
     if (offset > real_size) {
         error_setg(errp, "Offset (%" PRIu64 ") cannot be greater than "
                    "size of the containing file (%" PRId64 ")",
-                   s->offset, real_size);
+                   offset, real_size);
         return -EINVAL;
     }
 
@@ -119,7 +119,7 @@ raw_apply_options(BlockDriverState *bs, BDRVRawState *s, uint64_t offset,
         error_setg(errp, "The sum of offset (%" PRIu64 ") and size "
                    "(%" PRIu64 ") has to be smaller or equal to the "
                    " actual size of the containing file (%" PRId64 ")",
-                   s->offset, s->size, real_size);
+                   offset, size, real_size);
         return -EINVAL;
     }
 
-- 
2.47.0


