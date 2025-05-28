Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC0AC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKM9d-0006zt-5R; Wed, 28 May 2025 15:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9b-0006yh-3P
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9Z-0004E4-FP
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748459367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IywG/Djf5pm+yO3Rkxx9D0hkJ1WWGT1an6A0mRYcrMU=;
 b=W5yK+JSpOiB89p6CjZMzjaIvShkvZC3gZKHB5VU02qQBWNa5QqGpW32av1+zTWIr7TDZ64
 pehvre82Uxn8jOcaP2cZlF0wzIEjkY0jc3fxF6r+FAvDKdBRSjQ+rnUChmCSdQv3yuFyC3
 ZroScPO2tebhSAbQJhePCRB9jmuPxOU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-39sQeEkCNmCuGk7HPDB9vg-1; Wed,
 28 May 2025 15:09:24 -0400
X-MC-Unique: 39sQeEkCNmCuGk7HPDB9vg-1
X-Mimecast-MFC-AGG-ID: 39sQeEkCNmCuGk7HPDB9vg_1748459363
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 050AB195608B; Wed, 28 May 2025 19:09:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29FA219560AF; Wed, 28 May 2025 19:09:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 hibriansong@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Chao Gao <chao.gao@intel.com>
Subject: [RFC 02/11] aio-posix: keep polling enabled with fdmon-io_uring.c
Date: Wed, 28 May 2025 15:09:07 -0400
Message-ID: <20250528190916.35864-3-stefanha@redhat.com>
In-Reply-To: <20250528190916.35864-1-stefanha@redhat.com>
References: <20250528190916.35864-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Commit 816a430c517e ("util/aio: Defer disabling poll mode as long as
possible") kept polling enabled when the event loop timeout is 0. Since
there is no timeout the event loop will continue immediately and the
overhead of disabling and re-enabling polling can be avoided.

fdmon-io_uring.c is unable to take advantage of this optimization
because its ->need_wait() function returns true whenever there are new
io_uring SQEs to submit:

  if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Polling will be disabled even when timeout == 0.

Extend the optimization to handle the case when need_wait() returns true
and timeout == 0.

Cc: Chao Gao <chao.gao@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 2e0a5dadc4..2439cf0feb 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -722,7 +722,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
          * up IO threads when some work becomes pending. It is essential to
          * avoid hangs or unnecessary latency.
          */
-        if (poll_set_started(ctx, &ready_list, false)) {
+        if (timeout && poll_set_started(ctx, &ready_list, false)) {
             timeout = 0;
             progress = true;
         }
-- 
2.49.0


