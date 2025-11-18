Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D192CEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6w-0008WA-Iz; Tue, 18 Nov 2025 12:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6t-0008Tb-GA
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6r-0004iR-60
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqxlvZhk+CRjiofvBYAP5KLJ5IuZhocL4ETv/I7HwW4=;
 b=hrH+b62YV+5YcvMeLwFajRl6A/x+fEImlPBmEGwoRENuuPpdzlf2GvKLBdqml+S8STOdY9
 PzAl7ffQhettnVwsbMXA4UT+ghzbhCqXZvN7Hi60vKaTWOC9aXu1hnq7hkE7TnroZ4yLQx
 /jKYUYrPUISLzDnqLv/I7L4HlLDkaIo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-sRfSrChNO0K27G4gxVXa7A-1; Tue,
 18 Nov 2025 12:03:07 -0500
X-MC-Unique: sRfSrChNO0K27G4gxVXa7A-1
X-Mimecast-MFC-AGG-ID: sRfSrChNO0K27G4gxVXa7A_1763485386
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0F411800650; Tue, 18 Nov 2025 17:03:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19091300A88D; Tue, 18 Nov 2025 17:03:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/19] block: Note on aio_co_wake use if not yet yielding
Date: Tue, 18 Nov 2025 18:02:38 +0100
Message-ID: <20251118170256.272087-2-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

aio_co_wake() is generally safe to call regardless of whether the
coroutine is already yielding or not.  If it is not yet yielding, it
will be scheduled to run when it does yield.

Caveats:
- The caller must be independent of the coroutine (to ensure the
  coroutine must be yielding if both are in the same AioContext), i.e.
  must not be the same coroutine
- The coroutine must yield at some point

Make note of this so callers can reason that their use is safe.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-2-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index f38b584ac7..6049e6a0f4 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -746,6 +746,21 @@ void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
  * aio_co_wake may be executed either in coroutine or non-coroutine
  * context.  The coroutine must not be entered by anyone else while
  * aio_co_wake() is active.
+ *
+ * If `co`'s AioContext differs from the current AioContext, this will call
+ * aio_co_schedule(), which makes this safe to use even when `co` has not
+ * yielded yet.  In such a case, it will be entered once it yields.
+ *
+ * In contrast, if `co`'s AioContext is equal to the current one, it is
+ * required for `co` to currently be yielding.  This is generally the case
+ * if the caller is not in `co` (i.e. invoked by `co`), because the only
+ * other way for the caller to be running then is for `co` to currently be
+ * yielding.
+ *
+ * Therefore, if there is no way for the caller to be invoked/entered by
+ * `co`, it is generally safe to call this regardless of whether `co` is
+ * known to already be yielding or not -- it only has to yield at some
+ * point.
  */
 void aio_co_wake(Coroutine *co);
 
-- 
2.51.1


